//! Cross-translation-unit linker.
//!
//! Gated behind the `linker` feature; absent it the lib has no
//! way to write or read object / archive files and `Compiler`'s
//! single-TU compile-to-`Program` shape is the only path.
//!
//! ## Model
//!
//! A translation unit compiles to a [`LinkUnit`]: per-TU static
//! data (`.data`, `.tdata` / `.tbss`), the walker's SSA function
//! list (`user_ssa_funcs` plus `synthetic_ssa_funcs` for sys
//! trampolines), the parser symbol snapshot the walker still
//! reads from, and a symbol / relocation pair that names every
//! cross-TU data fixup. Text-segment references travel through
//! per-`FunctionSsa` `extern_*_refs` channels and resolve
//! independently of the [`Reloc`] enum, which patches
//! data-segment slots only.
//!
//! Object files (`.o`) are an ELF wrapper around a single
//! [`LinkUnit`]: standard `.symtab` / `.strtab` for the symbol
//! table plus `.badc.data`, `.badc.tdata` / `.badc.tbss`, and
//! `.badc.meta` carrying the SSA function bodies + parser
//! metadata. Archives (`.a`) are ar(5) with a SysV-style symbol
//! index (`/`); one member per object, pull-in driven by
//! undefined-symbol references in the root inputs.
//!
//! ## Pipeline
//!
//! ```text
//!   foo.c, bar.c
//!      |  Compiler::compile_to_link_unit
//!      v
//!   foo.lu, bar.lu  ----  object::write  --->  foo.o, bar.o
//!                                                  |
//!                                                  v
//!                  archive::write_archive ---> libbaz.a
//!   foo.o, bar.o, libbaz.a, plus -l/-L paths
//!      |  link_units
//!      v
//!   Program (single-TU shape; ready for emit_native)
//! ```
//!
//! `link_units` walks the input list, pulls archive members on
//! demand (a member is included iff one of its defined symbols
//! satisfies a still-unresolved reference), concatenates the
//! `data` / `tdata` segments with per-unit offsets, rebases each
//! unit's SSA function `ent_pc` / `end_pc` against a cumulative
//! PC extent, and applies data relocations against the merged
//! symbol table. The result is a single [`Program`]
//! indistinguishable from one produced by a single-TU compile,
//! plus a merged dylib / binding table, struct registry,
//! source-file table, and DWARF variable list.

mod archive;
pub(crate) mod unit_link;
mod unit_object;
mod unit_reloc;
mod unit_symbol;
mod unit;
#[cfg(feature = "std")]
mod image;
#[cfg(feature = "std")]
pub(crate) mod link;
#[cfg(feature = "std")]
mod object;

pub use archive::{ArchiveMember, read_archive, write_archive};
pub use unit_link::{LinkArchive, LinkOptions, link_units};
pub use unit_object::{read_object, write_object};
#[cfg(test)]
pub(crate) use unit_object::{read_ssa_func, write_ssa_func};
pub use unit_reloc::{Reloc, RelocKind};
pub use unit_symbol::{LinkSymbol, SymbolKind};
pub use unit::LinkUnit;
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
