defmodule Ledger.Warehouse.Aggregates.Tracking do
  defstruct [
    :uuid,
    :package_uuid,
    :vehicle_uuid,
    :driver_uuid,
    :warehouse_uuid,
    :gate_uuid,
    :operator_uuid,
    :notes,
    :tags
  ]

  @typedoc """
  Tracking aggregate field types.
  At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)
  """
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
  def execute(%Tracking{uuid: nil}, %ReceiveFromTransport{} = to_receive) do
    %Tracking{
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
        package_uuid: received.package.uuid,
        vehicle_uuid: received.vehicle_uuid,
        driver_uuid: received.driver_uuid,
        warehouse_uuid: received.warehouse_uuid,
        gate_uuid: received.gate_uuid,
        operator_uuid: received.operator_uuid,
        notes: received.notes,
        tags: received.tags
    }
  end
end
