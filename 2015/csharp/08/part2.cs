using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

class Day08
{
	static void Main()
	{
		Console.WriteLine(
			File.ReadLines("input.txt")
			.Sum(line => line.Count("\\\"".Contains)+2));
	}
}
