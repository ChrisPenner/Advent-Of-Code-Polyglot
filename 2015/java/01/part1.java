import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class part1 {
	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader(new File("input.txt")))) {
			String line = br.readLine();
			int answer = getAnswer(line);
			
			// Print the answer.
			System.out.println(answer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static int getAnswer(String line) {
		int result = 0;
		// Go through the input, one characetr at a time.
		for (int i=0; i<line.length(); i++) {
			// We add 1 to the result when we encounter an opening bracket.
			if (line.charAt(i) == '(')
				result++;
			else	// Otherwise we encountered a closing bracket and subtract 1.
				result--;
		}
		return result;
	}
}