import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class part2 {

	public static void main(String[] args) {
		int literalCount = 0;
		int treatedCount = 0;
		String line;
		StringBuilder sb = null;
		try (BufferedReader br = new BufferedReader(new FileReader(new File(
				"input.txt")))) {
			while ((line = br.readLine()) != null) {
				sb = new StringBuilder(line);
				literalCount += sb.length();
				// for every escape char we append a slash before it
				for (int i = 0; i < sb.length(); i++) {
					char c = sb.charAt(i);
					if (c == '"' || c == '\\') {
						// we use the StringBuilder to insert the slash into it
						// and we add 1 to i because the string has a new char
						// in it
						sb.replace(i, i + 1, "\\" + c);
						i++;
					}
				}
				// +2 because the final string is surrounded again by quotes
				treatedCount += sb.length() + 2;
			}
			System.out.println(treatedCount - literalCount);

		} catch (IOException e) {

		}

	}
}
