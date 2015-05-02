defmodule GPSApp.Plugs do
	import Plug.Conn
	
	require Logger
	
	@spec content_type(Plug.Conn.t, binary) :: Plug.Conn.t | no_return
	def content_type(conn, type) do
		Logger.error("hello")
		if type in get_req_header(conn, "Content-Type") do
			Logger.info "Has right content type"
			conn
		else
			Logger.info "Content-Type #{inspect get_req_header(conn, "Content-Type")} in plug :content_type, " <>
						"expected #{inspect type}"
			conn |> send_resp(415, "Incorrect content type.") |> halt
		end
	end
end