-module(part2).
-export([main/0]).

main() ->
	In = gather_data(),
	NoRed = filter_red(In),
	Sum = lists:foldl(fun(X, Sum) -> X+Sum end, 0, NoRed),
	io:format("Sum: ~p~n", [Sum]).

gather_data() ->
	{ok, Data} = file:read_file("input"),
	Data.

%% Thanks to /u/askalski on reddit for showing off this regex.
%% Without him I might actually have had to learn how to install a JSON library.
filter_red(In) ->
	NoRed = re:replace(In, "{(\\[(\\[(?2)*]|{(?2)*}|[^][}{])*]|{(?2)*}|[^][}{])*red(?1)*}", "", [global,{return,list}]),
	case re:run(NoRed, "(-?\\d+)", [global,{capture,all_but_first,list}]) of
		{match, Found} -> lists:map(fun(X) -> list_to_integer(lists:flatten(X)) end, Found);
		_			   -> 0
	end.
