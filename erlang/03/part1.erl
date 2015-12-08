-module(part1).
-export([main/0]).
-import(dict, [store/3, update_counter/3]).

main() ->
	In = io:get_line("") -- "\n",
	Houses = store({0,0}, 1, dict:new()),
	Visited = process_input(In, Houses, 0, 0),
	io:format("~p~n", [Visited]).

process_input([], Houses, _, _) ->
	dict:size(Houses);
process_input([H|T], Houses, X, Y) ->
	case H of
		$^ -> process_input(T, update_counter({X,Y+1}, 1, Houses), X, Y+1);
		$> -> process_input(T, update_counter({X+1,Y}, 1, Houses), X+1, Y);
		$v -> process_input(T, update_counter({X,Y-1}, 1, Houses), X, Y-1);
		$< -> process_input(T, update_counter({X-1,Y}, 1, Houses), X-1, Y)
	end.
