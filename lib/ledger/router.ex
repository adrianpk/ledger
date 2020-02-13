defmodule Ledger.Router do
  use Commanded.Commands.Router

  alias Ledger.Warehouse.Commands.{
    ReceiveFromTransport,
    ClassifyItem,
    RelocateInStore,
    RequestShipping,
    DispatchForShipping
  }

  import Ledger.Warehouse.Aggregates.Tracking
  alias Ledger.Warehouse.Aggregates.Tracking

  dispatch(
    [
      ReceiveFromTransport,
      ClassifyItem,
      RelocateInStore,
      RequestShipping,
      DispatchForShipping,
    ],
    to: Tracking,
    identity: :tracking_uuid,
    # identity_prefix: "tracking-",
    consistency: :strong
  )
end
