//! End-to-end DWARF-validation tests: compile a fixture with badc,
//! drop the Mach-O binary into a temp dir, then run `lldb --batch`
//! against it and assert the type-tree output matches the expected
//! shape. Cover per-c5-tag base-type DIEs, pointer-type chains,
//! struct DIEs with member offsets, and the multi-TU line-program
//! file table against regressions.
//!
//! Gated to macOS for the same reason `native.rs` is: the produced
//! binary is a Mach-O the host loader will accept. lldb has to be
//! on `PATH`; if it isn't, the tests skip with a printed note rather
//! than fail.

#![cfg(target_os = "macos")]

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;

use crate::{CompileOptions, Compiler, Target};

/// Compile the inline source with the standard prelude and write
/// an ad-hoc-signed Mach-O into a unique temp file. The path is
/// returned so callers can hand it to lldb; the caller is
/// responsible for cleanup (best-effort `remove_file` at the
/// bottom of each test).
fn build_signed_mach_o(src: &str, stem: &str) -> PathBuf {
    let mut program = Compiler::new(super::with_prelude(src))
        .compile()
        .unwrap_or_else(|e| panic!("compile failed for {stem}: {e}"));
    // Set source_path so the CU's DW_AT_name is a real string
    // rather than `<unknown>`; lldb prefers a non-empty CU name
    // when listing types.
    program.source_path = format!("{stem}.c");
    let bytes = crate::emit_native_with_options(
        &program,
        Target::MacOSAarch64,
        crate::NativeOptions::new().with_debug_info(true),
    )
    .unwrap_or_else(|e| panic!("emit_native_with_options failed for {stem}: {e}"));

    let path = std::env::temp_dir().join(format!("badc-dwarf-{stem}.bin"));
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
    }
    use std::os::unix::fs::PermissionsExt;
    let mut perms = std::fs::metadata(&path).unwrap().permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(&path, perms).unwrap();
    let status = Command::new("/usr/bin/codesign")
        .args(["--sign", "-", "--force"])
        .arg(&path)
        .status()
        .expect("codesign not available");
    assert!(status.success(), "codesign failed for {path:?}");
    path
}

/// Run `lldb --batch -o '<cmd>' ... <path>` and return its stdout.
/// `None` when lldb is missing on PATH (the test should `return`
/// rather than fail in that case so CI lanes without the
/// developer-tools install still run green).
fn lldb_batch(path: &Path, commands: &[&str]) -> Option<String> {
    let mut cmd = Command::new("lldb");
    cmd.arg("--batch");
    for c in commands {
        cmd.arg("-o").arg(c);
    }
    cmd.arg(path);
    let out = match cmd.output() {
        Ok(o) => o,
        Err(_) => return None,
    };
    Some(String::from_utf8_lossy(&out.stdout).into_owned())
}

/// Run `dwarfdump --debug-info <path>` and return its stdout.
/// Used for tests that need to inspect DIE shape directly --
/// pointer / array types have no `DW_AT_name`, so lldb's
/// `image lookup -t` can't always reach them. `None` when
/// dwarfdump is missing on PATH.
fn dwarfdump_debug_info(path: &Path) -> Option<String> {
    let out = Command::new("dwarfdump")
        .arg("--debug-info")
        .arg(path)
        .output()
        .ok()?;
    Some(String::from_utf8_lossy(&out.stdout).into_owned())
}

/// Run `dwarfdump --debug-line <path>` and return its stdout.
/// Used to inspect the line program directly -- specifically, to
/// confirm a multi-TU link produced one file-table entry per
/// translation-unit `.c` file and that the line program references
/// each one. `None` when dwarfdump is missing on PATH.
fn dwarfdump_debug_line(path: &Path) -> Option<String> {
    let out = Command::new("dwarfdump")
        .arg("--debug-line")
        .arg(path)
        .output()
        .ok()?;
    Some(String::from_utf8_lossy(&out.stdout).into_owned())
}

