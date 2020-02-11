defmodule Ledger.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:uuid, Ecto.UUID, autogenerate: false}
      @foreign_key_type Ecto.UUID
      @derive {Phoenix.Param, key: :uuid}
    end
  end
end
