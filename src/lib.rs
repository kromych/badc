//! badc -- a Rust compiler for the c5 dialect, an evolution of
//! Robert Swierczek's c4. The default pipeline parses, compiles,
//! and lowers to a Mach-O / ELF / PE32+ binary you can run on the
//! matching target. Cross-compile from anywhere to anywhere; an
//! in-process JIT and a `Vm`-based interpreter sit alongside for
//! programmatic use.
//!
//! `Compiler::new(source).compile()` returns a [`Program`].
//! [`emit_native`] / [`emit_native_with_options`] lower it to bytes
//! you can write to disk; [`jit_run`] / [`jit_run_with_options`]
//! load and execute it in-process; [`Vm::new(program).run`]
//! interprets the pre-lifted SSA functions under a
//! pointer-tracking runtime. [`optimize`] sits between compile
//! and any of those when you want it.
//!
//! Started as a Rust port of c4; over time the dialect grew structs,
//! a real preprocessor with `#include` / `#define` / `#pragma binding`,
//! per-target ABIs, native code emission for Mach-O / ELF / PE32+,
//! the in-process JIT, and a register-pool optimizer -- enough
//! divergence to warrant its own name. The `C5Error` type and `c5`
//! module are how the new identity shows up in the source tree. The
//! README covers the dialect, the runtime safety story, and the
//! CLI. The binary in `src/main.rs` is little more than CLI
//! plumbing around the types this module re-exports.
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
// `+` and `-` at the start of a doc-comment line are heavy-use
// markdown bullets in this codebase's narrative comments
// (declarator / parser shapes, ABI option-bit lists). Rust 1.95
// started flagging them as "list item without indentation" /
// "overindented". The intent is paragraphs, not lists; silencing
// the lint at the crate root is less invasive than rewriting
// every comment.
#![allow(clippy::doc_lazy_continuation, clippy::doc_overindented_list_items)]

extern crate alloc;

/// Compiler identification string baked into every emitted
/// binary. `build.rs` captures the git commit / branch / remote
/// at compile time and exposes them via `cargo:rustc-env`. The
/// codegen appends these bytes to `Build::text` so a `strings`
/// scan of the produced Mach-O / ELF / PE binary tells you
/// exactly which badc build emitted it.
///
/// Format: `PRODUCED BY BADC vX.Y.Z, commit ..., branch ..., remote ...`
/// Wrapped between two literal `**` markers so the prose can
/// pop out of binary noise even with a noisy `strings` output.
pub const BUILD_INFO: &str = concat!(
    "BADC\n\tv",
    env!("CARGO_PKG_VERSION"),
    "\n\tcommit ",
    env!("BADC_GIT_COMMIT"),
    "\n\tbranch ",
    env!("BADC_GIT_BRANCH"),
    "\n\tremote ",
    env!("BADC_GIT_REMOTE")
);

pub mod c5;

#[allow(unused_imports)]
pub use c5::{
    C5Error, CompileOptions, Compiler, Host, NativeOptions, OutputKind, Overwrite, PredefinedKind,
    PredefinedSymbol, Program, Target, Trace, VariableInfo, Vm, embedded_headers, emit_native,
    emit_native_with_options, jit_run, jit_run_with_options, predefined_symbols,
};

#[cfg(feature = "std")]
pub use c5::StdHost;

#[cfg(feature = "linker")]
pub use c5::{
    ArchiveMember, Binding, DylibSpec, LinkArchive, LinkOptions, LinkSymbol, LinkUnit, Linkage,
    Reloc, RelocKind, Subsystem, SymbolKind, embedded_runtime, link_units, read_archive,
    read_object, write_archive, write_object,
};

#[cfg(all(feature = "linker", feature = "std"))]
pub use c5::{
    MergedNative, MergedSymbol, NativeMachine, NativeObject, NativeReloc, NativeSymSection,
    NativeSymbol, PendingImportReloc, PltTrampoline, emit_aarch64_plt, emit_x86_64_plt,
    is_elf_object, link_native_objects, parse_native_elf, write_executable_elf64,
    write_native_image_from_merged,
};
