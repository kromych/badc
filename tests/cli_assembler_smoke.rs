//! End-to-end tests for the assembler driver, exercised through the
//! actual badc binary.
//!
//! The surface follows gcc's: `.S` (and `.sx`) preprocess before
//! assembling and get `__ASSEMBLER__` predefined, `.s` is taken
//! verbatim, `-c -o` names the object, the `-M` family describes the
//! unit, and `-Wa,` / `-Xassembler` hand options to the assembler.
//! Expected object shape is GNU as 2.46.1's for the same source.

use std::path::{Path, PathBuf};
use std::process::Command;

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

/// The ELF target whose assembly syntax the host writes natively, so a
/// test source assembles without a cross-target dialect switch.
const TARGET: &str = if cfg!(target_arch = "aarch64") {
    "linux-aarch64"
} else {
    "linux-x64"
};

/// A trivial leaf function in the host ISA's GNU assembler syntax.
const LEAF: &str = if cfg!(target_arch = "aarch64") {
    "\t.text\n\t.globl leaf\n\t.type leaf, @function\nleaf:\n\tmov x0, #7\n\tret\n"
} else {
    "\t.text\n\t.globl leaf\n\t.type leaf, @function\nleaf:\n\tmovl $7, %eax\n\tret\n"
};

fn dir(name: &str) -> PathBuf {
    let mut d = std::env::temp_dir();
    d.push(format!("badc-asm-test-{name}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&d);
    std::fs::create_dir_all(&d).expect("create temp dir");
    d
}

fn write(dir: &Path, name: &str, body: &str) -> PathBuf {
    let p = dir.join(name);
    std::fs::write(&p, body).expect("write file");
    p
}

/// Run badc in `dir`, returning `(status ok, stdout + stderr)`.
fn run(dir: &Path, args: &[&str]) -> (bool, String) {
    let out = Command::new(badc())
        .args(args)
        .current_dir(dir)
        .output()
        .expect("spawn badc");
    let mut text = String::from_utf8_lossy(&out.stdout).into_owned();
    text.push_str(&String::from_utf8_lossy(&out.stderr));
    (out.status.success(), text)
}

fn run_ok(dir: &Path, args: &[&str]) -> String {
    let (ok, text) = run(dir, args);
    assert!(ok, "badc {args:?} failed: {text}");
    text
}

/// Section names of an ELF64 relocatable object, in header order.
fn section_names(bytes: &[u8]) -> Vec<String> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap()) as usize;
    let shoff = u64at(0x28);
    let shentsize = u16at(0x3a);
    let shnum = u16at(0x3c);
    let shstrndx = u16at(0x3e);
    let strtab_off = u64at(shoff + shstrndx * shentsize + 0x18);
    (0..shnum)
        .map(|i| {
            let name_off = strtab_off + u32at(shoff + i * shentsize);
            let end = bytes[name_off..].iter().position(|&b| b == 0).unwrap();
            String::from_utf8_lossy(&bytes[name_off..name_off + end]).into_owned()
        })
        .collect()
}

#[test]
fn dot_s_assembles_to_an_object() {
    let d = dir("dot-s");
    write(&d, "leaf.s", LEAF);
    run_ok(&d, &["-q", "-c", &format!("--target={TARGET}"), "leaf.s"]);
    let bytes = std::fs::read(d.join("leaf.o")).expect("object written next to the source");
    assert_eq!(&bytes[..4], b"\x7fELF");
    let names = section_names(&bytes);
    assert_eq!(
        names.iter().filter(|n| *n == ".text").count(),
        1,
        "assembled `.text` is not named exactly once: {names:?}"
    );
}

#[test]
fn dot_capital_s_preprocesses_and_predefines_assembler() {
    let d = dir("dot-cap-s");
    write(&d, "bump.h", "#define SEVEN 7\n");
    // `__ASSEMBLER__` gates the C-only half of a shared header, as the
    // kernel's do; only the assembly half may reach the assembler.
    write(
        &d,
        "leaf.S",
        &format!(
            "#include \"bump.h\"\n#ifndef __ASSEMBLER__\nthis is not assembly\n#endif\n{}",
            LEAF.replace("7", "SEVEN")
        ),
    );
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "-I",
            ".",
            "leaf.S",
            "-o",
            "leaf.o",
        ],
    );
    assert_eq!(&std::fs::read(d.join("leaf.o")).unwrap()[..4], b"\x7fELF");
}

#[test]
fn dot_s_is_not_preprocessed() {
    let d = dir("dot-s-verbatim");
    // A `.s` unit is assembled verbatim, so a `#` line is the x86
    // comment / AArch64 line marker it looks like, never a directive.
    write(&d, "leaf.s", &format!("#include \"nonexistent.h\"\n{LEAF}"));
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "leaf.s",
            "-o",
            "leaf.o",
        ],
    );
    assert_eq!(&std::fs::read(d.join("leaf.o")).unwrap()[..4], b"\x7fELF");
}

#[test]
fn assembly_units_write_dependency_rules() {
    let d = dir("deps");
    write(&d, "bump.h", "#define SEVEN 7\n");
    write(
        &d,
        "leaf.S",
        &format!("#include \"bump.h\"\n{}", LEAF.replace("7", "SEVEN")),
    );
    // The kbuild spelling: the rule keeps the source-derived name.
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "-I",
            ".",
            "-Wp,-MMD,leaf.d",
            "leaf.S",
            "-o",
            "leaf.o",
        ],
    );
    let dep = std::fs::read_to_string(d.join("leaf.d")).expect("depfile written");
    let (target, prereqs) = dep.split_once(':').expect("rule has a colon");
    assert_eq!(target.trim(), "leaf.o");
    let prereqs: Vec<&str> = prereqs.split_whitespace().filter(|t| *t != "\\").collect();
    assert_eq!(prereqs, ["leaf.S", "bump.h"]);
}

#[test]
fn a_dot_s_unit_answers_dash_mm_without_assembling() {
    let d = dir("dash-mm");
    write(&d, "bump.h", "#define SEVEN 7\n");
    write(
        &d,
        "leaf.S",
        &format!("#include \"bump.h\"\n{}", LEAF.replace("7", "SEVEN")),
    );
    let out = run_ok(
        &d,
        &["-MM", "-I", ".", &format!("--target={TARGET}"), "leaf.S"],
    );
    assert_eq!(out, "leaf.o: leaf.S bump.h\n");
    assert!(!d.join("leaf.o").exists(), "-MM must assemble nothing");
}

#[test]
fn an_unimplemented_construct_is_named_and_no_object_is_written() {
    let d = dir("diagnosed");
    write(&d, "bad.s", "\t.text\n\t.symver foo, foo@VERS_1\n\tnop\n");
    let (ok, text) = run(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "bad.s",
            "-o",
            "bad.o",
        ],
    );
    assert!(!ok, "an unimplemented directive must fail the unit: {text}");
    assert!(
        text.contains(".symver"),
        "the diagnostic must name the construct: {text}"
    );
    assert!(!d.join("bad.o").exists(), "no object on a failed unit");
}

/// `st_other` visibility of a symbol, or `None` when it is absent.
fn visibility(bytes: &[u8], want: &str) -> Option<u8> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64at(0x28) as usize;
    let (shentsize, shnum) = (u16at(0x3a), u16at(0x3c));
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        if u32at(sh + 4) != 2 {
            continue;
        }
        let off = u64at(sh + 0x18) as usize;
        let size = u64at(sh + 0x20) as usize;
        let stroff = u64at(shoff + u32at(sh + 0x28) * shentsize + 0x18) as usize;
        for e in (0..size).step_by(24) {
            let sym = off + e;
            let n = stroff + u32at(sym);
            let end = bytes[n..].iter().position(|&b| b == 0).unwrap();
            if &bytes[n..n + end] == want.as_bytes() {
                return Some(bytes[sym + 5] & 3);
            }
        }
    }
    None
}

/// `(name, binding, section index)` of every named symbol table entry.
fn sym_bindings(bytes: &[u8]) -> Vec<(String, u8, u16)> {
    sym_table(bytes)
        .into_iter()
        .filter(|s| !s.0.is_empty())
        .map(|(n, info, shndx, _, _)| (n, info >> 4, shndx))
        .collect()
}

/// `(name, st_info, st_shndx, st_value, st_size)` of every `.symtab` entry,
/// in table order.
fn sym_table(bytes: &[u8]) -> Vec<(String, u8, u16, u64, u64)> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64at(0x28) as usize;
    let (shentsize, shnum) = (u16at(0x3a), u16at(0x3c));
    let mut out = Vec::new();
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        if u32at(sh + 4) != 2 {
            continue;
        }
        let off = u64at(sh + 0x18) as usize;
        let size = u64at(sh + 0x20) as usize;
        let stroff = u64at(shoff + u32at(sh + 0x28) * shentsize + 0x18) as usize;
        for e in (0..size).step_by(24) {
            let sym = off + e;
            let n = stroff + u32at(sym);
            let end = bytes[n..].iter().position(|&b| b == 0).unwrap();
            let name = String::from_utf8(bytes[n..n + end].to_vec()).unwrap();
            out.push((
                name,
                bytes[sym + 4],
                u16at(sym + 6) as u16,
                u64at(sym + 8),
                u64at(sym + 16),
            ));
        }
    }
    out
}

/// A `.globl` naming a symbol the unit neither defines nor references still
/// gets an undefined global entry; a `.weak` in the same position gets no
/// entry at all. Both are GNU as 2.46.1's symbol table for the same source,
/// and `ld -r` carries the undefined global into the next link stage.
#[test]
fn an_unreferenced_globl_declaration_reaches_the_symbol_table() {
    const STB_GLOBAL: u8 = 1;
    let bytes = object_of(
        "globl-undef",
        "\t.globl before_section\n\t.weak weak_before\n\t.text\n\t.globl after_section\n\
         \t.weak weak_after\n\t.globl defined_sym\ndefined_sym:\n\tret\n",
    );
    let syms = sym_bindings(&bytes);
    let find = |n: &str| syms.iter().find(|s| s.0 == n).cloned();
    const SHN_UNDEF: u16 = 0;
    assert_eq!(
        find("before_section"),
        Some((String::from("before_section"), STB_GLOBAL, SHN_UNDEF)),
        "a `.globl` before any section directive",
    );
    assert_eq!(
        find("after_section"),
        Some((String::from("after_section"), STB_GLOBAL, SHN_UNDEF)),
        "a `.globl` inside a section",
    );
    assert!(find("defined_sym").is_some_and(|s| s.2 != SHN_UNDEF));
    assert_eq!(find("weak_before"), None, "an unreferenced `.weak`");
    assert_eq!(find("weak_after"), None, "an unreferenced `.weak`");
}

/// An immediate whose expression folds to a value already fixed where the
/// instruction sits takes the operand's `imm8` form, as GNU as 2.46.1 does;
/// the kernel's boot decompressor writes `subl $rva(1b), %ebp` this way. A
/// form with no `imm8` keeps the wide field, and so does a reference to a
/// label the instruction's own width would move -- there GNU as settles the
/// field before the layout, and the two widths give different values.
#[test]
fn a_folded_expression_immediate_takes_the_narrow_form() {
    let back = "\t.text\nstart:\n\tcall 1f\n1:\tpopq %rbp\n";
    let t = text_of(
        "imm-narrow",
        &format!(
            "{back}\tsubl $(1b - start), %ebp\n\tsubq $(1b - start), %rbp\n\
             \tsubw $(1b - start), %bp\n\timull $(1b - start), %ebp, %ebp\n\
             \tpushq $(1b - start)\n\taddl $(1b - start), (%rsp)\n"
        ),
    );
    assert_eq!(
        &t[6..],
        [
            0x83, 0xed, 0x05, // subl
            0x48, 0x83, 0xed, 0x05, // subq
            0x66, 0x83, 0xed, 0x05, // subw
            0x6b, 0xed, 0x05, // imull
            0x6a, 0x05, // pushq
            0x83, 0x04, 0x24, 0x05, // addl to memory
        ],
    );
    // `test` and `mov` have no imm8 form, so the wide field stands.
    let t = text_of(
        "imm-wide-form",
        &format!("{back}\ttestl $(1b - start), %ebp\n\tmovl $(1b - start), %ebp\n"),
    );
    assert_eq!(&t[6..], [0xf7, 0xc5, 0x05, 0, 0, 0, 0xbd, 0x05, 0, 0, 0]);
    // A forward reference keeps the wide field and its value, matching the
    // layout GNU as settles on.
    let t = text_of(
        "imm-forward",
        "\t.text\nlo:\n\tsubl $(hi - lo), %ebp\n\tnop\n\tnop\nhi:\n\tnop\n",
    );
    assert_eq!(&t[..6], [0x81, 0xed, 0x08, 0, 0, 0]);
}

/// `inc` / `dec` on a 16- or 32-bit register take the one-byte `0x40+rd` /
/// `0x48+rd` form outside 64-bit mode, where those opcodes are the REX
/// prefix instead. Every expectation is GNU as 2.46.1's encoding of the
/// same source; the kernel's `efi-mixed.S` carries the 32-bit form.
#[test]
fn one_byte_inc_and_dec_encode_outside_long_mode() {
    let t = text_of(
        "inc32",
        "\t.code32\n\tinc %ecx\n\tdec %ecx\n\tinc %cx\n\tinc %cl\n\tincl (%ecx)\n",
    );
    assert_eq!(t, [0x41, 0x49, 0x66, 0x41, 0xfe, 0xc1, 0xff, 0x01]);
    let t = text_of("inc16", "\t.code16\n\tinc %cx\n\tdec %cx\n\tinc %ecx\n");
    assert_eq!(t, [0x41, 0x49, 0x66, 0x41]);
    // In 64-bit mode the short form is a REX prefix, so the ModRM one stands.
    let t = text_of("inc64", "\t.code64\n\tinc %ecx\n\tdec %ecx\n\tinc %rcx\n");
    assert_eq!(t, [0xff, 0xc1, 0xff, 0xc9, 0x48, 0xff, 0xc1]);
}

#[test]
fn hidden_visibility_reaches_the_symbol_table() {
    // GNU as 2.46.1 on the same source: `_bss` and `_ebss` are
    // `GLOBAL HIDDEN UND`, and a defined `.hidden` symbol keeps its
    // definition with STV_HIDDEN. The kernel's boot decompressor marks its
    // linker-script symbols this way.
    let d = dir("hidden");
    write(
        &d,
        "vis.s",
        "\t.text\n\t.hidden _bss\n\t.hidden _ebss\n\t.globl vis\n\t.hidden vis\nvis:\n\
         \t.long _bss - .\n",
    );
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "vis.s",
            "-o",
            "vis.o",
        ],
    );
    let bytes = std::fs::read(d.join("vis.o")).unwrap();
    const STV_HIDDEN: u8 = 2;
    assert_eq!(visibility(&bytes, "vis"), Some(STV_HIDDEN));
    assert_eq!(visibility(&bytes, "_bss"), Some(STV_HIDDEN));
    // A `.hidden` name that surfaces nowhere else still gets an undefined
    // entry carrying the visibility, as GNU as emits one.
    assert_eq!(visibility(&bytes, "_ebss"), Some(STV_HIDDEN));
}

