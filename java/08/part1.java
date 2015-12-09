package day8;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class part1 {

	public static void main(String[] args) {

		try (BufferedReader br = new BufferedReader(new FileReader(new File(
				"input.txt")))) {
			String line = null;

			int literalCount = 0;
			int memCount = 0;
			while ((line = br.readLine()) != null) {
				//strip down the first and last chars which are always the quotes
				String memoryString = line.substring(1, line.length() - 1);

				//the double slash has to be treated first. So "\\a" becomes "Sa" and not "\a" which would be IMO more logical. Indented?
				memoryString = memoryString.replace("\\\\", "S");

				String newString1 = memoryString;

				//replace those hex codes with theirs respective values
				for (int i = 0; i < memoryString.length(); i++) {
					if (memoryString.charAt(i) == 'x') {
						String hex = "";
						if (i > 0 && memoryString.charAt(i - 1) == '\\') {
							hex = memoryString.substring(i + 1, i + 3);
							newString1 = newString1.replace("\\x" + hex,
									convertHexToString(hex));
						}
					}
				}
				//replace other escape chars to simple chars
				String newString2 = newString1;
				for (int i = 0; i < newString1.length(); i++) {
					if (newString1.charAt(i) == '\\') {
						newString2 = newString1.replace(
								newString1.substring(i, i + 2),
								newString1.substring(i + 1, i + 2));
					}
				}

				literalCount += line.length();
				memCount += newString2.length();
			}
			
			System.out.println(literalCount - memCount);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * hex => integer, integer => char, char => string.
	 * Credit to http://www.mkyong.com/java/how-to-convert-hex-to-ascii-in-java/
	 * @param hex
	 * @return its string
	 */
	static public String convertHexToString(String hex) {
		StringBuilder sb = new StringBuilder();
		int decimal = Integer.parseInt(hex, 16);
		sb.append((char) decimal);
		return sb.toString();
	}
}
