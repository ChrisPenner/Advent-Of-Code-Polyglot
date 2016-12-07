import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

public class part1 {
	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader(new File("input.txt")))) {
			int answer = 0;
			
			for (String line = br.readLine(); line != null; line = br.readLine()) {
				if (isNice(line)) {
					answer++;
				}
			}
			
			// Print the answer.
			System.out.println(answer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Determine whether a given string s is nice.
	 * @param s The string for which we want to determine whether it is nice.
	 * @return True if the string is nice, false otherwise.
	 */
	private static boolean isNice(String s) {
		// A nice string must not contain ab, cd, pq or xy.
		if (s.contains("ab")) {
			return false;
		}
		if (s.contains("cd")) {
			return false;
		}
		if (s.contains("pq")) {
			return false;
		}
		if (s.contains("xy")) {
			return false;
		}
		
		// A nice string must contain a repeating character.
		boolean result = false;
		for (int i=0; i<s.length()-1; i++) {
			if (s.charAt(i) == s.charAt(i+1)) {
				result = true;
				break;
			}
		}
		if (!result) {
			return false;
		}

		// A nice string must contain at least 3 vowels.
		int vowels = 0;
		for (int i=0; i<s.length(); i++) {
			char c = s.charAt(i);
			if ("aeiou".contains(c + "")) {
				vowels++;
			}
		}
		
		return vowels >= 3;
	}
}