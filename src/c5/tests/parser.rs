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
    expect_compile_error(
        "int x; int x; int main() { return 0; }",
        "duplicate global definition",
    );
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
fn unknown_struct_name_is_rejected() {
    expect_compile_error(
        "int main() { struct Missing *p; return 0; }",
        "unknown struct Missing",
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
fn float_int_mixed_addition_requires_cast() {
    // The IR has no in-place int-to-float promotion when the int
    // operand is already on the stack, so c5 requires an explicit
    // cast to lift the int side. `(double)i + 1.0` works; bare
    // `i + 1.0` doesn't.
    expect_compile_error(
        "int main() { int i; double y; i = 1; y = i + 1.0; return 0; }",
        "requires both operands to be the same kind",
    );
}
