use badc::{Compiler, Op, Target};
use std::collections::BTreeMap;
use std::fs;

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let src = fs::read_to_string(&args[1]).unwrap();
    let mut defines: Vec<(String, String)> = Vec::new();
    for arg in args.iter().skip(2) {
        if let Some(d) = arg.strip_prefix("-D") {
            let (n, v) = match d.find('=') {
                Some(i) => (d[..i].to_string(), d[i + 1..].to_string()),
                None => (d.to_string(), "1".to_string()),
            };
            defines.push((n, v));
        }
    }
    let program = Compiler::with_options(
        src,
        Target::MacOSAarch64,
        badc::CompileOptions::default().with_defines(defines),
    )
    .compile()
    .unwrap();

    // Find sqlite3ExprAffinity in source_functions
    let mut bc = 0usize;
    let mut ent_pcs_for_ea: Vec<usize> = Vec::new();
    while bc < program.text.len() {
        let raw = program.text[bc];
        let Some(op) = Op::from_i64(raw) else { break };
        if matches!(op, Op::Ent) {
            let name = program
                .source_functions
                .get(bc)
                .cloned()
                .unwrap_or_default();
            if name == "sqlite3ExprAffinity" {
                ent_pcs_for_ea.push(bc);
            }
        }
        bc += op.word_size();
    }
    println!("sqlite3ExprAffinity Ent bc_pcs: {:?}", ent_pcs_for_ea);
    let mut by_pc: BTreeMap<u64, Vec<&badc::VariableInfo>> = BTreeMap::new();
    for v in &program.variables {
        by_pc.entry(v.function_bc_pc).or_default().push(v);
    }
    for &p in &ent_pcs_for_ea {
        let vs = by_pc.get(&(p as u64)).map(|v| v.len()).unwrap_or(0);
        println!("  bc_pc {}: {} variables", p, vs);
    }
}
