import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

public class part1 {
	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader(new File("input.txt")))) {
			int answer = getVisited(br.readLine());
			
			// Print the answer.
			System.out.println(answer);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Returns the total number of visited houses.
	 * @param line The line describing directions in which to move.
	 * @return The total number of visited houses.
	 */
	public static int getVisited(String line) {
		// We keep track of our position as a vector.
		Vector position  = new Vector(0, 0);
		// We keep a set with all the houses we have visited.
		HashSet<Vector> visited = new HashSet<Vector>();
		visited.add(position);
		
		for (char c : line.toCharArray()) {
			// We move our position in the right direction.
			switch (c) {
				case ('^'):
					position = position.up();
					break;
				case ('v'):
					position = position.down();
					break;
				case ('<'):
					position = position.left();
					break;
				case ('>'):
					position = position.right();
					break;
				default:
					throw new RuntimeException("Invalid input character: " + c);
			}
			// Since this is a set, the position will only be added if it isn't already in the set.
			visited.add(position);
		}
		// We return how many different houses we have visited.
		return visited.size();
	}

	/**
	 * This class represents a two dimensional geometric vector.
	 */
	private static class Vector {
		private int x, y;
		
		/**
		 * This class represents a two dimensional geometric vector.
		 * @param x The x coordinate of this vector.
		 * @param y The y coordinate of this vector.
		 */
		public Vector(int x, int y) {
			this.x = x;
			this.y = y;
		}
		
		/**
		 * The x coordinate of this vector.
		 * @return The x coordinate of this vector.
		 */
		public int getX() {
			return x;
		}
		
		/**
		 * The y coordinate of this vector.
		 * @return The y coordinate of this vector.
		 */
		public int getY() {
			return y;
		}
		
		/**
		 * Returns a new vector corresponding to one unit above this vector.
		 * @return A new vector corresponding to one unit above this vector.
		 */
		public Vector up() {
			return new Vector(x, y-1);
		}
		
		/**
		 * Returns a new vector corresponding to one unit below this vector.
		 * @return A new vector corresponding to one unit below this vector.
		 */
		public Vector down() {
			return new Vector(x, y+1);
		}
		
		/**
		 * Returns a new vector corresponding to one unit to the left of this vector.
		 * @return A new vector corresponding to one unit to the left of this vector.
		 */
		public Vector left() {
			return new Vector(x-1, y);
		}
		
		/**
		 * Returns a new vector corresponding to one unit to the right of this vector.
		 * @return A new vector corresponding to one unit to the right of this vector.
		 */
		public Vector right() {
			return new Vector(x+1, y);
		}
		
		@Override
		public boolean equals(Object other) {
			if (!(other instanceof Vector))
				return false;
			// We now know that we are dealing with another Vector object, so we can cast it.
			Vector otherVector = (Vector)other;
			return x == otherVector.x && y == otherVector.y;
		}
		
		@Override
		public int hashCode() {
			return x + 179 * y;
		}
	}
}