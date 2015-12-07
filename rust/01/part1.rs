// adventofcode - day 1
// part 1

use std::io::prelude::*;
use std::fs::File;

fn main() {

    let directions = import_data();
    let mut floor = 0i32;

    // we iterate over every character and increment/decrement whenever we hit
    // a ( or ), respectively.
    // any other character will just be ignored
    for token in directions.chars(){
        floor += match token {
            '(' => 1,
            ')' => -1,
            _   => 0
        };
    }

    println!("Deliver it to floor number {}", floor);
}

// This function simply imports the data set from a file called input.txt
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
