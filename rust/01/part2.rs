// adventofcode - day 1
// part 2

use std::io::prelude::*;
use std::fs::File;

fn main() {

    let directions = import_data();
    let mut floor = 0i32;
    let mut counter = 0i32;

    // we iterate over every character and increment/decrement whenever we hit
    // a ( or ), respectively.
    // any other character will just be ignored
    // additionally we count the characters we already observed
    for token in directions.chars(){
        counter += 1;
        floor += match token {
            '(' => 1,
            ')' => -1,
            _   => 0
        };

        // everytime we enter the basement we'll print it
        // for the solution, we just have to enter the first number printed
        if floor == -1 {
            println!("Basement entered @ char {}", counter);
        }
    }

    println!("Deliver it to floor number {}", floor);
}

fn import_data() -> String {
    let mut file = match File::open("input.txt") {
        Ok(f) => f,
        Err(e) => panic!("file error: {}", e),
    };

    let mut directions = String::new();
    match file.read_to_string(&mut directions){
        Ok(_) => {},
        Err(e) => panic!("file error: {}", e),
    };

	directions
}
