# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :equilan,
  ecto_repos: [Equilan.Repo]

# Configures the endpoint
config :equilan, EquilanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: EquilanWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Equilan.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Handle mime type vnd.api+json to be json-api compliant
config :phoenix, :format_encoders, 
  "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Equilan",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET") || "NMVzgIGdopkw+mbuqx/eL7usQCogrUza3CIO5ijX/d/S1n5oj4c/9bLBVOX+OyDB",
  serializer: Equilan.GuardianSerializer