// adventofcode - day 5
// part 1

use std::io::prelude::*;
use std::fs::File;


fn main(){
    println!("Advent of Code - day 5 | part 1");

    // import data
    let wordlist = import_data();

    let mut nice_words = 0i32;
    for word in wordlist.lines(){
        if ! contains_bad_strings(word)
                && contains_three_vowels(word)
                && contains_double_letters(word) {
            nice_words += 1;
        }
    }

    println!("There are {} nice words in Santas list.", nice_words);
}

fn contains_bad_strings(word: &str) -> bool {
    let bad_strings = vec!["ab", "cd", "pq", "xy"];

    for bad_string in bad_strings {
        if word.contains(bad_string) {
            return true;
        }
    }

    false
}

fn contains_three_vowels(word: &str) -> bool {

    let mut vowel_count = 0i32;
    for letter in word.chars() {
        vowel_count += match letter {
            'a' | 'e' | 'i' | 'o' | 'u' => 1,
            _   => 0,
        }
    }

    vowel_count >= 3
}

fn contains_double_letters(word: &str) -> bool {

    let mut last_letter = '\x00';
    for letter in word.chars(){
        last_letter = match letter == last_letter {
            true => return true,
            false => letter,
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
