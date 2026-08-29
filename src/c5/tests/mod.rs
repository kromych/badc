//! Test suite split by phase.
//!
//! - [`lexer`]    -- drives `Lexer::next` directly and inspects the token stream.
//! - [`parser`]   -- feeds malformed C to the compiler and asserts on errors.
//! - [`codegen`]  -- compiles valid C and inspects post-link program metadata.
//! - [`programs`] -- end-to-end: load a `.c` fixture, compile, run, assert exit code.
//!
//! Tests that contain meaningful C source load it from `tests/fixtures/c/<name>.c`
//! via [`load_fixture`] / [`run_fixture`] / [`compile_fixture`]. Lexer- and
//! parser-error tests use small inline strings since the snippets are tiny
//! and tightly coupled to the assertion.

use std::path::PathBuf;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::{Condvar, Mutex, OnceLock};

use super::lexer::{self as lex_helpers, Lexer};
use super::symbol::Symbol;
use super::token::{Tok, Token};
use super::{C5Error, Compiler, Program, Vm};

// These modules emit / link native images (via `emit_native*` and the
// `link_*` helpers below), which require `native-emit` -- pulled in by
// `full`. The host-only `--features std` build gates them out.
mod auto_var_init;
#[cfg(feature = "full")]
mod codegen;
mod deferred;
#[cfg(feature = "full")]
mod dwarf;
#[cfg(feature = "full")]
mod fixed_regs;
mod fixture_tables;
mod frame_slot_fuzz;
mod inline_asm;
#[cfg(feature = "full")]
mod inline_linkage;
mod intrinsics;
mod jit;
mod lexer;
#[cfg(feature = "full")]
mod linker;
mod loop_idiom;
#[cfg(feature = "full")]
mod native;
#[cfg(feature = "full")]
mod native_elf;
#[cfg(feature = "full")]
mod native_elf_x64;
#[cfg(feature = "full")]
mod native_pe_arm64;
#[cfg(feature = "full")]
mod native_pe_x64;
mod parser;
#[cfg(feature = "full")]
mod patchable_entry;
mod pointer_tracking;
mod programs;
#[cfg(feature = "full")]
mod reloc_golden;
#[cfg(feature = "full")]
mod relocatable;
#[cfg(feature = "full")]
mod stack_guard;
mod types;
mod vla;
mod x86_simd;

/// Absolute path of `tests/fixtures/c/<name>` relative to the crate root.
fn fixture_path(name: &str) -> PathBuf {
    let mut p = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    p.push("tests");
    p.push("fixtures");
    p.push("c");
    p.push(name);
    p
}

/// Read a C source fixture from `tests/fixtures/c/<name>`.
pub fn load_fixture(name: &str) -> String {
    let path = fixture_path(name);
    std::fs::read_to_string(&path)
        .unwrap_or_else(|e| panic!("failed to load fixture {}: {}", path.display(), e))
}

/// `<tmp>/<prefix>-<pid>-<n>-<stem><ext>`: unique per process and call.
/// Concurrent `cargo test` processes share the temp directory, so a fixed
/// name lets one run clobber the other's file. Callers remove what they
/// create.
pub fn unique_temp_path(prefix: &str, stem: &str, ext: &str) -> PathBuf {
    use std::sync::atomic::{AtomicU64, Ordering};
    static COUNTER: AtomicU64 = AtomicU64::new(0);
    let n = COUNTER.fetch_add(1, Ordering::Relaxed);
    let pid = std::process::id();
    std::env::temp_dir().join(format!("{prefix}-{pid}-{n}-{stem}{ext}"))
}

