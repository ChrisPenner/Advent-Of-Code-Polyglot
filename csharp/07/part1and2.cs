using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Sprache;

namespace ac
{
	//Deferred and cached calculation. With clear cache ability.
	class Val
	{
		private int val;
		private readonly Func<int> calculate;
		private readonly bool cache;

		public Val(Func<int> calculate, bool cache = true)
		{
			this.calculate = calculate;
			this.cache = cache;
		}

		public bool Calculated;

		public int Value
		{
			get
			{
				if (Calculated && cache) return val;
				Calculated = true;
				return val = calculate();
			}
		}
	}
	class Program
	{
		public static Dictionary<string, Val> ParseWires(IEnumerable<string> lines)
		{
			//Parser construction
			//See Sprache project for detals https://github.com/sprache/Sprache
			var wires = new Dictionary<string, Val>();
			var valueParser = Parse.Number.Select(s => new Val(() => int.Parse(s)));
			var nameParser = Parse.Identifier(Parse.Letter, Parse.Letter);
			var refParser = nameParser.Select(s => new Val(() => wires[s].Value, false));
			var argParser = valueParser.Or(refParser);
			var notRule = from not in Parse.String("NOT").Token()
						  from arg in argParser
						  select new Val(() => (~arg.Value) & 65535);
			var binOpParser =
						from a in argParser
						from op in Parse.Letter.Many().Text().Token()
						from b in argParser
						select new Val(() => BinOp(op, a.Value, b.Value) & 65535);
			var exprParser = notRule.Or(binOpParser).Or(argParser);
			var wireParser =
				from r in exprParser
				from arrow in Parse.String("->").Token()
				from name in nameParser
				select new { name, expr = r };
			var parsedWires = lines
				.Select(line => wireParser(new Input(line)))
				.Select(parsed => parsed.Value);
			foreach (var wire in parsedWires)
				wires[wire.name] = wire.expr;
			return wires;
		}

		private static int BinOp(string op, int a, int b)
		{
			if (op == "AND") return a & b;
			else if (op == "OR") return a | b;
			else if (op == "LSHIFT") return a << b;
			else if (op == "RSHIFT") return a >> b;
			throw new NotSupportedException(op);
		}

		static void Main()
		{
			var lines = File.ReadAllLines("input.txt");
			var wires = ParseWires(lines);
			var aValue = wires["a"].Value;
			Console.WriteLine("Part 1: " + aValue);
			// Clear the cache of calculated values
			foreach (var name in wires.Keys)
				wires[name].Calculated = false;
			wires["b"] = new Val(() => aValue);
			Console.WriteLine("Part 2: " + wires["a"].Value);

		}
	}
}
