//! Native object linker.
//!
//! Gated behind the `full` feature; absent it the lib has no way
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
pub(crate) mod attributes;
#[cfg(feature = "std")]
pub(crate) mod comdat;
#[cfg(feature = "std")]
pub(crate) mod default_script;
#[cfg(feature = "std")]
pub(crate) mod dynamic;
#[cfg(feature = "std")]
pub(crate) mod eh_frame;
pub(crate) mod erratum;
#[cfg(feature = "std")]
pub(crate) mod gnu_property;
#[cfg(feature = "std")]
mod image;
pub(crate) mod ld_driver;
#[cfg(feature = "std")]
pub(crate) mod lds;
#[cfg(feature = "std")]
pub(crate) mod lds_link;
#[cfg(feature = "std")]
pub(crate) mod link;
#[cfg(feature = "std")]
pub(crate) mod mach_o_object;
#[cfg(feature = "std")]
pub(crate) mod mach_o_shared;
#[cfg(feature = "std")]
pub(crate) mod map;
#[cfg(feature = "std")]
pub(crate) mod object;
#[cfg(feature = "std")]
pub(crate) mod relocatable;
#[cfg(feature = "std")]
mod synth_build;
#[cfg(feature = "std")]
pub(crate) mod target_libc;

/// A link failure that is badc's own: an invariant the linker relies on
/// did not hold. `module` prefixes the message with the module's name.
///
/// TODO: the input readers -- the archive, ELF and Mach-O parsers --
/// report a malformed input through `internal_err`, so their text
/// claims badc is at fault. Moving them to
/// `link_err(Code::MALFORMED_INPUT, ..)` changes what they print.
pub(crate) fn internal_err(module: &str, msg: &str) -> crate::c5::error::C5Error {
    crate::c5::error::C5Error::internal(tagged(module, msg))
}

/// A link failure in the user's inputs or command line, under the row
/// `code` names.
pub(crate) fn link_err(
    code: crate::c5::diag::Code,
    module: &str,
    msg: &str,
) -> crate::c5::error::C5Error {
    crate::c5::error::C5Error::hard(code, tagged(module, msg))
}

fn tagged(module: &str, msg: &str) -> alloc::string::String {
    if module.is_empty() {
        alloc::string::ToString::to_string(msg)
    } else {
        alloc::format!("{module}: {msg}")
    }
}

#[cfg(feature = "std")]
pub use archive::read_archive_at;
pub use archive::{ArchiveMember, read_archive, write_archive};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use image::write_executable_elf64;
pub use ld_driver::{is_ld_invocation, run_ld};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use lds::{LinkerScript, parse_linker_script};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use lds_link::{
    LdsEmit, LdsObject, LdsOptions, LdsResult, OrphanHandling, link_with_script, parse_lds_object,
};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use link::{
    MergedNative, MergedSymbol, PendingImportReloc, PltTrampoline, SectionContribution, SectionMap,
    emit_aarch64_plt, emit_x86_64_plt, link_native_objects, link_native_objects_with_options,
    link_native_objects_with_shared_libs, link_synthesized_symbol,
};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use mach_o_object::{is_mach_o_fat, is_mach_o_object, mach_o_fat_slice, parse_native_mach_o};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use mach_o_shared::{is_mach_o_dylib, is_tbd, parse_mach_o_dylib, parse_tbd};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use map::{ArchiveInclusion, render_link_map};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use object::{
    NativeMachine, NativeObject, NativeReloc, NativeSymSection, NativeSymbol, SharedLibrary,
    detect_binary_format, is_elf_object, is_native_object, parse_native_elf, parse_native_object,
    parse_shared_library,
};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use relocatable::{
    EtRel, LdScript, RelinkOptions, link_relocatable, parse_et_rel, parse_module_script,
};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use synth_build::{write_native_image_from_merged, write_native_image_from_merged_ex};
#[cfg(feature = "std")]
#[allow(unused_imports)]
pub use target_libc::TargetCLibrary;
