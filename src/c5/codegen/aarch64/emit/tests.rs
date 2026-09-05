mod asm_scratch_tests {
    use super::super::super::ir::{AsmBlock, AsmConstraint, AsmOperand, AsmSeg};
    use super::*;

    fn asm_func(template: &str) -> FunctionSsa {
        let asm = AsmBlock {
            template: template.as_bytes().to_vec(),
            operands: alloc::vec![AsmOperand {
                constraint: AsmConstraint::Reg,
                is_output: false,
                is_rw: false,
                width: 8,
                seg: AsmSeg::None,
            }],
            clobber_regs: 0,
            clobber_fp_regs: 0,
            clobber_memory: true,
            volatile: true,
        };
        FunctionSsa {
            insts: alloc::vec![
                Inst::Imm(0),
                Inst::InlineAsm {
                    asm: alloc::boxed::Box::new(asm),
                    args: alloc::vec![0],
                },
            ],
            ..Default::default()
        }
    }

    /// A no-op template reserves no frame scratch; the same statement
    /// with one instruction reserves the operand's save + capture slots.
    #[test]
    fn noop_template_needs_no_scratch() {
        assert_eq!(
            asm_scratch_bytes(&asm_func(""), crate::c5::codegen::FixedRegs::NONE),
            0
        );
        assert_eq!(
            asm_scratch_bytes(&asm_func("// note ;"), crate::c5::codegen::FixedRegs::NONE),
            0
        );
        assert!(asm_scratch_bytes(&asm_func("nop"), crate::c5::codegen::FixedRegs::NONE) > 0);
    }
}

use super::*;
use crate::Compiler;
use crate::c5::asm::AsmSectionSink;

/// File-scope section instructions referencing symbols encode to the
/// words and relocations GNU as emits (byte-verified against `as`):
/// same-section branches, `adr`, and the literal `ldr` fold with no
/// relocation; `adrp` / `:lo12:` / `bl ext` keep theirs.
#[test]
fn file_scope_a64_symbol_relocs_match_gnu_as() {
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::materialize_asm_sections;
    use crate::c5::asm::{AsmRelocKind, AsmSectionTarget};
    let text = ".pushsection .t,\"ax\"\nf1:\n1:\ncbz x0, 2f\nb 1b\n2:\nb.eq 1b\n\
                tbz x0, #3, 1b\nadr x1, 2b\nldr x2, 2b\nadrp x3, ext_obj\n\
                add x3, x3, :lo12:ext_obj\nldr x4, [x3, :lo12:ext_obj]\n\
                ldrb w5, [x3, :lo12:ext_obj]\nbl ext_func\nret\n.popsection\n";
    let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
    encode_a64_file_asm_section_code(&mut blocks).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )
    .unwrap();
    // GNU as words for the same input (opcodes at each instruction).
    let want_words: [u32; 12] = [
        0xb4000040, // cbz x0, 2f (+8)
        0x17ffffff, // b 1b (-4)
        0x54ffffc0, // b.eq 1b (-8)
        0x361fffa0, // tbz x0,#3,1b (-12)
        0x10ffffc1, // adr x1, 2b (-8)
        0x58ffffa2, // ldr x2, 2b (-12)
        0x90000003, // adrp x3, ext_obj
        0x91000063, // add x3, x3, :lo12:ext_obj
        0xf9400064, // ldr x4, [x3, :lo12:ext_obj]
        0x39400065, // ldrb w5, [x3, :lo12:ext_obj]
        0x94000000, // bl ext_func
        0xd65f03c0, // ret
    ];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
    let kinds: Vec<(u32, AsmRelocKind, &str)> = sec
        .relocs
        .iter()
        .map(|r| {
            let AsmSectionTarget::Symbol(n) = &r.target else {
                panic!("symbol target expected, got {:?}", r.target)
            };
            (r.offset, r.kind, n.as_str())
        })
        .collect();
    assert_eq!(
        kinds,
        vec![
            (24, AsmRelocKind::A64AdrpPage21, "ext_obj"),
            (28, AsmRelocKind::A64AddLo12, "ext_obj"),
            (32, AsmRelocKind::A64LdstLo12(8), "ext_obj"),
            (36, AsmRelocKind::A64LdstLo12(1), "ext_obj"),
            (40, AsmRelocKind::A64Branch26 { link: true }, "ext_func"),
        ]
    );
}

/// The SIMD forms the crypto and CRC units need encode to the words GNU as
/// emits: the bit-select group, shift-and-insert by immediate across every
/// arrangement, the SHA1 / SHA512 updates, register-pair load/store in the
/// s / d / q views with all three addressing modes, and the `mov` aliases
/// of the element insert / duplicate / extract forms.
#[test]
fn file_scope_a64_simd_match_gnu_as() {
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::materialize_asm_sections;
    let text = ".pushsection .t,\"ax\"\n\
                bsl v1.16b, v2.16b, v3.16b\n\
                bit v1.16b, v2.16b, v3.16b\n\
                bif v2.16b, v7.16b, v22.16b\n\
                bsl v1.8b, v2.8b, v3.8b\n\
                bif v5.8b, v6.8b, v11.8b\n\
                sri v1.4s, v17.4s, #20\n\
                sri v1.4s, v17.4s, #1\n\
                sri v1.4s, v4.4s, #32\n\
                sri v3.8b, v17.8b, #1\n\
                sri v3.8b, v17.8b, #8\n\
                sri v3.8h, v17.8h, #16\n\
                sri v3.2d, v17.2d, #64\n\
                sri v3.2d, v17.2d, #1\n\
                sri v3.16b, v17.16b, #3\n\
                sha1su0 v0.4s, v1.4s, v2.4s\n\
                sha1su1 v0.4s, v3.4s\n\
                sha512h q3, q6, v7.2d\n\
                sha512h2 q3, q1, v0.2d\n\
                sha512su0 v0.2d, v1.2d\n\
                sha512su1 v0.2d, v2.2d, v5.2d\n\
                ldp q0, q1, [x2]\n\
                ldp q0, q1, [x2, #16]\n\
                ldp q11, q12, [x3], #0x20\n\
                ldp q16, q17, [x4, #-128]!\n\
                ldp q18, q19, [x5, #-96]\n\
                stp q0, q1, [x2]\n\
                stp q6, q7, [sp, #32]\n\
                stp q11, q12, [x3], #0x20\n\
                stp q16, q17, [x4, #-128]!\n\
                ldp s0, s1, [x2, #8]\n\
                ldp d0, d1, [x2, #16]\n\
                stp d2, d3, [x2, #-16]!\n\
                sli v1.4s, v17.4s, #20\n\
                sli v3.8b, v17.8b, #0\n\
                sli v3.2d, v17.2d, #63\n\
                sri v1.2s, v2.2s, #12\n\
                sri v1.4h, v2.4h, #5\n\
                mov d19, v0.d[1]\n\
                mov s3, v7.s[2]\n\
                mov v17.d[1], v19.d[0]\n\
                mov v2.h[2], v5.h[0]\n\
                mov v2.b[15], v5.b[3]\n\
                mov v2.s[1], v5.s[3]\n\
                ins v17.d[1], v19.d[0]\n\
                dup d19, v0.d[1]\n\
                mov v3.d[0], x5\n\
                mov x5, v3.d[1]\n\
                mov w5, v3.s[2]\n\
                .popsection\n";
    let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
    encode_a64_file_asm_section_code(&mut blocks).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )
    .unwrap();
    let want_words: [u32; 48] = [
        0x6e631c41, // bsl v1.16b, v2.16b, v3.16b
        0x6ea31c41, // bit v1.16b, v2.16b, v3.16b
        0x6ef61ce2, // bif v2.16b, v7.16b, v22.16b
        0x2e631c41, // bsl v1.8b, v2.8b, v3.8b
        0x2eeb1cc5, // bif v5.8b, v6.8b, v11.8b
        0x6f2c4621, // sri v1.4s, v17.4s, #20
        0x6f3f4621, // sri v1.4s, v17.4s, #1
        0x6f204481, // sri v1.4s, v4.4s, #32
        0x2f0f4623, // sri v3.8b, v17.8b, #1
        0x2f084623, // sri v3.8b, v17.8b, #8
        0x6f104623, // sri v3.8h, v17.8h, #16
        0x6f404623, // sri v3.2d, v17.2d, #64
        0x6f7f4623, // sri v3.2d, v17.2d, #1
        0x6f0d4623, // sri v3.16b, v17.16b, #3
        0x5e023020, // sha1su0 v0.4s, v1.4s, v2.4s
        0x5e281860, // sha1su1 v0.4s, v3.4s
        0xce6780c3, // sha512h q3, q6, v7.2d
        0xce608423, // sha512h2 q3, q1, v0.2d
        0xcec08020, // sha512su0 v0.2d, v1.2d
        0xce658840, // sha512su1 v0.2d, v2.2d, v5.2d
        0xad400440, // ldp q0, q1, [x2]
        0xad408440, // ldp q0, q1, [x2, #16]
        0xacc1306b, // ldp q11, q12, [x3], #0x20
        0xadfc4490, // ldp q16, q17, [x4, #-128]!
        0xad7d4cb2, // ldp q18, q19, [x5, #-96]
        0xad000440, // stp q0, q1, [x2]
        0xad011fe6, // stp q6, q7, [sp, #32]
        0xac81306b, // stp q11, q12, [x3], #0x20
        0xadbc4490, // stp q16, q17, [x4, #-128]!
        0x2d410440, // ldp s0, s1, [x2, #8]
        0x6d410440, // ldp d0, d1, [x2, #16]
        0x6dbf0c42, // stp d2, d3, [x2, #-16]!
        0x6f345621, // sli v1.4s, v17.4s, #20
        0x2f085623, // sli v3.8b, v17.8b, #0
        0x6f7f5623, // sli v3.2d, v17.2d, #63
        0x2f344441, // sri v1.2s, v2.2s, #12
        0x2f1b4441, // sri v1.4h, v2.4h, #5
        0x5e180413, // mov d19, v0.d[1]
        0x5e1404e3, // mov s3, v7.s[2]
        0x6e180671, // mov v17.d[1], v19.d[0]
        0x6e0a04a2, // mov v2.h[2], v5.h[0]
        0x6e1f1ca2, // mov v2.b[15], v5.b[3]
        0x6e0c64a2, // mov v2.s[1], v5.s[3]
        0x6e180671, // ins v17.d[1], v19.d[0]
        0x5e180413, // dup d19, v0.d[1]
        0x4e081ca3, // mov v3.d[0], x5
        0x4e183c65, // mov x5, v3.d[1]
        0x0e143c65, // mov w5, v3.s[2]
    ];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
}

