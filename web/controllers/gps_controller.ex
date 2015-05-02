defmodule Gpsapp.GPSController do
    use Gpsapp.Web, :controller
	
	require Logger
	
	import Plug.Conn, only: [send_resp: 3]
#	use GPS.Parse
	
	plug :action
	
	def add(conn, _params) do
		Logger.debug "Add"
		
		# conn |> send_resp(200, "ok")
		conn |> text("ok")
	end
end