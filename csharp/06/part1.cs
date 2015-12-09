using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.IO;
using System.Linq;
using System.Text;

public class Day06
{
	public static void Main()
	{
		var cmds = new Dictionary<string, Func<int, int>>{
			//Part1
			{"turn on", x => 1},
			{"turn off", x => 0},
			{"toggle", x => 1-x},
			//Part2:
			//{"turn on", x => x+1},
			//{"turn off", x => Math.Max(0, x-1)},
			//{"toggle", x => x+2},
		};
		var map = new int[1000,1000];
		var effects = 
			from line in File.ReadLines("input.txt")
			let cmd = cmds.First(c => line.StartsWith(c.Key)).Value
			let splitted = line.Split(' ')
			let p1=splitted[splitted.Length-3].Split(',').Select(int.Parse).ToList()
			let p2=splitted[splitted.Length-1].Split(',').Select(int.Parse).ToList()
			from x in Enumerable.Range(p1[0], p2[0]-p1[0]+1)
			from y in Enumerable.Range(p1[1], p2[1]-p1[1]+1)
			select new{x,y,v=cmd(map[x, y])};
		foreach(var e in effects)
			map[e.x, e.y] = e.v;
		Console.WriteLine(map.Cast<int>().Sum());
	}
}