/// Lane broadcast to a vector, the SIMD bit reverse, and `uxtw`. The
/// broadcast shares the scalar form's imm5 but takes Q from the
/// arrangement; `rbit` is byte arrangements only; `uxtw` is the 32-bit
/// `orr`, whose W-register write does the widening.
#[test]
fn file_scope_a64_dup_rbit_uxtw_match_gnu_as() {
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::materialize_asm_sections;
    let text = ".pushsection .t,\"ax\"\n\
                dup v12.4s, v14.s[0]\n\
                dup v0.4s, v0.s[3]\n\
                dup v31.2s, v31.s[1]\n\
                dup v1.8h, v2.h[7]\n\
                dup v1.4h, v2.h[3]\n\
                dup v3.16b, v4.b[15]\n\
                dup v3.8b, v4.b[0]\n\
                dup v5.2d, v6.d[1]\n\
                rbit v16.16b, v0.16b\n\
                rbit v0.8b, v1.8b\n\
                rbit v31.16b, v31.16b\n\
                uxtw x5, w5\n\
                uxtw x0, w1\n\
                .popsection\n";
    let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
    encode_a64_file_asm_section_code(&mut blocks).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )
    .unwrap();
    let want_words: [u32; 13] = [
        0x4e0405cc, // dup v12.4s, v14.s[0]
        0x4e1c0400, // dup v0.4s, v0.s[3]
        0x0e0c07ff, // dup v31.2s, v31.s[1]
        0x4e1e0441, // dup v1.8h, v2.h[7]
        0x0e0e0441, // dup v1.4h, v2.h[3]
        0x4e1f0483, // dup v3.16b, v4.b[15]
        0x0e010483, // dup v3.8b, v4.b[0]
        0x4e1804c5, // dup v5.2d, v6.d[1]
        0x6e605810, // rbit v16.16b, v0.16b
        0x2e605820, // rbit v0.8b, v1.8b
        0x6e605bff, // rbit v31.16b, v31.16b
        0x2a0503e5, // uxtw x5, w5
        0x2a0103e0, // uxtw x0, w1
    ];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
}

/// A relocation specifier may carry GNU as's optional `#` and a constant
/// addend. Byte- and relocation-identical to `as`: `add x1, x2, #:lo12:sym`
/// is 0x91000041 with ADD_ABS_LO12_NC, and the addend rides the relocation
/// rather than the immediate field.
#[test]
fn file_scope_a64_hash_lo12_matches_gnu_as() {
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::materialize_asm_sections;
    use crate::c5::asm::{AsmRelocKind, AsmSectionTarget};
    let text = ".pushsection .t,\"ax\"\n\
                add x1, x2, #:lo12:sym\n\
                add x1, x2, :lo12:sym\n\
                add sp, x0, #:lo12:sym2 + 4096\n\
                ldr x4, [x3, #:lo12:sym]\n.popsection\n";
    let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
    encode_a64_file_asm_section_code(&mut blocks).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )
    .unwrap();
    let want_words: [u32; 4] = [0x91000041, 0x91000041, 0x9100001f, 0xf9400064];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
    let kinds: Vec<(u32, AsmRelocKind, &str, i64)> = sec
        .relocs
        .iter()
        .map(|r| {
            let AsmSectionTarget::Symbol(n) = &r.target else {
                panic!("symbol target expected, got {:?}", r.target)
            };
            (r.offset, r.kind, n.as_str(), r.addend)
        })
        .collect();
    assert_eq!(
        kinds,
        vec![
            (0, AsmRelocKind::A64AddLo12, "sym", 0),
            (4, AsmRelocKind::A64AddLo12, "sym", 0),
            (8, AsmRelocKind::A64AddLo12, "sym2", 4096),
            (12, AsmRelocKind::A64LdstLo12(8), "sym", 0),
        ]
    );
}

/// Materialize one file-scope section and return the sink, for the
/// `:abs_g` cases below.
fn materialize_one_section(text: &str) -> Result<AsmSectionSink, alloc::string::String> {
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::materialize_asm_sections;
    let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
    encode_a64_file_asm_section_code(&mut blocks)?;
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )?;
    Ok(sink)
}

/// A bare section name is that section's start, so a `.set` over a
/// section-local difference folds and the `:abs_g` halves resolve at
/// assembly with no relocation -- which is what GNU as does with the
/// kernel's `tramp_alias`. Words from `as`; the value is negative, so
/// the signed group's `movz` becomes a `movn` over the complement.
#[test]
fn file_scope_a64_abs_g_over_section_symbol_matches_gnu_as() {
    let text = ".pushsection .entry.tramp.text,\"ax\"\n\
                tramp_start:\n\
                nop\n\
                nop\n\
                tramp_exit:\n\
                nop\n\
                .popsection\n\
                .pushsection .t,\"ax\"\n\
                .set .Lalias, 0x1000 + tramp_exit - .entry.tramp.text\n\
                movz x5, :abs_g2_s:.Lalias\n\
                movk x5, :abs_g1_nc:.Lalias\n\
                movk x5, :abs_g0_nc:.Lalias\n\
                .set .Lneg, -0xc0d000 + tramp_exit - .entry.tramp.text\n\
                movz x6, :abs_g2_s:.Lneg\n\
                movk x6, :abs_g1_nc:.Lneg\n\
                movk x6, :abs_g0_nc:.Lneg\n\
                .popsection\n";
    let sink = materialize_one_section(text).unwrap();
    let want_words: [u32; 6] = [
        0xd2c00005, // movz x5, #0x0, lsl #32
        0xf2a00005, // movk x5, #0x0, lsl #16
        0xf2820105, // movk x5, #0x1008
        0x92c00006, // movn x6, #0x0, lsl #32   (0x1008 - 0xc0d000 < 0)
        0xf2bfe7e6, // movk x6, #0xff3f, lsl #16
        0xf2860106, // movk x6, #0x3008
    ];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
    assert!(
        sec.relocs.is_empty(),
        "a folded `:abs_g` keeps no relocation, as GNU as emits none: {:?}",
        sec.relocs
    );
}

