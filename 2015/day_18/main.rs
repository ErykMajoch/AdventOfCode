use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    match load_input("input.txt") {
        Ok(array) => {
            println!("Part One: {}", part_one(array, 100));
            println!("Part Two: {}", part_two(array, 100));
        },
        Err(e) => eprintln!("Error loading file: {}", e)
    }
}

fn part_one(input: [[char; 102]; 102], steps: u32) -> usize {
    let mut current = input;

    for _ in 0..steps {
        let mut buffer = [['.'; 102]; 102];
        for y in 1..=100 {
            for x in 1..=100 {
                let count = (-1..=1)
                    .flat_map(|dy| (-1..=1).map(move |dx| (dx, dy)))
                    .filter(|&(dx, dy)| dx != 0 || dy != 0)
                    .filter(|&(dx, dy)| current[(y as i32 + dy) as usize][(x as i32 + dx) as usize] == '#')
                    .count();

                buffer[y][x] = match (current[y][x], count) {
                    ('#', 2) | ('#', 3) | ('.', 3) => '#',
                    _ => '.',
                };
            }
        }
        current = buffer;
    }

    current.iter().flatten().filter(|&&cell| cell == '#').count()
}

fn part_two(input: [[char; 102]; 102], steps: u32) -> usize {
    let mut current = input;
    
    for _ in 0..steps {
        current[1][1] = '#';
        current[1][100] = '#';
        current[100][1] = '#';
        current[100][100] = '#';
        let mut buffer = [['.'; 102]; 102];
        for y in 1..=100 {
            for x in 1..=100 {
                let count = (-1..=1)
                    .flat_map(|dy| (-1..=1).map(move |dx| (dx, dy)))
                    .filter(|&(dx, dy)| dx != 0 || dy != 0)
                    .filter(|&(dx, dy)| current[(y as i32 + dy) as usize][(x as i32 + dx) as usize] == '#')
                    .count();

                buffer[y][x] = match (current[y][x], count) {
                    ('#', 2) | ('#', 3) | ('.', 3) => '#',
                    _ => '.',
                };
            }
        }
        buffer[1][1] = '#';
        buffer[1][100] = '#';
        buffer[100][1] = '#';
        buffer[100][100] = '#';
        current = buffer;
    }

    current.iter().flatten().filter(|&&cell| cell == '#').count()
}

fn load_input(filename: &str) -> Result<[[char; 102]; 102], std::io::Error> {
    let file = File::open(filename)?;
    let reader = BufReader::new(file);
    let mut char_array = [['.'; 102]; 102];

    for (row, line) in reader.lines().enumerate() {
        if row >= 100 {
            break;
        }

        let line = line?;
        for (col, ch) in line.chars().enumerate() {
            if col >= 100 {
                break;
            }
            char_array[row + 1][col + 1] = ch;
        }
    }

    Ok(char_array)
}

