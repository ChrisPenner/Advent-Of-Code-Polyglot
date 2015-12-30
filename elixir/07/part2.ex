use Bitwise

input = 'input.txt' |> File.read! |> String.split("\n") |> Enum.map &(String.split(&1," "))


defmodule Eval do
	def val(x) do
		try do
			String.to_integer(x)
		rescue
			_ in _ -> x
		end
	end

	def evaluate(map, v) do
		case map[v] do
			nil -> Map.put(map, v, v)
			x when is_integer(x) -> map
			x when is_binary(x) -> 
				map = evaluate(map, x)
				Map.put(map, v, map[x])
			{cmd, x} -> 
			  map = evaluate(map, x) 
			  Map.put(map, v, apply(:erlang, cmd, [map[x]]))
			{cmd, x, y} ->
			  map = evaluate(map, x) 
			  map = evaluate(map, y) 
			  Map.put(map, v, apply(:erlang, cmd, [map[x], map[y]]))
		end
	end
end

result = Enum.reduce input, %{}, fn
(["NOT", v1, "->", v2], acc) -> Map.put(acc, v2, {:bnot, Eval.val(v1)})
([v1, "AND", v2, "->", v3], acc) -> Map.put(acc, v3, {:band, Eval.val(v1), Eval.val(v2)})
([v1, "OR", v2, "->", v3], acc) -> Map.put(acc, v3, {:bor, Eval.val(v1), Eval.val(v2)})
([v1, "LSHIFT", v2, "->", v3], acc) -> Map.put(acc, v3, {:bsl, Eval.val(v1), Eval.val(v2)})
([v1, "RSHIFT", v2, "->", v3], acc) -> Map.put(acc, v3, {:bsr, Eval.val(v1), Eval.val(v2)})
([v1, "->", v2], acc) ->  Map.put(acc, Eval.val(v2), Eval.val(v1))
end

a =  Eval.evaluate(result, "a")["a"]
result = Map.put(result, "b", a)
IO.puts Eval.evaluate(result, "a")["a"]