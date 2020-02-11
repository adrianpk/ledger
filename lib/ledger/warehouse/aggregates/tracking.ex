defmodule Ledger.Warehouse.Aggregates.Tracking do
  defstruct uuid: nil,
            package_uuid: nil,
            vehicle_uuid: nil,
            driver_uuid: nil,
            warehouse_uuid: nil,
            gate_uuid: nil,
            operator_uuid: nil,
            notes: nil,
            tags: nil

  @type t :: %__MODULE__{
          uuid: UUID.t(),
          package_uuid: UUID.t() | nil,
          vehicle_uuid: UUID.t() | nil,
          driver_uuid: UUID.t() | nil,
          warehouse_uuid: UUID.t() | nil,
          gate_uuid: UUID.t() | nil,
          operator_uuid: UUID.t() | nil,
          notes: UUID.t() | nil
        }

  alias Ledger.Warehouse.Commands.ReceiveFromTransport
  alias Ledger.Warehouse.Events.ReceivedFromTransport
  alias Ledger.Warehouse.Aggregates.Tracking

  @doc """
  Receive from transport.
  """
  # def execute(%Tracking{uuid: nil}, %ReceiveFromTransport{} = to_receive) do
  def execute(%Tracking{uuid: nil}, %ReceiveFromTransport{} = to_receive) do
    %ReceivedFromTransport{
      tracking_uuid: to_receive.tracking_uuid,
      package_uuid: to_receive.package_uuid,
      vehicle_uuid: to_receive.vehicle_uuid,
      driver_uuid: to_receive.driver_uuid,
      warehouse_uuid: to_receive.warehouse_uuid,
      gate_uuid: to_receive.gate_uuid,
      operator_uuid: to_receive.operator_uuid,
      notes: to_receive.notes,
      tags: to_receive.tags
    }
  end

  # state mutators
  def apply(%Tracking{} = tracking, %ReceivedFromTransport{} = received) do
    %Tracking{
      tracking
      | uuid: received.tracking_uuid,
        package_uuid: received.package_uuid,
        vehicle_uuid: received.vehicle_uuid,
        driver_uuid: received.driver_uuid,
        warehouse_uuid: received.warehouse_uuid,
        gate_uuid: received.gate_uuid,
        operator_uuid: received.operator_uuid,
        notes: received.notes,
        tags: received.tags
    }
  end

  @doc """
  Assign a unique identity for the user
  """
  def assign_uuid(%ReceiveFromTransport{} = receive_from_transport, uuid) do
    %ReceiveFromTransport{receive_from_transport | tracking_uuid: uuid}
  end
end
