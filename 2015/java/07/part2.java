import java.io.*;
import java.util.*;

public class part2 {

    private static Hashtable<String, Integer> wireValues = new Hashtable<String, Integer>();
    private static List<String> commands = new ArrayList<String>();

    public static void main(String[] args) {

        //Read File commands into the string
        try {
            File file = new File("input.txt");
            FileReader fileReader = new FileReader(file);
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            String line;

            while ((line = bufferedReader.readLine()) != null) {
                commands.add(line);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        //Part 2
        Integer a = find("a");
        wireValues.clear();
        wireValues.put("b",a);

        System.out.println(find("a"));

    }

    /**
     * Takes search string (wire identifier) and recursively calculates the be
     * @param search
     * @return
     */
    public static int find(String search){

        //return numeric symbol to the receiving wire
        if(search.matches("^-?\\d+$")){
            return (Integer.parseInt(search) & 0xffff);
        }

        for(Iterator<String> i = commands.iterator(); i.hasNext(); ) {

                String command = i.next();
                String [] token = command.split(" ");
                String oWire = token[token.length - 1];
                int result;
                if(oWire.equals(search)){
                    if(wireValues.get(search) != null){
                        return wireValues.get(search);
                    }
                    if (command.contains("RSHIFT")) {
                        result = (find(token[0]) >> Integer.parseInt(token[2]));
                    } else if (command.contains("LSHIFT")) {
                        result = (find(token[0]) << Integer.parseInt(token[2]));
                    } else if (command.contains("OR")) {
                        result = find(token[0]) | find(token[2]);
                    } else if (command.contains("AND")) {
                        result = find(token[0]) & find(token[2]);
                    } else if (command.contains("NOT")) {
                        result = ~find(token[1]);
                    } else {
                        result = find(token[0]);
                    }
                    result = result & 0xffff;

                    wireValues.put(search,result);
                    return result;
                }
            }
        return 1;
    }
}