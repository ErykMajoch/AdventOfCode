using System;
using System.IO;

class DayOne {

  static void Main() {
    Console.WriteLine($"Part One: {PartOne()}");
    Console.WriteLine($"Part Two: {PartTwo()}");
  }

  static private int PartOne() {
    int counter = 0;
    foreach (string line in File.ReadLines("input.txt"))
    {
      foreach (char c in line)
      {
          if (c == '(') {
            counter += 1;
          } else if (c == ')')
          {
              counter -= 1;
          }
      }
    }
    return counter;
  }

  static private int PartTwo() {
    int position = 0;
    int counter = 0;
    foreach (string line in File.ReadLines("input.txt"))
    {
      foreach (char c in line)
      {
          position += 1;
          if (c == '(') {
            counter += 1;
          } else if (c == ')')
          {
            counter -= 1;
          } 
          if (counter == -1) {
            break;
          }
      }
    }
    return position;
  }

}
