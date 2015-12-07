using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

public class Day03
{
	public static void Main()
	{
		var dx = new int[256];
		var dy = new int[256];
		dy['v'] = 1; 
		dy['^'] = -1;
		dx['>']=1; 
		dx['<'] = -1;

		var cmds = Console.ReadLine();
		var pp = new[]{Tuple.Create(0, 0), Tuple.Create(0, 0)};
		
		//i — command index. i%2 — index of person (Santa / robo Santa) in pp array
		Console.WriteLine(
			cmds.Select((c, i) => pp[i%2] = Tuple.Create(pp[i%2].Item1+dx[c], pp[i%2].Item2+dy[c])) 
			.Concat(new []{Tuple.Create(0, 0)})
			.Distinct().Count());
	}
}