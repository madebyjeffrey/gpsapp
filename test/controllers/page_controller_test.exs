defmodule Gpsapp.PageControllerTest do
  use Gpsapp.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert conn.resp_body =~ "Welcome to Phoenix!"
  end
end
