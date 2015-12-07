using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

public class Day01
{
	public static void Main()
	{
		var text = Console.ReadLine();
		var currentFloor = 0;
		var floorWithIndex = text.Select((c, index) => new{index, floor=currentFloor+=(c=='(' ? 1 : -1)});
		Console.WriteLine(floorWithIndex.First(p => p.floor==-1).index+1);
	}
}