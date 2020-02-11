defmodule Ledger.Warehouse.Events.ReceivedFromTransport do
  @derive Jason.Encoder

  defstruct tracking_uuid: nil,
            package_uuid: nil,
            vehicle_uuid: nil,
            driver_uuid: nil,
            warehouse_uuid: nil,
            gate_uuid: nil,
            operator_uuid: nil,
            notes: nil,
            tags: nil

  @typedoc """
  ReceiveFromTransport command field types.
  At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)
  """

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          package_uuid: UUID.t(),
          vehicle_uuid: UUID.t() | nil,
          driver_uuid: UUID.t() | nil,
          warehouse_uuid: UUID.t() | nil,
          gate_uuid: UUID.t() | nil,
          operator_uuid: UUID.t() | nil,
          notes: String.t() | nil,
          tags: String.t() | nil
        }
end
