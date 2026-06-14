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
// Without `native-emit` the on-disk writers are gated out, leaving
// their support code (the `Machine` enum, `lower_for`, reloc tables,
// per-binding metadata read only by the writers) unreferenced. That
// configuration is a deliberate slim build, so allow the dead code
// rather than gating each field and helper individually.
#![cfg_attr(not(feature = "native-emit"), allow(dead_code))]
// `+` and `-` at the start of a doc-comment line are heavy-use
// markdown bullets in this codebase's narrative comments
// (declarator / parser shapes, ABI option-bit lists). Rust 1.95
// started flagging them as "list item without indentation" /
// "overindented". The intent is paragraphs, not lists; silencing
// the lint at the crate root is less invasive than rewriting
// every comment.
#![allow(clippy::doc_lazy_continuation, clippy::doc_overindented_list_items)]

extern crate alloc;

/// Compiler identification reported by `--version`. `build.rs`
/// captures the git commit / branch / remote at the time badc
/// itself was built and exposes them via `cargo:rustc-env`, so
/// the human invoking the tool can see exactly which checkout it
/// came from.
///
/// These bytes are NOT baked into emitted binaries: the commit /
/// branch / remote vary with the build environment (a git
/// checkout yields a hash; an exported tree yields `unknown`) and
/// change on every commit, which would make the compiler's output
/// depend on where badc was built. Output carries the
/// reproducible [`OUTPUT_MARKER`] instead.
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

/// Compiler-identification marker appended to the code section of
/// every emitted binary, so a `strings` scan of the produced
/// Mach-O / ELF / PE reveals the badc version that wrote it.
///
/// The marker carries the release version only -- never the git
/// commit / branch / remote. The compiler's output must be
/// reproducible: the same source, flags, and target must yield
/// identical bytes regardless of where or from which checkout
/// badc was built. Embedding volatile build-environment state
/// (the git fields in [`BUILD_INFO`]) would break that, so the
/// baked-in marker is pinned to `CARGO_PKG_VERSION`, which is
/// stable for a given release. This mirrors the compiler-version
/// string that gcc and clang place in `.comment` / `.ident`.
pub const OUTPUT_MARKER: &str = concat!("BADC\n\tv", env!("CARGO_PKG_VERSION"));

pub mod c5;

#[allow(unused_imports)]
pub use c5::{
    C5Error, CompileOptions, Compiler, Host, NativeOptions, OutputKind, Overwrite, PredefinedKind,
    PredefinedSymbol, Program, Target, Trace, VariableInfo, Vm, embedded_headers, jit_run,
    jit_run_with_options, predefined_symbols,
};
#[cfg(feature = "native-emit")]
pub use c5::{emit_native, emit_native_with_options};

#[cfg(feature = "std")]
pub use c5::StdHost;

#[cfg(feature = "full")]
pub use c5::{
    ArchiveMember, Binding, DylibSpec, Linkage, Subsystem, embedded_runtime, read_archive,
    write_archive,
};

#[cfg(all(feature = "full", feature = "std"))]
pub use c5::{
    MergedNative, MergedSymbol, NativeMachine, NativeObject, NativeReloc, NativeSymSection,
    NativeSymbol, PendingImportReloc, PltTrampoline, emit_aarch64_plt, emit_x86_64_plt,
    is_elf_object, link_native_objects, link_native_objects_with_options, parse_native_elf,
    write_executable_elf64, write_native_image_from_merged,
};
