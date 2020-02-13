defmodule Ledger.Warehouse.Events.DispatchedForShipping do
  @derive Jason.Encoder

  defstruct tracking_uuid: nil,
            location: nil,
            gate_uuid: nil,
            operator_uuid: nil,
            notes: nil,
            tags: nil,
            status: nil

  @typedoc """
  DispatchedForshipping command field types.
  At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)
  """

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          location: String.t() | nil,
          gate_uuid: UUID.t() | nil,
          operator_uuid: UUID.t() | nil,
          notes: String.t() | nil,
          tags: String.t() | nil,
          status: String.t() | nil
        }
end
