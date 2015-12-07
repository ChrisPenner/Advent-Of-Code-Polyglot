-module(part1).
-export([main/0]).
-import(lists, [partition/2]).

main() ->
	In = io:get_line("") -- "\n",
	{Left,Right} = partition(fun(X) -> X == $( end, In),
	io:format("~p~n", [length(Left) - length(Right)]).
