//! Native object linker.
//!
//! Gated behind the `linker` feature; absent it the lib has no way
//! to write or read object / archive files and `Compiler`'s
//! single-TU compile-to-`Program` shape is the only path.
//!
//! ## Pipeline
//!
//! ```text
//!   foo.c, bar.c
//!      |  Compiler::compile + emit_native (OutputKind::Relocatable)
//!      v
//!   foo.o, bar.o    (ELF64 ET_REL; a `.note.badc` carries dylib
//!                    routing, exports, and TLS metadata)
//!                                                  |
//!                  archive::write_archive ---> libbaz.a
//!   foo.o, bar.o, libbaz.a, plus -l/-L paths
//!      |  parse_native_elf -> link_native_objects -> emit_*_plt
//!      v
//!   MergedNative  ->  write_native_image_from_merged
//!      v
//!   ELF / Mach-O / PE executable or shared library
//! ```
//!
//! `link_native_objects` pulls archive members on demand (a member
//! is included iff one of its defined symbols satisfies a still-
//! unresolved reference), concatenates the `.text` / `.data` /
//! `.tdata` sections with per-unit offsets, resolves cross-unit
//! relocations by symbol name, and dedupes the dylib / binding /
//! export tables. `write_native_image_from_merged` lays out the
//! container, the PLT, the dynamic-symbol tables, PT_TLS / the PE
//! TLS directory / Mach-O TLV descriptors, and the merged DWARF.

mod archive;
#[cfg(feature = "std")]
mod image;
#[cfg(feature = "std")]
pub(crate) mod link;
#[cfg(feature = "std")]
mod object;
#[cfg(feature = "std")]
mod synth_build;

pub use archive::{ArchiveMember, read_archive, write_archive};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use image::write_executable_elf64;
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use link::{
    MergedNative, MergedSymbol, PendingImportReloc, PltTrampoline, emit_aarch64_plt,
    emit_x86_64_plt, link_native_objects,
};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use object::{
    NativeMachine, NativeObject, NativeReloc, NativeSymSection, NativeSymbol, is_elf_object,
    parse_native_elf,
};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use synth_build::write_native_image_from_merged;
