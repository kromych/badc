//! Compile-error / diagnostic tests. Each case feeds a small malformed
//! snippet through the full compiler and asserts the error contains the
//! expected substring (so we don't pin exact wording of line numbers).

use super::Compiler;

fn expect_compile_error(src: &str, needle: &str) {
    match Compiler::new(src.to_string()).compile() {
        Err(e) => {
            let msg = e.to_string();
            assert!(
                msg.contains(needle),
                "expected error containing {:?}, got {:?}",
                needle,
                msg,
            );
        }
        Ok(_) => panic!(
            "expected compile error containing {:?}, but compile succeeded",
            needle
        ),
    }
}

#[test]
fn empty_source_has_no_main() {
    expect_compile_error("", "main() not defined");
}

#[test]
fn source_with_only_a_global_has_no_main() {
    expect_compile_error("int x;", "main() not defined");
}

#[test]
fn bare_return_in_non_void_function_is_rejected() {
    // C23 6.8.6.4 + current toolchains: `return;` with no value in a
    // function returning non-void. C99 leaves the value indeterminate
    // (6.9.1p12).
    expect_compile_error(
        "int f(int x) { if (x) return x; return; } int main(void) { return f(0); }",
        "`return` with no value in a function returning non-void",
    );
}

#[test]
fn bare_return_in_void_function_is_allowed() {
    // The converse stays legal: `return;` in a `void` function.
    Compiler::new(
        "void g(int x) { if (x) return; } int main(void) { g(1); return 0; }".to_string(),
    )
    .compile()
    .expect("bare return in a void function must compile");
}

#[test]
fn fall_off_end_of_non_void_function_warns() {
    // C99 6.9.1p12: control reaching the closing brace of a
    // value-returning function with no `return value;` leaves the value
    // indeterminate. This is undefined behavior if the result is used,
    // not a constraint violation, so it is a warning (matching gcc /
    // clang) and the codegen synthesizes a `return 0`.
    let prog = crate::c5::Compiler::new(
        "int f(int x) { if (x) return x; } int main(void) { return f(1); }".to_string(),
    )
    .compile()
    .expect("a fall-off-end non-void function compiles with a warning");
    assert!(
        prog.warnings
            .iter()
            .any(|w| w.contains("control reaches end of non-void function")),
        "expected a fall-off-end warning, got {:?}",
        prog.warnings,
    );
}

#[test]
fn fall_off_end_with_both_if_arms_returning_is_allowed() {
    // Every path returns, so control cannot reach the end.
    Compiler::new(
        "int f(int x) { if (x) return 1; else return 0; } \
         int main(void) { return f(1); }"
            .to_string(),
    )
    .compile()
    .expect("a function whose if/else both return must compile");
}

#[test]
fn fall_off_end_after_noreturn_call_is_allowed() {
    // A call to a `_Noreturn` function does not reach its continuation,
    // so a function whose last statement is such a call does not fall
    // off its end.
    Compiler::new(
        "_Noreturn void die(void); \
         int f(int x) { if (x) return x; die(); } \
         int main(void) { return f(1); }"
            .to_string(),
    )
    .compile()
    .expect("a function ending in a _Noreturn call must compile");
}

#[test]
fn fall_off_end_of_infinite_loop_is_allowed() {
    // `for (;;)` with no break never reaches the end.
    Compiler::new("int f(void) { for (;;) { } } int main(void) { f(); return 0; }".to_string())
        .compile()
        .expect("a function whose body is an infinite loop must compile");
}

#[test]
fn fall_off_end_of_main_is_allowed() {
    // C99 5.1.2.2.3: `main` returns 0 by default, so it is exempt.
    Compiler::new("int main(void) { }".to_string())
        .compile()
        .expect("main may fall off its end");
}

#[test]
fn missing_semicolon_after_statement() {
    expect_compile_error(
        "int main() { int a; a = 1 return a; }",
        "semicolon expected",
    );
}

#[test]
fn duplicate_global_definition() {
    // Two defining declarations -- both have an initializer -- must
    // fail. The tentative-definition merge (`int x; int x = 5;`) is
    // now allowed; only an actual redefinition with conflicting
    // initializers trips the duplicate check.
    expect_compile_error(
        "int x = 1; int x = 2; int main() { return 0; }",
        "duplicate global definition",
    );
}

