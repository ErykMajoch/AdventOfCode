use std::fs::read_to_string;
use regex::Regex;

fn main() {
    let result = compute_strings();
    println!("Part one: {}", result.0);
    println!("Part two: {}", result.1);
}

fn compute_strings() -> (u32, u32) {
    let mut diff: u32 = 0;
    let mut encoded_sum: u32 = 0;

    for line in read_file() {
        let line_len: u32 = line.len() as u32;
        let mut result = parse_line(line.clone());
        result = result[1..result.len() - 1].to_string();
        diff += line_len - (result.len() as u32);

        let enc = encode(line.clone());
        encoded_sum += enc - line_len;
    }
    (diff, encoded_sum)
}

fn parse_line(line: String) -> String {
    let rxs = vec![
        (Regex::new(r#"(?m)\\\\"#).unwrap(), "#"),
        (Regex::new(r#"(?m)\\\""#).unwrap(), "~"),
        (Regex::new(r#"(?m)\\x[a-z0-9]{2}"#).unwrap(), "@")
    ];

    let mut binding = line.to_string();
    for tup in rxs.iter() {
        binding = tup.0.replace_all(&*binding, tup.1).to_string();
    }
    binding
}

fn encode(input: String) -> u32 {
    let mut s: String = input.to_string();
    let rxs = vec![
        (Regex::new(r#"(?m)\\"#).unwrap(), "\\\\"),
        (Regex::new(r#"(?m)""#).unwrap(), "\\\""),
    ];
    for tup in rxs.iter() {
        s = tup.0.replace_all(&*s, tup.1).to_string();
    }
    s.len() as u32 + 2
}

fn read_file() -> Vec<String> {
    read_to_string("input.txt")
        .unwrap()
        .lines()
        .map(String::from)
        .collect()
}

