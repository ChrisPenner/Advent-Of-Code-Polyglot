using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

class Day09
{
	static void Main()
	{
		// read graph edges
		var edges = File.ReadAllLines("input.txt")
			.Select(line => line.Split(' '))
			.Select(line => Tuple.Create(line[0], line[2], int.Parse(line[4])))
			.ToList();
		var nodes = new HashSet<string>(
			edges.Select(e => e.Item1).Concat(edges.Select(e => e.Item2)));
		
		edges = 
			// add reversed edges:
			edges.Concat(edges.Select(e => Tuple.Create(e.Item2, e.Item1, e.Item3))) 
			// add edges from virtual starting node to all other nodes:
			.Concat(nodes.Select(n => Tuple.Create("", n, 0))) 
			.ToList();
		Console.WriteLine(GetPathLen("", edges, nodes)); //start search from virtual starting node
	}
	
	static int GetPathLen(string node, List<Tuple<string, string, int>> edges, HashSet<string> nodes, int curLen = 0){
		nodes.Remove(node); // do not go to this node in recursive calls if any
		try{
			return nodes.Count == 0 ? curLen : 
				edges.Where(e => e.Item1 == node && nodes.Contains(e.Item2))
				.Select(e => GetPathLen(e.Item2, edges, nodes, curLen + e.Item3)) //find the path tail
				.Min(); // the only line different from part1
		}
		finally{
			nodes.Add(node);
		}
	}
}
