defmodule GPS.Parser do
#  @behaviour Plug.Parsers

#  import Plug.Conn
  use Timex

#  def parse(conn, "text", "gps", _headers, opts) do
#    IO.inspect "parsing"
#    conn
#    |> read_body(opts)
#    |> decode
#  end

#  def parse(conn, _, _, _, _) do
#    {:next, conn}
#  end

  def decode("$GPRMC," <> rmc) do
    components = String.split(rmc, ",")
    latitude = (components |> Enum.at(3) |> direction) * (components |> Enum.at(2) |> latitude)
    longitude = (components |> Enum.at(5) |> direction) * (components |> Enum.at(4) |> longitude)
    date = datetime(components |> Enum.at(8), components |> Enum.at(0))

    {:ok, %{latitude: latitude, longitude: longitude, date: date}}
  end

  def decode(_) do
    {:error, ~s{Invalid string}}
  end

#  def decode({:ok, "$GPRMC," <> rmc, conn}) do
#    components = String.split(rmc, ",")
#    latitude = (components |> Enum.at(3) |> direction) * (components |> Enum.at(2) |> latitude)
#    longitude = (components |> Enum.at(5) |> direction) * (components |> Enum.at(4) |> longitude)
#    date = datetime(components |> Enum.at(8), components |> Enum.at(0))

#    IO.inspect latitude
#    IO.inspect longitude
#    IO.inspect date

#    {:ok, %{latitude: latitude, longitude: longitude, date: date}, conn}
#  end

#  def decode({_, str, conn}) do
#    IO.inspect "NEXT!"
#    IO.inspect str
#    conn |> send_resp(
#    {:next, conn}
#  end

  @doc("Converts a NMEA latitude LLll.lll to LL + ll.lll/60 where ll.lll is in decimal hours")
  def latitude(str_lat) do
    (str_lat |> String.slice(0..1) |> String.to_integer) +
    (str_lat |> String.slice(2..-1) |> String.to_float) / 60
  end

  @doc("Converts a NMEA longitude LLLll.lll to LL + ll.lll/60 where ll.lll is in decimal hours")
  def longitude(str_long) do
    (str_long |> String.slice(0..2) |> String.to_integer) +
    (str_long |> String.slice(3..-1) |> String.to_float) / 60
  end

  @doc("Converts coordinate direction to appropriate multiplier.")
  def direction("N"), do: 1
  def direction("S"), do: -1
  def direction("E"), do: 1
  def direction("W"), do: -1

  @doc("Converts date / time format: ddMMyy / hhmmss.000")
  def datetime(
    <<day::2-bytes, month::2-bytes, year::2-bytes>>,
    <<hour::2-bytes, minute::2-bytes, second::2-bytes, ".", _ms::3-bytes>>) do
    gmt = Date.timezone("GMT")

    Date.from({{ (year |> String.to_integer) + 2000,
      month |> String.to_integer,
      day |> String.to_integer }, {
      hour |> String.to_integer,
      minute |> String.to_integer,
      second |> String.to_integer}}, gmt)
  end
end
