{paths, cities} = 'input.txt' 
|> File.read! 
|> String.split("\n") 
|> Enum.reduce {%{}, []}, fn (string, {paths, cities}) ->
  [x, "to", y,"=", val] = String.split(string," ")
  paths = Map.put(paths, {x, y}, String.to_integer(val))
  paths = Map.put(paths, {y, x}, String.to_integer(val))
  cities = Enum.uniq [x, y | cities]
  {paths, cities}
end

defmodule M do
  def permutations([]), do: [[]]
  def permutations(list) do
    for x <- list, y <- permutations(list -- [x]), do: [x|y]
  end

  def cost(_, []), do: 0
  def cost(_, [_]), do: 0
  def cost(paths, [x, y | t]) do
    val = if paths[{x,y}] == nil do
      999999999
  	else
  	 paths[{x,y}]
  	end
  	val + cost(paths, [y|t])
  end
end

IO.puts Enum.min Enum.map(M.permutations(cities), &(M.cost(paths, &1)))
