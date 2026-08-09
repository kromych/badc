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

#[test]
fn non_64_bit_code_models_are_refused_by_name() {
    let d = dir("m16");
    write(&d, "leaf.s", LEAF);
    for flag in ["-m16", "-m32"] {
        let (ok, text) = run(
            &d,
            &["-q", "-c", &format!("--target={TARGET}"), flag, "leaf.s"],
        );
        assert!(
            !ok,
            "{flag} must be refused rather than assembled as 64-bit"
        );
        assert!(
            text.contains(flag),
            "the diagnostic must name {flag}: {text}"
        );
    }
    // The 64-bit spelling is the one badc emits, and is accepted.
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