#[test]
fn reloc_directive_places_a_relocation_of_the_named_type() {
    // `.reloc offset, TYPE, expr` measures the offset from the section
    // start, not the location counter, and takes the addend literally.
    // GNU as 2.46.1 on this source emits, in `.rela.myrel`, PC32 at 0 with
    // addend 0x10, PC32 at 4 with 0x20, 32 at 8, and 64 at 12 with 1. The
    // arm64 hypervisor relocation table is built entirely out of this.
    let d = dir("reloc");
    let (kind32, kind64) = if cfg!(target_arch = "aarch64") {
        ("R_AARCH64_PREL32", "R_AARCH64_ABS64")
    } else {
        ("R_X86_64_PC32", "R_X86_64_64")
    };
    write(
        &d,
        "rel.s",
        &format!(
            "\t.section .myrel, \"a\"\n\t.globl tgt\n\t.word 0\n\
             \t.reloc 0, {kind32}, tgt + 0x10\n\t.word 0\n\
             \t.reloc 4, {kind32}, tgt + 0x20\n\t.quad 0\n\
             \t.reloc 8, {kind64}, tgt + 1\n"
        ),
    );
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "rel.s",
            "-o",
            "rel.o",
        ],
    );
    let bytes = std::fs::read(d.join("rel.o")).unwrap();
    let want32 = if cfg!(target_arch = "aarch64") {
        261
    } else {
        2
    };
    let want64 = if cfg!(target_arch = "aarch64") {
        257
    } else {
        1
    };
    assert_eq!(
        relocs(&bytes, ".rela.myrel"),
        [(0, want32, 0x10), (4, want32, 0x20), (8, want64, 1)]
    );
}

/// `(offset, type, addend)` of every entry of a named RELA section.
fn relocs(bytes: &[u8], want: &str) -> Vec<(u64, u32, i64)> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64at(0x28) as usize;
    let (shentsize, shnum, shstrndx) = (u16at(0x3a), u16at(0x3c), u16at(0x3e));
    let names = u64at(shoff + shstrndx * shentsize + 0x18) as usize;
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        let n = names + u32at(sh);
        let end = bytes[n..].iter().position(|&b| b == 0).unwrap();
        if &bytes[n..n + end] != want.as_bytes() {
            continue;
        }
        let off = u64at(sh + 0x18) as usize;
        let size = u64at(sh + 0x20) as usize;
        return (0..size)
            .step_by(24)
            .map(|e| {
                let r = off + e;
                (
                    u64at(r),
                    (u64at(r + 8) & 0xffff_ffff) as u32,
                    u64at(r + 16) as i64,
                )
            })
            .collect();
    }
    Vec::new()
}

#[test]
fn a_constant_assignment_with_external_linkage_becomes_an_absolute_symbol() {
    // GNU as puts `sym = <constant>` in the symbol table as SHN_ABS. The
    // kernel's generated `piggy.S` defines its payload lengths that way
    // and C code reads them, so the symbol has to survive the fold.
    let d = dir("abs-sym");
    write(
        &d,
        "lens.s",
        "\t.section .rodata\n\t.globl z_len\nz_len = 12345\n\t.globl blob\nblob:\n\t.long 1\n",
    );
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "lens.s",
            "-o",
            "lens.o",
        ],
    );
    let bytes = std::fs::read(d.join("lens.o")).unwrap();
    // SHN_ABS (0xfff1) with the assigned value, GLOBAL-bound.
    assert!(
        symbol(&bytes, "z_len") == Some((0xfff1, 12345)),
        "z_len must be an absolute symbol: {:?}",
        symbol(&bytes, "z_len")
    );
}

/// Contents of a named section, empty when the object has none.
fn section_data(bytes: &[u8], want: &str) -> Vec<u8> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap()) as usize;
    let shoff = u64at(0x28);
    let (shentsize, shnum, shstrndx) = (u16at(0x3a), u16at(0x3c), u16at(0x3e));
    let names = u64at(shoff + shstrndx * shentsize + 0x18);
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        let n = names + u32at(sh);
        let end = bytes[n..].iter().position(|&b| b == 0).unwrap();
        if &bytes[n..n + end] == want.as_bytes() {
            let off = u64at(sh + 0x18);
            return bytes[off..off + u64at(sh + 0x20)].to_vec();
        }
    }
    Vec::new()
}

/// The exception-table macros of `asm/asm-extable.h` each paste their own
/// copy of the `.L__gpr_num_*` table from `asm/gpr-num.h`, so a template
/// with two entries assigns every name twice with a read in between. Both
/// reads fold against the assignment in effect, so neither assignment may
/// reach the code stream: what is left of a function-body template is an
/// instruction stream, and no backend encodes `.set` as an instruction.
/// Each named it in its own words before -- aarch64 as a symbol operand
/// needing a relocation, x86_64 as an unsupported instruction -- so both
/// targets are checked here.
///
/// The section is GNU as 2.46.1's for the same source: two PC-relative
/// `.long`s per entry, then the type and data shorts as `02 00 ff 03`
/// (`EX_TYPE_UACCESS_ERR_ZERO`, and 31 in both 5-bit register fields).
#[test]
fn a_reassigned_gpr_number_table_leaves_the_exception_table_encodable() {
    const HEAD: &str = r#"
#define GPRNUMS \
"	.irp	num,0,1,2,3\n" \
"	.equ	.L__gpr_num_w\\num, \\num\n" \
"	.endr\n" \
"	.equ	.L__gpr_num_wzr, 31\n"

#define EXTAB(insn, fixup) \
	GPRNUMS \
	".pushsection	__ex_table, \"a\"\n" \
	".align		2\n" \
	".long		((" insn ") - .)\n" \
	".long		((" fixup ") - .)\n" \
	".short		(2)\n" \
	".short		(((.L__gpr_num_wzr) << 0) | ((.L__gpr_num_wzr) << 5))\n" \
	".popsection\n"

int f(unsigned *p)
{
	int ret = 0;
	asm volatile(
"#;
    // `1b` faults, `2b` faults, both are fixed up at `3f`.
    const A64_BODY: &str = r#""1:	ldxr	w0, [%[p]]\n"
"	cbz	w0, 3f\n"
"2:	stlxr	w1, w0, [%[p]]\n"
"3:\n"
	EXTAB("1b", "3b")
	EXTAB("2b", "3b")
	: "+r" (ret) : [p] "r" (p) : "memory", "w0", "w1");
	return ret;
}
"#;
    const X64_BODY: &str = r#""1:	movl	(%[p]), %%eax\n"
"	testl	%%eax, %%eax\n"
"	jz	3f\n"
"2:	movl	%%eax, (%[p])\n"
"3:\n"
	EXTAB("1b", "3b")
	EXTAB("2b", "3b")
	: "+r" (ret) : [p] "r" (p) : "memory", "eax");
	return ret;
}
"#;
    // R_AARCH64_PREL32 / R_X86_64_PC32: the entry addresses the faulting
    // instruction and its fixup relative to its own slot.
    for (target, body, pcrel) in [
        ("linux-aarch64", A64_BODY, 261u32),
        ("linux-x64", X64_BODY, 2u32),
    ] {
        let d = dir(&format!("extable-{target}"));
        write(&d, "ex.c", &format!("{HEAD}{body}"));
        run_ok(
            &d,
            &[
                "-q",
                "-c",
                &format!("--target={target}"),
                "ex.c",
                "-o",
                "ex.o",
            ],
        );
        let bytes = std::fs::read(d.join("ex.o")).unwrap();
        assert_eq!(
            section_data(&bytes, "__ex_table"),
            [
                0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0xff, 3, //
                0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0xff, 3,
            ],
            "{target}"
        );
        let r = relocs(&bytes, ".rela__ex_table");
        assert_eq!(
            r.iter().map(|e| (e.0, e.1)).collect::<Vec<_>>(),
            [(0, pcrel), (4, pcrel), (12, pcrel), (16, pcrel)],
            "{target}"
        );
        // Both entries are fixed up at the same label, and each faulting
        // instruction precedes it.
        assert_eq!(r[1].2, r[3].2, "{target}");
        assert!(r[0].2 < r[2].2 && r[2].2 < r[1].2, "{target}: {r:?}");
    }
}

/// `.set name, .` assigns the location counter's value, not an alias to a
/// symbol spelled `.`: the name reads back as a label at that spot. GNU as
/// 2.46 fills the same values.
#[test]
fn a_set_to_the_location_counter_defines_a_label() {
    let b = object_of(
        "set-dot-label",
        "\t.text\na:\n\tnop\n\t.set here, .\n\tnop\nb:\n\tnop\n\
         \t.data\n\t.byte here - a\n\t.byte b - here\n\t.long here - a\n",
    );
    assert_eq!(section64(&b, ".data"), [1, 1, 1, 0, 0, 0]);
}

#[test]
fn assembler_options_are_checked_rather_than_passed_on() {
    let d = dir("wa");
    write(&d, "leaf.s", LEAF);
    // The options the kernel's assembly units carry. `-march=` is the
    // arm64 defconfig's, and refusing it failed the first unit of the
    // build -- an instruction-set ceiling selects nothing badc varies.
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "-Wa,--fatal-warnings",
            "-Wa,-mrelax-relocations=no",
            "-Wa,-march=armv8.5-a",
            "leaf.s",
            "-o",
            "leaf.o",
        ],
    );
    let (ok, text) = run(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "-Wa,--nonesuch",
            "leaf.s",
            "-o",
            "x.o",
        ],
    );
    assert!(!ok, "an unimplemented assembler option must be refused");
    assert!(
        text.contains("--nonesuch"),
        "the option must be named: {text}"
    );
    // `-Xassembler` is the same surface spelled separately.
    let (ok, _) = run(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "-Xassembler",
            "--fatal-warnings",
            "leaf.s",
            "-o",
            "leaf.o",
        ],
    );
    assert!(ok, "-Xassembler must accept what -Wa, accepts");
}

