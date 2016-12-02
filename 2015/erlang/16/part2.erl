-module(part2).
-export([main/0]).

%% I solved part 1 accidentally simply by looking at the file..lol
main() ->
	Sues = gather_data(),
	Res = lists:map(fun(X) -> 
			maps:fold(fun(K1, V1, Acc) ->
				T = maps:map(fun(K2, V2) ->
						check_aunt(K2, V2) 
					end, V1),
				case all_true(T) of
					true -> K1;
					false -> Acc
				end 
			end, 0, X) 
		end, Sues),	
	Idx = [X || X <- Res, X > 0],
	io:format("~lp~n", [Idx]).
			

gather_data() ->
	{ok, Data} = file:read_file("input"),
	lists:map(fun(X) -> 
		case re:run(binary_to_list(X), "Sue (\\d+): (\\w+: \\d+), (\\w+: \\d+), (\\w+: \\d+)", [global,{capture,all_but_first,list}]) of
			{match, Found} ->
				{H,Rest} = lists:split(1, lists:append(Found)),
				TL = lists:foldl(fun(Y, Acc) -> [K,V] = re:split(Y, ": ", [{return,list}]), [{list_to_atom(K),list_to_integer(V)}|Acc] end, [], Rest),
				maps:from_list([{list_to_integer(lists:flatten(H)),maps:from_list(TL)}])
		end
	end, binary:split(Data, [<<"\n">>], [global]) -- [<<>>]).

check_aunt(K2, V2) ->
	case K2 of
		children    -> V2 == 3;
		cats	    -> V2 > 7;
		samoyeds    -> V2 == 2;
		pomeranians -> V2 < 3;
		akitas      -> V2 == 0;
		vizslas     -> V2 == 0;
		goldfish    -> V2 < 5;
		trees       -> V2 > 3;
		cars		-> V2 == 2;
		perfumes    -> V2 == 1
	end.

all_true(T) ->
	maps:fold(fun(K, V, Acc) ->
		Acc and V 
	end, true, T).
