defmodule Ledger.Queue.Worker do
  use GenServer

  ## Client API

  ## TODO: Set using env vars.
  @channel "outbund"

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: :publisher)
  end

  def publish(message) do
    IO.puts("Handling cast")
    GenServer.cast(:publisher, {:publish, message})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Queue.declare(channel, @channel)
    {:ok, %{channel: channel, connection: connection}}
  end

  def handle_cast({:publish, message}, state) do
    AMQP.Basic.publish(state.channel, "", @channel, message)
    {:noreply, state}
  end

  def terminate(_reason, state) do
    AMQP.Connection.close(state.connection)
  end
end
