-module(part2).
-export([main/0]).
-import(dict, [store/3, update_counter/3]).

main() ->
	In = io:get_line("") -- "\n",
	Houses = store({0,0}, 2, dict:new()),
	Visited = process_input(In, Houses, {0,0}, {0,0}, 0),
	io:format("~p~n", [Visited]).

process_input([], Houses, _, _, _) ->
	dict:size(Houses);
process_input([H|T], Houses, {X,Y}, RXY, 0) ->
	process_input(T, deliver_gift(H, Houses, X, Y), update_loc(H, X, Y), RXY, 1);
process_input([H|T], Houses, SXY, {X, Y}, 1) ->
	process_input(T, deliver_gift(H, Houses, X, Y), SXY, update_loc(H, X, Y), 0).

deliver_gift(Dir, Houses, X, Y) ->
	case Dir of
		$^ -> update_counter({X,Y+1}, 1, Houses);
		$> -> update_counter({X+1,Y}, 1, Houses);
		$v -> update_counter({X,Y-1}, 1, Houses);
		$< -> update_counter({X-1,Y}, 1, Houses)
	end.

update_loc($^, X, Y) -> {X,Y+1};
update_loc($>, X, Y) -> {X+1,Y};
update_loc($v, X, Y) -> {X,Y-1};
update_loc($<, X, Y) -> {X-1,Y}.
