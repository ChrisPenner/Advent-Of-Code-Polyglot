import String, only: [split: 2, to_integer: 1]

input = 'input.txt' |> File.read! |> String.split("\n") |> Enum.map &(String.split(&1," "))

turn = fn (matrix, [sx, sy], [ex, ey], val) ->
	for x <- sx..ex, y <- sy..ey, into: matrix, do: { {x,y}, val }
end

toggle = fn (matrix, [sx, sy], [ex, ey]) ->
	for x <- sx..ex, y <- sy..ey, into: matrix, do: { {x,y}, !Map.get(matrix, {x,y}) }
end

coord = fn (coord) ->
		[x, y] = split(coord, ",")
		[to_integer(x), to_integer(y)]
end

matrix = for x <- 0..999, y <- 0..999, into: %{}, do: {{x, y}, false}
matrix = Enum.reduce input, matrix, fn
(["toggle", start_pos, _, end_pos], acc) -> toggle.(acc, coord.(start_pos), coord.(end_pos))
(["turn", "on", start_pos, _, end_pos], acc) -> turn.(acc, coord.(start_pos), coord.(end_pos), true)
(["turn", "off", start_pos, _, end_pos], acc) -> turn.(acc, coord.(start_pos), coord.(end_pos), false)
end

IO.puts length(Enum.filter(Map.values(matrix), &(&1 == true)))
