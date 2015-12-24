input = 'input.txt' |> File.read! |> String.split "\n"

defmodule PartII do
	@double for n <- ?a..?z, x <- ?a..?z, do: to_string [n,x]
	@triple for n <- ?a..?z, x <- ?a..?z, do: to_string [n,x,n]
	
	def contains_two_double?(text) do
		!!Enum.find @double, false, &(length(String.split(text, &1)) > 2)
	end
	
	def contains_triplet?(text) do
		!!Enum.find @triple, false, &(String.contains?(text, &1))
	end
	
	def nice?(text) do
		contains_two_double?(text) && contains_triplet?(text)
	end
end

IO.puts Enum.reduce(input, 0, &( if PartII.nice?(to_string(&1)), do: &2 + 1, else: &2))