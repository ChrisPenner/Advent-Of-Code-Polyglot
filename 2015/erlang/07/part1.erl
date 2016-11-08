-module(part1).
-export([main/0]).

%% We create a new ETS table to function as a lookup table for the circuit.
%% (Read about ETS here: http://www.erlang.org/doc/man/ets.html)
main() ->
	ets:new(circuits, [set,public,named_table]),
	create_circuits(readlines("input")),
	io:format("~p~n", [val("a")]).

%% This does a few things:
%% 1) Read the whole file into Data (binary representation)
%% Then we're going to tokenize on "-> ". Erlang will tokenize based on the
%% characters in this list ("-> " is a list), but if it finds any of them in sequence they
%% are treated as 1 character so we don't have empty strings in the result.
%%
%% 2) The strings we're actually tokenizing come from the binary:split() function call.
%% We're splitting on "\n" which is written as <<"\n">> because it's a binary string- it's
%% in a list because that's what the functions expecting. Just a note- this split call will leave us
%% with an extra empty binary string at the end so we subtract that (-- [<<>>]) and bam good to go.
readlines(Filename) ->
	{ok, Data} = file:read_file(Filename),
	[string:tokens(erlang:binary_to_list(Str), "-> ") || 
	 	Str <- (binary:split(Data, [<<"\n">>], [global]) -- [<<>>])].

%% This function goes through all the lines and maps them into our previously created
%% ETS table. We take the head of the reverse list, i.e the thing on the right side of ->
%% in our input, and then we put in as a value the list of whatever else without the last element
%% (the last element became the key)
create_circuits(Schematics) ->
	lists:foreach(fun(X) ->
		{In, Op} = {hd(lists:reverse(X)), lists:droplast(X)},
		ets:insert(circuits, {In, Op})
	end, Schematics).

%% Now all we do is basically recursively lookup the value.
val(X) ->
	R = case string:to_integer(X) of
			{error, _} ->
				case ets:lookup(circuits, X) of
					[{_, Res}] when is_integer(Res) -> Res;
					[{_, L}] when is_list(L) -> parse(L)
				end;
			{Res, _} -> Res
	end,
	ets:insert(circuits, {X, R}),
	R.

%% Just some pattern matching to parse the expressions
%% after we have them in a list representation
parse([X]) -> val(X);
parse(["NOT", X]) -> bnot val(X);
parse([X, "AND", Y]) -> val(X) band val(Y);
parse([X, "OR", Y]) -> val(X) bor val(Y);
parse([X, "LSHIFT", Y]) -> val(X) bsl val(Y);
parse([X, "RSHIFT", Y]) -> val(X) bsr val(Y).
