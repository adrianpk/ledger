defmodule Ledger.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Ledger.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Ledger.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ledger.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Ledger.Repo, {:shared, self()})
    end

    Application.stop(:ledger)
    Application.stop(:commanded)
    Application.stop(:eventstore)
    reset_eventstore()
    reset_readstore()
    Application.ensure_all_started(:ledger)

    :ok
  end

  defp reset_eventstore do
    {:ok, conn} =
      EventStore.configuration()
      |> EventStore.Config.parse()
      |> Postgrex.start_link()

    EventStore.Storage.Initializer.reset!(conn)
  end

  defp reset_readstore do
    readstore_config = Application.get_env(:conduit, Conduit.Repo)
    {:ok, conn} = Postgrex.start_link(readstore_config)
    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
    warehouse_tracking_statuses,
    projection_versions
    RESTART IDENTITY;
    """
  end

  @doc """
  A helper that transforms changeset errors into a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
