package main

import (
  "fmt"
  "bufio"
  "os"
  "log"
  "strings"
  "strconv"
  "sort"
)

func main() {
  fmt.Printf("Part one: %d\n", part_one())
  fmt.Printf("Part two: %d\n", part_two())
}

func part_one() int {
  f, err := os.Open("input.txt")
  if err != nil {
    log.Fatal(err)
  }

  defer f.Close()

  count := 0
  scanner := bufio.NewScanner(f)
  for scanner.Scan() {
    raw := strings.Split(scanner.Text(), "x")
    dims := []int{0, 0, 0}
    
    for i := 0; i < 3; i++ {
      a, _ := strconv.Atoi(raw[i])
      b, _ := strconv.Atoi(raw[(i + 1) % 3])
      dims[i] = a * b
    }
    sort.Ints(dims)
    for i, item := range dims {
      if i == 0 {
        count += item
      }
      count += 2 * item
    }
  }

  if err := scanner.Err(); err != nil {
    log.Fatal(err)
  }

  return count

}

func part_two() int {
  f, err := os.Open("input.txt")
  if err != nil {
    log.Fatal(err)
  }

  count := 0
  scanner := bufio.NewScanner(f)
  for scanner.Scan() {
    raw := strings.Split(scanner.Text(), "x")
    dims := []int{0,0,0}
    
    for i, item := range raw {
      val, _ := strconv.Atoi(item)
      dims[i] = val
    }
    sort.Ints(dims)
    count += 2 * dims[0] + 2 * dims[1] + (dims[0] * dims[1] * dims[2])
  }

  if err := scanner.Err(); err != nil {
    log.Fatal(err)
  }

  return count
}