/// A `:abs_g` value that does not fold relocates, one relocation per
/// half, against the named symbol. The placeholder words carry the
/// group's shift and a zero immediate, as GNU as leaves them.
#[test]
fn file_scope_a64_abs_g_over_undefined_symbol_relocates() {
    let text = ".pushsection .t,\"ax\"\n\
                .globl ext_sym\n\
                movz x5, :abs_g2_s:ext_sym\n\
                movk x5, :abs_g1_nc:ext_sym\n\
                movk x5, :abs_g0_nc:ext_sym\n\
                movz x6, :abs_g3:ext_sym\n\
                movz x7, :abs_g0:ext_sym\n\
                .popsection\n";
    use crate::c5::asm::AsmRelocKind;
    let sink = materialize_one_section(text).unwrap();
    let want_words: [u32; 5] = [
        0xd2c00005, // movz x5, #0x0, lsl #32
        0xf2a00005, // movk x5, #0x0, lsl #16
        0xf2800005, // movk x5, #0x0
        0xd2e00006, // movz x6, #0x0, lsl #48
        0xd2800007, // movz x7, #0x0
    ];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
    let got: Vec<(u32, AsmRelocKind)> = sec.relocs.iter().map(|r| (r.offset, r.kind)).collect();
    assert_eq!(
        got,
        vec![
            (
                0,
                AsmRelocKind::A64MovwAbs {
                    group: 2,
                    signed: true,
                    check: Some(48)
                }
            ),
            (
                4,
                AsmRelocKind::A64MovwAbs {
                    group: 1,
                    signed: false,
                    check: None
                }
            ),
            (
                8,
                AsmRelocKind::A64MovwAbs {
                    group: 0,
                    signed: false,
                    check: None
                }
            ),
            (
                12,
                AsmRelocKind::A64MovwAbs {
                    group: 3,
                    signed: false,
                    check: None
                }
            ),
            (
                16,
                AsmRelocKind::A64MovwAbs {
                    group: 0,
                    signed: false,
                    check: Some(16)
                }
            ),
        ]
    );
}

/// The checked groups reject a folded value outside the width the
/// specifier names, and the no-check groups truncate. Boundaries and
/// messages follow GNU as: `:abs_g0_s:` admits [-0x8000, 0x8000),
/// `:abs_g0:` admits [0, 0x10000).
#[test]
fn file_scope_a64_abs_g_range_matches_gnu_as() {
    let one = |insn: &str| {
        materialize_one_section(&alloc::format!(
            ".pushsection .t,\"ax\"\n{insn}\n.popsection\n"
        ))
        .map(|s| {
            let sec = s
                .sections()
                .iter()
                .find(|s| s.name == ".t")
                .expect("`.t` emitted");
            u32::from_le_bytes(sec.bytes[..4].try_into().unwrap())
        })
    };
    // Signed group: the last value in range each way, and the first out.
    assert_eq!(one("movz x5, :abs_g0_s:0x7fff").unwrap(), 0xd28fffe5);
    assert_eq!(one("movz x5, :abs_g0_s:-0x8000").unwrap(), 0x928fffe5);
    assert!(
        one("movz x5, :abs_g0_s:0x8000")
            .unwrap_err()
            .contains("signed value out of range")
    );
    assert!(
        one("movz x5, :abs_g0_s:-0x8001")
            .unwrap_err()
            .contains("signed value out of range")
    );
    // The `_s` groups reach the top of a 48-bit signed value.
    assert_eq!(
        one("movz x5, :abs_g2_s:0x7fffffffffff").unwrap(),
        0xd2cfffe5
    );
    assert!(
        one("movz x5, :abs_g2_s:0x800000000000")
            .unwrap_err()
            .contains("signed value out of range")
    );
    // Unsigned checked group: no negative value, and no value past 2^16.
    assert_eq!(one("movz x5, :abs_g0:0xffff").unwrap(), 0xd29fffe5);
    assert!(
        one("movz x5, :abs_g0:0x10000")
            .unwrap_err()
            .contains("unsigned value out of range")
    );
    assert!(
        one("movz x5, :abs_g0:-1")
            .unwrap_err()
            .contains("unsigned value out of range")
    );
    // No-check groups truncate rather than reject, and keep `movz`
    // for a negative value -- only the signed groups take `movn`.
    assert_eq!(one("movz x5, :abs_g0_nc:0x10000").unwrap(), 0xd2800005);
    assert_eq!(one("movz x5, :abs_g0_nc:-1").unwrap(), 0xd29fffe5);
    assert_eq!(one("movz x5, :abs_g1_nc:0x123456789").unwrap(), 0xd2a468a5);
    assert_eq!(one("movz x5, :abs_g3:-1").unwrap(), 0xd2ffffe5);
}

/// A 32-bit destination clears the operand size bit and admits only
/// the two groups that fit its width; GNU as rejects the rest for a
/// `w` register. Words from `as`.
#[test]
fn file_scope_a64_abs_g_32bit_register_matches_gnu_as() {
    let one = |insn: &str| {
        materialize_one_section(&alloc::format!(
            ".pushsection .t,\"ax\"\n{insn}\n.popsection\n"
        ))
        .map(|s| {
            let sec = s
                .sections()
                .iter()
                .find(|s| s.name == ".t")
                .expect("`.t` emitted");
            u32::from_le_bytes(sec.bytes[..4].try_into().unwrap())
        })
    };
    assert_eq!(one("movz w6, :abs_g0_nc:0x5a827999").unwrap(), 0x528f3326);
    assert_eq!(one("movz w6, :abs_g1_nc:0x5a827999").unwrap(), 0x52ab5046);
    assert_eq!(one("movk w6, :abs_g0_nc:0x5a827999").unwrap(), 0x728f3326);
    assert_eq!(one("movk w6, :abs_g1_nc:0x5a827999").unwrap(), 0x72ab5046);
    // A negative signed group takes `movn` at either width.
    assert_eq!(one("movz w6, :abs_g0_s:-0x1234").unwrap(), 0x12824666);
    assert_eq!(one("movz x6, :abs_g0_s:-0x1234").unwrap(), 0x92824666);
    // Groups past the register's width have no encoding.
    for bad in ["movz w6, :abs_g2_nc:0x1", "movz w6, :abs_g3:0x1"] {
        assert!(
            one(bad)
                .unwrap_err()
                .contains("is not allowed for a 32-bit register"),
            "{bad}: {:?}",
            one(bad)
        );
    }
}

/// GNU as defines `_s` only on `movz` (a `movk` has no `movn` form to
/// carry a negative value) and defines no `:abs_g3_s:` / `:abs_g3_nc:`
/// / `:abs_g0_s_nc:` spelling.
#[test]
fn file_scope_a64_abs_g_rejects_what_gnu_as_rejects() {
    let one = |insn: &str| {
        materialize_one_section(&alloc::format!(
            ".pushsection .t,\"ax\"\n{insn}\n.popsection\n"
        ))
        .err()
        .unwrap_or_default()
    };
    assert!(one("movk x5, :abs_g0_s:sym").contains("not allowed on `movk`"));
    for bad in [
        "movz x5, :abs_g3_s:sym",
        "movz x5, :abs_g3_nc:sym",
        "movz x5, :abs_g0_s_nc:sym",
        "movz x5, :abs_g4:sym",
    ] {
        assert!(
            one(bad).contains("unknown relocation modifier"),
            "{bad}: {}",
            one(bad)
        );
    }
    assert!(one("add x5, x5, :abs_g0:sym").contains("outside `movz` or `movk`"));
}

/// An immediate or a memory offset written as a label difference is an
/// absolute value the section layout supplies, and on A64 the value
/// selects the encoding: `prfm` takes the scaled form only for a
/// multiple of the access size and `prfum` otherwise, `ldr` likewise
/// becomes `ldur`, and `mov` of a negative value becomes `movn`. Words
/// from `as`, which emits no relocation for any of them. This is the
/// kernel's vector-entry sequence in `arch/arm64/kernel/entry.S`.
#[test]
fn file_scope_a64_label_difference_operand_matches_gnu_as() {
    let text = ".pushsection .t,\"ax\"\n\
                vs:\n\
                nop\n\
                1:\n\
                prfm plil1strm, [x30, #(1b - vs)]\n\
                add x30, x30, #(1b - vs + 4)\n\
                ldr x0, [x30, #(1b - vs)]\n\
                mov x0, #(2f - 1b)\n\
                mov x1, #(vs - 2f)\n\
                prfm plil1strm, [x30, #(2f - vs)]\n\
                prfum plil1strm, [x30, #4]\n\
                sub sp, sp, #(2f - vs)\n\
                prfm plil1strm, [x30, #(2f - vs + 4)]\n\
                2:\n\
                nop\n\
                .popsection\n";
    let sink = materialize_one_section(text).unwrap();
    let want_words: [u32; 11] = [
        0xd503201f, // nop
        0xf88043c9, // prfum plil1strm, [x30, #4]
        0x910023de, // add   x30, x30, #0x8
        0xf84043c0, // ldur  x0, [x30, #4]
        0xd2800480, // mov   x0, #0x24
        0x928004e1, // mov   x1, #-0x28
        0xf98017c9, // prfm  plil1strm, [x30, #40]
        0xf88043c9, // prfum plil1strm, [x30, #4]
        0xd100a3ff, // sub   sp, sp, #0x28
        0xf882c3c9, // prfum plil1strm, [x30, #44]
        0xd503201f, // nop
    ];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
    assert!(
        sec.relocs.is_empty(),
        "a folded operand keeps no relocation: {:?}",
        sec.relocs
    );
}

