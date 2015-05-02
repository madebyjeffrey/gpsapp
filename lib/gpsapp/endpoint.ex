defmodule Gpsapp.Endpoint do
  use Phoenix.Endpoint, otp_app: :gpsapp

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :gpsapp,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_gpsapp_key",
    signing_salt: "8BQQoj2B",
    encryption_salt: "6+aYGH6v"

  plug :router, Gpsapp.Router
end
