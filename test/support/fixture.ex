defmodule Ledger.Fixture do
  import Ledger.Factory

  alias Ledger.{Warehouse}

  def receive_from_transport(_context) do
    {:ok, receive_from_transport} = fixture(:receive_from_transport)

    [
      receive_from_transport: receive_from_transport
    ]
  end

  def fixture(resource, attrs \\ [])

  def fixture(:receive_from_transport, attrs) do
    build(:receive_from_transport, attrs) |> Warehouse.receive_from_transport()
  end
end
