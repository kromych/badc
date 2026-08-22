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
            pp.enable_gnu(false, true);
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

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn x86_function_body_asm_takes_the_address_size_prefix() {
    use crate::{NativeOptions, Target};
    // A 32-bit base or index in a function-body template addresses 32 bits and
    // takes the `67` prefix, as it does in file-scope and `.s` asm. The
    // expected run is what GNU as 2.46.1 emits for the same statements.
    let src = "void f(void){ __asm__ volatile(\
               \"movl 2(%%eax), %%ebx\\n\\t\"\
               \"movl (%%eax,%%ecx,4), %%ebx\\n\\t\"\
               \"movl (,%%ecx,4), %%ebx\\n\\t\"\
               \"movl 2(%%r8d), %%ebx\\n\\t\"\
               \"movw 2(%%eax), %%bx\\n\\t\"\
               \"movq 2(%%eax), %%rbx\\n\\t\"\
               \"movl 2(%%rax), %%ebx\" \
               ::: \"memory\", \"rbx\", \"rcx\"); } \
               int main(void){ return 0; }";
    let image = crate::Compiler::with_options(
        alloc::string::String::from(src),
        Target::LinuxX64,
        crate::CompileOptions::default(),
    )
    .compile()
    .and_then(|p| {
        crate::c5::object::emit_native_single_tu_for_test(
            &p,
            Target::LinuxX64,
            NativeOptions::default(),
        )
    })
    .expect("emit");
    let want: &[u8] = &[
        0x67, 0x8B, 0x58, 0x02, // movl 2(%eax), %ebx
        0x67, 0x8B, 0x1C, 0x88, // movl (%eax,%ecx,4), %ebx
        0x67, 0x8B, 0x1C, 0x8D, 0x00, 0x00, 0x00, 0x00, // movl (,%ecx,4), %ebx
        0x67, 0x41, 0x8B, 0x58, 0x02, // movl 2(%r8d), %ebx
        0x67, 0x66, 0x8B, 0x58, 0x02, // movw 2(%eax), %bx
        0x67, 0x48, 0x8B, 0x58, 0x02, // movq 2(%eax), %rbx
        0x8B, 0x58, 0x02, // movl 2(%rax), %ebx -- mode default, no prefix
    ];
    assert!(
        image.windows(want.len()).any(|w| w == want),
        "function-body asm must encode a 32-bit base the way GNU as does"
    );
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn x86_c_operand_memory_reference_is_never_an_immediate() {
    use crate::{NativeOptions, Target};
    // A bare `%c` / `%P` operand is a memory reference in AT&T syntax. Taking
    // it for an immediate turns the percpu load `movq %%gs:%c1, %0` into
    // `movq $imm, %reg` under a stray segment prefix -- the same value the
    // template asked to dereference, silently. Whatever the emitter does with
    // these shapes, it must never encode the immediate form: `c7 /0` (mov
    // imm32 to r/m) and `b8+r` (mov imm to reg) are the two spellings.
    let emit = |body: &str| -> Option<alloc::vec::Vec<u8>> {
        let src = alloc::format!(
            "long g; long f(void){{ long v; {body} return v; }} int main(void){{ return 0; }}"
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
        .ok()
    };
    // The displacements are distinctive so the scan cannot collide with an
    // unrelated constant load elsewhere in the image.
    let cases = [
        (
            "__asm__ volatile(\"movq %%gs:%c1, %0\" : \"=r\"(v) : \"i\"(0x1234));",
            0x1234u32,
        ),
        (
            "__asm__ volatile(\"movq %%fs:%c1, %0\" : \"=r\"(v) : \"i\"(0x5678));",
            0x5678,
        ),
        (
            "__asm__ volatile(\"movq %c1, %0\" : \"=r\"(v) : \"i\"(0x2468));",
            0x2468,
        ),
    ];
    for (body, disp) in cases {
        let Some(bytes) = emit(body) else { continue };
        // `REX.W c7 /0 imm32` (mov imm32 to r/m) carrying the displacement as
        // its immediate: the shape the miscompile produced.
        let imm_move = bytes.windows(8).any(|w| {
            (0x48..=0x4f).contains(&w[0])
                && w[1] == 0xC7
                && w[2] & 0xF8 == 0xC0
                && u32::from_le_bytes([w[3], w[4], w[5], w[6]]) == disp
        });
        assert!(!imm_move, "`{body}` must not encode as an immediate move");
    }
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn x86_c_operand_memory_reference_encodings_match_the_assembler() {
    use crate::{NativeOptions, Target};
    // The absolute no-base form: mod=00 rm=100 with SIB 0x25 (base=101,
    // index=100) and a disp32, under the instruction's segment override.
    // Byte sequences taken from `clang -target x86_64-linux-gnu -c`.
    let emit = |body: &str| -> alloc::vec::Vec<u8> {
        let src = alloc::format!(
            "long f(void){{ long v = 0; unsigned w = 0; {body} return v + w; }} \
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
    let cases: &[(&str, &[u8])] = &[
        // movq %gs:0x10, %rax
        (
            "__asm__ volatile(\"movq %%gs:%c1, %0\" : \"=r\"(v) : \"i\"(16));",
            &[0x65, 0x48, 0x8B, 0x04, 0x25, 0x10, 0x00, 0x00, 0x00],
        ),
        // movq %fs:0x28, %rax
        (
            "__asm__ volatile(\"movq %%fs:%c1, %0\" : \"=r\"(v) : \"i\"(40));",
            &[0x64, 0x48, 0x8B, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00],
        ),
        // movq 0x10, %rax -- no override, still a memory reference
        (
            "__asm__ volatile(\"movq %c1, %0\" : \"=r\"(v) : \"i\"(16));",
            &[0x48, 0x8B, 0x04, 0x25, 0x10, 0x00, 0x00, 0x00],
        ),
        // movq %rax, %gs:0x18
        (
            "__asm__ volatile(\"movq %0, %%gs:%c1\" : : \"r\"(v), \"i\"(24) : \"memory\");",
            &[0x65, 0x48, 0x89, 0x04, 0x25, 0x18, 0x00, 0x00, 0x00],
        ),
        // movl %gs:0x10, %eax -- the access width follows the suffix
        (
            "__asm__ volatile(\"movl %%gs:%c1, %0\" : \"=r\"(w) : \"i\"(16));",
            &[0x65, 0x8B, 0x04, 0x25, 0x10, 0x00, 0x00, 0x00],
        ),
        // incq %gs:0x30 -- read-modify-write through the override
        (
            "__asm__ volatile(\"incq %%gs:%c0\" : : \"i\"(48) : \"memory\", \"cc\");",
            &[0x65, 0x48, 0xFF, 0x04, 0x25, 0x30, 0x00, 0x00, 0x00],
        ),
    ];
    for (body, want) in cases {
        let bytes = emit(body);
        assert!(
            bytes.windows(want.len()).any(|w| w == *want),
            "`{body}` did not encode as {want:02x?}"
        );
    }
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn x86_unencodable_c_memory_operand_is_diagnosed() {
    use crate::{NativeOptions, Target};
    // A displacement that is neither a compile-time constant nor a link-time
    // address, and one that does not fit the disp32 field, have no encoding.
    // Both must be reported rather than truncated or approximated.
    let cases = [
        (
            "long f(long x){ long v; __asm__ volatile(\"movq %%gs:%c1, %0\" \
             : \"=r\"(v) : \"r\"(x)); return v; } int main(void){ return 0; }",
            "not a constant or address",
        ),
        (
            "long f(void){ long v; __asm__ volatile(\"movq %%gs:%c1, %0\" \
             : \"=r\"(v) : \"i\"(0x100000000L)); return v; } int main(void){ return 0; }",
            "displacement out of range",
        ),
    ];
    for (src, want) in cases {
        let program = super::compile_str(src);
        let err = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            Target::LinuxX64,
            NativeOptions::default(),
        )
        .expect_err("the operand has no encoding");
        let msg = alloc::format!("{err}");
        assert!(msg.contains(want), "expected `{want}`, got {msg}");
    }
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

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_bare_immediate_operand_encodes_like_gcc() {
    use crate::{NativeOptions, Target};
    // GAS makes the `#` optional on an immediate: `BUG()` expands to
    // `brk 0x800` and the semihosting sites to `hlt 0xf000`, both written
    // without a `#`. They must encode identically to the `#`-prefixed form
    // gcc emits: brk #0x800 -> 0xD4210000, hlt #0xf000 -> 0xD45E0000.
    let src = "void f(void){ __asm__ volatile(\"brk 0x800\"); \
        __asm__ volatile(\"hlt 0xf000\"); } int main(void){ return 0; }";
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
    let has = |word: u32| {
        bytes
            .windows(4)
            .any(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]) == word)
    };
    assert!(has(0xD421_0000), "expected `brk 0x800` (0xD4210000)");
    assert!(has(0xD45E_0000), "expected `hlt 0xf000` (0xD45E0000)");
}

#[test]
#[cfg(feature = "native-emit")]
fn fixed_register_input_output_pair_is_accepted() {
    use crate::{NativeOptions, Target};
    // An input and an output pinned to the same register are a tied
    // pair: the register carries the input value in and the output
    // value out (both gcc and clang accept this; it is how call-style
    // instructions with fixed argument registers are wrapped).
    let emit = |src: &str, target: Target| {
        let program = crate::Compiler::with_options(
            src.to_string(),
            target,
            crate::CompileOptions::default(),
        )
        .compile()
        .expect("compile");
        crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .expect("emit");
    };
    emit(
        "long f(long v) { register long in asm(\"x0\") = v; \
         register long out asm(\"x0\"); \
         __asm__ volatile(\"add x0, x0, #1\" : \"=r\"(out) : \"r\"(in)); \
         return out; } int main(void) { return 0; }",
        Target::LinuxAarch64,
    );
    emit(
        "long f(long v) { register long in asm(\"rax\") = v; \
         register long out asm(\"rax\"); \
         __asm__ volatile(\"addq $1, %%rax\" : \"=r\"(out) : \"r\"(in)); \
         return out; } int main(void) { return 0; }",
        Target::LinuxX64,
    );
}

#[test]
fn two_inputs_on_one_fixed_register_are_accepted() {
    // Two inputs pinned to one register both read it; gcc and clang
    // accept the form (only the same-value use is meaningful).
    for (target, body) in [
        (
            crate::Target::LinuxAarch64,
            "register long a asm(\"x1\") = v; register long b asm(\"x1\") = v; \
             long out; __asm__(\"add %0, %1, %2\" : \"=r\"(out) : \"r\"(a), \"r\"(b));",
        ),
        (
            crate::Target::LinuxX64,
            "register long a asm(\"rcx\") = v; register long b asm(\"rcx\") = v; \
             long out; __asm__(\"leaq (%1,%2), %0\" : \"=r\"(out) : \"r\"(a), \"r\"(b));",
        ),
    ] {
        let src = alloc::format!(
            "long f(long v) {{ {body} return out; }} int main(void) {{ return 0; }}"
        );
        crate::Compiler::with_options(src, target, crate::CompileOptions::default())
            .compile()
            .expect("compile");
    }
}

/// Compile one source to a relocatable object and parse it, so a test can
/// assert on the symbol table the writers emit.
#[cfg(feature = "native-emit")]
fn asm_obj(src: &str, target: crate::Target) -> crate::c5::linker::relocatable::EtRel {
    use crate::{CompileOptions, NativeOptions, OutputKind, emit_native_with_options};
    let copts = CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program = crate::Compiler::with_options(src.to_string(), target, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, target, opts).expect("emit");
    crate::c5::linker::relocatable::parse_et_rel(&bytes, "a.o").expect("parse")
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_global_directive_declares_an_undefined_symbol() {
    use crate::c5::linker::relocatable::EtSymRef;
    const STB_GLOBAL: u8 = 1;
    const STT_NOTYPE: u8 = 0;
    // `arch/x86/include/asm/xen/hypercall.h` puts `.global` in the
    // instruction stream of an ordinary extended asm, naming a symbol the
    // unit does not define. GNU as 2.46.1 for
    //     .global __SCK__xen_hypercall
    // emits one undefined STB_GLOBAL STT_NOTYPE entry, value 0, size 0.
    let src = "int f(int x) { __asm__ volatile(\".global __SCK__xen_hypercall\\n\\t\" \
               \"nop\" : \"+r\"(x) :: \"memory\"); return x; } \
               int main(void) { return f(0); }";
    for target in [crate::Target::LinuxX64, crate::Target::LinuxAarch64] {
        let o = asm_obj(src, target);
        let s = o
            .symbols
            .iter()
            .find(|s| s.name == "__SCK__xen_hypercall")
            .unwrap_or_else(|| panic!("{target:?}: `.global` declared no symbol"));
        assert_eq!(s.binding, STB_GLOBAL, "{target:?}");
        assert_eq!(s.kind, STT_NOTYPE, "{target:?}");
        assert!(matches!(s.sec, EtSymRef::Undef), "{target:?}");
        assert_eq!((s.value, s.size), (0, 0), "{target:?}");
    }
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_function_body_symbol_operands_relocate() {
    use crate::c5::linker::relocatable::EtSymRef;
    use crate::c5::object::elf_reloc_types::{
        R_AARCH64_ADD_ABS_LO12_NC, R_AARCH64_ADR_PREL_LO21, R_AARCH64_ADR_PREL_PG_HI21,
        R_AARCH64_LDST8_ABS_LO12_NC, R_AARCH64_LDST32_ABS_LO12_NC, R_AARCH64_MOVW_UABS_G0_NC,
        R_AARCH64_MOVW_UABS_G1,
    };
    // Each admitted operand shape, one instruction per site: `adrp`, the
    // sized `:lo12:` load/store immediates, the `add :lo12:` form, a
    // symbol addend, `movz`/`movk` `:abs_gN:`, and `adr` of a function.
    // The rows match GNU as 2.46.1 for the same template: a static
    // resolves section-relative, an external-linkage or undefined name
    // keeps its own symbol.
    let src = "static int s_arr[4] = {1, 2, 3, 4};\n\
               int g_obj;\n\
               extern int e_obj;\n\
               __attribute__((used)) static int helper(void) { return 7; }\n\
               long f(void) {\n\
                 long a, b, c, d, e, g;\n\
                 __asm__(\"adrp %x0, s_arr\" : \"=r\"(a));\n\
                 __asm__(\"ldr %w0, [%x0, :lo12:s_arr + 8]\" : \"=r\"(b));\n\
                 __asm__(\"add %x0, %x0, :lo12:s_arr\" : \"=r\"(c));\n\
                 __asm__(\"movz %x0, :abs_g1:e_obj\\n\\tmovk %x0, :abs_g0_nc:e_obj\" : \"=r\"(d));\n\
                 __asm__(\"ldrb %w0, [%x0, :lo12:g_obj]\" : \"=r\"(e));\n\
                 __asm__(\"adr %x0, helper\" : \"=r\"(g));\n\
                 return a + b + c + d + e + g;\n\
               }\n";
    let o = asm_obj(src, crate::Target::LinuxAarch64);
    let text_idx = o
        .sections
        .iter()
        .position(|s| s.name == ".text")
        .expect(".text");
    let data_idx = o
        .sections
        .iter()
        .position(|s| s.name == ".data")
        .expect(".data");
    let s_arr = o
        .symbols
        .iter()
        .find(|s| s.name == "s_arr")
        .expect("local `s_arr` symbol")
        .value as i64;
    // (rtype, target name or owning section, addend) per row, in site order.
    let rows: alloc::vec::Vec<(u32, alloc::string::String, i64)> = o.sections[text_idx]
        .relocs
        .iter()
        .map(|r| {
            let sym = &o.symbols[r.sym as usize];
            let who = if sym.name.is_empty() {
                match sym.sec {
                    EtSymRef::Section(i) => o.sections[i].name.clone(),
                    _ => alloc::string::String::new(),
                }
            } else {
                sym.name.clone()
            };
            (r.rtype, who, r.addend)
        })
        .collect();
    let data = o.sections[data_idx].name.clone();
    let expect = [
        (R_AARCH64_ADR_PREL_PG_HI21, data.as_str(), s_arr),
        (R_AARCH64_LDST32_ABS_LO12_NC, data.as_str(), s_arr + 8),
        (R_AARCH64_ADD_ABS_LO12_NC, data.as_str(), s_arr),
        (R_AARCH64_MOVW_UABS_G1, "e_obj", 0),
        (R_AARCH64_MOVW_UABS_G0_NC, "e_obj", 0),
        (R_AARCH64_LDST8_ABS_LO12_NC, "g_obj", 0),
        (R_AARCH64_ADR_PREL_LO21, "helper", 0),
    ];
    assert_eq!(rows.len(), expect.len(), "rows: {rows:?}");
    for (row, want) in rows.iter().zip(expect.iter()) {
        assert_eq!((row.0, row.1.as_str(), row.2), *want, "rows: {rows:?}");
    }
    // The undefined extern keeps a symbol entry; the defined global its own.
    assert!(
        o.symbols
            .iter()
            .any(|s| s.name == "e_obj" && matches!(s.sec, EtSymRef::Undef))
    );
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn x86_64_riprel_const_operand_takes_any_address_constant() {
    use crate::c5::linker::relocatable::EtSymRef;
    use crate::c5::object::elf_reloc_types::R_X86_64_PC32;
    // `arch/x86/include/asm/asm.h`'s `rip_rel_ptr` names its `i`-class
    // operand under `%c`. The operand is a C99 6.6p9 address constant --
    // the address of a function or of a static-storage object, reached
    // through casts between object-pointer and integer types of the same
    // width. GNU as 2.46.1 assembles each site as
    // `leaq <symbol>(%rip), %reg`: a same-unit definition resolves
    // section-relative, a cross-TU name keeps its own symbol.
    let src = "extern int e_fn(void);\n\
               __attribute__((used)) static int s_fn(void) { return 1; }\n\
               static struct { char pad[16]; int v; } obj;\n\
               #define REL(x) ({ void *p_;\\\n\
                 __asm__(\"leaq %c1(%%rip), %0\" : \"=r\"(p_) : \"i\"((void *)(x)));\\\n\
                 p_; })\n\
               void *a(void) { return REL((unsigned long)&s_fn); }\n\
               void *b(void) { return REL((unsigned long)e_fn); }\n\
               void *c(void) { return REL((unsigned long)&obj.v); }\n";
    let o = asm_obj(src, crate::Target::LinuxX64);
    let text_idx = o
        .sections
        .iter()
        .position(|s| s.name == ".text")
        .expect(".text");
    let bss_idx = o
        .sections
        .iter()
        .position(|s| s.name == ".bss")
        .expect(".bss");
    let obj_off = o
        .symbols
        .iter()
        .find(|s| s.name == "obj")
        .expect("local `obj` symbol")
        .value as i64;
    // The `leaq` sites carry a `%c` operand each; every other row in
    // `.text` belongs to the operand's own value materialisation.
    let rows: alloc::vec::Vec<(u32, alloc::string::String, i64)> = o.sections[text_idx]
        .relocs
        .iter()
        .map(|r| {
            let sym = &o.symbols[r.sym as usize];
            let who = if sym.name.is_empty() {
                match sym.sec {
                    EtSymRef::Section(i) => o.sections[i].name.clone(),
                    _ => alloc::string::String::new(),
                }
            } else {
                sym.name.clone()
            };
            (r.rtype, who, r.addend)
        })
        .collect();
    let text = o.sections[text_idx].name.clone();
    let bss = o.sections[bss_idx].name.clone();
    for want in [
        (R_X86_64_PC32, text.as_str(), -4),
        (R_X86_64_PC32, "e_fn", -4),
        (R_X86_64_PC32, bss.as_str(), obj_off + 16 - 4),
    ] {
        assert!(
            rows.iter()
                .any(|r| (r.0, r.1.as_str(), r.2) == (want.0, want.1, want.2)),
            "missing {want:?} in {rows:?}"
        );
    }
    // A cast that narrows drops the high half, so the value is no
    // longer the address and the operand is refused.
    let narrowed = "static int obj;\n\
                    void *a(void) { void *p;\n\
                      __asm__(\"leaq %c1(%%rip), %0\" : \"=r\"(p) : \"i\"((void *)(unsigned)&obj));\n\
                      return p; }\n";
    let copts = crate::CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program =
        crate::Compiler::with_options(narrowed.to_string(), crate::Target::LinuxX64, copts)
            .compile()
            .expect("compile");
    let opts = crate::NativeOptions {
        output_kind: crate::OutputKind::Relocatable,
        ..Default::default()
    };
    let err = crate::emit_native_with_options(&program, crate::Target::LinuxX64, opts)
        .err()
        .map(|e| e.to_string())
        .unwrap_or_default();
    assert!(err.contains("not a constant or address"), "{err}");
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_symbol_operand_layout_expression_is_refused() {
    use crate::{NativeOptions, OutputKind, emit_native_with_options};
    // A label-difference addend has no value before a section layout;
    // the function-body path refuses it rather than encode a wrong one.
    let src = "static int s;\n\
               long f(void) { long v;\n\
                 __asm__(\"1:\\n\\t2:\\n\\tadrp %x0, s + (2b - 1b)\" : \"=r\"(v));\n\
                 return v; }\n";
    let copts = crate::CompileOptions {
        no_entry_point: true,
        ..Default::default()
    };
    let program =
        crate::Compiler::with_options(src.to_string(), crate::Target::LinuxAarch64, copts)
            .compile()
            .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let err = emit_native_with_options(&program, crate::Target::LinuxAarch64, opts)
        .err()
        .map(|e| e.to_string())
        .unwrap_or_default();
    assert!(err.contains("needs a section layout"), "{err}");
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_global_directive_binds_a_code_stream_label() {
    use crate::c5::linker::relocatable::EtSymRef;
    const STB_GLOBAL: u8 = 1;
    const STT_NOTYPE: u8 = 0;
    // `.global` naming a label the same template defines. GNU as 2.46.1 for
    //     .global my_alias
    //     my_alias:
    //     nop
    // gives `my_alias` STB_GLOBAL STT_NOTYPE in `.text`; without the
    // directive the label is STB_LOCAL. TODO named code-stream labels on
    // AArch64, whose template parser admits numeric labels only.
    let src = |dir: &str| {
        alloc::format!(
            "void f(void) {{ __asm__ volatile(\"{dir}my_alias:\\n\\tnop\"); }} \
             int main(void) {{ f(); return 0; }}"
        )
    };
    let o = asm_obj(&src(".global my_alias\\n\\t"), crate::Target::LinuxX64);
    let s = o
        .symbols
        .iter()
        .find(|s| s.name == "my_alias")
        .expect("`my_alias` missing");
    assert_eq!(s.binding, STB_GLOBAL);
    assert_eq!(s.kind, STT_NOTYPE);
    assert!(matches!(s.sec, EtSymRef::Section(_)));
    let plain = asm_obj(&src(""), crate::Target::LinuxX64);
    assert_eq!(
        plain
            .symbols
            .iter()
            .find(|s| s.name == "my_alias")
            .expect("`my_alias` missing")
            .binding,
        0,
        "an undeclared label stays STB_LOCAL"
    );
    // `.type` and `.size` reach the same label. GNU as 2.46.1 for
    //     .global my_fn / .type my_fn, @function / .size my_fn, 3 / my_fn:
    // gives STT_FUNC STB_GLOBAL, value 0 in `.text`, size 3.
    const STT_FUNC: u8 = 2;
    let typed = asm_obj(
        "void f(void) { __asm__ volatile(\".global my_fn\\n\\t\" \
         \".type my_fn, @function\\n\\t.size my_fn, 3\\n\\t\" \
         \"my_fn:\\n\\tnop\\n\\tnop\\n\\tnop\"); } \
         int main(void) { f(); return 0; }",
        crate::Target::LinuxX64,
    );
    let t = typed
        .symbols
        .iter()
        .find(|s| s.name == "my_fn")
        .expect("`my_fn` missing");
    assert_eq!((t.binding, t.kind, t.size), (STB_GLOBAL, STT_FUNC, 3));
    // A `.size` over the location counter needs a section's layout, which
    // the code stream does not have; the diagnostic says so.
    let program = crate::Compiler::with_options(
        "void f(void) { __asm__ volatile(\".size my_fn, .-my_fn\\n\\tmy_fn:\\n\\tnop\"); } \
         int main(void) { f(); return 0; }"
            .to_string(),
        crate::Target::LinuxX64,
        crate::CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let e = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        crate::Target::LinuxX64,
        crate::NativeOptions::default(),
    )
    .err()
    .map(|e| e.to_string())
    .unwrap_or_default();
    assert!(
        e.contains("outside a section needs a constant size"),
        "expected the location-counter diagnostic, got {e:?}"
    );
}

// Emits a native image, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn file_scope_size_reaches_a_label_of_an_earlier_statement() {
    use crate::c5::linker::relocatable::EtSymRef;
    const STB_LOCAL: u8 = 0;
    const STT_OBJECT: u8 = 1;
    // `include/linux/btf_ids.h` defines the set label in one `asm()` and
    // sizes it with `. - name` in another. GNU as 2.46.1 for the same three
    // statements emits `.BTF_ids` = 00 00 00 00 00 00 00 00 d2 04 00 00 and
    // one STB_LOCAL STT_OBJECT symbol of size 12 at offset 0 of it.
    let src = "asm(\".pushsection .BTF_ids,\\\"a\\\"\\n\"\
                   \".local __BTF_ID__set8__my_ids\\n\"\
                   \".type  __BTF_ID__set8__my_ids, @object\\n\"\
                   \"__BTF_ID__set8__my_ids:\\n\"\
                   \".zero 8\\n\"\
                   \".popsection\\n\");\
               asm(\".pushsection .BTF_ids,\\\"a\\\"\\n\"\
                   \".long 1234\\n\"\
                   \".popsection\\n\");\
               asm(\".pushsection .BTF_ids,\\\"a\\\"\\n\"\
                   \".size __BTF_ID__set8__my_ids, .-__BTF_ID__set8__my_ids\\n\"\
                   \".popsection\\n\");\
               int main(void) { return 0; }";
    for target in [crate::Target::LinuxX64, crate::Target::LinuxAarch64] {
        let o = asm_obj(src, target);
        let sec = o
            .sections
            .iter()
            .position(|s| s.name == ".BTF_ids")
            .unwrap_or_else(|| panic!("{target:?}: no `.BTF_ids`"));
        assert_eq!(
            o.sections[sec].bytes,
            [0, 0, 0, 0, 0, 0, 0, 0, 0xd2, 0x04, 0, 0],
            "{target:?}"
        );
        let s = o
            .symbols
            .iter()
            .find(|s| s.name == "__BTF_ID__set8__my_ids")
            .unwrap_or_else(|| panic!("{target:?}: set label missing"));
        assert_eq!((s.binding, s.kind), (STB_LOCAL, STT_OBJECT), "{target:?}");
        assert_eq!((s.value, s.size), (0, 12), "{target:?}");
        assert!(
            matches!(s.sec, EtSymRef::Section(i) if i == sec),
            "{target:?}"
        );
    }
}

#[test]
fn two_outputs_on_one_fixed_register_are_rejected() {
    // Two outputs cannot both leave a value in one register; gcc
    // rejects the register-variable form ("invalid hard register usage
    // between output operands") and the class-letter form alike.
    let err = |src: &str, target: crate::Target| -> alloc::string::String {
        crate::Compiler::with_options(src.to_string(), target, crate::CompileOptions::default())
            .compile()
            .err()
            .map(|e| e.to_string())
            .unwrap_or_default()
    };
    for (target, src) in [
        (
            crate::Target::LinuxAarch64,
            "long f(void) { register long a asm(\"x0\"); register long b asm(\"x0\"); \
             __asm__(\"mov x0, #7\" : \"=r\"(a), \"=r\"(b)); return a + b; } \
             int main(void) { return 0; }",
        ),
        (
            crate::Target::LinuxX64,
            "long f(void) { register long a asm(\"rax\"); register long b asm(\"rax\"); \
             __asm__(\"movq $7, %%rax\" : \"=r\"(a), \"=r\"(b)); return a + b; } \
             int main(void) { return 0; }",
        ),
        (
            crate::Target::LinuxX64,
            "long f(void) { long a, b; \
             __asm__(\"movq $7, %%rax\" : \"=a\"(a), \"=a\"(b)); return a + b; } \
             int main(void) { return 0; }",
        ),
    ] {
        let e = err(src, target);
        assert!(
            e.contains("two outputs bound to one fixed register"),
            "expected the duplicate-output diagnostic, got {e:?}"
        );
    }
}

#[test]
fn operand_wider_than_a_general_register_is_diagnosed() {
    // A 16-byte integer bound to a single-register constraint needs a
    // register pair (gcc 16 allocates an even/odd pair on aarch64 and
    // renders `%N` as its low register), which no constraint here models;
    // one register would carry only part of the value, in either
    // direction. TODO: allocate a register pair instead of rejecting.
    let err = |target: crate::Target, body: &str| -> alloc::string::String {
        let src = alloc::format!(
            "int main(void){{ unsigned __int128 v = 5; (void)v; {body} return 0; }}"
        );
        crate::Compiler::with_options(src, target, crate::CompileOptions::default())
            .compile()
            .err()
            .map(|e| e.to_string())
            .unwrap_or_default()
    };
    for target in [crate::Target::LinuxX64, crate::Target::LinuxAarch64] {
        for body in [
            "__asm__(\"# %0\" :: \"r\"(v));",
            "__asm__(\"# %0\" : \"=r\"(v));",
            "__asm__(\"# %0\" : \"+r\"(v));",
        ] {
            let e = err(target, body);
            assert!(
                e.contains("16-byte operand") && e.contains("exceeds a general register"),
                "{target:?} {body}: {e:?}"
            );
        }
    }
    // The specific-register letters bind one register just the same.
    for body in [
        "__asm__(\"# %0\" :: \"a\"(v));",
        "__asm__(\"# %0\" :: \"A\"(v));",
        "__asm__(\"# %0\" : \"=d\"(v));",
    ] {
        let e = err(crate::Target::LinuxX64, body);
        assert!(
            e.contains("16-byte operand") && e.contains("exceeds a general register"),
            "{body}: {e:?}"
        );
    }
}

#[test]
fn wide_operand_memory_and_split_spellings_stay_accepted() {
    // The workable spellings for a 16-byte value: the object through a
    // memory operand (its address), and the halves through 8-byte
    // register operands via a union.
    let src = "typedef union { unsigned __int128 v; \
                    struct { unsigned long long lo, hi; } s; } u128u; \
        int main(void) { u128u u; u.v = 5; unsigned long long r; \
            __asm__(\"# %0 %1 %2\" : \"=r\"(r) : \"r\"(u.s.lo), \"r\"(u.s.hi)); \
            __asm__(\"# %0\" :: \"m\"(u.v)); \
            return (int)r & 0; }";
    for target in [crate::Target::LinuxX64, crate::Target::LinuxAarch64] {
        crate::Compiler::with_options(src.to_string(), target, crate::CompileOptions::default())
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
    }
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_named_label_in_a_code_stream_defines_a_symbol() {
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    // GNU as makes a named label in an asm code stream a definition of the
    // unit: a `.text` NOTYPE symbol at the label's offset, local unless a
    // directive on the name rebinds it. A `.L`-prefixed name is
    // assembler-local and reaches no symbol table. Goldens from GNU as 2.46.1
    // (aarch64).
    let src = "\
        void f(void) { __asm__ volatile(\"plain:\\n\\tnop\\n\\t.Lhidden:\\n\\tnop\"); }\n\
        void g(void) { __asm__ volatile(\".globl gl\\n\\tgl:\\n\\tnop\"); }\n\
        void h(void) { __asm__ volatile(\".weak wk\\n\\twk:\\n\\tnop\"); }\n\
        void i(void) { __asm__ volatile(\".globl fx\\n\\t.type fx,%function\\n\\tfx:\\n\\tnop\"); }\n";
    let program = crate::Compiler::with_options(
        src.to_string(),
        Target::LinuxAarch64,
        crate::CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let sym = |n: &str| obj.symbols.iter().find(|s| s.name == n);
    // (binding, type): STB_LOCAL / GLOBAL / WEAK, STT_NOTYPE / FUNC.
    for (name, bind, kind) in [
        ("plain", 0u8, 0u8),
        ("gl", 1, 0),
        ("wk", 2, 0),
        ("fx", 1, 2),
    ] {
        let s = sym(name).unwrap_or_else(|| panic!("`{name}` must be defined"));
        assert_eq!(s.binding, bind, "`{name}` binding");
        assert_eq!(s.kind, kind, "`{name}` type");
        assert!(
            matches!(s.section, NativeSymSection::Text),
            "`{name}` must be defined in `.text`: {:?}",
            s.section
        );
    }
    assert!(
        sym(".Lhidden").is_none(),
        "a `.L`-prefixed label is assembler-local and defines no symbol"
    );
    assert_eq!(
        sym("plain").unwrap().value,
        sym("f").expect("f").value,
        "`plain:` stands at the offset it was written at"
    );
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_branch_to_a_named_label_resolves_in_the_code_stream() {
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    // A branch whose target the same template defines resolves to a
    // displacement and carries no relocation, as GNU as does; `b` back one
    // word encodes 0x17FFFFFF.
    let src = "void f(void) { __asm__ volatile(\"lp:\\n\\tnop\\n\\tb lp\"); }\n";
    let program = crate::Compiler::with_options(
        src.to_string(),
        Target::LinuxAarch64,
        crate::CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let lp = obj.symbols.iter().find(|s| s.name == "lp").expect("lp");
    let at = lp.value as usize + 4;
    let word = u32::from_le_bytes([
        obj.text[at],
        obj.text[at + 1],
        obj.text[at + 2],
        obj.text[at + 3],
    ]);
    assert_eq!(word, 0x17FF_FFFF, "`b lp` must encode the in-stream branch");
    assert!(
        !obj.text_relocs.iter().any(|r| r.offset == at as u64),
        "a branch to a template label carries no relocation"
    );
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn a_duplicate_named_label_in_a_code_stream_is_rejected() {
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    // GNU as rejects a second definition of a name, within one template and
    // across the unit's templates alike; both targets must agree.
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        for src in [
            "void f(void) { __asm__ volatile(\"dup:\\n\\tnop\\n\\tdup:\\n\\tnop\"); }\n",
            "void f(void) { __asm__ volatile(\"dup:\\n\\tnop\"); \
                __asm__ volatile(\"dup:\\n\\tnop\"); }\n",
        ] {
            let program = crate::Compiler::with_options(
                src.to_string(),
                target,
                crate::CompileOptions::default().with_no_entry_point(true),
            )
            .compile()
            .expect("compile");
            let opts = NativeOptions {
                output_kind: OutputKind::Relocatable,
                ..Default::default()
            };
            let e = emit_native_with_options(&program, target, opts)
                .err()
                .unwrap_or_else(|| panic!("{target:?}: a duplicate definition must be rejected"));
            assert!(
                alloc::format!("{e}").contains("`dup` is already defined"),
                "{target:?}: {e}"
            );
        }
    }
}

/// The bytes and relocations of one section of a compiled object.
#[cfg(feature = "native-emit")]
fn asm_section(
    src: &str,
    name: &str,
) -> (
    alloc::vec::Vec<u8>,
    alloc::vec::Vec<(u64, u32, alloc::string::String)>,
) {
    let o = asm_obj(src, crate::Target::LinuxAarch64);
    let s = o
        .sections
        .iter()
        .find(|s| s.name == name)
        .unwrap_or_else(|| panic!("section `{name}` emitted"));
    let relocs = s
        .relocs
        .iter()
        .map(|r| (r.offset, r.rtype, o.symbols[r.sym as usize].name.clone()))
        .collect();
    (s.bytes.clone(), relocs)
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_pushsection_assembles_instructions_in_both_positions() {
    use crate::c5::object::elf_reloc_types::{
        R_AARCH64_ADD_ABS_LO12_NC, R_AARCH64_ADR_PREL_PG_HI21, R_AARCH64_CALL26,
    };
    // A pushed executable section holding instructions, at file scope and in a
    // function body. GNU as 2.46.1 for the same statements emits 24 bytes --
    // `nop`, `mov x0, x1`, `b 1b` resolved in place, `bl other`, `adrp x2, g`,
    // `add x2, x2, :lo12:g` -- with three relocations at 0x0c, 0x10 and 0x14.
    let body = ".pushsection .text.alt,\\\"ax\\\"\\n\
                1:\\n\\tnop\\n\\tmov x0, x1\\n\\tb 1b\\n\\tbl other\\n\
                \\tadrp x2, g\\n\\tadd x2, x2, :lo12:g\\n\\t.popsection";
    let want: alloc::vec::Vec<u8> = [
        0xd503201fu32, // nop
        0xaa0103e0,    // mov x0, x1
        0x17fffffe,    // b 1b
        0x94000000,    // bl other
        0x90000002,    // adrp x2, g
        0x91000042,    // add x2, x2, :lo12:g
    ]
    .iter()
    .flat_map(|w| w.to_le_bytes())
    .collect();
    let want_relocs = [
        (0x0cu64, R_AARCH64_CALL26, "other"),
        (0x10, R_AARCH64_ADR_PREL_PG_HI21, "g"),
        (0x14, R_AARCH64_ADD_ABS_LO12_NC, "g"),
    ];
    for src in [
        alloc::format!("extern void other(void);\nint g;\n__asm__(\"{body}\");\n"),
        alloc::format!(
            "extern void other(void);\nint g;\n\
             void probe(void) {{ __asm__ volatile(\"{body}\"); }}\n"
        ),
    ] {
        let (bytes, relocs) = asm_section(&src, ".text.alt");
        assert_eq!(bytes, want, "{src}");
        let got: alloc::vec::Vec<_> = relocs
            .iter()
            .map(|(o, t, n)| (*o, *t, n.as_str()))
            .collect();
        assert_eq!(got, want_relocs, "{src}");
    }
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_pushsection_reads_the_enclosing_template_operands() {
    // A pushed section inside a function body resolves the template's
    // operands: `%c0` takes the constant, and `%0` takes the register the
    // enclosing stream was given, so the same statement encodes identically
    // in both places.
    let src = "void probe(long v) { __asm__ volatile(\
               \"mov x9, %0\\n\\t.pushsection .text.alt,\\\"ax\\\"\\n\
               \\tmov x9, %0\\n\\tmov x0, %c1\\n\\t.popsection\" :: \"r\"(v), \"i\"(7)); }\n";
    let (alt, _) = asm_section(src, ".text.alt");
    let (text, _) = asm_section(src, ".text");
    // `movz x0, #7`, which GNU as 2.46.1 emits for `mov x0, 7`.
    assert_eq!(&alt[4..8], &0xd28000e0u32.to_le_bytes());
    assert!(
        text.windows(4).any(|w| w == &alt[..4]),
        "the section instruction must use the operand's register"
    );
}

/// Relocation target name: the symbol's own name, or the target section's
/// for an STT_SECTION entry.
#[cfg(feature = "native-emit")]
fn reloc_target_name(o: &crate::c5::linker::relocatable::EtRel, sym: u32) -> alloc::string::String {
    let s = &o.symbols[sym as usize];
    if s.name.is_empty()
        && let crate::c5::linker::relocatable::EtSymRef::Section(ci) = s.sec
    {
        return o.sections[ci].name.clone();
    }
    s.name.clone()
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_template_symbol_branches_type_bl_call26_and_b_jump26() {
    use crate::c5::object::elf_reloc_types::{R_AARCH64_CALL26, R_AARCH64_JUMP26};
    // GNU as types the imm26 field by the instruction: `bl` takes CALL26,
    // a plain `b` JUMP26. gcc 14 on this unit emits the same pair, and the
    // branch to the template's own named label resolves without a reloc.
    let src = "extern void helper(void);\nextern void other(void);\n\
               void probe(void) { __asm__ volatile(\
               \"bl helper\\n\\tb other\\n\\tb past\\npast:\\n\\tnop\" ::: \"x30\"); }\n";
    let (_, relocs) = asm_section(src, ".text");
    let branches: alloc::vec::Vec<(u32, &str)> = relocs
        .iter()
        .filter(|(_, t, _)| matches!(*t, R_AARCH64_CALL26 | R_AARCH64_JUMP26))
        .map(|(_, t, n)| (*t, n.as_str()))
        .collect();
    assert_eq!(
        branches,
        [(R_AARCH64_CALL26, "helper"), (R_AARCH64_JUMP26, "other")]
    );
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_goto_branch_in_a_pushed_section_reaches_the_label_block() {
    use crate::c5::object::elf_reloc_types::{R_AARCH64_CONDBR19, R_AARCH64_JUMP26};
    // The `_static_cpu_has` shape on A64: a pushed executable section
    // branches to an `asm goto` label (`b %l[out]`). The section holds one
    // `b` word with a zero displacement and a JUMP26 into `.text`; the main
    // stream reaches the section through its own conditional.
    let src = "int probe(int x)\n\
               {\n\
                   __asm__ goto(\".pushsection .text.cold,\\\"ax\\\"\\n\"\n\
                                \"cold:\\n\\tb %l[out]\\n\\t\"\n\
                                \".popsection\\n\\t\"\n\
                                \"cbz %w0, cold\"\n\
                                :: \"r\"(x) :: out);\n\
                   return 1;\n\
               out:\n\
                   return 0;\n\
               }\n";
    let o = asm_obj(src, crate::Target::LinuxAarch64);
    let cold = o
        .sections
        .iter()
        .find(|s| s.name == ".text.cold")
        .expect(".text.cold emitted");
    assert_eq!(cold.bytes, 0x14000000u32.to_le_bytes(), "`b 0` placeholder");
    let text_len = o
        .sections
        .iter()
        .find(|s| s.name == ".text")
        .map(|s| s.bytes.len() as i64)
        .unwrap();
    let [r] = cold.relocs.as_slice() else {
        panic!("one branch reloc, got {:?}", cold.relocs);
    };
    assert_eq!(
        (r.rtype, reloc_target_name(&o, r.sym).as_str()),
        (R_AARCH64_JUMP26, ".text")
    );
    assert!(
        (0..text_len).contains(&r.addend),
        "the branch lands in the function's text, got addend {}",
        r.addend
    );
    let text = o.sections.iter().find(|s| s.name == ".text").unwrap();
    assert!(
        text.relocs
            .iter()
            .any(|r| r.rtype == R_AARCH64_CONDBR19 && reloc_target_name(&o, r.sym) == ".text.cold"),
        "the conditional relocates into the pushed section"
    );
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_numeric_branch_into_a_pushed_section_relocates_to_it() {
    use crate::c5::object::elf_reloc_types::{R_AARCH64_CONDBR19, R_AARCH64_JUMP26};
    // A numeric forward reference whose definition sits in the statement's
    // pushed section (the `jmp 6f` fixup shape). GNU as puts the two in
    // different object sections, so each branch relocates against the
    // section with the label's offset as addend.
    let src = "void probe(long x)\n\
               {\n\
                   __asm__ volatile(\"b 1f\\n\\tcbz %0, 1f\\n\\t\"\n\
                                    \".pushsection .text.fix,\\\"ax\\\"\\n\"\n\
                                    \"\\tnop\\n1:\\tret\\n\\t\"\n\
                                    \".popsection\" :: \"r\"(x));\n\
               }\n";
    let o = asm_obj(src, crate::Target::LinuxAarch64);
    let text = o.sections.iter().find(|s| s.name == ".text").unwrap();
    let hits: alloc::vec::Vec<(u32, i64)> = text
        .relocs
        .iter()
        .filter(|r| reloc_target_name(&o, r.sym) == ".text.fix")
        .map(|r| (r.rtype, r.addend))
        .collect();
    assert_eq!(hits, [(R_AARCH64_JUMP26, 4), (R_AARCH64_CONDBR19, 4)]);
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_function_body_layout_directives_match_gnu_as() {
    // `.balign` / `.skip` / `.org` in the main instruction stream. GNU as
    // 2.46.1 for the same statements in a `.text` body emits 44 bytes: the
    // `.balign 16` pads with three NOP words, the `.skip` deposits eight
    // zeros, the instruction after them is already word-aligned, and the
    // `.org` pads to twelve bytes past the label.
    let src = "__attribute__((naked)) void probe(void);\n\
               __attribute__((naked)) void probe(void) { __asm__ volatile(\
               \"nop\\n\\t.balign 16\\n\\tnop\\n\\t.skip 8\\n\
               2:\\n\\tnop\\n\\t.org 2b + 12\\n\\tnop\"); }\n";
    let mut want: alloc::vec::Vec<u8> = alloc::vec::Vec::new();
    for _ in 0..5 {
        want.extend_from_slice(&0xd503201fu32.to_le_bytes());
    }
    want.resize(28, 0);
    want.extend_from_slice(&0xd503201fu32.to_le_bytes());
    want.resize(40, 0);
    want.extend_from_slice(&0xd503201fu32.to_le_bytes());
    let (bytes, _) = asm_section(src, ".text");
    assert_eq!(bytes, want);
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn aarch64_alignment_fill_max_skip_and_zero_match_gnu_as() {
    // An explicit fill byte, a max skip that drops the alignment, a sub-word
    // gap after data, and the zero alignment GNU as reads as one. 2.46.1 for
    // the same statements emits 28 bytes.
    let src = "__attribute__((naked)) void probe(void);\n\
               __attribute__((naked)) void probe(void) { __asm__ volatile(\
               \"nop\\n\\t.balign 16, 0\\n\\tnop\\n\\t.balign 16, , 2\\n\
               \\t.byte 7\\n\\t.balign 8\\n\\t.align 0\\n\\t.balign 0\\n\\tnop\"); }\n";
    let mut want: alloc::vec::Vec<u8> = 0xd503201fu32.to_le_bytes().to_vec();
    want.resize(16, 0);
    want.extend_from_slice(&0xd503201fu32.to_le_bytes());
    want.push(7);
    want.resize(24, 0);
    want.extend_from_slice(&0xd503201fu32.to_le_bytes());
    let (bytes, _) = asm_section(src, ".text");
    assert_eq!(bytes, want);
}

/// The alignment item a template parser makes of `tmpl`, or `None` when the
/// parse rejects it or reads it as something other than a layout directive.
fn stream_align_item(
    tmpl: &str,
    aarch64: bool,
) -> Option<crate::c5::codegen::ssa::emit_common::AsmSectionItem> {
    let b = tmpl.as_bytes();
    if aarch64 {
        crate::c5::codegen::aarch64::asm::parse_template(b)
            .ok()?
            .first()?
            .layout
            .clone()
    } else {
        crate::c5::codegen::x86_64::asm::parse_template(b)
            .ok()?
            .first()?
            .layout
            .clone()
    }
}

#[test]
fn alignment_directive_family_reads_one_grammar_everywhere() {
    // The section engine, the x86-64 template parser and the AArch64 template
    // parser have to admit the same alignment directives and read the same
    // item out of them; a form one accepts and another rejects, or reads
    // differently, is the defect the shared parse exists to rule out.
    use crate::c5::codegen::ssa::emit_common::parse_stream_layout_item;
    let ok = [
        ".balign 16",
        ".balign 16, 0xff",
        ".balign 16, 0xff, 3",
        ".balign 0",
        ".balign 2b-1b",
        ".balign (2b-1b)*2",
        ".balignw 16, 0x1234",
        ".balignl 16, 0x12345678",
        ".balignw 16",
        ".balignl 16",
        ".p2align 4",
        ".p2align 4,,7",
        ".p2align 4, 0x90, 7",
        ".p2align 2b-1b",
        ".p2alignw 4, 0x1234",
        ".p2alignl 4, 0x12345678",
        ".align 0",
        ".align 2b-1b",
    ];
    // GNU as has no `w` / `l` spelling of `.align`, rejects a non-power-of-two
    // byte count and an out-of-range exponent, and takes at most three
    // operands. A count past the section-offset width has no layout either.
    let bad = [
        ".alignw 8",
        ".alignl 8",
        ".balign 3",
        ".balignl 3",
        ".p2align 13",
        ".p2alignl 13",
        ".balign 16, 0xff, 3, 4",
        ".balign 2b -",
        ".balign 8589934592",
    ];
    for t in ok.iter().chain(bad.iter()) {
        let (tok, rest) = t.split_once(' ').unwrap_or((t, ""));
        let want_ok = ok.contains(t);
        for (aarch64, arch) in [(false, "x86_64"), (true, "aarch64")] {
            let sec = match parse_stream_layout_item(tok, rest.trim(), aarch64) {
                Some(Ok(item)) => Some(item),
                _ => None,
            };
            assert_eq!(sec.is_some(), want_ok, "section engine `{t}` ({arch})");
            assert_eq!(
                stream_align_item(t, aarch64),
                sec,
                "template vs section engine `{t}` ({arch})"
            );
        }
    }
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn alignment_fill_width_family_matches_gnu_as() {
    // `.balignw` / `.balignl` / `.p2alignw` / `.p2alignl` repeat a 2- or
    // 4-byte little-endian fill over the gap, truncating a wider value; with
    // no fill they pad like the unsuffixed spelling. GNU as 2.46.1 emits
    // these bytes for the same statements.
    let sec = |body: &str| {
        let src = alloc::format!("__asm__(\".section .t,\\\"a\\\"\\n\" \"{body}\");\n");
        asm_section(&src, ".t").0
    };
    let cases: &[(&str, &[u8])] = &[
        (
            ".byte 0x11,0x22,0x33,0x44\\n .balignl 16, 0x12345678\\n .byte 0xbb\\n",
            &[
                0x11, 0x22, 0x33, 0x44, 0x78, 0x56, 0x34, 0x12, 0x78, 0x56, 0x34, 0x12, 0x78, 0x56,
                0x34, 0x12, 0xbb,
            ],
        ),
        (
            ".byte 0x11,0x22\\n .balignw 8, 0x1234\\n .byte 0xbb\\n",
            &[0x11, 0x22, 0x34, 0x12, 0x34, 0x12, 0x34, 0x12, 0xbb],
        ),
        (
            ".byte 0x11,0x22,0x33,0x44\\n .p2alignw 4, 0x1234\\n .byte 0xbb\\n",
            &[
                0x11, 0x22, 0x33, 0x44, 0x34, 0x12, 0x34, 0x12, 0x34, 0x12, 0x34, 0x12, 0x34, 0x12,
                0x34, 0x12, 0xbb,
            ],
        ),
        // A fill wider than the unit keeps the low bytes.
        (
            ".byte 0x11,0x22,0x33,0x44\\n .balignl 8, 0x123456789\\n .byte 0xbb\\n",
            &[0x11, 0x22, 0x33, 0x44, 0x89, 0x67, 0x45, 0x23, 0xbb],
        ),
        (
            ".byte 0x11,0x22,0x33,0x44\\n .balignw 8, 0x12345\\n .byte 0xbb\\n",
            &[0x11, 0x22, 0x33, 0x44, 0x45, 0x23, 0x45, 0x23, 0xbb],
        ),
        // No fill operand: the section default, as for `.balign` itself.
        (
            ".byte 0x11,0x22,0x33,0x44\\n .balignl 8\\n .byte 0xbb\\n",
            &[0x11, 0x22, 0x33, 0x44, 0, 0, 0, 0, 0xbb],
        ),
        // A max skip drops the padding, so the gap width never comes up.
        (
            ".byte 0x11,0x22,0x33\\n .balignl 16, 0x12345678, 2\\n .byte 0xbb\\n",
            &[0x11, 0x22, 0x33, 0xbb],
        ),
    ];
    for (body, want) in cases {
        assert_eq!(&sec(body)[..], *want, "`{body}`");
    }
}

#[cfg(feature = "native-emit")]
#[test]
fn alignment_fill_width_rejects_a_partial_unit() {
    // GNU as errors when the padding is not a whole number of fill units.
    for (d, w) in [(".balignl 16, 0x12345678", 4), (".p2alignw 4, 0x1234", 2)] {
        let src = alloc::format!(
            "__asm__(\".section .t,\\\"a\\\"\\n\" \" .byte 0x11\\n {d}\\n .byte 0xbb\\n\");\n"
        );
        let e = alloc::format!(
            "{:?}",
            crate::Compiler::with_target(src, crate::Target::LinuxAarch64)
                .compile()
                .err()
        );
        assert!(e.contains(&alloc::format!("not a multiple of {w}")), "{e}");
    }
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn alignment_over_a_label_difference_matches_gnu_as() {
    // A backward label difference is a constant where the directive stands,
    // so it is an alignment operand like any other. GNU as 2.46.1 emits these
    // bytes; the padding is the section's default fill, which is the AArch64
    // NOP only for a gap of whole instructions.
    let sec = |body: &str, flags: &str| {
        let src = alloc::format!("__asm__(\".section .t,\\\"{flags}\\\"\\n\" \"{body}\");\n");
        asm_section(&src, ".t").0
    };
    let head = " 1: .byte 0x11,0x22,0x33,0x44\\n 2:\\n .byte 0xaa\\n";
    let cases: &[(&str, &str, &[u8])] = &[
        // `2b-1b` is 4: three bytes of padding to the next multiple.
        (
            ".balign 2b-1b",
            "a",
            &[0x11, 0x22, 0x33, 0x44, 0xaa, 0, 0, 0, 0xbb],
        ),
        (
            ".balign (2b-1b)",
            "a",
            &[0x11, 0x22, 0x33, 0x44, 0xaa, 0, 0, 0, 0xbb],
        ),
        // The expression is the whole GNU as grammar, not just a difference.
        (
            ".balign (2b-1b)*2",
            "a",
            &[0x11, 0x22, 0x33, 0x44, 0xaa, 0, 0, 0, 0xbb],
        ),
        (
            ".balign 2b-1b, 0x55",
            "a",
            &[0x11, 0x22, 0x33, 0x44, 0xaa, 0x55, 0x55, 0x55, 0xbb],
        ),
        // `.p2align 4` is a 16-byte boundary: eleven bytes of padding, whose
        // whole instructions are NOPs in an executable section.
        (
            ".p2align 2b-1b",
            "ax",
            &[
                0x11, 0x22, 0x33, 0x44, 0xaa, 0, 0, 0, 0x1f, 0x20, 0x03, 0xd5, 0x1f, 0x20, 0x03,
                0xd5, 0xbb,
            ],
        ),
        // `.align`'s operand is an exponent on AArch64, so this is 16 too.
        (
            ".align 2b-1b",
            "ax",
            &[
                0x11, 0x22, 0x33, 0x44, 0xaa, 0, 0, 0, 0x1f, 0x20, 0x03, 0xd5, 0x1f, 0x20, 0x03,
                0xd5, 0xbb,
            ],
        ),
    ];
    for (d, flags, want) in cases {
        let body = alloc::format!("{head} {d}\\n .byte 0xbb\\n");
        assert_eq!(&sec(&body, flags)[..], *want, "`{d}`");
    }
}

// Emits a relocatable object, so it needs `native-emit`.
#[cfg(feature = "native-emit")]
#[test]
fn alignment_over_labels_settles_after_a_deferred_fill_count() {
    // A first measuring round takes an unresolved `.skip` count as zero
    // length, which moves the offsets an alignment operand reads. Here that
    // makes `8b-7b` three in the first round and four in the second, so the
    // operand's range is judged only once the layout has settled.
    let src = "__asm__(\".section .t,\\\"a\\\"\\n\"\n\
               \" 7: .byte 0x11,0x22,0x33\\n .skip 4f-3f\\n 8:\\n\"\n\
               \" .byte 0xaa\\n .balign 8b-7b\\n .byte 0xbb\\n\"\n\
               \" 3: .byte 0x99\\n 4:\\n\");\n";
    assert_eq!(
        asm_section(src, ".t").0,
        [0x11, 0x22, 0x33, 0, 0xaa, 0, 0, 0, 0xbb, 0x99]
    );
}

#[cfg(feature = "native-emit")]
#[test]
fn alignment_over_a_forward_label_difference_is_rejected() {
    // GNU as reduces an alignment operand where the directive stands, so a
    // definition placed after it has no value there and the directive is an
    // error rather than a layout the assembler iterates towards.
    for d in [".balign 4f-3f", ".p2align 4f-3f", ".align 4f-3f"] {
        let src = alloc::format!(
            "__asm__(\".section .t,\\\"a\\\"\\n\" \" .byte 0xaa\\n {d}\\n\
             \\n .byte 0xbb\\n 3: .byte 0,0,0,0\\n 4:\\n\");\n"
        );
        let e = alloc::format!(
            "{:?}",
            crate::Compiler::with_target(src, crate::Target::LinuxAarch64)
                .compile()
                .err()
        );
        assert!(e.contains("is not constant where it stands"), "`{d}`: {e}");
    }
}
