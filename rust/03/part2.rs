// adventofcode - day 3
// part 2

use std::io::prelude::*;
use std::fs::File;
use std::collections::HashMap;

#[derive(Hash, Eq, PartialEq, Debug)]
struct Point {
    x: i32,
    y: i32,
}

impl Point {
    fn new(x: i32, y: i32) -> Point {
        Point { x: x, y: y }
    }
}

fn main(){
    println!("Advent of Code - day 3 | part 2");

    // import data
    let steps = import_data();

    // we'll use a HasMap to keep track of the points (used as keys in the map)
    // we already visited -> Every point can only be stored once. Therefore, at
    // the end we can simply read out the number of stored locations
    let mut visited = HashMap::new();
    let mut santa = Point::new(0,0);
    let mut robo_santa = Point::new(0, 0);
    let mut robos_turn = false;

    visited.insert( Point::new(0, 0), true );
    for step in steps.chars(){

        if robos_turn {
            match step {
                '>' => robo_santa.x += 1,
                '<' => robo_santa.x += -1,
                '^' => robo_santa.y += 1,
                'v' => robo_santa.y += -1,
                _ => {},
            }

            visited.insert( Point::new(robo_santa.x, robo_santa.y), true);
        } else {
            // santas turn
            match step {
                '>' => santa.x += 1,
                '<' => santa.x += -1,
                '^' => santa.y += 1,
                'v' => santa.y += -1,
                _ => {},
            }

            visited.insert( Point::new(santa.x, santa.y), true);
        }

        robos_turn = !robos_turn;
    }

    println!("Santa and Robo-Santa visited {} unique houses", visited.len() );
}

// This function simply imports the data set from a file called input.txt
fn import_data() -> String {
    let mut file = match File::open("input.txt") {
        Ok(f) => f,
        Err(e) => panic!("file error: {}", e),
    };

    let mut data = String::new();
    match file.read_to_string(&mut data){
        Ok(_) => {},
        Err(e) => panic!("file error: {}", e),
    };

	data
}
