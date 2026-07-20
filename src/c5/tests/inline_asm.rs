//! Inline-asm operand tests: constraint classification (exercised
//! directly so the rules hold for every target regardless of the host)
//! and the template / operand diagnostics.

use crate::c5::ir::AsmConstraint;

/// Classify an output constraint for an x86_64 target.
fn out(cstr: &str) -> Option<(AsmConstraint, bool)> {
    crate::Compiler::parse_asm_constraint(cstr, true, 0, true)
}

/// Classify an input constraint for an x86_64 target. One output is
/// already parsed, so `"0"` resolves.
fn inp(cstr: &str) -> Option<(AsmConstraint, bool)> {
    crate::Compiler::parse_asm_constraint(cstr, false, 1, true)
}

#[test]
fn register_alternative_wins_over_memory() {
    // A constraint offering both a register and memory takes the
    // register, in output position as well as input.
    for c in ["=rm", "=qm", "=gm", "=mr", "+rm"] {
        assert_eq!(
            out(c).map(|(k, _)| k),
            Some(AsmConstraint::Reg),
            "output `{c}` should take the register alternative"
        );
    }
    for c in ["rm", "qm", "g", "ri", "rn"] {
        assert_eq!(
            inp(c).map(|(k, _)| k),
            Some(AsmConstraint::Reg),
            "input `{c}` should take the register alternative"
        );
    }
}

#[test]
fn memory_only_constraint_stays_memory() {
    // With no register alternative there is nothing to prefer.
    for c in ["=m", "+m"] {
        assert_eq!(out(c).map(|(k, _)| k), Some(AsmConstraint::Mem), "{c}");
    }
    assert_eq!(inp("m").map(|(k, _)| k), Some(AsmConstraint::Mem));
}

#[test]
fn read_write_flag_tracks_the_plus_modifier() {
    assert_eq!(out("=rm"), Some((AsmConstraint::Reg, false)));
    assert_eq!(out("+rm"), Some((AsmConstraint::Reg, true)));
    assert_eq!(out("+m"), Some((AsmConstraint::Mem, true)));
}

#[test]
fn specific_register_letters_still_pin() {
    // A class letter with no general-register alternative pins the
    // register; adding `r` makes it a multi-alternative that the
    // register path serves instead.
    assert_eq!(out("=a").map(|(k, _)| k), Some(AsmConstraint::Fixed(0)));
    assert_eq!(out("=D").map(|(k, _)| k), Some(AsmConstraint::Fixed(7)));
    assert_eq!(out("=ra").map(|(k, _)| k), Some(AsmConstraint::Reg));
}

#[test]
fn flag_output_conditions_map_to_their_nibbles() {
    let cases = [
        ("=@cco", 0x0u8),
        ("=@ccno", 0x1),
        ("=@ccc", 0x2),
        ("=@ccb", 0x2),
        ("=@ccnae", 0x2),
        ("=@ccnc", 0x3),
        ("=@ccae", 0x3),
        ("=@cce", 0x4),
        ("=@ccz", 0x4),
        ("=@ccne", 0x5),
        ("=@ccnz", 0x5),
        ("=@ccbe", 0x6),
        ("=@cca", 0x7),
        ("=@ccs", 0x8),
        ("=@ccns", 0x9),
        ("=@ccp", 0xA),
        ("=@ccnp", 0xB),
        ("=@ccl", 0xC),
        ("=@ccge", 0xD),
        ("=@ccle", 0xE),
        ("=@ccg", 0xF),
    ];
    for (c, nibble) in cases {
        assert_eq!(
            out(c).map(|(k, _)| k),
            Some(AsmConstraint::Flags(nibble)),
            "{c}"
        );
    }
}

#[test]
fn flag_output_is_rejected_where_it_has_no_meaning() {
    // Input position, read-write, an unknown condition, and any other
    // `@` form are all refused rather than read as class letters --
    // `=@ccc` must never be mistaken for the `c` (rcx) register class.
    assert_eq!(inp("@ccc"), None);
    assert_eq!(out("+@ccc"), None);
    assert_eq!(out("=@ccqq"), None);
    assert_eq!(out("=@foo"), None);
    // AArch64 spells its conditions differently and has no `setcc`
    // materialization here, so the form is not accepted for it.
    assert_eq!(
        crate::Compiler::parse_asm_constraint("=@ccc", true, 0, false),
        None
    );
}

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
    let src = "int main(void) { long s = 1, b = 2; unsigned char cf; \
               __asm__(\"addq %3, %0\" : \"=\" \"r\"(s), \"=@cc\" \"c\"(cf) \
               : \"0\"(s), \"r\"(b) : \"cc\"); return s == 3 ? 0 : 1; }";
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

#[test]
fn flag_output_macro_is_advertised_only_where_implemented() {
    // The macro must not claim a feature the target cannot lower:
    // `=@cc` is x86_64-only, and it is a GNU extension.
    let probe = "#if defined(__GCC_ASM_FLAG_OUTPUTS__)\nyes\n#else\nno\n#endif\n";
    let check = |target: crate::Target, gnu: bool| -> bool {
        let mut pp = crate::c5::preprocessor::Preprocessor::new("", target, "0");
        if gnu {
            pp.enable_gnu();
        }
        pp.process(probe).unwrap_or_default().contains("yes")
    };
    assert!(check(crate::Target::LinuxX64, true));
    assert!(!check(crate::Target::LinuxAarch64, true));
    assert!(!check(crate::Target::LinuxX64, false));
}
