defmodule Ledger.Warehouse.Commands.ReceiveFromTransport do
  defstruct tracking_uuid: nil,
            vehicle_uuid: nil,
            driver_uuid: nil,
            pallet_ext_id: nil,
            package_ext_id: nil,
            warehouse_uuid: nil,
            gate_uuid: nil,
            operator_uuid: nil,
            notes: nil,
            tags: nil

  use ExConstructor

  @typedoc """
  ReceiveFromTransport command field types.
  At the moment I asume that the loading process of vehicle, driver, gate, etc is automated through fixed credentials, sensor or terminal signatures (NFC, QR codes, biometric data, etc.)
  """

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          vehicle_uuid: UUID.t() | nil,
          driver_uuid: UUID.t() | nil,
          pallet_ext_id: String.t() | nil,
          package_ext_id: String.t() | nil,
          warehouse_uuid: UUID.t() | nil,
          gate_uuid: UUID.t() | nil,
          operator_uuid: UUID.t() | nil,
          notes: String.t() | nil,
          tags: String.t() | nil
        }

  alias Ledger.Warehouse.Commands.ReceiveFromTransport

  @doc """
  Assign a unique identity for the resource
  """
  def assign_uuid(%ReceiveFromTransport{} = receive_from_transport, uuid) do
    %ReceiveFromTransport{receive_from_transport | tracking_uuid: uuid}
  end
end
