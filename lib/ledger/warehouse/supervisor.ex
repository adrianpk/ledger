defmodule Warehouse.Supervisor do
  use Supervisor
  alias Ledger.Warehouse

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init(
      [
        Warehouse.Projectors.TrackingStatus
      ],
      strategy: :one_for_one
    )
  end
end
