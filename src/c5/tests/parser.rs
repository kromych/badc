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
    // gh #52: a prototype following a function definition used to
    // clobber the symbol's val (= bytecode pc) when val happened
    // to be 0 -- which is exactly the case for the *first*
    // function in the source. The reset would point every later
    // call site at the buffer's current pc, sending the call
    // into nowhere-land. Pin the fix.
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
    for (src, prev_needle, now_needle) in &[
        // Different return type.
        (
            "int f(int x) { return x; } char f(int x); int main() { return 0; }",
            "previous: int (int)",
            "now:      unsigned char (int)",
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
fn tentative_definition_merge() {
    // `int x;` + `int x = 5;` -- the prior declaration is tentative
    // (no initializer); the second one supplies the initializer.
    // Allowed by C11 6.9.2; sqlite3 amalgamation relies on this.
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

#[test]
fn thread_local_compiles_to_op_tlslea() {
    // `_Thread_local` lexes as Token::ThreadLocal, the parser
    // accepts it as a global storage-class prefix, the symbol
    // carries the flag, and reads/writes lower to Op::TlsLea
    // operands rather than the regular data-segment Op::Imm.
    use super::super::op::Op;
    let src = "_Thread_local int counter;\n\
               int main() { counter = 42; return counter; }";
    let p = super::Compiler::new(super::with_prelude(src))
        .compile()
        .expect("compile failed");
    assert!(
        p.text.contains(&(Op::TlsLea as i64)),
        "expected at least one Op::TlsLea in the bytecode"
    );
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
        super::super::emit_native_with_options(&p, target, super::super::NativeOptions::default())
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
    // but pointer types and typedefs can refer to it.
    // This is the C standard's behaviour and a hard requirement
    // for sqlite-style `typedef struct sqlite3 sqlite3;`-before-body.
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
    assert!(
        p.exports[0].bytecode_pc < p.text.len(),
        "exported PC must be inside the bytecode"
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
    // Today `#pragma export(...)` only handles functions.
    // Pointing it at a global variable surfaces a clear "not
    // a function" diagnostic so a future "data export"
    // milestone has somewhere to land.
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
fn libc_call_with_struct_arg_is_refused() {
    // The c5-internal struct ABI uses caller-pushes-address +
    // callee-copies-on-entry. Real platform ABIs (SysV/Win64/AAPCS64)
    // pack the bytes into argument registers instead. We don't
    // implement the platform path yet, so calling a Token::Sys
    // function with a struct-by-value argument is refused at
    // compile time rather than emitting a silently-wrong call.
    let mut src = super::with_prelude(
        "struct P { int x; int y; };\n\
         int main() {\n\
             struct P p;\n\
             p.x = 1; p.y = 2;\n\
             write(1, p, sizeof(p));\n\
             return 0;\n\
         }",
    );
    // `write` is a Token::Sys binding declared in unistd.h; its
    // 2nd arg is a `void*`, not a struct, so the c5 grammar
    // here passes the struct by value, which trips our refusal.
    src.push('\0');
    let res = Compiler::new(src).compile();
    let err = res.expect_err("expected struct-by-value-to-libc to fail");
    let msg = err.to_string();
    assert!(
        msg.contains("struct passed by value")
            || msg.contains("struct-arg convention isn't implemented"),
        "expected platform-ABI struct refusal, got: {msg}"
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
fn float_increment_not_yet_implemented() {
    // `f++` on a float would need to lower to `f = f + 1.0`, but the
    // current `++/--` lowering hard-codes integer arithmetic via
    // `Op::Imm 1; Op::Add` patches over the lvalue load. The float
    // path is still ahead of us.
    expect_compile_error(
        "int main() { float x; x = 1.0; x++; return 0; }",
        "floating-point ++/-- not yet implemented",
    );
}

#[test]
fn float_int_mixed_addition_auto_promotes() {
    // Mixed int / float operands now auto-promote -- the int side
    // is lifted to f64 (via `Op::Fcvtif` for the RHS-int case, or
    // via the spill-recover-Fcvtif sequence using `Op::StLocI` for
    // the LHS-int case). `(double)i + 1.0` and bare `i + 1.0` both
    // compile and produce the same result.
    let src = "int main() { int i; double y; i = 3; y = i + 1.5; return (int)y; }";
    let prog = crate::c5::Compiler::new(src.to_string()).compile().unwrap();
    let vm_result = crate::c5::Vm::new(prog).run().unwrap();
    assert_eq!(vm_result, 4);
}
