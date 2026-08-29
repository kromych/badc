//! End-to-end tests for the assembler: source text in, section items,
//! bytes, relocations and symbols out.

use super::*;
use crate::c5::codegen::map_syms::MapClass;

/// The name of the block each statement's items landed in, for the
/// section-stack tests below.
fn block_of(blocks: &[AsmSectionBlock], label: &str) -> alloc::string::String {
    blocks
        .iter()
        .find(|b| {
            b.items
                .iter()
                .any(|i| matches!(i, AsmSectionItem::Label(n) if n == label))
        })
        .map(|b| b.name.clone())
        .unwrap_or_else(|| alloc::string::String::from("<none>"))
}

/// GNU as keeps the previous section beside the `.pushsection` stack, so
/// a `.section` / `.previous` pair nested in a pushed region returns to
/// the pushed section and leaves the stack depth alone. This is the shape
/// the kernel's `EXPORT_SYMBOL` assembly macro has inside a
/// `.pushsection`-bracketed function.
#[test]
fn previous_returns_to_the_section_a_section_directive_left() {
    let text = ".pushsection .noinstr.text,\"ax\"\ninner:\n.section \"a\",\"a\"\nexported:\n\
                .previous\nback:\n.popsection\nouter:\n";
    let blocks = extract_file_scope_asm_sections(text, false).unwrap();
    assert_eq!(block_of(&blocks, "inner"), ".noinstr.text");
    assert_eq!(block_of(&blocks, "exported"), "a");
    assert_eq!(block_of(&blocks, "back"), ".noinstr.text");
    assert_eq!(block_of(&blocks, "outer"), ".text");
}

/// `.previous` toggles: a second one returns to where the first came
/// from, as GNU as does with its single previous-section slot.
#[test]
fn previous_toggles_between_two_sections() {
    let text = ".section \"a\",\"a\"\nin_a:\n.section \"b\",\"a\"\nin_b:\n\
                .previous\nback_a:\n.previous\nback_b:\n";
    let blocks = extract_file_scope_asm_sections(text, false).unwrap();
    assert_eq!(block_of(&blocks, "back_a"), "a");
    assert_eq!(block_of(&blocks, "back_b"), "b");
}

/// `.globl` is a unit-level declaration: the definition may be in another
/// section, which is how the kernel's `vdso-wrap.S` names its payload
/// bounds.
#[test]
fn globl_binds_a_label_defined_in_another_section() {
    let text = ".globl start, end\n.section .rodata,\"a\"\nstart:\n.byte 1\nend:\n";
    let blocks = extract_file_scope_asm_sections(text, false).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let labels: alloc::vec::Vec<_> = sink
        .sections()
        .iter()
        .flat_map(|s| s.labels.iter())
        .map(|l| (l.name.as_str(), l.global))
        .collect();
    assert!(labels.contains(&("start", true)), "{labels:?}");
    assert!(labels.contains(&("end", true)), "{labels:?}");
}

/// A `.set` to a constant folds into the expressions that read it, and
/// additionally defines an absolute symbol when the unit gave the name
/// external linkage -- what GNU as puts in `.symtab` as `SHN_ABS`.
#[test]
fn an_exported_constant_assignment_defines_an_absolute_symbol() {
    let text = ".globl len\n.section .rodata,\"a\"\nlen = 12345\nblob:\n.long len\n";
    let prepared = prepare_file_asm_text(text, AsmComments::X86).unwrap();
    let blocks = extract_file_scope_asm_sections(&prepared, false).unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let s = sink
        .sections()
        .iter()
        .find(|s| s.name == ".rodata")
        .expect("section built");
    assert_eq!(&s.bytes[..], &12345u32.to_le_bytes(), "the read folds");
    let len = s
        .labels
        .iter()
        .find(|l| l.name == "len")
        .expect("symbol defined");
    assert_eq!(len.absolute, Some(12345));
    assert!(len.global);
}

#[test]
fn extract_and_materialize() {
    let text = "1: nop\n.pushsection .discard.t,\"aw\",@progbits\n.balign 8\n.quad 1b\n.long 1b - .\n.long %c0, 7\n.asciz \"hi\"\n.popsection\nnop\n";
    let AsmExtract { code, blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    // The `1:` label is peeled onto its own line ahead of the `nop`.
    assert_eq!(code, "1:\nnop\nnop\n");
    assert_eq!(blocks.len(), 1);
    assert_eq!(blocks[0].name, ".discard.t");
    assert_eq!(blocks[0].flags, "aw");
    assert_eq!(blocks[0].sh_type.as_deref(), Some("progbits"));
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver {
            const_of: &|idx| (idx == 0).then_some(42),
            symbol_of: &|_| None,
            form: AsmOperandResolver::NONE.form,
        },
        &|name| (name == "1b").then_some(LabelLoc::Text(0x40)),
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    assert_eq!(sink.len(), 1);
    let s = sink.section(0);
    assert_eq!(s.align, 8);
    // 8 (quad) + 4 (pcrel long) + 4 + 4 (consts) + 3 ("hi\0").
    assert_eq!(s.bytes.len(), 23);
    assert_eq!(&s.bytes[12..16], &42u32.to_le_bytes());
    assert_eq!(&s.bytes[16..20], &7u32.to_le_bytes());
    assert_eq!(&s.bytes[20..23], b"hi\0");
    assert_eq!(s.relocs.len(), 2);
    assert_eq!(
        s.relocs[0],
        AsmSectionReloc {
            offset: 0,
            width: 8,
            kind: AsmRelocKind::Data,
            pcrel: false,
            branch: false,
            signed: false,
            target: AsmSectionTarget::Text(0x40),
            addend: 0
        }
    );
    assert_eq!(
        s.relocs[1],
        AsmSectionReloc {
            offset: 8,
            width: 4,
            kind: AsmRelocKind::Data,
            pcrel: true,
            branch: false,
            signed: false,
            target: AsmSectionTarget::Text(0x40),
            addend: 0
        }
    );
}

#[test]
fn align_fill_and_max_skip() {
    // `.balign`/`.p2align`/`.align` fill: an executable section defaults to
    // the target NOP, a data section to zero, and an explicit fill byte
    // other than the one-byte NOP wins for either. A max skip drops the
    // alignment when the gap is larger. Matches GNU as byte-for-byte.
    let mat = |text: &str, aarch64: bool| -> alloc::vec::Vec<u8> {
        let AsmExtract { blocks, .. } = extract_asm_sections(text, aarch64).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &AsmOperandResolver::NONE,
            &|_| None,
            &|_| None,
            aarch64,
            &mut sink,
        )
        .unwrap();
        sink.section(0).bytes.clone()
    };
    let exec = mat(
        ".pushsection .t,\"ax\"\n.byte 1\n.balign 8\n.byte 2\n.popsection\n",
        false,
    );
    assert_eq!(exec.len(), 9);
    // x86 executable default fill is the GNU as multi-byte NOP run. The
    // gap opens after a data directive, so it leads with the one-byte NOP
    // and the remaining six take the 6-byte NOP.
    assert_eq!(exec[1..8], [0x90, 0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00]);
    let data = mat(
        ".pushsection .t,\"aw\"\n.byte 1\n.balign 8\n.byte 2\n.popsection\n",
        false,
    );
    assert!(data[1..8].iter().all(|&b| b == 0x00));
    let zero = mat(
        ".pushsection .t,\"ax\"\n.byte 1\n.balign 8, 0\n.byte 2\n.popsection\n",
        false,
    );
    assert!(zero[1..8].iter().all(|&b| b == 0x00));
    // AArch64 executable default fill is the 4-byte NOP (0xd503201f).
    let a64 = mat(
        ".pushsection .t,\"ax\"\n.long 0\n.balign 16\n.long 0\n.popsection\n",
        true,
    );
    let nop = [0x1f, 0x20, 0x03, 0xd5];
    assert!((4..16).all(|i| a64[i] == nop[i % 4]));
    // A max skip larger than the alignment gap drops the padding.
    let skip = mat(
        ".pushsection .t,\"ax\"\n.byte 1\n.balign 16, 0x90, 3\n.byte 2\n.popsection\n",
        false,
    );
    assert_eq!(skip.len(), 2);
}

#[test]
fn a64_exec_align_fill_matches_gnu_as() {
    // GNU as splits an AArch64 code-section alignment gap: the gap's
    // sub-word remainder as zeros, then whole NOPs. The split is by the
    // gap, not by the offset, so a `.balign 2` over one byte writes one
    // zero. Each row is `(gap, zeros, nops)` read off `as` 2.46.
    for &(gap, zeros, nops) in &[
        (0usize, 0usize, 0usize),
        (1, 1, 0),
        (2, 2, 0),
        (3, 3, 0),
        (4, 0, 1),
        (7, 3, 1),
        (8, 0, 2),
        (12, 0, 3),
        (15, 3, 3),
        (30, 2, 7),
    ] {
        let mut out = alloc::vec::Vec::new();
        assert_eq!(push_a64_exec_align_fill(&mut out, gap), zeros, "gap {gap}");
        assert_eq!(out.len(), gap, "gap {gap} length");
        assert!(out[..zeros].iter().all(|&b| b == 0), "gap {gap} zeros");
        assert!(
            out[zeros..]
                .as_chunks::<{ A64_NOP.len() }>()
                .0
                .iter()
                .all(|c| c == &A64_NOP),
            "gap {gap} nops"
        );
        assert_eq!((out.len() - zeros) / A64_NOP.len(), nops, "gap {gap} count");
    }
}

#[test]
fn insn_align_gap_follows_the_mapping_state() {
    // The padding before an instruction is a data-to-instruction
    // transition in an AArch64 code section. No other state pads, and
    // neither does a non-executable section or x86-64.
    for at in 0..8i64 {
        let want = (4 - at % 4) % 4;
        assert_eq!(insn_align_gap(at, Some(MapClass::Data), true, true), want);
        assert_eq!(insn_align_gap(at, Some(MapClass::Code), true, true), 0);
        assert_eq!(insn_align_gap(at, None, true, true), 0);
        assert_eq!(insn_align_gap(at, Some(MapClass::Data), false, true), 0);
        assert_eq!(insn_align_gap(at, Some(MapClass::Data), true, false), 0);
    }
}

#[test]
fn an_alignment_of_one_leaves_the_mapping_state_alone() {
    // GNU as builds no frag for an alignment of one, so it neither
    // opens a run nor suppresses the padding before a later
    // instruction. A wider one leaves the section in the instruction
    // state where the section is executable.
    let item = |n: u32| AsmSectionItem::Align {
        spec: AlignSpec::Bytes(n),
        fill: None,
        max: None,
        nops: AlignNops::X86,
    };
    let (one, two) = (item(1), item(2));
    for exec in [false, true] {
        assert_eq!(
            step_map_state(&one, Some(MapClass::Data), exec),
            Some(MapClass::Data)
        );
        assert_eq!(step_map_state(&one, None, exec), None);
    }
    assert_eq!(
        step_map_state(&two, Some(MapClass::Data), true),
        Some(MapClass::Code)
    );
    assert_eq!(
        step_map_state(&two, Some(MapClass::Code), false),
        Some(MapClass::Data)
    );
}

