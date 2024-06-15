use std::fs;
use std::error::Error;
use serde_json::Value;

fn read_file() -> Result<String, Box<dyn Error>> {
    let file: String = fs::read_to_string("input.txt")?;
    Ok(file)
}

fn to_json(file: String) -> Result<Value, Box<dyn Error>> {
    Ok(serde_json::from_str(&*file)?)
}

fn part_one(value: &Value) -> i64 {
    match value {
        Value::Number(n) => n.as_i64().unwrap(),
        Value::Array(arr) => arr.iter().map(part_one).sum(),
        Value::Object(obj) => obj.values().map(part_one).sum(),
        _ => 0
    }
}

fn part_two(value: &Value) -> i64 {
    match value {
        Value::Number(n) => n.as_i64().unwrap(),
        Value::Array(arr) => arr.iter().map(part_two).sum(),
        Value::Object(obj) => {
            let mut sum: i64 = 0;
            for value in obj.values() {
                if let Value::String(value) = value {
                    if value == "red" {
                        return 0;
                    }
                }
                sum += part_two(value)
            }
            sum
        },
        _ => 0
    }
}

fn main() {
    let file = match read_file() {
        Ok(f) => {
            match to_json(f) {
                Ok(v) => {v},
                Err(e) => {panic!("{}", e)}
            }
        },
        Err(e) => {panic!("{}", e)}
    };
    println!("Part one: {}", part_one(&file));
    println!("Part two: {}", part_two(&file));
}

