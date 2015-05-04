defmodule Gpsapp.GPSController do
	use Gpsapp.Web, :controller
	use Timex

	require Logger
	import Plug.Conn

	# import Plug.Conn, only: [send_resp: 3]
#	use GPS.Parse

	plug :action

	def add(conn, _params) do
	  {:ok, body, conn} = (conn |> read_body)

	  case  body |> GPS.Parser.decode do
	    {:ok, %{longitude: longitude,
	            latitude: latitude,
	            date: date}} -> conn |> send_resp(200, "ok")
	    {:error, msg} -> conn |> send_resp(400, msg)
    end
	end
end
