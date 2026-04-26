mod compiler;
mod error;
mod lexer;
mod op;
mod program;
mod symbol;
mod token;
mod vm;

#[cfg(test)]
mod tests;

// Public surface of the c4 module. The `#[allow(unused_imports)]` covers
// re-exports that aren't reached from `main.rs` (only from tests, which
// resolve through the inner module path) — they are still part of the
// intended public API.
#[allow(unused_imports)]
pub use {compiler::Compiler, error::C4Error, op::Op, program::Program, vm::Vm};