/// An operand expression must reduce to an absolute value, as GNU as
/// requires: an undefined symbol or a difference across sections has no
/// relocation to carry it.
#[test]
fn file_scope_a64_operand_expression_rejects_what_gnu_as_rejects() {
    let one = |body: &str| {
        materialize_one_section(&alloc::format!(
            ".pushsection .t,\"ax\"\nvs:\nnop\n{body}\n.popsection\n"
        ))
        .err()
        .unwrap_or_default()
    };
    for bad in [
        "add x0, x0, #(ext_sym - vs)",
        "ldr x0, [x1, #(ext_sym - vs)]",
    ] {
        assert!(
            one(bad).contains("is not an absolute value in an instruction operand"),
            "{bad}: {}",
            one(bad)
        );
    }
}

/// The location counter in an instruction operand is the offset the
/// instruction itself is placed at, and the fold precedes encoding, so
/// the value still selects the form: `ldr` becomes `ldur` for an offset
/// that is not a multiple of the access size, `prfm` stays scaled for one
/// that is, and `mov` of a negative value becomes `movn`. Words from
/// `as`, which emits no relocation for any of them. Each section carries
/// its own counter.
#[test]
fn file_scope_a64_location_counter_operand_matches_gnu_as() {
    let text = ".pushsection .t,\"ax\"\n\
                1:\n\
                nop\n\
                ldr x0, [x30, #(. - 1b)]\n\
                add x0, x0, #(. - 1b)\n\
                add x1, x1, #(2f - .)\n\
                nop\n\
                2:\n\
                prfm plil1strm, [x30, #(. - 1b)]\n\
                mov x7, #(1b - .)\n\
                .set k, . - 1b\n\
                add x4, x4, #k\n\
                prfm plil1strm, [x30, #(. - 1b)]\n\
                .popsection\n\
                .pushsection .u,\"ax\"\n\
                3:\n\
                nop\n\
                add x8, x8, #(. - 3b)\n\
                .popsection\n";
    let sink = materialize_one_section(text).unwrap();
    let want_t: [u32; 9] = [
        0xd503201f, // nop
        0xf84043c0, // ldur  x0, [x30, #4]
        0x91002000, // add   x0, x0, #0x8
        0x91002021, // add   x1, x1, #0x8
        0xd503201f, // nop
        0xf88143c9, // prfum plil1strm, [x30, #20]
        0x928002e7, // mov   x7, #-0x18
        0x91007084, // add   x4, x4, #0x1c
        0xf98013c9, // prfm  plil1strm, [x30, #32]
    ];
    let want_u: [u32; 2] = [
        0xd503201f, // nop
        0x91001108, // add   x8, x8, #0x4
    ];
    for (name, want) in [(".t", &want_t[..]), (".u", &want_u[..])] {
        let bytes: Vec<u8> = want.iter().flat_map(|w| w.to_le_bytes()).collect();
        let sec = sink
            .sections()
            .iter()
            .find(|s| s.name == name)
            .expect("section");
        assert_eq!(sec.bytes, bytes, "{name}");
        assert!(sec.relocs.is_empty(), "{name}: {:?}", sec.relocs);
    }
}

/// A `.rept` whose count is a label difference defers to the section
/// layer with its body held once, so a statement inside it stands at one
/// offset per repetition and the counter has no single value. A label
/// difference there is still constant and folds.
#[test]
fn file_scope_a64_location_counter_in_a_deferred_rept_is_rejected() {
    let body = |op: &str| {
        alloc::format!(
            ".pushsection .t,\"ax\"\n1:\nnop\nnop\n2:\nnop\n\
             .rept (2b - 1b) / 4\n{op}\n.endr\n.popsection\n"
        )
    };
    let err = materialize_one_section(&body("add x0, x0, #(. - 1b)"))
        .err()
        .unwrap_or_default();
    assert!(
        err.contains("location counter `.` is not available here"),
        "{err}"
    );
    let sink = materialize_one_section(&body("add x0, x0, #(2b - 1b)")).unwrap();
    let want: [u32; 5] = [
        0xd503201f, 0xd503201f, 0xd503201f, //
        0x91002000, // add x0, x0, #0x8
        0x91002000,
    ];
    let bytes: Vec<u8> = want.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
}

/// The add/sub immediate field is unsigned, so GNU as encodes a negative
/// immediate as the opposite operation on the negated value, `lsl #12`
/// included. The scalar 64-bit `add` / `sub` and `sha1h` are covered here
/// too; all match `as` byte for byte.
#[test]
fn file_scope_a64_negative_addsub_imm_matches_gnu_as() {
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::materialize_asm_sections;
    let text = ".pushsection .t,\"ax\"\n\
                cmp w4, #48 - (4 << 4)\n\
                cmp x0, #-16\n\
                cmn x0, #16\n\
                add x1, x2, #-16\n\
                sub x1, x2, #-16\n\
                adds x1, x2, #-16\n\
                subs x1, x2, #-16\n\
                cmp w4, #-4096\n\
                add x1, x2, #-4096\n\
                sha1h s14, s12\n\
                add d7, d7, d16\n\
                sub d7, d7, d16\n\
                .popsection\n";
    let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
    encode_a64_file_asm_section_code(&mut blocks).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )
    .unwrap();
    let want_words: [u32; 12] = [
        0x3100409f, // cmp w4, #48 - (4 << 4)
        0xb100401f, // cmp x0, #-16
        0xb100401f, // cmn x0, #16
        0xd1004041, // add x1, x2, #-16
        0x91004041, // sub x1, x2, #-16
        0xf1004041, // adds x1, x2, #-16
        0xb1004041, // subs x1, x2, #-16
        0x3140049f, // cmp w4, #-4096
        0xd1400441, // add x1, x2, #-4096
        0x5e28098e, // sha1h s14, s12
        0x5ef084e7, // add d7, d7, d16
        0x7ef084e7, // sub d7, d7, d16
    ];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
}

/// The memory copy / set family (FEAT_MOPS) encodes to the words GNU as
/// emits. The cases cover both operand shapes, all three stages, and the
/// read/write option suffixes, with the registers varied so the
/// destination / size / source fields are each pinned.
#[test]
fn file_scope_a64_mops_match_gnu_as() {
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::materialize_asm_sections;
    let text = ".pushsection .t,\"ax\"\n\
                cpyfp [x1]!, [x2]!, x3!\n\
                cpyfprt [x4]!, [x8]!, x16!\n\
                cpyfpwn [x5]!, [x10]!, x20!\n\
                cpyfptn [x30]!, [x29]!, x28!\n\
                cpyp [x0]!, [x1]!, x2!\n\
                cpym [x1]!, [x2]!, x3!\n\
                cpye [x4]!, [x8]!, x16!\n\
                cpypwn [x5]!, [x10]!, x20!\n\
                cpyfprtwn [x30]!, [x29]!, x28!\n\
                setp [x0]!, x1!, x2\n\
                setpt [x1]!, x2!, x3\n\
                setpn [x4]!, x8!, x16\n\
                setptn [x5]!, x10!, x20\n\
                setm [x30]!, x29!, x28\n\
                sete [x0]!, x1!, x2\n\
                seten [x1]!, x2!, x3\n\
                setpn [x0]!, x1!, xzr\n.popsection\n";
    let mut blocks = extract_file_scope_asm_sections(text, true).unwrap();
    encode_a64_file_asm_section_code(&mut blocks).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )
    .unwrap();
    let want_words: [u32; 17] = [
        0x19020461, // cpyfp [x1]!, [x2]!, x3!
        0x19082604, // cpyfprt [x4]!, [x8]!, x16!
        0x190a4685, // cpyfpwn [x5]!, [x10]!, x20!
        0x191df79e, // cpyfptn [x30]!, [x29]!, x28!
        0x1d010440, // cpyp [x0]!, [x1]!, x2!
        0x1d420461, // cpym [x1]!, [x2]!, x3!
        0x1d880604, // cpye [x4]!, [x8]!, x16!
        0x1d0a4685, // cpypwn [x5]!, [x10]!, x20!
        0x191d679e, // cpyfprtwn [x30]!, [x29]!, x28!
        0x19c20420, // setp [x0]!, x1!, x2
        0x19c31441, // setpt [x1]!, x2!, x3
        0x19d02504, // setpn [x4]!, x8!, x16
        0x19d43545, // setptn [x5]!, x10!, x20
        0x19dc47be, // setm [x30]!, x29!, x28
        0x19c28420, // sete [x0]!, x1!, x2
        0x19c3a441, // seten [x1]!, x2!, x3
        0x19df2420, // setpn [x0]!, x1!, xzr
    ];
    let bytes: Vec<u8> = want_words.iter().flat_map(|w| w.to_le_bytes()).collect();
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == ".t")
        .expect("`.t` emitted");
    assert_eq!(sec.bytes, bytes);
}

