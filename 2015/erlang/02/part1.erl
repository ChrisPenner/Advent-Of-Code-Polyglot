-module(part1).
-export([main/0]).

main() ->
	{ok, File} = file:open("input", [read]),
	Lines = read(File),
	file:close(File),
	%% After we get all the lines in our tuple format we generate a list of the sides
	Sides = [{L*W,W*H,H*L} || {L,W,H} <- Lines],
	Sum = sum_sides(Sides, 0),
	io:format("~p~n", [Sum]).

%% This function is a bit involved but not too complicated..
%% It will read lines from the file, and turn them into tuples.
%% Since the lines are in the form: ##x##x## where #'s are numbers
%% we need to extract those. We do this by splitting the Data (minus \n)
%% on "x". Since this returns a list we map list_to_integer over that,
%% and then apply list_to_tuple to get the format we want.
read(File) ->
	case file:read_line(File) of
		{ok, Data} -> 
			[list_to_tuple(lists:map(fun(X) -> 
				list_to_integer(X) end, 
				re:split(Data -- "\n", "[x]", 
						 [{return,list}]))) | read(File)];
		eof 	   -> []
	end.

%% Basically get the min from the tuple and then add it to each side multiplied by 2
sum_sides([], Acc) ->
	Acc;
sum_sides([H|T], Acc) ->
	Min = lists:min(tuple_to_list(H)),
	sum_sides(T, Acc + Min + lists:foldl(fun(X, Prod) -> (2*X) + Prod end, 0, tuple_to_list(H))).
