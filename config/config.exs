# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :helsinki,
  namespace: AccountingSystem,
  ecto_repos: [AccountingSystem.Repo]

config :helsinki_web,
  namespace: AccountingSystemWeb,
  ecto_repos: [AccountingSystem.Repo],
  generators: [context_app: :helsinki]

# Configures the endpoint
config :helsinki_web, AccountingSystemWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gG2dHVcUUM7Z3w+nsr7cqFm0opDUvngkoM52npJiwzCFnCmkFPbVhIzwZO8y1sdO",
  render_errors: [view: AccountingSystemWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AccountingSystemWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