/// The flow-form ALTERNATIVE at file scope: `.subsection 1` holds the
/// replacement, `.previous` returns, the `.org` pair equalizes the
/// lengths, and a `.rept` count over labels of the main subsection
/// resolves at layout. Bytes match GNU as for the same input: the main
/// stream first, the subsection-1 content appended after.
#[test]
fn file_scope_a64_subsection_org_rept_match_gnu_as() {
    use crate::c5::asm::AsmComments;
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::{materialize_asm_sections, prepare_file_asm_text};
    let text = ".text\nf:\n661:\nnop\nnop\n662:\n.subsection 1\n663:\nmov x1, #2\nmov x2, #3\n\
                664:\n.previous\n.org . - (664b-663b) + (662b-661b)\n\
                .org . - (662b-661b) + (664b-663b)\n\
                661:\nnop\n662:\n.subsection 1\n663:\n.rept (662b-661b) / 4\nnop\n.endr\n664:\n\
                .previous\n.org . - (664b-663b) + (662b-661b)\n\
                .org . - (662b-661b) + (664b-663b)\nret\n";
    let text = prepare_file_asm_text(text, AsmComments::A64).unwrap();
    let mut blocks = extract_file_scope_asm_sections(&text, true).unwrap();
    encode_a64_file_asm_section_code(&mut blocks).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )
    .unwrap();
    let want: Vec<u8> = [
        0xd503201fu32, // nop (661 first instance)
        0xd503201f,    // nop
        0xd503201f,    // nop (second instance)
        0xd65f03c0,    // ret
        0xd2800041,    // mov x1, #2 (subsection 1)
        0xd2800062,    // mov x2, #3
        0xd503201f,    // rept'd nop
    ]
    .iter()
    .flat_map(|w| w.to_le_bytes())
    .collect();
    assert_eq!(sink.section(0).bytes, want);
}

/// Materialize one file-scope asm text and return the named section.
fn a64_file_asm_section(text: &str, name: &str) -> crate::c5::asm::AsmSection {
    a64_file_asm_sink(text)
        .sections()
        .iter()
        .find(|s| s.name == name)
        .expect("section emitted")
        .clone()
}

/// Expand, extract, encode and materialize one file-scope asm text.
fn a64_file_asm_sink_result(text: &str) -> Result<AsmSectionSink, alloc::string::String> {
    use crate::c5::asm::AsmComments;
    use crate::c5::asm::extract_file_scope_asm_sections;
    use crate::c5::asm::{materialize_asm_sections, prepare_file_asm_text};
    let text = prepare_file_asm_text(text, AsmComments::A64)?;
    let mut blocks = extract_file_scope_asm_sections(&text, true)?;
    encode_a64_file_asm_section_code(&mut blocks)?;
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &crate::c5::asm::AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        true,
        &mut sink,
    )?;
    Ok(sink)
}

fn a64_file_asm_sink(text: &str) -> AsmSectionSink {
    a64_file_asm_sink_result(text).expect("materializes")
}

/// A `.if` over a label difference guarding a `.error` is valued after
/// layout: the branches emit no bytes, so the layout cannot depend on the
/// outcome. Bytes are GNU as's for the same input, which reads the same
/// difference at the `.if`. Covers both spellings the kernel vector
/// tables use -- numeric labels through macro parameters, and `\@`-unique
/// labels -- and an `.else` arm.
#[test]
fn file_scope_a64_deferred_if_matches_gnu_as() {
    let text = ".macro check_preamble_length start, end\n\
                .if ((\\end-\\start) != (2 * 4))\n\
                .error \"vector preamble length mismatch\"\n\
                .endif\n.endm\n\
                .macro valid_vect target\n.align 4\n661:\nnop\n\
                stp x0, x1, [sp, #-16]!\n662:\nb \\target\n\
                check_preamble_length 661b, 662b\n.endm\n\
                .macro sized_vect\n.align 4\n.L__vect_start\\@:\n\
                mrs x0, esr_el2\nret\n.L__vect_end\\@:\n\
                .if ((.L__vect_end\\@ - .L__vect_start\\@) > 0x10)\n\
                .error \"vector larger than its entry\"\n.endif\n\
                .if ((.L__vect_end\\@ - .L__vect_start\\@) > 0x4)\n.else\n\
                .error \"vector shorter than one instruction\"\n.endif\n.endm\n\
                .text\n.globl v\nv:\nvalid_vect el1_sync\nvalid_vect el1_irq\n\
                sized_vect\nsized_vect\nel1_sync:\nel1_irq:\nret\n";
    let want: Vec<u8> = [
        0xd503201fu32, // nop
        0xa9bf07e0,    // stp x0, x1, [sp, #-16]!
        0x1400000c,    // b el1_sync
        0xd503201f,    // .align 4 padding
        0xd503201f,    // nop
        0xa9bf07e0,    // stp x0, x1, [sp, #-16]!
        0x14000008,    // b el1_irq
        0xd503201f,    // .align 4 padding
        0xd53c5200,    // mrs x0, esr_el2
        0xd65f03c0,    // ret
        0xd503201f,    // .align 4 padding
        0xd503201f,
        0xd53c5200, // mrs x0, esr_el2
        0xd65f03c0, // ret
        0xd65f03c0, // ret
    ]
    .iter()
    .flat_map(|w| w.to_le_bytes())
    .collect();
    let sec = a64_file_asm_section(text, ".text");
    assert_eq!(sec.bytes, want);
    assert_eq!(sec.align, 16);
}

/// The same guard reports when the region it measures is the wrong size,
/// with the `.error`'s own message.
#[test]
fn file_scope_a64_deferred_if_reports_a_failed_guard() {
    let text = ".macro check_preamble_length start, end\n\
                .if ((\\end-\\start) != (2 * 4))\n\
                .error \"vector preamble length mismatch\"\n\
                .endif\n.endm\n\
                .text\nv:\n661:\nnop\nnop\nnop\n662:\n\
                check_preamble_length 661b, 662b\n";
    let err = a64_file_asm_sink_result(text).expect_err("guard reports");
    assert!(
        err.contains("`.error` vector preamble length mismatch"),
        "{err}"
    );
}

/// A branch, `adr`, `adrp` or `:lo12:` operand is an expression over
/// symbols, not only a symbol with a constant addend: a label difference
/// in the addend folds against the layout and the symbol keeps the
/// relocation. The KVM hypervisor entry branches to a vector slot that
/// way. Words and relocations measured with GNU as 2.46.1 for the same
/// source.
#[test]
fn file_scope_a64_operand_symbol_expressions_match_gnu_as() {
    let text = ".text\n1:\nnop\nnop\n2:\nb __kvm_hyp_vector + (2b - 1b + (2 * 4))\n\
                adr x0, sym + (2b - 1b)\nadrp x1, sym + (2b - 1b)\n\
                add x1, x1, :lo12:(sym + (2b - 1b))\ncbz x2, sym + (2b - 1b)\n";
    let sec = a64_file_asm_section(text, ".text");
    let want: Vec<u8> = [
        0xd503201fu32, // nop
        0xd503201f,    // nop
        0x14000000,    // b __kvm_hyp_vector + 16
        0x10000000,    // adr x0, sym + 8
        0x90000001,    // adrp x1, sym + 8
        0x91000021,    // add x1, x1, :lo12:sym + 8
        0xb4000002,    // cbz x2, sym + 8
    ]
    .iter()
    .flat_map(|w| w.to_le_bytes())
    .collect();
    assert_eq!(sec.bytes, want);
    let relocs: Vec<_> = sec
        .relocs
        .iter()
        .map(|r| (r.offset, alloc::format!("{:?}", r.target), r.addend))
        .collect();
    let at = |n: &str| alloc::format!("Symbol(\"{n}\")");
    assert_eq!(
        relocs,
        [
            (8, at("__kvm_hyp_vector"), 16),
            (12, at("sym"), 8),
            (16, at("sym"), 8),
            (20, at("sym"), 8),
            (24, at("sym"), 8),
        ]
    );
}

/// A `.rept` count and a `.fill` count are expressions over the layout,
/// the location counter included. Bytes measured with GNU as 2.46.1.
#[test]
fn file_scope_a64_counts_over_the_layout_match_gnu_as() {
    let text = ".text\na:\nnop\nnop\nb:\n.rept (b - a) / 4\nnop\n.endr\n\
                .fill b + 20 - ., 1, 0xcc\n";
    let sec = a64_file_asm_section(text, ".text");
    let mut want: Vec<u8> = alloc::vec![];
    for _ in 0..4 {
        want.extend_from_slice(&0xd503201fu32.to_le_bytes());
    }
    want.extend_from_slice(&[0xcc; 12]);
    assert_eq!(sec.bytes, want);
}

