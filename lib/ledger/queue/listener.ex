defmodule Ledger.Queue.Listener do
  ## TODO: Make configurable using envar
  @channel "inbound"
  # No buffer: Messages are processed as they enter.
  @buffer_size 0

  require Logger

  alias Ledger.Warehouse
  alias Ledger.Queue.Listener
  alias Ledger.Queue.Message

  def start_link do
    Listener.listen()
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
    case Poison.decode(msg, as: %Message{}) do
      {:ok, %{} = msg} ->
        cmd =
          Recase.to_snake(msg.command)
          |> String.to_atom()

        args = to_atom_keys(msg.arguments)

        # IO.inspect(cmd)
        # IO.inspect(args)

        apply(Warehouse, cmd, [args])

      {:error, reason} ->
        Logger.error("Cannot decode message: " <> reason)
    end
  end

  # TODO: compare string keys with values in a dictionary
  # of allowed commands to avoid memory leaks
  # Ref.: https://engineering.klarna.com/monitoring-erlang-atoms-c1d6a741328e
  defp to_atom_keys(%{} = map) do
    for {key, val} <- map, into: %{} do
      cond do
        is_atom(key) -> {key, val}
        true -> {String.to_atom(key), val}
      end
    end
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
