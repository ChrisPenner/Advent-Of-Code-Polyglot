input = 'input.txt' |> File.read! |> String.split "\n"

ribbon = fn(l, w, h) ->
  	areas = Enum.sort([l, w, h])
  	2*(hd(areas) + hd(tl(areas))) + l*w*h
end

IO.puts Enum.reduce input, 0, fn
  (dimensions, acc) ->
    [l, w, h] = String.split(dimensions, "x")
    acc + ribbon.(String.to_integer(l), String.to_integer(w), String.to_integer(h))
  end 