#[test]
fn prototype_after_definition_at_pc_zero() {
    // A prototype following a function definition used to
    // clobber the symbol's val (= ent_pc) when val happened
    // to be 0 -- exactly the case for the *first* function in
    // the source. The reset would point every later call site
    // at the buffer's current pc, sending the call to a stale
    // address. Pin the fix.
    let src = "int foo_fn(int x) { return x + 1; } \
               int foo_fn(int x); \
               int main() { return foo_fn(41); }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    let vm_result = crate::c5::Vm::new(prog).run().unwrap();
    assert_eq!(vm_result, 42);
}

#[test]
fn redeclaration_with_different_signature_warns() {
    // C99 6.7p4 requires redeclarations to be compatible. badc
    // doesn't refuse them (the codegen only sees one declaration
    // at a time), but it surfaces the disagreement as a single
    // warning that prints both shapes, so amalgamated multi-TU
    // builds don't silently end up with mismatched signatures
    // across the boundary. The shape is one line per redecl plus
    // two indented `previous:` / `now:` lines.
    // Plain `char`'s signedness is host-dependent (C99 6.2.5p15; see
    // `Target::plain_char_signed`), and `Compiler::new` compiles for
    // the host target. The return-type-mismatch case prints `char` on
    // signed-char hosts and `unsigned char` on aarch64-Linux.
    let char_now = if super::super::codegen::Target::default_target().plain_char_signed() {
        "now:      char (int)"
    } else {
        "now:      unsigned char (int)"
    };
    for (src, prev_needle, now_needle) in &[
        // Different return type.
        (
            "int f(int x) { return x; } char f(int x); int main() { return 0; }",
            "previous: int (int)",
            char_now,
        ),
        // Different parameter list.
        (
            "int f(int x); int f(int x, int y) { return x + y; } int main() { return 0; }",
            "previous: int (int)",
            "now:      int (int, int)",
        ),
        // Differs in variadicity.
        (
            "int f(int x); int f(int x, ...) { return x; } int main() { return 0; }",
            "previous: int (int)",
            "now:      int (int, ...)",
        ),
    ] {
        let prog = crate::c5::Compiler::new((*src).to_string())
            .compile()
            .unwrap();
        assert!(
            prog.warnings
                .iter()
                .any(|w| w.contains(prev_needle) && w.contains(now_needle)),
            "no warning containing `{prev_needle}` + `{now_needle}` for {src:?}; got {:?}",
            prog.warnings,
        );
    }
}

#[test]
fn matching_redeclaration_is_silent() {
    // The amalgamator (scripts/amalgamate.py) glues TUs that
    // typically include the same prototype many times via shared
    // headers. Repeats with identical signatures must not
    // produce noise.
    let src = "int f(int x); int f(int x); int f(int x) { return x; } int main() { return f(7); }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    assert!(
        prog.warnings.is_empty(),
        "matching redecl should be silent, got {:?}",
        prog.warnings,
    );
    assert_eq!(crate::c5::Vm::new(prog).run().unwrap(), 7);
}

#[test]
fn undeclared_identifier_in_initializer_errors() {
    // C99 6.5.1: an identifier must be declared before use. An undeclared
    // identifier as an initializer element (a missing header or a typo) is
    // rejected, not bound to a placeholder that resolves to a silent zero.
    let src = "typedef void (*fp)(void); fp t[] = { undeclared_xyz }; int main(void) { return 0; }";
    let err = crate::c5::Compiler::new(src.to_string()).compile();
    assert!(
        err.is_err(),
        "expected a compile error for the undeclared initializer element",
    );
    // A function declared by a prior prototype and defined later in the same
    // unit is a valid forward reference (C99 6.7p7) and compiles silently.
    let ok = "typedef int (*fp)(void); int fwd(void); fp t[] = { fwd }; \
              int fwd(void) { return 0; } int main(void) { return 0; }";
    let prog = crate::c5::Compiler::new(ok.to_string()).compile().unwrap();
    assert!(
        prog.warnings.is_empty(),
        "valid forward reference should be silent, got {:?}",
        prog.warnings,
    );
}

#[test]
fn tentative_definition_merge() {
    // `int x;` + `int x = 5;` -- the prior declaration is tentative
    // (no initializer); the second one supplies the initializer.
    // Allowed by C11 6.9.2; amalgamated translation units rely
    // on this when each `#include`-ed unit re-emits the same
    // tentative-then-defined globals.
    let src = "int x; int x = 5; int main() { return x; }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    let vm_result = crate::c5::Vm::new(prog).run().unwrap();
    assert_eq!(vm_result, 5);
}

