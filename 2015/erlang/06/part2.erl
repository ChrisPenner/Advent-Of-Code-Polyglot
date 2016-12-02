-module(part2).
-export([main/0]).

%% This solves Advent of Code day 6 part 2 with ETS tables
%% and binary pattern matching to parse the input.
main() ->
	ets:new(grid, [set, public, named_table]),
	init_grid(),
	process_input(readlines("input")),
	io:format("~p~n", [count_brightness()]).

readlines(Filename) ->
	{ok, Data} = file:read_file(Filename),
	binary:split(Data, [<<"\n">>], [global]) -- [<<>>].

init_grid() ->
	lists:foreach(fun(X) ->
		lists:foreach(fun(Y) ->
			ets:insert(grid, {{X,Y},0})
		end, lists:seq(0,999))
	end, lists:seq(0,999)).

process_input([]) ->
	ok;
process_input([H|T]) ->
	case H of
		<<"turn on ", Rest/binary>> -> turn_on(parse_coord(Rest));
		<<"turn off ", Rest/binary>> -> turn_off(parse_coord(Rest));
		<<"toggle ", Rest/binary>> -> toggle(parse_coord(Rest))
	end,
	process_input(T).

turn_on({{X1,Y1},{X2,Y2}}) -> manip_grid(X1, Y1, X2, Y2, on).
turn_off({{X1,Y1},{X2,Y2}}) -> manip_grid(X1, Y1, X2, Y2, off).
toggle({{X1,Y1},{X2,Y2}}) -> manip_grid(X1, Y1, X2, Y2, toggle).

manip_grid(X1, Y1, X2, Y2, Op) ->
	lists:foreach(fun(X) ->
		lists:foreach(fun(Y) ->
			case Op of
				on -> ets:update_counter(grid, {X,Y}, 1);
				off -> ets:update_counter(grid, {X,Y}, {2, -1, 0, 0});
				toggle -> ets:update_counter(grid, {X,Y}, 2)
			end		
		end, lists:seq(X1,X2))
	end, lists:seq(Y1,Y2)).

count_brightness() ->
	ets:foldl(fun(X, Sum) -> 
		{_, Val} = X, 
		Val + Sum
	end, 0, grid).

parse_coord(Rest) ->
	[C1, _, C2] = re:split(Rest, "[ ]", [{return,list}]),
	[X1,Y1] = split_coord(C1),
	[X2,Y2] = split_coord(C2),
	{{X1,Y1},{X2,Y2}}.

split_coord(C) ->
	lists:map(fun(X) -> list_to_integer(X) end, re:split(C, "[,]", [{return,list}])).
