// adventofcode - day 2
// part 1

use std::io::prelude::*;
use std::fs::File;
use std::vec::Vec;

fn main(){
    println!("Adventofcode - day 2 | part 1");

    let content = import_data();

    let mut paper = 0u32;
    for line in content.lines(){
        let dimensions: Vec<&str> = line.split('x').collect();

        let l = str_to_u32(dimensions[0]);
        let w = str_to_u32(dimensions[1]);
        let h = str_to_u32(dimensions[2]);

	    paper += calc_paper( l, w, h );
    }

    println!("Total: {} square feet of wrapping paper", paper);
}

fn calc_paper(l: u32, w: u32, h: u32) -> u32 {

    // the extra paper we need is calculated by multiplying the two smallest
    // numbers with each other. Therefore, we look for the greatest number and
    // simply multiply the others.
    let extra = if l > w {
        if l > h {
            h * w
        } else {
            l * w
        }
    } else {
        if w > h {
            l * h
        } else {
            l * w
        }
    };

    // the rest is simply multiplying and adding stuff
    return extra + 2*l*w + 2*w*h + 2*l*h;
}

// converts a String to an unsigned int
fn str_to_u32(string: &str) -> u32 {
    match string.parse::<u32>(){
        Ok(x) => x,
        Err(_) => panic!("Failed to convert String to u32!"),
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