#[test]
fn duplicate_parameter_definition() {
    expect_compile_error(
        "int f(int a, int a) { return a; } int main() { return 0; }",
        "duplicate parameter definition",
    );
}

#[test]
fn undefined_variable_used_in_expression() {
    expect_compile_error(
        "int main() { return missing; }",
        "undefined variable missing",
    );
}

#[test]
fn sizeof_rejects_undeclared_identifier() {
    // C99 6.5.3.4 admits two operand shapes: a parenthesized
    // type-name and a unary-expression. The unary-expression path
    // folds back to 6.5.1p2, which requires every primary
    // identifier to be declared. Prior to the fix the bare-id
    // shortcut in `sizeof_expr.rs` read `Symbol::type_` directly
    // for any `Token::Id` operand, so an undeclared name silently
    // resolved to `Symbol::default()` (type_ = `Ty::Char` = 0) and
    // `sizeof(undeclared)` evaluated to 1 instead of erroring.
    expect_compile_error(
        "int main() { return sizeof(no_such_type); }",
        "undefined variable no_such_type",
    );
}

#[test]
fn sizeof_in_array_dim_rejects_undeclared_identifier() {
    // Same constraint surfacing through a constant-expression
    // `sizeof` (C99 6.6 + 6.7.6.2): the array-dimension parser
    // runs `parse_constant_int` -> `sizeof_operand_bytes`. An
    // undeclared operand must fail there, not silently fold to
    // the `Ty::Char` placeholder size and produce a positive
    // dimension or a confusing "array dimension must be positive"
    // downstream message.
    expect_compile_error(
        "int main() { char x[sizeof(no_such_type) == 1 ? 1 : -1]; return 0; }",
        "undefined variable no_such_type",
    );
}

#[test]
fn break_outside_loop() {
    expect_compile_error(
        "int main() { break; return 0; }",
        "break outside of loop or switch",
    );
}

#[test]
fn continue_outside_loop() {
    expect_compile_error(
        "int main() { continue; return 0; }",
        "continue outside of loop",
    );
}

#[test]
fn unresolved_goto_label() {
    expect_compile_error("int main() { goto nowhere; return 0; }", "unresolved label");
}

#[test]
fn missing_close_paren_in_if() {
    expect_compile_error("int main() { if (1 return 0; }", "close paren expected");
}

#[test]
fn missing_open_paren_after_while() {
    expect_compile_error("int main() { while 1) return 0; }", "open paren expected");
}

#[test]
fn bad_lvalue_in_assignment() {
    expect_compile_error(
        "int main() { 1 = 2; return 0; }",
        "bad lvalue in assignment",
    );
}

// Emits a native image for every target, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn thread_local_compiles_to_op_tlslea() {
    // `_Thread_local` lexes as Token::ThreadLocal, the parser
    // accepts it as a global storage-class prefix, the symbol
    // carries the flag, and reads/writes route through the TLS
    // segment rather than the regular data segment. The
    // contract surfaces through `Program::tls_data` (parser-side
    // slot allocation) and through the per-target codegen
    // accepting the lowered form below; a regression that
    // collapses the access onto the data segment trips one of
    // those gates.
    let src = "_Thread_local int counter;\n\
               int main() { counter = 42; return counter; }";
    let p = super::Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile failed");
    assert_eq!(p.tls_data.len(), 8, "single 8-byte TLS slot");
    // Every supported target now lowers `_Thread_local`. Linux
    // and Windows have full code paths; macOS arm64 routes
    // through the Mach-O `__thread_vars` + `__tlv_bootstrap`
    // pipeline.
    for target in [
        super::super::codegen::Target::LinuxAarch64,
        super::super::codegen::Target::LinuxX64,
        super::super::codegen::Target::WindowsX64,
        super::super::codegen::Target::WindowsAarch64,
        super::super::codegen::Target::MacOSAarch64,
    ] {
        super::super::codegen::emit_native_single_tu_for_test(
            &p,
            target,
            super::super::NativeOptions::default(),
        )
        .unwrap_or_else(|e| panic!("`{target:?}` rejected `_Thread_local`: {e}"));
    }
}

#[test]
fn struct_to_struct_assignment_type_mismatch_rejected() {
    // Struct copy works for matching types, but the LHS and RHS
    // must agree -- you can't assign a `Bar` value to a `Foo`
    // local even if the field layouts happen to match.
    expect_compile_error(
        "struct Foo { int x; }; struct Bar { int x; }; \
         int main() { struct Foo a; struct Bar b; a = b; return 0; }",
        "struct types differ on either side of `=`",
    );
}

