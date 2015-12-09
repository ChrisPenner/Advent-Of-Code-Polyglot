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
			//{"turn on", x => 1},
			//{"turn off", x => 0},
			//{"toggle", x => 1-x},
			//Part2:
			{"turn on", x => x+1},
			{"turn off", x => Math.Max(0, x-1)},
			{"toggle", x => x+2},
		};
		// Idea of this solution:
		// make a sequence of tuples (x, y, change), group it by (x, y) and aggregate all changes.
		// It is quite slow and memory consuming solution
		// The reason is 'group by' operation which forces IEnumerable to be evaluated and stored in large dictionary.
		var brightness = 
			from line in File.ReadLines("input.txt")
			let change = cmds.First(c => line.StartsWith(c.Key)).Value
			let splitted = line.Split(' ')
			let p1=splitted[splitted.Length-3].Split(',').Select(int.Parse).ToList()
			let p2=splitted[splitted.Length-1].Split(',').Select(int.Parse).ToList()
			from x in Enumerable.Range(p1[0], p2[0]-p1[0]+1)
			from y in Enumerable.Range(p1[1], p2[1]-p1[1]+1)
			group change by new {x, y} into g
			select g.Aggregate(0, (value, change) => change(value));
		Console.WriteLine(brightness.Sum());
	}
}