-module(part2).
-export([main/0]).

main() ->
	{ok, File} = file:open("input", [read]),
	Lines = read(File),
	file:close(File),
	Sum = sum_sides(Lines, 0),
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
	Max = lists:max(tuple_to_list(H)),
	Rest = tuple_to_list(H) -- [Max],
	Sum = lists:foldl(fun(X, Y) -> X+X + Y end, 0, Rest),
	sum_sides(T, Acc + Sum + lists:foldl(fun(X, Prod) -> X * Prod end, 1, tuple_to_list(H))).