#[test]
fn forward_declared_struct_pointer_compiles() {
    // A `struct Foo *p` mention before any body is a forward
    // declaration -- the struct stays opaque (size 0, no fields)
    // but pointer types and typedefs can refer to it. This is
    // the C standard's behaviour and a hard requirement for
    // common `typedef struct Foo Foo;`-before-body shapes.
    use super::run_str;
    let exit = run_str("int main() { struct Forward *p; p = 0; return 7; }");
    assert_eq!(exit, 7);
}

#[test]
fn field_access_on_opaque_struct_is_rejected() {
    // The pointer mention above auto-forward-declares; touching
    // a field on the opaque value is still an error -- the
    // struct has no fields to look up. We don't pin the exact
    // wording, just that compilation fails.
    match Compiler::new("int main() { struct Forward *p; p = 0; return p->x; }".to_string())
        .compile()
    {
        Err(_) => {}
        Ok(_) => panic!("expected compile error on field access through opaque struct"),
    }
}

#[test]
fn extern_and_static_keywords_are_no_op_at_global_scope() {
    use super::run_str;
    // `extern` and `static` may appear before the type prefix
    // (with or without `_Thread_local`); both are accepted and
    // ignored. The semantics of the resulting decl are
    // identical to the no-prefix form -- the global lives in
    // .data with zero init -- so the program runs the same
    // way it would without the keywords.
    let src = "
        extern int a;
        static int b;
        static extern int c;
        int main() {
            a = 1; b = 2; c = 3;
            return a + b + c;
        }
    ";
    assert_eq!(run_str(&super::with_prelude(src)), 6);
}

#[test]
fn extern_and_static_on_functions_compile() {
    let src = "
        static int helper(int n) { return n + 1; }
        extern int main() { return helper(41); }
    ";
    assert_eq!(super::run_str(&super::with_prelude(src)), 42);
}

#[test]
fn extern_and_static_on_locals_and_params_compile() {
    let src = "
        int f(static int n) {
            static int x;
            x = n;
            return x;
        }
        int main() { return f(42); }
    ";
    assert_eq!(super::run_str(&super::with_prelude(src)), 42);
}

#[test]
fn pragma_export_records_function_on_program() {
    // `#pragma export(<name>)` is the c5 directive that
    // marks a function as externally callable from another
    // image (dlsym / GetProcAddress). The preprocessor
    // recognises it, the compiler validates the name
    // resolves to a function defined here, and the result
    // lands on `Program::exports` for the per-format
    // shared-object writers to consume.
    let src = "
        int answer() { return 42; }
        int helper() { return 1; }
        #pragma export(answer)
        int main() { return 0; }
    ";
    let p = super::Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile");
    assert_eq!(p.exports.len(), 1, "expected one export");
    assert_eq!(p.exports[0].name, "answer");
    // The recorded PC must point at one of the finished
    // functions' entry positions; the export-resolution path
    // refuses any other value, so this asserts the same
    // invariant from the caller's side.
    assert!(
        p.finished_functions
            .iter()
            .any(|f| f.ent_pc == p.exports[0].ent_pc),
        "exported PC {} should match one of the finished functions' ent_pc values: {:?}",
        p.exports[0].ent_pc,
        p.finished_functions
            .iter()
            .map(|f| (&f.name, f.ent_pc))
            .collect::<alloc::vec::Vec<_>>(),
    );
}

#[test]
fn export_all_functions_exports_non_static() {
    // The `--export-all` driver flag sets `export_all_functions`, so
    // every non-static function defined in the unit is exported without
    // an explicit `#pragma export` -- a runtime `dlopen` consumer
    // resolves it by name. Applies to shared-library and executable
    // output on every native target. A `static` function keeps internal
    // linkage and is not exported.
    let src = "
        static int helper() { return 1; }
        int answer() { return 42 + helper(); }
        int entry() { return answer(); }
    ";
    let opts = crate::c5::compiler::CompileOptions::default()
        .with_export_all_functions(true)
        .with_no_entry_point(true);
    let target = super::super::codegen::Target::default_target();
    let p = super::Compiler::with_options(super::with_prelude(src), target, opts)
        .compile()
        .expect("compile");
    let names: alloc::vec::Vec<&str> = p.exports.iter().map(|e| e.name.as_str()).collect();
    assert!(
        names.contains(&"answer"),
        "non-static `answer` must export: {names:?}"
    );
    assert!(
        names.contains(&"entry"),
        "non-static `entry` must export: {names:?}"
    );
    assert!(
        !names.contains(&"helper"),
        "static `helper` must not export: {names:?}"
    );
}

