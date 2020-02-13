defmodule Ledger.Warehouse.Events.RequestedShipping do
  @derive Jason.Encoder

  defstruct tracking_uuid: nil,
            location: nil,
            operator_uuid: nil,
            addressee: nil,
            shipping_address: nil,
            notes: nil,
            tags: nil,
            status: nil

  @typedoc """
  Requested shipping command field types.
  Surely a more elaborate system can be expected to set the destination address but
  they are beyond the end of this proof of concept.
  """

  @type t :: %__MODULE__{
          tracking_uuid: UUID.t(),
          location: String.t() | nil,
          operator_uuid: UUID.t() | nil,
          addressee: String.t() | nil,
          shipping_address: String.t() | nil,
          notes: String.t() | nil,
          tags: String.t() | nil,
          status: String.t() | nil
        }
end
