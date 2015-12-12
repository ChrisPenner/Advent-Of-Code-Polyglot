using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.IO;
using System.Linq;
using System.Text;

public class Day05
{
	public static void Main()
	{
		var words = Enumerable.Range(0, int.MaxValue)
			.Select(i => Console.ReadLine()).TakeWhile(s => s!=null).ToList();

		var niceWords = words.Where(w => 
			w.Skip(1).Where((c, i) => w.LastIndexOf(w.Substring(i, 2)) > i+1).Any()
			&& q.Zip(w.Skip(2), (c1, c2) => c1 == c2)).Any()
			);
		Console.WriteLine(niceWords.Count());
	}
}