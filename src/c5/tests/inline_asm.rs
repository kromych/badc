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
