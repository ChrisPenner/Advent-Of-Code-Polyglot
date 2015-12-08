-module(part2).
-export([main/0]).
-import(lists, [flatten/1, map/2]).
-import(string, [str/2]).

main() ->
	Prefix = io:get_line("") -- "\n",
	LowestNum = get_lowest_num(Prefix, 1),
	io:format("~p~n", [LowestNum]).

get_lowest_num(Prefix, N) ->
	case str(checksum([Prefix|integer_to_list(N)]), "000000") of
		1 -> N;
		_ -> get_lowest_num(Prefix, N+1)
	end.

checksum(Md5Bin) ->
	flatten(list_to_hex(binary_to_list(erlang:md5(Md5Bin)))).

list_to_hex(L) ->
	map(fun(X) -> int_to_hex(X) end, L).

int_to_hex(N) when N < 256 ->
	[hex(N div 16), hex(N rem 16)].

hex(N) when N < 10 ->
	$0+N;
hex(N) when N >= 10, N < 16 ->
	$a + (N - 10).