/// Run a just-written image, retrying while the kernel reports it busy.
///
/// `exec` fails with `ETXTBSY` while any process holds the file open for
/// writing. The writer here closes it first, so the holder is another
/// test's `fork`: a child inherits every descriptor, and `O_CLOEXEC`
/// drops the inherited copy at its `exec`, not at the `fork`. A loaded
/// machine widens that window, which is why it surfaces on a shared
/// runner and not on an idle box. `sh` reports the condition as 126.
/// Reached only where a shell mediates the exec (the aarch64 ELF tests)
/// and on Mach-O; the x86-64 ELF tests carry their own errno-26 retry.
#[allow(dead_code)]
pub fn output_when_not_busy(build: impl Fn() -> std::process::Command) -> std::process::Output {
    let mut waited = std::time::Duration::ZERO;
    let mut delay = std::time::Duration::from_millis(5);
    loop {
        let spent = waited >= std::time::Duration::from_secs(5);
        // Direct exec reports the condition as errno 26; a shell in
        // between reports it as 126 with the message on stderr.
        let busy = match build().output() {
            Ok(out) => {
                let busy = out.status.code() == Some(126)
                    && String::from_utf8_lossy(&out.stderr).contains("Text file busy");
                if !busy || spent {
                    return out;
                }
                true
            }
            Err(e) if e.raw_os_error() == Some(26) && !spent => true,
            Err(e) => panic!("run the produced image: {e}"),
        };
        debug_assert!(busy);
        std::thread::sleep(delay);
        waited += delay;
        delay = (delay * 2).min(std::time::Duration::from_millis(250));
    }
}

/// Fixtures built and run at once, summed over every whole-corpus parity
/// test -- `cargo test` schedules those in parallel, so a per-test width
/// would multiply by the number live. The floor is what the serial loops
/// already reached, one fixture per live parity test; the ceiling bounds
/// memory on hosts whose RAM does not track their core count.
/// `BADC_TEST_JOBS` overrides both.
fn fixture_jobs() -> usize {
    static JOBS: OnceLock<usize> = OnceLock::new();
    *JOBS.get_or_init(|| {
        if let Some(n) = std::env::var("BADC_TEST_JOBS")
            .ok()
            .and_then(|v| v.parse::<usize>().ok())
        {
            return n.max(1);
        }
        let cpus = std::thread::available_parallelism().map_or(2, |n| n.get());
        (cpus / 2).clamp(cpus.min(4), 8)
    })
}

struct FixturePermits {
    free: Mutex<usize>,
    released: Condvar,
}

