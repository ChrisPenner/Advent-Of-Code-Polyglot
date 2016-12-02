-module(part1).
-export([main/0]).
-import(lists, [partition/2]).

%% This function gets a line and takes off the "\n".
%%
%% After this we partition the input into two lists, one with elements matching '('
%% and the other with elements not matching.
%%
%% If we subtract the left from the right, we find out what floor Santa is on.
main() ->
	In = io:get_line("") -- "\n",
	{Left,Right} = partition(fun(X) -> X == $( end, In),
	io:format("~p~n", [length(Left) - length(Right)]).
