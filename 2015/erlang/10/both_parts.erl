-module(both_parts).
-export([main/0]).
-import(lists, [flatten/1, reverse/1, flatmap/2, dropwhile/2, takewhile/2]).

main() ->
	In = "1113122113",
	Res = group(In, []),
	% Put 40 or 50 depending on if you want pt. 1 or 2.
	io:format("~p~n", [sequence(Res, 50)]).

sequence(L, 0) ->
	length(flatten(L));
sequence(L, N) ->
	sequence(group(flatten(flatmap(fun(X) -> [integer_to_list(length(X)),hd(X)] end, L)), []), N-1).

group([], Acc) ->
	reverse(Acc);
group(L, Acc) ->
	group(dropwhile(fun(X) -> X == hd(L) end, L),
		  [takewhile(fun(X) -> X == hd(L) end, L)|Acc]).