struct FixturePermit(&'static FixturePermits);

impl Drop for FixturePermit {
    fn drop(&mut self) {
        let mut free = self.0.free.lock().unwrap_or_else(|e| e.into_inner());
        *free += 1;
        self.0.released.notify_one();
    }
}

fn acquire_fixture_permit() -> FixturePermit {
    static POOL: OnceLock<FixturePermits> = OnceLock::new();
    let pool = POOL.get_or_init(|| FixturePermits {
        free: Mutex::new(fixture_jobs()),
        released: Condvar::new(),
    });
    let mut free = pool.free.lock().unwrap_or_else(|e| e.into_inner());
    while *free == 0 {
        free = pool.released.wait(free).unwrap_or_else(|e| e.into_inner());
    }
    *free -= 1;
    drop(free);
    FixturePermit(pool)
}

/// Check every entry of `corpus` on up to [`fixture_jobs`] threads and
/// return the messages `check` produced, ordered by corpus index so the
/// same regression reports the same text whatever order threads finish in.
pub fn parity_failures<T, F>(corpus: &[(&str, T)], check: F) -> Vec<String>
where
    T: Sync,
    F: Fn(&str, &T) -> Option<String> + Sync,
{
    let next = AtomicUsize::new(0);
    let failures: Mutex<Vec<(usize, String)>> = Mutex::new(Vec::new());
    let width = fixture_jobs().min(corpus.len().max(1));
    std::thread::scope(|scope| {
        for _ in 0..width {
            scope.spawn(|| {
                loop {
                    let i = next.fetch_add(1, Ordering::Relaxed);
                    let Some((name, expected)) = corpus.get(i) else {
                        break;
                    };
                    let _permit = acquire_fixture_permit();
                    if let Some(msg) = check(name, expected) {
                        failures
                            .lock()
                            .unwrap_or_else(|e| e.into_inner())
                            .push((i, msg));
                    }
                }
            });
        }
    });
    let mut failures = failures.into_inner().unwrap_or_else(|e| e.into_inner());
    failures.sort_by_key(|(i, _)| *i);
    failures.into_iter().map(|(_, msg)| msg).collect()
}

/// Completion order is the reverse of corpus order here, so an unsorted
/// collection would report the same regression differently per run.
#[test]
fn parity_failures_report_in_corpus_order() {
    let corpus: Vec<(&str, u64)> = (0..32).map(|i| ("fixture", i)).collect();
    let got = parity_failures(&corpus, |name, i| {
        std::thread::sleep(std::time::Duration::from_millis(32 - *i));
        Some(format!("{name} {i}"))
    });
    let want: Vec<String> = (0..32).map(|i| format!("fixture {i}")).collect();
    assert_eq!(got, want);
}

/// The permit pool is process-wide, so no run of the corpus exceeds
/// [`fixture_jobs`] however many parity tests the harness has in flight.
#[test]
fn parity_failures_hold_the_concurrency_bound() {
    let live = AtomicUsize::new(0);
    let peak = AtomicUsize::new(0);
    let corpus: Vec<(&str, u64)> = (0..64).map(|i| ("fixture", i)).collect();
    let got = parity_failures(&corpus, |_, _| {
        peak.fetch_max(live.fetch_add(1, Ordering::SeqCst) + 1, Ordering::SeqCst);
        std::thread::sleep(std::time::Duration::from_millis(1));
        live.fetch_sub(1, Ordering::SeqCst);
        None
    });
    assert!(got.is_empty());
    let peak = peak.load(Ordering::SeqCst);
    assert!(
        (1..=fixture_jobs()).contains(&peak),
        "peak {peak} outside 1..={}",
        fixture_jobs()
    );
}

/// Standard-library prelude prepended to every inline-source test.
/// Replaces the auto-prepend the compiler used to do via the
/// per-target umbrella header. Keeping it in the test helper means
/// each test body stays focused on the behaviour under test instead
/// of repeating five `#include` lines per snippet. Idempotent:
/// fixtures that already pull headers in via their own
/// `#include` lines just re-enter `#pragma once` and emit nothing.
pub const TEST_PRELUDE: &str = "\
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <dlfcn.h>
";

/// Concatenate [`TEST_PRELUDE`] with `src` so inline test snippets
/// don't have to spell every header out themselves.
pub fn with_prelude(src: &str) -> String {
    let mut out = String::with_capacity(TEST_PRELUDE.len() + src.len());
    out.push_str(TEST_PRELUDE);
    out.push_str(src);
    out
}

/// Compile inline source.
pub fn compile_str(src: &str) -> Program {
    Compiler::new(with_prelude(src)).compile().unwrap()
}

/// Compile inline source WITHOUT the standard prelude. Used by the
/// codegen tests that assert byte-for-byte equality on the emitted
/// native code -- those tests can't tolerate the lazy-stream helper
/// (or any future prelude-only function) appearing in the output.
pub fn compile_str_bare(src: &str) -> Program {
    Compiler::new(src.to_string()).compile().unwrap()
}

/// `compile_str_bare` with an explicit target, for sources whose asm
/// constraints only parse for that target's family.
pub fn compile_str_bare_for(src: &str, target: crate::Target) -> Program {
    Compiler::with_target(src.to_string(), target)
        .compile()
        .unwrap()
}

/// Link a compiled program against the embedded startup runtime into
/// a complete, runnable native image, mirroring the CLI's native path
/// (`emit_native` -> relocatable objects -> `link_native_objects` ->
/// `write_native_image_from_merged`). The entry stub's `__c5_*`
/// helpers are defined by the runtime, so the produced executable is
/// self-sufficient. `subsystem` (from `program.subsystem`) gates the
/// runtime's console vs GUI startup helpers on Windows.
///
/// `program` must have been compiled for `target`. `compile_str` /
/// `compile_fixture` use `Compiler::new`, which targets the host, so a
/// test that links for a fixed non-host target (e.g. always
/// `Target::LinuxX64`) must compile for that target -- via
/// `Compiler::with_options(..., target, ..)` -- or use a prelude-free
/// source (`compile_str_bare`). A host/target skew preprocesses the
/// bundled headers under the wrong OS macros: on a Windows host the
/// `<stdlib.h>` `_WIN32` branch then contributes an `environ` symbol
/// that collides with the runtime's when the image is emitted as ELF.
#[cfg(feature = "full")]
pub fn link_executable_with_runtime(
    program: &Program,
    target: crate::Target,
    opts: crate::NativeOptions,
) -> Result<Vec<u8>, String> {
    use crate::{
        CompileOptions, NativeMachine, OutputKind, embedded_runtime, emit_aarch64_plt,
        emit_native_with_options, emit_x86_64_plt, link_native_objects, parse_native_elf,
        write_native_image_from_merged,
    };
    let mut reloc = opts;
    reloc.output_kind = OutputKind::Relocatable;

    let mut objs = Vec::new();
    let prog_bytes = emit_native_with_options(program, target, reloc)
        .map_err(|e| format!("emit program object: {e}"))?;
    objs.push(parse_native_elf(&prog_bytes).map_err(|e| format!("parse program object: {e}"))?);

    // This helper always builds a hosted executable, so the runtime's
    // CRT and startup sections are both compiled in.
    // The entry shape follows the entry symbol: `__BADC_WIN_WINMAIN__`
    // for a `WinMain` entry, `__BADC_WIN_WIDE__` for `wmain`, else `main`
    // with argc/argv -- independent of the PE subsystem.
    let mut rt_defines: Vec<(String, String)> = vec![
        ("__BADC_C5_CRT__".to_string(), "1".to_string()),
        ("__BADC_C5_START__".to_string(), "1".to_string()),
    ];
    rt_defines.push((
        "__BADC_ENTRY__".to_string(),
        program
            .entry_name
            .clone()
            .unwrap_or_else(|| "main".to_string()),
    ));
    match program.entry_name.as_deref() {
        Some("WinMain") => rt_defines.push(("__BADC_WIN_WINMAIN__".to_string(), "1".to_string())),
        Some("wWinMain") => {
            rt_defines.push(("__BADC_WIN_WINMAIN__".to_string(), "1".to_string()));
            rt_defines.push(("__BADC_WIN_WIDE__".to_string(), "1".to_string()));
        }
        Some("wmain") => rt_defines.push(("__BADC_WIN_WIDE__".to_string(), "1".to_string())),
        _ => {}
    }
    for (name, body) in embedded_runtime().iter() {
        let copts = CompileOptions::default()
            .with_no_entry_point(true)
            .with_defines(rt_defines.clone());
        let rt_program = Compiler::with_options(body.to_string(), target, copts)
            .compile()
            .map_err(|e| format!("compile runtime {name}: {e}"))?;
        let rt_bytes = emit_native_with_options(&rt_program, target, reloc)
            .map_err(|e| format!("emit runtime {name}: {e}"))?;
        objs.push(parse_native_elf(&rt_bytes).map_err(|e| format!("parse runtime {name}: {e}"))?);
    }

    append_on_demand_objects(&mut objs, target, reloc)?;

    let mut merged = link_native_objects(&objs).map_err(|e| format!("link: {e}"))?;
    let plt = match merged.machine {
        NativeMachine::X86_64 => emit_x86_64_plt(&mut merged),
        NativeMachine::Aarch64 => emit_aarch64_plt(&mut merged),
    }
    .map_err(|e| format!("plt: {e}"))?;
    let entry_name = program.entry_name.as_deref().unwrap_or("main");
    write_native_image_from_merged(
        &merged,
        &plt,
        entry_name,
        program.subsystem,
        OutputKind::Executable,
        target,
        None,
    )
    .map_err(|e| format!("write image: {e}"))
}

/// Offer the compiler-runtime and C-library sources the way the CLI's
/// link does: each joins only when it defines a symbol the object set
/// still leaves undefined. Nothing is compiled when nothing is
/// undefined, which is the usual case for a fixture.
#[cfg(feature = "full")]
fn append_on_demand_objects(
    objs: &mut Vec<crate::NativeObject>,
    target: crate::Target,
    reloc: crate::NativeOptions,
) -> Result<(), String> {
    use crate::{
        CompileOptions, NativeSymSection, embedded_compiler_rt, embedded_libc,
        emit_native_with_options, parse_native_elf,
    };
    let unresolved = |objs: &[crate::NativeObject]| {
        let mut defined = alloc::collections::BTreeSet::new();
        let mut undefined = alloc::collections::BTreeSet::new();
        for o in objs {
            for s in &o.symbols {
                if s.binding == 0 {
                    continue;
                }
                if s.section == NativeSymSection::Undef {
                    if s.binding == 1 && !defined.contains(&s.name) {
                        undefined.insert(s.name.clone());
                    }
                } else {
                    defined.insert(s.name.clone());
                    undefined.remove(&s.name);
                }
            }
        }
        undefined
    };
    if unresolved(objs).is_empty() {
        return Ok(());
    }
    let mut pool = Vec::new();
    for (name, body) in embedded_compiler_rt().iter().chain(embedded_libc().iter()) {
        let copts = CompileOptions::default().with_no_entry_point(true);
        let p = Compiler::with_options(body.to_string(), target, copts)
            .compile()
            .map_err(|e| format!("compile {name}: {e}"))?;
        let bytes =
            emit_native_with_options(&p, target, reloc).map_err(|e| format!("emit {name}: {e}"))?;
        pool.push(Some(
            parse_native_elf(&bytes).map_err(|e| format!("parse {name}: {e}"))?,
        ));
    }
    loop {
        let undefined = unresolved(objs);
        let mut progress = false;
        for slot in pool.iter_mut() {
            let wanted = slot.as_ref().is_some_and(|o| {
                o.symbols.iter().any(|s| {
                    s.binding == 1
                        && !matches!(s.section, NativeSymSection::Undef | NativeSymSection::Abs)
                        && undefined.contains(&s.name)
                })
            });
            if wanted {
                objs.push(slot.take().expect("a wanted slot is occupied"));
                progress = true;
            }
        }
        if !progress {
            return Ok(());
        }
    }
}

/// Link one translation unit into a shared library, the way the CLI's
/// `--shared` does: no startup runtime, and an unresolved global becomes
/// a load-time import the host supplies.
#[cfg(feature = "full")]
#[allow(dead_code)] // used by the feature-gated shared-library tests
pub fn link_shared_library(
    program: &Program,
    target: crate::Target,
    opts: crate::NativeOptions,
) -> Result<Vec<u8>, String> {
    use crate::{
        NativeMachine, OutputKind, emit_aarch64_plt, emit_native_with_options, emit_x86_64_plt,
        link_native_objects_with_options, parse_native_elf, write_native_image_from_merged,
    };
    let mut reloc = opts;
    reloc.output_kind = OutputKind::Relocatable;
    let bytes = emit_native_with_options(program, target, reloc)
        .map_err(|e| format!("emit program object: {e}"))?;
    let obj = parse_native_elf(&bytes).map_err(|e| format!("parse program object: {e}"))?;
    let mut merged =
        link_native_objects_with_options(&[obj], true).map_err(|e| format!("link: {e}"))?;
    let plt = match merged.machine {
        NativeMachine::X86_64 => emit_x86_64_plt(&mut merged),
        NativeMachine::Aarch64 => emit_aarch64_plt(&mut merged),
    }
    .map_err(|e| format!("plt: {e}"))?;
    write_native_image_from_merged(
        &merged,
        &plt,
        program.entry_name.as_deref().unwrap_or("main"),
        program.subsystem,
        OutputKind::SharedLibrary,
        target,
        Some("libbadctest"),
    )
    .map_err(|e| format!("write image: {e}"))
}

/// Like [`link_executable_with_runtime`] but links several user
/// translation units into one image, mirroring a multi-`.o` CLI link.
/// `programs[0]` carries the entry point and subsystem. Used to exercise
/// cross-unit references the single-program helper can't, e.g. an
/// `extern _Thread_local` defined in one unit and read from another.
#[cfg(feature = "full")]
#[allow(dead_code)] // only the Linux/x86_64 native lane links multiple user units
pub fn link_executable_with_runtime_multi(
    programs: &[&Program],
    target: crate::Target,
    opts: crate::NativeOptions,
) -> Result<Vec<u8>, String> {
    use crate::{
        CompileOptions, NativeMachine, OutputKind, embedded_runtime, emit_aarch64_plt,
        emit_native_with_options, emit_x86_64_plt, link_native_objects, parse_native_elf,
        write_native_image_from_merged,
    };
    let entry = programs[0];
    let mut reloc = opts;
    reloc.output_kind = OutputKind::Relocatable;

    // Match the CLI's object order (the runtime precedes user inputs); the
    // PLT pass numbers trampolines in object order, so the order must be
    // stable across linkers.
    let mut objs = Vec::new();
    let mut rt_defines: Vec<(String, String)> = vec![
        ("__BADC_C5_CRT__".to_string(), "1".to_string()),
        ("__BADC_C5_START__".to_string(), "1".to_string()),
    ];
    rt_defines.push((
        "__BADC_ENTRY__".to_string(),
        entry
            .entry_name
            .clone()
            .unwrap_or_else(|| "main".to_string()),
    ));
    if entry.subsystem == Some(crate::Subsystem::Windows) {
        rt_defines.push(("__BADC_WIN_GUI__".to_string(), "1".to_string()));
    }
    if entry.entry_name.as_deref() == Some("wmain") {
        rt_defines.push(("__BADC_WIN_WIDE__".to_string(), "1".to_string()));
    }
    for (name, body) in embedded_runtime().iter() {
        let copts = CompileOptions::default()
            .with_no_entry_point(true)
            .with_defines(rt_defines.clone());
        let rt_program = Compiler::with_options(body.to_string(), target, copts)
            .compile()
            .map_err(|e| format!("compile runtime {name}: {e}"))?;
        let rt_bytes = emit_native_with_options(&rt_program, target, reloc)
            .map_err(|e| format!("emit runtime {name}: {e}"))?;
        objs.push(parse_native_elf(&rt_bytes).map_err(|e| format!("parse runtime {name}: {e}"))?);
    }

    for (i, program) in programs.iter().enumerate() {
        let bytes = emit_native_with_options(program, target, reloc)
            .map_err(|e| format!("emit user object {i}: {e}"))?;
        objs.push(parse_native_elf(&bytes).map_err(|e| format!("parse user object {i}: {e}"))?);
    }

    let mut merged = link_native_objects(&objs).map_err(|e| format!("link: {e}"))?;
    let plt = match merged.machine {
        NativeMachine::X86_64 => emit_x86_64_plt(&mut merged),
        NativeMachine::Aarch64 => emit_aarch64_plt(&mut merged),
    }
    .map_err(|e| format!("plt: {e}"))?;
    let entry_name = entry.entry_name.as_deref().unwrap_or("main");
    write_native_image_from_merged(
        &merged,
        &plt,
        entry_name,
        entry.subsystem,
        OutputKind::Executable,
        target,
        None,
    )
    .map_err(|e| format!("write image: {e}"))
}

/// Link a program that supplies its own `__c5_entry` into a
/// freestanding executable: the embedded runtime is not linked and the
/// image entry is `__c5_entry`. Mirrors the CLI path when an input
/// object defines `__c5_entry`.
#[cfg(feature = "full")]
pub fn link_freestanding(
    program: &Program,
    target: crate::Target,
    opts: crate::NativeOptions,
) -> Result<Vec<u8>, String> {
    use crate::{
        NativeMachine, OutputKind, emit_aarch64_plt, emit_native_with_options, emit_x86_64_plt,
        link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    let mut reloc = opts;
    reloc.output_kind = OutputKind::Relocatable;
    let prog_bytes = emit_native_with_options(program, target, reloc)
        .map_err(|e| format!("emit program object: {e}"))?;
    let objs = vec![parse_native_elf(&prog_bytes).map_err(|e| format!("parse: {e}"))?];
    let mut merged = link_native_objects(&objs).map_err(|e| format!("link: {e}"))?;
    let plt = match merged.machine {
        NativeMachine::X86_64 => emit_x86_64_plt(&mut merged),
        NativeMachine::Aarch64 => emit_aarch64_plt(&mut merged),
    }
    .map_err(|e| format!("plt: {e}"))?;
    write_native_image_from_merged(
        &merged,
        &plt,
        "__c5_entry",
        program.subsystem,
        OutputKind::Executable,
        target,
        None,
    )
    .map_err(|e| format!("write image: {e}"))
}

/// Compile a fixture with the standard prelude.
pub fn compile_fixture(name: &str) -> Program {
    compile_str(&load_fixture(name))
}

/// Compile a fixture WITHOUT the standard prelude.
pub fn compile_fixture_bare(name: &str) -> Program {
    compile_str_bare(&load_fixture(name))
}

/// Compile + run inline source. Pointer tracking is on by default so the
/// test suite catches use-after-free / double-free / OOB regressions for
/// free; tests that need to inspect a deliberate failure use
/// [`try_run_fixture`] instead.
pub fn run_str(src: &str) -> i64 {
    Vm::new(compile_str(src))
        .with_pointer_tracking()
        .run()
        .unwrap()
}

/// Compile + run a fixture.
pub fn run_fixture(name: &str) -> i64 {
    run_str(&load_fixture(name))
}

/// Compile + run a fixture with `args` exposed to `main(int argc, char **argv)`.
pub fn run_fixture_with_args<I, S>(name: &str, args: I) -> i64
where
    I: IntoIterator<Item = S>,
    S: Into<String>,
{
    let program = compile_fixture(name);
    Vm::new(program)
        .with_pointer_tracking()
        .with_args(args)
        .run()
        .unwrap()
}

/// Compile + run a fixture and return the raw `Result` so callers can
/// assert on either the exit code (no error) or the diagnostic message
/// (use-after-free / double-free / OOB). Pointer tracking is on, same as
/// the unwrapping helpers above.
pub fn try_run_fixture(name: &str) -> Result<i64, C5Error> {
    let program = compile_fixture(name);
    Vm::new(program).with_pointer_tracking().run()
}

/// Tiny harness that owns the `Lexer`, its symbol table, and the data
/// segment so lexer tests can step through tokens with one call. The symbol
/// table is pre-seeded with C keywords (so identifiers like `int` come back
/// as `Token::Int`, not `Token::Id`).
pub struct LexHarness {
    lex: Lexer,
    pub symbols: Vec<Symbol>,
    pub symbol_index: lex_helpers::SymbolIndex,
    pub data: Vec<u8>,
}

impl LexHarness {
    pub fn new(src: &str) -> Self {
        let mut symbols = Vec::new();
        let mut symbol_index = lex_helpers::SymbolIndex::new();
        // Lexer tests don't reach for `#pragma binding`s, so the
        // dynamic-binding seed is empty -- only keywords get
        // registered. Tests that want libc names should add their
        // own `Symbol` entries directly.
        lex_helpers::init_symbols(&mut symbols, &mut symbol_index, &[]);
        Self {
            lex: Lexer::new(src.to_string()),
            symbols,
            symbol_index,
            data: Vec::new(),
        }
    }

    /// Advance one token and return it as a [`Tok`]. Callers compare
    /// directly against `Token::X`, ASCII byte literals (`'('`,
    /// `';'`, ...), or bare `i64` thanks to the `PartialEq` impls on
    /// [`Tok`] -- no `as i64` cast at the call site.
    pub fn next(&mut self) -> Tok {
        self.lex
            .next(&mut self.symbols, &mut self.symbol_index, &mut self.data)
            .expect("lexer error");
        self.lex.tk
    }

    pub fn ival(&self) -> i64 {
        self.lex.ival
    }
    /// `(l_count, unsigned)` suffix record of the most recently lexed
    /// integer literal.
    pub fn int_suffix(&self) -> (u8, bool) {
        (self.lex.int_suffix_long, self.lex.int_suffix_unsigned)
    }
    pub fn line(&self) -> usize {
        self.lex.line
    }
    /// Name of the most recently lexed identifier.
    pub fn name(&self) -> &str {
        &self.symbols[self.lex.curr_id_idx].name
    }
}
