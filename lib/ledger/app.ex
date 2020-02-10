defmodule Ledger.App do
  use Commanded.Application,
    otp_app: :ledger,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Ledger.EventStore
    ]


  router Ledger.Router
end
