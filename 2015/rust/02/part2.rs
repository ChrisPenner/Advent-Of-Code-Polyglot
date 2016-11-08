// adventofcode - day 2
// part 2

use std::io::prelude::*;
use std::fs::File;
use std::vec::Vec;

fn main(){
    println!("Adventofcode - day 2 | part 2");

    let content = import_data();

    let mut ribbon = 0u32;
    for line in content.lines(){
        let dimensions: Vec<&str> = line.split('x').collect();

        let l = str_to_u32(dimensions[0]);
        let w = str_to_u32(dimensions[1]);
        let h = str_to_u32(dimensions[2]);

        ribbon += calc_ribbon( l, w, h );
    }

    println!("Total: {} feet of ribbon required", ribbon);
}

fn calc_ribbon(l: u32, w: u32, h: u32) -> u32 {

    // bow is easy to calculate
    let bow = l * w * h;

    // same procedure as in part 1: we look for the largest value and use
    // the other both to calculate the result
    let ribbon = if l > w {
        if l > h {
            2 * h + 2 * w
        } else {
            2 * l + 2 * w
        }
    } else {
        if w > h {
            2 * l + 2 * h
        } else {
            2 * l + 2 * w
        }
    };

    return ribbon + bow;
}

fn str_to_u32(string: &str) -> u32 {
    match string.parse::<u32>(){
        Ok(x) => x,
        Err(_) => panic!("Halp meh!"),
    }
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
