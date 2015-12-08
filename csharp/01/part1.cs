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
		Console.WriteLine(text.Sum(c => c=='(' ? 1 : -1));
	}
}