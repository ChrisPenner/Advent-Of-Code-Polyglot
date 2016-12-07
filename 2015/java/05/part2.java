import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

public class part2 {
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
		// A nice String must contain a character which repeats with another character inbetween.
		boolean result = false;
		for (int i=0; i<s.length()-2; i++) {
			if (s.charAt(i) == s.charAt(i+2)) {
				result = true;
				break;
			}
		}
		
		// A nice String must contain a pair of characters which repeat.
		if (!result) {
			return false;
		}
		for (int i=0; i<s.length()-3; i++) {
			for (int j=i+2; j<s.length()-1; j++) {
				if (s.charAt(i) == s.charAt(j) && s.charAt(i+1) == s.charAt(j + 1)) {
					return true;
				}
			}
		}
		return false;
	}
}