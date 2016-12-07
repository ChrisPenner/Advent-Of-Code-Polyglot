import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

public class part1 {
	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader(new File("input.txt")))) {
			int answer = 0;
			
			boolean[][] lights = new boolean[1000][1000];
			for (String line = br.readLine(); line != null; line = br.readLine()) {
				performAction(lights, line);
			}
			
			for (int i=0; i<1000; i++)
				for(int j=0; j<1000; j++)
					if (lights[i][j])
						answer++;
			// Print the answer.
			System.out.println(answer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Perform the action for the one line.
	 * @param lights The grid of lights. When a position is true, it means that lights is on.
	 * @param line The line with one instruction.
	 */
	private static void performAction(boolean[][] lights, String line) {
		String remainder;
		boolean toggle = line.startsWith("toggle ");
		boolean turnOn = false;
		// Strip the word toggle from the input.
		if (toggle)
			remainder = line.substring(7);
		else {
			turnOn = line.startsWith("turn on ");
			// Strip turn on or turn off from the input.
			if (turnOn)
				remainder = line.substring(8);
			else 
				remainder = line.substring(9);
		}
		int[] vals = getValues(remainder);
		for (int x=vals[0]; x <= vals[2]; x++) {
			for (int y=vals[1]; y <= vals[3]; y++) {
				// We either toggle the light.
				if (toggle)
					lights[x][y] = !lights[x][y];
				else	// Or we turn it on or off.
					lights[x][y] = turnOn;
			}
		}
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