# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :vocial2,
  ecto_repos: [Vocial2.Repo]

# Configures the endpoint
config :vocial2, Vocial2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LShGOoINtaVrx+6wL47IJTQ1v4u1C4USUL+yE4vbB7OEzy5UMRpmW7uhNk3VCM/E",
  render_errors: [view: Vocial2Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Vocial2.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