/// Run `dwarfdump --debug-frame <path>` to inspect the CFI
/// section directly. CFI lives outside `.debug_info` -- it has
/// its own `.debug_frame` (ELF / Mach-O `__debug_frame`)
/// section -- so the type-tree dumper above can't see it.
fn dwarfdump_debug_frame(path: &Path) -> Option<String> {
    let out = Command::new("dwarfdump")
        .arg("--debug-frame")
        .arg(path)
        .output()
        .ok()?;
    Some(String::from_utf8_lossy(&out.stdout).into_owned())
}

#[test]
fn lldb_resolves_distinct_base_types() {
    let path = build_signed_mach_o(
        r#"
        int main() {
            char c; unsigned char uc; short s; unsigned short us;
            int i; unsigned int ui;
            long l; unsigned long ul;
            long long ll; unsigned long long ull;
            float f; double d;
            c = 1; uc = 2; s = 3; us = 4; i = 5; ui = 6;
            l = 7; ul = 8; ll = 9; ull = 10;
            f = 11.5; d = 12.5;
            return c + uc + s + us + i + (int)ui + (int)l + (int)ul
                 + (int)ll + (int)ull + (int)f + (int)d;
        }
        "#,
        "base_types",
    );
    let Some(out) = lldb_batch(
        &path,
        &[
            "image lookup -t int",
            "image lookup -t double",
            "image lookup -t \"long long\"",
            "image lookup -t \"unsigned int\"",
        ],
    ) else {
        eprintln!("lldb not on PATH -- skipping base-type DWARF smoke test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // Each lookup should report a real type, not "0 matches found".
    for needle in [
        "byte-size = 4", // int
        "byte-size = 8", // double / long long
        "long long",     // explicit name match
        "unsigned int",  // signedness rendering
    ] {
        assert!(
            out.contains(needle),
            "lldb output missing `{needle}`:\n{out}"
        );
    }
    let _ = std::fs::remove_file(&path);
}

#[test]
fn dwarfdump_emits_pointer_chains() {
    // `DW_TAG_pointer_type` DIEs carry no `DW_AT_name`, so
    // lldb's `image lookup -t` can't address them by spelling
    // (`int *` looks up the type-tree leaf, not the pointer
    // wrapper). Read the chain straight out of `.debug_info`
    // via `dwarfdump` so the assertions pin down the actual
    // bytes the emitter produced.
    let path = build_signed_mach_o(
        r#"
        int main(int argc, char **argv) {
            int i = 0; int *pi = &i; int **ppi = &pi;
            // Touch every level so the optimizer can't drop them.
            **ppi = 1;
            return argc + i + (int)(long)pi + (int)(long)ppi + (int)(long)argv;
        }
        "#,
        "pointer_chains",
    );
    let Some(out) = dwarfdump_debug_info(&path) else {
        eprintln!("dwarfdump not on PATH -- skipping pointer-chain DWARF smoke test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // Pre-1B output had every pointer-typed local routing through
    // a single `void *` base DIE, so the dump contained no
    // `DW_TAG_pointer_type` at all. After 1B every (leaf, depth)
    // gets its own DIE; dwarfdump prints the resolved chain in
    // the `DW_AT_type` line as `"int *"`, `"int **"`, etc.
    let n_pointer_dies = out.matches("DW_TAG_pointer_type").count();
    assert!(
        n_pointer_dies >= 2,
        "expected at least two DW_TAG_pointer_type DIEs (int* and int**), got {n_pointer_dies}:\n{out}"
    );
    assert!(
        out.contains("\"int *\""),
        "expected dwarfdump to render `int *` somewhere in:\n{out}"
    );
    assert!(
        out.contains("\"int **\""),
        "expected dwarfdump to render `int **` somewhere in:\n{out}"
    );
    let _ = std::fs::remove_file(&path);
}

#[test]
fn lldb_resolves_struct_with_member_offsets() {
    let path = build_signed_mach_o(
        r#"
        struct Point { int x; int y; };
        int main() {
            struct Point p;
            p.x = 1; p.y = 2;
            return p.x + p.y;
        }
        "#,
        "struct_basic",
    );
    let Some(out) = lldb_batch(&path, &["image lookup -t Point"]) else {
        eprintln!("lldb not on PATH -- skipping struct DWARF smoke test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    assert!(
        out.contains("byte-size = 8"),
        "expected `byte-size = 8` in:\n{out}"
    );
    assert!(out.contains("int x"), "expected `int x` member in:\n{out}");
    assert!(out.contains("int y"), "expected `int y` member in:\n{out}");
    let _ = std::fs::remove_file(&path);
}

#[test]
fn lldb_resolves_recursive_struct_pointer() {
    let path = build_signed_mach_o(
        r#"
        struct Node { int value; struct Node *next; struct Node *prev; };
        int main() {
            struct Node n;
            n.value = 7; n.next = 0; n.prev = 0;
            return n.value;
        }
        "#,
        "struct_recursive",
    );
    let Some(out) = lldb_batch(&path, &["image lookup -t Node"]) else {
        eprintln!("lldb not on PATH -- skipping recursive struct DWARF smoke test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // The catalog's transitive expansion should pull `struct Node *`
    // into the chain and the layout pass should resolve it even
    // though `Node` references itself. Pre-1C output had this
    // routing through `void *`.
    assert!(
        out.contains("Node *next"),
        "expected `Node *next` in:\n{out}"
    );
    assert!(
        out.contains("Node *prev"),
        "expected `Node *prev` in:\n{out}"
    );
    let _ = std::fs::remove_file(&path);
}

#[test]
fn lldb_resolves_union_with_overlapping_fields() {
    let path = build_signed_mach_o(
        r#"
        union Variant {
            int as_int;
            double as_double;
        };
        int main() {
            union Variant v;
            v.as_int = 42;
            return v.as_int;
        }
        "#,
        "union_basic",
    );
    let Some(out) = lldb_batch(&path, &["image lookup -t Variant"]) else {
        eprintln!("lldb not on PATH -- skipping union DWARF smoke test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // lldb renders a `DW_TAG_union_type` as `union Variant { ... }`
    // whose fields all sit at offset 0; if we'd routed unions to
    // the structure_type abbrev, the test would see two distinct
    // offsets instead.
    assert!(
        out.contains("union Variant"),
        "expected `union Variant` rendering in:\n{out}"
    );
    let _ = std::fs::remove_file(&path);
}

#[test]
fn dwarfdump_emits_cfi_with_post_prologue_rules() {
    // Verify the CFI section: a CIE describing c5's standard
    // prologue plus one FDE per user function. Without it the
    // unwinder falls back to prologue heuristics, which break
    // under -O / restructured frames.
    let path = build_signed_mach_o(
        r#"
        int helper(int x) { return x + 1; }
        int main() { return helper(41); }
        "#,
        "cfi_basic",
    );
    let Some(out) = dwarfdump_debug_frame(&path) else {
        eprintln!("dwarfdump not on PATH -- skipping CFI smoke test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // CIE assertions: c5's prologue convention on aarch64 has
    // CFA = WSP at function entry, code_alignment_factor 4
    // (instructions are 4 bytes), data_alignment_factor -8
    // (8-byte saved-register slots), return-address register x30.
    assert!(
        out.contains("Code alignment factor: 4"),
        "CIE missing aarch64 code_alignment_factor:\n{out}"
    );
    assert!(
        out.contains("Data alignment factor: -8"),
        "CIE missing data_alignment_factor:\n{out}"
    );
    assert!(
        out.contains("Return address column: 30"),
        "CIE missing aarch64 return-address column:\n{out}"
    );
    assert!(
        out.contains("CFA=WSP"),
        "CIE entry-state CFA rule missing:\n{out}"
    );
    // Each user function (we have helper + main, plus libc
    // trampolines) gets an FDE. After the prologue's
    // `DW_CFA_advance_loc`, the rules switch to fp-based.
    assert!(
        out.contains("DW_CFA_advance_loc"),
        "FDE didn't advance past the prologue:\n{out}"
    );
    assert!(
        out.contains("CFA=W29+16"),
        "post-prologue CFA = x29 + 16 rule missing:\n{out}"
    );
    assert!(
        out.contains("W29=[CFA-16]"),
        "x29 saved at CFA-16 rule missing:\n{out}"
    );
    assert!(
        out.contains("W30=[CFA-8]"),
        "x30 saved at CFA-8 rule missing:\n{out}"
    );
    let _ = std::fs::remove_file(&path);
}

#[test]
fn lldb_resolves_bitfield_widths() {
    let path = build_signed_mach_o(
        r#"
        struct Bits {
            unsigned int width: 5;
            unsigned int height: 6;
            unsigned int rest: 21;
        };
        int main() {
            struct Bits b;
            b.width = 1; b.height = 2; b.rest = 3;
            return b.width + b.height + b.rest;
        }
        "#,
        "struct_bitfield",
    );
    let Some(out) = lldb_batch(&path, &["image lookup -t Bits"]) else {
        eprintln!("lldb not on PATH -- skipping bitfield DWARF smoke test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // lldb prints bitfield widths as `<name> : <bits>`. The
    // emitter converts c5's LSB-relative `bit_offset` to DWARF
    // v3-style MSB-relative `DW_AT_bit_offset` so a wrong sign on
    // that math would yield negative widths or swap field
    // positions.
    for needle in ["width : 5", "height : 6", "rest : 21"] {
        assert!(out.contains(needle), "expected `{needle}` in:\n{out}");
    }
    let _ = std::fs::remove_file(&path);
}

/// Compile two inline TUs with distinct source labels to ET_REL,
/// link them through the native path, and write an ad-hoc-signed
/// Mach-O. The distinct source labels propagate through the
/// preprocessor into each object's `.debug_*`; after
/// `link_native_objects` merges them, the DWARF line program places
/// one file-table entry per TU. The embedded runtime is linked in
/// too so the image launches under lldb.
fn build_signed_mach_o_two_units(
    src_a: &str,
    label_a: &str,
    src_b: &str,
    label_b: &str,
    stem: &str,
) -> PathBuf {
    let target = Target::MacOSAarch64;
    let mut reloc_opts = crate::NativeOptions::new().with_debug_info(true);
    reloc_opts.output_kind = crate::OutputKind::Relocatable;
    let compile_rel = |src: String, label: &str| -> crate::NativeObject {
        let program = Compiler::with_options(
            super::with_prelude(&src),
            target,
            CompileOptions::default()
                .with_source_label(label)
                .with_no_entry_point(true),
        )
        .compile()
        .unwrap_or_else(|e| panic!("compile failed for {label}: {e}"));
        let bytes = crate::emit_native_with_options(&program, target, reloc_opts)
            .unwrap_or_else(|e| panic!("emit_native_with_options failed for {label}: {e}"));
        crate::parse_native_elf(&bytes)
            .unwrap_or_else(|e| panic!("parse_native_elf failed for {label}: {e}"))
    };
    let mut objs = alloc::vec![
        compile_rel(src_a.to_string(), label_a),
        compile_rel(src_b.to_string(), label_b),
    ];
    for (rt_name, rt_body) in crate::embedded_runtime() {
        objs.push(compile_rel(rt_body.to_string(), rt_name));
    }
    let mut merged = crate::link_native_objects(&objs)
        .unwrap_or_else(|e| panic!("link_native_objects failed: {e}"));
    let plt = crate::emit_aarch64_plt(&mut merged)
        .unwrap_or_else(|e| panic!("emit_aarch64_plt failed: {e}"));
    let bytes = crate::write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        crate::OutputKind::Executable,
        target,
    )
    .unwrap_or_else(|e| panic!("write_native_image_from_merged failed for {stem}: {e}"));

    let path = std::env::temp_dir().join(format!("badc-dwarf-{stem}.bin"));
    {
        let mut f = std::fs::File::create(&path).expect("create temp file");
        f.write_all(&bytes).expect("write temp file");
    }
    use std::os::unix::fs::PermissionsExt;
    let mut perms = std::fs::metadata(&path).unwrap().permissions();
    perms.set_mode(perms.mode() | 0o111);
    std::fs::set_permissions(&path, perms).unwrap();
    let status = Command::new("/usr/bin/codesign")
        .args(["--sign", "-", "--force"])
        .arg(&path)
        .status()
        .expect("codesign not available");
    assert!(status.success(), "codesign failed for {path:?}");
    path
}

#[test]
fn multi_tu_dwarf_line_table_carries_both_files() {
    // The DWARF line program must attribute each PC back to the
    // `.c` file it came from across translation units. The
    // emitter walks `program.source_files` (skipping the lexer's
    // `<source>` placeholder) and assigns one DWARF file number
    // per entry; line-program rows reach the right file via
    // `DW_LNS_SET_FILE` through `program.source_file_indices`.
    // If the linker's source-table merge or the file-index remap
    // regresses, the file table loses one TU or every PC
    // attributes back to file 1.
    let path = build_signed_mach_o_two_units(
        // TU A: a helper that does a couple of statements so its
        // body has more than one line-program row.
        r#"
        int helper(int x) {
            int y;
            y = x + 1;
            y = y * 2;
            return y;
        }
        "#,
        "tu_helper.c",
        // TU B: main calls helper through an extern.
        r#"
        extern int helper(int x);
        int main() {
            int r;
            r = helper(20);
            return r;
        }
        "#,
        "tu_main.c",
        "multi_tu_lines",
    );
    let Some(out) = dwarfdump_debug_line(&path) else {
        eprintln!("dwarfdump not on PATH -- skipping multi-TU DWARF line-table test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // Both TUs should appear as file-table entries. dwarfdump renders
    // each file row containing the file name as a quoted string.
    assert!(
        out.contains("tu_main.c"),
        "expected `tu_main.c` in dwarfdump --debug-line output:\n{out}"
    );
    assert!(
        out.contains("tu_helper.c"),
        "expected `tu_helper.c` in dwarfdump --debug-line output:\n{out}"
    );
    // dwarfdump prints the file_names table with `file_names[<n>]`.
    // At least two entries (one per TU) should be present beyond the
    // sentinel; dwarfdump uses 1-based numbering and a buggy single-
    // file emit would print only one row.
    let n_file_rows = out.matches("file_names[").count();
    assert!(
        n_file_rows >= 2,
        "expected at least two file_names rows in line program, got {n_file_rows}:\n{out}"
    );
    let _ = std::fs::remove_file(&path);
}

#[test]
fn multi_tu_lldb_step_crosses_translation_unit_boundary() {
    // Scripted lldb step test: run to `main`, step into `helper`
    // (defined in a different TU), and verify lldb resolves the
    // PC to the helper's source file. Catches any drift where the
    // multi-TU line-program either drops the file change or
    // produces unsteppable rows (PC ranges that don't cover the
    // call site, line=0 stop reasons, etc.).
    let path = build_signed_mach_o_two_units(
        r#"
        int helper(int x) {
            int y;
            y = x + 1;
            y = y * 2;
            return y;
        }
        "#,
        "tu_helper.c",
        r#"
        extern int helper(int x);
        int main() {
            int r;
            r = helper(20);
            return r;
        }
        "#,
        "tu_main.c",
        "multi_tu_step",
    );
    // `b helper` sets a breakpoint on the helper symbol. `run`
    // launches; the first `stop reason = breakpoint` row carries
    // the file name lldb resolved through the DWARF line program.
    let Some(out) = lldb_batch(
        &path,
        &["breakpoint set --name helper", "run", "frame info", "quit"],
    ) else {
        eprintln!("lldb not on PATH -- skipping multi-TU lldb step test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // lldb's `frame info` prints something like
    //   frame #0: 0x... `helper(x=20) at tu_helper.c:3
    // when DWARF resolved the PC to the right source file. If the
    // linker had collapsed both TUs onto a single file entry, the
    // resolution would say `tu_main.c` instead.
    assert!(
        out.contains("helper"),
        "expected lldb to stop in `helper`:\n{out}"
    );
    assert!(
        out.contains("tu_helper.c"),
        "expected lldb to attribute helper's PC to `tu_helper.c`:\n{out}"
    );
    let _ = std::fs::remove_file(&path);
}

#[test]
fn lldb_backtrace_has_no_duplicate_caller_frame() {
    // A function's `.debug_frame` FDE must mark `DW_CFA_advance_loc`
    // at the real post-prologue offset. When the post-prologue marker
    // is stored per-`ent_pc` (not in a shared `pc_to_native` slot that
    // a neighbouring small function's PC can alias), a tiny callee's
    // FDE describes its body as established-frame. If it regresses to
    // a too-late prologue-end, the unwinder reads the return address
    // from the live link register inside the callee and synthesises a
    // phantom duplicate of the caller frame.
    let path = build_signed_mach_o_two_units(
        r#"
        int helper(void) {
            int a = 1;
            return a;
        }
        "#,
        "tu_helper.c",
        r#"
        extern int helper(void);
        int main(void) {
            return helper();
        }
        "#,
        "tu_main.c",
        "no_dup_frame",
    );
    let Some(out) = lldb_batch(
        &path,
        &["breakpoint set --name helper", "run", "bt", "quit"],
    ) else {
        eprintln!("lldb not on PATH -- skipping duplicate-frame backtrace test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    let _ = std::fs::remove_file(&path);
    // Each `bt` frame prints `<image>`<symbol> at <file>`. `main` is
    // called once, so exactly one frame should resolve to it; the
    // duplicate-frame bug printed two `\`main at` rows at the same PC.
    let main_frames = out.matches("`main at").count();
    assert_eq!(
        main_frames, 1,
        "expected exactly one `main` frame in the backtrace, got {main_frames}:\n{out}"
    );
}

/// Per-statement granularity in the line program: a function with
/// N straight-line statements must produce at least N distinct
/// `(addr, line)` rows so a debugger can stop on each one. Before
/// the SSA emit started recording per-`Inst` source positions, the
/// walker-driven path produced exactly one row per function and
/// `lldb step` walked straight out of the body in one go.
#[test]
fn debug_line_has_per_statement_rows() {
    let path = build_signed_mach_o(
        r#"
        int main(void) {
            int a;
            int b;
            int c;
            int d;
            a = 1;
            b = 2;
            c = 3;
            d = 4;
            return a + b + c + d;
        }
        "#,
        "per_stmt_rows",
    );
    let Some(out) = dwarfdump_debug_line(&path) else {
        eprintln!("dwarfdump not on PATH -- skipping per-statement row test");
        let _ = std::fs::remove_file(&path);
        return;
    };
    // The exact line numbers in the output depend on the prelude's
    // length, so count distinct source-line values appearing in
    // line-program rows instead of asserting against absolute
    // numbers. A function with 5 user-visible statements (4
    // assignments + return) needs at least 5 distinct lines.
    let mut distinct: alloc::collections::BTreeSet<u32> = alloc::collections::BTreeSet::new();
    for line in out.lines() {
        let parts: alloc::vec::Vec<&str> = line.split_whitespace().collect();
        // dwarfdump rows start with the address column (0x...).
        if parts.len() < 2 || !parts[0].starts_with("0x") {
            continue;
        }
        if let Ok(line_no) = parts[1].parse::<u32>()
            && line_no > 0
        {
            distinct.insert(line_no);
        }
    }
    assert!(
        distinct.len() >= 5,
        "expected at least 5 distinct line-program rows (one per statement), got {}:\n{out}",
        distinct.len(),
    );
    let _ = std::fs::remove_file(&path);
}
