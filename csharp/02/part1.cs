using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

public class Day02
{
	public static void Main()
	{
		var boxes = Enumerable.Range(0, int.MaxValue)
			.Select(i => Console.ReadLine()).TakeWhile(s => s!=null)
			.Select(s => s.Split('x').Select(int.Parse).ToList())
			.ToList();
		
		Console.WriteLine(boxes.Sum(b => 2*(b[0]*b[1]+b[1]*b[2]+b[2]*b[0]) + b.Min() * (b.Sum() - b.Min() - b.Max())));
	}
}