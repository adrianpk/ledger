defmodule Ledger.Warehouse.Commands.DispatchForShipping do
  defstruct tracking_uuid: nil,
            gate_uuid: nil,
            operator_uuid: nil,
            notes: nil,
            tags: nil

  use ExConstructor

  @typedoc """
  DispatchForShipping command field types.
  At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)
  """

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          gate_uuid: UUID.t() | nil,
          operator_uuid: UUID.t() | nil,
          notes: String.t() | nil,
          tags: String.t() | nil
        }

  alias Ledger.Warehouse.Commands.ReceiveFromTransport
end
