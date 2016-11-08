-module(part2).
-export([main/0]).

main() ->
	Grid = init_grid(0, 99),
	After = run_cycles(Grid, 100),
	io:format("~p~n", [lights_on(After)]).

run_cycles(G, 0) ->
	G;
run_cycles(G, N) ->
	Coords = [{X,Y} || X <- lists:seq(0, 99), Y <- lists:seq(0, 99)],
	NewVals = lists:map(fun(X) ->
		{P, L} = digraph:vertex(G, X),
		case P of
			{0,0}   -> 1;
			{99,99} -> 1;
			{0,99}  -> 1;
			{99,0}  -> 1;
			_       ->
				case L of
					1 ->
						case neighbours_on(G, X) of
							2 -> 1;
							3 -> 1;
							_ -> 0
						end;
					0 ->
						case neighbours_on(G, X) of
							3 -> 1;
							_ -> 0
						end
				end 
			end
	end, Coords),
	Points = lists:zip(Coords, NewVals),
	digraph:delete(G),
	GPrime = digraph:new(),
	lists:map(fun(X) -> {P, V} = X, digraph:add_vertex(GPrime, P, V) end, Points),
	add_edges(GPrime, Points),
	run_cycles(GPrime, N-1).

init_grid(A, B) ->
	Data = lists:flatten(parse_file()),
	Coords = [{X,Y} || X <- lists:seq(A, B), Y <- lists:seq(A, B)],
	Points = lists:zip(Coords, Data),
	G = digraph:new(),
	lists:map(fun(X) -> {P, V} = X, digraph:add_vertex(G, P, V) end, Points),
	add_edges(G, Points).

parse_file() ->
	{ok, D} = file:read_file("grid"),
	lists:map(fun(X) ->
		lists:map(fun(Y) -> case Y of $. -> 0; $# -> 1 end end, binary_to_list(X))
	end, binary:split(D, [<<"\n">>], [global]) -- [<<>>]).

add_edges(G, []) ->
	G;
add_edges(G, [H|T]) ->
	{P, _} = H,
	case P of
		{0,0}   -> add_top_left(G);
		{99,0}  -> add_top_right(G);
		{0,99}  -> add_bottom_left(G);
		{99,99} -> add_bottom_right(G);
		{0,Y}   -> add_Xside(G, 0,  Y);
		{99,Y}  -> add_Xside(G, 99, Y);
		{X,0}   -> add_Yside(G, X,  0);
		{X,99}  -> add_Yside(G, X, 99);
		{X,Y}   -> add_other_point(G, X, Y)
	end,
	add_edges(G, T).

%% Corner functions (add 3 edges)
add_top_left(G) ->
	lists:map(fun(X) -> digraph:add_edge(G, {0,0},   X) end, [{0,1},{1,0},{1,1}]).
add_top_right(G) ->
	lists:map(fun(X) -> digraph:add_edge(G, {99,0},  X) end, [{99,1},{98,0},{98,1}]).
add_bottom_left(G) ->
	lists:map(fun(X) -> digraph:add_edge(G, {0,99},  X) end, [{0,98},{1,99},{1,98}]).
add_bottom_right(G) ->
	lists:map(fun(X) -> digraph:add_edge(G, {99,99}, X) end, [{98,99},{99,98},{98,98}]).

%% Side functions (add 5 edges)
add_Xside(G, X, Y) ->
	lists:map(fun(S) -> 
		digraph:add_edge(G, {X,Y}, S) 
	end, case X of 
			 0  -> [{X,Y-1},{X,Y+1},{X+1,Y},{X+1,Y-1},{X+1,Y+1}]; 
			 99 -> [{X,Y-1},{X,Y+1},{X-1,Y},{X-1,Y+1},{X-1,Y-1}] 
		 end).
add_Yside(G, X, Y) ->
	lists:map(fun(S) -> 
		digraph:add_edge(G, {X,Y}, S) 
	end, case Y of
			 0  -> [{X-1,Y},{X+1,Y},{X,Y+1},{X-1,Y+1},{X+1,Y+1}];
			 99 -> [{X-1,Y},{X+1,Y},{X,Y-1},{X-1,Y-1},{X+1,Y-1}]
		 end).

add_other_point(G, X, Y) ->
	lists:map(fun(S) ->
		digraph:add_edge(G, {X,Y}, S) 
	end, [{X+1,Y},{X-1,Y},{X,Y+1},{X,Y-1},{X+1,Y-1},{X-1,Y+1},{X+1,Y+1},{X-1,Y-1}]).

neighbours_on(G, V) ->
	N = digraph:out_neighbours(G, V),
	lists:foldl(fun(X, Acc) ->
		{_, L} = digraph:vertex(G, X),
		case L of
			1 -> Acc+1;
			0 -> Acc
		end
	end, 0, N).


lights_on(G) ->
	lists:foldl(fun(X, Acc) ->
		{_, L} = digraph:vertex(G, X),
		case L of
			1 -> Acc+1;
			0 -> Acc
		end
	end, 0, digraph:vertices(G)).
