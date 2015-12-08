using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.IO;
using System.Linq;
using System.Text;

public class Day04
{
	public static void Main()
	{
		var key = Console.ReadLine();
		var md5 = MD5.Create();
		var hashes =  // sequence of pairs — number and corresponding md5 hash
			from i in Enumerable.Range(0, int.MaxValue)
			let hash = string.Join("", md5.ComputeHash(Encoding.ASCII.GetBytes(key + i)).Select(b => b.ToString("x2")))
			select new {i, hash};
			
		Console.WriteLine(hashes.First(h => h.hash.StartsWith("000000")).i);
	}
}