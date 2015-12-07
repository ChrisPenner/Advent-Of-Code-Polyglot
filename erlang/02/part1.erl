-module(part1).
-export([main/0]).

main() ->
	{ok, File} = file:open("input", [read]),
	Lines = read(File),
	file:close(File),
	Sides = [{L*W,W*H,H*L} || {L,W,H} <- Lines],
	Sum = sum_sides(Sides, 0),
	io:format("~p~n", [Sum]).

read(File) ->
	case file:read_line(File) of
		{ok, Data} -> 
			[list_to_tuple(lists:map(fun(X) -> 
				list_to_integer(X) end, 
				re:split(Data -- "\n", "[x]", 
						 [{return,list}]))) | read(File)];
		eof 	   -> []
	end.

sum_sides([], Acc) ->
	Acc;
sum_sides([H|T], Acc) ->
	Min = lists:min(tuple_to_list(H)),
	sum_sides(T, Acc + Min + lists:foldl(fun(X, Prod) -> (2*X) + Prod end, 0, tuple_to_list(H))).
