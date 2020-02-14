defmodule Ledger.Queue.Receiver do
  ## TODO: Make configurable using envar
  @channel "inbound"

  def wait_for_messages do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, @channel)
    AMQP.Basic.consume(channel, @channel, nil, no_ack: true)
    Agent.start_link(fn -> [] end, name: :batcher)
    _wait_for_messages()
  end

  defp push(value) do
    Agent.update(:batcher, fn list -> [value | list] end)
    flush_if_full()
  end

  defp flush do
    Agent.update(:batcher, fn _ -> [] end)
  end

  defp full? do
    Agent.get(:batcher, fn list -> length(list) > 1000 end)
  end

  defp make_key do
    rand = :crypto.strong_rand_bytes(6) |> Base.url_encode64()
    now = DateTime.utc_now() |> DateTime.to_string()
    "batch_#{now}_#{rand}.json"
  end

  defp process_messages(path, json) do
    IO.puts(path)
    IO.puts(json)
  end

  defp flush_if_full do
    if full?() do
      l = Agent.get(:batcher, fn list -> list end)
      {:ok, path} = Briefly.create()
      {:ok, json} = Poison.encode(l)
      process_messages(path, json)
      flush()
    end
  end

  defp _wait_for_messages do
    receive do
      {:basic_deliver, payload, _meta} ->
        push(payload)
        IO.puts("received a message!")
        _wait_for_messages()
    end
  end
end
