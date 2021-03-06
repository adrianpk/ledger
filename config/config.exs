# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# General application configuration
config :ledger,
  ecto_repos: [Ledger.Repo],
  event_stores: [Ledger.EventStore]

config :ledger, Ledger.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Ledger.EventStore
  ],
  pub_sub: :local,
  registry: :local

# Configures the endpoint
config :ledger, LedgerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A47gw+upf2bjwCokjU9jqZNFDqqeBx1nPn8qI1jJ5jyQqhw6LyGPUrRJpJqH+x9R",
  render_errors: [view: LedgerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Ledger.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Event store configuration
config :ledger, event_stores: [Ledger.EventStore]

# Projections
config :commanded_ecto_projections, repo: Ledger.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
