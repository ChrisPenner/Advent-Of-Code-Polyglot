-module(part2).
-export([main/0]).

main() ->
	In = io:get_line("") -- "\n",
	Basement = find_basement(In, 0, 0),
	io:format("~p~n", [Basement]).

find_basement(_, -1, Pos) ->
	Pos;
find_basement([H|T], Count, Pos) ->
	case H of
		$( -> find_basement(T, Count+1, Pos+1);
		$) -> find_basement(T, Count-1, Pos+1)
	end.
