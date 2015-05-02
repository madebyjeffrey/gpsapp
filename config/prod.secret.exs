use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :gpsapp, Gpsapp.Endpoint,
  secret_key_base: "8VGgzWkeMoag4FhSRaL57TiE6PDwTfN6cYOWVTCX0marTj/tDjd4QqXthJSe3yA2"

# Configure your database
config :gpsapp, Gpsapp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "gpsapp_prod"
