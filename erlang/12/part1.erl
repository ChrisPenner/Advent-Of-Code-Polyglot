-module(part1).
-export([main/0]).

main() ->
	{ok, Data} = file:read_file("input"),
	Sum = case re:run(Data, "(-?\\d+)", [global,{capture,all_but_first,list}]) of
			  {match, Found} -> lists:foldl(fun(X,Sum) -> X+Sum end, 0, lists:map(fun(Y) -> list_to_integer(lists:flatten(Y)) end, Found));
			  _				 -> 0
	end,
	io:format("Sum: ~p~n", [Sum]).