/// A deferred condition the layout still cannot value is reported rather
/// than guessed: a difference of labels in two sections is no distance.
#[test]
fn file_scope_a64_deferred_if_rejects_a_cross_section_difference() {
    let text = ".text\na:\nnop\n.section .other,\"ax\",@progbits\nb:\nnop\n.text\n\
                .if ((b - a) != 4)\n.error \"mismatch\"\n.endif\n";
    let err = a64_file_asm_sink_result(text).expect_err("condition is not constant");
    assert!(err.contains("non-constant `.if` condition"), "{err}");
}

/// `ldr Rt, =value` deposits the value in the section's literal pool.
/// The bytes are GNU as's for the same input: `.ltorg` flushes what has
/// accumulated, identical requests share an entry, the entries land in
/// width-ascending groups each aligned to its own width, a symbol entry
/// takes an `R_AARCH64_ABS64`, and what no `.ltorg` flushed is deposited
/// at the end of the section.
#[test]
fn file_scope_a64_literal_pool_matches_gnu_as() {
    use crate::c5::asm::{AsmRelocKind, AsmSectionTarget};
    let text = ".text\n.globl f\nf:\n\
                ldr x0, =some_sym\n\
                ldr w1, =0x12345678\n\
                ldr x2, =some_sym\n\
                ldr x3, =0x1122334455667788\n\
                ldr w4, =0x12345678\n\
                ldr x5, =other_sym + 8\n\
                .ltorg\nret\n.globl g\ng:\nldr x6, =tail_sym\nret\n";
    let sec = a64_file_asm_section(text, ".text");
    let want: Vec<u8> = [
        0x58000100u32, // ldr x0, 20   (some_sym)
        0x180000a1,    // ldr w1, 18   (0x12345678)
        0x580000c2,    // ldr x2, 20   (shares the some_sym entry)
        0x580000e3,    // ldr x3, 28
        0x18000044,    // ldr w4, 18   (shares the 0x12345678 entry)
        0x580000e5,    // ldr x5, 30
        0x12345678,    // pool: the 4-byte group first
        0x00000000,    // padding to the 8-byte group
        0x00000000,    // some_sym (ABS64)
        0x00000000,
        0x55667788, // 0x1122334455667788
        0x11223344,
        0x00000000, // other_sym + 8 (ABS64)
        0x00000000,
        0xd65f03c0, // ret
        0x58000066, // ldr x6, 48
        0xd65f03c0, // ret
        0x00000000, // end-of-section pool: padding
        0x00000000, // tail_sym (ABS64)
        0x00000000,
    ]
    .iter()
    .flat_map(|w| w.to_le_bytes())
    .collect();
    assert_eq!(sec.bytes, want);
    assert_eq!(sec.align, 8);
    let relocs: Vec<_> = sec
        .relocs
        .iter()
        .map(|r| {
            (
                r.offset,
                r.width,
                r.kind,
                r.pcrel,
                r.target.clone(),
                r.addend,
            )
        })
        .collect();
    let sym = |n: &str| AsmSectionTarget::Symbol(alloc::string::String::from(n));
    assert_eq!(
        relocs,
        alloc::vec![
            (0x20, 8, AsmRelocKind::Data, false, sym("some_sym"), 0),
            (0x30, 8, AsmRelocKind::Data, false, sym("other_sym"), 8),
            (0x48, 8, AsmRelocKind::Data, false, sym("tail_sym"), 0),
        ]
    );
}

/// A pool entry is shared by width and value, not by register class: the
/// `d`/`x` and `s`/`w` requests of one value take one entry each, and a
/// symbol addend distinguishes entries. Bytes are GNU as's.
#[test]
fn file_scope_a64_literal_pool_widths_match_gnu_as() {
    let text = ".text\n.globl h\nh:\n\
                ldr d2, =0x1111111122222222\n\
                ldr x3, =0x1111111122222222\n\
                ldr s4, =0x33445566\n\
                ldr w5, =0x33445566\n\
                .ltorg\n.globl i\ni:\n\
                ldr x6, =sym_c\nldr x7, =sym_c+0\nldr x8, =sym_c+4\n\
                .ltorg\n.globl j\nj:\n.ltorg\nnop\n";
    let sec = a64_file_asm_section(text, ".text");
    let want: Vec<u8> = [
        0x5c0000c2u32, // ldr d2, 14
        0x580000a3,    // ldr x3, 14 (shares the d2 entry)
        0x1c000044,    // ldr s4, 10
        0x18000025,    // ldr w5, 10 (shares the s4 entry)
        0x33445566,    // pool: 4-byte group
        0x00000000,    // padding to the 8-byte group
        0x22222222,    // 0x1111111122222222
        0x11111111,
        0x58000086, // ldr x6, 30
        0x58000067, // ldr x7, 30 (shares the sym_c entry)
        0x58000088, // ldr x8, 38
        0x00000000, // padding
        0x00000000, // sym_c (ABS64)
        0x00000000,
        0x00000000, // sym_c + 4 (ABS64)
        0x00000000,
        0xd503201f, // nop; the empty `.ltorg` deposits nothing
    ]
    .iter()
    .flat_map(|w| w.to_le_bytes())
    .collect();
    assert_eq!(sec.bytes, want);
    let relocs: Vec<_> = sec.relocs.iter().map(|r| (r.offset, r.addend)).collect();
    assert_eq!(relocs, alloc::vec![(0x30, 0), (0x38, 4)]);
}

/// A pool of one width raises the section's alignment to that width and
/// pads to it: GNU as gives the 4-, 8- and 16-byte cases alignment 4, 8
/// and 16, and a `q` entry zero-extends its 64-bit value.
#[test]
fn file_scope_a64_literal_pool_alignment_matches_gnu_as() {
    for (reg, value, align, want) in [
        (
            "w0",
            "0x11223344",
            4u32,
            alloc::vec![0x18000020u32, 0x11223344],
        ),
        (
            "x0",
            "0x1122334455667788",
            8,
            alloc::vec![0x58000040, 0x00000000, 0x55667788, 0x11223344],
        ),
        (
            "q0",
            "0x1122334455667788",
            16,
            alloc::vec![
                0x9c000080, 0x00000000, 0x00000000, 0x00000000, 0x55667788, 0x11223344, 0x00000000,
                0x00000000,
            ],
        ),
    ] {
        let text = alloc::format!(".section .p,\"ax\",@progbits\nldr {reg}, ={value}\n.ltorg\n");
        let sec = a64_file_asm_section(&text, ".p");
        let bytes: Vec<u8> = want.iter().flat_map(|w| w.to_le_bytes()).collect();
        assert_eq!(sec.bytes, bytes, "{reg}");
        assert_eq!(sec.align, align, "{reg}");
    }
}

/// Every LDR (literal) destination view encodes as GNU as does, with the
/// same-section target folded into the 19-bit displacement.
#[test]
fn file_scope_a64_ldr_literal_views_match_gnu_as() {
    let text = ".section .lit,\"ax\",@progbits\nlit0:\n.word 1\n\
                ldr w0, lit0\nldr x1, lit0\nldr s2, lit0\nldr d3, lit0\n\
                ldr q4, lit0\nldrsw x5, lit0\n";
    let sec = a64_file_asm_section(text, ".lit");
    let want: Vec<u8> = [
        0x00000001u32, // .word 1
        0x18ffffe0,    // ldr w0, lit0
        0x58ffffc1,    // ldr x1, lit0
        0x1cffffa2,    // ldr s2, lit0
        0x5cffff83,    // ldr d3, lit0
        0x9cffff64,    // ldr q4, lit0
        0x98ffff45,    // ldrsw x5, lit0
    ]
    .iter()
    .flat_map(|w| w.to_le_bytes())
    .collect();
    assert_eq!(sec.bytes, want);
    assert!(sec.relocs.is_empty(), "same-section literal needs no reloc");
}

fn lift_and_alloc(src: &str, target: Target) -> (crate::c5::ir::FunctionSsa, Allocation) {
    let program = Compiler::new(src.into()).compile().expect("compile");
    let funcs = crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
        .expect("produce_ssa_funcs");
    let main = funcs.into_iter().next().expect("at least one function");
    let alloc =
        super::super::ssa::reg_alloc::allocate(&main, target, crate::c5::codegen::FixedRegs::NONE);
    (main, alloc)
}

