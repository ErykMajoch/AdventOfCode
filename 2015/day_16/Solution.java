import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.function.Predicate;

public class Solution {
    private static final Pattern aunt_regex = Pattern.compile("Sue (?<id>\\d+): (\\w+): (\\d+), (\\w+): (\\d+), (\\w+): (\\d+)");
    private static final HashMap<String, Integer> static_values = new HashMap<>();
    private static final HashMap<String, Predicate<Integer>> range_values = new HashMap<>();

    static {
        static_values.put("children", 3);
        static_values.put("cats", 7);
        static_values.put("samoyeds", 2);
        static_values.put("pomeranians", 3);
        static_values.put("akitas", 0);
        static_values.put("vizslas", 0);
        static_values.put("goldfish", 5);
        static_values.put("trees", 3);
        static_values.put("cars", 2);
        static_values.put("perfumes", 1);
    }

    static {
        range_values.put("children", value -> value == 3);
        range_values.put("cats", value -> value > 7);
        range_values.put("samoyeds", value -> value == 2);
        range_values.put("pomeranians", value -> value < 3);
        range_values.put("akitas", value -> value == 0);
        range_values.put("vizslas", value -> value == 0);
        range_values.put("goldfish", value -> value < 5);
        range_values.put("trees", value -> value > 3);
        range_values.put("cars", value -> value == 2);
        range_values.put("perfumes", value -> value == 1);
    }

    public static void main(String[] args) {
        System.out.println("Part one: " + partOne());
        System.out.println("Part two: " + partTwo());
    }

    static private ArrayList<String> parseFile() {
        ArrayList<String> lines = new ArrayList<String>();
        try {
            BufferedReader reader = new BufferedReader(new FileReader("input.txt")); 
            String line = reader.readLine();
            while (line != null) {
                lines.add(line);
                line = reader.readLine();
            }
            reader.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return lines;
    }

    private static int partOne() {
        ArrayList<String> lines = parseFile();
        for (String line : lines) {
            Matcher matcher = aunt_regex.matcher(line);
            if (matcher.find()) {
                if (static_values.get(matcher.group(2)) == Integer.parseInt(matcher.group(3)) &&
                    static_values.get(matcher.group(4)) == Integer.parseInt(matcher.group(5)) &&
                    static_values.get(matcher.group(6)) == Integer.parseInt(matcher.group(7)))
                {
                    return Integer.parseInt(matcher.group("id"));
                }
            }
        }
        return -1;
    }

    private static int partTwo() {
        ArrayList<String> lines = parseFile();
        for (String line : lines) {
            Matcher matcher = aunt_regex.matcher(line);
            if (matcher.find()) {
                if (range_values.get(matcher.group(2)).test(Integer.parseInt(matcher.group(3))) &&
                    range_values.get(matcher.group(4)).test(Integer.parseInt(matcher.group(5))) &&
                    range_values.get(matcher.group(6)).test(Integer.parseInt(matcher.group(7))))
                {
                    return Integer.parseInt(matcher.group("id"));
                }
            }
        }
        return -1;
    }

}
