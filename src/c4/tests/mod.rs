//! Test suite split by phase.
//!
//! - [`lexer`]    — drives `Lexer::next` directly and inspects the token stream.
//! - [`parser`]   — feeds malformed C to the compiler and asserts on errors.
//! - [`codegen`]  — compiles valid C and inspects `program.text`.
//! - [`vm`]       — builds `Program` literals by hand and runs them.
//! - [`programs`] — end-to-end: load a `.c` fixture, compile, run, assert exit code.
//!
//! Tests that contain meaningful C source load it from `fixtures/c/<name>.c`
//! via [`load_fixture`] / [`run_fixture`] / [`compile_fixture`]. Lexer- and
//! parser-error tests use small inline strings since the snippets are tiny
//! and tightly coupled to the assertion.

use std::path::PathBuf;

use super::lexer::{self as lex_helpers, Lexer};
use super::symbol::Symbol;
use super::token::{Token, Ty};
use super::{C4Error, Compiler, Op, Program, Vm};

mod codegen;
mod lexer;
mod parser;
mod pointer_tracking;
mod programs;
mod syscalls;
mod vm;

/// Absolute path of `fixtures/c/<name>` relative to the crate root.
fn fixture_path(name: &str) -> PathBuf {
    let mut p = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    p.push("fixtures");
    p.push("c");
    p.push(name);
    p
}

/// Read a C source fixture from `fixtures/c/<name>`.
pub fn load_fixture(name: &str) -> String {
    let path = fixture_path(name);
    std::fs::read_to_string(&path)
        .unwrap_or_else(|e| panic!("failed to load fixture {}: {}", path.display(), e))
}

/// Compile inline source.
pub fn compile_str(src: &str) -> Program {
    Compiler::new(src.to_string()).compile().unwrap()
}

/// Compile a fixture.
pub fn compile_fixture(name: &str) -> Program {
    compile_str(&load_fixture(name))
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
pub fn try_run_fixture(name: &str) -> Result<i64, C4Error> {
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
    pub data: Vec<u8>,
}

impl LexHarness {
    pub fn new(src: &str) -> Self {
        let mut symbols = Vec::new();
        lex_helpers::init_symbols(&mut symbols);
        Self {
            lex: Lexer::new(src.to_string()),
            symbols,
            data: Vec::new(),
        }
    }

    /// Advance one token and return `tk`.
    pub fn next(&mut self) -> i64 {
        self.lex
            .next(&mut self.symbols, &mut self.data)
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
