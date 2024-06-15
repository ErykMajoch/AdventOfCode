package main

import (
  "fmt"
  "os"
  "strings"
  "strconv"
  "regexp"
)

type Reindeer struct {
  name              string
  speed             int
  flying_time       int
  rest_duration     int
  resting           bool
  current_rest_time int
  current_run_time  int
}

func (reindeer *Reindeer) step() int {
  if reindeer.resting {
    reindeer.current_rest_time += 1
    if reindeer.current_rest_time == reindeer.rest_duration {
      reindeer.resting = false
      reindeer.current_rest_time = 0
    }
    return 0
  } else {
    reindeer.current_run_time += 1
    if reindeer.current_run_time == reindeer.flying_time {
      reindeer.resting = true
      reindeer.current_run_time = 0
    }
    return reindeer.speed
  }
}

func main() {
  best_distance, most_points := simulate_race()
  fmt.Printf("Part one: %d\n", best_distance)
  fmt.Printf("Part two: %d\n", most_points)
}

func simulate_race() (int, int) {
  reindeers := parse_file()
  racetrack := make(map[*Reindeer]int)
  points := make(map[*Reindeer]int)
  
  max_distance := 0

  for i := 0; i < 2503; i++ {
    for _, reindeer := range reindeers {
      racetrack[reindeer] += reindeer.step()
    }
    
    for _, distance := range racetrack {
      max_distance = max(max_distance, distance)
    }

    for name, distance := range racetrack {
      if distance == max_distance {
        points[name] += 1;
      } 
    }
  }

  max_points := 0
  for _, points := range points {
    max_points = max(max_points, points)
  }

  return max_distance, max_points
}

func parse_file() map[string]*Reindeer {
  b, err := os.ReadFile("input.txt")
  if err != nil {
    fmt.Print(err)
  }
  lines := strings.Split(string(b), "\n")
  reindeers := make(map[string]*Reindeer)
  re := regexp.MustCompile(`(?m)(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds\.`)

  for _, line := range lines {
    if line == "" {
      continue
    }

    values := re.FindStringSubmatch(line)
    
    name := values[1]
    speed, _ := strconv.Atoi(values[2])
    flying, _ := strconv.Atoi(values[3])
    resting, _ := strconv.Atoi(values[4])

    reindeers[name] = &Reindeer{
      name: name,
      speed: speed,
      flying_time: flying,
      rest_duration: resting,
      resting: false,
      current_rest_time: 0,
      current_run_time: 0,
    }
  }

  return reindeers
} 

