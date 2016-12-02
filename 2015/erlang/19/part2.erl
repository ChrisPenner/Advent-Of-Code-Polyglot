-module(part2).
-export([main/0]).

-define(MOLECULE, "CRnCaSiRnBSiRnFArTiBPTiTiBFArPBCaSiThSiRnTiBPBPMgArCaSiRnTiMgArCaSiThCaSiRnFArRnSiRnFArTiTiBFArCaCaSiRnSiThCaCaSiRnMgArFYSiRnFYCaFArSiThCaSiThPBPTiMgArCaPRnSiAlArPBCaCaSiRnFYSiThCaRnFArArCaCaSiRnPBSiRnFArMgYCaCaCaCaSiThCaCaSiAlArCaCaSiRnPBSiAlArBCaCaCaCaSiThCaPBSiThPBPBCaSiRnFYFArSiThCaSiRnFArBCaCaSiRnFYFArSiThCaPBSiThCaSiRnPMgArRnFArPTiBCaPRnFArCaCaCaCaSiRnCaCaSiRnFYFArFArBCaSiThFArThSiThSiRnTiRnPMgArFArCaSiThCaPBCaSiRnBFArCaCaPRnCaCaPMgArSiRnFYFArCaSiThRnPBPMgAr").

%% Input file was modified a bit to make it easier to parse.
main() ->
	Map = gather_data(),
	Steps = get_steps(Map, lists:reverse(?MOLECULE), 0),
	io:format("~p~n", [Steps]).

gather_data() ->
	{ok, Data} = file:read_file("input"),
	lists:foldl(fun(X, Map) -> 
		[S,T] = re:split(X, ":", [{return,list}]), 
		dict:store(lists:reverse(T), lists:reverse(S), Map) end, 
	dict:new(), 
	lists:map(fun(Y) -> 
		binary_to_list(Y) 
	end, binary:split(Data, [<<"\n">>], [global]) -- [<<>>])).

get_steps(_, [$e], N) ->
	N;
get_steps(M, Str, N) ->
	case re:run(Str, string:join(dict:fetch_keys(M), "|"), [{capture,all,list}]) of
		{match, Found} ->
			FoundM = lists:flatten(Found),
			NewM = re:replace(Str, FoundM, dict:fetch(FoundM, M), [{return,list}]),
			io:format("~p~n", [NewM]),
			get_steps(M, NewM, N + 1)
	end.
