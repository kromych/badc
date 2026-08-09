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
    write(
        &d,
        "bad.s",
        "\t.text\n\t.reloc 0, R_X86_64_NONE, foo\n\tnop\n",
    );
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
        text.contains(".reloc"),
        "the diagnostic must name the construct: {text}"
    );
    assert!(!d.join("bad.o").exists(), "no object on a failed unit");
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

/// A `.code16` branch to a label in the same section resolves at
/// assembly time at the 2-byte field's width, leaving no relocation.
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
        [
            0x90, 0xe9, 0xfc, 0xff, 0x90, 0xe9, 0x01, 0x00, 0x90, 0x90, 0x0f, 0x84, 0xf2, 0xff
        ],
        "16-bit near-branch displacements"
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

/// badc generates no i386 machine code, so `-m16` / `-m32` reach the
/// assembler only; a C source under either is refused by name.
#[test]
fn a_c_source_under_m32_is_refused_by_name() {
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
