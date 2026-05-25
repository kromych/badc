//! Cross-translation-unit linker.
//!
//! Gated behind the `linker` feature; absent it the lib has no
//! way to write or read object / archive files and `Compiler`'s
//! single-TU compile-to-`Program` shape is the only path.
//!
//! ## Model
//!
//! A *translation unit* compiles to a [`LinkUnit`] -- the same
//! bytecode + static-data shape as [`crate::c5::Program`], plus
//! a symbol table (defined and undefined names) and a list of
//! relocations that the link step resolves once every required
//! TU is in memory. Bytecode is target-independent; per-target
//! native lowering happens only when a [`Program`] flows into the
//! existing codegen, after the link.
//!
//! Object files (`.o`) are an ELF wrapper around a single
//! [`LinkUnit`]: standard `.symtab` / `.strtab` for the symbol
//! table, a `.rela.badc.text` relocation section, and badc-
//! specific sections (`.badc.text` = `Vec<i64>` bytecode,
//! `.badc.data`, `.badc.tdata` / `.badc.tbss`, `.badc.meta`)
//! carrying everything else. Archives (`.a`) are ar(5) with a
//! SysV-style symbol index (`/`) -- one member per object,
//! pull-in driven by undefined-symbol references in the root
//! inputs.
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
//! `text` / `data` / `tdata` segments with per-unit offsets,
//! and applies relocations against the merged symbol table.
//! The result is a single [`Program`] indistinguishable from one
//! produced by a single-TU compile, plus a merged dylib /
//! binding table, struct registry, source-file table, and
//! DWARF variable list.

mod archive;
pub(crate) mod link;
#[cfg(feature = "std")]
mod native_image;
#[cfg(feature = "std")]
mod native_link;
#[cfg(feature = "std")]
mod native_object;
mod object;
mod reloc;
mod symbol;
mod unit;

pub use archive::{ArchiveMember, read_archive, write_archive};
pub use link::{LinkArchive, LinkOptions, link_units};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use native_image::write_executable_elf64;
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use native_link::{
    MergedNative, MergedSymbol, PendingImportReloc, PltTrampoline, emit_aarch64_plt,
    emit_x86_64_plt, link_native_objects,
};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use native_object::{
    NativeMachine, NativeObject, NativeReloc, NativeSymSection, NativeSymbol, is_elf_object,
    parse_native_elf,
};
pub use object::{read_object, write_object};
#[cfg(test)]
pub(crate) use object::{read_ssa_func, write_ssa_func};
pub use reloc::{Reloc, RelocKind};
pub use symbol::{LinkSymbol, SymbolKind};
pub use unit::LinkUnit;
