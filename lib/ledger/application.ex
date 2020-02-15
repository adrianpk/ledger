defmodule Ledger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  # def start(_type, _args) do
  #   import Supervisor.Spec

  #   children = [
  #     supervisor(Ledger.Repo, []),
  #     supervisor(Ledger.Warehouse.Supervisor, [])
  #   ]

  #   opts = [strategy: :one_for_one, name: Ledger.Supervisor]
  #   Supervisor.start_link(children, opts)
  # end

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised
    children = [
      Ledger.App,
      # Start the Ecto repository
      Ledger.Repo,
      # Start the endpoint when the application starts
      LedgerWeb.Endpoint,
      # Starts a worker by calling: Ledger.Worker.start_link(arg)
      # {Ledger.Worker, arg},
      # Warehouse supervisor
      Ledger.Warehouse.Supervisor,
      # Publisher
      worker(Ledger.Queue.Publisher, []),
      # Listener
      worker(Ledger.Queue.Listener, [])
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
