-module(part1).
-export([main/0]).

%% Fairly unimaginative, we just brute-force the score by generating all
%% combos that sum to 100 then finding the max score on all possibilities.
main() ->
	[A1,A2,A3,A4] = [4,-2,0,0],
	[B1,B2,B3,B4] = [0,5,-1,0],
	[C1,C2,C3,C4] = [-1,0,5,0],
	[D1,D2,D3,D4] = [0,0,-2,2],

	Combos = generate_combos(),
	BestScore = lists:foldl(fun([Ax,Bx,Cx,Dx], Acc) ->
						Ar = (Ax * A1 + Bx * B1 + Cx * C1 + Dx * D1),
						Br = set_ratio_val(Ax,Bx,Cx,Dx,A2,B2,C2,D2,Ar),
						Cr = set_ratio_val(Ax,Bx,Cx,Dx,A3,B3,C3,D3,Br),
						Dr = set_ratio_val(Ax,Bx,Cx,Dx,A4,B4,C4,D4,Cr),
						case (Dr > 0) and (Ar*Br*Cr*Dr > Acc) of
							true -> Ar*Br*Cr*Dr;
							_	 -> Acc
						end
				end, 0, Combos),
	io:format("~p~n", [BestScore]).

generate_combos() ->
	[[A, B, C, D] ||
		A <- lists:seq(0,100),
		B <- lists:seq(0,100),
		C <- lists:seq(0,100),
		D <- lists:seq(0,100),
		A + B + C + D == 100].

set_ratio_val(Ax,Bx,Cx,Dx,An,Bn,Cn,Dn,Lr) ->
	case Lr > 0 of
		true -> (Ax*An + Bx*Bn + Cx*Cn + Dx*Dn);
		false -> 0
	end.
