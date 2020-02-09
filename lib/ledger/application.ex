defmodule Ledger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  # use Application

  use Commanded.Application,
    otp_app: :ledger,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Ledger.EventStore
    ]

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Ledger.Repo,
      # Start the endpoint when the application starts
      LedgerWeb.Endpoint,
      # Starts a worker by calling: Ledger.Worker.start_link(arg)
      # {Ledger.Worker, arg},

      # Warehouse supervisor
      Ledger.Warehouse.Supervisor,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ledger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LedgerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
