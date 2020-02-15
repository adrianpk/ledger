defmodule Ledger.Queue.Receiver do
  ## TODO: Make configurable using envar
  @channel "inbound"
  # No buffer: Messages are processed as they enter.
  @buffer_size 0

  alias Ledger.Queue.Receiver

  def start_link do
    Receiver.listen()
  end

  def listen do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, @channel)
    AMQP.Basic.consume(channel, @channel, nil, no_ack: true)
    Agent.start_link(fn -> [] end, name: :batcher)
    _listen()
  end

  defp process_message(msg) do
    # Dispatch using Ledger.Router
    IO.inspect(msg)
  end

  defp push(value) do
    Agent.update(:batcher, fn list -> [value | list] end)
    process_if_full()
  end

  defp clear do
    Agent.update(:batcher, fn _ -> [] end)
  end

  defp full? do
    Agent.get(:batcher, fn list -> length(list) > @buffer_size end)
  end

  defp process_if_full do
    if full?() do
      msg = Agent.get(:batcher, fn list -> list end)
      process_message(msg)
      clear()
    end
  end

  defp _listen do
    receive do
      {:basic_deliver, payload, _meta} ->
        push(payload)
        IO.puts("Message received")
        _listen()
    end
  end
end
