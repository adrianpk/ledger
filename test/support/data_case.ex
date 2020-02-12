defmodule Ledger.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Ledger.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Ledger.Factory
      import Ledger.Fixture
      import Ledger.DataCase
    end
  end

  setup tags do
    Ledger.Store.reset!()
    :ok
  end

  # setup tags do
  #   :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ledger.Repo)

  #   unless tags[:async] do
  #     Ecto.Adapters.SQL.Sandbox.mode(Ledger.Repo, {:shared, self()})
  #   end

  #   # {:ok, conn: Phoenix.ConnTest.build_conn()}
  #   :ok
  # end
end
