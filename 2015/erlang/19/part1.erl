-module(part1).
-export([main/0]).

-define(MOLECULE, "CRnCaSiRnBSiRnFArTiBPTiTiBFArPBCaSiThSiRnTiBPBPMgArCaSiRnTiMgArCaSiThCaSiRnFArRnSiRnFArTiTiBFArCaCaSiRnSiThCaCaSiRnMgArFYSiRnFYCaFArSiThCaSiThPBPTiMgArCaPRnSiAlArPBCaCaSiRnFYSiThCaRnFArArCaCaSiRnPBSiRnFArMgYCaCaCaCaSiThCaCaSiAlArCaCaSiRnPBSiAlArBCaCaCaCaSiThCaPBSiThPBPBCaSiRnFYFArSiThCaSiRnFArBCaCaSiRnFYFArSiThCaPBSiThCaSiRnPMgArRnFArPTiBCaPRnFArCaCaCaCaSiRnCaCaSiRnFYFArFArBCaSiThFArThSiThSiRnTiRnPMgArFArCaSiThCaPBCaSiRnBFArCaCaPRnCaCaPMgArSiRnFYFArCaSiThRnPBPMgAr").

%% Input file was modified a bit to make it easier to parse.
main() ->
	ets:new(molecules, [bag,named_table,public]),
	process_line(),
	Molecules = ets:lookup(molecules, ?MOLECULE),
	io:format("~p~n", [length(Molecules)]),
	ets:delete(molecules).

process_line() ->
	case io:get_line("") of
		eof -> ok;
		Str -> get_replacements(Str -- "\n"), process_line()
	end.

get_replacements(Str) ->
	[Init,Replace] = re:split(Str, ":", [{return,list}]),
	case re:run(?MOLECULE, Init, [global]) of
		{match, Matches} ->
			lists:map(fun(X) -> 
				{Offset, _} = X,
				ets:insert(molecules, {?MOLECULE, re:replace(?MOLECULE, Init, Replace, [{offset,Offset},{return,list}])})
			end, lists:flatten(Matches));
		nomatch ->
			ok
	end.
