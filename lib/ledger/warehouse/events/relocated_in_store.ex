defmodule Ledger.Warehouse.Events.RelocatedInStore do
  @derive Jason.Encoder

  defstruct tracking_uuid: nil,
            location: nil,
            operator_uuid: nil,
            shelf_color: nil,
            rack: nil,
            bay: nil,
            level: nil,
            position: nil,
            notes: nil,
            tags: nil,
            status: nil

  @typedoc """
  RelocatedInStore command field types.
  At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)
  """

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          location: String.t() | nil,
          operator_uuid: UUID.t() | nil,
          shelf_color: String.t() | nil,
          rack: String.t() | nil,
          bay: String.t() | nil,
          level: String.t() | nil,
          position: String.t() | nil,
          notes: String.t() | nil,
          tags: String.t() | nil,
          status: String.t() | nil
        }
end
