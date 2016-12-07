import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class part2 {
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
		int floor = 0;
		// Go through the input, one characetr at a time.
		for (int i=0; i<line.length(); i++) {
			if (line.charAt(i) == '(')
				floor++;
			else
				floor--;
			
			// This is the first time the floor goes below 0, so we have our answer.
			// We have to add one because the variable i starts at 0 instead of 1.
			if (floor == -1)
				return i + 1;
		}
		return -1;
	}
}