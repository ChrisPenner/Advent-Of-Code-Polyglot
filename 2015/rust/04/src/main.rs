extern crate crypto;

mod part1;
mod part2;

// this file/function is just a wrapper for cargo
// build with: cargo build --release (invoking from the directory where
//   Cargo.toml is located)
// run with: cargo run --release
// NOTE: input.txt has to be in the same directory as Cargo.toml
// note2: --release is necessary because part2 computes roughly 10 million
//   md5-hashes. This is quite slow in debug mode
fn main() {
    part1::run();
    part2::run();
}
