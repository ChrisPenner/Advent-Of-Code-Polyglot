#!/usr/bin/env escript

-module(part_1_2).
-mode(compile).
-export([find_hash/2, test/0]).

find_hash(Base, N, Zeroes) ->
	Bits = Zeroes * 4,
	Hash = erlang:md5([Base | integer_to_list(N)]),
	case Hash of
		<<0:Bits, _/bitstring>> ->
			N;
		_ ->
			find_hash(Base, N+1, Zeroes)
	end.

find_hash(Key, Zeroes) ->
	find_hash(Key, 0, Zeroes).

test() ->
	609043 = find_hash("abcdef", 5),
	1048970 = find_hash("pqrstuv", 5).

main([Base, Zeroes]) ->
	Num = find_hash(Base, list_to_integer(Zeroes)),
	io:format("found number: ~p \n", [Num]);

main([]) ->
	io:format("usage: string leading-zeroes \n").
