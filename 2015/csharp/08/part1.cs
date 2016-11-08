using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

class Program
{
	static void Main()
	{
		var lines = File.ReadAllLines("input.txt");
		var sum = 0;
		foreach(var line in lines) 
		{
			int i = 1;
			int chars = 0;
			while (i<line.Length-1)
			{
				if (line[i] == '\\')
				{
					if (line[i+1] == 'x') i+=4; // skip sequence \xdd
					else i+=2; // skip sequence \c
				}
				else i++; // just a character
				chars++;
			}
			sum += line.Length - chars;
			Console.WriteLine(line + " " + chars);
		}
		Console.WriteLine(sum);
	}
}
