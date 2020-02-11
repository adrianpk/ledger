use Mix.Config

# Configure your database
config :ledger, Ledger.Repo,
  username: "ledger",
  password: "ledger",
  database: "ledger_readstore_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the event store database
config :ledger, Ledger.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  # types: EventStore.PostgresTypes,
  username: "ledger",
  password: "ledger",
  database: "ledger_eventstore_test",
  hostname: "localhost",
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_timeout: 120_000,
  timeout: 120_000,
  ownership_timeout: 120_000

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ledger, LedgerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
