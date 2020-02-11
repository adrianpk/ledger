defmodule Ledger.App do
  use Commanded.Application,
    otp_app: :ledger

  router(Ledger.Router)
end
