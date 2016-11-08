input = 'input.txt' |> File.read! |> to_char_list

{ -1, idx } = Enum.reduce_while(input, {0, 0}, fn
(?(, {floor, idx}) ->
	{:cont, {floor + 1, idx + 1}}
(?), {floor, idx}) -> 
	tag = if (floor - 1) == -1, do: :halt, else: :cont 
	{tag, { floor - 1, idx + 1}}
end)

IO.puts idx
