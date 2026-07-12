//! Type-checking tests -- assignments and call sites should warn (not
//! error) on type mismatches, and a C-style cast should silence the
//! warning. Variadic functions skip type-check past the fixed prefix.

use super::{compile_fixture, compile_str, run_fixture};

/// C99 6.4.4.4p11: a wide character constant (`L'x'`) has type `wchar_t`,
/// whose width the target fixes -- 2 bytes on Windows (UTF-16) and 4 on
/// the Unix targets, matching the `<stddef.h>` typedef. A narrow
/// character constant keeps type `int` (6.4.4.4p10) on every target. The
/// SSA interpreter is target-independent, so a program compiled for any
/// target folds its `sizeof` against that target's widths.
#[test]
fn wide_char_constant_has_target_wchar_width() {
    use super::Vm;
    use crate::Compiler;
    use crate::Target;
    let run = |src: &str, t: Target| -> i64 {
        Vm::new(Compiler::with_target(src.to_string(), t).compile().unwrap())
            .run()
            .unwrap()
    };
    let wide = "int main(void){ return (int)sizeof(L'A'); }";
    assert_eq!(
        run(wide, Target::WindowsX64),
        2,
        "sizeof(L'A') is 2 on Windows"
    );
    assert_eq!(run(wide, Target::LinuxX64), 4, "sizeof(L'A') is 4 on Unix");
    let narrow = "int main(void){ return (int)sizeof('A'); }";
    assert_eq!(run(narrow, Target::WindowsX64), 4, "sizeof('A') is 4 (int)");
    // The value is unaffected: `L'A'` is 65 and promotes for arithmetic.
    let val = "int main(void){ return L'A' == 65 ? 7 : 0; }";
    assert_eq!(run(val, Target::WindowsX64), 7, "L'A' keeps its value");
}

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
fn warn_return_type_mismatch() {
    // `return <expr>;` whose type doesn't match the function return
    // type warns like an assignment (C99 6.8.6.4p3).
    let p = compile_fixture("type_warning_return.c");
    let has = |needle: &str| p.warnings.iter().any(|w| w.contains(needle));
    assert!(
        has("pointer assigned to integer in return"),
        "expected ptr-returned-as-int warning, got: {:?}",
        p.warnings
    );
    assert!(
        has("integer assigned to pointer in return"),
        "expected int-returned-as-ptr warning, got: {:?}",
        p.warnings
    );
    assert!(
        has("incompatible struct types in return"),
        "expected incompatible-struct return warning, got: {:?}",
        p.warnings
    );
    // The NULL idiom and a matching return stay silent.
    assert!(
        !has("ret_null") && !has("ret_ok"),
        "unexpected warning on a well-typed return: {:?}",
        p.warnings
    );
}

#[test]
fn call_without_return_prototype_warns_implicit_int() {
    use crate::{Compiler, Target};
    // A `#pragma binding` seen without an accompanying prototype leaves
    // the callee's return type at the implicit `int` default. A call
    // warns once: the result truncates to 32 bits if the function really
    // returns a pointer or wider type. Target-fixed so the bound dylib
    // name (`libc`) is the same regardless of the host.
    let src = "#pragma dylib(libc, \"libc.so.6\")\n\
               #pragma binding(libc::mystery, \"getenv\")\n\
               int main(void) { return mystery(\"PATH\") ? 0 : 1; }\n";
    let p = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    assert!(
        p.warnings
            .iter()
            .any(|w| w.contains("mystery") && w.contains("without a return-type prototype")),
        "expected implicit-int warning, got: {:?}",
        p.warnings
    );
}

#[test]
fn call_with_return_prototype_is_silent() {
    use crate::{Compiler, Target};
    // Declaring the return type clears the implicit-`int` default, so
    // the same call produces no warning.
    let src = "#pragma dylib(libc, \"libc.so.6\")\n\
               #pragma binding(libc::mystery, \"getenv\")\n\
               char *mystery(char *name);\n\
               int main(void) { return mystery(\"PATH\") ? 0 : 1; }\n";
    let p = Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .unwrap();
    assert!(
        !p.warnings.iter().any(|w| w.contains("mystery")),
        "expected no warning for a prototyped binding, got: {:?}",
        p.warnings
    );
}

#[test]
fn shadowing_fnptr_param_does_not_clobber_signature() {
    // A prototype whose fn-ptr parameter reuses a bound library
    // function's name must not replace that function's recorded
    // signature: a later 1-arg `exit(0)` would otherwise be checked
    // against the parameter's own prototype (C99 6.2.1p4).
    let p = compile_str(
        "struct Obj { int x; };\n\
         void takes(void (*exit)(struct Obj *o, int code));\n\
         int main(void) { exit(0); }\n",
    );
    assert!(
        !p.warnings.iter().any(|w| w.contains("exit")),
        "shadowed `exit` signature leaked, got: {:?}",
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

/// Per-store dead-store analysis: when `-Wdead-store` is on, each
/// store whose value never reaches a read fires a `dead store:
/// value assigned to X is never read` diagnostic at the store's
/// source line. Off by default; the per-symbol `set but never
/// used` warning still fires unconditionally.
#[test]
fn warn_dead_store_per_store_when_enabled() {
    use crate::CompileOptions;
    use crate::Compiler;
    use crate::Target;
    let src = super::with_prelude(&super::load_fixture("warn_dead_store.c"));
    let opts = CompileOptions::default().with_warn_dead_store(true);
    let p = Compiler::with_options(src, Target::host(), opts)
        .compile()
        .unwrap();
    let dead: alloc::vec::Vec<&String> = p
        .warnings
        .iter()
        .filter(|w| w.contains("dead store:"))
        .collect();
    // `int a = 1; a = 2; return 1;` -> both stores dead.
    let a_warns: alloc::vec::Vec<&&String> = dead.iter().filter(|w| w.contains("`a`")).collect();
    assert_eq!(
        a_warns.len(),
        2,
        "expected two dead-store warnings on `a` (initializer + a = 2;), got: {:?}",
        dead
    );
    // No false positives: branch-straddling, self-referencing
    // RHS, and address-escape cases must not fire.
    for w in &dead {
        assert!(
            !w.contains("`b`") && !w.contains("`c`") && !w.contains("`d`"),
            "unexpected dead-store warning: {w}"
        );
    }
}

#[test]
fn warn_dead_store_off_by_default() {
    let p = compile_fixture("warn_dead_store.c");
    let dead: alloc::vec::Vec<&String> = p
        .warnings
        .iter()
        .filter(|w| w.contains("dead store:"))
        .collect();
    assert!(
        dead.is_empty(),
        "dead-store warnings should not fire without -Wdead-store: {:?}",
        dead
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
