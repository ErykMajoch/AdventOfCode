import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

class Operation {
  public String command = null;
  public ArrayList<String> args;

  public Operation() {
    args = new ArrayList<String>();
  }

}

class Line {
  public String address = null;
  public Operation op = new Operation();

  final String regex = "(?<lhs>[a-z0-9]+)? ?(?<command>[A-Z]+)? ?(?<rhs>[a-z0-9]+)? -> (?<address>[a-z]+)";
    private final Pattern pattern = Pattern.compile(regex);

  public Line(String str) {
    Matcher matcher = pattern.matcher(str);
    if (matcher.find()) {
      address = matcher.group("address");
      if (matcher.group("command") != null) {
        op.command = matcher.group("command");
      }
      if (matcher.group("lhs") != null) {
        op.args.add(matcher.group("lhs"));
      }
      if (matcher.group("rhs") != null) {
        op.args.add(matcher.group("rhs"));
      }
    }
  }

}

class Seven {

  public HashMap<String, Operation> wires = new HashMap<String, Operation>();
  public HashMap<String, Integer> results = new HashMap<String, Integer>();

  public static void main(String[] args) {
    Seven sols = new Seven();
    
    Integer p1 = sols.simulateCircuit();
    System.out.println("Part one: " + p1);

    sols.wires = new HashMap<String, Operation>();
    sols.results = new HashMap<String, Integer>();

    Line p2 = new Line(p1 + " -> b");
    sols.wires.put(p2.address, p2.op);
    sols.results.put("b", p1);

    System.out.println("Part two: " + sols.simulateCircuit());
  }

  public Integer simulateCircuit() {
    ArrayList<String> lines = loadFile();
    for (String l : lines) {
      Line line = new Line(l);
      wires.put(line.address, line.op);
    }
    return calculatePath("a");
  }

  private Integer calculatePath(String input) {
    try {
      return Integer.parseInt(input);
    } catch (NumberFormatException e) {
      Integer result = null;
      if (results.get(input) == null) {
        Operation current = wires.get(input);

        if (current.command != null) {        
          switch (current.command) {
            case "NOT":
              result = ~calculatePath(current.args.get(0)) & 0xffff; 
              break;
            case "AND":
              result = calculatePath(current.args.get(0)) & calculatePath(current.args.get(1));
              break;
            case "OR":
              result = calculatePath(current.args.get(0)) | calculatePath(current.args.get(1));
              break;
            case "LSHIFT":
              result = calculatePath(current.args.get(0)) << calculatePath(current.args.get(1));
              break;
            case "RSHIFT":
              result = calculatePath(current.args.get(0)) >> calculatePath(current.args.get(1));
              break;
            default:
              break;
          }
        } else {
          result = calculatePath(current.args.get(0));
        }
        results.put(input, result);
      }
      return results.get(input);
    }
  }

  private ArrayList<String> loadFile() {
    ArrayList<String> lines = new ArrayList<String>();
    BufferedReader reader;
    try {
      reader = new BufferedReader(new FileReader("input.txt"));
      String line = reader.readLine();
      while (line != null) {
        lines.add(line);
        line = reader.readLine();
      }
      reader.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
    return lines;
  } 

}

