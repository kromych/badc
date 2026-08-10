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
    assert!(
        names.iter().filter(|n| *n == ".text").count() >= 1,
        "assembled `.text` missing: {names:?}"
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

#[test]
fn assembler_options_are_checked_rather_than_passed_on() {
    let d = dir("wa");
    write(&d, "leaf.s", LEAF);
    // The two options the kernel's assembly units carry.
    run_ok(
        &d,
        &[
            "-q",
            "-c",
            &format!("--target={TARGET}"),
            "-Wa,--fatal-warnings",
            "-Wa,-mrelax-relocations=no",
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
    let (ok, text) = run(
        &d,
        &["-q", "-c", &format!("--target={TARGET}"), "-m32", "u.c"],
    );
    assert!(!ok, "a C source under -m32 must be refused");
    assert!(
        text.contains("-m32") && text.contains("u.c"),
        "the diagnostic must name the flag and the source: {text}"
    );
    write(&d, "leaf.s", LEAF);
    let (ok, text) = run(
        &d,
        &[
            "-q",
            &format!("--target={TARGET}"),
            "-m32",
            "leaf.s",
            "-o",
            "prog",
        ],
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
        if &bytes[n..n + end] == want.as_bytes() && size != 0 {
            let off = u64at(sh + 0x18);
            return bytes[off..off + size].to_vec();
        }
    }
    Vec::new()
}

/// Assemble `src` for x86_64 and return its `.text`.
fn text_of(name: &str, src: &str) -> Vec<u8> {
    let d = dir(name);
    write(&d, "b.s", src);
    run_ok(&d, &["-q", "-c", "--target=linux-x64", "b.s", "-o", "b.o"]);
    section64(&std::fs::read(d.join("b.o")).expect("object"), ".text")
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
/// keep a relocation, which the link fills at the long form's width.
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
    // A global definition in the same section is resolved in place, as GNU
    // as resolves it, so it does relax.
    let t = text_of(
        "relax-glob",
        "\t.text\n\t.globl g\nf:\n\tjmp g\n\tnop\ng:\n\tnop\n",
    );
    assert_eq!(&t[..2], [0xeb, 0x01], "global target in this section");
}

/// `call` has no `rel8` form, so it keeps `e8 rel32` at any distance.
#[test]
fn a_near_call_is_not_shortened() {
    let t = text_of("relax-call", "\t.text\nf:\n\tcall 1f\n1:\n\tnop\n");
    assert_eq!(&t[..5], [0xe8, 0, 0, 0, 0], "call keeps rel32");
}
