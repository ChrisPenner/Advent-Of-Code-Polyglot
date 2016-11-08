input = 'input.txt' |> File.read! |> String.split "\n"
area = fn(l, w, h) ->
	  extra = l*w |> min w*h |> min h*l
	  2*(l*w + w*h + h*l) + extra
end

IO.puts Enum.reduce input, 0, fn
  (dimensions, acc) ->
    [l, w, h] = String.split(dimensions, "x")
    acc + area.(String.to_integer(l), String.to_integer(w), String.to_integer(h))
  end 
