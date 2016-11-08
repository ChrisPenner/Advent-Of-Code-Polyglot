-module(both_parts).
-export([main/0]).

%% We want to ignore this text, offers nothing for building our structure
-define(JUNK, " happiness units by sitting next to ").

%% For part 2 the input changed, but the function did not.
main() ->
	ets:new(seating, [set,public,named_table]),
	gather_data(),
	Perms = get_permutations(ets:match(seating, '$1')),
	Optimal = get_optimal(Perms),
	io:format("~p~n", [Optimal]),
	ets:delete(seating).

gather_data() ->
	{ok, Data} = file:read_file("input"),
	lists:map(fun(X) -> 
		[Head, P2] = re:split(binary_to_list(X) -- [$.], ?JUNK, [{return,list}]),
		case re:run(Head, "(\\S+)", [global,{capture,all_but_first,list}]) of
			{match, [[P1],_,["gain"],[N]]} -> ets:insert(seating, {{P1,P2},list_to_integer(N)});
			{match, [[P1],_,["lose"],[N]]} -> ets:insert(seating, {{P1,P2},(list_to_integer(N) * -1)});
			_			   -> 0
		end
	end, binary:split(Data, [<<"\n">>], [global]) -- [<<>>]).

%% From the erlang documentation on list comprehensions
%% http://www.erlang.org/doc/programming_examples/list_comprehensions.html
perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L -- [H])].

get_optimal(Perms) ->
	lists:max(lists:map(fun(X) -> 
		lists:foldl(fun(Y,Sum) -> 
			Y + Sum 
		end, 0, total_happiness(X, hd(X), [])
	) end, Perms)).

total_happiness([P1,P2|T],F,Acc) ->
	[{{_,_},Val1}] = ets:lookup(seating,{P1,P2}),
	[{{_,_},Val2}] = ets:lookup(seating,{P2,P1}),
	total_happiness([P2|T],F,[Val1,Val2|Acc]);
total_happiness([T|[]],F,Acc) -> 
	[{{_,_},Val1}] = ets:lookup(seating,{T,F}),
	[{{_,_},Val2}] = ets:lookup(seating,{F,T}),
	lists:reverse([Val1,Val2|Acc]).

get_permutations(Cities) ->
	perms(sets:to_list(sets:from_list(lists:flatmap(fun(X) -> [{{F, T},_}] = X, [F,T] end, Cities)))).
