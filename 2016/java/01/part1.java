import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.lang.Math;

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
		String[] instructions = line.split(", ");
		
		// We use a vector for keeping track of our location.
		Vector location = new Vector(0, 0);
		// We use another vector for keeping track of the direction we are facing.
		// Positive y is North, positive x is west.
		Vector direction = new Vector(0, 1);
		
		for (String instruction : instructions) {
			// Read in the seperate parts of each instruction.
			char turnDirection = instruction.charAt(0);
			int distance = Integer.parseInt(instruction.substring(1));
			
			// Turn the direction vector.
			if (turnDirection == 'R')
				direction = direction.rotateRight();
			else
				direction = direction.rotateLeft();
			
			// Move the location forward in the direction we are facing by the distance specified in the input.
			location = location.plus(direction.multiply(distance));
		}
		return location.getManhattanLength();
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
		 * Returns a new vector corresponding to this vector turned right 90 degrees.
		 * @return A new vector corresponding to this vector turned right. 
		 */
		public Vector rotateRight() {
			return new Vector(y, -x);
		}
		
		/**
		 * Returns a new vector corresponding to this vector turned left 90 degrees.
		 * @return A new vector corresponding to this vector turned left. 
		 */
		public Vector rotateLeft() {
			return new Vector(-y, x);
		}
		
		/**
		 * Returns a new vector which is the sum of this vector and the vector provided to this method.
		 * @param other The vector we want to add to this one.
		 * @return A new vector which is the sum of this vector and the one provided to this method.
		 */
		public Vector plus(Vector other) {
			return new Vector(x + other.x, y + other.y);
		}
		
		/**
		 * Returns a new vector which is this vector multiplied by the value provided to this method.
		 * @param multiplier The value by which we will multuply this vector.
		 * @return A new vector which is this vector multiplied by the value provided to this method.
		 */
		public Vector multiply(int multiplier) {
			return new Vector(multiplier * x, multiplier * y);
		}
		
		/**
		 * Returns the Manhattan distance from the origin (0, 0) to this vector.
		 * @return the Manhattan distance from the origin (0, 0) to this vector.
		 */
		public int getManhattanLength() {
			return Math.abs(x) + Math.abs(y);
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