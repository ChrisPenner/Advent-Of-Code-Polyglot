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
		Console.WriteLine(boxes.Sum(b => 
			2*(b.Sum() - b.Max()) //2(min + middle) = 2(sum - max)
			+ b[0]*b[1]*b[2])); // volume of the box
	}
}