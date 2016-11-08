-module(both_parts).
-export([main/0]).

%% This functions displays the results for both parts
main() ->
	ets:new(cities, [set,public,named_table]),
	gather_data(),
	Perms = get_permutations(ets:match(cities, '$1')),
	Distances = lists:map(fun(X) -> total_dist(X, 0) end, Perms),
	io:format("Shortest: ~p~n", [lists:min(Distances)]),
	io:format("Longest: ~p~n", [lists:max(Distances)]),
	ets:delete(cities).
	%lists:map(fun(X) -> io:format("For route: ~p it takes: ~p~n", [X, total_dist(X, 0)]) end, Perms).

gather_data() ->
	{ok, Data} = file:read_file("input"),
	lists:map(fun(X) -> 
		[F, _, T, _, W] = re:split(binary_to_list(X), "\\s+", [{return,list}]), 
		ets:insert(cities, {{F,T},list_to_integer(W)})
	end, binary:split(Data, [<<"\n">>], [global]) -- [<<>>]).

%% From the erlang documentation on list comprehensions
%% http://www.erlang.org/doc/programming_examples/list_comprehensions.html
perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L -- [H])].

total_dist([C1,C2|T],Acc) ->
	case ets:lookup(cities,{C1,C2}) of
		[] -> case ets:lookup(cities,{C2,C1}) of
				[{{_,_},Val}] -> total_dist([C2|T],Acc+Val);
				_ -> error("Connection not found")
			  end;
		[{{_,_},Val}] -> total_dist([C2|T],Acc+Val)
	end;
total_dist([_|[]],Acc) -> 
	Acc.

get_permutations(Cities) ->
	perms(sets:to_list(sets:from_list(lists:flatmap(fun(X) -> [{{F, T},_}] = X, [F,T] end, Cities)))).
