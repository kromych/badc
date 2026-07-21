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
    // VLA fixtures that assert a clean rejection diagnostic rather
    // than compiling; the constructs are unsupported by design (C99
    // 6.7.6.2 corners left as TODO).
    "vla_multidim_rejected.c",
    "vla_file_scope_rejected.c",
    "vla_initializer_rejected.c",
];

/// Fixtures whose body carries inline asm specific to one ISA. The
/// paired target lacks the instruction and rejects the compile by
/// design; the native target still compiles and is checked. (TODO:
/// lower these recognized asm intrinsics on the foreign target so the
/// fixtures compile everywhere.)
const TARGET_SPECIFIC_ASM: &[(&str, &str)] = &[
    ("cacheflush_asm.c", "linux-x64"), // aarch64 cache-ops / barriers
    ("atomic128_ldaxp_stlxp.c", "linux-x64"), // aarch64 128-bit ldaxp/stlxp
    ("atomic128_ldst.c", "linux-x64"), // aarch64 128-bit ldp/stp, ldxp/stxp
    ("inline_asm_a64_dp.c", "linux-x64"), // aarch64 mul/csel (x86 mul is 1-operand)
    ("inline_asm_a64_labels.c", "linux-x64"), // aarch64 local-label branches
    ("inline_asm_a64_barriers.c", "linux-x64"), // aarch64 dmb/dsb/isb/clrex
    ("inline_asm_a64_acqrel.c", "linux-x64"), // aarch64 ldar/stlr via `Q`
    ("inline_asm_a64_llsc.c", "linux-x64"), // aarch64 ldxr/stxr loop via `+Q`
    ("inline_asm_a64_llsc_prfm.c", "linux-x64"), // aarch64 prfm + ldxr/stxr via `+Q`
    ("divq_udiv_qrnnd.c", "linux-aarch64"), // x86-64 128/64 divq
    ("rdtsc_host_ticks.c", "linux-aarch64"), // x86-64 rdtsc
    ("inline_asm_memory_operand.c", "linux-aarch64"), // x86-64 lock cmpxchg/xadd
    ("inline_asm_x64_catalogue.c", "linux-aarch64"), // x86-64 neg/not/xchg/rol/adc
    ("inline_asm_x64_setcc.c", "linux-aarch64"), // x86-64 setcc
    ("inline_asm_x64_cmov.c", "linux-aarch64"), // x86-64 cmovcc
    ("inline_asm_x64_cdqe.c", "linux-aarch64"), // x86-64 cdqe
    ("inline_asm_x64_movnti.c", "linux-aarch64"), // x86-64 movnti/sfence
    ("inline_asm_x64_clflush.c", "linux-aarch64"), // x86-64 clflush/prefetch
    ("inline_asm_x64_setjmp_label.c", "linux-aarch64"), // x86-64 asm context switch
    ("inline_asm_x64_mem_disp.c", "linux-aarch64"), // x86-64 disp(%reg) memory operands
    ("inline_asm_x64_imm_mem.c", "linux-aarch64"), // x86-64 byte/word imm-to-memory ALU
    ("inline_asm_x64_flags_push.c", "linux-aarch64"), // x86-64 pushf/popf and word push/pop
    ("inline_asm_m_operand_array_cast.c", "linux-aarch64"), // x86-64 addq/adcq region operand
    ("inline_asm_x64_const_expr.c", "linux-aarch64"), // x86-64 addq/adcq const-expr displacements
    ("inline_asm_x64_constraint_a.c", "linux-aarch64"), // x86-64 `A` accumulator constraint
    ("register_var_asm_operand.c", "linux-aarch64"), // x86-64 extended-asm operand pinning
    ("register_var_asm_operand_sp.c", "linux-aarch64"), // x86-64 rsp / rbp operand binding
    ("register_var_asm_operand_split.c", "linux-aarch64"), // x86-64 split-literal register name
    ("inline_asm_x64_sib.c", "linux-aarch64"), // x86-64 scaled-index memory operands
    ("cpuid_partial_outputs.c", "linux-aarch64"), // x86-64 cpuid
    ("inline_asm_x64_flag_outputs.c", "linux-aarch64"), // x86-64 `=@cc` flag outputs
    ("inline_asm_x64_string_ops.c", "linux-aarch64"), // x86-64 string primitives / prefixes
    ("inline_asm_a64_comments.c", "linux-x64"), // aarch64 comment syntax
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
    let mut attempts = 0usize;
    let targets = ["linux-aarch64", "linux-x64"];
    for fixture in &entries {
        let name = fixture.file_name().unwrap().to_str().unwrap();
        if COMPILE_SKIPLIST.contains(&name) {
            continue;
        }
        for target in targets {
            if TARGET_SPECIFIC_ASM.contains(&(name, target)) {
                continue;
            }
            attempts += 1;
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
            attempts,
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

// A callee marked `always_inline` / `__forceinline` that the inliner
// cannot substitute (here: a variadic body) draws a diagnostic naming
// the function and the reason, so a silently-unhonored mandatory inline
// request is visible. A body the inliner can substitute stays silent.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn always_inline_not_honored_warns() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-ai-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");

    let compile = |src: &std::path::Path, obj: &str| {
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-O")
            .arg("-c")
            .arg(src)
            .arg("-o")
            .arg(dir.join(obj))
            .output()
            .expect("run badc")
    };

    // Variadic always_inline: the inliner rejects it, so the request is
    // unhonored and must warn.
    let va = dir.join("va.c");
    std::fs::write(
        &va,
        "#include <stdarg.h>\n\
         static inline __attribute__((always_inline)) int s(int n, ...) {\n\
         \tva_list ap; va_start(ap, n); int t = 0;\n\
         \tfor (int i = 0; i < n; i++) t += va_arg(ap, int);\n\
         \tva_end(ap); return t; }\n\
         int main(void) { return s(2, 3, 4); }\n",
    )
    .expect("write va.c");
    let out = compile(&va, "va.o");
    assert!(
        out.status.success(),
        "compile failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        stderr.contains("always_inline") && stderr.contains("`s`"),
        "expected an always_inline diagnostic naming `s`, got: {stderr}"
    );

    // A body the inliner can substitute draws no warning.
    let ok = dir.join("ok.c");
    std::fs::write(
        &ok,
        "static inline __attribute__((always_inline)) int a(int x, int y) { return x + y; }\n\
         int main(void) { return a(2, 3); }\n",
    )
    .expect("write ok.c");
    let out2 = compile(&ok, "ok.o");
    assert!(
        out2.status.success(),
        "compile failed: {}",
        String::from_utf8_lossy(&out2.stderr)
    );
    assert!(
        !String::from_utf8_lossy(&out2.stderr).contains("always_inline"),
        "inlinable always_inline should be silent, got: {}",
        String::from_utf8_lossy(&out2.stderr)
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

// `-O` predefines `NDEBUG=1` and `__OPTIMIZE__=1` (release semantics).
// The predefines land before the CLI `-D` / `-U` lists, so an explicit
// `-D NDEBUG=<v>` keeps the user's value and `-U NDEBUG` removes the
// implied one, re-enabling `assert`.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn optimize_flag_predefines_ndebug() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let manifest = env!("CARGO_MANIFEST_DIR");
    let fixtures = PathBuf::from(manifest)
        .join("tests")
        .join("fixtures")
        .join("c");
    let dir = std::env::temp_dir().join(format!("badc-ndebug-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");

    let run = |tag: &str, flags: &[&str], src: &std::path::Path| -> std::process::ExitStatus {
        let exe = dir.join(tag);
        let mut cmd = Command::new(badc);
        for f in flags {
            cmd.arg(f);
        }
        let out = cmd.arg(src).arg("-o").arg(&exe).output().expect("run badc");
        assert!(
            out.status.success(),
            "compile {tag} failed: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        Command::new(&exe).output().expect("run prog").status
    };

    // Exit codes: both predefines -> NDEBUG's value, exactly one -> 101,
    // neither -> 100 (see the fixture).
    let probe = fixtures.join("ndebug_optimize_predefine.c");
    assert_eq!(run("plain", &[], &probe).code(), Some(100));
    assert_eq!(run("opt", &["-O"], &probe).code(), Some(1));
    assert_eq!(
        run("opt-dval", &["-O", "-DNDEBUG=7"], &probe).code(),
        Some(7)
    );
    assert_eq!(
        run("opt-undef", &["-O", "-UNDEBUG"], &probe).code(),
        Some(101)
    );

    // Under `-O` the assert(0) is compiled out; `-U NDEBUG` re-enables
    // it and the program traps instead of exiting 0.
    let trap = fixtures.join("ndebug_undef_reenables_assert.c");
    assert_eq!(run("assert-off", &["-O"], &trap).code(), Some(0));
    let fired = run("assert-on", &["-O", "-UNDEBUG"], &trap);
    assert!(
        !fired.success(),
        "-U NDEBUG under -O must re-enable assert (got {fired:?})"
    );
    let _ = std::fs::remove_dir_all(&dir);
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
    // ./include or ./libc/include, so the overlay is the only one.
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

// An unrecognised dash-prefixed option must be rejected with a clear
// "unknown option" diagnostic, not silently reinterpreted as a source
// file (which produces a misleading `cannot read` error or, worse,
// compiles a same-named file).
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn unknown_option_is_rejected() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-unkopt-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let src = dir.join("main.c");
    std::fs::write(&src, "int main(void) { return 0; }\n").expect("write main");
    let out = Command::new(badc)
        .arg("-Wall")
        .arg(&src)
        .arg("-o")
        .arg(dir.join("prog"))
        .output()
        .expect("run badc");
    assert!(!out.status.success(), "unknown option must fail the build");
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        stderr.contains("unknown option"),
        "expected an 'unknown option' diagnostic, got: {stderr}"
    );
    // A valid build of the same source still succeeds.
    let ok = Command::new(badc)
        .arg(&src)
        .arg("-o")
        .arg(dir.join("prog2"))
        .output()
        .expect("run badc");
    assert!(ok.status.success(), "valid build must still succeed");
    let _ = std::fs::remove_dir_all(&dir);
}

#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn unrecognized_input_extension_is_rejected() {
    // A compile/link mode must diagnose an unrecognized input extension
    // rather than silently reclassifying it (and every input after it)
    // as the program's argv.
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-unkext-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let a = dir.join("a.c");
    let b = dir.join("b.c");
    let cc = dir.join("foo.cc");
    std::fs::write(&a, "int helper(void); int main(void){ return helper(); }\n").expect("write a");
    std::fs::write(&b, "int helper(void){ return 0; }\n").expect("write b");
    std::fs::write(&cc, "int nope(void){ return 0; }\n").expect("write cc");
    let out = Command::new(badc)
        .arg(&a)
        .arg(&cc)
        .arg(&b)
        .arg("-o")
        .arg(dir.join("prog"))
        .output()
        .expect("run badc");
    assert!(
        !out.status.success(),
        "unrecognized input extension must fail the build"
    );
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        stderr.contains("unrecognized input file extension") && stderr.contains("foo.cc"),
        "expected a diagnostic naming foo.cc, got: {stderr}"
    );
    // Two valid `.c` inputs still link (b.c is not silently dropped in
    // the valid case).
    let ok = Command::new(badc)
        .arg(&a)
        .arg(&b)
        .arg("-o")
        .arg(dir.join("prog2"))
        .output()
        .expect("run badc");
    assert!(
        ok.status.success(),
        "valid multi-input native link must succeed"
    );
    let _ = std::fs::remove_dir_all(&dir);
}

// `--jobs` must not change emitted bytes. A source compiled alone (one
// TU, sequential) and the same source compiled inside a parallel `-c`
// batch produce identical objects, and a parallel batch is stable
// across runs. The reloc byte-stability gate pins per-TU determinism;
// this drives it through the CLI's worker pool.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn jobs_object_bytes_match_sequential_and_are_stable() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = std::env::temp_dir().join(format!("badc-jobs-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&root);
    let srcs: [(&str, &str); 6] = [
        ("a.c", "int a(int x){ return x*x + 1; }"),
        (
            "b.c",
            "long b(long x,long y){ long s=0; for(long i=0;i<y;i++) s+=x; return s; }",
        ),
        ("c.c", "double c(double p,double q){ return p*q - p/q; }"),
        (
            "d.c",
            "int d(int*p,int n){ int s=0; for(int i=0;i<n;i++) s+=p[i]; return s; }",
        ),
        (
            "e.c",
            "struct S{int a;int b;}; int e(struct S s){ return s.a - s.b; }",
        ),
        ("f.c", "float f(float a,float b){ return a<b ? a : b; }"),
    ];
    let seq = root.join("seq");
    let par1 = root.join("par1");
    let par2 = root.join("par2");
    for d in [&seq, &par1, &par2] {
        std::fs::create_dir_all(d).expect("mkdir");
        for (name, body) in &srcs {
            std::fs::write(d.join(name), body).expect("write src");
        }
    }
    let target = "linux-x64";
    // Sequential baseline: each source in its own single-input
    // invocation (one TU -> one worker -> inline, no threads).
    for (name, _) in &srcs {
        let ok = Command::new(badc)
            .arg(format!("--target={target}"))
            .arg("-c")
            .arg(name)
            .current_dir(&seq)
            .status()
            .expect("run badc")
            .success();
        assert!(ok, "sequential compile of {name} failed");
    }
    // Parallel batch: every source in one `-j8 -c` invocation. The same
    // relative labels keep the (debug-info-off) bytes path-independent.
    let run_batch = |dir: &std::path::Path| {
        let mut cmd = Command::new(badc);
        cmd.arg(format!("--target={target}"))
            .arg("-j8")
            .arg("-c")
            .current_dir(dir);
        for (name, _) in &srcs {
            cmd.arg(name);
        }
        assert!(
            cmd.status().expect("run badc").success(),
            "parallel `-j8 -c` batch failed"
        );
    };
    run_batch(&par1);
    run_batch(&par2);
    for (name, _) in &srcs {
        let o = name.replace(".c", ".o");
        let s = std::fs::read(seq.join(&o)).expect("read seq .o");
        let p1 = std::fs::read(par1.join(&o)).expect("read par1 .o");
        let p2 = std::fs::read(par2.join(&o)).expect("read par2 .o");
        assert_eq!(s, p1, "`-j8` object for {name} differs from sequential");
        assert_eq!(p1, p2, "`-j8` object for {name} not stable across runs");
    }
    let _ = std::fs::remove_dir_all(&root);
}
