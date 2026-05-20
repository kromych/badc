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

/// C99 6.2.4 + 6.2.2: block-scope locals, function parameters,
/// and `static` file-scope functions that are never referenced
/// are dead. The compiler emits a `<file>:<line>: warning:
/// unused ...` line for each, in the same shape as the
/// type-mismatch warnings above. Names whose first character is
/// `_` are suppressed by convention.
#[test]
fn warn_unused_variable_parameter_function() {
    let p = compile_fixture("warn_unused_symbols.c");
    let names_warned: alloc::vec::Vec<&str> = p
        .warnings
        .iter()
        .filter_map(|w| {
            let backtick = w.find('`')?;
            let end = w[backtick + 1..].find('`')?;
            Some(&w[backtick + 1..backtick + 1 + end])
        })
        .collect();
    let expect = [
        "dead_static",
        "unused_arg",
        "unused_local",
        "main_unused",
        "main_unused_init",
        "inner_unused",
        "dead_assigned",
        "touched_then_overwritten",
    ];
    for name in expect {
        assert!(
            names_warned.contains(&name),
            "expected warning for `{name}`, got: {:?}",
            p.warnings
        );
    }
    let suppress = [
        "live_static",
        "x",
        "used_local",
        "_silenced_local",
        "_silenced",
        "used",
        "main",
        "inner_used",
    ];
    for name in suppress {
        assert!(
            !names_warned.contains(&name),
            "did not expect warning for `{name}`, got: {:?}",
            p.warnings
        );
    }
    let set_but_unused: alloc::vec::Vec<&String> = p
        .warnings
        .iter()
        .filter(|w| w.contains("set but never used"))
        .collect();
    assert!(
        set_but_unused.iter().any(|w| w.contains("`dead_assigned`")),
        "expected `set but never used` for dead_assigned, got: {:?}",
        p.warnings
    );
    assert!(
        set_but_unused
            .iter()
            .any(|w| w.contains("`touched_then_overwritten`")),
        "expected `set but never used` for touched_then_overwritten, got: {:?}",
        p.warnings
    );
}

/// `typedef HANDLE *PHANDLE;` with no prior `HANDLE` typedef
/// must error at the declaration site, not silently default
/// to `int *`.
#[test]
fn unknown_type_name_is_a_compile_error() {
    use crate::Compiler;
    let result = Compiler::new("typedef HANDLE *PHANDLE; int main(void) { return 0; }".to_string())
        .compile();
    let err = result.expect_err("expected an error for unknown `HANDLE`");
    let msg = format!("{err:?}");
    assert!(
        msg.contains("unknown type name `HANDLE`"),
        "expected `unknown type name`, got: {msg}"
    );
}

/// `HANDLE x;` at file scope must error rather than declare
/// `x` as `int`.
#[test]
fn unknown_base_type_in_global_decl_is_an_error() {
    use crate::Compiler;
    let result = Compiler::new("HANDLE x;".to_string()).compile();
    let err = result.expect_err("expected an error for unknown `HANDLE`");
    let msg = format!("{err:?}");
    assert!(
        msg.contains("unknown type name `HANDLE`"),
        "expected `unknown type name`, got: {msg}"
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
