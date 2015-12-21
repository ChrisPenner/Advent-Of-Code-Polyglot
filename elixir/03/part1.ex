input = 'input.txt' |> File.read! |> to_char_list

{map, _} = Enum.reduce input, {MapSet.put(%MapSet{}, {0,0}), {0,0} }, fn
  (?v, {map, {x, y}}) -> { MapSet.put(map, {x, y - 1}), {x, y - 1}}
  (?>, {map, {x, y}}) -> { MapSet.put(map, {x + 1, y}), {x + 1, y}}
  (?<, {map, {x, y}}) -> { MapSet.put(map, {x - 1, y}), {x - 1, y}}
  (?^, {map, {x, y}}) -> { MapSet.put(map, {x, y + 1}), {x, y + 1}}
  end
IO.puts MapSet.size map