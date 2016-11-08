input = 'input.txt' |> File.read! |> to_char_list

{map, _, _} = Enum.reduce Enum.with_index(input), {MapSet.put(%MapSet{}, {0,0}), {0,0}, {0,0} }, fn
  ({?v, idx}, {map, {sx, sy}, {rx, ry}}) when rem(idx, 2) == 0 -> { MapSet.put(map, {sx, sy - 1}), {sx, sy - 1}, {rx, ry}}
  ({?v, idx}, {map, {sx, sy}, {rx, ry}}) when rem(idx, 2) == 1 -> { MapSet.put(map, {rx, ry - 1}), {sx, sy}, {rx, ry - 1}}
  ({?>, idx}, {map, {sx, sy}, {rx, ry}}) when rem(idx, 2) == 0 -> { MapSet.put(map, {sx + 1, sy}), {sx + 1, sy}, {rx, ry}}
  ({?>, idx}, {map, {sx, sy}, {rx, ry}}) when rem(idx, 2) == 1 -> { MapSet.put(map, {rx + 1, ry}), {sx, sy}, {rx + 1, ry}}
  ({?<, idx}, {map, {sx, sy}, {rx, ry}}) when rem(idx, 2) == 0 -> { MapSet.put(map, {sx - 1, sy}), {sx - 1, sy}, {rx, ry}}
  ({?<, idx}, {map, {sx, sy}, {rx, ry}}) when rem(idx, 2) == 1 -> { MapSet.put(map, {rx - 1, ry}), {sx, sy}, {rx - 1, ry}}
  ({?^, idx}, {map, {sx, sy}, {rx, ry}}) when rem(idx, 2) == 0 -> { MapSet.put(map, {sx, sy + 1}), {sx, sy + 1}, {rx, ry}}
  ({?^, idx}, {map, {sx, sy}, {rx, ry}}) when rem(idx, 2) == 1 -> { MapSet.put(map, {rx, ry + 1}), {sx, sy}, {rx, ry + 1}}
  end
IO.puts MapSet.size map

