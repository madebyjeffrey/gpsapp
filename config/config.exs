# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :gpsapp, Gpsapp.Endpoint,
  url: [host: "localhost"],
  root: Path.expand("..", __DIR__),
  secret_key_base: "F82UWeJiAzml0mk1XfGKD1YGuyfKKii5v2vM3fL/IyazqJr/hoVkFfLsdVSooeYm",
  debug_errors: false,
  pubsub: [name: Gpsapp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  # adds mime types
config :plug, :mimes, %{
	"text/gps" => ["gps"],
	"text/plain" => ["text"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