/// A `return 42;` function emits a small, well-formed
/// aarch64 sequence: prologue, materialise 42, mov to x0,
/// epilogue, ret. The exact length isn't load-bearing here
/// -- the test exists to lock in that the thin slice
/// completes without falling back.
#[test]
fn emit_return_42() {
    let (func, alloc) = lift_and_alloc("int main(void) { return 42; }", Target::MacOSAarch64);
    let mut code = Vec::new();
    let mut fx = Vec::new();
    let mut plt = Vec::new();
    let mut data_fx = Vec::new();
    let mut pf_fx = Vec::new();
    let imps = super::super::ResolvedImports::default();
    let variadic_targets: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let mut tls_idx = Vec::new();
    let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
    let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    let mut tlv_fx = Vec::new();
    let mut tlv_desc = Vec::new();
    let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
    let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
    let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
        alloc::collections::BTreeMap::new();
    let mut elf_tpoff = Vec::new();
    let mut asm_sections = AsmSectionSink::default();
    let mut asm_extern_call_sites = Vec::new();
    let mut asm_sym_fixups = Vec::new();
    let mut text_align: usize = 16;
    let mut label_relocs = Vec::new();
    let mut text_data_ranges = Vec::new();
    let ok = {
        let mut cx = super::super::ssa::emit_common::EmitCtx {
            code: &mut code,
            plt_call_fixups: &mut plt,
            data_fixups: &mut data_fx,
            user_extern_data_refs: &mut user_data_refs,
            pending_func_fixups: &mut pf_fx,
            tls_index_fixups: &mut tls_idx,
            elf_tpoff_fixups: &mut elf_tpoff,
            ssa_line_rows: &mut ssa_line_rows,
            pc_to_native: &mut pc_to_native,
            prologue_native: &mut prologue_native,
            asm_sections: &mut asm_sections,
            asm_extern_call_sites: &mut asm_extern_call_sites,
            asm_sym_fixups: &mut asm_sym_fixups,
            text_align: &mut text_align,
            label_relocs: &mut label_relocs,
            text_data_ranges: &mut text_data_ranges,
            canary_frame_bytes: &mut alloc::collections::BTreeMap::new(),
            mcount_sites: &mut alloc::vec::Vec::new(),
        };
        emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut cx,
            &mut fx,
            &extern_data_names,
            &extern_tls_names,
            8,
            &imps,
            &variadic_targets,
            &mut tlv_fx,
            &mut tlv_desc,
            &alloc::collections::BTreeMap::new(),
            &alloc::collections::BTreeMap::new(),
            &mut Vec::new(),
            &mut Vec::new(),
            &mut None,
            false,
            false,
            &mut super::super::RodataBuild::default(),
            false,
            super::super::Hardening::NONE,
            super::super::StackProtect::OFF,
            super::super::FunctionEntry::default(),
            super::super::FixedRegs::NONE,
        )
    };
    assert!(
        ok.is_ok(),
        "expected SSA emit to handle a single-return function; got fallback"
    );
    assert!(!code.is_empty(), "emit produced no bytes");
    // Every aarch64 instruction is 4 bytes -- a non-multiple
    // of 4 means we encoded a wrong-width op.
    assert_eq!(code.len() % 4, 0, "code length must be 4-aligned");
    // Last instruction must be `ret x30` (0xd65f03c0).
    let tail = &code[code.len() - 4..];
    assert_eq!(
        u32::from_le_bytes([tail[0], tail[1], tail[2], tail[3]]),
        0xd65f03c0,
        "function must end with `ret`",
    );
}

/// An indexed store `a[i] = v` needs three registers: base, index,
/// and value. AArch64 has two scratch registers, so when all three
/// spill, base and index take both and the value would otherwise
/// reuse the base register. Forcing all three operands to spill must
/// precompute the address (`add xN, base, index, lsl #shift`) and
/// store from a register distinct from the base.
#[test]
fn store_indexed_spilled_operands_precompute_address() {
    let target = Target::MacOSAarch64;
    // Compile for the target, not the host: `long` is 64-bit on the
    // aarch64 target but 32-bit on a Windows host, which would change
    // the element scale and drop the StoreIndexed.
    let program = Compiler::with_target(
        "void store_at(long *a, int i, long v){ a[i] = v; } int main(void){ return 0; }".into(),
        target,
    )
    .compile()
    .expect("compile");
    let mut funcs =
        crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
            .expect("ssa");
    // StoreIndexed is produced by the index fold, which the lowering
    // runs after `produce_ssa_funcs`.
    crate::c5::codegen::passes::index_fold::run(&mut funcs);
    let func = funcs
        .into_iter()
        .find(|f| {
            f.insts
                .iter()
                .any(|i| matches!(i, crate::c5::ir::Inst::StoreIndexed { .. }))
        })
        .expect("a function with a StoreIndexed");
    let (base, index, value, scale, kind) = func
        .insts
        .iter()
        .find_map(|i| match i {
            crate::c5::ir::Inst::StoreIndexed {
                base,
                index,
                scale,
                value,
                kind,
            } => Some((*base, *index, *value, *scale, *kind)),
            _ => None,
        })
        .expect("StoreIndexed operands");
    let mut alloc =
        super::super::ssa::reg_alloc::allocate(&func, target, crate::c5::codegen::FixedRegs::NONE);
    alloc.places[base as usize] = Place::Spill(0);
    alloc.places[index as usize] = Place::Spill(1);
    alloc.places[value as usize] = Place::Spill(2);
    // The frame must reserve the three slots the test forces, or the
    // spill-offset computation underflows.
    alloc.spill_count = alloc.spill_count.max(3);
    let frame = compute_frame(&func, &alloc, target.abi(), target);
    let scratch = ScratchPool {
        primary: Reg(16),
        secondary: Reg(17),
    };
    let mut code = Vec::new();
    let ok = emit_store_indexed(
        &mut code,
        Place::None,
        base,
        index,
        scale,
        value,
        kind,
        &alloc,
        frame,
        &scratch,
    );
    assert!(ok.is_ok(), "emit_store_indexed bailed");
    let words: Vec<u32> = code
        .as_chunks::<4>()
        .0
        .iter()
        .map(|c| u32::from_le_bytes([c[0], c[1], c[2], c[3]]))
        .collect();
    // The precomputed address: `add x16, x16, x17, lsl #3` for an
    // 8-byte element.
    let add_word: u32 = 0x8B11_0E10;
    assert!(
        words.contains(&add_word),
        "expected a precomputed-address add; got {words:08x?}",
    );
    // No store may use one register as both base and value.
    for &w in &words {
        let op = w >> 22;
        let is_str = op == 0x3E0 || op == 0x2E0 || op == 0x3E4 || op == 0x2E4;
        if is_str {
            let rt = w & 0x1f;
            let rn = (w >> 5) & 0x1f;
            assert_ne!(rt, rn, "store reuses base x{rn} as the value register");
        }
    }
}

/// The contracted multiply-accumulate over `c - a*b`, with the
/// operand places the test forces. Returns the emitted words.
fn emit_spilled_mul_add(dst: Place) -> Vec<u32> {
    try_emit_spilled_mul_add(dst).expect("emit_mul_add bailed")
}

/// [`emit_spilled_mul_add`] returning the emit's own verdict.
fn try_emit_spilled_mul_add(dst: Place) -> Result<Vec<u32>, Unsupported> {
    let target = Target::MacOSAarch64;
    let program = Compiler::with_target(
        "long long f(long long a, long long b, long long c){ return c - a*b; } \
         int main(void){ return 0; }"
            .into(),
        target,
    )
    .compile()
    .expect("compile");
    let mut funcs =
        crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
            .expect("ssa");
    crate::c5::codegen::passes::mul_add::run(&mut funcs);
    let func = funcs
        .into_iter()
        .find(|f| {
            f.insts
                .iter()
                .any(|i| matches!(i, crate::c5::ir::Inst::MulAdd { .. }))
        })
        .expect("a function with a MulAdd");
    let (v, a, b, c) = func
        .insts
        .iter()
        .enumerate()
        .find_map(|(v, i)| match i {
            crate::c5::ir::Inst::MulAdd { a, b, c, .. } => {
                Some((v as crate::c5::ir::ValueId, *a, *b, *c))
            }
            _ => None,
        })
        .expect("MulAdd operands");
    let mut alloc =
        super::super::ssa::reg_alloc::allocate(&func, target, crate::c5::codegen::FixedRegs::NONE);
    for (i, operand) in [a, b, c].into_iter().enumerate() {
        alloc.places[operand as usize] = Place::Spill(i as u32);
    }
    alloc.places[v as usize] = dst;
    alloc.spill_count = alloc.spill_count.max(4);
    let frame = compute_frame(&func, &alloc, target.abi(), target);
    let scratch = ScratchPool {
        primary: Reg(16),
        secondary: Reg(17),
    };
    let mut code = Vec::new();
    emit_mul_add(&mut code, dst, a, b, c, true, &alloc, frame, &scratch)?;
    Ok(code
        .as_chunks::<4>()
        .0
        .iter()
        .map(|c| u32::from_le_bytes([c[0], c[1], c[2], c[3]]))
        .collect())
}

