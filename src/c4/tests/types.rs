//! Type-checking tests -- assignments and call sites should warn (not
//! error) on type mismatches, and a C-style cast should silence the
//! warning. Variadic functions skip type-check past the fixed prefix.

use super::{compile_fixture, run_fixture};

#[test]
fn warn_int_to_pointer_assignment() {
    // `int *p; p = 5;` -- assigning a non-zero integer to a pointer.
    let p = compile_fixture("type_warning_int_to_ptr.c");
    assert!(
        p.warnings
            .iter()
            .any(|w| w.contains("integer assigned to pointer")),
        "expected int-to-ptr warning, got: {:?}",
        p.warnings
    );
}

#[test]
fn cast_silences_int_to_pointer_warning() {
    // Same shape, but with `p = (int *)5;` -- the cast tells the compiler
    // the conversion is intentional, so no warning.
    let p = compile_fixture("type_warning_silenced_by_cast.c");
    assert!(
        p.warnings.is_empty(),
        "expected no warnings, got: {:?}",
        p.warnings
    );
}

#[test]
fn warn_call_arity_mismatch() {
    // `int add(int, int);` called with 1 arg and with 4 args.
    let p = compile_fixture("type_warning_arity.c");
    assert!(
        p.warnings.iter().any(|w| w.contains("too few arguments")),
        "expected too-few warning, got: {:?}",
        p.warnings
    );
    assert!(
        p.warnings.iter().any(|w| w.contains("too many arguments")),
        "expected too-many warning, got: {:?}",
        p.warnings
    );
}

#[test]
fn cast_to_struct_pointer_compiles_and_runs() {
    // `(struct Node *)malloc(...)` -- the cast operator must accept a
    // struct type expression, not only `int`/`char [*]`.
    assert_eq!(run_fixture("cast_to_struct_pointer.c"), 42);
    let p = compile_fixture("cast_to_struct_pointer.c");
    assert!(
        p.warnings.is_empty(),
        "cast should silence the malloc-returns-char* warning, got: {:?}",
        p.warnings
    );
}
