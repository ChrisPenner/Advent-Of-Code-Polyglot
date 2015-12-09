-module(part2).
-export([main/0]).


main() ->
	In = io:get_line("") -- "\n",
	Basement = find_basement(In, 0, 0),
	io:format("~p~n", [Basement]).

%% Once we hit a -1 we return the position (index) we're at
find_basement(_, -1, Pos) ->
	Pos;

%% If it's ( we recurse going up a floor
%% If it's ) we recurse going down a floor
%%
%% -1 for Count will hit the above base case.
find_basement([H|T], Count, Pos) ->
	case H of
		$( -> find_basement(T, Count+1, Pos+1);
		$) -> find_basement(T, Count-1, Pos+1)
	end.
