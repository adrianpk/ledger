defmodule Ledger.Warehouse.Commands.ReceiveFromTransport do
  defstruct tracking_uuid: nil,
            package_uuid: nil,
            vehicle_uuid: nil,
            driver_uuid: nil,
            warehouse_uuid: nil,
            gate_uuid: nil,
            operator_uuid: nil,
            notes: nil,
            tags: nil

  use ExConstructor

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          package_uuid: UUID.t() | nil,
          vehicle_uuid: UUID.t() | nil,
          driver_uuid: UUID.t() | nil,
          warehouse_uuid: UUID.t() | nil,
          gate_uuid: UUID.t() | nil,
          operator_uuid: UUID.t() | nil,
          notes: String.t() | nil,
          tags: String.t() | nil
        }

  alias Ledger.Warehouse.Commands.ReceiveFromTransport

  @doc """
  Assign a unique identity for the user
  """
  def assign_uuid(%ReceiveFromTransport{} = receive_from_transport, uuid) do
    %ReceiveFromTransport{receive_from_transport | tracking_uuid: uuid}
  end
end
