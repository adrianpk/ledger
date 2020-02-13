defmodule Ledger.Warehouse.Commands.RequestShipping do
  defstruct tracking_uuid: nil,
            operator_uuid: nil,
            addressee: nil,
            shipping_address: nil,
            notes: nil,
            tags: nil

  use ExConstructor

  @typedoc """
  RequestShipment command field types.
  Surely a more elaborate system can be expected to set the destination address but
  they are beyond the end of this proof of concept.
  """

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          operator_uuid: UUID.t() | nil,
          addressee: String.t(),
          shipping_address: String.t(),
          notes: String.t() | nil,
          tags: String.t() | nil
        }
end
