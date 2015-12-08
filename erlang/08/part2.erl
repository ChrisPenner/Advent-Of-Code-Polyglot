-module(part2).
-export([main/0, enc_length/1]).
-import(binary, [split/3]).

main() ->
	{ok, Data} = file:read_file("input"),
	Lines = gather_lines(Data),
	C1 = count_chars(Lines, fun(X) -> length(X) end), 
	C2 = count_chars(Lines, fun(X) -> enc_length(X) end),
	io:format("~p~n", [C2 - C1]).

%% Counts characters in a list
count_chars(L, Fun) ->
	lists:foldl(fun(X, Sum) -> 
		Fun(X) + Sum 
	end, 0, L).

gather_lines(Data) ->
	[binary_to_list(Y) || Y <- [Str || Str <- split(Data, [<<"\n">>], [global]) -- [<<>>]]].

%% Accounts for escape sequences
%% We add an additional 2 chars for the enclosing double quotes.
enc_length(L)                      -> enc_length(L, 0).
enc_length([], Acc) 			   -> Acc+2;
enc_length([$\\,$x,_,_|T],Acc)	   -> enc_length(T,Acc+5);
enc_length([$\\|T],Acc)			   -> enc_length(T,Acc+2);
enc_length([$"|T],Acc)			   -> enc_length(T,Acc+2);
enc_length([_|T],Acc)              -> enc_length(T,Acc+1).
