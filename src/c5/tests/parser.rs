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
fn thread_local_keyword_recognized_codegen_pending() {
    // `_Thread_local` lexes as Token::ThreadLocal, the parser
    // accepts it as a global storage-class prefix, and the symbol
    // carries the flag. Codegen for the per-target TLS sequences
    // is the next milestone, so use of a `_Thread_local` global
    // emits a clean diagnostic rather than silently lowering as a
    // regular global.
    expect_compile_error(
        "_Thread_local int counter;\n\
         int main() { return 0; }",
        "`_Thread_local` is parsed but the codegen lowering",
    );
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
