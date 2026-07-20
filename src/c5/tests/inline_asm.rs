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

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
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

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn backend_asm_diagnostics_carry_the_error_prefix() {
    use crate::{NativeOptions, Target};
    // A diagnostic that does not identify itself as an error leaves a
    // log consumer to attribute it to whatever severity came before.
    // Every backend-recorded inline-asm failure goes out through one
    // site per target, so check both.
    for (target, arch) in [
        (Target::LinuxX64, "x86_64"),
        (Target::LinuxAarch64, "aarch64"),
    ] {
        let program =
            super::compile_str("int main(void){ __asm__ volatile(\"frobnicate\"); return 0; }");
        let err = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .expect_err("`frobnicate` is not an instruction");
        let msg = alloc::format!("{err}");
        assert!(msg.starts_with("error: "), "{arch}: {msg}");
        assert!(msg.contains("frobnicate"), "{arch}: {msg}");
    }
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

#[test]
fn address_constraint_takes_a_register() {
    // `p` takes its operand as an address held in a general register, on
    // either target; unlike `m` it forces no addressing mode.
    for is_x86 in [true, false] {
        assert_eq!(
            crate::Compiler::parse_asm_constraint("p", false, 0, is_x86).map(|(k, _)| k),
            Some(AsmConstraint::Reg),
            "is_x86={is_x86}"
        );
    }
    // The aarch64 `U`-prefixed memory classes spell their own multi-letter
    // names and keep reaching the memory path.
    assert_eq!(
        crate::Compiler::parse_asm_constraint("Ump", false, 0, false).map(|(k, _)| k),
        Some(AsmConstraint::Mem),
    );
}

#[test]
fn aarch64_q_memory_constraint_covers_the_offsettable_forms() {
    // The MMIO write accessors use `"Qo"`: the base-register (`Q`) class
    // broadened by the offsettable (`o`) one. badc renders every form as
    // `[xN]`, so `Q`, `Qo` and `Qm`, with any output/read-write prefix, all
    // classify as the base-register memory operand.
    for c in ["Q", "Qo", "Qm", "=Q", "+Qo"] {
        assert_eq!(
            crate::Compiler::parse_asm_constraint(c, false, 0, false).map(|(k, _)| k),
            Some(AsmConstraint::MemBase),
            "`{c}` on aarch64"
        );
    }
    // The x86 `Q` is the legacy high-byte register class, not memory; the
    // `Qo` spelling has no x86 meaning and stays unrecognized.
    assert_eq!(
        crate::Compiler::parse_asm_constraint("Qo", false, 0, true).map(|(k, _)| k),
        None,
    );
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_qo_operand_stores_through_a_base_register() {
    use crate::{NativeOptions, Target};
    // `%1` is the `"Qo"` memory operand; the store must address it as
    // `[xN]` with a zero offset -- `strb Wt, [Xn]` (0x39000000, imm12 = 0),
    // byte-identical to clang for `*ptr`.
    let src = "typedef unsigned char u8; \
        void wb(u8 v, volatile void *a){ volatile u8 *p = a; \
        __asm__ volatile(\"strb %w0, %1\" : : \"rZ\"(v), \"Qo\"(*p)); } \
        int main(void){ return 0; }";
    let program = crate::Compiler::with_options(
        src.to_string(),
        Target::LinuxAarch64,
        crate::CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .expect("emit");
    let found = bytes.windows(4).any(|w| {
        let word = u32::from_le_bytes([w[0], w[1], w[2], w[3]]);
        word & 0xFFC0_0000 == 0x3900_0000 && (word >> 10) & 0xFFF == 0
    });
    assert!(found, "expected `strb Wt, [Xn]` with a zero offset");
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn x86_seg_qualified_memory_operand_rides_a_segment_prefix() {
    use crate::{NativeOptions, Target};
    // A `__seg_gs` / `__seg_fs`-qualified `"+m"` operand emits a segment
    // override on the accessing instruction (GCC named address spaces): the
    // `incq %[v]` reaches `%gs:`/`%fs:`-relative memory. gcc encodes the read
    // path `65 48 ff ..` (gs) / `64 48 ff ..` (fs); the prefix is the only
    // delta from the unqualified operand. An `incq` through memory is
    // `REX.W ff /0`, so scan for the override byte followed by a REX and the
    // `ff` opcode -- register-choice independent.
    let emit = |seg: &str| -> alloc::vec::Vec<u8> {
        let src = alloc::format!(
            "extern unsigned long pv; \
             void bump(void){{ __asm__ volatile(\"incq %[v]\" \
             : [v] \"+m\" (*(unsigned long {seg} *)(__UINTPTR_TYPE__)&pv)); }} \
             int main(void){{ return 0; }}"
        );
        let program =
            crate::Compiler::with_options(src, Target::LinuxX64, crate::CompileOptions::default())
                .compile()
                .expect("compile");
        crate::c5::object::emit_native_single_tu_for_test(
            &program,
            Target::LinuxX64,
            NativeOptions::default(),
        )
        .expect("emit")
    };
    let inc_prefixed = |bytes: &[u8], pfx: u8| -> bool {
        bytes
            .windows(3)
            .any(|w| w[0] == pfx && (0x48..=0x4f).contains(&w[1]) && w[2] == 0xff)
    };
    let gs = emit("__seg_gs");
    let fs = emit("__seg_fs");
    let plain = emit(""); // negative control: no qualifier, no override.
    assert!(
        inc_prefixed(&gs, 0x65),
        "`__seg_gs` operand must ride a %gs (0x65) prefix"
    );
    assert!(
        inc_prefixed(&fs, 0x64),
        "`__seg_fs` operand must ride a %fs (0x64) prefix"
    );
    assert!(
        !inc_prefixed(&plain, 0x65) && !inc_prefixed(&plain, 0x64),
        "an unqualified operand must carry no segment override"
    );
}

#[test]
fn x86_range_immediate_constraints_are_immediates() {
    // The x86 range-restricted immediate letters classify as immediates,
    // like `i` / `n`; the value restriction is applied at the operand,
    // where the constant is known.
    for c in ["I", "J", "K", "L", "M", "N", "O"] {
        assert_eq!(
            inp(c).map(|(k, _)| k),
            Some(AsmConstraint::Imm),
            "`{c}` should classify as an immediate"
        );
    }
    // x86 leaves `P` undefined within the machine-dependent `I`..`P`
    // band, so it stays unrecognized (GCC and clang both reject it).
    assert_eq!(inp("P").map(|(k, _)| k), None);
    // A register alternative alongside the letter wins: the operand can
    // be loaded, so no value restriction applies.
    for c in ["Ir", "rI", "Jr", "Kr", "Nr"] {
        assert_eq!(
            inp(c).map(|(k, _)| k),
            Some(AsmConstraint::Reg),
            "`{c}` should take the register alternative"
        );
    }
    // aarch64 gives `I`..`N` its own immediate meanings (different ranges,
    // checked in the aarch64 tests below); it does not take the x86 ones. `O`
    // is not modeled on aarch64, so it stays unrecognized there.
    for c in ["I", "J", "K", "L", "M", "N"] {
        assert_eq!(
            crate::Compiler::parse_asm_constraint(c, false, 0, false).map(|(k, _)| k),
            Some(AsmConstraint::Imm),
            "`{c}` should be an aarch64 immediate"
        );
    }
    assert_eq!(
        crate::Compiler::parse_asm_constraint("O", false, 0, false).map(|(k, _)| k),
        None,
        "`O` is not modeled on aarch64"
    );
    // The x86 memory and fixed-register paths keep their classification.
    assert_eq!(inp("m").map(|(k, _)| k), Some(AsmConstraint::Mem));
    assert_eq!(inp("D").map(|(k, _)| k), Some(AsmConstraint::Fixed(7)));
}

#[test]
fn x86_immediate_constraint_ranges() {
    // The accepted-value sets for the x86 range-restricted immediate
    // letters, each checked at and just past its bounds. The values
    // match GCC's "Machine Constraints" (i386 family) and were confirmed
    // against gcc 16 and clang 22.
    let cases: &[(char, &[i64], &[i64])] = &[
        // 32-bit shift counts.
        ('I', &[0, 1, 31], &[-1, 32]),
        // 64-bit shift counts.
        ('J', &[0, 1, 63], &[-1, 64]),
        // A signed 8-bit value.
        ('K', &[-128, -1, 0, 127], &[-129, 128]),
        // The zero-extending and-masks.
        ('L', &[0xFF, 0xFFFF, 0xFFFF_FFFF], &[0, 1, 0xFE, 0xFFFE]),
        // `lea` scale-factor shift counts.
        ('M', &[0, 1, 3], &[-1, 4]),
        // An unsigned 8-bit value.
        ('N', &[0, 1, 255], &[-1, 256]),
        // 128-bit shift counts.
        ('O', &[0, 1, 127], &[-1, 128]),
    ];
    for &(letter, accept, reject) in cases {
        for &v in accept {
            assert!(
                crate::Compiler::x86_imm_constraint_accepts(letter, v),
                "`{letter}` should accept {v}"
            );
        }
        for &v in reject {
            assert!(
                !crate::Compiler::x86_imm_constraint_accepts(letter, v),
                "`{letter}` should reject {v}"
            );
        }
    }
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn x86_immediate_constraint_operand_encodes_as_an_immediate() {
    use crate::{NativeOptions, Target};
    // A bit-set whose bit number arrives through the range-restricted
    // `I`: the operand must reach the instruction as an immediate byte,
    // not a register. The expected encoding is `lock; btsl $8, (reg)` --
    // `f0 0f ba /5 08` -- which clang emits for the same source; only the
    // ModRM base register is allocation-dependent, so the check spans the
    // lock prefix, opcode and immediate around it.
    let src = "unsigned f(int *p) { char c; \
         __asm__ volatile(\"lock; btsl %[val], %[var]\\n\\tsetc %[cc]\" \
         : [var] \"+m\"(*p), [cc] \"=qm\"(c) : [val] \"I\"(8) : \"memory\"); \
         return (unsigned)c; } int main(void) { return 0; }";
    let program = crate::Compiler::with_options(
        src.to_string(),
        Target::LinuxX64,
        crate::CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .expect("emit");
    let found = bytes.windows(5).any(|w| {
        w[0] == 0xF0 && w[1] == 0x0F && w[2] == 0xBA && (w[3] >> 3) & 7 == 5 && w[4] == 0x08
    });
    assert!(found, "expected `lock btsl $8` with an immediate operand");
}

#[test]
fn x86_immediate_constraint_out_of_range_is_diagnosed() {
    // An out-of-range literal has no register alternative to fall back
    // on, so it cannot be satisfied; GCC reports "impossible constraint"
    // and clang "value out of range for constraint".
    let err = |body: &str| -> alloc::string::String {
        let src =
            alloc::format!("void f(int n){{ (void)n; {body} }} int main(void){{ return 0; }}");
        crate::Compiler::with_options(
            src,
            crate::Target::LinuxX64,
            crate::CompileOptions::default(),
        )
        .compile()
        .err()
        .map(|e| e.to_string())
        .unwrap_or_default()
    };
    let e = err("__asm__ volatile(\"# %0\" :: \"I\"(32));");
    assert!(
        e.contains("value 32 out of range for constraint `I`"),
        "{e}"
    );
    let e = err("__asm__ volatile(\"# %0\" :: \"N\"(256));");
    assert!(
        e.contains("value 256 out of range for constraint `N`"),
        "{e}"
    );
    // A non-constant operand cannot satisfy an immediate-only constraint.
    let e = err("__asm__ volatile(\"# %0\" :: \"I\"(n));");
    assert!(e.contains("requires an integer constant"), "{e}");
    // A register alternative lifts the restriction.
    assert_eq!(err("__asm__ volatile(\"# %0\" :: \"Ir\"(n));"), "");
    // x86 leaves `P` undefined in the machine-dependent band.
    let e = err("__asm__ volatile(\"# %0\" :: \"P\"(0));");
    assert!(e.contains("unsupported constraint `P`"), "{e}");
}

#[test]
fn aarch64_immediate_constraints_classify_and_combine() {
    let a64 = |c: &str| crate::Compiler::parse_asm_constraint(c, false, 0, false).map(|(k, _)| k);
    // Bare I..N are pure immediates; the value restriction is applied at the
    // operand, where the constant is known.
    for c in ["I", "J", "K", "L", "M", "N"] {
        assert_eq!(a64(c), Some(AsmConstraint::Imm), "`{c}` on aarch64");
    }
    // A register alternative alongside the letter wins: the operand can be
    // loaded, so no value restriction applies.
    for c in ["rI", "Ir", "rL", "Nr"] {
        assert_eq!(a64(c), Some(AsmConstraint::Reg), "`{c}` on aarch64");
    }
    // A multi-letter `U` / `D` / `v` class embeds these letters without being
    // an immediate and must not be misread as one.
    for c in ["UsM", "vsN", "DL"] {
        assert_ne!(
            a64(c),
            Some(AsmConstraint::Imm),
            "`{c}` must not be read as an immediate"
        );
    }
}

#[test]
fn aarch64_immediate_constraint_ranges() {
    // Accept / reject sets confirmed against gcc 16 and clang 22 on aarch64.
    let cases: &[(char, &[i64], &[i64])] = &[
        // 12-bit unsigned, optionally shifted left by 12 (add/sub operand).
        (
            'I',
            &[0, 1, 0xFFF, 0x1000, 0xFFF000, 0x401],
            &[0x1001, 0xFFF001, 0x1000000, -1],
        ),
        // The negation of an `I` value (sub operand).
        (
            'J',
            &[0, -1, -0xFFF, -0x1000, -0xFFF000],
            &[-0x1001, 1, -0xFFF001],
        ),
        // 32-bit logical bitmask (and/orr/eor).
        (
            'K',
            &[1, 0xF, 0xFFFF, 0x8000_0001, 0x5555_5555, 0xFFFF_FFFE],
            &[0, 5, 0xFFFF_FFFF, -1],
        ),
        // 64-bit logical bitmask.
        (
            'L',
            &[1, 0xFFFF_FFFF, 0x5555_5555_5555_5555, 0xFFFF, i64::MIN + 1],
            &[0, -1],
        ),
        // 32-bit move immediate (movz / movn / bitmask).
        (
            'M',
            &[
                0,
                1,
                0xFFFF,
                0xFFFF_0000,
                0x1234,
                0xFFFF_FFFF,
                0xFFFF_FF00,
                0x1_0001,
            ],
            &[0x1234_5678],
        ),
        // 64-bit move immediate.
        (
            'N',
            &[0, 0xFFFF, 0x1_0000_0001, -0x1_0000],
            &[0x1234_5678_1234_5678],
        ),
    ];
    for &(letter, accept, reject) in cases {
        for &v in accept {
            assert!(
                crate::Compiler::aarch64_imm_constraint_accepts(letter, v),
                "`{letter}` should accept {v:#x}"
            );
        }
        for &v in reject {
            assert!(
                !crate::Compiler::aarch64_imm_constraint_accepts(letter, v),
                "`{letter}` should reject {v:#x}"
            );
        }
    }
}

#[test]
fn aarch64_immediate_constraint_out_of_range_is_diagnosed() {
    // An out-of-range literal has no register alternative to fall back on, so
    // it cannot be satisfied; the values match what gcc 16 and clang 22 reject.
    let err = |body: &str| -> alloc::string::String {
        let src =
            alloc::format!("void f(int n){{ (void)n; {body} }} int main(void){{ return 0; }}");
        crate::Compiler::with_options(
            src,
            crate::Target::LinuxAarch64,
            crate::CompileOptions::default(),
        )
        .compile()
        .err()
        .map(|e| e.to_string())
        .unwrap_or_default()
    };
    // 0x1001 is neither a 12-bit value nor a shifted one.
    let e = err("__asm__ volatile(\"add x0, x0, %0\" :: \"I\"(0x1001));");
    assert!(
        e.contains("value 4097 out of range for constraint `I`"),
        "{e}"
    );
    // The all-ones 32-bit mask is not a logical immediate.
    let e = err("__asm__ volatile(\"and w0, w0, %w0\" :: \"K\"(0xffffffff));");
    assert!(e.contains("out of range for constraint `K`"), "{e}");
    // A non-constant operand cannot satisfy an immediate-only constraint.
    let e = err("__asm__ volatile(\"add x0, x0, %0\" :: \"I\"(n));");
    assert!(e.contains("requires an integer constant"), "{e}");
    // A register alternative lifts the restriction.
    assert_eq!(
        err("__asm__ volatile(\"add x0, x0, %0\" :: \"Ir\"(n));"),
        ""
    );
    // `O` is not modeled on aarch64.
    let e = err("__asm__ volatile(\"# %0\" :: \"O\"(0));");
    assert!(e.contains("unsupported constraint `O`"), "{e}");
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_brk_immediate_operand_encodes_as_an_immediate() {
    use crate::{NativeOptions, Target};
    // The kgdb breakpoint site `asm("brk %0" :: "I"(imm))`: the `I` operand
    // reaches `brk` as an immediate, encoding `brk #0x401` (0xD4208020),
    // byte-identical to clang.
    let src = "void f(void){ __asm__ (\"brk %0\" :: \"I\"(0x401)); } \
        int main(void){ return 0; }";
    let program = crate::Compiler::with_options(
        src.to_string(),
        Target::LinuxAarch64,
        crate::CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxAarch64,
        NativeOptions::default(),
    )
    .expect("emit");
    let found = bytes
        .windows(4)
        .any(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]) == 0xD420_8020);
    assert!(found, "expected `brk #0x401` (0xD4208020)");
}