#[test]
fn pragma_export_with_unknown_name_is_refused() {
    let src = "
        int main() { return 0; }
        #pragma export(missing)
    ";
    let res = super::Compiler::new(super::with_prelude(src)).compile();
    let err = res.expect_err("expected unknown-export to fail");
    let msg = err.to_string();
    assert!(
        msg.contains("no such symbol") || msg.contains("missing"),
        "expected unknown-symbol diagnostic, got: {msg}"
    );
}

#[test]
fn pragma_export_with_global_data_is_refused() {
    // `#pragma export(...)` only handles functions. Pointing it at a
    // global variable surfaces a clear "not a function" diagnostic.
    let src = "
        int counter;
        #pragma export(counter)
        int main() { return 0; }
    ";
    let res = super::Compiler::new(super::with_prelude(src)).compile();
    let err = res.expect_err("expected data-export to fail");
    let msg = err.to_string();
    assert!(
        msg.contains("expected a function"),
        "expected non-function diagnostic, got: {msg}"
    );
}

#[test]
fn libc_call_with_struct_arg_compiles() {
    // A struct passed by value to a Token::Sys (libc) call is packed into the
    // platform-ABI argument registers (SysV / AAPCS64), no longer refused. The
    // runtime ABI is locked in by libc_struct_arg_by_value.c.
    let mut src = super::with_prelude(
        "struct P { int x; int y; };\n\
         int main() {\n\
             struct P p;\n\
             p.x = 1; p.y = 2;\n\
             write(1, p, sizeof(p));\n\
             return 0;\n\
         }",
    );
    src.push('\0');
    assert!(
        Compiler::new(src).compile().is_ok(),
        "struct-by-value to a libc binding should compile"
    );
}

#[test]
fn libc_call_returning_struct_is_refused() {
    // Symmetric to the arg case: a Token::Sys binding declared
    // to return a struct by value (e.g. `div_t div(int, int)`)
    // would need the platform ABI's two-register split on
    // SysV / AAPCS64 or hidden-out-pointer on Win64. Until
    // that lands, we refuse the call.
    //
    // The prelude doesn't declare any struct-returning libc
    // function today, so we synthesize one via a local
    // `#pragma binding` to a non-existent symbol; the parser
    // type-checks the call before the loader would notice the
    // binding is bogus.
    let src = "\
        #pragma dylib(libc, \"libc.so.6\")\n\
        #pragma binding(libc::make_pair, \"make_pair\")\n\
        struct Pair { int a; int b; };\n\
        struct Pair make_pair();\n\
        int main() { struct Pair p; p = make_pair(); return p.a; }\n";
    let res = Compiler::new(src.to_string()).compile();
    let err = res.expect_err("expected struct-return-from-libc to fail");
    let msg = err.to_string();
    assert!(
        msg.contains("returns a struct by value")
            || msg.contains("struct-return convention isn't implemented"),
        "expected platform-ABI struct-return refusal, got: {msg}"
    );
}

#[test]
fn float_modulo_rejected() {
    // `%` on floats is not legal C either; we surface our own error
    // so the message points at the operand rather than at the op.
    expect_compile_error(
        "int main() { float x; x = 1.0; x = x % 2; return 0; }",
        "`%` is not defined on floating-point operands",
    );
}

#[test]
fn float_increment_compiles() {
    // C99 6.5.3.1 / 6.5.2.4: `++` / `--` apply to any real floating type,
    // adding or subtracting 1. The lowering routes a floating lvalue
    // through the FP add path (runtime values pinned by the
    // float_increment_decrement fixture).
    assert!(
        Compiler::new("int main() { float x = 1.0f; x++; --x; return 0; }".to_string())
            .compile()
            .is_ok()
    );
}

#[test]
fn float_int_mixed_addition_auto_promotes() {
    // Mixed int / float operands now auto-promote -- the int side
    // is lifted to f64 (via int-to-float cast for the RHS-int
    // case, or via the spill-recover-cast sequence using a
    // store-local for the LHS-int case). `(double)i + 1.0` and
    // bare `i + 1.0` both compile and produce the same result.
    let src = "int main() { int i; double y; i = 3; y = i + 1.5; return (int)y; }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    let vm_result = crate::c5::Vm::new(prog).run().unwrap();
    assert_eq!(vm_result, 4);
}
