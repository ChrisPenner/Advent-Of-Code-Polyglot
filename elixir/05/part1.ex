input = 'input.txt' |> File.read! |> String.split "\n"

defmodule PartI do
	@double for n <- ?a..?z, do: to_string [n,n] 
	@forbidden ["ab", "cd", "pq", "xy"]

	def contains_double?(text) do
		!!Enum.find @double, false, &(String.contains?(text, &1))
	end

	def contains_forbidden?(text) do
		!!Enum.find @forbidden, false, &(String.contains?(text, &1))
	end

	def contains_3vowels?(text) do
		length(for n <- to_char_list(text), n in [?a, ?e, ?i, ?o, ?u], do: n) > 2
	end

	def nice?(text) do
		contains_double?(text) && !contains_forbidden?(text) && contains_3vowels?(text)
	end
end

IO.puts Enum.reduce(input, 0, &( if PartI.nice?(&1), do: &2 + 1, else: &2))