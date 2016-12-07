import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

public class part2 {
	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader(new File("input.txt")))) {
			int answer = 0;
			
			int[][] lights = new int[1000][1000];
			for (String line = br.readLine(); line != null; line = br.readLine()) {
				performAction(lights, line);
			}
			
			for (int i=0; i<1000; i++)
				for(int j=0; j<1000; j++)
					answer += lights[i][j];
				
			// Print the answer.
			System.out.println(answer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Perform the action for the one line.
	 * @param lights The grid of lights. The integer values denote the light intensity.
	 * @param line The line with one instruction.
	 */
	private static void performAction(int[][] lights, String line) {
		String remainder;
		// How much we increase or decrease the lights.
		int difference = 0;
		// Strip the word toggle from the input.
		if (line.startsWith("toggle ")) {
			remainder = line.substring(7);
			difference = 2;
		}
		else {
			// Strip turn on or turn off from the input.
			if (line.startsWith("turn on ")) {
				remainder = line.substring(8);
				difference = 1;
			}
			else {
				remainder = line.substring(9);
				difference = -1;
			}
		}
		int[] vals = getValues(remainder);
		
		// Change the lights.
		// The max is in there to make sure we never drop below 0 intensity.
		for (int x=vals[0]; x <= vals[2]; x++)
			for (int y=vals[1]; y <= vals[3]; y++)
				lights[x][y] = Math.max(0, lights[x][y] + difference);
	}
	
	/**
	 * Gets the integer coordinates from the string after stripping the action to be performed.
	 * the four values are returned in an array.
	 * @param remainder The remainder of a line of input after stripping the command (turn on, turn off or toggle).
	 * @return An array of size 4 with the integer coordinates.
	 */
	private static int[] getValues(String remainder)
	{
		String[] parts = remainder.split(" through ");
		String[] topLeft = parts[0].split(",");
		String[] bottomRight = parts[1].split(",");
		return new int[]{Integer.parseInt(topLeft[0]),
			Integer.parseInt(topLeft[1]),
			Integer.parseInt(bottomRight[0]),
			Integer.parseInt(bottomRight[1])
		};
	}
}