-module(part2).
-export([main/0]).

%% I really should just learn to do this with spawn / msg passing
%%
%% NOTE: This solution is too complicated. I misread part 2 at first
%% which resulted in a bunch of probably needless calculation, but I didn't
%% want to backtrack too much so I kind of just adapted it into something
%% that'd give me the right answer...
main() ->
	ets:new(deers, [set,public,named_table]),
	Lines = get_lines([]),
	%% Reindeer data...
	%% After we have it, we'll make N slots in the ETS table to hold their running totals
	RData = lists:map(fun(X) ->
				{match, [[Speed,Time,Rest]]} = re:run(X, "(\\d+).+?(\\d+).+?(\\d+)", [global,{capture,all_but_first,list}]),
				[Speed,Time,Rest]
			end, Lines),
	init_table(length(RData)),
	Distances = gather_distances(RData, []),
	score_deers(Distances, 1, 2503),
	FinalScores = lists:flatten(ets:match(deers, '$1')),
	MaxPoints = get_max_points(FinalScores, 0),
	io:format("~p~n", [MaxPoints]),
	ets:delete(deers).

get_lines(Acc) ->
	case io:get_line("") of
		eof -> lists:reverse(Acc);
		Str -> get_lines([Str -- "\n"|Acc])
	end.

gather_distances([], Acc) ->
	lists:reverse(Acc);
gather_distances([H|T], Acc) ->
	[Speed,Time,Rest] = lists:map(fun(X) -> list_to_integer(X) end, H),
	Ticks = get_race_ticks([], 2503, running, Speed, Time, Rest),
	Times = lists:zipwith(fun(X,Y) -> {Y,X} end, Ticks, lists:seq(1,2503)),
	gather_distances(T, [Times|Acc]).

get_race_ticks(Acc, N, _, _, _, _) when length(Acc) >= N ->
	lists:sublist(lists:reverse(Acc), 1, N);
get_race_ticks(Acc, N, State, Speed, Time, Rest) ->
	case State of
		running ->
			get_race_ticks(lists:append(lists:duplicate(Time, Speed), Acc), N, resting, Speed, Time, Rest);
		resting ->
			get_race_ticks(lists:append(lists:duplicate(Rest, 0), Acc), N, running, Speed, Time, Rest)
	end.

init_table(N) ->
	lists:map(fun(X) ->
		ets:insert(deers, {X,0,0})
	end, lists:seq(1,N)).

deers_at([], _, Acc, _) ->
	lists:reverse(Acc);
deers_at([H|T], N, Acc, Idx) ->
	{_, Val} = lists:keyfind(N, 1, H),
	deers_at(T, N, [{Idx,Val}|Acc],Idx+1).

score_deers(_, Tick, TotalTicks) when Tick > TotalTicks ->
	ok;
score_deers(Dists, Tick, TotalTicks) ->
	CurrSpots = deers_at(Dists, Tick, [], 1),
	lists:map(fun(X) -> {K,V} = X, ets:update_counter(deers, K, {2, V}) end, CurrSpots),
	Deers = lists:flatten(ets:match(deers, '$1')),
	Max = max_from_curr(Deers, 0),
	DeersAtMax = [X || {X, Val, _} <- Deers, Val == Max],
	lists:map(fun(X) -> ets:update_counter(deers, X, {3, 1}) end, DeersAtMax),
	score_deers(Dists, Tick+1, TotalTicks).

max_from_curr([], Max) ->
	Max;
max_from_curr([H|T], Max) ->
	{_, Val, _} = H,
	case Val >= Max of
		true -> max_from_curr(T, Val);
		false -> max_from_curr(T, Max)
	end.

get_max_points([], Max) ->
	Max;
get_max_points([H|T], Max) ->
	{_, _, P} = H,
	case P >= Max of
		true -> get_max_points(T, P);
		false -> get_max_points(T, Max)
	end.
