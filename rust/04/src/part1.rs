// adventofcode - day 04
// part 1

// required for File operations
use std::io::prelude::*;
use std::fs::File;

use crypto::md5::Md5;
use crypto::digest::Digest;

// part1's main function
pub fn run(){
    let mut input = import_data();
    // remove the trailing '\n'
    input.pop();

    let mut md5 = Md5::new();

    for number in 1.. {
        let mut new_string = input.clone();
        new_string.push_str( &*number.to_string() );
        let data = new_string.as_bytes();

        md5.input( data );
        let hash = md5.result_str();

        if hash.starts_with("00000") {
            println!("Data: {} -> {}", new_string, hash);
            break;
        }

        md5.reset();
    }
}

// This function simply imports the data set from a file called input.txt
fn import_data() -> String {
    let mut file = match File::open("./input.txt") {
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