/// One ELF32 section as `(name, sh_type, sh_offset, sh_size, sh_info,
/// sh_entsize)`, in header order.
fn elf32_sections(b: &[u8]) -> Vec<(String, u32, usize, usize, u32, u32)> {
    let u16at = |o: usize| u16::from_le_bytes([b[o], b[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
    let shoff = u32at(0x20) as usize;
    let (shentsize, shnum, shstrndx) = (u16at(0x2e), u16at(0x30), u16at(0x32));
    let strtab = u32at(shoff + shstrndx * shentsize + 0x10) as usize;
    (0..shnum)
        .map(|i| {
            let sh = shoff + i * shentsize;
            let n = strtab + u32at(sh) as usize;
            let end = b[n..].iter().position(|&c| c == 0).unwrap();
            (
                String::from_utf8_lossy(&b[n..n + end]).into_owned(),
                u32at(sh + 4),
                u32at(sh + 0x10) as usize,
                u32at(sh + 0x14) as usize,
                u32at(sh + 0x1c),
                u32at(sh + 0x24),
            )
        })
        .collect()
}

/// `-m16` / `-m32` put an assembly unit's object out as ELFCLASS32 /
/// EM_386, the container `as --32` writes for either. Record widths,
/// `SHT_REL` shape, `R_386_*` numbering and the implicit addend are the
/// values GNU as 2.46.1 produces for the same source.
#[test]
fn m16_and_m32_write_an_i386_object() {
    const SRC: &str = concat!(
        "\t.code16\n\t.section .text,\"ax\"\n\t.globl entry\nentry:\n",
        "\tmovw $msg, %ax\n\tcalll far_fn\n\t.byte msg\n\t.word msg\n\t.long msg\n",
        "\t.section .data,\"aw\"\nptr:\t.long entry\n",
    );
    for flag in ["-m16", "-m32"] {
        let d = dir(&format!("i386{}", &flag[2..]));
        write(&d, "rm.s", SRC);
        run_ok(
            &d,
            &["-q", "-c", "--target=linux-x64", flag, "rm.s", "-o", "rm.o"],
        );
        let b = std::fs::read(d.join("rm.o")).expect("object");
        assert_eq!(b[4], 1, "{flag}: EI_CLASS must be ELFCLASS32");
        assert_eq!(
            u16::from_le_bytes([b[18], b[19]]),
            3,
            "{flag}: e_machine must be EM_386"
        );
        assert_eq!(
            u16::from_le_bytes([b[16], b[17]]),
            1,
            "e_type must be ET_REL"
        );
        assert_eq!(
            u16::from_le_bytes([b[40], b[41]]),
            52,
            "Elf32_Ehdr is 52 bytes"
        );
        assert_eq!(
            u16::from_le_bytes([b[46], b[47]]),
            40,
            "Elf32_Shdr is 40 bytes"
        );

        let secs = elf32_sections(&b);
        let symtab = secs.iter().find(|s| s.1 == 2).expect(".symtab");
        assert_eq!(symtab.5, 16, "Elf32_Sym is 16 bytes");
        // i386 uses SHT_REL: the table is named `.rel<section>`, its
        // entries are 8 bytes, and no `.rela*` is emitted.
        assert!(
            !secs.iter().any(|s| s.0.starts_with(".rela")),
            "{flag}: an i386 object carries no RELA table: {secs:?}"
        );
        let rel = secs
            .iter()
            .find(|s| s.0 == ".rel.text")
            .unwrap_or_else(|| panic!("{flag}: no .rel.text in {secs:?}"));
        assert_eq!(rel.1, 9, "sh_type must be SHT_REL");
        assert_eq!(rel.5, 8, "Elf32_Rel is 8 bytes");
        let text = secs
            .iter()
            .find(|s| s.0 == ".text" && s.3 != 0)
            .expect(".text");
        assert_eq!(
            rel.4,
            secs.iter().position(|s| std::ptr::eq(s, text)).unwrap() as u32
        );

        // R_386_16 / R_386_8 / R_386_32 for the symbol-width data
        // directives, R_386_PC32 for the far call.
        let types: Vec<(u32, u32)> = (0..rel.3 / 8)
            .map(|i| {
                let o = rel.2 + i * 8;
                let off = u32::from_le_bytes(b[o..o + 4].try_into().unwrap());
                let info = u32::from_le_bytes(b[o + 4..o + 8].try_into().unwrap());
                (off, info & 0xff)
            })
            .collect();
        assert_eq!(
            types.iter().map(|&(_, t)| t).collect::<Vec<_>>(),
            [20, 2, 22, 20, 1],
            "{flag}: R_386_16, R_386_PC32, R_386_8, R_386_16, R_386_32: {types:?}"
        );
        // SHT_REL has no addend field, so the `calll`'s -4 rides in the
        // relocated field, as gas writes it.
        let (pc32_off, _) = types[1];
        let field = &b[text.2 + pc32_off as usize..text.2 + pc32_off as usize + 4];
        assert_eq!(field, (-4i32).to_le_bytes(), "{flag}: implicit addend");
    }
}

/// The assembler starts in 32-bit mode under `-m16` / `-m32`, the way
/// `as --32` does; `.code16` in the source moves it from there. Bytes
/// are GNU as 2.46.1's.
#[test]
fn m32_starts_the_encoder_in_32_bit_mode() {
    let d = dir("m32-mode");
    write(
        &d,
        "m.s",
        "\tmovl $7, %eax\n\tpushl %eax\n\tpopl %eax\n\tret\n",
    );
    run_ok(
        &d,
        &["-q", "-c", "--target=linux-x64", "-m32", "m.s", "-o", "m.o"],
    );
    let b = std::fs::read(d.join("m.o")).expect("object");
    let secs = elf32_sections(&b);
    let t = secs
        .iter()
        .find(|s| s.0 == ".text" && s.3 != 0)
        .expect(".text");
    assert_eq!(
        &b[t.2..t.2 + t.3],
        [0xb8, 0x07, 0x00, 0x00, 0x00, 0x50, 0x58, 0xc3],
        "32-bit default operand size, no 0x66 prefixes"
    );
}

/// The direct far branch of real-mode mode-switch code, in the shapes
/// the kernel's `arch/x86/realmode` units write it. Bytes, `R_386_*`
/// numbering and the implicit addend are GNU as 2.46.1's for the same
/// source.
#[test]
fn direct_far_branches_assemble_to_an_i386_object() {
    const SRC: &str = concat!(
        "\t.code16\n\t.text\n",
        "\tljmpw $0xf000, $0xfff0\n",
        "\tljmpw $8, $2f\n",
        "2:\tljmpl $(1*8), $pa_startup_32\n",
        "\t.code32\n",
        "\tljmpl $(1*8), $pa_startup_32\n",
    );
    let d = dir("far-branch");
    write(&d, "f.s", SRC);
    run_ok(
        &d,
        &["-q", "-c", "--target=linux-x64", "-m16", "f.s", "-o", "f.o"],
    );
    let b = std::fs::read(d.join("f.o")).expect("object");
    let secs = elf32_sections(&b);
    let text = secs
        .iter()
        .find(|s| s.0 == ".text" && s.3 != 0)
        .expect(".text");
    assert_eq!(
        &b[text.2..text.2 + text.3],
        [
            0xea, 0xf0, 0xff, 0x00, 0xf0, // ljmpw $0xf000, $0xfff0
            0xea, 0x0a, 0x00, 0x08, 0x00, // ljmpw $8, $2f
            0x66, 0xea, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, // .code16 ljmpl $8, $sym
            0xea, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, // .code32 ljmpl $8, $sym
        ]
    );
    let rel = secs.iter().find(|s| s.0 == ".rel.text").expect(".rel.text");
    // R_386_16 over the same-section label's offset, R_386_32 over each
    // external one. SHT_REL has no addend field, so the label's own
    // offset rides in the field it patches.
    let rels: Vec<(u32, u32)> = (0..rel.3 / 8)
        .map(|i| {
            let o = rel.2 + i * 8;
            (
                u32::from_le_bytes(b[o..o + 4].try_into().unwrap()),
                u32::from_le_bytes(b[o + 4..o + 8].try_into().unwrap()) & 0xff,
            )
        })
        .collect();
    assert_eq!(rels, [(6, 20), (12, 1), (19, 1)], "R_386_16, R_386_32 x2");
}

/// A `.code16` branch to a label in the same section resolves at
/// assembly time, leaving no relocation, and takes the `rel8` form its
/// displacement fits, as GNU as does in every code-size mode.
#[test]
fn code16_same_section_branches_resolve_in_place() {
    let d = dir("code16-br");
    write(
        &d,
        "b.s",
        "\t.code16\nc:\tnop\n\tjmp c\n\tnop\n\tjmp f\n\tnop\nf:\tnop\n\tje c\n",
    );
    run_ok(
        &d,
        &["-q", "-c", "--target=linux-x64", "-m16", "b.s", "-o", "b.o"],
    );
    let b = std::fs::read(d.join("b.o")).expect("object");
    let secs = elf32_sections(&b);
    assert!(
        !secs.iter().any(|s| s.0.starts_with(".rel")),
        "a same-section branch needs no relocation: {secs:?}"
    );
    let t = secs
        .iter()
        .find(|s| s.0 == ".text" && s.3 != 0)
        .expect(".text");
    assert_eq!(
        &b[t.2..t.2 + t.3],
        [0x90, 0xeb, 0xfd, 0x90, 0xeb, 0x01, 0x90, 0x90, 0x74, 0xf6],
        "16-bit short-branch displacements"
    );
}

/// The same source relaxes to the same `rel8` bytes under `.code32` and
/// `.code64`: only the long form's displacement width varies by mode.
#[test]
fn code32_and_code64_short_branches_take_rel8() {
    let bytes = [0x90, 0xeb, 0xfd, 0x90, 0xeb, 0x01, 0x90, 0x90, 0x74, 0xf6];
    let body = "c:\tnop\n\tjmp c\n\tnop\n\tjmp f\n\tnop\nf:\tnop\n\tje c\n";
    let t = text_of("code32-br", &format!("\t.code32\n\t.text\n{body}"));
    assert_eq!(t, bytes);
    let t = text_of("code64-br", &format!("\t.text\n{body}"));
    assert_eq!(t, bytes);
}

/// `jcxz` / `jecxz` / `jrcxz` are one `E3 rel8` opcode; the counter the name
/// spells is the address size, so the name off the mode's default carries the
/// `67` prefix. Bytes are GNU as 2.46.1's for the same unit.
#[test]
fn e3_branches_take_the_address_size_prefix_by_mode() {
    const SRC: &str = concat!(
        "\t.code16\n",
        "a:\tjcxz a\n",  // e3 fe
        "b:\tjecxz b\n", // 67 e3 fd
        "\t.code32\n",
        "c:\tjecxz c\n", // e3 fe
        "d:\tjcxz d\n",  // 67 e3 fd
        "\t.code64\n",
        "e:\tjecxz e\n", // 67 e3 fd
        "f:\tjrcxz f\n", // e3 fe
    );
    assert_eq!(
        text_of("e3-branches", SRC),
        [
            0xe3, 0xfe, 0x67, 0xe3, 0xfd, 0xe3, 0xfe, 0x67, 0xe3, 0xfd, 0x67, 0xe3, 0xfd, 0xe3,
            0xfe
        ]
    );
    // A counter the mode cannot address is rejected, as GNU as rejects it.
    let d = dir("e3-reject");
    write(&d, "r.s", "x:\tjcxz x\n");
    let (ok, text) = run(&d, &["-q", "-c", "--target=linux-x64", "r.s", "-o", "r.o"]);
    assert!(!ok && text.contains("64-bit mode"), "{text}");
}

/// Opmask registers as first-class operands in a `.S` unit, where basic asm
/// reads `%kN` under a single `%` as a register (extended asm keeps GCC's
/// `%k<N>` operand-modifier meaning). Bytes are GNU as 2.46.1's, and llvm-mc
/// agrees on every instruction.
#[test]
fn opmask_operands_assemble_in_a_section_unit() {
    const SRC: &str = concat!(
        "\t.text\n\t.globl mask_unit\nmask_unit:\n",
        "\tkxnorw %k2, %k2, %k2\n",           // c5 ec 46 d2
        "\tkmovd %eax, %k1\n",                // c5 fb 92 c8
        "\tkmovw %k1, %ecx\n",                // c5 f8 93 c9
        "\tkshiftrw $8, %k1, %k2\n",          // c4 e3 f9 30 d1 08
        "\tkmovq %k3, (%rdi)\n",              // c4 e1 f8 91 1f
        "\tkmovb 1(%rsi), %k4\n",             // c5 f9 90 66 01
        "\tkandq %k1, %k2, %k3\n",            // c4 e1 ec 41 d9
        "\tktestw %k1, %k2\n",                // c5 f8 99 d1
        "\tvpcmpeqd %zmm1, %zmm2, %k3\n",     // 62 f1 6d 48 76 d9
        "\tvpcmpub $6, (%rdx), %zmm5, %k1\n", // 62 f3 55 48 3e 0a 06
        "\tvpmovm2b %k1, %zmm3\n",            // 62 f2 7e 48 28 d9
        "\tvmovdqu8 (%rsi), %zmm0{%k1}{z}\n", // 62 f1 7f c9 6f 06
        "\tret\n",
    );
    assert_eq!(
        text_of("opmask-unit", SRC),
        [
            0xc5, 0xec, 0x46, 0xd2, 0xc5, 0xfb, 0x92, 0xc8, 0xc5, 0xf8, 0x93, 0xc9, 0xc4, 0xe3,
            0xf9, 0x30, 0xd1, 0x08, 0xc4, 0xe1, 0xf8, 0x91, 0x1f, 0xc5, 0xf9, 0x90, 0x66, 0x01,
            0xc4, 0xe1, 0xec, 0x41, 0xd9, 0xc5, 0xf8, 0x99, 0xd1, 0x62, 0xf1, 0x6d, 0x48, 0x76,
            0xd9, 0x62, 0xf3, 0x55, 0x48, 0x3e, 0x0a, 0x06, 0x62, 0xf2, 0x7e, 0x48, 0x28, 0xd9,
            0x62, 0xf1, 0x7f, 0xc9, 0x6f, 0x06, 0xc3,
        ]
    );
}

/// Contents of `.text`, from an object of either ELF class.
fn text_bytes(b: &[u8]) -> Vec<u8> {
    if b[4] == 1 {
        let t = elf32_sections(b)
            .into_iter()
            .find(|s| s.0 == ".text")
            .expect(".text");
        return b[t.2..t.2 + t.3].to_vec();
    }
    let u16at = |o: usize| u16::from_le_bytes([b[o], b[o + 1]]) as usize;
    let u64at = |o: usize| u64::from_le_bytes(b[o..o + 8].try_into().unwrap()) as usize;
    let (shoff, shentsize) = (u64at(0x28), u16at(0x3a));
    let (off, size) = section_names(b)
        .iter()
        .position(|n| n == ".text")
        .map(|i| {
            let sh = shoff + i * shentsize;
            (u64at(sh + 0x18), u64at(sh + 0x20))
        })
        .expect(".text");
    b[off..off + size].to_vec()
}

/// A difference of two local numeric labels is an absolute value in every
/// operand position, in plain `.text` as much as inside a `.pushsection`:
/// the ALTERNATIVE idiom stores it as a length byte and reads it as an
/// instruction field. GNU as 2.46.1 emits these bytes for the same unit --
/// a backward difference takes the narrow field, a forward one keeps the
/// wide field the encoding chose.
#[test]
fn label_difference_operands_in_plain_text() {
    const SRC: &str = concat!(
        "\t.text\n\t.globl f\nf:\n",
        "661:\n\tnop\n\tnop\n662:\n",
        "\t.byte 662b-661b\n\t.short 662b-661b\n",
        "\t.long 662b-661b\n\t.quad 662b-661b\n",
        "\t.byte 664f-663f\n",
        "663:\n",
        "\tsubl $(662b - 661b), %ebp\n",
        "\tsubl $(664f - 663b), %ebp\n",
        "\tmovl (662b - 661b)(%rax), %ebx\n",
        "\tmovl (664f - 663b)(%rax), %ecx\n",
        "\tnop\n664:\n\tnop\n",
    );
    let d = dir("label-difference-text");
    write(&d, "ld.s", SRC);
    run_ok(
        &d,
        &["-q", "-c", "--target=linux-x64", "ld.s", "-o", "ld.o"],
    );
    let b = std::fs::read(d.join("ld.o")).expect("object");
    assert_eq!(
        text_bytes(&b),
        vec![
            0x90, 0x90, 0x02, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x13, 0x83, 0xed, 0x02, 0x81, 0xed, 0x13, 0x00, 0x00, 0x00, 0x8b,
            0x58, 0x02, 0x8b, 0x88, 0x13, 0x00, 0x00, 0x00, 0x90, 0x90,
        ]
    );
}

/// A constant operand expression encodes as the literal, so it reaches
/// every short form the encoder has, not only the one-field-narrower one:
/// `disp8` and `imm8` in one instruction, the dropped displacement byte of
/// a zero, and the `D1` shift-by-one opcode. Each expectation is GNU as
/// 2.46's encoding of the same source.
#[test]
fn a_folded_operand_expression_takes_every_short_form() {
    let t = text_of(
        "fold-imm-disp",
        "\t.text\na:\n\tnop\nb:\n\taddl $(b - a), (a - b)(%rdx)\n",
    );
    assert_eq!(t, [0x90, 0x83, 0x42, 0xff, 0x01], "disp8 and imm8 together");
    let t = text_of(
        "fold-disp0",
        "\t.text\na:\nb:\n\tmovl (a - b)(%rbx), %eax\n",
    );
    assert_eq!(t, [0x8b, 0x03], "a zero displacement drops its byte");
    let t = text_of(
        "fold-shift1",
        "\t.text\na:\n\tnop\nb:\n\tshll $(b - a), %ecx\n",
    );
    assert_eq!(t, [0x90, 0xd1, 0xe1], "shift by one takes the D1 form");
    let t = text_of("fold-dot-imm", "\t.text\na:\n\tnop\n\tpushq $(. - a)\n");
    assert_eq!(t, [0x90, 0x6a, 0x01], "`.` is the instruction's own start");
    let t = text_of(
        "fold-dot-disp",
        "\t.text\na:\n\tnop\n\tmovl (a - .)(%rbx), %eax\n",
    );
    assert_eq!(t, [0x90, 0x8b, 0x43, 0xff]);
}

/// GNU as fixes a non-branch field's width when it parses the instruction,
/// so a difference folds only over items whose sizes are already fixed
/// there. A branch that may still relax, an alignment, and an `.org`
/// between the labels keep the wide field even though the final layout
/// would fit the narrow one -- the value is still resolved in place. A
/// fixed-size span folds whatever it holds: data, a `call`, an instruction
/// whose own wide field waits for a relocation. Each expectation is GNU as
/// 2.46's encoding of the same source.
#[test]
fn an_operand_difference_narrows_only_over_a_parse_fixed_span() {
    let t = text_of(
        "fold-branch-span",
        "\t.text\na:\n\tnop\n\tjmp far\nb:\n\tmovl (a - b)(%rbx), %eax\n\
         \taddq $(b - a), %r8\nfar:\n\tnop\n",
    );
    assert_eq!(
        t,
        [
            0x90, 0xeb, 0x0d, 0x8b, 0x83, 0xfd, 0xff, 0xff, 0xff, 0x49, 0x81, 0xc0, 0x03, 0x00,
            0x00, 0x00, 0x90,
        ],
        "a span over a relaxable jmp keeps both wide fields"
    );
    let t = text_of(
        "fold-align-span",
        "\t.text\na:\n\tnop\n\t.balign 4\nb:\n\tpushq $(b - a)\n",
    );
    assert_eq!(&t[4..], [0x68, 0x04, 0x00, 0x00, 0x00], "span over .balign");
    let t = text_of(
        "fold-org-span",
        "\t.text\na:\n\tnop\n\t.org 4\nb:\n\tpushq $(b - a)\n",
    );
    assert_eq!(&t[4..], [0x68, 0x04, 0x00, 0x00, 0x00], "span over .org");
    let t = text_of(
        "fold-fill-span",
        "\t.text\na:\n\tnop\n\t.fill 3,1,0x90\nb:\n\tpushq $(b - a)\n\
         c:\n\tnop\n\t.skip 3\nd:\n\tpushq $(d - c)\n",
    );
    assert_eq!(&t[4..6], [0x6a, 0x04], "a constant .fill span folds");
    assert_eq!(&t[10..], [0x6a, 0x04], "a constant .skip span folds");
    let t = text_of(
        "fold-fixed-insns-span",
        "\t.text\na:\n\tnop\n\tcall x\n\taddl $x, %eax\nb:\n\tpushq $(b - a)\n",
    );
    assert_eq!(
        &t[11..],
        [0x6a, 0x0b],
        "calls and relocated fields are fixed"
    );
    let t = text_of(
        "fold-mul-expr",
        "\t.text\na:\n\tnop\n\tnop\nb:\n\tpushq $((b - a) * 8 - 6)\n",
    );
    assert_eq!(&t[2..], [0x6a, 0x0a], "arithmetic over a folded difference");
}

/// The fold reads names as the source defined them up to the instruction:
/// numeric labels by their latest definition, `.set` aliases through the
/// chain, a `.set` to the location counter as a label, and a weak or global
/// binding not at all -- a difference of two defined locations is a value
/// whatever their binding. A subsection is its own chain, so a difference
/// across two of them stays wide. Each expectation is GNU as 2.46's
/// encoding of the same source.
#[test]
fn an_operand_difference_resolves_names_as_the_parse_defined_them() {
    let t = text_of(
        "fold-numeric",
        "\t.text\n1:\n\tnop\n2:\n\tpushq $(2b - 1b)\n",
    );
    assert_eq!(t, [0x90, 0x6a, 0x01]);
    let t = text_of(
        "fold-set-alias",
        "\t.text\na:\n\tnop\n\t.set x, a\nb:\n\tpushq $(b - x)\n",
    );
    assert_eq!(t, [0x90, 0x6a, 0x01]);
    let t = text_of(
        "fold-set-dot",
        "\t.text\na:\n\tnop\n\t.set x, .\nb:\n\tnop\n\tpushq $(x - a)\n",
    );
    assert_eq!(t, [0x90, 0x90, 0x6a, 0x01], "`.set x, .` is a location");
    let t = text_of(
        "fold-weak-diff",
        "\t.text\n\t.weak b\na:\n\tnop\nb:\n\tpushq $(b - a)\n",
    );
    assert_eq!(t, [0x90, 0x6a, 0x01], "binding does not hold a difference");
    let t = text_of(
        "fold-subsec-cross",
        "\t.text\n\t.subsection 1\na:\n\tnop\n\t.subsection 0\nb:\n\tnop\n\tpushq $(b - a)\n",
    );
    assert_eq!(
        t,
        [0x90, 0x68, 0xfa, 0xff, 0xff, 0xff, 0x90],
        "a cross-subsection difference stays wide"
    );
}

/// gcc selects the preprocessor's predefines from the code model:
/// `-m16` and `-m32` are i386 units, so `__i386__` is defined and
/// `__x86_64__` is not. `-m16` is `-m32` code generation with a 16-bit
/// default operand size, and gcc gives the two the same predefines.
#[test]
fn m16_and_m32_preprocess_as_i386() {
    const SRC: &str = concat!(
        "\t.text\n",
        "#ifndef __x86_64__\n\t.byte 0x11\n#endif\n",
        "#ifdef __i386__\n\t.byte 0x22\n#endif\n",
        "#ifdef __x86_64__\n\t.byte 0x33\n#endif\n",
    );
    let d = dir("m16-predefines");
    write(&d, "pp.S", SRC);
    for (flag, want) in [
        ("-m16", &[0x11u8, 0x22][..]),
        ("-m32", &[0x11, 0x22][..]),
        ("-m64", &[0x33][..]),
    ] {
        let obj = format!("pp{}.o", &flag[2..]);
        run_ok(
            &d,
            &["-q", "-c", "--target=linux-x64", flag, "pp.S", "-o", &obj],
        );
        let b = std::fs::read(d.join(&obj)).expect("object");
        assert_eq!(text_bytes(&b), want, "{flag}: predefine set");
    }
}

/// The data-model predefines follow the code model as well: an i386
/// unit is ILP32, with a 32-bit pointer and `long` and no `__int128`.
/// Values are gcc 16.1.1's for `-m32 -dM -E -x assembler-with-cpp`.
#[test]
fn m32_predefines_the_ilp32_data_model() {
    const SRC: &str = concat!(
        "#define Q(x) #x\n#define S(x) Q(x)\n",
        "__SIZEOF_POINTER__ __SIZEOF_LONG__ __SIZEOF_SIZE_T__ __SIZEOF_PTRDIFF_T__\n",
        "S(__SIZE_TYPE__) S(__PTRDIFF_TYPE__)\n",
        "#if defined(__ILP32__) && defined(_ILP32) && !defined(__LP64__) && !defined(_LP64)\n",
        "ilp32-ok\n#endif\n",
        "#ifndef __SIZEOF_INT128__\nno-int128\n#endif\n",
        "#ifdef __GCC_ASM_FLAG_OUTPUTS__\ncc-outputs\n#endif\n",
        "wchar S(__WCHAR_TYPE__)\n",
        "#ifdef __code_model_32__\ncm32-ok\n#endif\n",
    );
    let d = dir("m32-data-model");
    write(&d, "dm.S", SRC);
    let out = run_ok(
        &d,
        &["-q", "-E", "--gnu", "--target=linux-x64", "-m32", "dm.S"],
    );
    let body: String = out.split_whitespace().collect::<Vec<_>>().join(" ");
    assert!(body.contains("4 4 4 4"), "ILP32 widths: {body}");
    assert!(
        body.contains(r#""unsigned int" "int""#),
        "ILP32 size_t / ptrdiff_t: {body}"
    );
    assert!(body.contains(r#"wchar "long int""#), "i386 wchar_t: {body}");
    for want in ["ilp32-ok", "no-int128", "cc-outputs", "cm32-ok"] {
        assert!(body.contains(want), "missing {want}: {body}");
    }
}

/// `-fshort-wchar` reaches the front end from the driver: the `wchar_t`
/// predefine pair narrows and a wide literal stages 16-bit elements, so
/// an `unsigned short` array takes one (C99 6.7.8p15) where the default
/// 4-byte `wchar_t` refuses it. `-fno-short-wchar` is the explicit
/// default, as in gcc 16.1.1, and leaves the already-16-bit Windows
/// targets alone. The kernel builds its whole tree this way and stages
/// `L"..."` into `efi_char16_t` arrays.
#[test]
fn short_wchar_narrows_wchar_t_from_the_driver() {
    const PP: &str = concat!(
        "#define Q(x) #x\n#define S(x) Q(x)\n",
        "wchar S(__WCHAR_TYPE__) __SIZEOF_WCHAR_T__\n",
    );
    let d = dir("short-wchar");
    write(&d, "pp.c", PP);
    for (target, flags, want) in [
        ("linux-x64", &[][..], r#"wchar "int" 4"#),
        ("linux-x64", &["-fno-short-wchar"][..], r#"wchar "int" 4"#),
        (
            "linux-x64",
            &["-fshort-wchar"][..],
            r#"wchar "unsigned short" 2"#,
        ),
        (
            "linux-aarch64",
            &["-fshort-wchar"][..],
            r#"wchar "unsigned short" 2"#,
        ),
        (
            "windows-x64",
            &["-fno-short-wchar"][..],
            r#"wchar "unsigned short" 2"#,
        ),
    ] {
        let tgt = format!("--target={target}");
        let mut args = vec!["-q", "-E", &tgt];
        args.extend_from_slice(flags);
        args.push("pp.c");
        let out = run_ok(&d, &args);
        let body: String = out.split_whitespace().collect::<Vec<_>>().join(" ");
        assert!(body.contains(want), "{target} {flags:?}: {body}");
    }
    // The staged bytes are UTF-16 code units, which is what makes the
    // 2-byte destination element legal.
    write(&d, "w.c", "unsigned short d[] = L\"ab\";\n");
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            "--target=linux-x64",
            "-fshort-wchar",
            "w.c",
            "-o",
            "w.o",
        ],
    );
    let b = std::fs::read(d.join("w.o")).expect("object");
    assert!(
        b.windows(6).any(|w| w == b"a\0b\0\0\0"),
        "wide literal must stage 16-bit elements"
    );
    let (ok, text) = run(
        &d,
        &["-q", "-c", "--target=linux-x64", "w.c", "-o", "wide.o"],
    );
    assert!(!ok, "a 4-byte wchar_t must refuse a 2-byte element: {text}");
    assert!(
        text.contains("wchar_t-width array element"),
        "diagnostic must name the element width: {text}"
    );
}

/// `-fsigned-char` / `-funsigned-char` reach the front end from the
/// driver and move `__CHAR_UNSIGNED__` with the type, so `<limits.h>`
/// and the compiler agree. Without either, the target ABI decides:
/// unsigned on AArch64 ELF, signed elsewhere, as gcc 16.1.1 and
/// clang 22.1.8 do on each. The kernel builds every unit
/// `-funsigned-char`.
#[test]
fn char_signedness_flags_reach_the_front_end() {
    const PP: &str = concat!(
        "#ifdef __CHAR_UNSIGNED__\n",
        "plain unsigned\n#else\nplain signed\n#endif\n",
    );
    let d = dir("char-signedness");
    write(&d, "pp.c", PP);
    for (target, flags, want) in [
        ("linux-x64", &[][..], "plain signed"),
        ("linux-aarch64", &[][..], "plain unsigned"),
        ("macos-aarch64", &[][..], "plain signed"),
        ("windows-x64", &[][..], "plain signed"),
        ("linux-x64", &["-funsigned-char"][..], "plain unsigned"),
        ("linux-x64", &["-fno-signed-char"][..], "plain unsigned"),
        ("linux-aarch64", &["-fsigned-char"][..], "plain signed"),
        ("linux-aarch64", &["-fno-unsigned-char"][..], "plain signed"),
        // The last selection wins, as it does in gcc.
        (
            "linux-x64",
            &["-funsigned-char", "-fsigned-char"][..],
            "plain signed",
        ),
    ] {
        let tgt = format!("--target={target}");
        let mut args = vec!["-q", "-E", &tgt];
        args.extend_from_slice(flags);
        args.push("pp.c");
        let out = run_ok(&d, &args);
        let body: String = out.split_whitespace().collect::<Vec<_>>().join(" ");
        assert!(body.contains(want), "{target} {flags:?}: {body}");
    }
    // `<limits.h>` keys CHAR_MIN on the predefine, so a unit compiled
    // with the flag sees the matching range rather than the ABI's.
    write(
        &d,
        "l.c",
        "#include <limits.h>\nint probe[CHAR_MIN < 0 ? -1 : 1];\n",
    );
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            "--target=linux-x64",
            "-funsigned-char",
            "l.c",
            "-o",
            "l.o",
        ],
    );
    let (ok, text) = run(&d, &["-q", "-c", "--target=linux-x64", "l.c", "-o", "ls.o"]);
    assert!(!ok, "the signed default must give CHAR_MIN < 0: {text}");
}

/// `-mcmodel` names the selected x86-64 model in a predefine and
/// `-m16` / `-m32` override the name to the 32-bit model; the aarch64
/// targets name none. Names are gcc 16.1.1's.
#[test]
fn the_code_model_macro_follows_mcmodel() {
    const SRC: &str = concat!(
        "#ifdef __code_model_32__\ncm-32\n#endif\n",
        "#ifdef __code_model_small__\ncm-small\n#endif\n",
        "#ifdef __code_model_kernel__\ncm-kernel\n#endif\n",
    );
    let d = dir("mcmodel-predefine");
    write(&d, "cm.S", SRC);
    let x64 = ["-q", "-E", "--target=linux-x64"];
    for (extra, want) in [
        (None, "cm-small"),
        (Some("-mcmodel=kernel"), "cm-kernel"),
        (Some("-m32"), "cm-32"),
        (Some("-m16"), "cm-32"),
    ] {
        let mut args = x64.to_vec();
        args.extend(extra);
        args.push("cm.S");
        let out = run_ok(&d, &args);
        for n in ["cm-32", "cm-small", "cm-kernel"] {
            assert_eq!(out.contains(n), n == want, "{extra:?}: {out}");
        }
    }
    let out = run_ok(&d, &["-q", "-E", "--target=linux-aarch64", "cm.S"]);
    assert!(
        !out.contains("cm-"),
        "aarch64 must name no code model: {out}"
    );
}

/// Which headers a unit opens depends on the predefine set, so the
/// preprocess-only modes take the code model too, as gcc does. Refusing
/// them would leave `-MM` describing a unit nobody builds.
#[test]
fn the_dependency_scan_follows_the_code_model() {
    let d = dir("m32-deps");
    write(&d, "i386.h", "");
    write(&d, "x64.h", "");
    write(
        &d,
        "dep.S",
        "#ifdef __i386__\n#include \"i386.h\"\n#else\n#include \"x64.h\"\n#endif\n\t.text\n",
    );
    for (flag, want) in [("-m32", "i386.h"), ("-m64", "x64.h")] {
        let out = run_ok(&d, &["-MM", "-I", ".", "--target=linux-x64", flag, "dep.S"]);
        assert_eq!(out, format!("dep.o: dep.S {want}\n"), "{flag}");
    }
}

/// `arch/x86/kernel/verify_cpu.S` guards its CPUID-presence probe with
/// `#ifndef __x86_64__`, and the realmode units that include it are
/// built `-m16`. Preprocessing that unit with `__x86_64__` defined drops
/// the probe, leaving a `cpuid` on a CPU never established to have one.
/// Bytes are GNU as 2.46.1's for the same source.
#[test]
fn m16_selects_the_realmode_cpuid_check() {
    const SRC: &str = concat!(
        "\t.code16\n\t.text\nverify_cpu:\n\tpushf\n\tpush\t$0\n\tpopf\n",
        "#ifndef __x86_64__\n",
        "\tpushfl\n\tpopl\t%eax\n\tmovl\t%eax,%ebx\n\txorl\t$0x200000,%eax\n",
        "\tpushl\t%eax\n\tpopfl\n\tpushfl\n\tpopl\t%eax\n\tcmpl\t%eax,%ebx\n",
        "#endif\n\tmovl\t$0x0,%eax\n\tcpuid\n",
    );
    // pushf; push $0; popf
    const PROLOGUE: &[u8] = &[0x9c, 0x6a, 0x00, 0x9d];
    // pushfl; popl %eax; movl %eax,%ebx; xorl $0x200000,%eax; pushl
    // %eax; popfl; pushfl; popl %eax; cmpl %eax,%ebx
    const CPUID_CHECK: &[u8] = &[
        0x66, 0x9c, 0x66, 0x58, 0x66, 0x89, 0xc3, 0x66, 0x35, 0x00, 0x00, 0x20, 0x00, 0x66, 0x50,
        0x66, 0x9d, 0x66, 0x9c, 0x66, 0x58, 0x66, 0x39, 0xc3,
    ];
    // movl $0x0,%eax; cpuid
    const LEAF0: &[u8] = &[0x66, 0xb8, 0x00, 0x00, 0x00, 0x00, 0x0f, 0xa2];
    let d = dir("m16-verify-cpu");
    write(&d, "vc.S", SRC);
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            "--target=linux-x64",
            "-m16",
            "vc.S",
            "-o",
            "vc.o",
        ],
    );
    let b = std::fs::read(d.join("vc.o")).expect("object");
    let mut want = PROLOGUE.to_vec();
    want.extend_from_slice(CPUID_CHECK);
    want.extend_from_slice(LEAF0);
    assert_eq!(text_bytes(&b), want, "the -m16 arm is the i386 one");
}

/// `-m16` / `-m32` name an x86 code model. gcc's AArch64 driver has no
/// such option, and badc has neither an AArch32 encoder nor an AArch32
/// predefine set, so the flag is refused rather than producing an
/// ELFCLASS32 AArch64 object.
#[test]
fn the_x86_code_models_are_refused_on_a_non_x86_target() {
    let d = dir("m32-aarch64");
    write(&d, "leaf.s", "\t.text\n\t.globl leaf\nleaf:\n\tret\n");
    for flag in ["-m16", "-m32"] {
        let (ok, text) = run(&d, &["-q", "-c", "--target=linux-aarch64", flag, "leaf.s"]);
        assert!(!ok, "{flag} must be refused on an AArch64 target");
        assert!(
            text.contains(flag) && text.contains("linux-aarch64"),
            "the diagnostic must name the flag and the target: {text}"
        );
    }
}

#[test]
fn non_64_bit_abis_are_refused_by_name() {
    let d = dir("m31");
    write(&d, "leaf.s", LEAF);
    for flag in ["-m31", "-mx32"] {
        let (ok, text) = run(
            &d,
            &["-q", "-c", &format!("--target={TARGET}"), flag, "leaf.s"],
        );
        assert!(!ok, "{flag} must be refused rather than assembled");
        assert!(
            text.contains(flag),
            "the diagnostic must name {flag}: {text}"
        );
    }
    // The 64-bit spelling is the default, and is accepted.
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "-m64",
            "leaf.s",
            "-o",
            "leaf.o",
        ],
    );
}

