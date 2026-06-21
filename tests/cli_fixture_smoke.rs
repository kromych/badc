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

// The optimizer has a single level; every `-O<n>` form selects it and
// `-O0` disables it. With an inline candidate present the optimizer
// changes the emitted object, so the byte image distinguishes
// "optimized" from "not". Compile for a fixed target for a
// deterministic image.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn opt_level_flags_map_to_the_single_level() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-optlvl-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let src = dir.join("u.c");
    std::fs::write(
        &src,
        "static int helper(int x) { return x + 1; }\nint f(int v) { return helper(v) * 2; }\n",
    )
    .expect("write source");

    let compile = |tag: &str, flags: &[&str]| -> Vec<u8> {
        let obj = dir.join(format!("u{tag}.o"));
        let mut cmd = Command::new(badc);
        cmd.arg("--target=linux-x64").arg("-c");
        for f in flags {
            cmd.arg(f);
        }
        let out = cmd
            .arg(&src)
            .arg("-o")
            .arg(&obj)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "compile {flags:?} failed: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        std::fs::read(&obj).expect("read object")
    };

    let none = compile("none", &[]);
    let o0 = compile("o0", &["-O0"]);
    let o = compile("o", &["-O"]);
    let o2 = compile("o2", &["-O2"]);
    let o3 = compile("o3", &["-O3"]);
    let os = compile("os", &["-Os"]);
    let _ = std::fs::remove_dir_all(&dir);

    // The optimizer is observable here: the helper inlines under -O.
    assert_ne!(o, none, "-O produced the same object as no optimization");
    // -O0 and no flag both leave the optimizer off.
    assert_eq!(o0, none, "-O0 should match the unoptimized image");
    // Every other level selects the same single optimization level.
    assert_eq!(o2, o, "-O2 should match -O");
    assert_eq!(o3, o, "-O3 should match -O");
    assert_eq!(os, o, "-Os should match -O");
}

// `--install <dir>` writes every embedded header under <dir>/include
// (recreating subdirectories) and the runtime source under <dir>/lib.
#[test]
fn install_writes_header_and_runtime_tree() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-install-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    let out = Command::new(badc)
        .arg("--install")
        .arg(&dir)
        .output()
        .expect("run badc --install");
    assert!(
        out.status.success(),
        "--install failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    // A flat header, a nested header (subdirectory recreated), and the
    // runtime source must all land on disk.
    for rel in ["include/stdio.h", "include/sys/socket.h", "lib/runtime.c"] {
        let p = dir.join(rel);
        assert!(p.is_file(), "missing installed file {}", p.display());
        assert!(
            !std::fs::read_to_string(&p).unwrap().is_empty(),
            "installed file {} is empty",
            p.display()
        );
    }
    let _ = std::fs::remove_dir_all(&dir);
}

// The installed overlay under $BADC_HOME takes precedence over the
// embedded headers and runtime: editing an installed copy changes the
// build without rebuilding badc, and removing the override falls back
// to the embedded copy.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn installed_overlay_overrides_embedded() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-overlay-{}", std::process::id()));
    let home = dir.join("home");
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    // Install the embedded set under `home`.
    let out = Command::new(badc)
        .arg("--install")
        .arg(&home)
        .current_dir(&dir)
        .output()
        .expect("run badc --install");
    assert!(out.status.success(), "--install failed");

    // Stamp a marker into the installed <stdbool.h>; the embedded copy
    // does not define it.
    std::fs::write(
        home.join("include/stdbool.h"),
        "#define bool _Bool\n#define true 1\n#define false 0\n#define BADC_OVERLAY_OK 1\n",
    )
    .expect("overwrite installed stdbool.h");
    std::fs::write(
        dir.join("m.c"),
        "#include <stdbool.h>\nint main(void){ return BADC_OVERLAY_OK ? 0 : 1; }\n",
    )
    .expect("write source");

    // With BADC_HOME set the overlay header is used, so the marker is
    // defined and the program builds and exits 0. The temp cwd has no
    // ./include or ./headers/include, so the overlay is the only one.
    let exe = dir.join("m");
    let built = Command::new(badc)
        .env("BADC_HOME", &home)
        .arg(dir.join("m.c"))
        .arg("-o")
        .arg(&exe)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        built.status.success(),
        "overlay build failed: {}",
        String::from_utf8_lossy(&built.stderr)
    );
    assert_eq!(
        Command::new(&exe).output().expect("run prog").status.code(),
        Some(0),
        "overlay program returned non-zero"
    );

    // Without BADC_HOME the embedded <stdbool.h> (no marker) is used, so
    // the same source fails to compile -- the fallback path.
    let fallback = Command::new(badc)
        .arg(dir.join("m.c"))
        .arg("-o")
        .arg(dir.join("m-fallback"))
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        !fallback.status.success(),
        "expected the embedded stdbool.h (no marker) to fail compilation"
    );

    // A broken installed runtime is compiled in place of the embedded
    // one: a normal program that links the runtime then fails to build,
    // naming the installed runtime.c.
    std::fs::write(home.join("lib/runtime.c"), "this is not valid C @@@\n")
        .expect("overwrite installed runtime.c");
    std::fs::write(dir.join("h.c"), "int main(void){ return 0; }\n").expect("write source");
    let broken = Command::new(badc)
        .env("BADC_HOME", &home)
        .arg(dir.join("h.c"))
        .arg("-o")
        .arg(dir.join("h"))
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        !broken.status.success(),
        "expected the broken installed runtime to fail the build"
    );
    assert!(
        String::from_utf8_lossy(&broken.stderr).contains("runtime.c"),
        "build error should name the installed runtime.c: {}",
        String::from_utf8_lossy(&broken.stderr)
    );

    let _ = std::fs::remove_dir_all(&dir);
}
