defmodule Ledger.Warehouse.Commands.ClassifyItem do
  defstruct tracking_uuid: nil,
            operator_uuid: nil,
            pallet_uuid: nil,
            package_uuid: nil,
            length_cm: nil,
            width_cm: nil,
            height_cm: nil,
            weight_gm: nil,
            picture_front: nil,
            picture_back: nil,
            picture_left: nil,
            picture_right: nil,
            picture_top: nil,
            is_repackaged: nil,
            is_damaged: nil,
            notes: nil,
            tags: nil

  use ExConstructor

  @typedoc """
  ClassifyItem command field types.
  At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)
  """

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          operator_uuid: UUID.t() | nil,
          pallet_uuid: UUID.t() | nil,
          package_uuid: UUID.t() | nil,
          length_cm: Integer.t() | nil,
          width_cm: Integer.t() | nil,
          height_cm: Integer.t() | nil,
          weight_gm: Integer.t() | nil,
          picture_front: String.t() | nil,
          picture_back: String.t() | nil,
          picture_left: String.t() | nil,
          picture_right: String.t() | nil,
          picture_top: String.t() | nil,
          is_repackaged: Boolean.t() | nil,
          is_damaged: Boolean.t() | nil,
          notes: String.t() | nil,
          tags: String.t() | nil
        }
end
