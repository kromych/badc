//! badc — a Rust compiler / VM for the c4 dialect (and several
//! extensions on top). Started as a port of Robert Swierczek's c4 —
//! the `c4` module name and `C4Error` type are kept to acknowledge
//! that lineage.
//!
//! See `README.md` for the dialect, runtime safety story, and CLI.
//! This crate is the library half of the project; the binary lives in
//! `src/main.rs` and just wires the CLI flags around `Compiler` + `Vm`.
//!
//! ## no_std
//!
//! The library compiles under `--no-default-features` (no `std`
//! feature). In that mode the `StdHost` adapter (file IO, env vars,
//! real stdin/stdout) is not available; consumers must provide their
//! own [`Host`] impl. Everything else — lexer, compiler, VM dispatch,
//! pointer tracking, mprotect — works on `extern crate alloc`.

#![cfg_attr(not(feature = "std"), no_std)]

extern crate alloc;

pub mod c4;

#[allow(unused_imports)]
pub use c4::{
    C4Error, Compiler, Host, Op, Overwrite, PredefinedKind, PredefinedSymbol, Program, Trace, Vm,
    optimize, predefined_symbols,
};

#[cfg(feature = "std")]
pub use c4::StdHost;
