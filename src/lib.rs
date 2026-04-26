//! badc -- a Rust compiler / VM for the c4 dialect, plus a handful of
//! extensions. The pipeline is straight-line: `Compiler::new(source)
//! .compile()` returns a [`Program`], and `Vm::new(program).run()`
//! runs it. `optimize(program)` sits between them when you want it.
//!
//! Started as a Rust port of Robert Swierczek's c4 -- the `c4` module
//! name and [`C4Error`] type are kept as a nod to that lineage. The
//! README covers the dialect, the runtime safety story, and the CLI.
//! The binary in `src/main.rs` is little more than CLI plumbing
//! around the types this module re-exports.
//!
//! ## no_std
//!
//! Build the library with `--no-default-features` to drop `std`. In
//! that mode the [`StdHost`] adapter -- file IO, env vars, real
//! stdin/stdout -- goes with it; consumers wire up their own [`Host`]
//! and construct the VM with `Vm::with_host(program, my_host)`.
//! Everything else -- lexer, compiler, VM dispatch, pointer tracking,
//! mprotect, optimizer -- runs on `extern crate alloc`.

#![cfg_attr(not(feature = "std"), no_std)]

extern crate alloc;

pub mod c4;

#[allow(unused_imports)]
pub use c4::{
    C4Error, Compiler, Host, Op, Overwrite, PredefinedKind, PredefinedSymbol, Program, Target,
    Trace, Vm, emit_native, optimize, predefined_symbols,
};

#[cfg(feature = "std")]
pub use c4::StdHost;
