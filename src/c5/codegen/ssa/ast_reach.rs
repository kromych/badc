//! AST-level function reachability ahead of the walk: the [`ReachGraph`]
//! the SSA liveness solves, with each function's edges read off its AST.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use super::shadow::{Node, ReachGraph};
use crate::c5::ast::{Expr, ExprId, FinishedFunction};
use crate::c5::irgen::{
    GloAddr, binding_defined_here, glo_ident_addr, live_fun_addr_val, live_fun_val,
};
use crate::c5::program::Program;
use crate::c5::symbol::Symbol;
use crate::c5::token::Token;

/// The functions a root of `program` reaches: the set the walk lowers.
pub(crate) fn reachable_functions(program: &Program) -> BTreeSet<usize> {
    let graph = ReachGraph::new(program, &[]);
    let by_ent: BTreeMap<usize, &FinishedFunction> = program
        .finished_functions
        .iter()
        .map(|f| (f.ent_pc, f))
        .collect();
    let defined = by_ent.keys().copied().collect();
    let (funcs, _) = graph.solve(&defined, None, false, |pc, work| {
        if let Some(f) = by_ent.get(&pc) {
            body_edges(&graph, &program.symbols, f, work);
        }
    });
    funcs
}

/// Every node the body of `f` can reference. The arenas are read whole, so no
/// node kind or field hides one; an unevaluated operand's identifiers count.
fn body_edges(graph: &ReachGraph, symbols: &[Symbol], f: &FinishedFunction, work: &mut Vec<Node>) {
    let ast = &f.ast;
    ast.data_offsets(|off| work.extend(graph.data(off)));
    for (id, e) in ast.exprs.iter().enumerate() {
        let Expr::Ident {
            sym,
            class,
            val,
            is_thread_local,
            ..
        } = *e
        else {
            continue;
        };
        if class == Token::Glo as i64 {
            if !is_thread_local
                && let GloAddr::Resolved(off) = glo_ident_addr(symbols, ast, id as ExprId, sym, val)
            {
                work.extend(graph.data(off));
            }
        } else if class == Token::Fun as i64 || binding_defined_here(symbols, sym, class) {
            // A call names the body, an inline definition's address the import.
            work.push(Node::Func(live_fun_val(symbols, sym, val) as usize));
            work.push(Node::Func(live_fun_addr_val(symbols, sym, val) as usize));
        }
    }
    for block in &ast.asm_blocks {
        graph.asm_names(&block.block.template, work);
    }
}

#[cfg(test)]
mod tests {
    use super::super::shadow::{
        compute_live_sets, dropped_live_functions, produce_ssa_funcs, walk_program,
    };
    use super::reachable_functions;
    use crate::c5::Target;
    use crate::c5::compiler::Compiler;

    fn lowered(src: &str, target: Target) -> Result<alloc::vec::Vec<alloc::string::String>, ()> {
        let opts = crate::c5::compiler::CompileOptions::default().with_no_entry_point(true);
        let program = Compiler::with_options(src.into(), target, opts)
            .compile()
            .expect("compile");
        produce_ssa_funcs(&program, target, false, true)
            .map(|funcs| funcs.into_iter().map(|f| f.name).collect())
            .map_err(|_| ())
    }

    fn walked_names(src: &str, target: Target) -> alloc::vec::Vec<alloc::string::String> {
        lowered(src, target).expect("walk")
    }

    #[test]
    fn an_asm_template_keeps_the_function_its_assembler_name_names() {
        for (target, template) in [
            (Target::LinuxAarch64, "adr %x0, renamed_target"),
            (Target::LinuxX64, "lea renamed_target(%%rip), %0"),
        ] {
            let src = alloc::format!(
                "static int foo(void) __asm__(\"renamed_target\");\n\
                 static int foo(void) {{ return 7; }}\n\
                 void *addr_of_target(void) {{ void *p; __asm__(\"{template}\" : \"=r\"(p)); return p; }}\n"
            );
            let names = walked_names(&src, target);
            assert!(
                names.iter().any(|n| n == "renamed_target"),
                "{target:?}: {names:?}"
            );
        }
    }

