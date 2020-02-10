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

  setup do
    Ledger.Storage.reset!()
    :ok
  end
end
