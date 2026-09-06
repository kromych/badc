//! badc -- a Rust compiler for the c5 dialect of C.
//! The default pipeline parses, compiles, and lowers to a
//! Mach-O / ELF / PE32+ binary you can run on the matching
//! target. Cross-compile from anywhere to anywhere; an
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

// The one-line identification and the GNU dialect version it
// embeds are macros so `concat!`, which takes literals only, can
// build the consts below from a single spelling of each.
macro_rules! gnu_compat_version {
    () => {
        "4.3.0"
    };
}
macro_rules! version_line_with {
    ($($tail:expr),*) => {
        concat!(
            "badc ",
            env!("CARGO_PKG_VERSION"),
            " (gcc-compatible, GNU C ",
            gnu_compat_version!(),
            $($tail,)*
            ")"
        )
    };
}
macro_rules! version_line {
    () => {
        version_line_with!()
    };
}

/// GNU C dialect version claimed under `--gnu`: the preprocessor
/// derives `__GNUC__` / `__GNUC_MINOR__` / `__GNUC_PATCHLEVEL__`
/// and `__VERSION__` from it, and [`VERSION_LINE`] states it, so
/// the claim cannot drift between the macros and the banner. See
/// `Preprocessor::enable_gnu` for what backs the value and what
/// bounds it.
pub const GNU_COMPAT_VERSION: &str = gnu_compat_version!();

/// One-line compiler identification: name, release version, the
/// gcc-compatibility statement, and the commit the compiler was
/// built from where its source named one, in the family style of
/// `gcc (GCC) 14.2.0` / `clang version 19.0.0`. This is the first
/// line of `--version`, so consumers that keep `head -n1` of
/// `$(CC) --version` (the Linux kernel's `CONFIG_CC_VERSION_TEXT`,
/// which reaches the boot banner and `/proc/version`) record which
/// compiler build produced the image, not merely which release.
///
/// This is deliberately not [`OUTPUT_MARKER`]. The commit belongs
/// in what identifies the compiler to a person or a build system;
/// it must not reach emitted objects, whose bytes have to be a
/// function of the source, flags and target alone.
#[cfg(badc_git_commit)]
pub const VERSION_LINE: &str = version_line_with!(", git ", env!("BADC_GIT_ID"));

/// As above, for a build whose source named no commit.
#[cfg(not(badc_git_commit))]
pub const VERSION_LINE: &str = version_line!();

/// Compiler identification reported by `--version`:
/// [`VERSION_LINE`] followed by the git commit / branch / remote
/// captured by `build.rs` at the time badc itself was built, so
/// the human invoking the tool can see exactly which checkout it
/// came from.
///
/// The git tail is NOT baked into emitted binaries: the fields
/// vary with the build environment (a git checkout yields a hash;
/// an exported tree yields `unknown`) and change on every commit,
/// which would make the compiler's output depend on where badc
/// was built. Output carries the reproducible [`OUTPUT_MARKER`]
/// instead.
#[cfg(badc_git)]
pub const BUILD_INFO: &str = concat!(
    version_line_with!(", git ", env!("BADC_GIT_ID")),
    "\n        commit ",
    env!("BADC_GIT_COMMIT"),
    "\n        branch ",
    env!("BADC_GIT_BRANCH"),
    "\n        remote ",
    env!("BADC_GIT_REMOTE")
);

/// Built outside a checkout -- an exported tree, a crates.io
/// package -- so there is no provenance to report and the
/// identification is the version line alone.
#[cfg(not(badc_git))]
pub const BUILD_INFO: &str = VERSION_LINE;

/// Compiler-identification marker carried by every emitted
/// binary: appended to the code-section tail of final images so a
/// `strings` scan reveals the producer, and stored as the
/// `.comment` section of relocatable ELF objects, mirroring the
/// version string gcc and clang place there.
///
/// The marker is the release version only, never the git commit /
/// branch / remote -- so it is not [`VERSION_LINE`], which does
/// name the commit. The compiler's output must be reproducible:
/// the same source, flags, and target must yield identical bytes
/// regardless of where or from which checkout badc was built, and
/// the git fields vary with exactly that.
pub const OUTPUT_MARKER: &str = version_line!();

pub mod c5;

pub use c5::diag;

#[allow(unused_imports)]
pub use c5::{
    AUTO_VAR_INIT_PATTERN_BYTE, AutoVarInit, BinaryFormat, C5Error, CodeModel, CompileOptions,
    Compiler, DEFAULT_SSP_BUFFER_SIZE, DWARF_FORMAT_BITS, DWARF_VERSION, ElfClass, FixedReg,
    FixedRegs, GuardSeg, GuardSymbol, Hardening, Host, IncludeOrigin, IncludeRecord, IncludeStatus,
    IndirectBranch, NativeOptions, OutputKind, Overwrite, PatchableEntry, PredefinedKind,
    PredefinedSymbol, Profiling, Program, SYSV_TLS_GUARD_OFFSET, StackGuard, StackProtect,
    StackProtector, Target, Trace, VariableInfo, Vm, dep_escape, dep_prerequisites, dep_render,
    embedded_headers, fixed_register, jit_run, jit_run_with_options, predefined_symbols,
    stack_guard_sysreg,
};
#[cfg(feature = "native-emit")]
pub use c5::{
    NativeEmit, emit_native, emit_native_reporting, emit_native_with_options,
    emit_native_with_options_owned,
};

#[cfg(feature = "std")]
pub use c5::StdHost;

#[cfg(feature = "full")]
pub use c5::{
    ArchiveMember, Binding, DylibSpec, Linkage, Subsystem, embedded_compiler_rt, embedded_libc,
    embedded_runtime, read_archive, write_archive,
};

#[cfg(all(feature = "full", feature = "std"))]
pub use c5::{
    ArchiveInclusion, LdsEmit, LdsObject, LdsOptions, LdsResult, LinkerScript, MergedNative,
    MergedSymbol, NativeMachine, NativeObject, NativeReloc, NativeSymSection, NativeSymbol,
    OrphanHandling, PendingImportReloc, PltTrampoline, SectionContribution, SectionMap,
    SharedLibrary, TargetCLibrary, detect_binary_format, emit_aarch64_plt, emit_x86_64_plt,
    is_elf_object, is_ld_invocation, is_mach_o_dylib, is_mach_o_fat, is_mach_o_object,
    is_native_object, is_tbd, library_bindings, link_native_objects,
    link_native_objects_with_options, link_native_objects_with_shared_libs,
    link_synthesized_symbol, link_with_script, mach_o_fat_slice, parse_lds_object,
    parse_linker_script, parse_mach_o_dylib, parse_native_elf, parse_native_mach_o,
    parse_native_object, parse_shared_library, parse_tbd, read_archive_at, render_link_map, run_ld,
    write_executable_elf64, write_native_image_from_merged, write_native_image_from_merged_ex,
};
