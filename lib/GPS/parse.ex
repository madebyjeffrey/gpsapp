defmodule GPS.Parse do
    use Timex
    
    def test do
        parse("$GPRMC,033449.000,A,4218.5275,N,08303.8435,W,0.52,239.12,260415,,,A*75")
    end
    
    # Example input: "$GPRMC,033449.000,A,4218.5275,N,08303.8435,W,0.52,239.12,260415,,,A*75"
    @doc("Parses a NEMA GPRMC string to get latitude and longitude")
    def parse("$GPRMC," <> string) do
        components = String.split(string, ",")        
        latitude = (components |> Enum.at(3) |> direction) * (components |> Enum.at(2) |> latitude)
        longitude = (components |> Enum.at(5) |> direction) * (components |> Enum.at(4) |> longitude)
        date = datetime(components |> Enum.at(8), components |> Enum.at(0))
        IO.puts(latitude)
        IO.puts(longitude)
        IO.puts(DateFormat.format!(date, "{RFC1123}"))
    end
        
    @doc("Converts a NEMA latitude LLll.lll to LL + ll.lll/60 where ll.lll is in decimal hours")
    def latitude(str_lat) do
        (str_lat |> String.slice(0..1) |> String.to_integer) +
        (str_lat |> String.slice(2..-1) |> String.to_float) / 60        
    end 
    
    @doc("Converts a NEMA longitude LLLll.lll to LL + ll.lll/60 where ll.lll is in decimal hours")
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
    def datetime(<<day::2-bytes, month::2-bytes, year::2-bytes>>,
        <<hour::2-bytes, minute::2-bytes, second::2-bytes, ".", ms::3-bytes>>) do
        gmt = Date.timezone("GMT")
        Date.from({{ (year |> String.to_integer) + 2000, 
            month |> String.to_integer,
            day |> String.to_integer }, {
            hour |> String.to_integer, 
            minute |> String.to_integer,
            second |> String.to_integer}}, gmt)
    end
end