/// GNU as 2.46 output for an x86-64 executable-section alignment gap
/// of 1..=24 bytes: the fill after a data directive and the fill after
/// an instruction, as `(gap, data_fill, insn_fill)`. Measured by
/// assembling `.fill n, 1, 0xcc` / `n` one-byte NOPs followed by
/// `.balign 64` and reading back the padding.
const GAS_ALIGN_FILL: &[(usize, &[u8], &[u8])] = &[
    (1, &[0x90], &[0x90]),
    (2, &[0x90, 0x90], &[0x66, 0x90]),
    (3, &[0x90, 0x66, 0x90], &[0x0f, 0x1f, 0x00]),
    (4, &[0x90, 0x0f, 0x1f, 0x00], &[0x0f, 0x1f, 0x40, 0x00]),
    (
        5,
        &[0x90, 0x0f, 0x1f, 0x40, 0x00],
        &[0x0f, 0x1f, 0x44, 0x00, 0x00],
    ),
    (
        6,
        &[0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00],
        &[0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00],
    ),
    (
        7,
        &[0x90, 0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00],
        &[0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00],
    ),
    (
        8,
        &[0x90, 0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00],
        &[0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    ),
    (
        9,
        &[0x90, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
        &[0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    ),
    (
        10,
        &[0x90, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
        &[0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    ),
    (
        11,
        &[
            0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
        &[
            0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
    ),
    (
        12,
        &[
            0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
        &[
            0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
    ),
    (
        13,
        &[
            0x90, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
        &[
            0x66, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
    ),
    (
        14,
        &[
            0x90, 0x66, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
        &[
            0x0f, 0x1f, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
    ),
    (
        15,
        &[
            0x90, 0x0f, 0x1f, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00,
            0x00,
        ],
        &[
            0x0f, 0x1f, 0x40, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00,
            0x00,
        ],
    ),
    (
        16,
        &[
            0x90, 0x0f, 0x1f, 0x40, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00,
            0x00, 0x00,
        ],
        &[
            0x0f, 0x1f, 0x44, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00,
            0x00, 0x00,
        ],
    ),
    (
        17,
        &[
            0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00,
            0x00, 0x00, 0x00,
        ],
        &[
            0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00,
            0x00, 0x00, 0x00,
        ],
    ),
    (
        18,
        &[
            0x90, 0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00,
            0x00, 0x00, 0x00, 0x00,
        ],
        &[
            0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00,
            0x00, 0x00, 0x00, 0x00,
        ],
    ),
    (
        22,
        &[
            0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e,
            0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
        &[
            0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e,
            0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
    ),
    (
        23,
        &[
            0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66,
            0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
        &[
            0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66,
            0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
    ),
    (
        24,
        &[
            0x90, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66,
            0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
        &[
            0x66, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66,
            0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
        ],
    ),
];

/// GNU as output for an 88-byte x86-64 alignment gap after an instruction:
/// the first gap over seven maximal NOPs, so the first one jumped over.
const GAS_ALIGN_FILL_88: &[u8] = &[
    0xeb, 0x56, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f,
    0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f,
    0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e,
    0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
];

/// The jump GNU as opens a wide x86-64 alignment gap with, as `(gap, jump)`:
/// the `rel8` form up to the last displacement it reaches, the `rel32` form
/// past it. Measured the same way as [`GAS_ALIGN_FILL`].
const GAS_ALIGN_JUMP: &[(usize, &[u8])] = &[
    (88, &[0xeb, 0x56]),
    (89, &[0xeb, 0x57]),
    (129, &[0xeb, 0x7f]),
    (130, &[0xe9, 0x7d, 0x00, 0x00, 0x00]),
    (260, &[0xe9, 0xff, 0x00, 0x00, 0x00]),
];

/// GNU as output for a `.code16` executable-section alignment gap of 1..=16
/// bytes, in the same columns as [`GAS_ALIGN_FILL`] and measured the same
/// way. The 16-bit no-op forms run to five bytes and only two maximal ones
/// are laid before the padding is jumped over, so the jump appears at 15.
const GAS_ALIGN_FILL_16: &[(usize, &[u8], &[u8])] = &[
    (1, &[0x90], &[0x90]),
    (2, &[0x90, 0x90], &[0x89, 0xf6]),
    (3, &[0x90, 0x89, 0xf6], &[0x8d, 0x74, 0x00]),
    (4, &[0x90, 0x8d, 0x74, 0x00], &[0x8d, 0xb4, 0x00, 0x00]),
    (
        5,
        &[0x90, 0x8d, 0xb4, 0x00, 0x00],
        &[0x2e, 0x8d, 0xb4, 0x00, 0x00],
    ),
    (
        6,
        &[0x90, 0x2e, 0x8d, 0xb4, 0x00, 0x00],
        &[0x90, 0x2e, 0x8d, 0xb4, 0x00, 0x00],
    ),
    (
        7,
        &[0x90, 0x90, 0x2e, 0x8d, 0xb4, 0x00, 0x00],
        &[0x89, 0xf6, 0x2e, 0x8d, 0xb4, 0x00, 0x00],
    ),
    (
        10,
        &[0x90, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00],
        &[0x2e, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00],
    ),
    (
        14,
        &[
            0x90, 0x8d, 0x74, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00,
        ],
        &[
            0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00,
        ],
    ),
    (
        15,
        &[
            0x90, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00,
            0x00,
        ],
        &[
            0xeb, 0x0d, 0x8d, 0x74, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00,
            0x00,
        ],
    ),
    (
        16,
        &[
            0x90, 0xeb, 0x0d, 0x8d, 0x74, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4,
            0x00, 0x00,
        ],
        &[
            0xeb, 0x0e, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4, 0x00, 0x00, 0x2e, 0x8d, 0xb4,
            0x00, 0x00,
        ],
    ),
];

/// The jump GNU as opens a wide `.code16` alignment gap with. Past the `rel8`
/// range the 32-bit displacement takes the operand-size prefix, so the jump
/// is six bytes rather than five.
const GAS_ALIGN_JUMP_16: &[(usize, &[u8])] = &[
    (15, &[0xeb, 0x0d]),
    (129, &[0xeb, 0x7f]),
    (130, &[0x66, 0xe9, 0x7c, 0x00, 0x00, 0x00]),
    (260, &[0x66, 0xe9, 0xfe, 0x00, 0x00, 0x00]),
];

#[test]
fn code16_exec_align_fill_matches_gnu_as() {
    let fill = |gap: usize, after_insn: bool| {
        let mut out = alloc::vec::Vec::new();
        push_x86_exec_align_fill(&mut out, gap, after_insn, AlignNops::X86Bits16);
        out
    };
    for &(gap, data_fill, insn_fill) in GAS_ALIGN_FILL_16 {
        for (after_insn, want) in [(false, data_fill), (true, insn_fill)] {
            assert_eq!(
                fill(gap, after_insn),
                want,
                "gap {gap}, after_insn {after_insn}: fill differs from GNU as"
            );
        }
    }
    for &(gap, jump) in GAS_ALIGN_JUMP_16 {
        let got = fill(gap, true);
        assert_eq!(got.len(), gap);
        assert_eq!(
            &got[..jump.len()],
            jump,
            "gap {gap}: jump differs from GNU as"
        );
    }
    // The widest gap the 16-bit NOP count still covers takes no jump.
    let last_plain = X86_NOPS_16.len() * (X86_MAX_NOPS_16 + 1) - 1;
    assert_ne!(fill(last_plain, true)[0], GAS_ALIGN_JUMP_16[0].1[0]);
}

#[test]
fn x86_exec_align_fill_jumps_over_a_wide_gap_like_gnu_as() {
    let fill = |gap: usize, after_insn: bool| {
        let mut out = alloc::vec::Vec::new();
        push_x86_exec_align_fill(&mut out, gap, after_insn, AlignNops::X86);
        out
    };
    assert_eq!(fill(GAS_ALIGN_FILL_88.len(), true), GAS_ALIGN_FILL_88);
    // The widest gap the NOP count still covers takes no jump.
    let last_plain = X86_NOPS.len() * (X86_MAX_NOPS + 1) - 1;
    assert_ne!(fill(last_plain, true)[0], GAS_ALIGN_JUMP[0].1[0]);
    for &(gap, jump) in GAS_ALIGN_JUMP {
        let got = fill(gap, true);
        assert_eq!(got.len(), gap);
        assert_eq!(
            &got[..jump.len()],
            jump,
            "gap {gap}: jump differs from GNU as"
        );
        // The jump's displacement reaches the byte past the padding.
        let disp = match jump.len() {
            2 => jump[1] as usize,
            _ => u32::from_le_bytes(jump[1..].try_into().unwrap()) as usize,
        };
        assert_eq!(disp + jump.len(), gap);
        // A gap opening after data takes the leading one-byte NOP first, and
        // the rest of the gap decides the jump.
        let after_data = fill(gap + 1, false);
        assert_eq!(after_data[0], X86_NOPS[0][0]);
        assert_eq!(&after_data[1..], &got[..]);
    }
}

#[test]
fn x86_exec_align_fill_matches_gnu_as() {
    for &(gap, data_fill, insn_fill) in GAS_ALIGN_FILL {
        for (after_insn, want) in [(false, data_fill), (true, insn_fill)] {
            let mut got = alloc::vec::Vec::new();
            push_x86_exec_align_fill(&mut got, gap, after_insn, AlignNops::X86);
            assert_eq!(
                got, want,
                "gap {gap}, after_insn {after_insn}: fill differs from GNU as"
            );
        }
    }
    // Past the table the tail is maximal NOPs, so a gap and the gap
    // eleven bytes larger differ by exactly one more of them.
    for gap in 1..=63usize {
        for after_insn in [false, true] {
            let mut small = alloc::vec::Vec::new();
            push_x86_exec_align_fill(&mut small, gap, after_insn, AlignNops::X86);
            let mut large = alloc::vec::Vec::new();
            push_x86_exec_align_fill(&mut large, gap + X86_NOPS.len(), after_insn, AlignNops::X86);
            assert_eq!(small.len(), gap);
            assert_eq!(large.len(), gap + X86_NOPS.len());
            assert_eq!(
                &large[..gap],
                &small[..],
                "gap {gap}: prefix must be stable"
            );
            assert_eq!(&large[gap..], X86_NOPS[X86_NOPS.len() - 1]);
        }
    }
}

#[test]
fn section_label_difference_parses() {
    // `label_a - label_b` is a constant distance; `label - .` stays
    // PC-relative; a bare name stays a plain reference.
    assert_eq!(
        parse_section_value("662b - 661b").unwrap(),
        AsmSectionValue::LabelDiff {
            minuend: alloc::string::String::from("662b"),
            subtrahend: alloc::string::String::from("661b"),
        }
    );
    assert_eq!(
        parse_section_value("662f-661b").unwrap(),
        AsmSectionValue::LabelDiff {
            minuend: alloc::string::String::from("662f"),
            subtrahend: alloc::string::String::from("661b"),
        }
    );
    assert_eq!(
        parse_section_value("661b - .").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("661b"),
            pcrel: true,
            addend: alloc::string::String::new(),
        }
    );
    assert_eq!(
        parse_section_value("sym").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("sym"),
            pcrel: false,
            addend: alloc::string::String::new(),
        }
    );
    // Three bare labels do not fit a single relocation; the form defers
    // to the location-value evaluator, which folds or rejects it once
    // the labels' spaces are known.
    assert_eq!(
        parse_section_value("a - b - c").unwrap(),
        AsmSectionValue::LocExpr(alloc::string::String::from("a - b - c"))
    );
}

#[test]
fn section_reloc_addend_parses() {
    // `func - (. + 4)` (a static-call trampoline's `jmp.d32` to an external
    // symbol): PC-relative against `func`, the inner `+ 4` folding into the
    // addend as `- 4`.
    assert_eq!(
        parse_section_value("func - (. + 4)").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("func"),
            pcrel: true,
            addend: alloc::string::String::from("0 - 4"),
        }
    );
    // `1b - %c2 - .` (the user-pointer bound): PC-relative against the
    // template label `1b`, the operand constant `%c2` folding into the
    // addend.
    assert_eq!(
        parse_section_value("1b - %c2 - .").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("1b"),
            pcrel: true,
            addend: alloc::string::String::from("0 - %c2"),
        }
    );
    // An absolute (non-PC-relative) base plus a constant addend.
    assert_eq!(
        parse_section_value("sym + 8").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("sym"),
            pcrel: false,
            addend: alloc::string::String::from("0 + 8"),
        }
    );
    // Two relocation bases with an addend, and a positive location
    // counter, defer to the location-value evaluator.
    assert_eq!(
        parse_section_value("a - b + 4").unwrap(),
        AsmSectionValue::LocExpr(alloc::string::String::from("a - b + 4"))
    );
    assert_eq!(
        parse_section_value("sym + .").unwrap(),
        AsmSectionValue::LocExpr(alloc::string::String::from("sym + ."))
    );
}

#[test]
fn shift_right_is_logical_like_gnu_as() {
    // GNU as shifts the 64-bit value, so `>>` never replicates the sign
    // bit. Verified against `as` (`.quad` of each expression): the kernel's
    // GENMASK reduces to 1, not -1, which is what makes it a valid AArch64
    // logical immediate.
    assert_eq!(eval_const_expr("~0 >> 63"), Some(1));
    assert_eq!(eval_const_expr("-8 >> 1"), Some(0x7fff_ffff_ffff_fffc));
    assert_eq!(eval_const_expr("1 << 63 >> 60"), Some(8));
    assert_eq!(
        eval_const_expr("(((~(0)) << (0)) & (~(0) >> (64 - 1 - (0))))"),
        Some(1)
    );
}

#[test]
fn octa_and_cfi_match_gnu_as() {
    // GNU as reference (x86-64 `as`, section `.probe,"a"`). `.octa` takes a
    // 16-byte little-endian field: a literal too wide for 64 bits keeps its
    // full value, a narrower expression sign-extends. `.cfi_*` deposits no
    // bytes.
    let text = ".pushsection .probe,\"a\"\n\
                .cfi_sections .debug_frame\n\
                .octa 0x000102030405060708090a0b0c0d0e0f\n\
                .cfi_startproc\n\
                .octa 1+2\n\
                .octa -1\n\
                .octa 0x5BE0CD191F83D9AB9B05688C510E527F, 0xA54FF53A3C6EF372BB67AE856A09E667\n\
                .cfi_endproc\n\
                .popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let mut want = alloc::vec::Vec::new();
    want.extend_from_slice(&(0x000102030405060708090a0b0c0d0e0fu128).to_le_bytes());
    want.extend_from_slice(&3u128.to_le_bytes());
    want.extend_from_slice(&(-1i128).to_le_bytes());
    want.extend_from_slice(&(0x5BE0CD191F83D9AB9B05688C510E527Fu128).to_le_bytes());
    want.extend_from_slice(&(0xA54FF53A3C6EF372BB67AE856A09E667u128).to_le_bytes());
    assert_eq!(sink.section(0).bytes, want);
}

#[test]
fn location_valued_expressions_match_gnu_as() {
    // GNU as reference (x86-64 `as`, one section `.probe,"a"`):
    //   a: .long 8
    //   b: .long b - a          -> 4 (constant)
    //   .long a - b             -> -4
    //   .quad a                 -> ABS64 reloc
    //   .long a - .             -> constant (both in .probe): 0 - 0x14
    //   .long ext - .           -> PC32 ext + 0
    //   .quad ext + 8           -> ABS64 ext + 8
    //   .long (b - a) / 4       -> 1
    //   .quad .                 -> ABS64 .probe + 0x28
    let text = ".pushsection .probe,\"a\"\n\
                a:\n.long 8\n\
                b:\n.long b - a\n\
                .long a - b\n\
                .quad a\n\
                .long a - .\n\
                .long ext - .\n\
                .quad ext + 8\n\
                .long (b - a) / 4\n\
                .quad .\n\
                .popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let mut want = alloc::vec::Vec::new();
    want.extend_from_slice(&8i32.to_le_bytes());
    want.extend_from_slice(&4i32.to_le_bytes());
    want.extend_from_slice(&(-4i32).to_le_bytes());
    want.extend_from_slice(&[0u8; 8]); // .quad a (reloc)
    want.extend_from_slice(&(-0x14i32).to_le_bytes());
    want.extend_from_slice(&[0u8; 4]); // .long ext - . (reloc)
    want.extend_from_slice(&[0u8; 8]); // .quad ext + 8 (reloc)
    want.extend_from_slice(&1i32.to_le_bytes());
    want.extend_from_slice(&[0u8; 8]); // .quad . (reloc)
    assert_eq!(sink.section(0).bytes, want);
    assert_eq!(
        sink.section(0).relocs,
        alloc::vec![
            AsmSectionReloc {
                offset: 0x0c,
                width: 8,
                kind: AsmRelocKind::Data,
                pcrel: false,
                branch: false,
                signed: false,
                target: AsmSectionTarget::Symbol(alloc::string::String::from("a")),
                addend: 0,
            },
            AsmSectionReloc {
                offset: 0x18,
                width: 4,
                kind: AsmRelocKind::Data,
                pcrel: true,
                branch: false,
                signed: false,
                target: AsmSectionTarget::Symbol(alloc::string::String::from("ext")),
                addend: 0,
            },
            AsmSectionReloc {
                offset: 0x1c,
                width: 8,
                kind: AsmRelocKind::Data,
                pcrel: false,
                branch: false,
                signed: false,
                target: AsmSectionTarget::Symbol(alloc::string::String::from("ext")),
                addend: 8,
            },
            AsmSectionReloc {
                offset: 0x28,
                width: 8,
                kind: AsmRelocKind::Data,
                pcrel: false,
                branch: false,
                signed: false,
                target: AsmSectionTarget::OwnSection(0x28),
                addend: 0,
            },
        ],
    );
}

#[test]
fn location_expression_cross_statement_size() {
    // `.size f, . - f` in a later template resolves against a label an
    // earlier statement placed in the same sink section, at merged
    // offsets. The second call's `.balign` also pads from the merged
    // length, keeping measurement and materialization in agreement.
    let t1 = ".pushsection .t,\"ax\"\nf:\n.byte 1, 2, 3\n.popsection\n";
    let t2 = ".pushsection .t,\"ax\"\n.balign 4\ng:\n.byte 9\n.size f, g - f\n.popsection\n";
    let mut sink = AsmSectionSink::default();
    for t in [t1, t2] {
        let AsmExtract { blocks, .. } = extract_asm_sections(t, false).unwrap().unwrap();
        materialize_asm_sections(
            &blocks,
            &AsmOperandResolver::NONE,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
    }
    assert_eq!(sink.section(0).bytes.len(), 5); // 3 bytes, 1 pad, 1 byte
    let f = sink
        .section(0)
        .labels
        .iter()
        .find(|l| l.name == "f")
        .unwrap();
    assert_eq!(f.size, Some(4));
}

#[test]
fn string_directive_operand_lists() {
    // `.ascii` / `.asciz` / `.string` take a comma-separated operand
    // list; adjacent literals in one operand concatenate; `.asciz` /
    // `.string` terminate each operand, `.ascii` terminates none.
    let bytes = |tok: &str, rest: &str| match parse_string_directive(tok, rest).unwrap() {
        AsmSectionItem::Bytes(b) => b,
        other => panic!("expected Bytes, got {other:?}"),
    };
    assert_eq!(bytes(".ascii", "\"A\""), b"A");
    assert_eq!(bytes(".asciz", "\"B\""), b"B\0");
    assert_eq!(bytes(".ascii", "\"C\", \"D\""), b"CD");
    assert_eq!(bytes(".asciz", "\"E\", \"F\""), b"E\0F\0");
    assert_eq!(bytes(".ascii", "\"G\" \"H\""), b"GH");
    assert_eq!(bytes(".string", "\"I\", \"J\""), b"I\0J\0");
    // The metadata-section shape: an empty literal adjacent to an
    // escaped NUL is one empty operand plus the NUL byte.
    assert_eq!(bytes(".ascii", "\"\" \"\\0\""), b"\0");
    // Assembler escapes: octal and hex runs, and pass-through for the
    // quoted quote and backslash.
    assert_eq!(bytes(".ascii", "\"\\101\\x42\\n\\\\\""), b"AB\n\\");
    assert!(parse_string_directive(".ascii", "\"a\" junk").is_err());
    assert!(parse_string_directive(".ascii", "\"a\", ").is_err());
    assert!(parse_string_directive(".ascii", "\"open").is_err());
}

#[test]
fn section_value_quoted_symbol_name() {
    // A double-quoted symbol name is the symbol, quotes stripped, and
    // composes with an addend and the `- .` PC-relative marker.
    assert_eq!(
        parse_section_value("\"__SCK__call\"").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("__SCK__call"),
            pcrel: false,
            addend: alloc::string::String::new(),
        }
    );
    assert_eq!(
        parse_section_value("\"sym\" + 8").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("sym"),
            pcrel: false,
            addend: alloc::string::String::from("0 + 8"),
        }
    );
    // The quoted run is opaque: the name may carry expression characters.
    assert_eq!(
        parse_section_value("\"a-b\" - .").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("a-b"),
            pcrel: true,
            addend: alloc::string::String::new(),
        }
    );
    // An unterminated quote is not a value.
    assert!(parse_section_value("\"sym").is_err());
}

#[test]
fn section_value_strips_enclosing_parens() {
    // A fully-enclosing paren group is grouping only. The aarch64
    // exception table wraps the whole PC-relative expression
    // (`.long ((insn) - .)`); it must reduce like the single-paren form.
    assert_eq!(
        parse_section_value("((1b) - .)").unwrap(),
        parse_section_value("(1b) - .").unwrap(),
    );
    assert_eq!(
        parse_section_value("((1b) - .)").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("1b"),
            pcrel: true,
            addend: alloc::string::String::new(),
        }
    );
    assert_eq!(
        parse_section_value("(((sym)))").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("sym"),
            pcrel: false,
            addend: alloc::string::String::new(),
        }
    );
    // A group closing before the end is not a full enclosure: the two
    // parenthesised labels stay a constant distance.
    assert_eq!(
        parse_section_value("(662b) - (661b)").unwrap(),
        AsmSectionValue::LabelDiff {
            minuend: alloc::string::String::from("662b"),
            subtrahend: alloc::string::String::from("661b"),
        }
    );
}

#[test]
fn section_operand_constant_expression() {
    // `(1 << 15) | (%0)`: a constant expression whose leaves are integer
    // literals and an operand constant. It parses as a deferred `Expr` and
    // materializes with the operand resolved (a cpucap number 37, so
    // 0x8000 | 37 = 0x8025).
    assert_eq!(
        parse_section_value("(1 << 15) | (%0)").unwrap(),
        AsmSectionValue::Expr(alloc::string::String::from("(1 << 15) | (%0)")),
    );
    let text = ".pushsection .altinstructions,\"a\"\n.hword (1 << 15) | (%0)\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver {
            const_of: &|idx| (idx == 0).then_some(37),
            symbol_of: &|_| None,
            form: AsmOperandResolver::NONE.form,
        },
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    assert_eq!(sink.section(0).bytes, alloc::vec![0x25, 0x80]);
    // A non-constant operand leaves the expression unresolved.
    let mut sink2 = AsmSectionSink::default();
    let err = materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink2,
    )
    .unwrap_err();
    assert!(err.contains("non-constant"), "{err}");
}

#[test]
fn section_parenthesised_label_reference() {
    // `_ASM_EXTABLE` wraps its label in parentheses (`.long (1b) - .`).
    // The parentheses are grouping, so it resolves like the bare `1b - .`,
    // and a parenthesised label distance like the bare form.
    assert_eq!(
        parse_section_value("(1b) - .").unwrap(),
        AsmSectionValue::Ref {
            name: alloc::string::String::from("1b"),
            pcrel: true,
            addend: alloc::string::String::new(),
        },
    );
    assert_eq!(
        parse_section_value("(2b) - (1b)").unwrap(),
        AsmSectionValue::LabelDiff {
            minuend: alloc::string::String::from("2b"),
            subtrahend: alloc::string::String::from("1b"),
        },
    );
    // The materialized field is a PC-relative reloc to the label's text
    // offset, as for the unparenthesised reference.
    let text = "1: nop\n.pushsection __ex_table,\"a\"\n.long (1b) - .\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|n| (n == "1b").then_some(LabelLoc::Text(0x40)),
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    assert_eq!(
        sink.section(0).relocs,
        alloc::vec![AsmSectionReloc {
            offset: 0,
            width: 4,
            kind: AsmRelocKind::Data,
            pcrel: true,
            branch: false,
            signed: false,
            target: AsmSectionTarget::Text(0x40),
            addend: 0,
        }],
    );
}

#[test]
fn asm_conditionals_keep_the_taken_branch() {
    // `.if <expr>` compares with the relational operators; a non-zero
    // result keeps the branch. A true comparison is -1, as in GNU as.
    // `.else` / `.elseif` select the live arm, and a dropped branch takes
    // its `.pushsection` with it.
    assert_eq!(eval_asm_if_condition("1 == 1"), Some(-1));
    assert_eq!(eval_asm_if_condition("1 != 1"), Some(0));
    assert_eq!(eval_asm_if_condition("(1 << 2) >= 4"), Some(-1));
    assert_eq!(eval_asm_if_condition("nop"), None);
    let reduce = |t: &str| strip_asm_conditionals(t).unwrap().unwrap();
    assert_eq!(reduce(".if 1 == 1\nnop\n.endif\n"), "nop\n");
    assert_eq!(reduce(".if 0\nbad\n.else\ngood\n.endif\n"), "good\n");
    assert_eq!(
        reduce(".if 0\n.pushsection .x\n.byte 1\n.popsection\n.endif\nkeep\n"),
        "keep\n"
    );
    // A false outer branch suppresses a true inner one.
    assert_eq!(reduce(".if 0\n.if 1\nx\n.endif\n.endif\ny\n"), "y\n");
    // Unbalanced and non-constant conditions are rejected.
    assert!(strip_asm_conditionals(".if 1\nnop\n").is_err());
    assert!(strip_asm_conditionals(".if x\n.endif\n").is_err());
    // A template with no conditional is left untouched.
    assert!(strip_asm_conditionals("nop\n").unwrap().is_none());
}

#[test]
fn word_directive_width_is_target_dependent() {
    // GNU as `.word` is 2 bytes on x86 ELF, 4 on AArch64. The alternatives
    // metadata stores a label reference with `.word`, which needs a 4- or
    // 8-byte field, so it resolves only under the AArch64 width.
    let width = |is_a64: bool| -> u8 {
        let AsmExtract { blocks, .. } =
            extract_asm_sections(".pushsection .x,\"a\"\n.word 0x1234\n.popsection\n", is_a64)
                .unwrap()
                .unwrap();
        match &blocks[0].items[0] {
            AsmSectionItem::Data { width, .. } => *width,
            _ => panic!("expected data"),
        }
    };
    assert_eq!(width(false), 2);
    assert_eq!(width(true), 4);
    // On AArch64 `.word 1b - .` fits its PC-relative reloc.
    let AsmExtract { blocks, .. } =
        extract_asm_sections(".pushsection .x,\"a\"\n.word 1b - .\n.popsection\n", true)
            .unwrap()
            .unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|n| (n == "1b").then_some(LabelLoc::Text(0)),
        &|_| None,
        true,
        &mut sink,
    )
    .unwrap();
    assert_eq!(sink.section(0).relocs[0].width, 4);
}

#[test]
fn section_label_difference_bytes() {
    // Distances between two template labels are constants sized to the
    // field, forward or backward, byte-verified against GNU as (a 4-byte
    // instruction between the labels: `.byte 2b - 1b` is 0x04, `1b - 2b`
    // is 0xFC).
    let text = "1: nop\n2: nop\n.pushsection .x,\"a\"\n\
                .byte 2b - 1b\n.short 2b - 1b\n.long 2b - 1b\n.byte 1b - 2b\n\
                .popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|name| match name {
            "1b" => Some(LabelLoc::Text(0)),
            "2b" => Some(LabelLoc::Text(4)),
            _ => None,
        },
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let s = sink.section(0);
    assert_eq!(
        s.bytes,
        alloc::vec![0x04, 0x04, 0x00, 0x04, 0x00, 0x00, 0x00, 0xFC]
    );
    assert!(s.relocs.is_empty());
}

#[test]
fn cross_section_label_difference_folds_to_replacement_length() {
    // The alternatives entry's `.byte 775f - 774f` measures a distance
    // between two labels in a later section (`.altinstr_replacement`), while
    // the field itself sits in `.altinstructions`. GNU as folds it to the
    // replacement length (3 here). A difference across sections is rejected.
    let text = ".pushsection .altinstructions,\"a\"\n.byte 775f - 774f\n.popsection\n\
                .pushsection .altinstr_replacement,\"ax\"\n\
                774:\n.byte 0x0f,0x01,0xca\n775:\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let entry = sink
        .sections()
        .iter()
        .find(|s| s.name == ".altinstructions")
        .unwrap();
    assert_eq!(
        entry.bytes,
        alloc::vec![3],
        "775f - 774f is the repl length"
    );
    assert!(
        entry.relocs.is_empty(),
        "a same-section distance is constant"
    );
}

#[test]
fn cross_section_label_difference_across_sections_is_rejected() {
    // `774f` and `1b` live in different sections, so their difference is not
    // a constant; it is rejected rather than folded to a bogus byte.
    let text = "1: nop\n.pushsection .a,\"a\"\n.byte 774f - 1b\n.popsection\n\
                .pushsection .b,\"ax\"\n774:\n.byte 0\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    let err = materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|name| (name == "1b").then_some(LabelLoc::Text(0)),
        &|_| None,
        false,
        &mut sink,
    )
    .expect_err("cross-section difference is not a constant");
    assert!(err.contains("crosses sections"), "{err}");
}

#[test]
fn skip_count_expression_matches_gnu_as() {
    // The ALTERNATIVE `.skip` count `-(((rlen)-(slen)) > 0) * ((rlen)-(slen))`
    // pads by `max(0, rlen - slen)`: a relational is -1 for true (GNU as),
    // so a longer replacement yields a positive count and a shorter one
    // zero. Labels resolve through the passed closure.
    let expr = "-(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b))";
    let pad = |rlen: i64, slen: i64| {
        eval_asm_expr_with_labels(expr, &|n| match n {
            "775f" => Some(rlen),
            "774f" => Some(0),
            "772b" => Some(slen),
            "771b" => Some(0),
            _ => None,
        })
    };
    assert_eq!(pad(3, 0), Some(3), "replacement longer: pad the difference");
    assert_eq!(pad(1, 4), Some(0), "replacement shorter: no padding");
    assert_eq!(pad(2, 2), Some(0), "equal length: no padding");
    // A constant count needs no labels; an unknown label is not a constant.
    assert_eq!(eval_asm_expr_with_labels("16", &|_| None), Some(16));
    assert_eq!(eval_asm_expr_with_labels("7f - 6b", &|_| None), None);
}

#[test]
fn measure_offsets_locate_section_labels() {
    // Structural measurement places each label at its byte offset within the
    // section, so a forward difference resolves before the values are laid
    // out: `774` at 0, `775` after the 3 replacement bytes.
    let text = ".pushsection .altinstr_replacement,\"ax\"\n\
                774:\n.byte 0x0f,0x01,0xca\n775:\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let m =
        measure_asm_section_offsets(&blocks, &|_| None, false, &AsmSectionSink::default()).unwrap();
    assert_eq!(m.offset("774f"), Some(0));
    assert_eq!(m.offset("775f"), Some(3));
    assert_eq!(m.section("774f"), m.section("775f"), "same section");
}

#[test]
fn section_label_difference_overflow_rejected() {
    // A distance outside the field width is rejected, not truncated.
    let text = "1: nop\n2: nop\n.pushsection .x,\"a\"\n.byte 2b - 1b\n.popsection\n";
    let AsmExtract {
        code: _c, blocks, ..
    } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    let err = materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|name| match name {
            "1b" => Some(LabelLoc::Text(0)),
            "2b" => Some(LabelLoc::Text(256)),
            _ => None,
        },
        &|_| None,
        false,
        &mut sink,
    )
    .expect_err("256 does not fit a byte");
    assert!(err.contains("does not fit"), "{err}");
}

#[test]
fn subsection_is_rejected() {
    // The AArch64 emitter lifts the ALTERNATIVE `.subsection` replacement
    // with `split_asm_subsections` before this; `extract_asm_sections` is
    // the backstop for any `.subsection` that reaches it (a shape the split
    // did not lift). Emitting it inline would run both the main and the
    // replacement sequence, so it is rejected rather than miscompiled.
    let with = "661: nop\n.pushsection .altinstructions,\"a\"\n.byte 0\n\
                .popsection\n.subsection 1\n663: nop\n.previous\n";
    let err = extract_asm_sections(with, true).unwrap_err();
    assert!(err.contains(".subsection"), "{err}");
    let bare = "nop\n.subsection 1\nnop\n.previous\n";
    let err = extract_asm_sections(bare, true).unwrap_err();
    assert!(err.contains(".subsection"), "{err}");
}

#[test]
fn split_asm_subsections_lifts_supported_shape() {
    // The clean ALTERNATIVE shape -- a `.subsection N` bracketed by
    // `.previous` at code-stream level -- is lifted: its lines move to the
    // deferred stream and leave the main stream free of `.subsection`, so
    // `extract_asm_sections` then processes it.
    let text = "661:\nmrs x0, tpidr_el1\n662:\n\
                .pushsection .altinstructions,\"a\"\n.byte 0\n.popsection\n\
                .subsection 1\n663:\nmrs x0, tpidr_el2\n664:\n.previous\n";
    let (main, deferred) = split_asm_subsections(text);
    assert!(!main.contains(".subsection"), "main: {main}");
    assert!(main.contains("tpidr_el1") && main.contains(".altinstructions"));
    assert!(deferred.contains("tpidr_el2") && deferred.contains("663:"));
    assert!(!deferred.contains("tpidr_el1"));
    // Shapes the split does not lift are left intact for the backstop: an
    // open region (no `.previous`), a second region, and a `.subsection`
    // nested in a `.pushsection`.
    for unlifted in [
        "nop\n.subsection 1\nnop\n",
        ".subsection 1\nnop\n.previous\n.subsection 1\nnop\n.previous\n",
        ".pushsection .x,\"ax\"\n.subsection 1\nnop\n.previous\n.popsection\n",
    ] {
        let (main, deferred) = split_asm_subsections(unlifted);
        assert_eq!(main, unlifted, "left intact");
        assert!(deferred.is_empty());
    }
    // A template without `.subsection` is returned unchanged.
    let (main, deferred) = split_asm_subsections("nop\nret\n");
    assert_eq!(main, "nop\nret\n");
    assert!(deferred.is_empty());
}

#[test]
fn deferred_org_length_expression_via_label_evaluator() {
    // The deferred `.org` target reuses `eval_asm_expr_with_labels` with a
    // resolver mapping the location counter `.` to the current offset and
    // each `Nb` label to its offset. `. - (664b-663b) + (662b-661b)` moves
    // `.` by (old_len - new_len): a no-op when the lengths match, backward
    // (an error at the call site) when the replacement is longer.
    let at = |cur: i64, m: &[(&'static str, i64)]| {
        eval_asm_expr_with_labels(". - (664b-663b) + (662b-661b)", &|n| {
            if n == "." {
                return Some(cur);
            }
            m.iter().find(|(k, _)| *k == n).map(|(_, v)| *v)
        })
    };
    // new_len 8, old_len 8: target equals `.`.
    assert_eq!(
        at(8, &[("663b", 0), ("664b", 8), ("661b", 0), ("662b", 8)]),
        Some(8)
    );
    // new_len 8, old_len 4: target 8 - 8 + 4 = 4, a backward move.
    assert_eq!(
        at(8, &[("663b", 0), ("664b", 8), ("661b", 0), ("662b", 4)]),
        Some(4)
    );
}

#[test]
fn replacement_instruction_kept_as_code_for_executable_section() {
    // The x86 ALTERNATIVE places its replacement in a `.pushsection
    // .altinstr_replacement,"ax"`. An instruction there is kept as a `Code`
    // item; the arch backend encodes it (a direct call/jmp to a symbol or a
    // self-contained instruction) or rejects an un-encodable one (see the
    // linker test `x86_alternative_call_replacement_encodes_and_relocates`).
    let exec = "771: nop\n.pushsection .altinstr_replacement,\"ax\"\n\
                774: call foo\n775:\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(exec, false).unwrap().unwrap();
    let repl = blocks
        .iter()
        .find(|b| b.name == ".altinstr_replacement")
        .unwrap();
    assert!(
        repl.items
            .iter()
            .any(|it| matches!(it, AsmSectionItem::Code(t) if t == "call foo")),
        "instruction kept as Code: {:?}",
        repl.items
    );
    // GNU as assembles instructions into any section; the flags set the
    // object section's attributes, not whether code is admitted. An
    // instruction in a section flagged `"a"` (not executable) is likewise
    // kept as a `Code` item for the backend to encode.
    let data = "771: nop\n.pushsection .data.tramp,\"a\"\n\
                774: wrmsr\n775:\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(data, false).unwrap().unwrap();
    let sec = blocks.iter().find(|b| b.name == ".data.tramp").unwrap();
    assert!(
        sec.items
            .iter()
            .any(|it| matches!(it, AsmSectionItem::Code(t) if t == "wrmsr")),
        "instruction in a non-executable section is kept as Code: {:?}",
        sec.items
    );
}

#[test]
fn label_without_whitespace_peels_from_following_instruction() {
    // GNU as terminates a label at the colon and requires no whitespace
    // before the statement that follows, so `name:insn` in a named section
    // is a label plus an instruction. Both must reach the block as separate
    // items -- a `Label` and a single-instruction `Code` -- not one glued
    // `Code("name:insn")` the arch encoder then rejects.
    let src = ".pushsection .spinlock.text,\"ax\"\n\
               wrapper:push %rcx\n\
               pop %rcx\n\
               .popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(src, false).unwrap().unwrap();
    let sec = blocks.iter().find(|b| b.name == ".spinlock.text").unwrap();
    assert!(
        sec.items
            .iter()
            .any(|it| matches!(it, AsmSectionItem::Label(n) if n == "wrapper")),
        "label peeled as its own item: {:?}",
        sec.items
    );
    assert!(
        sec.items
            .iter()
            .any(|it| matches!(it, AsmSectionItem::Code(t) if t == "push %rcx")),
        "the instruction after the label is a single-instruction Code item: {:?}",
        sec.items
    );
    assert!(
        !sec.items
            .iter()
            .any(|it| matches!(it, AsmSectionItem::Code(t) if t.contains(':'))),
        "no Code item retains the label colon: {:?}",
        sec.items
    );
}

#[test]
fn data_field_fit_boundaries() {
    // Signed-or-unsigned fit per width, matching GNU as's accept set.
    assert!(value_fits_width(255, 1) && value_fits_width(-128, 1));
    assert!(!value_fits_width(256, 1) && !value_fits_width(-129, 1));
    assert!(value_fits_width(65535, 2) && value_fits_width(-32768, 2));
    assert!(!value_fits_width(65536, 2));
    assert!(value_fits_width(0xFFFF_FFFF, 4) && !value_fits_width(0x1_0000_0000, 4));
    assert!(value_fits_width(i64::MIN, 8) && value_fits_width(i64::MAX, 8));
}

#[test]
fn section_previous_and_symbols() {
    // `.section` + `.previous` return to the code stream; an unknown
    // name resolves as a symbol target.
    let text = "nop\n.section .fixup,\"ax\"\n.quad handler\n.previous\nnop\n";
    let AsmExtract { code, blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    assert_eq!(code, "nop\nnop\n");
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    assert_eq!(
        sink.section(0).relocs[0].target,
        AsmSectionTarget::Symbol(alloc::string::String::from("handler"))
    );
    // Two blocks naming one section merge; a `.popsection` without a
    // push is rejected.
    let text = ".pushsection .a,\"a\"\n.long 1\n.popsection\n.pushsection .a,\"a\"\n.long 2\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    assert_eq!(sink.len(), 1);
    assert_eq!(sink.section(0).bytes.len(), 8);
    assert!(
        extract_asm_sections(".pushsection .a,\"a\"\n.popsection\n.popsection", false).is_err()
    );
    // No section directives: the fast path returns None.
    assert!(extract_asm_sections("nop", false).unwrap().is_none());
}

#[test]
fn align_convention_per_arch() {
    // `.align`'s operand is an exponent on AArch64 and a byte count on
    // x86, so `.align 3` is 8 bytes on the one and rejected as a
    // non-power-of-two count on the other, and `.align 8` the reverse.
    let sec_align = |spec: &str, aarch64: bool| -> Result<u32, alloc::string::String> {
        let text = alloc::format!(".pushsection .t,\"a\"\n.align {spec}\n.byte 1\n.popsection");
        let AsmExtract { blocks, .. } =
            extract_asm_sections(&text, aarch64)?.expect("section directives");
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &AsmOperandResolver::NONE,
            &|_| None,
            &|_| None,
            aarch64,
            &mut sink,
        )?;
        Ok(sink.section(0).align)
    };
    assert_eq!(sec_align("3", true).unwrap(), 8);
    assert!(sec_align("3", false).is_err());
    assert_eq!(sec_align("8", false).unwrap(), 8);
    assert_eq!(sec_align("8", true).unwrap(), 256);
}

#[test]
fn section_labels_become_offsets() {
    // A label records its offset in the section; `.globl` sets external
    // binding whether it precedes or follows the definition, and a
    // quoted section name is unquoted.
    let text = ".section \".export\",\"a\"\n                    first:\n                    .asciz \"GPL\"\n                    .balign 8\n                    .globl second\n                    second: .quad 0\n                    .globl nowhere\n                    .previous\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    assert_eq!(blocks[0].name, ".export");
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let s = sink.section(0);
    assert_eq!(s.bytes.len(), 16);
    assert_eq!(
        s.labels,
        alloc::vec![
            AsmSectionLabel {
                name: alloc::string::String::from("first"),
                offset: 0,
                global: false,
                weak: false,
                sym_type: AsmSymType::NoType,
                size: None,
                absolute: None,
            },
            AsmSectionLabel {
                name: alloc::string::String::from("second"),
                offset: 8,
                global: true,
                weak: false,
                sym_type: AsmSymType::NoType,
                size: None,
                absolute: None,
            },
        ],
        "a `.globl` naming no label here defines no symbol",
    );
}

#[test]
fn section_type_and_size_set_symbol_attributes() {
    // The static-call trampoline shape: `.type name, @function` sets the
    // label's ELF type, `.size name, . - name` its byte extent (the
    // distance from the label to the directive). gas emits STT_FUNC with
    // st_size = 8 for this body.
    let text = ".pushsection .static_call.text, \"ax\"\n\
                .globl tramp\n\
                tramp:\n\
                .byte 0xe9, 0x11, 0x22, 0x33, 0x44\n\
                .byte 0x0f, 0xb9, 0xcc\n\
                .type tramp, @function\n\
                .size tramp, . - tramp\n\
                .popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let l = &sink.section(0).labels[0];
    assert_eq!(l.name, "tramp");
    assert!(l.global);
    assert_eq!(l.sym_type, AsmSymType::Func);
    assert_eq!(l.size, Some(8));
}

#[test]
fn section_type_object_and_bad_forms_rejected() {
    let materialize = |text: &str| {
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
        materialize_asm_sections(
            &blocks,
            &AsmOperandResolver::NONE,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .map(|_| sink)
    };
    // `@object` is accepted and sets STT_OBJECT.
    let sink = materialize(
        ".pushsection .d,\"a\"\nv:\n.quad 0\n.type v, @object\n.size v, . - v\n.popsection\n",
    )
    .unwrap();
    assert_eq!(sink.section(0).labels[0].sym_type, AsmSymType::Object);
    assert_eq!(sink.section(0).labels[0].size, Some(8));
    // An unknown type name is rejected at parse rather than mis-typed.
    let err = extract_asm_sections(
        ".pushsection .t,\"a\"\nv:\n.type v, @weird\n.popsection\n",
        false,
    )
    .expect_err("unknown .type must be rejected");
    assert!(err.contains("unsupported `.type`"), "{err}");
    // `.type` / `.size` on a symbol not defined in the section is rejected.
    let err = materialize(".pushsection .t,\"a\"\n.type ext, @function\n.popsection\n")
        .expect_err("`.type` on an undefined label must be rejected");
    assert!(err.contains("undefined label"), "{err}");
}

#[test]
fn duplicate_section_label_is_rejected() {
    let text = ".pushsection .t,\"a\"\ndup:\n.quad 0\ndup:\n.popsection\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    let mut sink = AsmSectionSink::default();
    let err = materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .expect_err("duplicate label must be rejected");
    assert!(err.contains("duplicate label"), "{err}");
}

#[test]
fn tab_separated_directives_and_trailing_whitespace() {
    // Preprocessed templates separate the directive from its arguments
    // with tabs and leave trailing whitespace after a label.
    let text = ".section\t\".initcall7.init\", \"a\"\t\t\n                    __initcall_probe7:\t\t\t\n                    .long\tprobe - .\t\n                    .previous\t\t\t\n";
    let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    assert_eq!(blocks[0].name, ".initcall7.init");
    assert_eq!(blocks[0].flags, "a");
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let s = sink.section(0);
    assert_eq!(s.bytes.len(), 4);
    assert_eq!(s.labels.len(), 1);
    assert_eq!(s.labels[0].name, "__initcall_probe7");
    assert_eq!(s.labels[0].offset, 0);
    assert!(!s.labels[0].global);
    assert_eq!(s.relocs.len(), 1, "the pc-relative reference survives");
}

#[test]
fn gas_macro_sysreg_read_folds_to_inst_word() {
    // The read_sysreg_s construct: an `.irp`-generated `.L__gpr_num_*`
    // table, a local `mrs_s` macro, its invocation, and `.purgem`. `%0`
    // stands for the destination register x1.
    let text = concat!(
        "\t.irp\tnum,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n",
        "\t.equ\t.L__gpr_num_x\\num, \\num\n",
        "\t.equ\t.L__gpr_num_w\\num, \\num\n",
        "\t.endr\n",
        "\t.equ\t.L__gpr_num_xzr, 31\n",
        "\t.equ\t.L__gpr_num_wzr, 31\n",
        "\t.macro\tmrs_s, rt, sreg\n",
        "\t.inst (0xd5200000|(\\sreg)|(.L__gpr_num_\\rt))\n",
        "\t.endm\n",
        "\tmrs_s %0, (((3) << 19) | ((0) << 16) | ((0) << 12) | ((0) << 8) | ((0) << 5))\n",
        "\t.purgem\tmrs_s\n",
    );
    let subst = |t: &str| (t == "%0").then(|| alloc::string::String::from("x1"));
    let out = expand_asm_gas_macros(text, 4, &subst).unwrap().unwrap();
    // sys_reg(3,0,0,0,0) is 0x180000, mrs base 0xd5200000, Rt=1: 0xd5380001.
    assert_eq!(
        out.trim(),
        alloc::format!("{INST_BYTES_DIRECTIVE} 0x01, 0x00, 0x38, 0xd5"),
        "{out}"
    );
}

/// A comma with no argument before it supplies an empty one, so the
/// arguments after it keep their positions; a parameter supplied empty
/// still takes its `=default`. Both are what GNU as binds -- the kernel's
/// SIMD macro layers pass empty arguments through several levels
/// (`__pmull_p8_tail \rq, ..., 8b,, sh1, ...`).
#[test]
fn gas_macro_empty_arguments_bind_like_gnu_as() {
    let expand = |invocation: &str, params: &str| {
        let text =
            alloc::format!(".macro m {params}\n.ascii \"[\\a][\\b][\\c]\"\n.endm\n{invocation}\n");
        expand_asm_gas_macros(&text, 4, &|_| None)
            .unwrap()
            .unwrap()
            .trim()
            .to_string()
    };
    for (invocation, want) in [
        ("m 1,,3", "[1][][3]"),
        ("m 1, , 3", "[1][][3]"),
        ("m 1 2 3", "[1][2][3]"),
        ("m 1,2,", "[1][2][]"),
        ("m ,2,3", "[][2][3]"),
    ] {
        assert_eq!(
            expand(invocation, "a, b, c"),
            alloc::format!(".ascii \"{want}\""),
            "{invocation}"
        );
    }
    for (invocation, want) in [
        ("m 1,,3", "[1][5][3]"),
        ("m 1", "[1][5][]"),
        ("m 1,,", "[1][5][]"),
    ] {
        assert_eq!(
            expand(invocation, "a, b=5, c"),
            alloc::format!(".ascii \"{want}\""),
            "{invocation}"
        );
    }
}

#[test]
fn gas_macro_expansions_are_independent_per_call() {
    // A second expansion redefines the macro and equates cleanly: the
    // per-call tables are what makes two read_sysreg_s in one unit work.
    let block = |sreg: &str, reg: &str| {
        let text = alloc::format!(
            concat!(
                "\t.irp\tnum,0,1,2\n",
                "\t.equ\t.L__gpr_num_x\\num, \\num\n",
                "\t.endr\n",
                "\t.macro\tmrs_s, rt, sreg\n",
                "\t.inst (0xd5200000|(\\sreg)|(.L__gpr_num_\\rt))\n",
                "\t.endm\n",
                "\tmrs_s %0, {sreg}\n",
                "\t.purgem\tmrs_s\n"
            ),
            sreg = sreg
        );
        let subst = move |t: &str| (t == "%0").then(|| alloc::string::String::from(reg));
        expand_asm_gas_macros(&text, 4, &subst)
            .unwrap()
            .unwrap()
            .trim()
            .to_string()
    };
    assert_eq!(
        block("(3 << 19)", "x1"),
        alloc::format!("{INST_BYTES_DIRECTIVE} 0x01, 0x00, 0x38, 0xd5")
    );
    assert_eq!(
        block("((3 << 19) | (4 << 8))", "x0"),
        alloc::format!("{INST_BYTES_DIRECTIVE} 0x00, 0x04, 0x38, 0xd5")
    );
}

#[test]
fn gas_macro_extable_short_resolves_register_field() {
    // The exception-table register field: a `.short` inside a section
    // whose value references the `.L__gpr_num_*` table with a `%w0`
    // operand. The operand substitutes to w2, then the table resolves it.
    let text = concat!(
        "\t.irp\tnum,0,1,2\n",
        "\t.equ\t.L__gpr_num_w\\num, \\num\n",
        "\t.endr\n",
        "\t.equ\t.L__gpr_num_wzr, 31\n",
        "\t.pushsection __ex_table, \"a\"\n",
        "\t.short (((.L__gpr_num_%w0) << 0) | ((.L__gpr_num_wzr) << 5))\n",
        "\t.popsection\n",
    );
    let subst = |t: &str| (t == "%w0").then(|| alloc::string::String::from("w2"));
    let out = expand_asm_gas_macros(text, 4, &subst).unwrap().unwrap();
    assert!(out.contains(".short (((2) << 0) | ((31) << 5))"), "{out}");
    assert!(out.contains(".pushsection __ex_table"), "{out}");
}

/// Every `_ASM_EXTABLE_*` carries its own copy of the `.L__gpr_num_*`
/// table, so two of them in one template assign each name twice with a
/// read in between. Both reads fold against the assignment in effect, so
/// neither assignment may survive as a directive: what is left of a
/// function-body template is an instruction stream, and no backend
/// encodes `.set` as an instruction.
#[test]
fn gas_macro_repeated_extable_leaves_no_assignment_in_the_stream() {
    let block = concat!(
        "\t.irp\tnum,0,1,2\n",
        "\t.equ\t.L__gpr_num_w\\num, \\num\n",
        "\t.endr\n",
        "\t.equ\t.L__gpr_num_wzr, 31\n",
        "\t.pushsection __ex_table, \"a\"\n",
        "\t.short (((.L__gpr_num_%w0) << 0) | ((.L__gpr_num_wzr) << 5))\n",
        "\t.popsection\n",
    );
    let subst = |t: &str| (t == "%w0").then(|| alloc::string::String::from("w2"));
    let out = expand_asm_gas_macros(&alloc::format!("{block}{block}"), 4, &subst)
        .unwrap()
        .unwrap();
    assert_eq!(
        out.matches(".short (((2) << 0) | ((31) << 5))").count(),
        2,
        "{out}"
    );
    assert!(!out.contains(".set"), "{out}");
    assert!(!out.contains(".equ"), "{out}");
}

/// A read with no assignment before it has nothing to fold against, so
/// the assignment stays for the section parse to define the name:
/// `arch/x86/boot/header.S` reads `textsize` in its PE header and
/// assigns it further down.
#[test]
fn gas_macro_keeps_an_assignment_an_earlier_statement_read() {
    let text = concat!(
        "\t.pushsection .pehdr, \"a\"\n",
        "\t.long textsize\n",
        "\t.popsection\n",
        "\t.set textsize, 0x1234\n",
    );
    let out = expand_asm_gas_macros(text, 4, &|_| None).unwrap().unwrap();
    assert!(out.contains(".long textsize"), "{out}");
    assert!(out.contains(".set textsize, 4660"), "{out}");
}

#[test]
fn gas_macro_malformed_forms_are_rejected() {
    let none = |_: &str| None;
    // No directives at all: not this pass's business.
    assert!(
        expand_asm_gas_macros("add x0, x0, x1\n", 4, &none)
            .unwrap()
            .is_none()
    );
    // `.purgem` of a macro that was never defined.
    assert!(
        expand_asm_gas_macros(".purgem foo\n", 4, &none)
            .unwrap_err()
            .contains("purgem")
    );
    // `.macro` with no closing `.endm`.
    assert!(
        expand_asm_gas_macros(".macro foo\nnop\n", 4, &none)
            .unwrap_err()
            .contains(".endm")
    );
    // A non-constant `.inst` value is rejected, never mis-encoded.
    assert!(
        expand_asm_gas_macros(".inst (0xd5200000 | undefined_sym)\n", 4, &none)
            .unwrap_err()
            .contains(".inst")
    );
}

#[test]
fn gas_macro_spaced_qualifiers_bind_like_gnu_as() {
    // GNU as scans a formal's `=` / `:` separator as its own token, so
    // whitespace may border either. Verified against `as`: `m1 x5` binds
    // `a`, `m2` takes the default x7 and `m2 x9` overrides it.
    let none = |_: &str| None;
    let text = ".macro m1, a : req\nadd x0, x0, \\a\n.endm\n\
                .macro m2, b = x7\nadd x1, x1, \\b\n.endm\n\
                m1 x5\nm2\nm2 x9\n";
    let out = expand_asm_gas_macros(text, 4, &none).unwrap().unwrap();
    let body: alloc::vec::Vec<&str> = out
        .lines()
        .map(str::trim)
        .filter(|l| !l.is_empty())
        .collect();
    assert_eq!(body, ["add x0, x0, x5", "add x1, x1, x7", "add x1, x1, x9"]);
    // A default is only bound when the invocation omits the argument, so a
    // spaced default never leaks into a supplied one.
    let text = ".macro m3, p = 64\n.if \\p == 32\nnop\n.else\nret\n.endif\n.endm\nm3\nm3 32\n";
    let out = expand_asm_gas_macros(text, 4, &none).unwrap().unwrap();
    assert!(out.contains("ret") && out.contains("nop"), "{out}");
}

/// `.ifdef` answers against the names defined so far, so the guard that
/// keeps one datum per variable across macro expansions sees the label
/// the first expansion placed. Measured against `as`: only the first
/// expansion emits the body, a definition further down the stream does
/// not count, and a declaration or a dead branch defines nothing.
#[test]
fn gas_ifdef_sees_definitions_like_gnu_as() {
    let none = |_: &str| None;
    let body = |text: &str| -> alloc::vec::Vec<alloc::string::String> {
        expand_asm_gas_macros(text, 4, &none)
            .unwrap()
            .unwrap()
            .lines()
            .map(|l| alloc::string::String::from(l.trim()))
            .filter(|l| !l.is_empty())
            .collect()
    };
    let text = ".macro rv var\n\
                .ifndef .L__d_\\var\n\
                .L__d_\\var:\n\
                .quad 0\n\
                .endif\n\
                .endm\n\
                rv a\nrv a\nrv b\n";
    assert_eq!(
        body(text),
        [".L__d_a:", ".quad 0", ".L__d_b:", ".quad 0"],
        "the guarded body assembles once per variable"
    );
    // A label, an assignment and a common block define; a `.globl`
    // declaration, a reference, a later definition and one in a dead
    // branch do not.
    for (t, want) in [
        ("foo:\n.ifdef foo\nnop\n.endif\n", true),
        (".set foo, 7\n.ifdef foo\nnop\n.endif\n", true),
        (".comm foo,4,4\n.ifdef foo\nnop\n.endif\n", true),
        (".globl foo\n.ifdef foo\nnop\n.endif\n", false),
        (".quad foo\n.ifdef foo\nnop\n.endif\n", false),
        (".ifdef foo\nnop\n.endif\nfoo:\n", false),
        (".if 0\nfoo:\n.endif\n.ifdef foo\nnop\n.endif\n", false),
    ] {
        assert_eq!(
            body(t).contains(&alloc::string::String::from("nop")),
            want,
            "{t}"
        );
    }
}

#[test]
fn altmacro_percent_arguments_evaluate_like_gnu_as() {
    // Under `.altmacro` a `%`-led argument is evaluated at the invocation
    // and bound as its decimal value. The kernel's SVE register loop drives
    // a recursive macro this way; assembled with `as`, the body below emits
    // `add x0, x0, #0` through `#7` in order.
    let none = |_: &str| None;
    let text = ".macro __for from:req, to:req\n\
                .if (\\from) == (\\to)\n\
                _for__body %\\from\n\
                .else\n\
                __for %\\from, %((\\from) + ((\\to) - (\\from)) / 2)\n\
                __for %((\\from) + ((\\to) - (\\from)) / 2 + 1), %\\to\n\
                .endif\n\
                .endm\n\
                .macro _for var:req, from:req, to:req, insn:vararg\n\
                .macro _for__body \\var:req\n\
                .noaltmacro\n\
                \\insn\n\
                .altmacro\n\
                .endm\n\
                .altmacro\n\
                __for \\from, \\to\n\
                .noaltmacro\n\
                .purgem _for__body\n\
                .endm\n\
                _for n, 0, 7, add x0, x0, #\\n\n";
    let out = expand_asm_gas_macros(text, 4, &none).unwrap().unwrap();
    let body: alloc::vec::Vec<&str> = out
        .lines()
        .map(str::trim)
        .filter(|l| !l.is_empty())
        .collect();
    assert_eq!(
        body,
        (0..8)
            .map(|n| alloc::format!("add x0, x0, #{n}"))
            .collect::<alloc::vec::Vec<_>>()
    );
    // Without `.altmacro` the `%` is not an evaluation marker.
    let text = ".macro m a\n.byte \\a\n.endm\nm %1+2\n";
    let out = expand_asm_gas_macros(text, 4, &none).unwrap().unwrap();
    assert!(out.contains("%1+2"), "{out}");
}

/// `name = expr` is the GNU as spelling of `.set`, so a unit that uses no
/// other directive still resolves its symbols. A value naming a register
/// is a register equate -- the binding `.req` makes -- and defines no
/// symbol; every later use of the name substitutes the register. `$name`
/// splits at the AT&T immediate sigil, while a `$` inside a name does not.
#[test]
fn gas_assignments_bind_constants_and_registers() {
    let expand = |text: &str| {
        expand_asm_gas_macros(text, 4, &|_| None)
            .unwrap()
            .expect("an assignment triggers the pass")
            .trim()
            .to_string()
    };
    assert_eq!(
        expand("_A = 8\n_B = _A + 8\nK = _B + 16\nsubq $K, %rsp\n"),
        "subq $32, %rsp"
    );
    assert_eq!(
        expand("IN_KEY = %rdx\nmovdqu 16(IN_KEY), %xmm1\n"),
        "movdqu 16(%rdx), %xmm1"
    );
    assert_eq!(expand("A = %rdx\nB = A\nmov (%r9), B\n"), "mov (%r9), %rdx");
    assert_eq!(
        expand(".set copy0, %xmm5\nmovdqa copy0, %xmm1\n"),
        "movdqa %xmm5, %xmm1"
    );
    // A `$` inside a name belongs to it; `x$y` is one token.
    assert_eq!(expand("x$y = 5\nmovl $x$y, %eax\n"), "movl $5, %eax");
    // An assignment naming a symbol is not an equate: it reaches the
    // section parser, which emits the object-level alias.
    assert_eq!(expand("alias = target\nnop\n"), ".set alias, target\nnop");
    // A comparison is not an assignment, so it triggers nothing.
    assert!(
        expand_asm_gas_macros("cmpl $1, %eax\nsete %al\n", 4, &|_| None)
            .unwrap()
            .is_none()
    );
}

fn rept(text: &str) -> Result<alloc::string::String, alloc::string::String> {
    Ok(expand_asm_gas_macros(text, 4, &|_| None)?.expect("`.rept` triggers the pass"))
}

/// GNU as spells the repeat directive `.rept` or `.rep`, and iterates the
/// characters of an operand with `.irpc`. Bytes measured with GNU as
/// 2.46.1: `.rep 3 / .byte 0xaa / .endr` deposits `aa aa aa`;
/// `.irpc l, 0123 / .byte \l / .endr` deposits `00 01 02 03`; an empty
/// `.irpc` operand still expands the body once.
#[test]
fn rep_and_irpc_match_gnu_as() {
    assert_eq!(
        rept(".rep 3\n.byte 0xaa\n.endr\n")
            .unwrap()
            .matches(".byte 0xaa")
            .count(),
        3
    );
    let out = rept(".irpc l, 0123\n.byte \\l\n.endr\n").unwrap();
    assert_eq!(out, ".byte 0\n.byte 1\n.byte 2\n.byte 3\n", "{out}");
    let out = rept(".irpc c, ab\n.ascii \"[\\c]\"\n.endr\n").unwrap();
    assert_eq!(out, ".ascii \"[a]\"\n.ascii \"[b]\"\n", "{out}");
    assert_eq!(
        rept(".irpc n,\n.byte 0xff\n.endr\n").unwrap(),
        ".byte 0xff\n"
    );
    // The dead branch of a conditional consumes both spellings' bodies,
    // so neither `.endr` leaks.
    assert_eq!(
        rept(".if 0\n.rep 2\nnop\n.endr\n.endif\nret\n").unwrap(),
        "ret\n"
    );
    assert_eq!(
        rept(".if 0\n.irpc l,ab\nnop\n.endr\n.endif\nret\n").unwrap(),
        "ret\n"
    );
}

/// GNU as separates a macro invocation's arguments by commas or by
/// whitespace, and `%` is not one of the operators that keeps whitespace
/// from separating: measured, `m 1 % 2` binds three arguments and
/// `m %r8 %r9` binds two, while `m sym + 24` stays one.
#[test]
fn macro_arguments_split_on_whitespace_like_gnu_as() {
    let show = ".macro SHOW a b c\n.ascii \"[\\a][\\b][\\c]\"\n.endm\n";
    let go = |call: &str| rept(&alloc::format!("{show}{call}\n")).unwrap();
    assert_eq!(go("SHOW %r8 %r9"), ".ascii \"[%r8][%r9][]\"\n");
    assert_eq!(go("SHOW 1 % 2"), ".ascii \"[1][%][2]\"\n");
    assert_eq!(go("SHOW p q, r"), ".ascii \"[p][q][r]\"\n");
    assert_eq!(go("SHOW sym + 24"), ".ascii \"[sym + 24][][]\"\n");
    // A character constant is one argument, separators included, and
    // binds as its value: `SHOW 'r', ' ', ':'` measures `[114][32][58]`.
    assert_eq!(go("SHOW 'r', ' ', ':'"), ".ascii \"[114][32][58]\"\n");
}

/// A `.set` folds into the expander's symbol table, which substitutes it
/// into what follows. A statement that referenced the name earlier is
/// already past, so the assignment stays in the stream for the section
/// layer to define -- `arch/x86/boot/header.S` reads `textsize` in its PE
/// header and assigns it further down.
#[test]
fn a_set_referenced_before_its_assignment_stays_in_the_stream() {
    let out = rept(".long textsize\n.set textsize, 0x1234\n.long textsize\n").unwrap();
    assert_eq!(
        out, ".long textsize\n.set textsize, 4660\n.long 4660\n",
        "{out}"
    );
    // One referenced only after its assignment still folds away.
    assert_eq!(
        rept(".set only_after, 7\n.long only_after\n").unwrap(),
        ".long 7\n"
    );
}

/// A macro body is re-scanned after substitution, so a `;` that arrives
/// through an argument separates statements -- the x86 ALTERNATIVE macros
/// pass a whole instruction sequence as one argument, and the macros it
/// names have to be recognized inside it. GNU as also ends a macro name
/// at the first character that cannot be part of one, so the C-macro
/// invocation spelling works.
#[test]
fn macro_expansion_rescans_substituted_statements() {
    let defs = ".macro INNER t\n.byte \\t\n.endm\n.macro OUTER body\n\\body\n.endm\n";
    assert_eq!(
        rept(&alloc::format!("{defs}OUTER \"nop; INNER t=2; ret\"\n")).unwrap(),
        "nop\n.byte 2\nret\n"
    );
    assert_eq!(
        rept(&alloc::format!("{defs}INNER(7)\n")).unwrap(),
        ".byte (7)\n"
    );
}

#[test]
fn rept_expands_repeats_and_rejects_malformed() {
    // No `.rept` and no other macro directive: not this pass's business.
    assert!(
        expand_asm_gas_macros("nop\nret\n", 4, &|_| None)
            .unwrap()
            .is_none()
    );
    // `.rept 3` repeats the body three times (the ALTERNATIVE nop
    // padding); `.rept 0` drops it; nested counts multiply.
    let out = rept("swpb w0, w1, [x2]\n.rept 3\nnop\n.endr\n").unwrap();
    assert_eq!(out.matches("nop").count(), 3, "{out}");
    assert!(out.contains("swpb"));
    assert_eq!(
        rept(".rept 0\nnop\n.endr\n")
            .unwrap()
            .matches("nop")
            .count(),
        0
    );
    assert_eq!(
        rept(".rept 2\n.rept 3\nnop\n.endr\n.endr\n")
            .unwrap()
            .matches("nop")
            .count(),
        6
    );
    // A count over labels defers to the section layer, which knows the
    // offsets; the body expands once inside the kept `.rept`.
    assert_eq!(
        rept(".rept 2b-1b\nnop\n.endr\n").unwrap(),
        ".rept 2b-1b\nnop\n.endr\n"
    );
    // A stray `.endr` and an unclosed `.rept` are errors rather than a
    // mis-counted expansion.
    assert!(
        rept("nop\n.rept 2\nnop\n.endr\n.endr\n")
            .unwrap_err()
            .contains(".endr")
    );
    assert!(rept(".rept 2\nnop\n").unwrap_err().contains(".endr"));
}

#[test]
fn rept_nests_with_macros_and_irp() {
    // A `.rept` in a macro body expands on invocation, with the count
    // bound from the macro argument.
    let out = rept(".macro nops, num\n.rept \\num\nnop\n.endr\n.endm\nnops 3\n").unwrap();
    assert_eq!(out.matches("nop").count(), 3, "{out}");
    // `.endr` closes the whole repeat family, so the two spellings nest
    // through each other.
    let out = rept(".irp r,1,2\n.rept 2\nnop\n.endr\n.endr\n").unwrap();
    assert_eq!(out.matches("nop").count(), 4, "{out}");
    let out = rept(".rept 2\n.irp r,1,2,3\nnop\n.endr\n.endr\n").unwrap();
    assert_eq!(out.matches("nop").count(), 6, "{out}");
    // The count is an expression over the `.set` table, as in GNU as.
    let out = rept(".set n, 2\n.rept n + 1\nnop\n.endr\n").unwrap();
    assert_eq!(out.matches("nop").count(), 3, "{out}");
    // A `.rept` in a dead conditional branch consumes its body.
    let out = rept(".if 0\n.rept 2\nnop\n.endr\n.endif\nret\n").unwrap();
    assert_eq!(out.matches("nop").count(), 0, "{out}");
    assert!(out.contains("ret"));
}

#[test]
fn type_directive_accepts_the_gas_spellings() {
    let ty = |rest: &str| parse_type_directive(rest);
    for rest in [
        "f,STT_FUNC",
        "f, STT_FUNC",
        "f STT_FUNC",
        "f @function",
        "f %function",
        "f #function",
        "f function",
        "f \"function\"",
    ] {
        assert_eq!(
            ty(rest).unwrap(),
            AsmSectionItem::Type {
                name: alloc::string::String::from("f"),
                sym_type: AsmSymType::Func,
            },
            "{rest}"
        );
    }
    assert!(matches!(
        ty("f STT_OBJECT").unwrap(),
        AsmSectionItem::Type {
            sym_type: AsmSymType::Object,
            ..
        }
    ));
    assert!(matches!(
        ty("f, @notype").unwrap(),
        AsmSectionItem::Type {
            sym_type: AsmSymType::NoType,
            ..
        }
    ));
    assert!(ty("f STT_TLS").unwrap_err().contains("unsupported"));
    assert!(ty("f").unwrap_err().contains("expects"));
}

/// The export-table shape modpost generates: one file-scope template
/// per exported symbol, pushing a section every symbol shares and a
/// section named after the symbol.
fn export_table_templates(n: usize) -> alloc::vec::Vec<alloc::string::String> {
    (0..n)
        .map(|i| {
            alloc::format!(
                "\t.section \"__ksymtab_strings\",\"aMS\",%progbits,1\n\
                 __kstrtab_s{i}:\n\t.asciz \"s{i}\"\n\t.previous\n\
                 \t.section \"___ksymtab+s{i}\", \"a\"\n\t.balign 4\n\
                 __ksymtab_s{i}:\n\t.long s{i}- .\n\t.long __kstrtab_s{i}- .\n\
                 \t.previous\n"
            )
        })
        .collect()
}

/// A unit carries tens of thousands of export-table templates, so the
/// per-call lookups against the accumulated sink -- the section
/// identity, its name, the labels earlier templates defined and the
/// bindings they carry -- have to be indexed. What each lookup answers
/// is asserted here; that none of them walks the sink is
/// [`file_scope_asm_sink_walks_stay_linear`].
#[test]
fn file_scope_asm_sink_lookups_are_indexed() {
    const N: usize = 4000;
    let templates = export_table_templates(N);
    let mut sink = AsmSectionSink::default();
    materialize_file_asm(&templates, true, AsmComments::A64, &|_| Ok(()), &mut sink).unwrap();
    // One shared strings section plus one per symbol.
    assert_eq!(sink.len(), N + 1);
    let strs = sink
        .sections()
        .iter()
        .find(|s| s.name == "__ksymtab_strings")
        .expect("the shared strings section");
    assert_eq!(strs.labels.len(), N);
    // Each name is `s`, the index digits, and the `.asciz` terminator.
    assert_eq!(
        strs.bytes.len(),
        (0..N).map(|i| i.to_string().len() + 2).sum::<usize>()
    );
    // Each per-symbol section holds the two relative references, both
    // as relocations against the named symbol.
    let sec = sink
        .sections()
        .iter()
        .find(|s| s.name == "___ksymtab+s3999")
        .expect("the last symbol's section");
    assert_eq!(sec.bytes.len(), 8);
    assert_eq!(sec.labels.len(), 1);
    assert_eq!(sec.relocs.len(), 2);
}

/// The same shape at two sizes, measured in sections walked rather than
/// in time, so the result does not depend on the host. Materialization
/// resolves through the sink's indexes and walks nothing per statement;
/// the only walk here is the one an object writer makes of the finished
/// sink. A lookup that derives state over the whole sink per statement
/// squares this, which a content assertion cannot see.
#[test]
fn file_scope_asm_sink_walks_stay_linear() {
    const N: usize = 1000;
    let walks = |n: usize| -> u64 {
        let mut sink = AsmSectionSink::default();
        materialize_file_asm(
            &export_table_templates(n),
            true,
            AsmComments::A64,
            &|_| Ok(()),
            &mut sink,
        )
        .unwrap();
        let _ = sink.sections();
        sink.walked()
    };
    let (small, large) = (walks(N), walks(2 * N));
    assert!(
        small <= 4 * N as u64 && large <= 8 * N as u64,
        "sink walks: {small} over {N} statements, {large} over {}",
        2 * N
    );
    assert!(
        large <= 3 * small,
        "doubling the statements multiplied the walks by {}",
        large as f64 / small as f64
    );
}

/// A second definition of a name in a section an earlier template
/// pushed is a duplicate, which the sink's label index answers.
#[test]
fn duplicate_section_label_across_templates_is_rejected() {
    let text =
        alloc::string::String::from("\t.section \"t\",\"a\"\ndup:\n\t.quad 0\n\t.previous\n");
    let mut sink = AsmSectionSink::default();
    let mat = |sink: &mut AsmSectionSink| {
        materialize_file_asm(
            core::slice::from_ref(&text),
            true,
            AsmComments::A64,
            &|_| Ok(()),
            sink,
        )
    };
    mat(&mut sink).unwrap();
    let err = mat(&mut sink).expect_err("the name is already defined there");
    assert!(err.contains("duplicate label"), "{err}");
}

/// A bare section name is that section's start whichever template
/// pushed the section, so a difference to a label of it folds; the
/// sink's name index answers where the section came from.
#[test]
fn section_name_resolves_across_templates() {
    let templates = alloc::vec![
        alloc::string::String::from("\t.section \"t\",\"a\"\n\t.quad 0\nfirst:\n\t.previous\n"),
        alloc::string::String::from("\t.section \"u\",\"a\"\n\t.quad first - t\n\t.previous\n"),
    ];
    let mut sink = AsmSectionSink::default();
    materialize_file_asm(&templates, true, AsmComments::A64, &|_| Ok(()), &mut sink).unwrap();
    let u = sink
        .sections()
        .iter()
        .find(|s| s.name == "u")
        .expect("the second template's section");
    assert_eq!(u.bytes, 8u64.to_le_bytes(), "`first - t` is the offset");
    assert!(u.relocs.is_empty(), "an absolute value keeps no relocation");
}

/// A location expression resolves a label an earlier template defined,
/// and a snapshot restore drops the sections and the labels it created
/// so a later template does not resolve against undone work.
#[test]
fn sink_labels_span_templates_and_unwind() {
    let mat = |text: &str, sink: &mut AsmSectionSink| {
        materialize_file_asm(
            &[alloc::string::String::from(text)],
            true,
            AsmComments::A64,
            &|_| Ok(()),
            sink,
        )
    };
    let mut sink = AsmSectionSink::default();
    mat(
        "\t.section \"t\",\"a\"\nfirst:\n\t.long 0\n\t.long 0\n\t.previous\n",
        &mut sink,
    )
    .unwrap();
    // A difference to `first`, defined by the template above, folds:
    // the sink supplies its section and offset.
    mat(
        "\t.section \"t\",\"a\"\nsecond:\n\t.long 0\n\t.size second, second - first\n\t.previous\n",
        &mut sink,
    )
    .unwrap();
    let sized = |s: &AsmSectionSink, n: &str| {
        s.sections()
            .iter()
            .flat_map(|x| &x.labels)
            .find(|l| l.name == n)
            .and_then(|l| l.size)
    };
    assert_eq!(sized(&sink, "second"), Some(8));
    let snap = sink.snapshot();
    mat(
        "\t.section \"v\",\"a\"\nlater:\n\t.long 0\n\t.previous\n",
        &mut sink,
    )
    .unwrap();
    assert_eq!(sink.len(), 2);
    sink.restore(&snap);
    assert_eq!(sink.len(), 1);
    // `later` went with the section the restore dropped, so a difference
    // to it no longer folds. A rejected template leaves its bytes behind
    // for the caller to unwind, so take a snapshot over it.
    let before_err = sink.snapshot();
    assert!(
        mat(
            "\t.section \"t\",\"a\"\nthird:\n\t.long 0\n\t.size third, third - later\n\t.previous\n",
            &mut sink,
        )
        .is_err()
    );
    sink.restore(&before_err);
    // `first` survived the restore and still resolves.
    mat(
        "\t.section \"t\",\"a\"\nfourth:\n\t.long 0\n\t.size fourth, fourth - first\n\t.previous\n",
        &mut sink,
    )
    .unwrap();
    assert_eq!(sized(&sink, "fourth"), Some(12));
}

/// `.popsection` restores the `.previous` slot saved at the matching
/// `.pushsection`, so a push/pop pair leaves a later `.previous` where the
/// `.section` before the pair put it. The kernel's `xen-asm.S` switches to
/// `.init.text`, expands `UNWIND_HINT` there and returns with `.previous`
/// before `xen_iret:`. Every binding is GNU as 2.46.1's for the same
/// source, including the `.previous` with no change to return to, which it
/// ignores.
#[test]
fn popsection_restores_the_previous_slot_the_push_saved() {
    let text = "first:\n.previous\nstill:\n.section .a,\"a\"\ninit:\n.pushsection .b,\"a\"\n\
                in_b:\n.pushsection .c,\"a\"\nin_c:\n.popsection\nback_b:\n.previous\n\
                prev_from_b:\n.popsection\nback_a:\n.previous\nback_text:\n\
                .pushsection .d,\"a\"\n.byte 1\nbefore_pop:\n.popsection\nafter_pop:\n";
    let blocks = extract_file_scope_asm_sections(text, false).unwrap();
    for (label, section) in [
        ("first", ".text"),
        ("still", ".text"),
        ("init", ".a"),
        ("in_b", ".b"),
        ("in_c", ".c"),
        ("back_b", ".b"),
        ("prev_from_b", ".a"),
        ("back_a", ".a"),
        ("back_text", ".text"),
        ("before_pop", ".d"),
        ("after_pop", ".text"),
    ] {
        assert_eq!(block_of(&blocks, label), section, "{label}");
    }
}

/// The same pair in a function-body template returns to the code stream.
#[test]
fn previous_after_a_push_pop_pair_returns_to_the_code_stream() {
    let text = "nop\n.section .fixup,\"ax\"\n.pushsection .x,\"a\"\n.byte 0\n.popsection\n\
                .previous\nnop\n";
    let AsmExtract { code, blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
    assert_eq!(code, "nop\nnop\n");
    assert!(blocks.iter().all(|b| b.name == ".x" || b.items.is_empty()));
}

/// The `M` flag's entry size and the `o` flag's ordering section are part
/// of the section's identity and reach the materialized section. `M`
/// without an entry size is dropped, as GNU as drops it.
#[test]
fn section_arguments_carry_the_entry_size_and_the_link() {
    let text = ".pushsection .discard.annotate_insn,\"M\",@progbits,8\n.long 1\n.popsection\n\
                .section .rodata.str1.1,\"aMS\",@progbits,1\n.asciz \"x\"\n\
                .section .text.hot,\"axo\",@progbits,.text\n.byte 0\n\
                .section .nosize,\"aM\",@progbits\n.byte 0\n";
    let blocks = extract_file_scope_asm_sections(text, false).unwrap();
    let block = |n: &str| blocks.iter().find(|b| b.name == n).expect(n);
    let insn = block(".discard.annotate_insn");
    assert_eq!(
        (insn.flags.as_str(), insn.sh_type.as_deref(), insn.entsize, insn.link.as_deref()),
        ("M", Some("progbits"), 8, None)
    );
    let strings = block(".rodata.str1.1");
    assert_eq!((strings.flags.as_str(), strings.entsize), ("aMS", 1));
    let hot = block(".text.hot");
    assert_eq!((hot.flags.as_str(), hot.link.as_deref()), ("axo", Some(".text")));
    let nosize = block(".nosize");
    assert_eq!((nosize.flags.as_str(), nosize.entsize), ("a", 0));
    let mut sink = AsmSectionSink::default();
    materialize_asm_sections(
        &blocks,
        &AsmOperandResolver::NONE,
        &|_| None,
        &|_| None,
        false,
        &mut sink,
    )
    .unwrap();
    let section = |n: &str| sink.sections().iter().find(|s| s.name == n).expect(n);
    let insn = section(".discard.annotate_insn");
    assert_eq!((insn.flags.as_str(), insn.entsize), ("M", 8));
    assert_eq!(section(".text.hot").link.as_deref(), Some(".text"));
}
