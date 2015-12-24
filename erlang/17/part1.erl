-module(part1).
-export([main/0]).

-define(JARS, [50, 44, 11, 49, 42, 46, 18, 32, 26, 40, 21, 7, 18, 43, 10, 47, 36, 24, 22, 40]). 
main() ->
	Combos = combos(?JARS),
	Sum150 = lists:filter(fun(X) -> lists:sum(X) =:= 150 end, Combos),
	io:format("~p~n", [length(Sum150)]).

%% Formula taken from:
%% http://blog.sethladd.com/2007/08/calculating-combinations-erlang-way.html
%%
%% Not sure if other methods of generating combinations would be as fast.
combos(L) -> combos(L, bit_masks(length(L))).

combos(L, [BH|BT]) ->
	  [mask_list(L, BH)|combos(L, BT)];
combos(_, []) -> [].

mask_list([H|T], [BH|BT]) ->
	  case (BH) of
		      1 -> [H|mask_list(T, BT)] ;
		      0 -> mask_list(T, BT)
				     end;
mask_list([], []) -> [].

bit_masks(NumColumns) ->
	  bit_masks(0, round(math:pow(2, NumColumns))-1, NumColumns).

bit_masks(Max, Max, NumColumns) ->
	  [padl(NumColumns, bl(Max))];

bit_masks(X, Max, NumColumns) ->
	  [padl(NumColumns, bl(X)) | bit_masks(X+1, Max, NumColumns)].

padl(N, L) when N =:= length(L) -> L ;
padl(N, L) when N > length(L) -> padl(N, [0|L]).

bl(N) -> bl(N, []).

bl(0, Accum) -> Accum;
bl(N, Accum) -> bl(N bsr 1, [(N band 1) | Accum]).
