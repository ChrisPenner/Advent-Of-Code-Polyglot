using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

public class Day02
{
	public static void Main()
	{
		var boxes = Enumerable.Range(0, int.MaxValue) //[almost] infinite lazy sequence
			.Select(i => Console.ReadLine()).TakeWhile(s => s!=null) //all lines from console
			.Select(s => s.Split('x').Select(int.Parse).ToList()) //convert each line to list of integers.
			.ToList();
		Console.WriteLine(
			boxes.Sum(b => 
				2*(b[0]*b[1]+b[1]*b[2]+b[2]*b[0]) // area of the box
				+ b.Min() * (b.Sum() - b.Min() - b.Max()) // extra paper = min * middle, while middle = sum - min - max
				));
	}
}