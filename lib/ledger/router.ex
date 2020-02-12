defmodule Ledger.Router do
  use Commanded.Commands.Router

  alias Ledger.Warehouse.Commands.{
    ReceiveFromTransport,
    ClassifyItem
  }

  alias Ledger.Warehouse.Commands.{
    ReceiveFromTransport,
    ClassifyItem,
    }
  alias Ledger.Warehouse.Aggregates.Tracking

  # dispatch [
  #   ReceiveFromTransport
  # ], to: Tracking

  dispatch(
    [
      ReceiveFromTransport,
      ClassifyItem
    ],
    to: Tracking,
    identity: :tracking_uuid,
    # identity_prefix: "tracking-",
    consistency: :strong
  )
end
