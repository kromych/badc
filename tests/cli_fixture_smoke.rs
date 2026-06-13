//! gh #70 -- CLI standalone smoke test.
//!
//! The lib-side fixture tests (`src/c5/tests/native.rs` etc.) all
//! prepend `with_prelude()` (`src/c5/tests/mod.rs:74`) before
//! compiling. That hides whether each fixture compiles when
//! invoked through the badc binary, where the user gets no auto-
//! prelude. Before gh #69 landed, 45 of the 123 fixtures failed
//! standalone with "no `#pragma binding(<dylib>::exit, ...)` is
//! in scope" because their source didn't `#include <stdlib.h>`.
//!
//! This test runs the actual badc binary against every fixture
//! for every supported Linux target and asserts that compilation
//! succeeds. Programs that intentionally crash at runtime
//! (`oob_*`, `double_free.c`, ...) are excluded -- the suite is
//! a *compile-time* smoke check, not a runtime one.

use std::path::PathBuf;
use std::process::Command;

/// Fixtures that exercise the runtime safety net (the VM aborts
/// with -1 on the violation; the native binary smashes memory or
/// hits SIGSEGV instead). They compile fine -- the divergence is
/// at execution time. Skip them rather than treat their compile
/// as a regression target.
const COMPILE_SKIPLIST: &[&str] = &[
    // Pointer-tracking safety-net fixtures.
    "double_free.c",
    "use_after_free.c",
    "forge_code_pointer.c",
    "negative_size_memset.c",
    "code_as_data.c",
    "memset_oob.c",
    "memcpy_oob_dst.c",
    "memcpy_oob_src.c",
    "oob_read.c",
    // mprotect-blocks-* fixtures live under their own runtime
    // tests; their compile path is exercised through the
    // standard fixture pipeline.
    //
    // `_Thread_local`-bearing fixtures. The Linux native-link
    // path (compile -> ET_REL -> link_native_objects -> write_executable_elf64)
    // doesn't carry TLS storage through ET_REL yet, so the
    // codegen's relocatable writer refuses these with a clear
    // link error pointing at the in-memory compile + link path
    // (TODO: thread `.tdata` / `.tbss` plus per-format TLS
    // metadata through the synth pipeline).
    "thread_local_basic.c",
    "thread_local_initializer.c",
    "thread_local_per_thread.c",
    "deferred_jit_thread_local.c",
];

#[test]
fn every_fixture_compiles_standalone_for_linux() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let manifest = env!("CARGO_MANIFEST_DIR");
    let fixtures_dir = PathBuf::from(manifest)
        .join("tests")
        .join("fixtures")
        .join("c");
    let mut entries: Vec<PathBuf> = std::fs::read_dir(&fixtures_dir)
        .expect("read tests/fixtures/c")
        .filter_map(|e| e.ok().map(|e| e.path()))
        .filter(|p| p.extension().and_then(|s| s.to_str()) == Some("c"))
        .collect();
    entries.sort();
    assert!(
        !entries.is_empty(),
        "no fixtures discovered under {}",
        fixtures_dir.display()
    );

    let tmp_root = std::env::temp_dir().join("badc-cli-smoke");
    let _ = std::fs::create_dir_all(&tmp_root);

    let mut failures: Vec<String> = Vec::new();
    let targets = ["linux-aarch64", "linux-x64"];
    for fixture in &entries {
        let name = fixture.file_name().unwrap().to_str().unwrap();
        if COMPILE_SKIPLIST.contains(&name) {
            continue;
        }
        for target in targets {
            let stem = name.trim_end_matches(".c");
            let out = tmp_root.join(format!("{stem}-{target}"));
            let status = Command::new(badc)
                .arg(format!("--target={target}"))
                .arg("-o")
                .arg(&out)
                .arg(fixture)
                .output();
            match status {
                Ok(o) if o.status.success() => {}
                Ok(o) => {
                    let stderr = String::from_utf8_lossy(&o.stderr);
                    failures.push(format!(
                        "[{target}] {name}: exit {} -- {}",
                        o.status.code().unwrap_or(-1),
                        stderr.lines().next().unwrap_or("(no stderr)").trim()
                    ));
                }
                Err(e) => failures.push(format!("[{target}] {name}: spawn failed: {e}")),
            }
        }
    }

    if !failures.is_empty() {
        panic!(
            "{} of {} fixture-compilation attempts failed:\n  {}",
            failures.len(),
            (entries.len() - COMPILE_SKIPLIST.len()) * targets.len(),
            failures.join("\n  ")
        );
    }
}

// A quoted `#include "header"` resolves against the directory of the
// including file, not the process working directory (C99 6.10.2p2).
// Compiling `sub/main.c` from the parent directory must still find
// `sub/helper.h`; a CWD-relative-only search would miss it.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn quoted_include_resolves_relative_to_including_file() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-qinc-{}", std::process::id()));
    let sub = dir.join("sub");
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&sub).expect("create temp dir");
    std::fs::write(sub.join("helper.h"), "int helper(void) { return 42; }\n")
        .expect("write header");
    std::fs::write(
        sub.join("main.c"),
        "#include \"helper.h\"\nint main(void) { return helper(); }\n",
    )
    .expect("write main");
    let exe = dir.join("prog");
    let out = Command::new(badc)
        .arg(sub.join("main.c"))
        .arg("-o")
        .arg(&exe)
        .current_dir(&dir) // CWD is the parent, not sub/.
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "compile failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let run = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        run.status.code(),
        Some(42),
        "quoted-include program returned wrong value"
    );
    let _ = std::fs::remove_dir_all(&dir);
}