/// badc generates no i386 machine code and writes no 32-bit image, so
/// `-m16` / `-m32` reach a `-c` assembly unit only; anything else is
/// refused by name rather than failing inside the linker.
#[test]
fn m32_outside_a_c_assembly_unit_is_refused_by_name() {
    let d = dir("m32-c");
    write(&d, "u.c", "int f(void) { return 1; }\n");
    let (ok, text) = run(&d, &["-q", "-c", "--target=linux-x64", "-m32", "u.c"]);
    assert!(!ok, "a C source under -m32 must be refused");
    assert!(
        text.contains("-m32") && text.contains("u.c"),
        "the diagnostic must name the flag and the source: {text}"
    );
    write(
        &d,
        "leaf.s",
        "\t.text\n\t.globl leaf\n\t.type leaf, @function\nleaf:\n\tmovl $7, %eax\n\tret\n",
    );
    let (ok, text) = run(
        &d,
        &["-q", "--target=linux-x64", "-m32", "leaf.s", "-o", "prog"],
    );
    assert!(!ok, "a link under -m32 must be refused");
    assert!(
        text.contains("-m32") && text.contains("-c"),
        "the diagnostic must name the flag and where it applies: {text}"
    );
}

#[test]
fn the_vm_modes_refuse_assembly_rather_than_run_nothing() {
    let d = dir("jit");
    write(&d, "leaf.s", LEAF);
    let (ok, text) = run(&d, &["--jit", "leaf.s"]);
    assert!(!ok, "--jit must refuse an assembly unit");
    assert!(
        text.contains("leaf.s"),
        "the diagnostic must name the unit: {text}"
    );
}

