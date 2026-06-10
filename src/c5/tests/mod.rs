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

use super::lexer::{self as lex_helpers, Lexer};
use super::symbol::Symbol;
use super::token::{Tok, Token};
use super::{C5Error, Compiler, Program, Vm};

// These modules emit / link native images (via `emit_native*` and the
// `link_*` helpers below), which require `native-emit` -- pulled in by
// `full`. The host-only `--features std` build gates them out.
#[cfg(feature = "full")]
mod codegen;
mod deferred;
#[cfg(feature = "full")]
mod dwarf;
mod intrinsics;
mod jit;
mod lexer;
#[cfg(feature = "full")]
mod linker;
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
mod pointer_tracking;
mod programs;
mod types;

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

/// Link a compiled program against the embedded startup runtime into
/// a complete, runnable native image, mirroring the CLI's native path
/// (`emit_native` -> relocatable objects -> `link_native_objects` ->
/// `write_native_image_from_merged`). The entry stub's `__c5_*`
/// helpers are defined by the runtime, so the produced executable is
/// self-sufficient. `subsystem` (from `program.subsystem`) gates the
/// runtime's console vs GUI startup helpers on Windows.
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
    // startup section is compiled in (`__BADC_C5_START__`).
    // `__BADC_WIN_GUI__` selects the kernel32 WinMain entry on a PE GUI
    // subsystem; `__BADC_WIN_WIDE__` selects the `wmain` entry.
    let mut rt_defines: Vec<(String, String)> =
        vec![("__BADC_C5_START__".to_string(), "1".to_string())];
    rt_defines.push((
        "__BADC_ENTRY__".to_string(),
        program
            .entry_name
            .clone()
            .unwrap_or_else(|| "main".to_string()),
    ));
    if program.subsystem == Some(crate::Subsystem::Windows) {
        rt_defines.push(("__BADC_WIN_GUI__".to_string(), "1".to_string()));
    }
    if program.entry_name.as_deref() == Some("wmain") {
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
    pub fn line(&self) -> usize {
        self.lex.line
    }
    /// Name of the most recently lexed identifier.
    pub fn name(&self) -> &str {
        &self.symbols[self.lex.curr_id_idx].name
    }
}
