-module(part1).
-export([main/0]).

-define(TARGET, 29000000).

main() ->
	find_house(1).

find_house(N) ->
	Divs = divisors(N),
	case (lists:sum(Divs)*10) >= ?TARGET of
		true ->
			io:format("~p~n", [N]);
		false ->
			find_house(N+1)
	end.

%% Should be a pretty fast divisors algorithm.
divisors(0) -> [];
divisors(1) -> [1];
divisors(N) -> lists:sort(divisors(1, N)) ++ [N].

divisors(1, N) ->
	[1] ++ divisors(2, N, math:sqrt(N)).
divisors(K, _, Q) when K > Q -> [];
divisors(K, N, _) when N rem K =/= 0 ->
	[] ++ divisors(K + 1, N, math:sqrt(N));
divisors(K, N, _) when K * K =:= N ->
	[K] ++ divisors(K + 1, N, math:sqrt(N));
divisors(K, N, _) ->
	[K, N div K] ++ divisors(K + 1, N, math:sqrt(N)).
