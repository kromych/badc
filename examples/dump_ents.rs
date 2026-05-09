//! Diagnostic: walk a compiled program's bytecode, count Op::Ent
//! entries, and group by source-function name to surface c5
//! source-tracking bugs (gh #48).

use badc::{Compiler, Op, Target};
use std::collections::BTreeMap;
use std::fs;
use std::io::Read;

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        eprintln!("usage: dump_ents <source.c> [-D ...]");
        std::process::exit(1);
    }
    let mut src = String::new();
    if args[1] == "-" {
        std::io::stdin().read_to_string(&mut src).unwrap();
    } else {
        src = fs::read_to_string(&args[1]).unwrap();
    }
    // Honour -D flags from argv so we can run against the sqlite
    // amalgamation with the same defines the smoke uses.
    let mut defines: Vec<(String, String)> = Vec::new();
    for arg in args.iter().skip(2) {
        if let Some(d) = arg.strip_prefix("-D") {
            let (name, value) = match d.find('=') {
                Some(i) => (d[..i].to_string(), d[i + 1..].to_string()),
                None => (d.to_string(), "1".to_string()),
            };
            defines.push((name, value));
        }
    }
    let undefines: Vec<String> = Vec::new();
    let include_paths: Vec<String> = Vec::new();
    let force_includes: Vec<String> = Vec::new();
    let program = Compiler::with_full_options(
        src,
        Target::MacOSAarch64,
        &defines,
        &undefines,
        &include_paths,
        &force_includes,
    )
    .compile()
    .unwrap();
    let mut bc = 0usize;
    let mut counts: BTreeMap<String, Vec<usize>> = BTreeMap::new();
    while bc < program.text.len() {
        let raw = program.text[bc];
        let Some(op) = Op::from_i64(raw) else {
            break;
        };
        if matches!(op, Op::Ent) {
            let name = program
                .source_functions
                .get(bc)
                .cloned()
                .unwrap_or_default();
            counts.entry(name).or_default().push(bc);
        }
        bc += op.word_size();
    }
    let mut top: Vec<_> = counts.iter().collect();
    top.sort_by_key(|(_, v)| std::cmp::Reverse(v.len()));
    println!("# Ents grouped by source-function name (top 30):");
    for (name, pcs) in top.iter().take(30) {
        let preview: Vec<String> = pcs.iter().take(5).map(|p| p.to_string()).collect();
        println!(
            "{:>6}  {:?}  bc_pcs[..5] = [{}{}]",
            pcs.len(),
            name,
            preview.join(", "),
            if pcs.len() > 5 { ", ..." } else { "" }
        );
    }
}
