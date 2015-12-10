// adventofcode - day 5
// part 2

use std::io::prelude::*;
use std::fs::File;


fn main(){
    println!("Advent of Code - day 5 | part 2");

    // import data
    let wordlist = import_data();

    let mut nice_words = 0i32;
    for word in wordlist.lines(){
        if contains_repeating_letter(word.to_string())
                && contains_pair(word.to_string()) {
            nice_words += 1;
        }
    }

    println!("There are {} nice words in Santas list.", nice_words);
}

fn contains_repeating_letter(word: String) -> bool {

    for ii in 0..word.len() - 2 {
        if word[ii] == word[ii+2] {
            return true;
        }
    }

    false
}

fn contains_pair(word: String) -> bool {

    for ii in 0..word.len() - 1 {
        let pair = &word[ii..ii+2];
        let remainder = &word[ii+2..word.len()];

        if remainder.contains(pair) {
            return true;
        }
    }

    false
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
