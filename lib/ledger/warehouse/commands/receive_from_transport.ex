defmodule Ledger.Warehouse.Commands.ReceiveFromTransport do
  defstruct [
    :tracking_uuid,
    :package_uuid,
    :vehicle_uuid,
    :driver_uuid,
    :warehouse_uuid,
    :gate_uuid,
    :operator_uuid,
    :notes,
    :tags
  ]

  use ExConstructor

  @typedoc """
  ReceiveFromTransport command field types.
  At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)
  """
  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          package_uuid: UUID.t() | nil,
          vehicle_uuid: UUID.t() | nil,
          driver_uuid: UUID.t() | nil,
          warehouse_uuid: UUID.t() | nil,
          gate_uuid: UUID.t() | nil,
          operator_uuid: UUID.t() | nil,
          notes: UUID.t() | nil
        }
end
