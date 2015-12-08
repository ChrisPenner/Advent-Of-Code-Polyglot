-module(part1).
-export([main/0]).

main() ->
	Nice = run_lines(0),
	io:format("~p~n", [Nice]).

run_lines(Acc) ->
	case io:get_line("") of
		eof -> Acc;
		Str ->
			case re:run(Str, "(ab|cd|pq|xy)") of
				{match, _} -> run_lines(Acc);
				nomatch ->
					case is_nice(Str) of
						false -> run_lines(Acc);
						true -> run_lines(Acc+1)
					end
			end
	end.

is_nice(Str) ->
	case re:run(Str, "[aeiou].*[aeiou].*[aeiou].*") of
		nomatch -> 
			false;
		{match, _} -> 
			case re:run(Str, "(.)\\1") of
				{match, _} -> true;
				nomatch -> false
			end
	end.