/// A result the integer form cannot hold is refused with the form and the
/// operand named, so the diagnostic is that text rather than a generic one.
#[test]
fn mul_add_fp_result_names_the_refused_form() {
    let e = try_emit_spilled_mul_add(Place::FpReg(0)).expect_err("an FP result has no MulAdd");
    assert_eq!(e.reason(), "MulAdd: dst not int reg / spill");
}

/// Three spilled operands and a register result: the reloads take
/// the two scratch registers and the result's own, and the fused
/// `msub` reads three distinct registers.
#[test]
fn mul_add_spilled_operands_use_three_registers() {
    let words = emit_spilled_mul_add(Place::IntReg(5));
    let msub = words
        .iter()
        .copied()
        .find(|w| w & 0xFFE0_8000 == 0x9B00_8000)
        .expect("an MSUB word");
    let (rm, ra, rn) = ((msub >> 16) & 0x1f, (msub >> 10) & 0x1f, (msub >> 5) & 0x1f);
    assert_eq!(msub & 0x1f, 5, "result register");
    assert!(
        rn != rm && rn != ra && rm != ra,
        "reloads collided: {words:08x?}",
    );
}

/// A spilled result leaves no third register, so the same node
/// falls back to the `mul` / `sub` pair, and the subtract reads the
/// addend rather than the product as its left operand.
#[test]
fn mul_add_spilled_result_falls_back_to_mul_sub() {
    let words = emit_spilled_mul_add(Place::Spill(3));
    assert!(
        !words.iter().any(|w| w & 0xFFE0_8000 == 0x9B00_8000),
        "no MSUB is encodable here: {words:08x?}",
    );
    let mul = words
        .iter()
        .copied()
        .find(|w| w & 0xFFE0_FC00 == 0x9B00_7C00)
        .expect("a MUL word");
    let product = mul & 0x1f;
    let sub = words
        .iter()
        .copied()
        .find(|w| w & 0xFFE0_FC00 == 0xCB00_0000)
        .expect("a SUB word");
    assert_eq!((sub >> 16) & 0x1f, product, "subtracts the product");
    assert_ne!((sub >> 5) & 0x1f, product, "the addend is the left operand");
}

/// `return 1 + 2;` exercises the Binop + BinopI handlers
/// (the walker emits `Imm 1; Psh; Imm 2; Add` plus the
/// int-promotion shl/shr; the walker's BinopI imm-fold may
/// rewrite the Add into BinopI directly).
#[test]
fn emit_return_one_plus_two() {
    let (func, alloc) = lift_and_alloc("int main(void) { return 1 + 2; }", Target::MacOSAarch64);
    let mut code = Vec::new();
    let mut fx = Vec::new();
    let mut plt = Vec::new();
    let mut data_fx = Vec::new();
    let mut pf_fx = Vec::new();
    let imps = super::super::ResolvedImports::default();
    let variadic_targets: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let mut tls_idx = Vec::new();
    let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
    let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    let mut tlv_fx = Vec::new();
    let mut tlv_desc = Vec::new();
    let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
    let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
    let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
        alloc::collections::BTreeMap::new();
    let mut elf_tpoff = Vec::new();
    let mut asm_sections = AsmSectionSink::default();
    let mut asm_extern_call_sites = Vec::new();
    let mut asm_sym_fixups = Vec::new();
    let mut text_align: usize = 16;
    let mut label_relocs = Vec::new();
    let mut text_data_ranges = Vec::new();
    let ok = {
        let mut cx = super::super::ssa::emit_common::EmitCtx {
            code: &mut code,
            plt_call_fixups: &mut plt,
            data_fixups: &mut data_fx,
            user_extern_data_refs: &mut user_data_refs,
            pending_func_fixups: &mut pf_fx,
            tls_index_fixups: &mut tls_idx,
            elf_tpoff_fixups: &mut elf_tpoff,
            ssa_line_rows: &mut ssa_line_rows,
            pc_to_native: &mut pc_to_native,
            prologue_native: &mut prologue_native,
            asm_sections: &mut asm_sections,
            asm_extern_call_sites: &mut asm_extern_call_sites,
            asm_sym_fixups: &mut asm_sym_fixups,
            text_align: &mut text_align,
            label_relocs: &mut label_relocs,
            text_data_ranges: &mut text_data_ranges,
            canary_frame_bytes: &mut alloc::collections::BTreeMap::new(),
            mcount_sites: &mut alloc::vec::Vec::new(),
        };
        emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut cx,
            &mut fx,
            &extern_data_names,
            &extern_tls_names,
            8,
            &imps,
            &variadic_targets,
            &mut tlv_fx,
            &mut tlv_desc,
            &alloc::collections::BTreeMap::new(),
            &alloc::collections::BTreeMap::new(),
            &mut Vec::new(),
            &mut Vec::new(),
            &mut None,
            false,
            false,
            &mut super::super::RodataBuild::default(),
            false,
            super::super::Hardening::NONE,
            super::super::StackProtect::OFF,
            super::super::FunctionEntry::default(),
            super::super::FixedRegs::NONE,
        )
    };
    assert!(ok.is_ok(), "binop handler should cover Add + Shl + Shr");
    assert_eq!(code.len() % 4, 0);
}

/// `if (x > 0) return 1; else return 0;` exercises the
/// comparison binop path (cmp + cset), the branch terminator
/// path (CBZ + fixup), and the multi-block walk.
#[test]
fn emit_if_else_returns() {
    let (func, alloc) = lift_and_alloc(
        "int test(int x) { if (x > 0) return 1; else return 0; } \
         int main(void) { return test(5); }",
        Target::MacOSAarch64,
    );
    // The first function is `test`; the walker order is
    // declaration order, but `Inst::Call` for main isn't in
    // the thin slice yet, so we only check that `test` emits
    // cleanly. main will fall back.
    let mut code = Vec::new();
    let mut fx = Vec::new();
    let mut plt = Vec::new();
    let mut data_fx = Vec::new();
    let mut pf_fx = Vec::new();
    let imps = super::super::ResolvedImports::default();
    let variadic_targets: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let mut tls_idx = Vec::new();
    let mut user_data_refs: Vec<super::super::UserExternDataRef> = Vec::new();
    let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    let mut tlv_fx = Vec::new();
    let mut tlv_desc = Vec::new();
    let mut pc_to_native = alloc::vec![usize::MAX; func.end_pc + 1];
    let mut ssa_line_rows: Vec<(usize, u32, u32)> = Vec::new();
    let mut prologue_native: alloc::collections::BTreeMap<usize, usize> =
        alloc::collections::BTreeMap::new();
    let mut elf_tpoff = Vec::new();
    let mut asm_sections = AsmSectionSink::default();
    let mut asm_extern_call_sites = Vec::new();
    let mut asm_sym_fixups = Vec::new();
    let mut text_align: usize = 16;
    let mut label_relocs = Vec::new();
    let mut text_data_ranges = Vec::new();
    let ok = {
        let mut cx = super::super::ssa::emit_common::EmitCtx {
            code: &mut code,
            plt_call_fixups: &mut plt,
            data_fixups: &mut data_fx,
            user_extern_data_refs: &mut user_data_refs,
            pending_func_fixups: &mut pf_fx,
            tls_index_fixups: &mut tls_idx,
            elf_tpoff_fixups: &mut elf_tpoff,
            ssa_line_rows: &mut ssa_line_rows,
            pc_to_native: &mut pc_to_native,
            prologue_native: &mut prologue_native,
            asm_sections: &mut asm_sections,
            asm_extern_call_sites: &mut asm_extern_call_sites,
            asm_sym_fixups: &mut asm_sym_fixups,
            text_align: &mut text_align,
            label_relocs: &mut label_relocs,
            text_data_ranges: &mut text_data_ranges,
            canary_frame_bytes: &mut alloc::collections::BTreeMap::new(),
            mcount_sites: &mut alloc::vec::Vec::new(),
        };
        emit_function(
            &func,
            &alloc,
            Target::MacOSAarch64,
            &mut cx,
            &mut fx,
            &extern_data_names,
            &extern_tls_names,
            8,
            &imps,
            &variadic_targets,
            &mut tlv_fx,
            &mut tlv_desc,
            &alloc::collections::BTreeMap::new(),
            &alloc::collections::BTreeMap::new(),
            &mut Vec::new(),
            &mut Vec::new(),
            &mut None,
            false,
            false,
            &mut super::super::RodataBuild::default(),
            false,
            super::super::Hardening::NONE,
            super::super::StackProtect::OFF,
            super::super::FunctionEntry::default(),
            super::super::FixedRegs::NONE,
        )
    };
    assert!(
        ok.is_ok(),
        "`test` should emit via the thin slice (cmp + cset + cbz + ldr params)"
    );
}