#[test]
fn an_assembled_object_links_with_a_c_unit() {
    let d = dir("link");
    write(&d, "leaf.s", LEAF);
    write(
        &d,
        "main.c",
        "int leaf(void);\nint main(void){ return leaf() == 7 ? 0 : 1; }\n",
    );
    run_ok(
        &d,
        &[
            "-q",
            &format!("--target={TARGET}"),
            "main.c",
            "leaf.s",
            "-o",
            "prog",
        ],
    );
    assert!(d.join("prog").exists(), "the link produced no image");
}

/// `(st_shndx, st_value)` of a named symbol in an ELF64 object.
fn symbol(bytes: &[u8], want: &str) -> Option<(u16, u64)> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64at(0x28) as usize;
    let shentsize = u16at(0x3a);
    let shnum = u16at(0x3c);
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        if u32at(sh + 4) != 2 {
            continue; // not SHT_SYMTAB
        }
        let off = u64at(sh + 0x18) as usize;
        let size = u64at(sh + 0x20) as usize;
        let strsh = shoff + u32at(sh + 0x28) * shentsize;
        let stroff = u64at(strsh + 0x18) as usize;
        for e in (0..size).step_by(24) {
            let sym = off + e;
            let n = stroff + u32at(sym);
            let end = bytes[n..].iter().position(|&b| b == 0).unwrap();
            if &bytes[n..n + end] == want.as_bytes() {
                return Some((u16at(sym + 6) as u16, u64at(sym + 8)));
            }
        }
    }
    None
}

/// The contents of a named section of an ELF64 object.
fn section64(bytes: &[u8], want: &str) -> Vec<u8> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap()) as usize;
    let shoff = u64at(0x28);
    let (shentsize, shnum, shstrndx) = (u16at(0x3a), u16at(0x3c), u16at(0x3e));
    let strtab = u64at(shoff + shstrndx * shentsize + 0x18);
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        let n = strtab + u32at(sh);
        let end = bytes[n..].iter().position(|&c| c == 0).unwrap();
        let size = u64at(sh + 0x20);
        if &bytes[n..n + end] == want.as_bytes() {
            let off = u64at(sh + 0x18);
            return bytes[off..off + size].to_vec();
        }
    }
    Vec::new()
}

/// Assemble `src` for x86_64 and return its `.text`.
fn text_of(name: &str, src: &str) -> Vec<u8> {
    section64(&object_of(name, src), ".text")
}

/// Assemble `src` for x86_64 and return the object bytes.
fn object_of(name: &str, src: &str) -> Vec<u8> {
    object_for(name, src, "linux-x64")
}

/// Compile the C source `src` for x86_64 and return the object bytes.
fn object_of_c(name: &str, src: &str) -> Vec<u8> {
    let d = dir(name);
    write(&d, "u.c", src);
    run_ok(&d, &["-q", "-c", "--target=linux-x64", "u.c", "-o", "u.o"]);
    std::fs::read(d.join("u.o")).expect("object")
}

/// Assemble `src` for `target` and return the object bytes.
fn object_for(name: &str, src: &str, target: &str) -> Vec<u8> {
    let d = dir(name);
    write(&d, "b.s", src);
    let t = format!("--target={target}");
    run_ok(&d, &["-q", "-c", &t, "b.s", "-o", "b.o"]);
    std::fs::read(d.join("b.o")).expect("object")
}

/// `(offset, type, symbol name, addend)` of every `.rela.text` entry.
fn text_relocs(name: &str, src: &str) -> Vec<(u64, u32, String, i64)> {
    named_relocs(&object_of(name, src), ".rela.text")
}

/// `(offset, type, symbol name, addend)` of every entry of the named RELA
/// section of an ELF64 object.
fn named_relocs(bytes: &[u8], want: &str) -> Vec<(u64, u32, String, i64)> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64at(0x28) as usize;
    let shentsize = u16at(0x3a);
    let shnum = u16at(0x3c);
    // The symbol table the RELA section indexes, with its string table.
    let (symtab, stroff) = (0..shnum)
        .map(|i| shoff + i * shentsize)
        .find(|&sh| u32at(sh + 4) == 2)
        .map(|sh| {
            let strsh = shoff + u32at(sh + 0x28) * shentsize;
            (u64at(sh + 0x18) as usize, u64at(strsh + 0x18) as usize)
        })
        .expect(".symtab");
    let shstrndx = u16at(0x3e);
    let strtab = u64at(shoff + shstrndx * shentsize + 0x18) as usize;
    let str_at = |base: usize, off: usize| {
        let n = base + off;
        let end = bytes[n..].iter().position(|&b| b == 0).unwrap();
        String::from_utf8(bytes[n..n + end].to_vec()).unwrap()
    };
    // A section symbol carries no name of its own; readers take the
    // section's, so name it that way here too.
    let sym_name = |i: usize| {
        let sym = symtab + i * 24;
        if u32at(sym) == 0 {
            let sh = shoff + u16at(sym + 6) * shentsize;
            return str_at(strtab, u32at(sh));
        }
        str_at(stroff, u32at(sym))
    };
    let named = (0..shnum)
        .map(|i| shoff + i * shentsize)
        .find(|&sh| str_at(strtab, u32at(sh)) == want);
    let Some(sh) = named else {
        return Vec::new();
    };
    let (off, size) = (u64at(sh + 0x18) as usize, u64at(sh + 0x20) as usize);
    (0..size)
        .step_by(24)
        .map(|e| {
            let r = off + e;
            let info = u64at(r + 8);
            (
                u64at(r),
                (info & 0xffff_ffff) as u32,
                sym_name((info >> 32) as usize),
                u64at(r + 16) as i64,
            )
        })
        .collect()
}

/// A direct branch takes `R_X86_64_PLT32` only where the link may bind it
/// through a PLT slot -- a named function symbol. A target the assembler
/// reduces to a section symbol takes `R_X86_64_PC32`, which is what GNU as
/// 2.46.1 emits for the same source; it is the shape `entry_64.o`,
/// `memmove_64.o` and `retpoline.o` carry.
#[test]
fn a_branch_against_a_section_symbol_takes_pc32() {
    const PC32: u32 = 2;
    const PLT32: u32 = 4;
    assert_eq!(
        text_relocs(
            "reloc-xsec",
            "\t.text\nf:\n\tjmp o\n\t.section .other,\"ax\"\no:\n\tnop\n",
        ),
        [(1, PC32, String::from(".other"), -4)],
    );
    // A local label of a third section reduces the same way, and a `call`
    // to one does too: the reduction, not the mnemonic, picks the type.
    assert_eq!(
        text_relocs(
            "reloc-xsec-call",
            "\t.text\nf:\n\tcall o\n\t.section .other,\"ax\"\no:\n\tnop\n",
        ),
        [(1, PC32, String::from(".other"), -4)],
    );
    // An undefined named symbol keeps PLT32.
    assert_eq!(
        text_relocs("reloc-undef", "\t.text\nf:\n\tjmp undef\n"),
        [(1, PLT32, String::from("undef"), -4)],
    );
    // A `call` to a same-section global keeps PLT32; the relaxable `jmp`
    // to the same target resolves in place, which is GNU as 2.46.1's
    // encoding of each source.
    assert_eq!(
        text_relocs(
            "reloc-glob-call",
            "\t.text\n\t.globl g\nf:\n\tcall g\n\tnop\ng:\n\tnop\n",
        ),
        [(1, PLT32, String::from("g"), -4)],
    );
    assert_eq!(
        text_relocs(
            "reloc-glob",
            "\t.text\n\t.globl g\nf:\n\tjmp g\n\tnop\ng:\n\tnop\n",
        ),
        [],
    );
}

/// `rel8` reaches a displacement in `-128..=127` measured from the end of
/// the short form, and nothing wider. Each expectation is GNU as 2.46.1's
/// encoding of the same source.
#[test]
fn short_branches_take_the_gnu_as_displacement_range() {
    // Backward: 126 bytes of filler puts the target 128 back from the end
    // of a two-byte branch; 127 puts it 129 back, which needs the long form.
    let t = text_of("relax-b128", "\t.text\nt:\n\t.fill 126,1,0x90\n\tjne t\n");
    assert_eq!(&t[126..], [0x75, 0x80], "jne at -128");
    let t = text_of("relax-b129", "\t.text\nt:\n\t.fill 127,1,0x90\n\tjne t\n");
    assert_eq!(
        &t[127..],
        [0x0f, 0x85, 0x7b, 0xff, 0xff, 0xff],
        "jne at -129"
    );
    let t = text_of("relax-jb128", "\t.text\nt:\n\t.fill 126,1,0x90\n\tjmp t\n");
    assert_eq!(&t[126..], [0xeb, 0x80], "jmp at -128");
    let t = text_of("relax-jb129", "\t.text\nt:\n\t.fill 127,1,0x90\n\tjmp t\n");
    assert_eq!(&t[127..], [0xe9, 0x7c, 0xff, 0xff, 0xff], "jmp at -129");
    // Forward: the filler count is the displacement itself.
    let t = text_of("relax-f127", "\t.text\n\tjne t\n\t.fill 127,1,0x90\nt:\n");
    assert_eq!(&t[..2], [0x75, 0x7f], "jne at +127");
    let t = text_of("relax-f128", "\t.text\n\tjne t\n\t.fill 128,1,0x90\nt:\n");
    assert_eq!(&t[..6], [0x0f, 0x85, 0x80, 0, 0, 0], "jne at +128");
    let t = text_of("relax-j127", "\t.text\n\tjmp t\n\t.fill 127,1,0x90\nt:\n");
    assert_eq!(&t[..2], [0xeb, 0x7f], "jmp at +127");
    let t = text_of("relax-j128", "\t.text\n\tjmp t\n\t.fill 128,1,0x90\nt:\n");
    assert_eq!(&t[..5], [0xe9, 0x80, 0, 0, 0], "jmp at +128");
}

/// Shortening one branch brings another into range, so each form is settled
/// against a layout that already accounts for the other: the outer `jmp`
/// reaches +127 only once the inner one is two bytes rather than five.
#[test]
fn branch_forms_settle_against_each_other() {
    let t = text_of(
        "relax-iter",
        "\t.text\na:\n\tjmp e\n\t.fill 124,1,0x90\nb:\n\tjmp b\n\t.fill 1,1,0x90\ne:\n\tnop\n",
    );
    assert_eq!(&t[..2], [0xeb, 0x7f], "outer jmp at +127");
    assert_eq!(&t[126..128], [0xeb, 0xfe], "inner jmp to itself");
    assert_eq!(t.len(), 130, "2 + 124 + 2 + 1 + 1 with both short");
}

/// A `.org` between a branch and its target absorbs what the branch saves,
/// so the short form does not reach even though it does in the layout the
/// long form produces. GNU as settles on the long form, and so does badc: a
/// form is taken only when it reaches in the layout that choice produces.
#[test]
fn a_branch_an_org_pushes_out_of_range_keeps_the_long_form() {
    let t = text_of(
        "relax-org",
        "\t.text\nf:\n\tjmp 1f\n\t.org 0x84\n1:\n\tnop\n",
    );
    assert_eq!(&t[..5], [0xe9, 0x7f, 0, 0, 0], "long form across `.org`");
    assert_eq!(t.len(), 0x85, "the `.org` target is unmoved");
}

/// Only a reference the assembler resolves in place may take the short
/// form: a weak name, a name in another section, and an undefined name all
/// keep a relocation, which the link fills at the long form's width. A
/// same-section global is not among them -- the link cannot rebind it away
/// from the definition here, so the branch relaxes.
#[test]
fn a_relocated_branch_keeps_the_long_form() {
    let t = text_of(
        "relax-weak",
        "\t.text\n\t.weak w\nf:\n\tjmp w\n\tnop\nw:\n\tnop\n",
    );
    assert_eq!(&t[..5], [0xe9, 0, 0, 0, 0], "weak target");
    let t = text_of("relax-ext", "\t.text\nf:\n\tjmp undef\n");
    assert_eq!(&t[..5], [0xe9, 0, 0, 0, 0], "undefined target");
    let t = text_of(
        "relax-xsec",
        "\t.text\nf:\n\tjmp o\n\t.section .other,\"ax\"\no:\n\tnop\n",
    );
    assert_eq!(&t[..5], [0xe9, 0, 0, 0, 0], "target in another section");
    // A global definition in the same section relaxes: GNU as 2.46.1 emits
    // `eb 01` here, while the non-relaxable `call` to the same target keeps
    // rel32 and its relocation.
    let t = text_of(
        "relax-glob",
        "\t.text\n\t.globl g\nf:\n\tjmp g\n\tnop\ng:\n\tnop\n",
    );
    assert_eq!(&t[..2], [0xeb, 0x01], "global target in this section");
    let t = text_of(
        "relax-glob-call",
        "\t.text\n\t.globl g\nf:\n\tcall g\n\tnop\ng:\n\tnop\n",
    );
    assert_eq!(&t[..5], [0xe8, 0, 0, 0, 0], "call to a same-section global");
}

/// The same binding rule inside a function-body template: an in-stream
/// definition satisfies a `jmp` / `jcc` only when the link cannot rebind it.
/// GNU as 2.46.1 for the stream this template pastes keeps the rel32 form
/// and `R_X86_64_PLT32 wk - 4`, and resolves a `.globl`-declared target
/// against its definition.
#[test]
fn a_template_branch_to_a_weak_label_keeps_its_relocation() {
    const PLT32: u32 = 4;
    let bytes = object_of_c(
        "tmpl-weak-branch",
        "int f(int x) {\n\
         __asm__ volatile(\"jmp wk\\n\\tnop\\n.weak wk\\nwk:\\n\\tnop\");\n\
         __asm__ volatile(\"jmp gl\\n\\t.globl gl\\ngl:\\n\\tnop\");\n\
         return x;\n}\n",
    );
    let relocs = named_relocs(&bytes, ".rela.text");
    let wk: Vec<_> = relocs.iter().filter(|(_, _, n, _)| n == "wk").collect();
    let t = section64(&bytes, ".text");
    assert_eq!(wk.len(), 1, "one branch row: {relocs:?}");
    let &(off, rtype, _, addend) = wk[0];
    assert_eq!((rtype, addend), (PLT32, -4));
    assert_eq!(t[off as usize - 1], 0xe9, "rel32 jmp under the reloc");
    assert_eq!(&t[off as usize..off as usize + 4], [0, 0, 0, 0]);
    assert!(
        !relocs.iter().any(|(_, _, n, _)| n == "gl"),
        "a global definition resolves in place: {relocs:?}"
    );
}

