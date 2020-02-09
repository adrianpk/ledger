defmodule Ledger.Router do
  use Commanded.Commands.Router
  alias Ledger.Warehouse.Commands.ReceiveFromTransport
  alias Ledger.Warehouse.Aggregates.Tracking

  dispatch([ReceiveFromTransport], to: Tracking, identity: :tracking_uuid)
end
