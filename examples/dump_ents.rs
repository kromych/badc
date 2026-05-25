use badc::{Compiler, Op, Target};
use std::fs;

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let src = fs::read_to_string(&args[1]).unwrap();
    let program = Compiler::with_target(src, Target::MacOSAarch64)
        .compile()
        .unwrap();
    println!("# program.text.len() = {}", program.text.len());
    println!(
        "# program.source_functions.len() = {}",
        program.source_functions.len()
    );
    println!("# program.entry_pc = {}", program.entry_pc);
    println!("# Ents in order:");
    let mut bc = 0usize;
    while bc < program.text.len() {
        let raw = program.text[bc];
        let Some(op) = Op::from_i64(raw) else { break };
        if matches!(op, Op::Ent) {
            let name = program
                .source_functions
                .get(bc)
                .cloned()
                .unwrap_or_default();
            println!("  bc={:>5}: name={:?}", bc, name);
        }
        bc += op.word_size();
    }
}
