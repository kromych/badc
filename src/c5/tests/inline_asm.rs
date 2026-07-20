//! Inline-asm operand tests.

#[test]
fn template_operand_reference_past_the_operand_list_is_diagnosed() {
    use crate::{NativeOptions, Target};
    // `%N` beyond the last operand indexes the operand list out of
    // bounds in both the native emitter and the interpreter; it must be
    // reported, not panic.
    let program = super::compile_str(
        "int main(void){ long x = 0; __asm__(\"testq %2, %2\" : : \"r\"(x) : \"cc\"); return 0; }",
    );
    let err = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .expect_err("`%2` names no operand");
    let msg = alloc::format!("{err}");
    assert!(msg.contains("`%2` names no operand"), "{msg}");
}

#[test]
fn adjacent_constraint_literals_concatenate() {
    // C99 5.1.1.2 phase 6. A constraint may be split across adjacent
    // string literals, as macro-built constraints commonly are.
    let src = "int main(void) { long s = 1, b = 2; \
               __asm__(\"addq %2, %0\" : \"=\" \"r\"(s) : \"0\"(s), \"r\"(b)); \
               return s == 3 ? 0 : 1; }";
    let prog = crate::Compiler::with_options(
        src.to_string(),
        crate::Target::LinuxX64,
        crate::CompileOptions::default(),
    )
    .compile();
    assert!(
        prog.is_ok(),
        "split constraint literals should concatenate: {:?}",
        prog.err()
    );
}

#[test]
fn split_constraint_reaching_an_unknown_letter_is_still_rejected() {
    // Concatenation must not swallow a bad constraint: the pieces are
    // joined and then classified as a whole.
    let src = "int main(void) { int s; __asm__(\"nop\" : \"=\" \"?\"(s)); return s; }";
    let err = crate::Compiler::with_options(
        src.to_string(),
        crate::Target::LinuxX64,
        crate::CompileOptions::default(),
    )
    .compile()
    .err()
    .map(|e| e.to_string())
    .unwrap_or_default();
    assert!(
        err.contains("unsupported constraint `=?`"),
        "expected the joined constraint in the diagnostic, got {err:?}"
    );
}
