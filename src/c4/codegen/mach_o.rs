//! Mach-O (64-bit) writer for arm64 executables.
//!
//! Mach-O files are a fixed-size header followed by a list of "load
//! commands" describing segments, dylibs, the entry point, and the
//! dynamic linker's bind/rebase opcode streams. We write all of that
//! by hand -- the format is well-documented in
//! `<mach-o/loader.h>` and Apple's `dyld` source, and a hand-rolled
//! writer keeps us free of any binary-writer dependency.
//!
//! This module is structured as a flat tower of `write_*` helpers
//! that each push raw bytes to a `Vec<u8>` in the order dyld expects
//! to read them. The header has to know the total size of the load
//! commands before they're written, so we lay out commands twice:
//! once to size them, once to emit them.
//!
//! Phase 1 stub. Real implementation lands across M1.2-M1.7.

use alloc::vec::Vec;

use super::super::error::C4Error;
use super::Build;

/// Serialize a [`Build`] to a Mach-O64 image. Phase 1 stub --
/// returns a not-yet-implemented error so the CLI flag plumbing can
/// be wired before the writer is built out in M1.2+.
pub(super) fn write(_build: &Build) -> Result<Vec<u8>, C4Error> {
    Err(C4Error::Compile(
        "Mach-O writer not yet implemented (M1.0 scaffolding only)".into(),
    ))
}
