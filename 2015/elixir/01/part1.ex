input = 'input.txt' |> File.read! |> to_char_list
IO.puts Enum.reduce(input, 0, fn
(?(, acc) -> acc + 1
(?), acc) -> acc - 1
end)
