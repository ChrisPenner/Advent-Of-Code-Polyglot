import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashSet;

public class part2 {
	public static void main(String[] args) {
		try (BufferedReader br = new BufferedReader(new FileReader(new File("input.txt")))) {
			int answer = getAnswer(br.readLine());
			
			// Print the answer.
			System.out.println(answer);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Returns the number needed for the AdventCoin.
	 * @param line The secret key needed for mining the AdventCoin.
	 * @return The number needed for the AdventCoin.
	 */
	public static int getAnswer(String line) throws NoSuchAlgorithmException {
		for (int i=0; ;i++) {
			String hash = md5(line + i);
			// We have found the result!
			if (hash.startsWith("000000")) {
				return i;
			}
		}
	}
	
	/**
	 * Calculates the MD5 hash of a string and returns it as a hexadecimal string.
	 * @param text The text to hash.
	 * @return The hash as a hexadecimal string.
	 * @throws NoSuchAlgorithmException
	 */
	public static String md5(String text) throws NoSuchAlgorithmException 
	{
		MessageDigest digest = MessageDigest.getInstance("MD5");
		byte[] bytes = digest.digest(text.getBytes());
		StringBuilder sb = new StringBuilder();
		for (byte b : bytes)
		{
			int unsigned = Byte.toUnsignedInt(b);
			sb.append(toHex(unsigned/16));
			sb.append(toHex(unsigned%16));
		}
		return sb.toString();
	}

	/**
	 * Takes an integer from 0 to 15 and returns the corresponding hexadecimal character.
	 * @param val The value to convert.
	 * @return The hexadecimal character corresponding to the value.
	 */
	private static char toHex(int val)
	{
		if (val >= 16 || val < 0)
			throw new IllegalArgumentException("Value must be between 0 and 15.");
		if (val < 10)
			return (char)(val + '0');
		else return (char)(val - 10 + 'a');
	}
}