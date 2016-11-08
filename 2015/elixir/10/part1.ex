input = 'input.txt' |> File.read! |> to_char_list

defmodule M do
  def next([x|t]), do: Enum.reverse next(t, x, 1, [])
  def next([], _, 0, result), do: result
  def next([], digit, count, result), do: [digit, ?0 + count | result]
  def next([x|t], digit, count, result) do
  	if x == digit do
  		next(t, digit, count + 1, result)
  	else
  		next(t, x, 1, [digit, ?0 + count | result])
  	end
  end

  def lookAndSay(char_list, 0), do: char_list 
  def lookAndSay(char_list, count), do: lookAndSay(next(char_list), count - 1)
end

IO.inspect length(M.lookAndSay(input, 40))
