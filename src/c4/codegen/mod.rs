//! Native code generation. Takes a compiled (and optionally optimized)
//! [`Program`] and writes a platform-native executable that runs
//! without involving the VM.
//!
//! The story is intentionally simple: lower the existing stack-machine
//! bytecode straight to native instructions (no SSA, no register
//! allocation worth the name -- the VM "accumulator" lives in a
//! callee-saved register, the VM "stack" rides on the native stack),
//! then wrap the bytes in whatever executable container the OS wants.
//!
//! ## Pipeline
//!
//! [`Program`] -> per-arch [`Codegen`] -> raw machine code -> per-OS
//! image writer -> bytes on disk -> (Apple Silicon only) shell to
//! `codesign --sign -`.
//!
//! ## What we trade away
//!
//! Native binaries skip the VM's safety net. There's no `--track-pointers`
//! equivalent, no `mprotect` enforcement, no code-vs-data separation
//! check on every load and store. If you want those, run under the VM
//! instead. `--emit-native` is the "I want a real binary" mode; the
//! VM is the "I want my hand held" mode.
//!
//! ## Supported targets
//!
//! Phase 1: macOS aarch64 only. Other targets land later --
//! see milestone tracker for the order.

use alloc::format;
use alloc::vec::Vec;

use super::error::C4Error;
use super::program::Program;

mod aarch64;
mod mach_o;

/// Which native binary to produce. The single-variant enum is
/// deliberate -- it makes adding the next target a structural change
/// (new variant, new match arm in [`emit_native`]) rather than a
/// silent string parse, and gives `--emit-native` somewhere to grow.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Target {
    /// macOS on Apple Silicon. Mach-O / arm64e-not-required, links
    /// against `libSystem.B.dylib` for libc, signed ad-hoc with
    /// `codesign --sign -` so dyld will load it.
    MacOSAarch64,
}

impl Target {
    /// Parse the value passed to `--emit-native` (or use the default
    /// for the single supported target). Reserved for when the flag
    /// grows a value form like `--emit-native=linux-x64`.
    pub fn parse(spec: Option<&str>) -> Result<Self, C4Error> {
        match spec {
            None | Some("macos-aarch64") | Some("aarch64-apple-darwin") => Ok(Target::MacOSAarch64),
            Some(other) => Err(C4Error::Compile(format!(
                "unsupported native target: {other:?} (try `macos-aarch64`)"
            ))),
        }
    }
}

/// Where each piece of the program-being-built ends up in the final
/// image. The codegen and image-writer halves both populate this --
/// the codegen knows the code bytes and pinned-data bytes, the writer
/// arranges them into segments and tells the codegen what virtual
/// addresses they landed at so it can finalize PC-relative refs.
#[derive(Debug, Default)]
#[allow(dead_code)] // fields land in M1.1+
pub(crate) struct Build {
    /// Machine code, ready to be placed in `__TEXT,__text` (or its
    /// per-OS equivalent).
    pub text: Vec<u8>,
    /// Initialised data segment: string literals + zero-initialised
    /// globals (badc currently uses one segment for both).
    pub data: Vec<u8>,
    /// Offset (within `text`) of the program's entry point. Becomes
    /// the entry address of `LC_MAIN` / `e_entry` / etc.
    pub entry_offset: usize,
}

/// Translate a [`Program`] into a native binary. The bytes are written
/// to `out` in whatever format the [`Target`] requires; on macOS, the
/// caller is responsible for invoking `codesign` afterwards (handled
/// by the CLI shim, not by this function -- code-signing is a runtime
/// concern, not part of the format).
///
/// Returns the raw image bytes so the caller can decide whether to
/// write them to disk, embed them, hash them, etc.
pub fn emit_native(program: &Program, target: Target) -> Result<Vec<u8>, C4Error> {
    match target {
        Target::MacOSAarch64 => {
            let build = aarch64::lower(program)?;
            mach_o::write(&build)
        }
    }
}
