-module(part2).
-export([main/0]).

-define(WEAPONS, [
	{dagger,     [{cost,  8},{dam,4},{def,0}]}, 
	{shortsword, [{cost, 10},{dam,5},{def,0}]}, 
	{warhammer,  [{cost, 25},{dam,6},{def,0}]}, 
	{longsword,  [{cost, 40},{dam,7},{def,0}]}, 
	{greataxe,   [{cost, 74},{dam,8},{def,0}]}
]).

-define(ARMOR, [
	{dummy,      [{cost,   0},{dam,0},{def,0}]},
	{leather,    [{cost,  13},{dam,0},{def,1}]}, 
	{chainmail,  [{cost,  31},{dam,0},{def,2}]}, 
	{splintmail, [{cost,  53},{dam,0},{def,3}]}, 
	{bandedmail, [{cost,  75},{dam,0},{def,4}]}, 
	{platemail,  [{cost, 102},{dam,0},{def,5}]}
]).

-define(RINGS, [
	{dam1, [{cost, 25},{dam,1},{def,0}]}, 
	{dam2, [{cost, 50},{dam,2},{def,0}]}, 
	{dam3, [{cost,100},{dam,3},{def,0}]}, 
	{def1, [{cost, 20},{dam,0},{def,1}]}, 
	{def2, [{cost, 40},{dam,0},{def,2}]},
	{def3, [{cost, 80},{dam,0},{def,3}]},
	{dum1, [{cost, 0},{dam,0},{def,0}]},
	{dum2, [{cost, 0},{dam,0},{def,0}]}
]).

-define(PLAYER, [{hp,100},{dam,0},{def,0}]).
-define(BOSS, [{hp,103},{dam,9},{def,2}]).

main() ->
	Builds = get_builds(),
	LosingBuild = lists:max(find_losers(Builds, [])),
	io:format("~p~n", [LosingBuild]).

get_builds() ->
	[{W,A,R1,R2} || 
	 W <- ?WEAPONS, 
	 A <- ?ARMOR, 
	 R1 <- ?RINGS, 
	 R2 <- ?RINGS, 
	 R1 /= R2].

find_losers([], Acc) ->
	Acc;
find_losers([H|T], Acc) ->
	Build = tuple_to_list(H),
	Cost = lists:foldl(fun(X, Sum) -> {_, Prop} = X, Sum + proplists:get_value(cost, Prop) end, 0, Build),
	DamBoost = lists:foldl(fun(X, Sum) -> {_, Prop} = X, Sum + proplists:get_value(dam, Prop) end, 0, Build),
	DefBoost = lists:foldl(fun(X, Sum) -> {_, Prop} = X, Sum + proplists:get_value(def, Prop) end, 0, Build),
	PDam = proplists:get_value(dam, ?PLAYER) + DamBoost,
	PDef = proplists:get_value(def, ?PLAYER) + DefBoost,
	BDam = proplists:get_value(dam, ?BOSS),
	BDef = proplists:get_value(def, ?BOSS),
	BMoves = ceiling(proplists:get_value(hp, ?PLAYER) / max((BDam - PDef), 1)),
	PMoves = ceiling(proplists:get_value(hp, ?BOSS) / max((PDam - BDef), 1)),
	case BMoves =< PMoves of
		true ->
			find_losers(T, [Cost|Acc]);
		false ->
			find_losers(T, Acc)
	end.

ceiling(X) when X < 0 ->
	trunc(X);
ceiling(X) ->
	T = trunc(X),
	case X - T == 0 of
		true -> T;
		false -> T + 1
	end.