/// A template branch to a label of its own stream settles on the rel8 form
/// where the layout reaches, as the section path settles one. GNU as 2.46.1
/// for the stream this template pastes gives `eb 01` over the nop and
/// `75 fc` back over the `inc`, and holds the branch over the 130-byte
/// `.skip` on the rel32 form; nothing here relocates.
#[test]
fn a_template_stream_branch_takes_the_short_form() {
    let bytes = object_of_c(
        "tmpl-branch-relax",
        "int f(void) {\n\
         __asm__ volatile(\"jmp 1f\\n\\tnop\\n1:\\n\\tinc %eax\\n\\tjne 1b\\n\\t\" \
         \"jmp 2f\\n\\t.skip 130\\n2:\\n\\tnop\" ::: \"eax\", \"cc\");\n\
         return 0;\n}\n",
    );
    let t = section64(&bytes, ".text");
    let seq = [
        0xeb, 0x01, 0x90, 0xff, 0xc0, 0x75, 0xfc, 0xe9, 0x82, 0x00, 0x00, 0x00,
    ];
    assert!(t.windows(seq.len()).any(|w| w == seq), "{t:x?}");
    assert!(
        named_relocs(&bytes, ".rela.text").is_empty(),
        "no relocation rows"
    );
}

/// A branch relaxes across `.align` and a label-valued `.skip`, whose
/// padding absorbs the branch's own width. The kernel's `clear_bhb_loop` is
/// this shape; the bytes are GNU as 2.46.1's for the same source, which
/// needs the function's base to keep the 64-byte modulus the padding is
/// measured against.
#[test]
fn a_branch_over_alignment_padding_matches_gnu_as() {
    let src = "\t.text\n\t.skip 32, 0x90\n\t.globl f\nf:\n\tpush %rbp\n\tmov %rsp, %rbp\n\
               \tmovl $5, %ecx\n\tcall 1f\n\tjmp 5f\n\t.align 64, 0xcc\n\
               \t.skip 32 - (.Lret1 - 1f), 0xcc\n1:\tcall 2f\n.Lret1:\tjmp thunk\n\
               \t.align 64, 0xcc\n\t.skip 32 - 18, 0xcc\n2:\tmovl $5, %eax\n\
               3:\tjmp 4f\n\tnop\n4:\tsub $1, %eax\n\tjnz 3b\n\tsub $1, %ecx\n\tjnz 1b\n\
               .Lret2:\tjmp thunk\n5:\tlfence\n\tpop %rbp\n\tjmp thunk\n";
    let t = text_of("relax-bhb", src);
    // The `jmp 5f` at 0x2e reaches 0xa5 in the short form; the following
    // `.align 64` absorbs the three bytes, so every later offset stands.
    assert_eq!(&t[0x2e..0x30], [0xeb, 0x75], "jmp 5f");
    assert_eq!(&t[0x29..0x2e], [0xe8, 0x2d, 0, 0, 0], "call 1f");
    assert_eq!(&t[0x5b..0x60], [0xe8, 0x2e, 0, 0, 0], "1: call 2f");
    assert_eq!(&t[0x8e..0x93], [0xb8, 0x05, 0, 0, 0], "2: movl $5, %eax");
    assert_eq!(&t[0xa5..0xa8], [0x0f, 0xae, 0xe8], "5: lfence");
}

/// A branch to a `.set name, symbol` alias takes the location and the
/// binding of the name the chain ends at. An alias of a local label of the
/// branch's own section resolves at assembly time and takes the short form,
/// and one of a label of another section reduces to that section's symbol;
/// both are GNU as 2.46.1's encoding of the same source. An alias of a name
/// the unit binds global relaxes, as a direct reference to that name does.
#[test]
fn a_branch_to_a_set_alias_follows_the_chain() {
    let src = "\t.text\nf:\n\tjmp a\n\tnop\nt:\n\tnop\n\t.set a, t\n";
    assert_eq!(text_of("alias-local", src), [0xeb, 0x01, 0x90, 0x90]);
    assert_eq!(text_relocs("alias-local-rel", src), []);
    // A chain of assignments resolves the same way.
    let src = "\t.text\nf:\n\tjmp a\n\tnop\nt:\n\tnop\n\t.set a, b\n\t.set b, t\n";
    assert_eq!(text_of("alias-chain", src), [0xeb, 0x01, 0x90, 0x90]);
    assert_eq!(text_relocs("alias-chain-rel", src), []);
    // An alias of a label of another section reduces to that section.
    let src = "\t.text\nf:\n\tjmp ya\n\t.set ya, o\n\t.section .other,\"ax\"\no:\n\tnop\n";
    assert_eq!(&text_of("alias-xsec", src)[..5], [0xe9, 0, 0, 0, 0]);
    assert_eq!(
        text_relocs("alias-xsec-rel", src),
        [(1, 2, String::from(".other"), -4)],
    );
    // An alias of a same-section global relaxes, as a direct reference to
    // that name does; GNU as 2.46.1 emits `eb 01` with no relocation.
    let src = "\t.text\n\t.globl g\nf:\n\tjmp ga\n\tnop\ng:\n\tnop\n\t.set ga, g\n";
    assert_eq!(&text_of("alias-glob", src)[..2], [0xeb, 0x01]);
    assert_eq!(text_relocs("alias-glob-rel", src), []);
}

/// A data field naming a `.set name, symbol` alias relocates against the
/// name the source wrote: the chain supplies the value, not the symbol the
/// relocation names, which is how GNU as 2.46.1 assembles the source below
/// on both targets. `SYM_FUNC_ALIAS` plus `EXPORT_SYMBOL` gives the kernel
/// one `.export_symbol` entry per name, and modpost matches each entry's
/// label suffix against the name its relocation targets, so reducing the
/// entry to the aliased name rejects the export.
#[test]
fn a_data_reference_to_a_set_alias_names_the_written_symbol() {
    const X86_64: u32 = 1;
    const A64_ABS64: u32 = 257;
    let src = concat!(
        "\t.text\n\t.globl memcpy\nmemcpy:\n\tnop\n",
        "\t.globl __memcpy\n\t.set __memcpy, memcpy\n",
        "\t.section \"exp\",\"a\"\n\t.quad __memcpy\n\t.quad memcpy\n"
    );
    for (target, kind) in [("linux-x64", X86_64), ("linux-aarch64", A64_ABS64)] {
        let o = object_for(&format!("alias-data-{target}"), src, target);
        assert_eq!(
            named_relocs(&o, ".relaexp"),
            [
                (0, kind, String::from("__memcpy"), 0),
                (8, kind, String::from("memcpy"), 0),
            ],
            "{target}"
        );
    }
    // A branch still resolves through the chain: the alias of a local label
    // of the branch's own section needs no relocation on either target.
    let src = "\t.text\nf:\n\tjmp a\n\tnop\nt:\n\tnop\n\t.set a, t\n";
    assert_eq!(
        text_of("alias-data-branch-x64", src),
        [0xeb, 0x01, 0x90, 0x90]
    );
    assert_eq!(text_relocs("alias-data-branch-x64-rel", src), []);
    let src = "\t.text\nf:\n\tb a\n\tnop\nt:\n\tnop\n\t.set a, t\n";
    let o = object_for("alias-data-branch-a64", src, "linux-aarch64");
    assert_eq!(&section64(&o, ".text")[..4], [0x02, 0x00, 0x00, 0x14]);
    assert_eq!(named_relocs(&o, ".rela.text"), []);
}

/// A `.set` alias takes the binding the unit gave the name it assigns: local
/// unless a `.globl` or a `.weak` of the unit declared it, which is GNU as
/// 2.46.1's symbol table for the source below. The three positions the
/// assignment holds -- a `.s` unit, file-scope asm, and a function body's code
/// stream -- share the rule, and every local entry precedes the rest, as ELF
/// requires of `sh_info`.
#[test]
fn a_set_alias_binds_as_the_unit_declared_the_name() {
    const LOCAL: u8 = 0;
    const GLOBAL: u8 = 1;
    const WEAK: u8 = 2;
    const BODY: &str = "\t.globl g\ng:\n\tnop\nt:\n\tnop\n\
                        \t.set la, t\n\t.set ga, g\n\
                        \t.globl ega\n\t.set ega, g\n\
                        \t.weak wa\n\t.set wa, t\n\t.set chain, la\n";
    const WANT: [(&str, u8); 6] = [
        ("la", LOCAL),
        ("ga", LOCAL),
        ("chain", LOCAL),
        ("g", GLOBAL),
        ("ega", GLOBAL),
        ("wa", WEAK),
    ];
    let body_c = BODY.replace('\n', "\\n").replace('\t', "\\t");
    let objects = [
        (
            "set-bind-s",
            object_of("set-bind-s", &format!("\t.text\n{BODY}")),
        ),
        (
            "set-bind-file",
            object_of_c(
                "set-bind-file",
                &format!("__asm__(\".text\\n{body_c}\");\n"),
            ),
        ),
        (
            "set-bind-body",
            object_of_c(
                "set-bind-body",
                &format!("void f(void) {{ __asm__ volatile(\"{body_c}\"); }}\n"),
            ),
        ),
    ];
    for (name, bytes) in &objects {
        let syms = sym_bindings(bytes);
        for (n, bind) in WANT {
            let got = syms.iter().find(|s| s.0 == n);
            assert!(
                got.is_some_and(|s| s.1 == bind),
                "{name}: `{n}` in {syms:?}"
            );
        }
        let first_nonlocal = syms.iter().position(|s| s.1 != LOCAL).unwrap_or(syms.len());
        assert!(
            syms[first_nonlocal..].iter().all(|s| s.1 != LOCAL),
            "{name}: a local entry follows a global one: {syms:?}"
        );
    }
}

/// A `.set` alias whose chain ends at a name the unit does not define emits
/// no symbol of its own: GNU as 2.46.1 drops the alias, resolves every
/// reference against the chain's end, and gives the end an undefined global
/// entry whether or not anything references it. A `.globl` on the alias
/// changes none of that.
#[test]
fn a_set_alias_of_an_undefined_name_resolves_against_the_name() {
    const GLOBAL: u8 = 1;
    const SHN_UNDEF: u16 = 0;
    const PLT32: u32 = 4;
    const ABS64: u32 = 1;
    let find = |syms: &[(String, u8, u16)], n: &str| syms.iter().find(|s| s.0 == n).cloned();
    // Unreferenced: the alias vanishes and the end surfaces undefined.
    let bytes = object_of("set-undef", "\t.text\n\t.set x, ext\n");
    let syms = sym_bindings(&bytes);
    assert_eq!(find(&syms, "x"), None, "{syms:?}");
    assert_eq!(
        find(&syms, "ext"),
        Some((String::from("ext"), GLOBAL, SHN_UNDEF)),
        "{syms:?}"
    );
    // A branch through the alias, also via a chain and under `.globl`,
    // relocates against the end.
    for (name, src) in [
        ("set-undef-call", "\t.text\n\t.set x, ext\n\tcall x\n"),
        (
            "set-undef-chain",
            "\t.text\n\t.set a, b\n\t.set b, ext\n\tcall a\n",
        ),
        (
            "set-undef-globl",
            "\t.text\n\t.globl x\n\t.set x, ext\n\tcall x\n",
        ),
    ] {
        let bytes = object_of(name, src);
        let syms = sym_bindings(&bytes);
        assert_eq!(find(&syms, "x"), None, "{name}: {syms:?}");
        assert_eq!(find(&syms, "a"), None, "{name}: {syms:?}");
        assert_eq!(find(&syms, "b"), None, "{name}: {syms:?}");
        assert_eq!(
            named_relocs(&bytes, ".rela.text"),
            [(1, PLT32, String::from("ext"), -4)],
            "{name}"
        );
    }
    // A data field through the alias relocates against the end too.
    let bytes = object_of("set-undef-data", "\t.set x, ext\n\t.data\n\t.quad x\n");
    assert_eq!(
        named_relocs(&bytes, ".rela.data"),
        [(0, ABS64, String::from("ext"), 0)],
    );
}

/// `.set name, sym + k` assigns the symbol at an offset. Where the unit's
/// layout does not place `sym`, the name is an alias with an addend: GNU as
/// 2.46.1 emits no symbol for it and lands every reference on `sym`, the
/// offset folded into the addend. For `.text: .set x, ext+8; call x; jmp x`
/// it writes `e8 00 00 00 00 e9 00 00 00 00` with `PLT32 ext + 4` at 0x1 and
/// 0x6; for `.set x, ext+8; .data; .quad x; .long x` it writes `64 ext + 8`
/// at 0 and `32 ext + 8` at 8. An alias of a name the unit defines takes its
/// place at the offset, keeping the target's type and size, as gas gives
/// `d+8` value 8 size 16 OBJECT and `f+1` value 1 size 1 FUNC.
#[test]
fn a_set_alias_of_a_symbol_at_an_offset_carries_the_addend() {
    const OBJECT_GLOBAL: u8 = 0x11;
    const FUNC_GLOBAL: u8 = 0x12;
    const GLOBAL: u8 = 1;
    const SHN_UNDEF: u16 = 0;
    const PLT32: u32 = 4;
    const ABS64: u32 = 1;
    const ABS32: u32 = 10;
    // An undefined end: no symbol for the alias, the offset in the addend.
    let src = "\t.text\n\t.set x, ext+8\n\tcall x\n\tjmp x\n";
    assert_eq!(
        text_of("set-off-call", src),
        [0xe8, 0, 0, 0, 0, 0xe9, 0, 0, 0, 0]
    );
    let bytes = object_of("set-off-undef", src);
    let syms = sym_bindings(&bytes);
    assert_eq!(syms.iter().find(|s| s.0 == "x"), None, "{syms:?}");
    assert_eq!(
        syms.iter().find(|s| s.0 == "ext"),
        Some(&(String::from("ext"), GLOBAL, SHN_UNDEF)),
        "{syms:?}"
    );
    assert_eq!(
        named_relocs(&bytes, ".rela.text"),
        [
            (1, PLT32, String::from("ext"), 4),
            (6, PLT32, String::from("ext"), 4),
        ],
    );
    let bytes = object_of(
        "set-off-data",
        "\t.set x, ext+8\n\t.data\n\t.quad x\n\t.long x\n",
    );
    assert_eq!(
        named_relocs(&bytes, ".rela.data"),
        [
            (0, ABS64, String::from("ext"), 8),
            (8, ABS32, String::from("ext"), 8),
        ],
    );
    // Offsets accumulate along a chain of assignments.
    let bytes = object_of(
        "set-off-chain",
        "\t.text\n\t.set a, b+2\n\t.set b, ext+8\n\t.quad a\n",
    );
    assert_eq!(
        named_relocs(&bytes, ".rela.text"),
        [(0, ABS64, String::from("ext"), 10)],
    );
    // A defined end: the name takes its target's place at the offset.
    let bytes = object_of_c(
        "set-off-defined",
        "int d[4] = {1,2,3,4};\nvoid f(void) {}\n\
         __asm__(\".globl ad\\n.set ad, d+8\\n.globl af\\n.set af, f+1\\n\");\n",
    );
    let syms = sym_table(&bytes);
    let of = |n: &str| syms.iter().find(|s| s.0 == n).cloned().unwrap();
    let (_, d_info, d_shndx, d_val, d_size) = of("d");
    let (_, f_info, f_shndx, f_val, f_size) = of("f");
    assert_eq!((d_info, d_size, f_info), (OBJECT_GLOBAL, 16, FUNC_GLOBAL));
    assert_eq!(
        of("ad"),
        (
            String::from("ad"),
            OBJECT_GLOBAL,
            d_shndx,
            d_val + 8,
            d_size
        )
    );
    assert_eq!(
        of("af"),
        (String::from("af"), FUNC_GLOBAL, f_shndx, f_val + 1, f_size)
    );
}

