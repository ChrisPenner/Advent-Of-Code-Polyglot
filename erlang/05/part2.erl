-module(part2).
-export([main/0]).

main() ->
	Nice = run_lines(0),
	io:format("~p~n", [Nice]).

run_lines(Acc) ->
	case io:get_line("") of
		eof -> Acc;
		Str ->
			case re:run(Str, "(..).*\\1") of
				{match, _} -> 
					case re:run(Str, "(.).{1}\\1") of
						{match, _} -> run_lines(Acc+1);
						nomatch    -> run_lines(Acc)
					end;
				nomatch ->
					run_lines(Acc)
			end
	end.
