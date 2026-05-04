//! End-to-end optimizer tests: every fixture in `programs.rs` must
//! produce the same exit code with `-O` as without. If a peephole or
//! DCE rewrite changes observable behavior, this is where it surfaces.
//!
//! We also assert `optimized.text.len() <= original.text.len()` for
//! each fixture -- the passes are size-preserving by construction, so a
//! growth here means a bug in the encoder (e.g. failing to skip
//! `Removed` slots).

use super::{compile_fixture, run_optimized_fixture, run_optimized_fixture_with_args};
use crate::optimize;

/// Cases mirror the assertions in `programs.rs` exactly. When you add
/// a new fixture there, add it here too.
const FIXTURES: &[(&str, i64)] = &[
    ("arithmetic.c", 60),
    ("goto.c", 5),
    ("function_pointers.c", 150),
    ("switch_statement.c", 25),
    ("switch_default_routing.c", 100),
    ("control_flow.c", 1),
    ("do_while.c", 5),
    ("break_continue.c", 4),
    ("for_loop.c", 10),
    ("recursion_factorial.c", 120),
    ("pointers.c", 200),
    ("nested_function_calls.c", 100),
    ("printf.c", 0),
    ("memory_ops.c", 0),
    ("pointer_arithmetic_scaling.c", 108),
    ("expression_precedence.c", 1),
    ("variable_shadowing.c", 10),
    ("pointer_arithmetic.c", 3),
    ("memset_mcmp.c", 42),
    ("memcpy_basic.c", 'A' as i64),
    ("shebang.c", 7),
    ("sizeof_basic.c", 0),
    ("sizeof_expr.c", 0),
    ("sizeof_with_write.c", 24),
    ("struct_basic.c", 25),
    ("struct_linked_list.c", 10),
    ("struct_sizeof.c", 0),
    ("adjacent_strings.c", 'f' as i64),
    ("predefined_constants.c", 0),
    ("c99_qualifiers.c", 0),
    ("integer_suffixes.c", 0),
    ("predefined_macros.c", 0),
    ("macro_operators.c", 0),
    ("typedef_basic.c", 0),
    ("local_init_and_block_scope.c", 0),
    ("arrays_basic.c", 0),
    ("function_pointer_typedefs.c", 0),
    ("unions_basic.c", 0),
    ("array_initializers.c", 0),
    ("struct_initializers.c", 0),
    ("enum_tag_types.c", 0),
    ("bitfields.c", 0),
    ("static_locals.c", 0),
    ("quicksort.c", 0),
    ("linked_list.c", 10),
    ("binary_search_tree.c", 0),
    ("bst_free.c", 0),
    ("double_pointers.c", 0),
    ("cast_to_struct_pointer.c", 42),
];

#[test]
fn optimizer_preserves_fixture_exit_codes() {
    for (name, expected) in FIXTURES {
        let got = run_optimized_fixture(name);
        assert_eq!(
            got, *expected,
            "fixture {name} regressed under -O: got {got}, expected {expected}"
        );
    }
}

#[test]
fn optimizer_never_grows_text() {
    for (name, _) in FIXTURES {
        let original = compile_fixture(name);
        let original_len = original.text.len();
        let opt = optimize(original).expect("optimize failed");
        assert!(
            opt.text.len() <= original_len,
            "fixture {name}: optimized text grew from {} to {}",
            original_len,
            opt.text.len()
        );
    }
}

#[test]
fn optimizer_actually_shrinks_typical_fixtures() {
    // Pick a few fixtures with obvious folding / fusion opportunities
    // and assert that the optimizer made the text strictly smaller.
    // These all contain `i + 1`-style loops or constant arithmetic.
    let shrinkers = [
        "arithmetic.c",
        "for_loop.c",
        "expression_precedence.c",
        "recursion_factorial.c",
    ];
    for name in shrinkers {
        let original = compile_fixture(name);
        let original_len = original.text.len();
        let opt = optimize(original).expect("optimize failed");
        assert!(
            opt.text.len() < original_len,
            "fixture {name}: expected -O to shrink text, got {} -> {}",
            original_len,
            opt.text.len()
        );
    }
}

#[test]
fn optimizer_handles_c4_self_host() {
    // The big one -- c4.c parsing hello.c. Optimization must not break
    // self-host compilation; this is the canonical end-to-end check.
    let exit = run_optimized_fixture_with_args(
        "c4.c",
        ["c4.c", concat!(env!("CARGO_MANIFEST_DIR"), "/hello.c")],
    );
    assert_eq!(exit, 0);
}
