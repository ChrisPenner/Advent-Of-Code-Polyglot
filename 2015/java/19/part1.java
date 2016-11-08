/*
 * Advent of Code day 19. Solution by Erik Schick
 */


import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Scanner;
import java.util.Set;


public class aoc19 {
	
	/**
	 * Puts an item on the HashMap, adds value instead of overwriting
	 */
	private static void putMultiHash(HashMap<String, LinkedList<String>> map, String k, String v) {
		LinkedList<String> list = map.get(k);
		if(list == null) {
			map.put(k, new LinkedList<String>());
		}
		list = map.get(k);
		list.add(v);
	}
	
	private static LinkedList<String> solve(String s, HashMap<String, LinkedList<String>> rules) {
		LinkedList<String> results = new LinkedList<String>();
		LinkedList<String> modifiers;// = rules.get("Ca");
		int current;
		
		for(String k : rules.keySet()) {
			modifiers = rules.get(k);
			for(String mod : modifiers) {
				current = 0;
				while((current = s.indexOf(k, current)) != -1) {
					String pre = s.substring(0, current);
					String post = s.substring(current);
					post = post.replaceFirst(k, mod);
					//System.out.println(pre + "     " + post);
					results.add(pre + post);
					current++;
				}
			}
		}
		return results;
	}
	
	public static void main(String[] args) {
		HashMap<String, LinkedList<String>> rules = new HashMap<String, LinkedList<String>>();
		Scanner sn = new Scanner(System.in);
		String s;
		LinkedList<String> results;
		
		System.out.println("Enter all rules (at once):");
		while(sn.hasNextLine()) {
			s = sn.nextLine();
			if(s.length() < 1) break;
			int middle =  s.indexOf('=');
			putMultiHash(rules, s.substring(0, middle - 1), s.substring(middle + 3));
		}
		
		System.out.println("Enter the molecule:");
		s = sn.nextLine();
		results = solve(s, rules);
		
		System.out.println();
		Set<String> set = new HashSet<String>(results);
		System.out.println(set.size() + " strings with " + (results.size() - set.size()) + " duplicates");
		sn.close();
	}

}