    #[test]
    fn an_alias_spelling_the_assembler_name_keeps_its_target() {
        let names = walked_names(
            "static int impl(void) __asm__(\"impl_asm\");\n\
             static int impl(void) { return 9; }\n\
             int pub(void) __attribute__((weak, alias(\"impl_asm\")));\n",
            Target::LinuxX64,
        );
        assert!(names.iter().any(|n| n == "impl_asm"), "{names:?}");
    }

    #[test]
    fn an_overflow_builtin_result_pointer_keeps_what_it_reaches() {
        let names = walked_names(
            "static long sink;\n\
             static long *where(void) { return &sink; }\n\
             static int helper(int x) { return x + 1; }\n\
             int (*volatile fp)(int);\n\
             int f(long a) { return __builtin_add_overflow(a, 41L, (fp = helper, where())); }\n",
            Target::LinuxX64,
        );
        for want in ["where", "helper"] {
            assert!(names.iter().any(|n| n == want), "{want}: {names:?}");
        }
    }

    /// A walk error fails the compile only for a live function: a root or a callee.
    #[test]
    fn a_walk_error_fails_the_compile_only_for_a_live_function() {
        let f = "typedef struct { long a, b; } pair;\n\
                 static _Atomic pair shared;\n\
                 static pair f(void) { return __atomic_load_n(&shared, 5); }\n";
        let external = f.replacen("static pair f", "pair f", 1);
        for target in [Target::LinuxX64, Target::LinuxAarch64] {
            for (user, live) in [
                ("int g(void) { return sizeof(f()); }", false),
                ("int g(void) { if (0) return f().a; return 0; }", false),
                ("long g(void) { return f().a; }", true),
            ] {
                let src = alloc::format!("{f}{user}\n");
                assert_eq!(lowered(&src, target).is_err(), live, "{target:?}: {user}");
            }
            assert!(lowered(&external, target).is_err(), "{target:?}");
        }
    }

    /// The AST set holds what the liveness keeps over an unpruned walk, -O0 and -O.
    #[test]
    fn ast_reachability_keeps_what_the_unpruned_walk_keeps() {
        let dir = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/c");
        let mut names: alloc::vec::Vec<alloc::string::String> = std::fs::read_dir(&dir)
            .expect("fixtures")
            .filter_map(|e| e.ok()?.file_name().into_string().ok())
            .filter(|n| n.ends_with(".c"))
            .collect();
        names.sort();
        let corpus: alloc::vec::Vec<(&str, ())> = names.iter().map(|n| (n.as_str(), ())).collect();
        let checked = core::sync::atomic::AtomicUsize::new(0);
        let target = Target::host();
        let failures = crate::c5::tests::parity_failures(&corpus, |name, _| {
            let src = crate::c5::tests::with_prelude(&crate::c5::tests::load_fixture(name));
            // A fixture this host rejects has no walk to compare.
            let program = Compiler::with_target(src, target).compile().ok()?;
            let reachable = reachable_functions(&program);
            let every = program
                .finished_functions
                .iter()
                .map(|f| f.ent_pc)
                .collect();
            for optimize in [false, true] {
                let (funcs, failed) = walk_program(&program, target, optimize, true, &every);
                let unwalked = failed.iter().map(|&(pc, _)| pc).collect();
                let live = compute_live_sets(&funcs, &unwalked, &program, false, None).func_pcs;
                if failed.iter().any(|(pc, _)| live.contains(pc)) {
                    return None;
                }
                let dropped = dropped_live_functions(&program, &reachable, &live);
                if !dropped.is_empty() {
                    return Some(alloc::format!("{name} (optimize {optimize}): {dropped:?}"));
                }
            }
            checked.fetch_add(1, core::sync::atomic::Ordering::Relaxed);
            None
        });
        assert!(
            failures.is_empty(),
            "the AST reachability dropped functions the SSA liveness keeps:\n  {}",
            failures.join("\n  ")
        );
        let checked = checked.into_inner();
        assert!(
            checked * 2 > corpus.len(),
            "{checked} of {} fixtures compared",
            corpus.len()
        );
    }
}