/// A `.set` alias whose chain ends at a definition of this unit takes that
/// definition's section, value, type and size, through whichever channel
/// defines the name. GNU as 2.46.1 over the equivalent assembly emits
/// `(value, size, type, bind)` `(0, 4, OBJECT, LOCAL)` for an alias of a
/// `.data` object, `(0, 4, TLS, LOCAL)` for one of a `.tdata` object,
/// `(1, 0, NOTYPE, LOCAL)` for one of a code-stream label at `.text+1`, and
/// `(0, 3, FUNC, GLOBAL)` for a `.globl` alias of a 3-byte function.
#[test]
fn a_set_alias_of_a_defined_name_takes_its_place() {
    const NOTYPE_LOCAL: u8 = 0x00;
    const OBJECT_LOCAL: u8 = 0x01;
    const TLS_LOCAL: u8 = 0x06;
    const OBJECT_GLOBAL: u8 = 0x11;
    const FUNC_GLOBAL: u8 = 0x12;
    const ABS64: u32 = 1;
    // `(st_info, st_shndx, st_value, st_size)` of a named entry.
    let place = |bytes: &[u8], n: &str| {
        sym_table(bytes)
            .into_iter()
            .find(|s| s.0 == n)
            .map(|(_, info, shndx, val, size)| (info, shndx, val, size))
    };
    let at = |bytes: &[u8], n: &str, info: u8| {
        let (_, shndx, val, size) = place(bytes, n).unwrap_or_else(|| panic!("no `{n}` entry"));
        (info, shndx, val, size)
    };
    // Assembled directly: an alias of a data object, a chain through it,
    // and a `.globl` alias of a function.
    let bytes = object_of(
        "set-defined-s",
        "\t.text\n\t.globl g\n\t.type g, @function\ng:\n\tret\n\t.size g, .-g\n\
         \t.data\n\t.globl d\n\t.type d, @object\n\t.size d, 4\nd:\n\t.long 5\n\
         \t.set alias_d, d\n\t.globl alias_g\n\t.set alias_g, g\n\t.set chain, alias_d\n",
    );
    let d = at(&bytes, "d", OBJECT_GLOBAL);
    let g = at(&bytes, "g", FUNC_GLOBAL);
    assert_eq!((d.2, d.3, g.2, g.3), (0, 4, 0, 1));
    assert_eq!(
        place(&bytes, "alias_d"),
        Some((OBJECT_LOCAL, d.1, d.2, d.3))
    );
    assert_eq!(place(&bytes, "chain"), Some((OBJECT_LOCAL, d.1, d.2, d.3)));
    assert_eq!(place(&bytes, "alias_g"), Some((FUNC_GLOBAL, g.1, g.2, g.3)));
    // The same assignments in a C unit's file-scope asm. A target that is
    // neither an inline-asm section label nor a function body reaches the
    // writer through another channel: a data or thread-local object, or a
    // label an inline-asm template defined in the main code stream.
    let bytes = object_of_c(
        "set-defined-c",
        "int d = 5;\n_Thread_local int t = 3;\n\
         void f(void) { __asm__ volatile(\"nop\\n mylbl:\\n nop\\n\"); }\n\
         __asm__(\".set ad, d\\n.set chain, ad\\n.set at, t\\n.set al, mylbl\\n\
         .globl af\\n.set af, f\\n\");\n",
    );
    let d = at(&bytes, "d", OBJECT_GLOBAL);
    let t = at(&bytes, "t", TLS_LOCAL | 0x10);
    let lbl = at(&bytes, "mylbl", NOTYPE_LOCAL);
    let f = at(&bytes, "f", FUNC_GLOBAL);
    assert_eq!((d.3, t.3, lbl.2), (4, 4, 1));
    assert_eq!(place(&bytes, "ad"), Some((OBJECT_LOCAL, d.1, d.2, d.3)));
    assert_eq!(place(&bytes, "chain"), Some((OBJECT_LOCAL, d.1, d.2, d.3)));
    assert_eq!(place(&bytes, "at"), Some((TLS_LOCAL, t.1, t.2, t.3)));
    assert_eq!(
        place(&bytes, "al"),
        Some((NOTYPE_LOCAL, lbl.1, lbl.2, lbl.3))
    );
    assert_eq!(place(&bytes, "af"), Some((FUNC_GLOBAL, f.1, f.2, f.3)));
    // A C reference to such an alias binds to the definition rather than
    // adding an undefined entry beside it.
    let bytes = object_of_c(
        "set-defined-ref",
        "int d = 5;\n__asm__(\".globl ad\\n.set ad, d\\n\");\nextern int ad;\nint *q = &ad;\n",
    );
    let ad: Vec<_> = sym_table(&bytes)
        .into_iter()
        .filter(|s| s.0 == "ad")
        .collect();
    assert_eq!(ad.len(), 1, "{ad:?}");
    assert_eq!(ad[0].1 >> 4, 1, "{ad:?}");
    assert_ne!(ad[0].2, 0, "{ad:?}");
    let rows: Vec<_> = named_relocs(&bytes, ".rela.data")
        .into_iter()
        .map(|(_, ty, name, addend)| (ty, name, addend))
        .collect();
    assert_eq!(rows, [(ABS64, String::from("ad"), 0)]);
}

/// An `__attribute__((alias))` declarator's symbol takes the declarator's own
/// linkage, as gcc 16.1 emits it: `static` binds it local,
/// `__attribute__((weak))` weak, and external linkage global.
#[test]
fn an_attribute_alias_binds_as_its_declarator() {
    const LOCAL: u8 = 0;
    const GLOBAL: u8 = 1;
    const WEAK: u8 = 2;
    let bytes = object_of_c(
        "attr-alias-bind",
        "void real(void) {}\n\
         static void sal(void) __attribute__((alias(\"real\")));\n\
         void gal(void) __attribute__((alias(\"real\")));\n\
         void wal(void) __attribute__((weak, alias(\"real\")));\n\
         void use(void) { sal(); }\n",
    );
    let syms = sym_bindings(&bytes);
    for (n, bind) in [("sal", LOCAL), ("gal", GLOBAL), ("wal", WEAK)] {
        let got = syms.iter().find(|s| s.0 == n);
        assert!(got.is_some_and(|s| s.1 == bind), "`{n}` in {syms:?}");
    }
}

/// A branch target may be an expression over symbols and labels, as every
/// other operand may. A reference to a symbol at an offset takes `PC32`: the
/// offset is no entry point, so it binds no PLT slot. A plain reference keeps
/// `PLT32`, and so does one whose expression leaves no offset. A target in
/// the branch's own section resolves in place and takes the short form,
/// through a `.set` alias as a bare name does. The bytes and the relocations
/// are GNU as 2.46.1's for the same source.
#[test]
fn a_branch_takes_an_expression_target() {
    let src = "\t.text\nf:\n\tjmp sym+4\n\tcall sym+8\n\tje sym+4\n\tjmp sym+0\n";
    assert_eq!(
        text_of("branch-expr", src),
        [
            0xe9, 0, 0, 0, 0, 0xe8, 0, 0, 0, 0, 0x0f, 0x84, 0, 0, 0, 0, 0xe9, 0, 0, 0, 0,
        ],
    );
    assert_eq!(
        text_relocs("branch-expr-rel", src),
        [
            (1, 2, String::from("sym"), 0),
            (6, 2, String::from("sym"), 4),
            (0xc, 2, String::from("sym"), 0),
            (0x11, 4, String::from("sym"), -4),
        ],
    );
    let src = "\t.text\nf:\n\tjmp lo+4\n\tnop\nlo:\n\tnop\n";
    assert_eq!(text_of("branch-expr-local", src), [0xeb, 0x05, 0x90, 0x90]);
    assert_eq!(text_relocs("branch-expr-local-rel", src), []);
    let src = "\t.text\nf:\n\tnop\n\tjmp a+1\n\t.set a, t\nt:\n\tnop\n";
    assert_eq!(text_of("branch-expr-alias", src), [0x90, 0xeb, 0x01, 0x90]);
    assert_eq!(text_relocs("branch-expr-alias-rel", src), []);
}

/// GNU as writes a 64-bit far branch with its `rex[.WRXB]` prefix and has no
/// `q` suffix for one; LLVM spells the same encoding `ljmpq` and prints it
/// that way, so both are accepted. On one statement the prefix merges into
/// the instruction's own REX byte, which is where the extended base register
/// puts its bit. The bytes are GNU as 2.46.1's for the same source.
#[test]
fn a_rex_prefix_writes_a_far_branch() {
    let t = text_of(
        "rex-far",
        "\t.text\n\trex.W ljmp *(%rax)\n\trex.W ljmp *(%r13)\n\tljmpq *(%rax)\n",
    );
    assert_eq!(
        t,
        [0x48, 0xff, 0x28, 0x49, 0xff, 0x6d, 0x00, 0x48, 0xff, 0x28]
    );
}

/// GNU as orders the legacy prefixes segment, address size, operand size,
/// then repeat / lock, whatever order the statement writes them in, and takes
/// a memory operand's address size from the base register it names. The three
/// positions a template holds -- a `.s` unit, file-scope asm, and a function
/// body -- share the ordering, so each yields GNU as 2.46.1's bytes for the
/// source below.
#[test]
fn legacy_prefixes_take_gnu_as_order_in_every_position() {
    const BODY: &str = "\tlock cmpxchgw %bx, 2(%rax)\n\
                        \tlock cmpxchgw %bx, 2(%eax)\n\
                        \tlock incl %gs:2(%rax)\n\
                        \tgs lock cmpxchgw %bx, 2(%rax)\n\
                        \tlock gs cmpxchgw %bx, 2(%rax)\n\
                        \trep stosw\n\
                        \trepnz scasb\n";
    const WANT: [u8; 37] = [
        0x66, 0xf0, 0x0f, 0xb1, 0x58, 0x02, // lock cmpxchgw %bx, 2(%rax)
        0x67, 0x66, 0xf0, 0x0f, 0xb1, 0x58, 0x02, // lock cmpxchgw %bx, 2(%eax)
        0x65, 0xf0, 0xff, 0x40, 0x02, // lock incl %gs:2(%rax)
        0x65, 0x66, 0xf0, 0x0f, 0xb1, 0x58, 0x02, // gs lock cmpxchgw %bx, 2(%rax)
        0x65, 0x66, 0xf0, 0x0f, 0xb1, 0x58, 0x02, // lock gs cmpxchgw %bx, 2(%rax)
        0x66, 0xf3, 0xab, // rep stosw
        0xf2, 0xae, // repnz scasb
    ];
    assert_eq!(
        text_of("prefix-order-s", &format!("\t.text\np:\n{BODY}")),
        WANT,
    );
    let body_c = BODY.replace('\n', "\\n").replace('\t', "\\t");
    for (name, src) in [
        (
            "prefix-order-file",
            format!("__asm__(\".text\\npf:\\n{body_c}\");\n"),
        ),
        (
            "prefix-order-body",
            format!("void f(void) {{ __asm__ volatile(\"{body_c}\"); }}\n"),
        ),
    ] {
        let t = section64(&object_of_c(name, &src), ".text");
        assert_eq!(
            t.windows(WANT.len()).filter(|w| *w == WANT).count(),
            1,
            "{name}: {t:02x?}"
        );
    }
}

/// `call` has no `rel8` form, so it keeps `e8 rel32` at any distance.
#[test]
fn a_near_call_is_not_shortened() {
    let t = text_of("relax-call", "\t.text\nf:\n\tcall 1f\n1:\n\tnop\n");
    assert_eq!(&t[..5], [0xe8, 0, 0, 0, 0], "call keeps rel32");
}

/// A near branch through an absolute address: AT&T's `*` makes the operand
/// the memory holding the target, which long mode addresses with a base-less
/// SIB. GNU as 2.46.1 writes `ff 24 25 34 12 00 00` for `jmp *0x1234` and
/// `ff 14 25 34 12 00 00` for `call *0x1234`; the symbol spelling takes an
/// `R_X86_64_32S` in the same displacement field.
#[test]
fn a_near_indirect_branch_takes_an_absolute_address() {
    const X86_64_32S: u32 = 11;
    let t = text_of("jmp-abs", "\t.text\n\tjmp *0x1234\n\tcall *0x1234\n");
    #[rustfmt::skip]
    let want = [0xff, 0x24, 0x25, 0x34, 0x12, 0, 0,
                0xff, 0x14, 0x25, 0x34, 0x12, 0, 0];
    assert_eq!(t, want);
    let src = "\t.text\n\tjmp *sym\n";
    assert_eq!(&text_of("jmp-abs-sym", src)[..3], [0xff, 0x24, 0x25]);
    assert_eq!(
        text_relocs("jmp-abs-sym-rel", src),
        [(3, X86_64_32S, String::from("sym"), 0)],
    );
    // Outside long mode the reference takes the mode's operand size, and the
    // address size decides the r/m form and the `67` prefix: gas writes
    // `ff 26 34 12` / `ff 27` in `.code16` and `ff 25 34 12 00 00` /
    // `67 ff 27` in `.code32`.
    let t = text_of("jmp-abs-16", "\t.code16\n\tjmp *0x1234\n\tjmp *(%bx)\n");
    assert_eq!(t, [0xff, 0x26, 0x34, 0x12, 0xff, 0x27]);
    let t = text_of("jmp-abs-32", "\t.code32\n\tjmp *0x1234\n\tjmp *(%bx)\n");
    assert_eq!(t, [0xff, 0x25, 0x34, 0x12, 0, 0, 0x67, 0xff, 0x27]);
}

const X64: &str = "linux-x64";
const A64: &str = "linux-aarch64";

/// A prologue described by `.cfi_*` and nothing else. Every byte below is
/// GNU as 2.46.1's for the same source: a `zR` CIE carrying the x86-64
/// entry rules, then one FDE whose address field is a PC-relative
/// displacement the link resolves against `.text`.
#[test]
fn cfi_directives_build_the_eh_frame_gnu_as_does() {
    let b = object_for(
        "cfi-eh",
        "\t.text\n\t.globl f\n\t.type f,@function\nf:\n\
         \t.cfi_startproc\n\tpushq\t%rbp\n\t.cfi_adjust_cfa_offset 8\n\
         \t.cfi_rel_offset %rbp, 0\n\tnop\n\tpopq\t%rbp\n\
         \t.cfi_restore %rbp\n\t.cfi_def_cfa %rsp, 8\n\tret\n\
         \t.cfi_endproc\n\t.size f,.-f\n",
        X64,
    );
    assert_eq!(
        section_data(&b, ".eh_frame"),
        [
            0x14, 0, 0, 0, 0, 0, 0, 0, 0x01, 0x7a, 0x52, 0x00, 0x01, 0x78, 0x10, 0x01, 0x1b, 0x0c,
            0x07, 0x08, 0x90, 0x01, 0x00, 0x00, 0x1c, 0, 0, 0, 0x1c, 0, 0, 0, 0, 0, 0, 0, 0x04, 0,
            0, 0, 0x00, 0x41, 0x0e, 0x10, 0x86, 0x02, 0x42, 0xc6, 0x0c, 0x07, 0x08, 0x00, 0, 0, 0,
            0
        ]
    );
    // R_X86_64_PC32 over the FDE's address field, so the table needs no
    // load-time relocation in a shared object.
    assert_eq!(relocs(&b, ".rela.eh_frame"), [(0x20, 2, 0)]);
    assert!(!section_names(&b).iter().any(|n| n == ".debug_frame"));
}

