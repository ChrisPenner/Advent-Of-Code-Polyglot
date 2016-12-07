import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class part1 {
	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader(new File("input.txt")))) {
			int answer = 0;
			for (String line = br.readLine(); line != null; line = br.readLine()) {
				answer += getArea(line);
			}
			
			// Print the answer.
			System.out.println(answer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Returns the required area of wrapping paper for a present.
	 * @param line The line describing the dimensions of the present.
	 * @return The total area of wrapping paper required to wrap the present.
	 */
	public static int getArea(String line) {
		// Split the line into the three numbers that represent the length, height and width.
		String[] sidesStrings = line.split("x");
		
		// Parse the sides as integers.
		int[] sides = new int[3];
		for (int i=0; i<3; i++) {
			sides[i] = Integer.parseInt(sidesStrings[i]);
		}
		
		// We start by finding the smallest side.
		int answer = Math.min(sides[0]*sides[1], Math.min(sides[1]*sides[2], sides[0]*sides[2]));
		// There are three different sizes of sides, each of which occur twice.
		for (int i=0; i<3; i++)
			answer += sides[i]*sides[(i+1)%3]*2;
		return answer;
	}
}