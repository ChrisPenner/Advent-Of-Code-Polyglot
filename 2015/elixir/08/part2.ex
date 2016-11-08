input = 'input.txt' |> File.read! |> String.split("\n")

defmodule M do

  def encode([]), do: []
  def encode([?" | t]), do: [?\\, ?" | encode(t)]
  def encode([?\\ | t]), do: [?\\, ?\\ | encode(t)]
  def encode([ch | t]), do: [ch | encode(t)]

  def esc_length(char_list), do: esc_length(char_list, -2)
  def esc_length([], acc), do: acc
  def esc_length([?\\ , ?\\ | t], acc), do: esc_length(t, acc + 1)
  def esc_length([?\\ , ?x , _ , _ | t], acc), do: esc_length(t, acc + 1)
  def esc_length([?\\ , ?" | t], acc), do: esc_length(t, acc + 1)
  def esc_length([_ | t], acc), do: esc_length(t, acc + 1)
end

IO.puts Enum.reduce input, 0, fn 
(string, acc) ->
	encoded = M.encode(String.to_char_list(string))
	acc + length(encoded) - M.esc_length(encoded)
end