/// `.cfi_sections .debug_frame` moves the same description to the offline
/// table: an all-ones `cie_id`, an absolute address field, and a CIE
/// pointer the link rebases. GNU as 2.46.1's bytes for the same source.
#[test]
fn cfi_sections_moves_the_table_to_debug_frame() {
    let b = object_for(
        "cfi-dbg",
        "\t.text\n\t.globl f\n\t.type f,@function\nf:\n\
         \t.cfi_sections .debug_frame\n\t.cfi_startproc\n\tpushq\t%rbp\n\
         \t.cfi_adjust_cfa_offset 8\n\t.cfi_rel_offset %rbp, 0\n\tnop\n\
         \tpopq\t%rbp\n\t.cfi_restore %rbp\n\t.cfi_def_cfa %rsp, 8\n\tret\n\
         \t.cfi_endproc\n\t.size f,.-f\n",
        X64,
    );
    assert_eq!(
        section_data(&b, ".debug_frame"),
        [
            0x14, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x01, 0x78, 0x10, 0x0c, 0x07, 0x08,
            0x90, 0x01, 0x00, 0x00, 0, 0, 0, 0, 0x24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0x04, 0, 0, 0, 0, 0, 0, 0, 0x41, 0x0e, 0x10, 0x86, 0x02, 0x42, 0xc6, 0x0c, 0x07, 0x08,
            0, 0, 0, 0, 0, 0
        ]
    );
    // The CIE pointer is a 32-bit offset into this section; the address
    // field is a full absolute address.
    assert_eq!(
        relocs(&b, ".rela.debug_frame"),
        [(0x1c, 10, 0), (0x20, 1, 0)]
    );
    assert!(!section_names(&b).iter().any(|n| n == ".eh_frame"));
}

/// `.cfi_signal_frame` marks the CIE in both tables: `zRS` where the
/// augmentation block exists, a bare `S` in `.debug_frame`. An unwinder
/// reads it to take the return address unmodified, which is what lets a
/// walk step out of a signal handler. GNU as 2.46.1's augmentation bytes.
#[test]
fn a_signal_frame_is_marked_in_both_tables() {
    let b = object_for(
        "cfi-sig",
        "\t.text\n\t.globl f\n\t.type f,@function\nf:\n\
         \t.cfi_sections .eh_frame, .debug_frame\n\t.cfi_startproc\n\
         \t.cfi_signal_frame\n\tnop\n\t.cfi_endproc\n\t.size f,.-f\n",
        X64,
    );
    assert_eq!(&section_data(&b, ".eh_frame")[9..13], b"zRS\0");
    assert_eq!(&section_data(&b, ".debug_frame")[9..11], b"S\0");
}

/// The AArch64 PCS puts the entry CFA at `sp` with the return address in
/// x30, and factors code offsets by four. GNU as 2.46.1's bytes.
#[test]
fn an_aarch64_frame_takes_the_pcs_alignment_factors() {
    let b = object_for(
        "cfi-a64",
        "\t.text\n\t.globl f\n\t.type f,%function\nf:\n\t.cfi_startproc\n\
         \tstp\tx29, x30, [sp, #-16]!\n\t.cfi_def_cfa_offset 16\n\
         \t.cfi_offset x29, -16\n\t.cfi_offset x30, -8\n\tnop\n\
         \tldp\tx29, x30, [sp], #16\n\t.cfi_restore x30\n\t.cfi_restore x29\n\
         \t.cfi_def_cfa_offset 0\n\tret\n\t.cfi_endproc\n\t.size f,.-f\n",
        A64,
    );
    assert_eq!(
        section_data(&b, ".eh_frame"),
        [
            0x10, 0, 0, 0, 0, 0, 0, 0, 0x01, 0x7a, 0x52, 0x00, 0x04, 0x78, 0x1e, 0x01, 0x1b, 0x0c,
            0x1f, 0x00, 0x20, 0, 0, 0, 0x18, 0, 0, 0, 0, 0, 0, 0, 0x10, 0, 0, 0, 0x00, 0x41, 0x0e,
            0x10, 0x9d, 0x02, 0x9e, 0x01, 0x42, 0xde, 0xdd, 0x0e, 0x00, 0, 0, 0, 0, 0, 0, 0
        ]
    );
    // R_AARCH64_PREL32 over the FDE's address field.
    assert_eq!(relocs(&b, ".rela.eh_frame"), [(0x1c, 261, 0)]);
}

/// `-m32` narrows the object to i386, whose frame registers are numbered
/// from a different table (`ecx` is 1, the return column 8) and whose data
/// alignment factor is -4. This is the shape the 32-bit vDSO ships, so it
/// is checked against GNU as 2.46.1's bytes for the same source.
#[test]
fn an_i386_frame_takes_the_i386_register_numbering() {
    let d = dir("cfi-i386");
    write(
        &d,
        "u.s",
        "\t.text\n\t.globl f\n\t.type f,@function\nf:\n\t.cfi_startproc\n\
         \tpushl\t%ecx\n\t.cfi_adjust_cfa_offset 4\n\t.cfi_rel_offset ecx, 0\n\
         \tnop\n\tpopl\t%ecx\n\t.cfi_restore ecx\n\t.cfi_adjust_cfa_offset -4\n\
         \tret\n\t.cfi_endproc\n\t.size f,.-f\n",
    );
    run_ok(
        &d,
        &["-q", "-c", "--target=linux-x64", "-m32", "u.s", "-o", "u.o"],
    );
    let b = std::fs::read(d.join("u.o")).unwrap();
    let secs = elf32_sections(&b);
    let eh = secs.iter().find(|s| s.0 == ".eh_frame").expect(".eh_frame");
    assert_eq!(
        &b[eh.2..eh.2 + eh.3],
        [
            0x14, 0, 0, 0, 0, 0, 0, 0, 0x01, 0x7a, 0x52, 0x00, 0x01, 0x7c, 0x08, 0x01, 0x1b, 0x0c,
            0x04, 0x04, 0x88, 0x01, 0x00, 0x00, 0x18, 0, 0, 0, 0x1c, 0, 0, 0, 0, 0, 0, 0, 0x04, 0,
            0, 0, 0x00, 0x41, 0x0e, 0x08, 0x81, 0x02, 0x42, 0xc1, 0x0e, 0x04, 0x00, 0x00
        ]
    );
    // i386 has no RELA: the FDE address is a `SHT_REL` R_386_PC32.
    assert!(secs.iter().any(|s| s.0 == ".rel.eh_frame"));
}

/// `.cfi_val_offset` states a register's value rather than where it was
/// saved, and takes the signed opcode when the factored offset is negative.
/// `.cfi_negate_ra_state` is the AArch64 return-address-signing toggle,
/// which shares its vendor opcode with `DW_CFA_GNU_window_save`. GNU as
/// 2.46.1's bytes.
#[test]
fn val_offset_and_ra_state_take_their_own_opcodes() {
    let b = object_for(
        "cfi-val",
        "\t.text\n\t.globl f\n\t.type f,%function\nf:\n\t.cfi_startproc\n\
         \t.cfi_negate_ra_state\n\tnop\n\t.cfi_val_offset x19, -16\n\tnop\n\
         \t.cfi_val_offset x20, 24\n\tnop\n\t.cfi_endproc\n\t.size f,.-f\n",
        A64,
    );
    assert_eq!(
        section_data(&b, ".eh_frame"),
        [
            0x10, 0, 0, 0, 0, 0, 0, 0, 0x01, 0x7a, 0x52, 0x00, 0x04, 0x78, 0x1e, 0x01, 0x1b, 0x0c,
            0x1f, 0x00, 0x18, 0, 0, 0, 0x18, 0, 0, 0, 0, 0, 0, 0, 0x0c, 0, 0, 0, 0x00, 0x2d, 0x41,
            0x14, 0x13, 0x02, 0x41, 0x15, 0x14, 0x7d, 0x00, 0x00
        ]
    );
}

/// A frame operand is an absolute expression, not a literal: the kernel's
/// signal trampolines spell every saved-register slot as offset arithmetic
/// over a macro argument. Both frames below describe the same state, so
/// the two must encode identically.
#[test]
fn a_frame_operand_may_be_a_constant_expression() {
    let lit = object_for(
        "cfi-lit",
        "\t.text\nf:\n\t.cfi_startproc simple\n\t.cfi_def_cfa %rsp, 12\n\
         \t.cfi_offset %rbx, -24\n\tnop\n\t.cfi_endproc\n",
        X64,
    );
    let expr = object_for(
        "cfi-expr",
        "\t.text\nf:\n\t.cfi_startproc simple\n\t.cfi_def_cfa %rsp, 16 - 4\n\
         \t.cfi_offset %rbx, (0 - 3) * 8\n\tnop\n\t.cfi_endproc\n",
        X64,
    );
    assert_eq!(
        section_data(&lit, ".eh_frame"),
        section_data(&expr, ".eh_frame")
    );
    assert!(!section_data(&lit, ".eh_frame").is_empty());
}

/// A unit with no `.cfi_startproc` gains no frame table, and an unclosed
/// description is an error rather than a truncated one: a consumer trusts
/// the table, so a partial one is worse than none.
#[test]
fn frames_appear_only_for_a_closed_description() {
    let plain = object_for("cfi-none", "\t.text\nf:\n\tnop\n\tret\n", X64);
    assert!(!section_names(&plain).iter().any(|n| n == ".eh_frame"));

    let d = dir("cfi-open");
    write(&d, "u.s", "\t.text\nf:\n\t.cfi_startproc\n\tnop\n");
    let (ok, out) = run(
        &d,
        &["-q", "-c", &format!("--target={X64}"), "u.s", "-o", "u.o"],
    );
    assert!(!ok, "an unclosed frame description must fail: {out}");
    assert!(out.contains("cfi_endproc"), "{out}");
}

/// `(name, st_info, st_shndx)` of every symbol table entry, the unnamed
/// ones included, in table order.
fn sym_entries(bytes: &[u8]) -> Vec<(String, u8, u16)> {
    sym_table(bytes)
        .into_iter()
        .map(|(n, info, shndx, _, _)| (n, info, shndx))
        .collect()
}

/// `(name, sh_type, sh_flags, sh_addralign, sh_entsize)` per section.
fn section_headers(bytes: &[u8]) -> Vec<(String, u32, u64, u64, u64)> {
    let u16at = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32at = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let u64at = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64at(0x28) as usize;
    let (shentsize, shnum, shstrndx) = (u16at(0x3a), u16at(0x3c), u16at(0x3e));
    let names = u64at(shoff + shstrndx * shentsize + 0x18) as usize;
    (0..shnum)
        .map(|i| {
            let sh = shoff + i * shentsize;
            let n = names + u32at(sh) as usize;
            let end = bytes[n..].iter().position(|&b| b == 0).unwrap();
            (
                String::from_utf8(bytes[n..n + end].to_vec()).unwrap(),
                u32at(sh + 4),
                u64at(sh + 8),
                u64at(sh + 0x30),
                u64at(sh + 0x38),
            )
        })
        .collect()
}

const STT_FILE_INFO: u8 = 4; // STB_LOCAL << 4 | STT_FILE
const STT_SECTION_INFO: u8 = 3; // STB_LOCAL << 4 | STT_SECTION

/// A unit with a call, a data reference, and a data definition, per ISA.
const SHAPE_A64: &str = "\t.text\n\t.globl f\n\t.type f, @function\nf:\n\
\tbl ext\n\tadrp x0, v\n\tadd x0, x0, :lo12:v\n\tret\n\
\t.data\n\t.globl v\nv:\n\t.word 7\n";
const SHAPE_X64: &str = "\t.text\n\t.globl f\n\t.type f, @function\nf:\n\
\tcall ext\n\tmovq v(%rip), %rax\n\tret\n\
\t.data\n\t.globl v\nv:\n\t.quad 7\n";

/// A `.s` object carries the GNU as section roster and nothing else: no
/// `.note.badc`, no `.comment`, and no `.debug_*` without `-g`. GNU as
/// 2.46 emits exactly the null section, the three defaults, the used
/// `.rela.text`, and the three table sections for the same source.
#[test]
fn a_dot_s_object_carries_the_gnu_as_section_roster() {
    for (target, src) in [("linux-aarch64", SHAPE_A64), (X64, SHAPE_X64)] {
        let name = format!("roster-{target}");
        let bytes = object_for(&name, src, target);
        let mut names = section_names(&bytes);
        names.sort();
        let mut want: Vec<String> = [
            "",
            ".bss",
            ".data",
            ".rela.text",
            ".shstrtab",
            ".strtab",
            ".symtab",
            ".text",
        ]
        .iter()
        .map(|s| s.to_string())
        .collect();
        want.sort();
        assert_eq!(names, want, "{target}: section roster");
    }
}

/// An STT_FILE symbol appears only for a `.file "name"` directive, named
/// by its operand; GNU as emits none for a unit without one, and the
/// numbered DWARF form (`.file N "name"`) names no symbol either.
#[test]
fn a_file_symbol_appears_only_per_dot_file_directive() {
    let plain = object_for("file-none", SHAPE_A64, "linux-aarch64");
    assert!(
        !sym_entries(&plain).iter().any(|s| s.1 == STT_FILE_INFO),
        "no `.file`, no STT_FILE symbol"
    );

    let named = object_for(
        "file-named",
        "\t.file \"unit.c\"\n\t.text\nf:\n\tret\n",
        "linux-aarch64",
    );
    let files: Vec<_> = sym_entries(&named)
        .into_iter()
        .filter(|s| s.1 == STT_FILE_INFO)
        .collect();
    assert_eq!(
        files,
        vec![(String::from("unit.c"), STT_FILE_INFO, 0xfff1)],
        "`.file \"unit.c\"` names one SHN_ABS file symbol"
    );

    let numbered = object_for(
        "file-numbered",
        "\t.file 1 \"unit.c\"\n\t.text\nf:\n\tret\n",
        "linux-aarch64",
    );
    assert!(
        !sym_entries(&numbered).iter().any(|s| s.1 == STT_FILE_INFO),
        "the numbered `.file` form is line-table input, not a symbol"
    );
}

/// `.ident` strings pool into `.comment` in GNU as shape -- a leading NUL,
/// each string NUL-terminated, SHF_MERGE | SHF_STRINGS with byte entsize.
#[test]
fn ident_strings_pool_into_dot_comment() {
    let bytes = object_for(
        "ident",
        "\t.ident \"one\"\n\t.ident \"two\"\n\t.text\nf:\n\tret\n",
        "linux-aarch64",
    );
    assert_eq!(section_data(&bytes, ".comment"), b"\0one\0two\0");
    let (_, ty, flags, _, entsize) = section_headers(&bytes)
        .into_iter()
        .find(|s| s.0 == ".comment")
        .expect(".comment present");
    assert_eq!(
        (ty, flags, entsize),
        (1, 0x30, 1),
        "PROGBITS, MS, entsize 1"
    );
}

/// A default section the unit leaves empty claims no alignment: GNU as
/// keeps `.text` / `.data` / `.bss` at addralign 1 until content raises it.
#[test]
fn an_empty_default_section_claims_no_alignment() {
    let bytes = object_for(
        "empty-defaults",
        "\t.data\n\t.globl d\nd:\n\t.word 9\n",
        "linux-aarch64",
    );
    for want in [".text", ".bss"] {
        let (_, _, _, align, _) = section_headers(&bytes)
            .into_iter()
            .find(|s| s.0 == want)
            .unwrap_or_else(|| panic!("{want} present"));
        assert_eq!(align, 1, "empty {want} addralign");
    }
}

/// Section symbols follow the GNU as target policy: the x86 backend omits
/// every one no relocation references, the aarch64 backend keeps them all.
#[test]
fn unused_section_symbols_follow_the_target_policy() {
    let count = |bytes: &[u8]| {
        sym_entries(bytes)
            .iter()
            .filter(|s| s.1 == STT_SECTION_INFO)
            .count()
    };

    let x = object_for("secsym-x64", "\t.text\n\t.globl f\nf:\n\tret\n", X64);
    assert_eq!(count(&x), 0, "x86-64: no relocation, no section symbol");

    let x_used = object_for(
        "secsym-x64-used",
        "\t.text\nf:\n\tmovq lv(%rip), %rax\n\tret\n\t.data\nlv:\n\t.quad 1\n",
        X64,
    );
    assert_eq!(
        count(&x_used),
        1,
        "x86-64: only the `.data` a relocation names keeps its symbol"
    );

    let a = object_for(
        "secsym-a64",
        "\t.text\n\t.globl f\nf:\n\tret\n",
        "linux-aarch64",
    );
    assert_eq!(count(&a), 3, "aarch64: the three defaults keep theirs");
}
