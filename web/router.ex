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

	# this isn't really what we want to do - check mime type instead
	pipeline :gps do
		plug :accepts, [ "gps" ]
		plug Plug.Parsers, parsers: [ :gps ]
		# plug :content_type, ["text/gps"]
	end

	scope "/", Gpsapp do
		pipe_through :browser # Use the default browser stack

		get "/", PageController, :index
		resources "/users", UserController	
		get "/hello", HelloController, :index
		get "/hello/:messenger", HelloController, :show
	end
	
	scope "/", Gpsapp do
		pipe_through :gps
		
		post "/gps", GPSController, :add
	end

# Other scopes may use custom stacks.
# scope "/api", Gpsapp do
#   pipe_through :api
# end
end
