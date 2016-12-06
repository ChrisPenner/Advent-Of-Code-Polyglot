import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class part2 {
	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader(new File("input.txt")))) {
			int answer = 0;
			for (String line = br.readLine(); line != null; line = br.readLine()) {
				answer += getLength(line);
			}
			
			// Print the answer.
			System.out.println(answer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Returns the required length of ribbon for a present.
	 * @param line The line describing the dimensions of the present.
	 * @return The total length of ribbon required to wrap the present.
	 */
	public static int getLength(String line) {
		// Split the line into the three numbers that represent the length, height and width.
		String[] sidesStrings = line.split("x");
		
		// Parse the sides as integers.
		int[] sides = new int[3];
		for (int i=0; i<3; i++) {
			sides[i] = Integer.parseInt(sidesStrings[i]);
		}
		
		// The smallest perimeter is the perimeter along the two smallest sides.
		// We first calculate the sum of all sides and we subtract the largest side.
		// Multiplying it by two because the ribbon goes along both the front and back side.
		int perimeter = 2*(sides[0]+sides[1]+sides[2]-Math.max(sides[0], Math.max(sides[1], sides[2])));
		int bow = sides[0]*sides[1]*sides[2];
		return perimeter + bow;
	}
}