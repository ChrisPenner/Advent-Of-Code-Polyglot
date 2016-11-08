-module(part1).
-export([main/0]).

main() ->
	Lines = get_lines([]),
	%% Reindeer data...
	RData = lists:map(fun(X) ->
				{match, [[Speed,Time,Rest]]} = re:run(X, "(\\d+).+?(\\d+).+?(\\d+)", [global,{capture,all_but_first,list}]),
				[Speed,Time,Rest]
			end, Lines),
	Distances = gather_distances(RData, []),
	io:format("~p~n", [lists:max(Distances)]).

get_lines(Acc) ->
	case io:get_line("") of
		eof -> lists:reverse(Acc);
		Str -> get_lines([Str -- "\n"|Acc])
	end.

gather_distances([], Acc) ->
	lists:reverse(Acc);
gather_distances([H|T], Acc) ->
	[Speed,Time,Rest] = lists:map(fun(X) -> list_to_integer(X) end, H),
	Ticks = lists:sum(get_race_ticks([], 2503, running, Speed, Time, Rest)),
	gather_distances(T, [Ticks|Acc]).

get_race_ticks(Acc, N, _, _, _, _) when length(Acc) >= N ->
	lists:sublist(lists:reverse(Acc), 1, N);
get_race_ticks(Acc, N, State, Speed, Time, Rest) ->
	case State of
		running ->
			get_race_ticks(lists:append(lists:duplicate(Time, Speed), Acc), N, resting, Speed, Time, Rest);
		resting ->
			get_race_ticks(lists:append(lists:duplicate(Rest, 0), Acc), N, running, Speed, Time, Rest)
	end.
