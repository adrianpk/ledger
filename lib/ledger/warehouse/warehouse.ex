defmodule Ledger.Warehouse do
  @moduledoc """
  Bounded context for Warehouse system.
  """
  alias Ledger.Warehouse.Commands.ReceiveFromTransport
  alias Ledger.Router

  @doc """
  Receive from transport.
  """
  def receive_from_transport(attrs \\ %{}) do
    attrs
    |> assign_uuid(:tracking_uuid)
    |> ReceiveFromTransport.new()
    |> Router.dispatch()
  end

  # generate a unique identity
  defp assign_uuid(attrs, identity), do: Map.put(attrs, identity, UUID.uuid4())
end
