defmodule Ledger.Warehouse do
  @moduledoc """
  Bounded context for Warehouse system.
  """
  alias Ledger.Warehouse.Commands.ReceiveFromTransport
  alias Ledger.Warehouse.Projections.TrackingStatus
  alias Ledger.App
  alias Ledger.Repo

  @doc """
  Receive from transport.
  """
  def receive_from_transport(attrs \\ %{}) do
    uuid = UUID.uuid4()

    receive_from_transport =
      attrs
      |> ReceiveFromTransport.new()
      |> ReceiveFromTransport.assign_uuid(uuid)

    with :ok <- App.dispatch(receive_from_transport, consistency: :strong) do
      get(TrackingStatus, uuid)
    else
      reply -> reply
    end
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
