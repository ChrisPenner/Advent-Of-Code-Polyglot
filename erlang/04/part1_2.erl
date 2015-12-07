#!/usr/bin/env escript

-module(part_1_2).
-mode(compile).
-export([find_hash/2, test/0]).

find_hash(Base, N, Zeroes) ->

	%% number of bits to match for, number of leading zeroes * bits per hex character (0-F = 4 bits to represent).
	Bits = Zeroes * 4,

	%% calculates the md5 hash from the new list of characters,
	%%  returns a binary: http://www.erlang.org/doc/efficiency_guide/binaryhandling.html
	%% * note that strings in erlangs are simply lists of characters *
	Hash = erlang:md5([Base | integer_to_list(N)]),

	case Hash of
		%% uses binary pattern matching to look for Bits number of leading bits,
		%%  with the rest of the binary in _
		<<0:Bits, _/bitstring>> ->
			N; %% done recursing, return the current N.
		_ ->
			find_hash(Base, N+1, Zeroes) %% recurse further since case didn't match, now with next N.
	end.

find_hash(Key, Zeroes) ->
	find_hash(Key, 0, Zeroes).

%% unit tests, expression fails if the two sides are not equal, since the left hand side is not a new Term.
test() ->
	609043 = find_hash("abcdef", 5),
	1048970 = find_hash("pqrstuv", 5).

main([Base, Zeroes]) ->
	Num = find_hash(Base, list_to_integer(Zeroes)),
	io:format("found number: ~p \n", [Num]);

main([]) ->
	io:format("usage: string leading-zeroes \n").
