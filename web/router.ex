defmodule Gpsapp.Router do
  use Phoenix.Router
  # import GPSApp.Plugs


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :gps do
    plug :accepts, [ "text" ]
#    plug Plug.Parsers, parsers: [ :gps ]
  end

#  scope "/", Gpsapp do
#    pipe_through :browser # Use the default browser stack

#    get "/", PageController, :index
#    resources "/users", UserController
#    get "/hello", HelloController, :index
#    get "/hello/:messenger", HelloController, :show
#  end

  scope "/gps", Gpsapp do
    pipe_through :gps

    post "/", GPSController, :add
  end
end
