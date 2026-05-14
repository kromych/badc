//! End-to-end DWARF-validation tests: compile a fixture with badc,
//! drop the Mach-O binary into a temp dir, then run `lldb --batch`
//! against it and assert the type-tree output matches the expected
//! shape. Anchors gh #57 (per-c5-tag base type DIEs), gh #58
//! (pointer chains), and gh #59 (struct DIEs with member offsets)
//! against regressions.
//!
//! Gated to macOS for the same reason `native.rs` is: the produced
//! binary is a Mach-O the host loader will accept. lldb has to be
//! on `PATH`; if it isn't, the tests skip with a printed note rather
//! than fail.

#![cfg(target_os = "macos")]

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::Command;

use crate::{CompileOptions, Compiler, LinkOptions, Target, emit_native, link_units};

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
    let bytes = emit_native(&program, Target::MacOSAarch64)
        .unwrap_or_else(|e| panic!("emit_native failed for {stem}: {e}"));

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
    // gh #47: emit a CIE describing c5's standard prologue, plus
    // an FDE per user function. Previously the section didn't
    // exist and the unwinder fell back to prologue heuristics
    // (fragile under -O / restructured frames). Verify the
    // expected CFI rules land in `__debug_frame`.
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

/// Compile two inline TUs with distinct source labels, link them
/// through `link_units`, and write an ad-hoc-signed Mach-O. The
/// distinct source labels propagate through the preprocessor into
/// each unit's `source_files[0]`; after the linker merges them, the
/// resulting `program.source_files` carries both names and the
/// DWARF line-program emitter places one file-table entry per TU.
fn build_signed_mach_o_two_units(
    src_a: &str,
    label_a: &str,
    src_b: &str,
    label_b: &str,
    stem: &str,
) -> PathBuf {
    let unit_a = Compiler::with_options(
        super::with_prelude(src_a),
        Target::MacOSAarch64,
        CompileOptions::default().with_source_label(label_a),
    )
    .compile_to_link_unit()
    .unwrap_or_else(|e| panic!("compile_to_link_unit failed for {label_a}: {e}"));
    let unit_b = Compiler::with_options(
        super::with_prelude(src_b),
        Target::MacOSAarch64,
        CompileOptions::default().with_source_label(label_b),
    )
    .compile_to_link_unit()
    .unwrap_or_else(|e| panic!("compile_to_link_unit failed for {label_b}: {e}"));
    let mut unit_a = unit_a;
    let mut unit_b = unit_b;
    unit_a.source_path = label_a.to_string();
    unit_b.source_path = label_b.to_string();
    // `main`-bearing unit first so link_units anchors the entry on it.
    let mut program = link_units(alloc::vec![unit_b, unit_a], &[], LinkOptions::default())
        .unwrap_or_else(|e| panic!("link_units failed: {e}"));
    if program.source_path.is_empty() {
        program.source_path = label_b.to_string();
    }
    let bytes = emit_native(&program, Target::MacOSAarch64)
        .unwrap_or_else(|e| panic!("emit_native failed for {stem}: {e}"));

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
    // gh #88-shape regression: after the cross-TU linker landed, the
    // DWARF line program must continue to attribute each PC back to
    // the `.c` file it came from. The DWARF emitter walks
    // `program.source_files` (skipping the lexer's `<source>`
    // placeholder) and assigns one DWARF file number per entry; the
    // line-program rows reach the right file via `DW_LNS_SET_FILE`
    // through `program.source_file_indices`. If the linker's source-
    // table merge or the file-index remap regresses, the file table
    // would either lose one of the TUs or every PC would attribute
    // back to file 1.
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
