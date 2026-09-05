//! Native ELF link step -- consumes one or more
//! [`NativeObject`]s (produced by `codegen/elf_reloc.rs`,
//! parsed back by `object::parse_native_elf`) and
//! returns the merged sections + resolved symbol table the
//! final-image writer will package as an `ET_EXEC` /
//! `ET_DYN` / `IMAGE_EXECUTABLE` / `MH_EXECUTE`.
//!
//! Scope: section concat, symbol resolution across units,
//! intra-unit (`Text`/`Data` section-symbol) and cross-unit
//! (`STB_GLOBAL` -> defining unit) relocs. Imports the units
//! reach for (libc `printf` / `malloc` / ...) stay as
//! [`MergedNative::imports`] entries the final-image writer
//! pours into the dynamic linker's PLT pool.

#![cfg(feature = "std")]
#![allow(dead_code)]

use crate::c5::diag::Code;
use alloc::borrow::Cow;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;
use hashbrown::HashMap;

use crate::c5::error::C5Error;

use super::object::{
    ElfTpoffTarget, NativeMachine, NativeObject, NativeReloc, NativeSymSection, NativeSymbol,
    RelocOrigin, RelocSite, SectionFamily, SharedLibrary, reloc_desc,
};
use crate::c5::layout::{pad_to_align as align_up, round_up as align_usize};
// A tail-call `b <sym>` reaches its target the same way `bl` does --
// a 26-bit PC-relative branch immediate -- so `R_AARCH64_JUMP26` shares
// CALL26's patch, PLT eligibility, and undefined-weak handling. Emitted
// by other toolchains' objects; c5's own codegen uses CALL26 for calls.
// `R_X86_64_REX_GOTPCRELX` is the relaxable variant of GOTPCREL marking
// a `REX mov reg, [rip+disp32]` GOT load (psABI B.2); emitted by c5's
// writer and other toolchains.
use super::{internal_err, link_err};
use crate::c5::object::elf_reloc_types::AbsCheck;
use crate::c5::object::elf_reloc_types::{
    R_AARCH64_ABS32, R_AARCH64_ABS64, R_AARCH64_ADD_ABS_LO12_NC, R_AARCH64_ADR_GOT_PAGE,
    R_AARCH64_ADR_PREL_LO21, R_AARCH64_ADR_PREL_PG_HI21, R_AARCH64_CALL26, R_AARCH64_JUMP26,
    R_AARCH64_LD64_GOT_LO12_NC, R_AARCH64_PREL32, R_AARCH64_PREL64, R_AARCH64_TLS_DTPREL64,
    R_AARCH64_TLSLE_ADD_TPREL_HI12, R_AARCH64_TLSLE_ADD_TPREL_LO12_NC, R_X86_64_32, R_X86_64_64,
    R_X86_64_DTPOFF64, R_X86_64_GOTPCREL, R_X86_64_PC32, R_X86_64_PC64, R_X86_64_PLT32,
    R_X86_64_REX_GOTPCRELX, R_X86_64_TPOFF32, aarch64_ldst_lo12_scale, aarch64_movw_field,
    aarch64_pcrel_data_field, aarch64_pcrel_imm_field, x86_64_abs_field, x86_64_pcrel_data_field,
};

/// The tag this module's diagnostics carry.
const MODULE: &str = "";

pub(crate) use crate::c5::object::elf_reloc_types::GOT_BASE_SYMBOL;

/// A relocation whose site reads a GOT slot: the value it wants is the
/// symbol's address, taken from storage the loader fills, not a
/// PC-relative distance to the symbol itself.
pub(crate) const fn is_got_reloc(rtype: u32) -> bool {
    matches!(
        rtype,
        R_X86_64_GOTPCREL
            | R_X86_64_REX_GOTPCRELX
            | R_AARCH64_ADR_GOT_PAGE
            | R_AARCH64_LD64_GOT_LO12_NC
    )
}

/// A relocation whose site transfers control: the field holds a branch
/// displacement, so the reference names an entry point and binds to a
/// call stub. No slot read can satisfy one.
pub(crate) const fn is_branch_reloc(machine: NativeMachine, rtype: u32) -> bool {
    match machine {
        NativeMachine::X86_64 => rtype == R_X86_64_PLT32,
        NativeMachine::Aarch64 => matches!(rtype, R_AARCH64_CALL26 | R_AARCH64_JUMP26),
    }
}

/// Result of merging N [`NativeObject`]s. Carries enough state
/// for a final-image writer to lay out `.text` / `.data` at the
/// target's expected virtual addresses, materialise the PLT
/// pool against [`Self::imports`], and emit the dynamic
/// symbol table.
#[derive(Debug, Clone)]
pub struct MergedNative {
    /// Concatenated `.text` bytes. Intra-unit relocs (to
    /// defined symbols in another unit, or to `.text` / `.data`
    /// section symbols within the same unit) have been
    /// applied in place. Call-site relocs targeting external
    /// imports stay at their raw placeholder value -- they're
    /// recorded in [`Self::pending_imports`].
    pub text: Vec<u8>,
    /// Base alignment the merged `.text` requires: the largest input
    /// section alignment, at least 16. The image writers place the
    /// text stream at a multiple of this.
    pub text_align: usize,
    /// Concatenated file-backed data bytes, read-only payload first:
    /// `[.rodata of every unit][relro of every unit][.data of every
    /// unit]`. One offset space, so every parked reference and every
    /// data relocation speaks the same kind of offset.
    pub data: Vec<u8>,
    /// Length of the read-only prefix of [`Self::data`]. The image
    /// writers place `data[..data_ro_len]` in a section the loader
    /// maps without write permission and `data[data_relro_len..]`
    /// plus the `.bss` tail in the writable one.
    pub data_ro_len: usize,
    /// End of the relro region: `data[data_ro_len..data_relro_len]`
    /// holds read-only content with loader-written slots. The ELF
    /// writer covers it (with `.dynamic` and `.got`) by a
    /// `PT_GNU_RELRO` header; writers without such a mechanism fold
    /// it into the writable stream. Always within
    /// `data_ro_len..=data.len()`.
    pub data_relro_len: usize,
    /// Base alignment the merged `.data` requires: the largest input
    /// section alignment, at least 8. The image writers place the
    /// data stream at a multiple of this.
    pub data_align: usize,
    /// Sum of every unit's `.bss` size. The final-image writer
    /// emits a single `.bss` of this size; no file bytes.
    pub bss_size: usize,
    /// Defined symbols in the merged image (every unit's
    /// `STB_GLOBAL`-non-`UNDEF` entries, deduped on name).
    /// Maps the symbol's name to its absolute byte offset
    /// within the merged section's range.
    pub defined: BTreeMap<String, MergedSymbol>,
    /// Imports the units reach for that weren't defined by any
    /// unit. Each appears once even if multiple units / call
    /// sites reach for it. The final-image writer turns each
    /// into a PLT trampoline + dynsym entry.
    pub imports: Vec<String>,
    /// Per call-site reloc against an import. Carries the byte
    /// offset within [`Self::text`] of the placeholder to
    /// patch, the index into [`Self::imports`], and the reloc
    /// kind. The writer applies these against the trampoline
    /// pool it appends to `.text`.
    pub pending_imports: Vec<PendingImportReloc>,
    /// Pointer-to-global initializer slots (`R_X86_64_64` /
    /// `R_AARCH64_ABS64`). Each entry is `(slot_data_offset,
    /// target_data_offset)`: the 8-byte slot at
    /// `slot_data_offset` within [`Self::data`] needs to hold
    /// `data_vaddr + target_data_offset` once the final-image
    /// writer commits a layout.
    pub data_abs_relocs: Vec<DataAbsReloc>,
    /// PC-relative 4-byte slots in [`Self::data`] targeting `.text`
    /// (switch dispatch tables from folded `.rodata`); see
    /// [`DataPcRel`].
    pub data_pcrel_relocs: Vec<DataPcRel>,
    /// Text relocations the merge applied in place, kept so a writer
    /// under `--emit-relocs` can re-emit each as a `.rela.text` entry
    /// against the `.text` section symbol.
    pub applied_text_relocs: Vec<AppliedTextReloc>,
    /// Data-initializer slots that hold the address of an imported
    /// function: `(slot_data_offset, import_index)`. A function-pointer
    /// table entry naming a shared-library symbol (`static freefn t =
    /// free;`) resolves to that import's PLT stub -- a valid function
    /// pointer. The PLT pass creates the stub (even for an import
    /// referenced only from data) and turns each entry into a
    /// `Text`-target [`DataAbsReloc`] against the stub, so the PIE
    /// writer emits the load-time relative relocation like any other
    /// function-pointer initializer.
    pub data_import_refs: Vec<(u64, usize)>,
    /// Architecture of the merged image. Every unit must agree;
    /// the link errors out if they don't.
    pub machine: NativeMachine,
    /// Dylib load paths the final-image writer drops into
    /// DT_NEEDED / LC_LOAD_DYLIB / IMAGE_IMPORT_DESCRIPTOR.
    /// Sourced from every input unit's
    /// [`NativeObject::dylibs`] (the `#pragma dylib` paths the
    /// .o writer recorded), deduped on full path with insertion
    /// order preserved across units.
    pub dylibs: Vec<String>,
    /// Per-import dylib routing: maps an import name (as it
    /// appears in [`Self::imports`]) to its index in [`Self::dylibs`].
    /// Populated from each unit's `NT_BADC_BINDING_MAP` note with
    /// the per-unit `dylib_index` remapped to the merged
    /// `dylibs` order; entries from later units that name the
    /// same import are ignored (first writer wins).
    pub import_dylib_map: BTreeMap<String, u32>,
    /// Import names that resolve through the runtime's flat namespace
    /// rather than a specific dylib: unresolved `STB_GLOBAL` references
    /// admitted under `allow_undefined` (a shared library). The
    /// per-format writer emits each as a flat-lookup Mach-O bind /
    /// undefined ELF `.dynsym` entry the host supplies at `dlopen`.
    pub flat_imports: alloc::collections::BTreeSet<String>,
    /// Source-declared export names, unioned across input objects
    /// from each unit's `NT_BADC_EXPORTS` note. The final-image
    /// writer promotes each to the export table when emitting a
    /// shared library (resolving the name through [`Self::defined`]).
    pub exports: Vec<String>,
    /// Win64 `_tls_index` fixup offsets, rebased into the merged
    /// `.text`. The PE writer patches each with the `_tls_index` slot
    /// address. Empty on non-Windows links and Windows links without
    /// `_Thread_local` access.
    pub tls_index_fixups: Vec<usize>,
    /// Mach-O TLV descriptor offsets, concatenated across units. The
    /// Mach-O writer materialises one `__thread_vars` descriptor per
    /// entry. Empty on non-macOS links.
    pub macho_tlv_descriptors: Vec<u64>,
    /// Mach-O TLV fixups, each `(adrp_offset, descriptor_index)` with
    /// `adrp_offset` rebased into the merged `.text` and
    /// `descriptor_index` into [`Self::macho_tlv_descriptors`].
    pub macho_tlv_fixups: Vec<(usize, usize)>,
    /// Data-import copy relocations from `#pragma binding(data ...)`,
    /// each `(local_name, host_symbol)`, deduplicated across units. The
    /// final-image writer binds each local data symbol it defines to the
    /// host's data object with an `R_*_COPY` relocation.
    pub copy_relocs: Vec<(String, String)>,
    /// Indices into [`Self::imports`] an input symbol table typed
    /// `STT_OBJECT`. The writers republish the type on the undefined
    /// dynamic symbol instead of tagging every import a function.
    pub object_imports: alloc::collections::BTreeSet<usize>,
    /// Concatenated standard DWARF byte streams from every
    /// input unit. Each unit's blob starts at
    /// `debug_*_bases[unit_idx]` inside the merged stream; the
    /// per-unit relocs (below) have their `r_offset` rebased to
    /// land inside the merged sections.
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    /// The exception: `.debug_str` is `SHF_MERGE | SHF_STRINGS` and is
    /// folded rather than concatenated.
    pub debug_str: Vec<u8>,
    pub debug_info_bases: Vec<usize>,
    pub debug_abbrev_bases: Vec<usize>,
    pub debug_line_bases: Vec<usize>,
    /// DWARF reloc lists (rebased). `sym_idx` is the per-unit
    /// symtab index of the target section symbol; the parallel
    /// `unit_for_*_reloc` records which unit each reloc came
    /// from so the writer can resolve through that unit's
    /// symbol table when applying.
    pub debug_info_relocs: Vec<super::object::NativeReloc>,
    pub debug_line_relocs: Vec<super::object::NativeReloc>,
    pub unit_for_debug_info_reloc: Vec<usize>,
    pub unit_for_debug_line_reloc: Vec<usize>,
    /// Text-targeting DWARF relocs that survived the link pass.
    /// Each entry's `byte_offset` is the placeholder location
    /// inside the matching merged section; the writer adds the
    /// committed text vmaddr to `merged_text_offset` and writes
    /// the result in little-endian over `width` bytes.
    pub debug_info_text_relocs: Vec<DebugTextReloc>,
    /// Data-image-targeting `.debug_info` placeholders: the
    /// `DW_OP_addr` of an object with static storage duration.
    pub debug_info_data_relocs: Vec<DebugDataReloc>,
    pub debug_line_text_relocs: Vec<DebugTextReloc>,
    /// Post-prologue byte offset in [`Self::text`], keyed by the
    /// function's merged entry offset. Sourced from each unit's
    /// `NT_BADC_PROLOGUE_END` note record, rebased by the
    /// per-unit text base. The synth path consults this to
    /// populate `Build::func_prologue_native` so
    /// `dwarf::build_debug_frame` emits
    /// `DW_CFA_advance_loc <prologue_size>` ahead of the
    /// post-prologue CFA rule. Consulted by lookup only, so it is
    /// keyed by hash rather than ordered.
    pub prologue_ends: HashMap<u64, u64>,
    /// Defined `STT_FUNC STB_LOCAL` (static) functions as
    /// `(name, merged_text_offset)`, rebased by the per-unit text base.
    /// Kept as a flat list separate from `defined` -- which is
    /// name-keyed and drives global reloc resolution -- so a static
    /// `foo` cannot shadow a global `foo` in another unit and two
    /// units' same-named statics both survive. The synth path adds them
    /// to `Build::func_names` so the static symbol table and DWARF name
    /// the program's own static functions.
    pub local_funcs: Vec<(String, u64)>,
    /// Per-thread TLS image for the merged executable. The first
    /// [`Self::tls_init_size`] bytes are the initialised `.tdata`
    /// template; the remainder is `.tbss` zero-fill. The per-format
    /// writers consume this as `Build::tls_data` / `tls_init_size`
    /// to lay out PT_TLS (ELF), the TLV section (Mach-O), or the
    /// `.tls` directory (PE). Empty when no input object carries
    /// `_Thread_local` storage.
    pub tls_data: Vec<u8>,
    pub tls_init_size: usize,
    /// Alignment of [`Self::tls_data`]: the largest input alignment, at
    /// least 8. Each unit's block starts on its own alignment inside it.
    pub tls_align: usize,
    /// Address-constant initializers inside [`Self::tls_data`]. Same
    /// resolution as [`Self::data_abs_relocs`], with `slot_offset`
    /// indexing the TLS template instead of `data`.
    pub tls_abs_relocs: Vec<DataAbsReloc>,
    /// `.init_array` / `.fini_array` placement in [`Self::data`],
    /// forwarded to the dynamic-ELF writer so it emits DT_INIT_ARRAY /
    /// DT_FINI_ARRAY. The pointer slots already carry R_*_RELATIVE via
    /// [`Self::data_abs_relocs`].
    pub init_fini_arrays: crate::c5::codegen::InitFiniArrays,
    /// Per-input-section placement records for the merged streams.
    pub section_map: SectionMap,
    /// C-identifier-named sections grouped across units, in the order
    /// their bytes sit in the merged streams. A writer able to carry a
    /// variable section list gives each its own output section; the
    /// rest leave the bytes in the family they were grouped into.
    pub named_sections: Vec<crate::c5::codegen::NamedSection>,
}

/// One input section's placement within a merged output stream.
#[derive(Debug, Clone)]
pub struct SectionContribution {
    /// Index into [`SectionMap::sources`]; `None` for linker-materialized
    /// content (init/fini arrays, the PLT pool).
    pub input: Option<usize>,
    /// Input section name as spelled in the object; `COMMON` for a
    /// coalesced C99 6.9.2 tentative definition.
    pub name: String,
    /// Byte offset within the merged stream.
    pub offset: u64,
    pub size: u64,
}

/// Which input object contributed which byte range of each merged
/// stream, in placement order. `data` offsets index the unified data
/// stream ([`MergedNative::data`]; offsets under
/// [`MergedNative::data_ro_len`] are the read-only prefix), `tls`
/// offsets the merged TLS block, the rest the like-named streams.
#[derive(Debug, Clone, Default)]
pub struct SectionMap {
    /// Origin label per input object ([`NativeObject::source`]), in
    /// link order.
    pub sources: Vec<String>,
    pub text: Vec<SectionContribution>,
    pub data: Vec<SectionContribution>,
    pub bss: Vec<SectionContribution>,
    pub tls: Vec<SectionContribution>,
    /// Input sections the object parser dropped, `(input, name, size)`.
    pub discarded: Vec<(usize, String, u64)>,
}

impl SectionMap {
    /// Input, section and section-relative offset for `offset` of the
    /// merged text stream. Lets a diagnostic raised after the merge
    /// name the object a site came from, at the offset `readelf -r`
    /// prints, without carrying the origin per relocation.
    pub(crate) fn locate_text(&self, offset: u64) -> Option<(&str, &str, u64)> {
        // A contribution that covers the offset names it; an empty one
        // sharing that offset is the answer only when no other does.
        let c = self
            .text
            .iter()
            .find(|c| offset >= c.offset && offset < c.offset + c.size)
            .or_else(|| self.text.iter().find(|c| offset == c.offset))?;
        let src = c
            .input
            .and_then(|i| self.sources.get(i))
            .map_or("", |s| s.as_str());
        Some((src, c.name.as_str(), offset - c.offset))
    }
}

/// One text relocation resolved and patched during the merge:
/// `text_offset` is the patched site, `target_text_offset` the
/// resolved `S + A` within the merged text stream. Re-emitted under
/// `--emit-relocs` as `rtype` against the `.text` section symbol with
/// `target_text_offset` as the addend.
#[derive(Debug, Clone, Copy)]
pub struct AppliedTextReloc {
    pub text_offset: u64,
    pub rtype: u32,
    pub target_text_offset: i64,
}

/// Pending `R_*_64` relocation that the final-image writer
/// resolves once it knows the runtime vmaddrs.
#[derive(Debug, Clone, Copy)]
pub struct DataAbsReloc {
    /// Byte offset within `MergedNative::data` of the 8-byte
    /// slot to patch.
    pub slot_offset: u64,
    /// Where the slot points, in the merged image. The writer maps a
    /// [`MergedTarget::Data`] offset through its data-offset-to-vaddr
    /// map and a [`MergedTarget::Text`] offset through `text_vaddr`.
    pub target: MergedTarget,
    /// Start of the object `target` is measured from -- the resolved
    /// symbol without the relocation addend. The data-byte space maps
    /// to non-contiguous runtime regions, so a writer attributes the
    /// region from the anchor and applies `target - anchor` to the
    /// address. Equals `target` for a zero addend.
    pub anchor: MergedTarget,
}

/// Which merged stream a resolved reference lands in, and where.
///
/// The merged image has two offset spaces: `.text`, and the
/// file-backed data plus its zero-fill tail. Both places that resolve
/// a `.rela.text` entry -- against the referencing unit's own symbol
/// and against another unit's definition -- answer the question
/// through [`merged_target`], so neither can drift from the other.
#[derive(Debug, Clone, Copy)]
pub enum MergedTarget {
    /// Byte offset within `MergedNative::text`.
    Text(i64),
    /// Byte offset within the merged data-byte space:
    /// `[read-only prefix][relro][writable data][zero-fill tail]`.
    Data(i64),
}

/// Resolve `(section, value)` -- a section-relative offset already
/// rebased by its unit's base -- into the merged image, applying the
/// `data.len()` bias that puts a `.bss` offset past the writable data.
///
/// `RoData` and `Data` share the data-byte space by construction (the
/// layout lays the read-only payload down first), so a caller never has to
/// know which side of the boundary a reference fell on.
fn merged_target(
    section: NativeSymSection,
    value: i64,
    addend: i64,
    data_len: usize,
) -> Result<MergedTarget, C5Error> {
    match section {
        NativeSymSection::Text => Ok(MergedTarget::Text(value + addend)),
        NativeSymSection::RoData | NativeSymSection::RelRo | NativeSymSection::Data => {
            Ok(MergedTarget::Data(value + addend))
        }
        NativeSymSection::Bss => Ok(MergedTarget::Data(data_len as i64 + value + addend)),
        // The GOT is not part of either merged stream; a reference to
        // it parks on its own section rather than an offset.
        NativeSymSection::Got
        | NativeSymSection::Undef
        | NativeSymSection::Abs
        | NativeSymSection::Common
        | NativeSymSection::Tls
        | NativeSymSection::DebugAbbrev
        | NativeSymSection::DebugLine
        | NativeSymSection::DebugStr => Err(internal_err(
            MODULE,
            &format!(
                "link_native_objects: reference resolves to {section:?}, which has no merged \
             text or data offset"
            ),
        )),
    }
}

/// Pending pc-relative relocation whose site lives in the merged data
/// stream: a switch dispatch table in folded `.rodata` (`R_*_PC32`
/// class, 4-byte) or an assembler `label - .` record in a folded
/// named section (`R_X86_64_PC64` class, 8-byte). The slot at
/// `slot_offset` receives `(text_vaddr + target_offset) - (data_vaddr
/// + slot_offset)` once the final-image writer commits a layout; no
/// absolute address survives into the image, so a PIE needs no
/// load-time relocation for it.
#[derive(Debug, Clone, Copy)]
pub struct DataPcRel {
    /// Byte offset within `MergedNative::data` of the slot.
    pub slot_offset: u64,
    /// `S + A` of the relocation in the merged image.
    pub target: MergedTarget,
    /// `S` alone. A negative addend can put `target` outside the
    /// merged section, which has no offset-to-address mapping of its
    /// own; the writers map this instead and apply the difference.
    pub anchor: MergedTarget,
    /// Slot width in bytes: 4 or 8.
    pub width: u8,
}

/// Where a defined symbol lives in the merged image, and the
/// `.symtab` attributes the defining unit gave it. The image writers
/// republish those attributes in the dynamic symbol table, so they
/// have to survive the merge rather than being re-derived from the
/// section.
#[derive(Debug, Clone, Copy)]
pub struct MergedSymbol {
    pub section: NativeSymSection,
    /// Byte offset within the merged section (so
    /// `merged.text[value..]` is the symbol's body for a Text
    /// symbol, `merged.data[value..]` for a Data symbol).
    pub value: u64,
    pub size: u64,
    /// `STT_NOTYPE` / `STT_OBJECT` / `STT_FUNC`.
    pub kind: u8,
    /// `STV_DEFAULT` (0) or a restricted visibility; see
    /// [`super::object::NativeSymbol::visibility`].
    pub visibility: u8,
    /// `STB_WEAK` definition -- a strong definition of the same name
    /// anywhere in the process overrides it.
    pub weak: bool,
}

/// Call-site / address-of reloc the linker parks for the
/// final-image writer to apply. Three flavours, discriminated
/// by `target_section`:
///
///   * `Undef`: a libc / dylib import. `import_index` selects
///     the `MergedNative::imports` slot. The writer emits a
///     PLT trampoline per import and patches the placeholder
///     to reach it.
///   * `Data` / `Bss`: a data-segment reference whose runtime
///     VA needs `data_vaddr` (or `data_vaddr + data_size` for
///     bss) in hand. `addend` carries the target's byte offset
///     within the merged data; `import_index` is `usize::MAX`.
///   * `Text`: a text-segment reference whose ADRP+ADD pair
///     can't be applied at link time on aarch64 because
///     `text_vaddr & 0xfff` is non-zero and the ADD_ABS_LO12
///     immediate depends on it. `addend` carries the target's
///     byte offset within the merged text; `import_index` is
///     `usize::MAX`.
#[derive(Debug, Clone)]
pub struct PendingImportReloc {
    /// Byte offset within `MergedNative::text` of the
    /// placeholder.
    pub text_offset: u64,
    /// Index into `MergedNative::imports`. `usize::MAX` for
    /// parked data / text refs (`target_section != Undef`).
    pub import_index: usize,
    /// ELF reloc kind (`R_AARCH64_CALL26` etc.).
    pub rtype: u32,
    /// The reloc's signed addend; mostly `-4` for x86_64
    /// `PLT32` and `0` for aarch64 `CALL26`; for parked refs
    /// carries the target's byte offset within the merged
    /// section identified by `target_section`.
    pub addend: i64,
    /// Section the target lives in (see the type-level doc).
    pub target_section: NativeSymSection,
    /// The site reads the import's slot to obtain the symbol's address
    /// rather than branching to the symbol. Such a site takes no call
    /// stub -- a stub is code, so reading through it returns
    /// instructions. Per site, not per import: a function's address may
    /// be taken at one site and called at another.
    pub slot_load: bool,
    /// Referenced symbol for a parked section reference a writer may
    /// still decline; `import_index` names no symbol for those.
    /// `None` for an import and for the aarch64 page pair.
    pub sym_name: Option<Box<str>>,
}

/// Where one unit's family blob landed in the merged stream. Blob
/// offsets below `prefix_len` sit at `base`; the named sections above
/// it were moved out to group by name and carry their own offsets.
struct BlobMap {
    base: u64,
    prefix_len: u64,
    /// `(blob offset, size, merged offset)`, ascending by blob offset.
    moved: Vec<(u64, u64, u64)>,
}

impl BlobMap {
    fn new(base: u64, prefix_len: u64) -> BlobMap {
        BlobMap {
            base,
            prefix_len,
            moved: Vec::new(),
        }
    }

    /// Merged-stream offset for a blob offset. An offset past the
    /// prefix that no moved section covers keeps the prefix mapping,
    /// which is where a blob-length offset (an end marker) belongs.
    fn at(&self, off: u64) -> u64 {
        if off < self.prefix_len {
            return self.base + off;
        }
        match self
            .moved
            .iter()
            .find(|&&(o, sz, _)| off >= o && off < o + sz)
        {
            Some(&(o, _, merged)) => merged + (off - o),
            None => self.base + off,
        }
    }
}

/// Blob length below which this unit's `fam` sections stay in place.
/// The parse sorted C-identifier-named sections last, so they form a
/// suffix starting at the lowest such section's offset.
fn named_prefix_len(obj: &NativeObject, fam: SectionFamily, blob_len: u64) -> u64 {
    obj.sections
        .iter()
        .filter(|s| s.family == fam && super::object::is_c_identifier(&s.name))
        .map(|s| s.offset)
        .min()
        .unwrap_or(blob_len)
}

/// Every unit's C-identifier-named `fam` sections, grouped by name.
/// Name order, then link order within a name, so the merge is a
/// function of its inputs.
fn named_group_order(
    objs: &[NativeObject],
    fam: SectionFamily,
) -> Vec<(usize, &super::object::InputSection)> {
    let mut v: Vec<(usize, &super::object::InputSection)> = objs
        .iter()
        .enumerate()
        .flat_map(|(i, o)| o.sections.iter().map(move |s| (i, s)))
        .filter(|(_, s)| s.family == fam && super::object::is_c_identifier(&s.name))
        .collect();
    v.sort_by(|a, b| a.1.name.cmp(&b.1.name).then(a.0.cmp(&b.0)));
    v
}

/// The widest alignment the merged `.bss` answers to: each unit's `.bss`
/// family, each named zero-fill section, and each common symbol, whose
/// `st_value` is its alignment.
fn bss_alignment(objs: &[NativeObject]) -> usize {
    let units = objs
        .iter()
        .map(|o| crate::c5::layout::bss_image_align(o.bss_align));
    let named = named_group_order(objs, SectionFamily::Bss)
        .into_iter()
        .map(|(_, s)| s.align.max(1) as usize);
    let commons = objs
        .iter()
        .flat_map(|o| &o.symbols)
        .filter(|s| matches!(s.section, NativeSymSection::Common))
        .map(|s| s.value.max(1) as usize);
    units
        .chain(named)
        .chain(commons)
        .max()
        .unwrap_or(crate::c5::layout::BSS_ALIGN_MIN)
}

/// One grouped name's merged extent. `start` / `end` are offsets in
/// the merged data stream, or in the zero-fill region when `bss`.
struct NamedExtent {
    name: String,
    sec: NativeSymSection,
    start: u64,
    end: u64,
    align: u64,
    bss: bool,
    write: bool,
}

/// Record one contribution's extent, widening the entry an earlier
/// contribution to the same name opened.
fn note_extent(extents: &mut Vec<NamedExtent>, e: NamedExtent) {
    match extents.iter_mut().find(|x| x.name == e.name) {
        Some(x) => {
            x.start = x.start.min(e.start);
            x.end = x.end.max(e.end);
            x.align = x.align.max(e.align);
        }
        None => extents.push(e),
    }
}

/// Append the grouped named sections of `fam` to the merged data
/// stream, recording each one's new offset in its unit's map.
fn group_named_bytes(
    data: &mut Vec<u8>,
    objs: &[NativeObject],
    fam: SectionFamily,
    blob: impl Fn(&NativeObject) -> &Vec<u8>,
    maps: &mut [BlobMap],
    sec: NativeSymSection,
    extents: &mut Vec<NamedExtent>,
) {
    let order = named_group_order(objs, fam);
    let any = !order.is_empty();
    let write = fam != SectionFamily::RoData;
    let mut prev: Option<&str> = None;
    for (i, s) in order {
        // A writer that gives each name a section of its own places
        // them apart, so an offset at one group's end must not name the
        // next group's first byte.
        if prev.is_some_and(|p| p != s.name) {
            data.push(0);
        }
        prev = Some(&s.name);
        align_up(data, s.align.max(1) as usize);
        let at = data.len() as u64;
        let src = blob(&objs[i]);
        data.extend_from_slice(&src[s.offset as usize..(s.offset + s.size) as usize]);
        maps[i].moved.push((s.offset, s.size, at));
        note_extent(
            extents,
            NamedExtent {
                name: s.name.clone(),
                sec,
                start: at,
                end: at + s.size,
                align: s.align.max(1),
                bss: false,
                write,
            },
        );
    }
    // An offset equal to a region's end names the next region's first
    // byte, so the last group keeps a byte of slack behind it.
    if any {
        data.push(0);
    }
}

/// The zero-fill counterpart: bss carries sizes, not bytes.
fn group_named_zerofill(
    bss_size: &mut usize,
    objs: &[NativeObject],
    maps: &mut [BlobMap],
    extents: &mut Vec<NamedExtent>,
) {
    let order = named_group_order(objs, SectionFamily::Bss);
    let any = !order.is_empty();
    let mut prev: Option<&str> = None;
    for (i, s) in order {
        if prev.is_some_and(|p| p != s.name) {
            *bss_size += 1;
        }
        prev = Some(&s.name);
        *bss_size = align_usize(*bss_size, s.align.max(1) as usize);
        let at = *bss_size as u64;
        *bss_size += s.size as usize;
        maps[i].moved.push((s.offset, s.size, at));
        note_extent(
            extents,
            NamedExtent {
                name: s.name.clone(),
                sec: NativeSymSection::Bss,
                start: at,
                end: at + s.size,
                align: s.align.max(1),
                bss: true,
                write: true,
            },
        );
    }
    if any {
        *bss_size += 1;
    }
}

/// Whether the link itself defines `name` once layout is known: the
/// init/fini array bounds, the `__start_` / `__stop_` pair of a named
/// section, and the GOT base. Archive selection runs before layout,
/// so a reference left undefined by one of these names is not one an
/// archive member is still needed for.
pub fn link_synthesized_symbol(name: &str) -> bool {
    matches!(
        name,
        "__init_array_start" | "__init_array_end" | "__fini_array_start" | "__fini_array_end"
    ) || name == GOT_BASE_SYMBOL
        || name.starts_with("__start_")
        || name.starts_with("__stop_")
}

/// Merge `objs` into a single [`MergedNative`]. Per-unit
/// section bases stack in the order the caller supplies; a
/// future linker can pick a different layout (sorted by
/// alignment, debug sections last, etc.) without changing
/// callers because every cross-section reference in the
/// merged output is recorded against a section base.
pub fn link_native_objects(objs: &[NativeObject]) -> Result<MergedNative, C5Error> {
    link_native_objects_with_options(objs, false)
}

/// Link with explicit options. `allow_undefined` lets an unresolved
/// `STB_GLOBAL` reference become a runtime import resolved at load
/// time (flat-namespace Mach-O bind / undefined ELF `.dynsym` entry)
/// rather than a link error -- the convention for a shared library
/// whose external references the host executable supplies through a
/// `dlopen` global scope.
pub fn link_native_objects_with_options(
    objs: &[NativeObject],
    allow_undefined: bool,
) -> Result<MergedNative, C5Error> {
    link_native_objects_with_shared_libs(objs, allow_undefined, &[])
}

/// Link, resolving otherwise-undefined references against the exports
/// of the given shared libraries (the `-l<name>` inputs). A reference
/// a library exports becomes a runtime import; every referenced
/// library is recorded as a `DT_NEEDED` dependency, so the dynamic
/// loader binds the import at load time. This is how a system linker
/// resolves undefined references against a `.so` on the `-l` path.
pub fn link_native_objects_with_shared_libs<'a>(
    objs: &'a [NativeObject],
    allow_undefined: bool,
    shared_libs: &'a [SharedLibrary],
) -> Result<MergedNative, C5Error> {
    let mut link = Link::new(objs, allow_undefined, shared_libs)?;
    link.lay_out_tls()?;
    link.lay_out_sections();
    link.lay_out_init_fini_arrays();
    link.collect_definitions()?;
    link.collect_prologue_anchors();
    link.collect_local_functions();
    link.coalesce_commons();
    link.define_link_symbols();
    link.collect_import_facts();
    link.resolve_text_relocs()?;
    link.resolve_tls_fixups()?;
    link.resolve_data_relocs()?;
    link.finish()
}

/// The state one native link accumulates. Each pass is a method;
/// [`link_native_objects_with_shared_libs`] states their order.
///
/// Symbol resolution runs over borrowed names in hash tables: a large
/// link resolves hundreds of thousands of references against tens of
/// thousands of definitions, and an ordered string-keyed map pays a
/// chain of comparisons per lookup. `MergedNative::defined` is
/// rebuilt as an ordered map at the end -- the image writers iterate
/// it, and their output order is part of the produced image.
struct Link<'a> {
    objs: &'a [NativeObject],
    machine: NativeMachine,
    allow_undefined: bool,
    shared_libs: &'a [SharedLibrary],
    /// Union of every shared library's exports: an undefined global
    /// reference whose name appears here is a load-time import, not a
    /// link error.
    shlib_exports: hashbrown::HashSet<&'a str>,
    /// The data-object subset. A reference to one resolves to the
    /// object's address through the GOT (a data import), never to a
    /// PLT stub -- a stub is code, so reading the object through it
    /// returns instructions.
    shlib_data_exports: hashbrown::HashSet<&'a str>,

    /// Each unit's base in the merged TLS block (0 for units with no
    /// TLS storage, which contribute nothing).
    tls_bases: Vec<usize>,
    tls_data: Vec<u8>,
    tls_init_size: usize,
    tls_align: usize,
    /// Each defined `_Thread_local` at its unit base plus its offset
    /// within that unit's block.
    tls_symbol_offsets: HashMap<&'a str, u64>,

    text: Vec<u8>,
    text_bases: Vec<usize>,
    text_align: usize,
    /// The file-backed data of every unit as one offset space: every
    /// unit's read-only payload first, then every unit's relro payload,
    /// then every unit's writable payload, then the zero-fill tail.
    /// `data_ro_len` / `data_relro_len` mark the boundaries: the image
    /// writers map the prefix read-only from the file and cover the
    /// relro region with `PT_GNU_RELRO`.
    data: Vec<u8>,
    data_align: usize,
    data_ro_len: usize,
    data_relro_len: usize,
    bss_size: usize,
    /// Where each unit's family blob landed; sections whose name is a
    /// C identifier were moved out to group by name across units.
    ro_map: Vec<BlobMap>,
    relro_map: Vec<BlobMap>,
    rw_map: Vec<BlobMap>,
    bss_map: Vec<BlobMap>,
    /// One `__start_` / `__stop_` pair per grouped name.
    start_stop_bounds: Vec<(String, NativeSymSection, u64)>,
    named_sections: Vec<crate::c5::codegen::NamedSection>,
    section_map: SectionMap,
    /// Constructors and destructors as `(priority, merged text
    /// offset)`, in run order.
    init_entries: Vec<(Option<u32>, u64)>,
    fini_entries: Vec<(Option<u32>, u64)>,
    /// `[start, end)` of each pointer array in the data stream.
    init_array: (u64, u64),
    fini_array: (u64, u64),

    defined: HashMap<Cow<'a, str>, MergedSymbol>,
    /// `SHN_ABS` definitions: a link-time constant, not a position in
    /// any merged section, so no `MergedSymbol` and no image base.
    absolute_defined: HashMap<&'a str, i64>,
    /// Function entry -> post-prologue offset, in merged text.
    prologue_ends: HashMap<u64, u64>,
    /// `STT_FUNC` `STB_LOCAL` text symbols; a flat list, so two units'
    /// same-named statics both survive.
    local_funcs: Vec<(String, u64)>,

    imports: Vec<String>,
    import_idx_for_name: HashMap<&'a str, usize>,
    /// Names admitted as flat-namespace imports (a shared library's
    /// references the host supplies at `dlopen`, or a `-l` export).
    flat_imports: BTreeSet<String>,
    /// Local names bound to a host data symbol via `#pragma
    /// binding(data ...)`; their references reach the merged table as
    /// UNDEF and route through the GOT.
    data_binding_locals: hashbrown::HashSet<&'a str>,
    /// Names any unit references as data through an undefined symbol;
    /// the symbol table types every undefined reference STT_NOTYPE.
    extern_data_names: hashbrown::HashSet<&'a str>,
    /// Names with dylib routing from any unit's binding map.
    routed_import_names: hashbrown::HashSet<&'a str>,
    /// Import indices the note channel names as data references, and
    /// those some site branches to; a branch makes the import code.
    object_imports: BTreeSet<usize>,
    branch_imports: BTreeSet<usize>,

    pending_imports: Vec<PendingImportReloc>,
    applied_text_relocs: Vec<AppliedTextReloc>,
    data_abs_relocs: Vec<DataAbsReloc>,
    data_pcrel_relocs: Vec<DataPcRel>,
    /// Data slots that name an imported function; the PLT pass turns
    /// each into a stub-targeting `DataAbsReloc`.
    data_import_refs: Vec<(u64, usize)>,
    /// `.rela.tdata` slots, resolved like `.rela.data` ones.
    tls_abs_relocs: Vec<DataAbsReloc>,
}

impl<'a> Link<'a> {
    fn new(
        objs: &'a [NativeObject],
        allow_undefined: bool,
        shared_libs: &'a [SharedLibrary],
    ) -> Result<Link<'a>, C5Error> {
        if objs.is_empty() {
            return Err(internal_err(
                MODULE,
                "link_native_objects: no input objects",
            ));
        }
        let machine = objs[0].machine;
        for (i, obj) in objs.iter().enumerate().skip(1) {
            if obj.machine != machine {
                return Err(internal_err(
                    MODULE,
                    &format!(
                        "link_native_objects: object {i}'s machine {:?} differs from object 0's {:?}",
                        obj.machine, machine,
                    ),
                ));
            }
        }
        Ok(Link {
            objs,
            machine,
            allow_undefined,
            shared_libs,
            shlib_exports: shared_libs
                .iter()
                .flat_map(|l| l.exports.iter().map(String::as_str))
                .collect(),
            shlib_data_exports: shared_libs
                .iter()
                .flat_map(|l| l.data_exports.iter().map(String::as_str))
                .collect(),
            tls_bases: Vec::new(),
            tls_data: Vec::new(),
            tls_init_size: 0,
            tls_align: crate::c5::layout::TLS_ALIGN_MIN,
            tls_symbol_offsets: HashMap::new(),
            text: Vec::new(),
            text_bases: Vec::with_capacity(objs.len()),
            text_align: 16,
            data: Vec::new(),
            data_align: crate::c5::layout::DATA_ALIGN_MIN,
            data_ro_len: 0,
            data_relro_len: 0,
            bss_size: 0,
            ro_map: Vec::with_capacity(objs.len()),
            relro_map: Vec::with_capacity(objs.len()),
            rw_map: Vec::with_capacity(objs.len()),
            bss_map: Vec::with_capacity(objs.len()),
            start_stop_bounds: Vec::new(),
            named_sections: Vec::new(),
            section_map: SectionMap::default(),
            init_entries: Vec::new(),
            fini_entries: Vec::new(),
            init_array: (0, 0),
            fini_array: (0, 0),
            defined: HashMap::new(),
            absolute_defined: HashMap::new(),
            prologue_ends: HashMap::new(),
            local_funcs: Vec::new(),
            imports: Vec::new(),
            import_idx_for_name: HashMap::new(),
            flat_imports: BTreeSet::new(),
            data_binding_locals: hashbrown::HashSet::new(),
            extern_data_names: hashbrown::HashSet::new(),
            routed_import_names: hashbrown::HashSet::new(),
            object_imports: BTreeSet::new(),
            branch_imports: BTreeSet::new(),
            pending_imports: Vec::new(),
            applied_text_relocs: Vec::new(),
            data_abs_relocs: Vec::new(),
            data_pcrel_relocs: Vec::new(),
            data_import_refs: Vec::new(),
            tls_abs_relocs: Vec::new(),
        })
    }

    /// Merged offset of a symbol `unit` defines in one of the streams,
    /// or `None` for a symbol no stream holds.
    fn unit_symbol_offset(
        &self,
        unit: usize,
        section: NativeSymSection,
        value: u64,
    ) -> Option<u64> {
        Some(match section {
            NativeSymSection::Text => self.text_bases[unit] as u64 + value,
            NativeSymSection::RoData => self.ro_map[unit].at(value),
            NativeSymSection::RelRo => self.relro_map[unit].at(value),
            NativeSymSection::Data => self.rw_map[unit].at(value),
            NativeSymSection::Bss => self.bss_map[unit].at(value),
            _ => return None,
        })
    }

    /// `_Thread_local` storage. The Mach-O TLV model resolves each
    /// access by a `__thread_vars` descriptor whose per-thread offset
    /// the linker fills, so multiple units' TLS blocks concatenate
    /// freely: each unit contributes [init bytes ++ zero-fill] to one
    /// merged block at its own alignment, and a descriptor's offset is
    /// rebased by the unit's base (a unit-local access) or set from the
    /// merged TLS symbol table (a cross-unit `extern _Thread_local`).
    /// The ELF and Windows/aarch64 paths achieve the same through
    /// `NT_BADC_ELF_TPOFF` fixups resolved in `resolve_tls_fixups`, so a
    /// multi-unit link rebases each access against the merged layout.
    /// The merged block's alignment is the largest unit alignment.
    fn lay_out_tls(&mut self) -> Result<(), C5Error> {
        let objs = self.objs;
        let uses_tlv = objs.iter().any(|o| {
            !o.macho_tlv_descriptors.is_empty()
                || !o.macho_tlv_fixups.is_empty()
                || !o.macho_tlv_descriptor_syms.is_empty()
        });
        let elf_tpoff_resolved =
            matches!(self.machine, NativeMachine::X86_64 | NativeMachine::Aarch64);
        let tls_objs: Vec<&NativeObject> = objs
            .iter()
            .filter(|o| !o.tls_data.is_empty() || o.tls_bss_size > 0)
            .collect();
        if !uses_tlv && !elf_tpoff_resolved && tls_objs.len() > 1 {
            return Err(link_err(
                Code::LINK,
                MODULE,
                "link_native_objects: more than one input object carries \
                 `_Thread_local` storage -- merging multiple TLS blocks needs \
                 per-unit TPOFF relocations against the merged layout, which \
                 aren't wired yet (TODO). Combine the `_Thread_local` \
                 definitions into a single translation unit.",
            ));
        }
        self.tls_bases = alloc::vec![0; objs.len()];
        let mut any_tls_init = false;
        for (i, obj) in objs.iter().enumerate() {
            if obj.tls_data.is_empty() && obj.tls_bss_size == 0 {
                continue;
            }
            let base = align_usize(self.tls_data.len(), obj.tls_align.max(1));
            self.tls_data.resize(base, 0);
            self.tls_bases[i] = base;
            self.tls_align = self.tls_align.max(obj.tls_align);
            if !obj.tls_data.is_empty() {
                any_tls_init = true;
            }
            self.tls_data.extend_from_slice(&obj.tls_data);
            self.tls_data
                .resize(self.tls_data.len() + obj.tls_bss_size, 0);
        }
        // The init boundary. Concatenating several units' [init ++
        // zero-fill] blocks has no single `.tdata` / `.tbss` split
        // point, so when more than one unit contributes the whole
        // merged block is emitted as initialised data (the zero-fill
        // regions are already zero bytes) when any unit carries an init
        // template. A single TLS unit keeps the `.tdata` / `.tbss`
        // split the writer expects, so its zero-fill stays out of the
        // file image.
        let multi_tls = tls_objs.len() > 1;
        self.tls_init_size = if uses_tlv || (elf_tpoff_resolved && multi_tls) {
            if any_tls_init { self.tls_data.len() } else { 0 }
        } else {
            tls_objs.first().map(|o| o.tls_data.len()).unwrap_or(0)
        };
        for (i, obj) in objs.iter().enumerate() {
            for (name, off, _size) in &obj.tls_symbols {
                self.tls_symbol_offsets
                    .insert(name.as_str(), self.tls_bases[i] as u64 + off);
            }
        }
        Ok(())
    }

    /// Each unit's `.text` / `.rodata` / `.data` / `.bss` base in the
    /// merged image: 16-byte alignment for `.text` (matches the
    /// writer's section header) and 8-byte for `.data` / `.bss`, raised
    /// to a unit's own data alignment (a foreign object's high-align
    /// sections, e.g. `.rodata.cst16`). Keeping one data space means a
    /// parked data reference carries one kind of offset no matter which
    /// region it hits.
    fn lay_out_sections(&mut self) {
        let objs = self.objs;
        let bss_align = bss_alignment(objs);
        let mut rodata_align: usize = crate::c5::layout::DATA_ALIGN_MIN;
        let mut relro_align: usize = crate::c5::layout::DATA_ALIGN_MIN;
        // Sections whose name is a C identifier keep their identity: the
        // parse sorted them to the end of their family blob, and the
        // merge moves that suffix out to group every unit's
        // contribution to one name together, so `__start_` / `__stop_`
        // can bound it.
        let mut named_extents: Vec<NamedExtent> = Vec::new();
        for obj in objs {
            align_up(&mut self.text, obj.text_align.max(16));
            self.text_align = self.text_align.max(obj.text_align);
            self.text_bases.push(self.text.len());
            self.text.extend_from_slice(&obj.text);
            align_up(
                &mut self.data,
                crate::c5::layout::data_image_align(obj.rodata_align),
            );
            rodata_align = rodata_align.max(obj.rodata_align);
            relro_align = relro_align.max(obj.relro_align);
            let keep = named_prefix_len(obj, SectionFamily::RoData, obj.rodata.len() as u64);
            self.ro_map.push(BlobMap::new(self.data.len() as u64, keep));
            self.data.extend_from_slice(&obj.rodata[..keep as usize]);
            self.data_align = self.data_align.max(obj.data_align);
        }
        group_named_bytes(
            &mut self.data,
            objs,
            SectionFamily::RoData,
            |o| &o.rodata,
            &mut self.ro_map,
            NativeSymSection::Data,
            &mut named_extents,
        );
        // One alignment covers the whole data image: the writers place
        // every region from it, and each region starts at a multiple of
        // it so a unit's data base keeps the residue its `sh_addralign`
        // asked for once the region is placed. The bss tail is one more
        // region in the same offset space, so its alignment counts here
        // too.
        self.data_align = crate::c5::layout::data_image_align(
            self.data_align
                .max(rodata_align)
                .max(relro_align)
                .max(bss_align),
        );
        align_up(&mut self.data, self.data_align);
        self.data_ro_len = self.data.len();
        for obj in objs {
            align_up(
                &mut self.data,
                crate::c5::layout::data_image_align(obj.relro_align),
            );
            let keep = named_prefix_len(obj, SectionFamily::RelRo, obj.relro.len() as u64);
            self.relro_map
                .push(BlobMap::new(self.data.len() as u64, keep));
            self.data.extend_from_slice(&obj.relro[..keep as usize]);
        }
        group_named_bytes(
            &mut self.data,
            objs,
            SectionFamily::RelRo,
            |o| &o.relro,
            &mut self.relro_map,
            NativeSymSection::Data,
            &mut named_extents,
        );
        align_up(&mut self.data, self.data_align);
        self.data_relro_len = self.data.len();
        for obj in objs {
            align_up(
                &mut self.data,
                crate::c5::layout::data_image_align(obj.data_align),
            );
            let keep = named_prefix_len(obj, SectionFamily::Data, obj.data.len() as u64);
            self.rw_map.push(BlobMap::new(self.data.len() as u64, keep));
            self.data.extend_from_slice(&obj.data[..keep as usize]);
            // Each unit's bss offsets carry an alignment residue modulo
            // the widest `.bss` sh_addralign the unit claims; a unit base
            // aligned to the same value preserves it.
            self.bss_size = align_usize(
                self.bss_size,
                crate::c5::layout::bss_image_align(obj.bss_align),
            );
            let keep = named_prefix_len(obj, SectionFamily::Bss, obj.bss_size as u64);
            self.bss_map.push(BlobMap::new(self.bss_size as u64, keep));
            self.bss_size += keep as usize;
        }
        group_named_bytes(
            &mut self.data,
            objs,
            SectionFamily::Data,
            |o| &o.data,
            &mut self.rw_map,
            NativeSymSection::Data,
            &mut named_extents,
        );
        group_named_zerofill(
            &mut self.bss_size,
            objs,
            &mut self.bss_map,
            &mut named_extents,
        );
        self.start_stop_bounds = named_extents
            .iter()
            .flat_map(|e| {
                [
                    (format!("__start_{}", e.name), e.sec, e.start),
                    (format!("__stop_{}", e.name), e.sec, e.end),
                ]
            })
            .collect();
        // The same extents as output sections, for a writer that gives
        // each its own header rather than folding it into the family.
        self.named_sections = named_extents
            .iter()
            .map(|e| crate::c5::codegen::NamedSection {
                name: e.name.clone(),
                offset: e.start,
                size: e.end - e.start,
                align: e.align,
                bss: e.bss,
                write: e.write,
            })
            .collect();

        // Per-input-section placement: each record's stream offset is
        // the owning unit's family base plus the section's offset
        // within that unit's blob.
        for (i, obj) in objs.iter().enumerate() {
            self.section_map.sources.push(obj.source.clone());
            for (name, size) in &obj.discarded {
                self.section_map.discarded.push((i, name.clone(), *size));
            }
            for s in &obj.sections {
                let (list, offset) = match s.family {
                    SectionFamily::Text => (
                        &mut self.section_map.text,
                        self.text_bases[i] as u64 + s.offset,
                    ),
                    SectionFamily::RoData => {
                        (&mut self.section_map.data, self.ro_map[i].at(s.offset))
                    }
                    SectionFamily::RelRo => {
                        (&mut self.section_map.data, self.relro_map[i].at(s.offset))
                    }
                    SectionFamily::Data => {
                        (&mut self.section_map.data, self.rw_map[i].at(s.offset))
                    }
                    SectionFamily::Bss => (&mut self.section_map.bss, self.bss_map[i].at(s.offset)),
                    SectionFamily::Tdata | SectionFamily::Tbss => (
                        &mut self.section_map.tls,
                        self.tls_bases[i] as u64 + s.offset,
                    ),
                    SectionFamily::Discard => continue,
                };
                list.push(SectionContribution {
                    input: Some(i),
                    name: s.name.clone(),
                    offset,
                    size: s.size,
                });
            }
        }
    }

    /// `.init_array` / `.fini_array`: every unit's constructor and
    /// destructor entries, rebased to merged `.text` offsets and
    /// ordered prioritized ascending, then unprioritized in link order
    /// (a stable sort over `(priority.is_none(), priority)` keeps each
    /// unit's slot order). Two contiguous pointer arrays are appended
    /// to `.data`; the startup runtime walks `[__init_array_start,
    /// __init_array_end)` forward before `main` and the fini array
    /// backward after. Each 8-byte slot is a `.text` pointer, so a
    /// `DataAbsReloc` gives the PIE its load-time R_*_RELATIVE.
    fn lay_out_init_fini_arrays(&mut self) {
        for (i, obj) in self.objs.iter().enumerate() {
            for f in &obj.init_funcs {
                let off = self.text_bases[i] as u64 + f.unit_text_offset;
                if f.is_destructor {
                    self.fini_entries.push((f.priority, off));
                } else {
                    self.init_entries.push((f.priority, off));
                }
            }
        }
        self.init_entries
            .sort_by_key(|&(p, _)| (p.is_none(), p.unwrap_or(0)));
        self.fini_entries
            .sort_by_key(|&(p, _)| (p.is_none(), p.unwrap_or(0)));
        // A program with no constructors gets no `.data` change (start
        // == end leaves the runtime's walk a no-op); only touch the
        // layout when there is something to lay out, so existing data
        // offsets are stable.
        if self.init_entries.is_empty() && self.fini_entries.is_empty() {
            let at = self.data.len() as u64;
            self.init_array = (at, at);
            self.fini_array = (at, at);
        } else {
            align_up(&mut self.data, 8);
            let init_start = self.data.len() as u64;
            self.data
                .resize(self.data.len() + self.init_entries.len() * 8, 0);
            let init_end = self.data.len() as u64;
            let fini_start = self.data.len() as u64;
            self.data
                .resize(self.data.len() + self.fini_entries.len() * 8, 0);
            let fini_end = self.data.len() as u64;
            self.init_array = (init_start, init_end);
            self.fini_array = (fini_start, fini_end);
        }
        for (name, (start, end)) in [
            (".init_array", self.init_array),
            (".fini_array", self.fini_array),
        ] {
            if end > start {
                self.section_map.data.push(SectionContribution {
                    input: None,
                    name: name.to_string(),
                    offset: start,
                    size: end - start,
                });
            }
        }
        // The end symbol is a one-past-the-array `.data` address. These
        // arrays are the last `.data` content, so if one ends exactly
        // at the `.data` length the offset->vaddr map (which treats an
        // offset at `data.len()` as the first `.bss` byte) resolves the
        // end symbol into `.bss` -- and with a `.tbss` gap between
        // `.data` and `.bss` the two addresses differ, so the walk
        // overruns the array into zero padding and calls a null
        // pointer. Keep the arrays strictly inside `.data`.
        if self.fini_array.1 > self.init_array.0 {
            self.data.resize(self.data.len() + 8, 0);
        }
        // The merged bss region begins at `data.len()` in the unified
        // data-offset space; pad the file image so bss offsets keep
        // their per-unit alignment residues in the final image.
        // `data_align` covers the bss alignment, so the padded end and
        // the region boundaries before it are bss boundaries wherever
        // the writers place the stream.
        if self.bss_size > 0 {
            align_up(
                &mut self.data,
                crate::c5::layout::bss_image_align(self.data_align),
            );
        }
    }

    /// Every `STB_GLOBAL` symbol that lives in a `.text` / `.data` /
    /// `.bss` section in some unit becomes a defined entry at the
    /// matching base + the unit-local offset; two definitions of one
    /// name error out, the ELF rule for `STB_GLOBAL`. An `STB_WEAK`
    /// definition is real but overridable: a strong definition of the
    /// same name wins silently, and a weak one on its own satisfies a
    /// reference.
    fn collect_definitions(&mut self) -> Result<(), C5Error> {
        let mut weak_defined: HashMap<&'a str, MergedSymbol> = HashMap::new();
        let mut weak_absolute: HashMap<&'a str, i64> = HashMap::new();
        for (i, obj) in self.objs.iter().enumerate() {
            for sym in &obj.symbols {
                // STB_LOCAL (0) routes through the static-func pass;
                // only STB_GLOBAL (1) and STB_WEAK (2) join the merged
                // table here.
                if sym.binding != 1 && sym.binding != 2 {
                    continue;
                }
                if sym.section == NativeSymSection::Abs {
                    if sym.name.is_empty() {
                        continue;
                    }
                    if sym.binding == 2 {
                        weak_absolute
                            .entry(sym.name.as_str())
                            .or_insert(sym.value as i64);
                    } else if let Some(prev) = self
                        .absolute_defined
                        .insert(sym.name.as_str(), sym.value as i64)
                        && prev != sym.value as i64
                    {
                        return Err(link_err(
                            Code::DUPLICATE_SYMBOL,
                            MODULE,
                            &format!(
                                "multiple definition of `{}` (first {prev:#x}, also {:#x})",
                                sym.name, sym.value,
                            ),
                        ));
                    }
                    continue;
                }
                if sym.section == NativeSymSection::Undef {
                    continue;
                }
                if sym.name.is_empty() {
                    continue;
                }
                // A `_Thread_local` definition reaches the merged image
                // through the TLS symbol table, a DWARF section symbol
                // through the debug-section rebasing; neither belongs
                // in the address-resolving table.
                let Some(value) = self.unit_symbol_offset(i, sym.section, sym.value) else {
                    continue;
                };
                // `RoData` / `RelRo` normalise to `Data`: both payloads
                // lie in the data-byte space, so the merged table speaks
                // one space.
                let section = match sym.section {
                    NativeSymSection::RoData | NativeSymSection::RelRo => NativeSymSection::Data,
                    other => other,
                };
                let merged = MergedSymbol {
                    section,
                    value,
                    size: sym.size,
                    kind: sym.kind,
                    visibility: sym.visibility,
                    weak: sym.binding == 2,
                };
                if sym.binding == 2 {
                    // Multiple weak definitions -- keep the first, no
                    // error.
                    weak_defined.entry(sym.name.as_str()).or_insert(merged);
                    continue;
                }
                if let Some(prev) = self.defined.get(sym.name.as_str()) {
                    return Err(link_err(
                        Code::DUPLICATE_SYMBOL,
                        MODULE,
                        &format!(
                            "multiple definition of `{}` (first at offset 0x{:x}, also at 0x{:x})",
                            sym.name, prev.value, merged.value,
                        ),
                    ));
                }
                self.defined
                    .insert(Cow::Borrowed(sym.name.as_str()), merged);
            }
        }
        for (name, merged) in weak_defined {
            self.defined.entry(Cow::Borrowed(name)).or_insert(merged);
        }
        for (name, value) in weak_absolute {
            self.absolute_defined.entry(name).or_insert(value);
        }
        Ok(())
    }

    /// Each unit's `NT_BADC_PROLOGUE_END` note carries (function entry,
    /// post-prologue) `.text` offset pairs; rebasing both by that
    /// unit's text base keys each anchor on the entry it belongs to.
    /// Two units' same-named statics therefore keep separate anchors,
    /// where a name-keyed lookup would describe one as frameless in the
    /// Win-x64 .pdata / DWARF CFA output.
    fn collect_prologue_anchors(&mut self) {
        for (i, obj) in self.objs.iter().enumerate() {
            let base = self.text_bases[i] as u64;
            for &(entry, post) in &obj.prologue_ends {
                self.prologue_ends.insert(base + entry, base + post);
            }
        }
    }

    fn collect_local_functions(&mut self) {
        for (i, obj) in self.objs.iter().enumerate() {
            for sym in &obj.symbols {
                // STB_GLOBAL = 1, STT_FUNC = 2.
                if sym.binding == 1
                    || sym.kind != 2
                    || !matches!(sym.section, NativeSymSection::Text)
                    || sym.name.is_empty()
                {
                    continue;
                }
                self.local_funcs
                    .push((sym.name.clone(), self.text_bases[i] as u64 + sym.value));
            }
        }
    }

    /// Coalesce SHN_COMMON tentative definitions (C99 6.9.2). For each
    /// Common symbol name no strong entry defines, accumulate
    /// `max(size)` and `max(alignment)` across every unit that declares
    /// it, reserve one zero-init slot per name past the per-unit `.bss`
    /// extent, and surface the slot as a Bss-defined merged symbol.
    /// Name-ordered, so the `.bss` layout does not depend on the order
    /// the units happen to declare the names in. The section map
    /// attributes the slot to the first declaring unit, the way ld's
    /// map reports a COMMON allocation under an object.
    fn coalesce_commons(&mut self) {
        let mut common_max: BTreeMap<&'a str, (u64, u64, usize)> = BTreeMap::new();
        for (i, obj) in self.objs.iter().enumerate() {
            for sym in &obj.symbols {
                if !matches!(sym.section, NativeSymSection::Common) {
                    continue;
                }
                if sym.name.is_empty() || self.defined.contains_key(sym.name.as_str()) {
                    continue;
                }
                let entry = common_max.entry(sym.name.as_str()).or_insert((0, 1, i));
                entry.0 = entry.0.max(sym.size);
                entry.1 = entry.1.max(sym.value.max(1));
            }
        }
        for (name, (size, align, unit)) in &common_max {
            let align = (*align).max(1) as usize;
            self.bss_size = align_usize(self.bss_size, align);
            let slot_offset = self.bss_size as u64;
            self.bss_size += *size as usize;
            self.defined.insert(
                Cow::Borrowed(name),
                MergedSymbol {
                    section: NativeSymSection::Bss,
                    value: slot_offset,
                    size: *size,
                    kind: super::object::STT_OBJECT,
                    visibility: super::object::STV_DEFAULT,
                    weak: false,
                },
            );
            self.section_map.bss.push(SectionContribution {
                input: Some(*unit),
                name: "COMMON".to_string(),
                offset: slot_offset,
                size: *size,
            });
        }
    }

    /// The symbols the link itself defines: the init/fini array bounds
    /// (always, so the runtime's references never dangle; an empty
    /// array leaves start == end), the GOT base, and the `__start_` /
    /// `__stop_` pair of each grouped section. bfd defines the latter
    /// two only where nothing else does, so an object that already
    /// defines the name keeps its definition -- `__start_tty` is an
    /// ordinary function in one such tree.
    fn define_link_symbols(&mut self) {
        for (name, off) in [
            ("__init_array_start", self.init_array.0),
            ("__init_array_end", self.init_array.1),
            ("__fini_array_start", self.fini_array.0),
            ("__fini_array_end", self.fini_array.1),
        ] {
            self.defined.insert(
                Cow::Borrowed(name),
                MergedSymbol {
                    section: NativeSymSection::Data,
                    value: off,
                    size: 0,
                    // A boundary address, not an object: the same
                    // `STT_NOTYPE` the reference toolchain gives `_edata`
                    // and `__bss_start`.
                    kind: super::object::STT_NOTYPE,
                    visibility: super::object::STV_DEFAULT,
                    weak: false,
                },
            );
        }
        // The psABIs make the GOT base a linker-defined local OBJECT on
        // the section holding the GOT; hand-written PIC computes the
        // base from it. Its address belongs to the image writer, so the
        // entry names the section and carries offset zero.
        if !self.defined.contains_key(GOT_BASE_SYMBOL) {
            self.defined.insert(
                Cow::Borrowed(GOT_BASE_SYMBOL),
                MergedSymbol {
                    section: NativeSymSection::Got,
                    value: 0,
                    size: 0,
                    kind: super::object::STT_OBJECT,
                    visibility: super::object::STV_DEFAULT,
                    weak: false,
                },
            );
        }
        for (sym, section, value) in &self.start_stop_bounds {
            if self.defined.contains_key(sym.as_str()) {
                continue;
            }
            self.defined.insert(
                Cow::Owned(sym.clone()),
                MergedSymbol {
                    section: *section,
                    value: *value,
                    size: 0,
                    kind: super::object::STT_NOTYPE,
                    visibility: super::object::STV_DEFAULT,
                    weak: false,
                },
            );
        }
    }

    /// The per-unit facts the import passes consult: data bindings,
    /// names referenced as data, and dylib routing.
    fn collect_import_facts(&mut self) {
        let objs = self.objs;
        self.data_binding_locals = objs
            .iter()
            .flat_map(|o| o.copy_relocs.iter().map(|(local, _host)| local.as_str()))
            .collect();
        self.extern_data_names = objs
            .iter()
            .flat_map(|o| o.extern_data_names.iter().map(|n| n.as_str()))
            .collect();
        // The c5 `.o` writer emits its libc imports as STB_WEAK UNDEF
        // paired with a map entry; a weak UNDEF without routing is a
        // genuine unresolved weak reference (typically from a foreign
        // object) and resolves to address 0 per ELF practice rather
        // than becoming a required import.
        self.routed_import_names = objs
            .iter()
            .flat_map(|o| o.import_dylib_map.iter().map(|(n, _)| n.as_str()))
            .collect();
    }

    /// Whether any unit routes `name` to a dylib. A binding map keys an
    /// entry by the host symbol, which on Mach-O carries the platform's
    /// leading underscore that the object readers strip; test both
    /// spellings so a reference from a foreign object matches. The
    /// import is still recorded under the reference's own name -- the
    /// per-format writer re-applies the platform prefix.
    fn is_routed_import(&self, name: &str) -> bool {
        self.routed_import_names.contains(name)
            || self
                .routed_import_names
                .contains(alloc::format!("_{name}").as_str())
    }

    fn record_import(&mut self, name: &'a str) -> usize {
        if let Some(&i) = self.import_idx_for_name.get(name) {
            return i;
        }
        let i = self.imports.len();
        self.imports.push(name.to_string());
        self.import_idx_for_name.insert(name, i);
        i
    }

    /// Walk each unit's `text_relocs`, resolve each against the merged
    /// symbol table, and apply the patch in `text` at the unit's base
    /// plus the site offset, or park it for the writer.
    fn resolve_text_relocs(&mut self) -> Result<(), C5Error> {
        let objs = self.objs;
        for (i, obj) in objs.iter().enumerate() {
            let origin = RelocOrigin::in_object(obj, SectionFamily::Text);
            for reloc in &obj.text_relocs {
                let sym = obj.symbols.get(reloc.sym_idx).ok_or_else(|| {
                    internal_err(MODULE, &format!(
                        "link_native_objects: object {i} reloc references symbol index {} out of \
                         range ({} symbols)",
                        reloc.sym_idx,
                        obj.symbols.len(),
                    ))
                })?;
                let patch_offset = self.text_bases[i] + reloc.offset as usize;
                // Local-exec TLS relocations duplicate the note-channel
                // TLS fixups for external linkers; `resolve_tls_fixups`
                // patches the same sites from the fixup records. Other
                // TLS models (initial-exec / general-dynamic, from
                // foreign objects) still land in the
                // `NativeSymSection::Tls` arm and error.
                if reloc.rtype == R_X86_64_TPOFF32
                    || reloc.rtype == R_AARCH64_TLSLE_ADD_TPREL_HI12
                    || reloc.rtype == R_AARCH64_TLSLE_ADD_TPREL_LO12_NC
                {
                    continue;
                }
                // An STB_WEAK definition is overridable: a strong
                // definition of the same name in a sibling unit wins
                // (ELF/SysV). Resolve it through the merged table
                // instead of this unit's copy, which is what the UNDEF
                // arm already does.
                let sym_section = if sym.binding == 2 {
                    NativeSymSection::Undef
                } else {
                    sym.section
                };
                let resolved_here = !matches!(sym_section, NativeSymSection::Undef)
                    || self.defined.contains_key(sym.name.as_str());
                let relaxed = self.relax_got_reference(reloc, patch_offset, resolved_here);
                let reloc = relaxed.as_ref().unwrap_or(reloc);
                let site = origin.at(self.machine, reloc.rtype, &sym.name, reloc.offset);
                self.resolve_text_reloc(i, sym, sym_section, reloc, patch_offset, &site)?;
            }
        }
        Ok(())
    }

    /// A GOT reference whose symbol this link defines needs no
    /// indirection, so it relaxes to a direct reference: the aarch64
    /// `adrp :got:` + `ldr` pair becomes ADR_PREL / ADD_ABS with the
    /// `ldr` rewritten back to the `add` it came from, the x86_64
    /// `mov reg, [rip+disp32]` GOT load becomes the `lea` it came from
    /// (opcode 0x8b -> 0x8d, two bytes before the disp32) resolved as a
    /// direct PC32. A reference the link cannot resolve keeps the GOT:
    /// the slot is where the loader writes the symbol's address, and
    /// the relaxed form would instead materialize an address inside
    /// this image -- for an import, its call stub.
    fn relax_got_reference(
        &mut self,
        reloc: &NativeReloc,
        patch_offset: usize,
        resolved_here: bool,
    ) -> Option<NativeReloc> {
        if !resolved_here {
            return None;
        }
        if reloc.rtype == R_AARCH64_ADR_GOT_PAGE || reloc.rtype == R_AARCH64_LD64_GOT_LO12_NC {
            if reloc.rtype == R_AARCH64_LD64_GOT_LO12_NC && patch_offset + 4 <= self.text.len() {
                let ldr = u32::from_le_bytes([
                    self.text[patch_offset],
                    self.text[patch_offset + 1],
                    self.text[patch_offset + 2],
                    self.text[patch_offset + 3],
                ]);
                let add = 0x9100_0000u32 | (ldr & 0x3ff); // add Xrd, Xrn, #0
                self.text[patch_offset..patch_offset + 4].copy_from_slice(&add.to_le_bytes());
            }
            return Some(NativeReloc {
                rtype: if reloc.rtype == R_AARCH64_ADR_GOT_PAGE {
                    R_AARCH64_ADR_PREL_PG_HI21
                } else {
                    R_AARCH64_ADD_ABS_LO12_NC
                },
                ..*reloc
            });
        }
        if reloc.rtype == R_X86_64_GOTPCREL || reloc.rtype == R_X86_64_REX_GOTPCRELX {
            if patch_offset >= 2 && self.text[patch_offset - 2] == 0x8b {
                self.text[patch_offset - 2] = 0x8d;
            }
            return Some(NativeReloc {
                rtype: R_X86_64_PC32,
                ..*reloc
            });
        }
        None
    }

    fn resolve_text_reloc(
        &mut self,
        unit: usize,
        sym: &'a NativeSymbol,
        sym_section: NativeSymSection,
        reloc: &NativeReloc,
        patch_offset: usize,
        site: &RelocSite<'_>,
    ) -> Result<(), C5Error> {
        if let Some(at) = self.unit_symbol_offset(unit, sym_section, sym.value) {
            let target = merged_target(sym_section, at as i64, reloc.addend, self.data.len())?;
            return self.place_target(patch_offset, reloc, target, site);
        }
        match sym_section {
            NativeSymSection::Undef => {
                self.resolve_undefined_text_reloc(unit, sym, reloc, patch_offset, site)
            }
            NativeSymSection::Abs => {
                // `S + A` is a link-time constant, so the field takes it
                // here: no image base is involved and the value survives
                // a load-time slide unchanged.
                apply_absolute_reloc(
                    &mut self.text,
                    patch_offset,
                    sym.value as i64 + reloc.addend,
                    site,
                )
            }
            NativeSymSection::Common => {
                // C99 6.9.2 tentative definition: `coalesce_commons`
                // gave this name a `.bss` slot, so the merged table
                // already answers where it lands.
                let def = *self.defined.get(sym.name.as_str()).ok_or_else(|| {
                    internal_err(MODULE, &format!(
                        "link_native_objects: SHN_COMMON `{}` not coalesced (internal: coalesce_commons missed it)",
                        sym.name,
                    ))
                })?;
                let target =
                    merged_target(def.section, def.value as i64, reloc.addend, self.data.len())?;
                self.place_target(patch_offset, reloc, target, site)
            }
            NativeSymSection::Tls => Err(link_err(
                Code::RELOCATION,
                MODULE,
                &format!(
                    "reloc against `_Thread_local` symbol `{}` -- \
                 native-linker TLS lowering not yet wired",
                    sym.name,
                ),
            )),
            // `.rela.text` shouldn't target a DWARF section symbol; the
            // producer routes those through `.rela.debug_info` /
            // `.rela.debug_line` instead. No input symbol carries the
            // GOT section.
            NativeSymSection::DebugAbbrev
            | NativeSymSection::DebugLine
            | NativeSymSection::DebugStr
            | NativeSymSection::Got
            | NativeSymSection::Text
            | NativeSymSection::RoData
            | NativeSymSection::RelRo
            | NativeSymSection::Data
            | NativeSymSection::Bss => Err(internal_err(
                MODULE,
                &format!(
                    "link_native_objects: `.rela.text` reloc targets {:?} symbol",
                    sym.section,
                ),
            )),
        }
    }

    /// A reference this unit leaves undefined: a cross-unit reference
    /// to a definition, an absolute constant, or an import.
    fn resolve_undefined_text_reloc(
        &mut self,
        unit: usize,
        sym: &'a NativeSymbol,
        reloc: &NativeReloc,
        patch_offset: usize,
        site: &RelocSite<'_>,
    ) -> Result<(), C5Error> {
        let def = self.defined.get(sym.name.as_str()).copied();
        if def.map(|d| d.section) == Some(NativeSymSection::Got) {
            // The GOT's address is the image writer's to decide, so the
            // site waits for it like any other cross-section reference.
            return park_section_ref(
                &mut self.pending_imports,
                patch_offset,
                reloc,
                reloc.addend,
                NativeSymSection::Got,
                site,
            );
        }
        if let Some(def) = def {
            // Text-section targets can be patched in place because the
            // text segment's vmaddr is anchored before the merge runs;
            // data / bss targets depend on the final-image writer's
            // `.text`-to-`.data` gap, so they park through the same
            // path that local data refs use.
            let target =
                merged_target(def.section, def.value as i64, reloc.addend, self.data.len())
                    .map_err(|_| {
                        internal_err(
                            MODULE,
                            &format!(
                                "link_native_objects: defined entry for `{}` has \
                         non-progbits section {:?}",
                                sym.name, def.section,
                            ),
                        )
                    })?;
            return self.place_target(patch_offset, reloc, target, site);
        }
        if let Some(&value) = self.absolute_defined.get(sym.name.as_str()) {
            return apply_absolute_reloc(&mut self.text, patch_offset, value + reloc.addend, site);
        }
        if sym.name.is_empty() {
            // Every reloc the writer emits points at a named symbol.
            return Err(internal_err(
                MODULE,
                &format!(
                    "link_native_objects: reloc at object {unit} offset 0x{:x} points at \
                 unnamed UNDEF symbol",
                    reloc.offset,
                ),
            ));
        }
        self.admit_import(sym, reloc, patch_offset)
    }

    /// A reference the link set does not supply. STB_WEAK UNDEF entries
    /// with dylib routing are libc imports the dynamic linker resolves
    /// at load time; an unrouted weak reference resolves to address 0,
    /// as ELF leaves it, so the `if (fn) fn();` guard idiom skips the
    /// call -- unless a `-l` shared library exports the name, in which
    /// case it binds like a strong one, as a system linker binds it. A
    /// STB_GLOBAL UNDEF is an error, except under `allow_undefined` (a
    /// shared library), where it is a load-time import the host
    /// resolves through the `dlopen` global scope, or where a shared
    /// library or a binding supplies it.
    fn admit_import(
        &mut self,
        sym: &'a NativeSymbol,
        reloc: &NativeReloc,
        patch_offset: usize,
    ) -> Result<(), C5Error> {
        let name = sym.name.as_str();
        // A `#pragma binding(data ...)` local and a shared library's
        // data object are data imports: the reference reaches the object
        // through the GOT, never a PLT stub.
        let is_data_binding =
            self.data_binding_locals.contains(name) || self.shlib_data_exports.contains(name);
        // A site wanting the symbol's address takes no call stub -- a
        // stub is code. The relocation kind is the reference
        // toolchain's discriminator and survives here because an
        // unresolvable GOT reference stays unrelaxed; the note covers
        // the forms it does not classify, the aarch64 page-relative
        // pair that extern data and a function's address share. The
        // note names the symbol rather than the site, and one unit's
        // address-of puts an imported function there, so a branch
        // keeps its stub whatever the note says of the name.
        let slot_load = is_data_binding
            || is_got_reloc(reloc.rtype)
            || (!is_branch_reloc(self.machine, reloc.rtype)
                && self.extern_data_names.contains(name));
        let routed = self.is_routed_import(name);
        let shlib_exported = self.shlib_exports.contains(name);
        if sym.binding == 2 && !is_data_binding && !routed && !shlib_exported {
            return resolve_weak_undef_to_zero(
                self.machine,
                &mut self.text,
                patch_offset,
                reloc,
                &sym.name,
            );
        }
        // Dylib routing names a symbol, not a unit: once any unit's
        // binding map places the name in a dylib, every reference to it
        // in the link is that import. A foreign object (a Mach-O
        // archive member) states no routing of its own and reaches its
        // libc through this.
        if sym.binding == 1
            && !self.allow_undefined
            && !is_data_binding
            && !shlib_exported
            && !routed
        {
            return Err(link_err(
                Code::UNDEFINED_SYMBOL,
                MODULE,
                &format!("undefined reference to `{}`", sym.name,),
            ));
        }
        // A global UNDEF admitted here has no dylib routing; mark it
        // flat so the writer emits a load-time flat-namespace import. A
        // weak one admitted through a shared library's export needs the
        // same marking; a routed weak carries its own dylib assignment.
        if sym.binding == 1 || (sym.binding == 2 && shlib_exported && !routed) {
            self.flat_imports.insert(sym.name.clone());
        }
        let idx = self.record_import(name);
        if is_branch_reloc(self.machine, reloc.rtype) {
            self.branch_imports.insert(idx);
        } else if self.extern_data_names.contains(name) {
            self.object_imports.insert(idx);
        }
        self.pending_imports.push(PendingImportReloc {
            text_offset: patch_offset as u64,
            import_index: idx,
            rtype: reloc.rtype,
            addend: reloc.addend,
            target_section: NativeSymSection::Undef,
            slot_load,
            sym_name: None,
        });
        Ok(())
    }

    /// Apply or park a text relocation whose target is known.
    fn place_target(
        &mut self,
        patch_offset: usize,
        reloc: &NativeReloc,
        target: MergedTarget,
        site: &RelocSite<'_>,
    ) -> Result<(), C5Error> {
        resolve_merged_target(
            &mut self.text,
            &mut self.pending_imports,
            &mut self.applied_text_relocs,
            patch_offset,
            reloc,
            target,
            site,
        )
    }

    /// Each unit's `elf_tpoff_fixups` marks the instruction holding a
    /// TLS variable's offset immediate; the per-unit emit baked a
    /// single-unit default (or a 0 placeholder for an extern access),
    /// so each is re-resolved against the merged layout. The
    /// immediate's bias depends on the access model:
    ///   * x86_64 (Linux variant-2) places the block below the thread
    ///     pointer at `tp - roundup(memsz, align)`, `align` being the
    ///     writer's PT_TLS `p_align`, so the access computes `TP +
    ///     (merged_offset - roundup(merged_size, align))`.
    ///   * aarch64 Linux (variant-1) places the block above the thread
    ///     pointer after the 16-byte TCB, rounded up to `align`, so
    ///     `imm = roundup(16, align) + merged_offset` baked into an
    ///     `add` pair.
    ///   * Windows (both arches) reaches the block through the TEB's
    ///     TLS array (`r10`/`x16 = tls_array[_tls_index]`), so the
    ///     register already holds the module's block base and the
    ///     immediate is `merged_offset` with no bias (an x86_64 `lea`
    ///     disp32, an aarch64 `add` imm12).
    /// `machine` does not separate the Windows and ELF models; the
    /// Windows TEB sequence always records a `_tls_index` fixup, so an
    /// object carrying any such fixup uses the Windows no-bias offset.
    fn resolve_tls_fixups(&mut self) -> Result<(), C5Error> {
        let objs = self.objs;
        let merged_tls_total = align_usize(self.tls_data.len(), self.tls_align) as u64;
        let tcb_reserve = align_usize(16, self.tls_align) as u64;
        for (i, obj) in objs.iter().enumerate() {
            let win_teb = !obj.tls_index_fixups.is_empty();
            for (text_off, target) in &obj.elf_tpoff_fixups {
                let merged_offset = match target {
                    ElfTpoffTarget::Local(off) => self.tls_bases[i] as u64 + off,
                    ElfTpoffTarget::Extern(name) => {
                        match self.tls_symbol_offsets.get(name.as_str()) {
                            Some(o) => *o,
                            None => {
                                return Err(internal_err(
                                    MODULE,
                                    &format!(
                                        "link_native_objects: TLS access references undefined \
                                 `_Thread_local` symbol `{name}`",
                                    ),
                                ));
                            }
                        }
                    }
                };
                let patch = self.text_bases[i] + *text_off as usize;
                if patch + 4 > self.text.len() {
                    return Err(internal_err(
                        MODULE,
                        &format!(
                            "link_native_objects: TLS fixup offset 0x{text_off:x} out of range in object {i}",
                        ),
                    ));
                }
                match self.machine {
                    NativeMachine::X86_64 => {
                        // Windows: the `lea` adds disp32 to the TEB block
                        // base, so disp32 = merged_offset (no bias). Linux
                        // variant-2: the block sits below the thread
                        // pointer, so the `add` takes the negative TPOFF
                        // `merged_offset - merged_size`.
                        let value = if win_teb {
                            if merged_offset > i32::MAX as u64 {
                                return Err(internal_err(
                                    MODULE,
                                    &format!(
                                        "link_native_objects: TLS offset 0x{merged_offset:x} exceeds the \
                                     i32 immediate",
                                    ),
                                ));
                            }
                            merged_offset as i64
                        } else {
                            merged_offset as i64 - merged_tls_total as i64
                        };
                        self.text[patch..patch + 4].copy_from_slice(&(value as i32).to_le_bytes());
                    }
                    NativeMachine::Aarch64 => {
                        let tpoff = if win_teb {
                            merged_offset
                        } else {
                            merged_offset + tcb_reserve
                        };
                        if tpoff >= (1 << 24) {
                            return Err(internal_err(
                                MODULE,
                                &format!(
                                    "link_native_objects: TLS TPOFF 0x{tpoff:x} exceeds the \
                                 hi12/lo12 range",
                                ),
                            ));
                        }
                        let patch_imm12 = |text: &mut [u8], at: usize, imm: u32| {
                            let mut insn = u32::from_le_bytes([
                                text[at],
                                text[at + 1],
                                text[at + 2],
                                text[at + 3],
                            ]);
                            insn = (insn & !(0xFFF << 10)) | ((imm & 0xFFF) << 10);
                            text[at..at + 4].copy_from_slice(&insn.to_le_bytes());
                        };
                        if win_teb {
                            // TEB sequence: a single `add rd, x16, #imm12`.
                            if tpoff >= 4096 {
                                return Err(internal_err(
                                    MODULE,
                                    &format!(
                                        "link_native_objects: TLS offset 0x{tpoff:x} exceeds the 12-bit \
                                     `add` immediate",
                                    ),
                                ));
                            }
                            patch_imm12(&mut self.text, patch, tpoff as u32);
                        } else {
                            // Variant-1 local-exec pair: `add #hi12, lsl 12`
                            // at the fixup, `add #lo12` right after it.
                            if patch + 8 > self.text.len() {
                                return Err(internal_err(
                                    MODULE,
                                    &format!(
                                        "link_native_objects: TLS fixup offset 0x{text_off:x} out of \
                                     range in object {i}",
                                    ),
                                ));
                            }
                            patch_imm12(&mut self.text, patch, (tpoff >> 12) as u32);
                            patch_imm12(&mut self.text, patch + 4, (tpoff & 0xFFF) as u32);
                        }
                    }
                }
            }
        }
        Ok(())
    }

    /// `.rela.data` / relro / `.rela.tdata` entries. Each points at an
    /// 8-byte slot in its own blob whose final value is the runtime VA
    /// of another global; the target resolves to a merged-image offset
    /// and queues for the writer to patch once `data_vaddr` is
    /// committed. A `.rela.tdata` slot resolves the same way; only the
    /// segment the slot lives in differs.
    fn resolve_data_relocs(&mut self) -> Result<(), C5Error> {
        let objs = self.objs;
        for (i, obj) in objs.iter().enumerate() {
            // A relocation site is a blob offset, so it moves with the
            // section that carries it.
            let sited: Vec<(&NativeReloc, u64, bool)> = obj
                .data_relocs
                .iter()
                .map(|r| (r, self.rw_map[i].at(r.offset), false))
                .chain(
                    obj.relro_relocs
                        .iter()
                        .map(|r| (r, self.relro_map[i].at(r.offset), false)),
                )
                .chain(
                    obj.tls_relocs
                        .iter()
                        .map(|r| (r, self.tls_bases[i] as u64 + r.offset, true)),
                )
                .collect();
            for (reloc, slot_offset, in_tls) in sited {
                self.resolve_data_reloc(i, obj, reloc, slot_offset, in_tls)?;
            }
        }
        // Init/fini array slots: each 8-byte slot holds a `.text`
        // function pointer, so it needs the same absolute relocation as
        // a function-pointer data initializer -- an R_*_RELATIVE in the
        // PIE the final-image writer emits.
        for (k, &(_, text_off)) in self.init_entries.iter().enumerate() {
            self.data_abs_relocs.push(DataAbsReloc {
                slot_offset: self.init_array.0 + (k * 8) as u64,
                target: MergedTarget::Text(text_off as i64),
                anchor: MergedTarget::Text(text_off as i64),
            });
        }
        for (k, &(_, text_off)) in self.fini_entries.iter().enumerate() {
            self.data_abs_relocs.push(DataAbsReloc {
                slot_offset: self.fini_array.0 + (k * 8) as u64,
                target: MergedTarget::Text(text_off as i64),
                anchor: MergedTarget::Text(text_off as i64),
            });
        }
        Ok(())
    }

    fn resolve_data_reloc(
        &mut self,
        unit: usize,
        obj: &'a NativeObject,
        reloc: &NativeReloc,
        slot_offset: u64,
        in_tls: bool,
    ) -> Result<(), C5Error> {
        if reloc.sym_idx >= obj.symbols.len() {
            return Err(internal_err(
                MODULE,
                &format!(
                    "link_native_objects: .rela.data sym_idx {} out of range in object {unit}",
                    reloc.sym_idx,
                ),
            ));
        }
        let sym = &obj.symbols[reloc.sym_idx];
        // A pc-relative slot in the data stream (a switch dispatch
        // table in folded `.rodata`, an assembler `label - .` record in
        // a folded named section): the value is `S + A - P`, deferred
        // to the writer since the text-to-data vaddr gap is unknown
        // here.
        let pcrel_width: Option<u8> =
            match (self.machine, reloc.rtype) {
                (NativeMachine::X86_64, R_X86_64_PC32)
                | (NativeMachine::Aarch64, R_AARCH64_PREL32) => Some(4),
                (NativeMachine::X86_64, R_X86_64_PC64)
                | (NativeMachine::Aarch64, R_AARCH64_PREL64) => Some(8),
                _ => None,
            };
        if let Some(width) = pcrel_width {
            return self.resolve_data_pcrel(unit, sym, reloc, slot_offset, in_tls, width);
        }
        // The remaining kinds are the 8-byte absolute pointer
        // initializers.
        let is_abs64 = matches!(
            (self.machine, reloc.rtype),
            (NativeMachine::X86_64, R_X86_64_64) | (NativeMachine::Aarch64, R_AARCH64_ABS64)
        );
        if !is_abs64 {
            return Err(RelocOrigin::in_object(obj, SectionFamily::Data)
                .at(self.machine, reloc.rtype, &sym.name, reloc.offset)
                .unsupported());
        }
        // A slot naming an `SHN_ABS` symbol takes `S + A` directly: the
        // value is a link-time constant, so no load-time relocation
        // carries it.
        let abs_value = match sym.section {
            NativeSymSection::Abs => Some(sym.value as i64),
            NativeSymSection::Undef if !self.defined.contains_key(sym.name.as_str()) => {
                self.absolute_defined.get(sym.name.as_str()).copied()
            }
            _ => None,
        };
        if let Some(value) = abs_value {
            return self.write_data_slot(slot_offset, in_tls, value + reloc.addend, "absolute");
        }
        let resolved_section = match sym.section {
            NativeSymSection::Undef | NativeSymSection::Common => {
                // Common targets were coalesced into `.bss` and join
                // `defined` with section == Bss; the lookup is the same
                // as for an Undef cross-unit reference.
                match self.defined.get(sym.name.as_str()) {
                    Some(d) => d.section,
                    // An unresolved weak reference in a data initializer
                    // takes the absolute value 0 + addend (ELF behavior);
                    // the slot is patched now and no reloc survives. A
                    // name a `-l` shared library exports binds instead,
                    // in the arm below.
                    None if sym.binding == 2
                        && !self.is_routed_import(sym.name.as_str())
                        && !self.shlib_exports.contains(sym.name.as_str()) =>
                    {
                        return self.write_data_slot(slot_offset, in_tls, reloc.addend, "weak");
                    }
                    // A data initializer naming an imported function (a
                    // function-pointer table entry, e.g. `static freefn
                    // t = free;`) routes to the import's PLT stub -- a
                    // valid function pointer -- recorded for the PLT
                    // pass to resolve.
                    None if self.shlib_exports.contains(sym.name.as_str())
                        || self.is_routed_import(sym.name.as_str())
                        || self.import_idx_for_name.contains_key(sym.name.as_str()) =>
                    {
                        if in_tls {
                            return Err(link_err(
                                Code::RELOCATION,
                                MODULE,
                                &format!(
                                    "`_Thread_local` initializer names imported symbol `{}`: \
                                 the template is resolved at image load, before the \
                                 import's stub address is known",
                                    sym.name,
                                ),
                            ));
                        }
                        let idx = self.record_import(sym.name.as_str());
                        self.flat_imports.insert(sym.name.clone());
                        self.data_import_refs.push((slot_offset, idx));
                        return Ok(());
                    }
                    None => {
                        let site = if in_tls {
                            "`_Thread_local` initializer"
                        } else {
                            "data initializer"
                        };
                        return Err(link_err(
                            Code::UNDEFINED_SYMBOL,
                            MODULE,
                            &format!("undefined reference to `{}` ({site})", sym.name,),
                        ));
                    }
                }
            }
            NativeSymSection::Tls => {
                return Err(link_err(
                    Code::RELOCATION,
                    MODULE,
                    &format!(
                        ".rela.data targets `_Thread_local` symbol `{}` -- \
                     native-linker TLS lowering not yet wired",
                        sym.name,
                    ),
                ));
            }
            other => other,
        };
        // The referencing unit's own definition rebases by that unit's
        // base; a resolved cross-unit one is already merged.
        let resolved_value = match sym.section {
            NativeSymSection::Undef | NativeSymSection::Common => self
                .defined
                .get(sym.name.as_str())
                .map(|d| d.value as i64)
                .unwrap(),
            NativeSymSection::RoData => self.ro_map[unit].at(sym.value) as i64,
            NativeSymSection::RelRo => self.relro_map[unit].at(sym.value) as i64,
            NativeSymSection::Data => self.rw_map[unit].at(sym.value) as i64,
            NativeSymSection::Bss => self.bss_map[unit].at(sym.value) as i64,
            NativeSymSection::Text => self.text_bases[unit] as i64 + sym.value as i64,
            NativeSymSection::Tls => {
                return Err(link_err(
                    Code::RELOCATION,
                    MODULE,
                    &format!(
                        ".rela.data points at `_Thread_local` symbol `{}` -- \
                     native-linker TLS lowering not yet wired",
                        sym.name,
                    ),
                ));
            }
            NativeSymSection::Abs => {
                return Err(internal_err(
                    MODULE,
                    &format!(
                        "link_native_objects: .rela.data ABS symbol `{}` reached the \
                     section-relative path",
                        sym.name,
                    ),
                ));
            }
            NativeSymSection::Got => {
                return Err(internal_err(
                    MODULE,
                    &format!(
                        "link_native_objects: input symbol `{}` carries the GOT section",
                        sym.name,
                    ),
                ));
            }
            NativeSymSection::DebugAbbrev
            | NativeSymSection::DebugLine
            | NativeSymSection::DebugStr => {
                return Err(internal_err(
                    MODULE,
                    &format!(
                        "link_native_objects: .rela.data points at {:?} symbol `{}`",
                        sym.section, sym.name,
                    ),
                ));
            }
        };
        let target = merged_target(
            resolved_section,
            resolved_value,
            reloc.addend,
            self.data.len(),
        )
        .map_err(|_| {
            internal_err(
                MODULE,
                &format!(
                    "link_native_objects: .rela.data target `{}` lives in {:?}",
                    sym.name, resolved_section,
                ),
            )
        })?;
        // The anchor is the resolved symbol alone; the addend may
        // displace `target` outside the image (a negative addend below
        // the first object), which only the anchored writers can place,
        // so the in-image check applies to the anchor.
        let anchor = match target {
            MergedTarget::Text(o) => MergedTarget::Text(o - reloc.addend),
            MergedTarget::Data(o) => MergedTarget::Data(o - reloc.addend),
        };
        let off = match anchor {
            MergedTarget::Text(o) | MergedTarget::Data(o) => o,
        };
        if off < 0 {
            return Err(internal_err(
                MODULE,
                &format!("link_native_objects: .rela.data resolved to negative offset {off}",),
            ));
        }
        let dest = if in_tls {
            &mut self.tls_abs_relocs
        } else {
            &mut self.data_abs_relocs
        };
        dest.push(DataAbsReloc {
            slot_offset,
            target,
            anchor,
        });
        Ok(())
    }

    /// A pc-relative data slot. Only defined `.text` targets occur.
    fn resolve_data_pcrel(
        &mut self,
        unit: usize,
        sym: &'a NativeSymbol,
        reloc: &NativeReloc,
        slot_offset: u64,
        in_tls: bool,
        width: u8,
    ) -> Result<(), C5Error> {
        let (section, value) = match sym.section {
            NativeSymSection::Undef | NativeSymSection::Common => {
                let d = self.defined.get(sym.name.as_str()).ok_or_else(|| {
                    link_err(
                        Code::UNDEFINED_SYMBOL,
                        MODULE,
                        &format!(
                            "undefined reference to `{}` (pc-relative data slot)",
                            sym.name,
                        ),
                    )
                })?;
                (d.section, d.value as i64)
            }
            other => match self.unit_symbol_offset(unit, other, sym.value) {
                Some(v) => (other, v as i64),
                None => {
                    return Err(internal_err(
                        MODULE,
                        &format!(
                            "pc-relative data slot targets {other:?} symbol `{}`",
                            sym.name,
                        ),
                    ));
                }
            },
        };
        if in_tls {
            return Err(link_err(
                Code::RELOCATION,
                MODULE,
                &format!(
                    "pc-relative relocation against `{}` in the `_Thread_local` \
                 initialization template: the template is copied per thread, \
                 so a displacement from it has no fixed value",
                    sym.name,
                ),
            ));
        }
        self.data_pcrel_relocs.push(DataPcRel {
            slot_offset,
            target: merged_target(section, value, reloc.addend, self.data.len())?,
            anchor: merged_target(section, value, 0, self.data.len())?,
            width,
        });
        Ok(())
    }

    /// Store a link-time constant into an 8-byte slot of the data or
    /// the TLS template stream.
    fn write_data_slot(
        &mut self,
        slot_offset: u64,
        in_tls: bool,
        value: i64,
        what: &str,
    ) -> Result<(), C5Error> {
        let slot = slot_offset as usize;
        let seg = if in_tls {
            &mut self.tls_data
        } else {
            &mut self.data
        };
        if slot + 8 > seg.len() {
            return Err(internal_err(
                MODULE,
                &format!(
                    "{what} data reloc slot 0x{slot:x} past end of segment (len {})",
                    seg.len(),
                ),
            ));
        }
        seg[slot..slot + 8].copy_from_slice(&value.to_le_bytes());
        Ok(())
    }

    /// The `DT_NEEDED` list and the import->dylib map. Dylib paths are
    /// deduplicated across units in declaration order, since the order
    /// controls the dynamic loader's search precedence; each `-l`
    /// shared library joins by SONAME. Each unit's per-import
    /// dylib_index is local to that unit's list and translates to the
    /// merged order; two units routing one import to different dylibs
    /// is a conflict, since the loser's calls would bind against the
    /// wrong library.
    fn merge_dylibs(&self) -> Result<(Vec<String>, BTreeMap<String, u32>), C5Error> {
        let mut dylibs: Vec<String> = Vec::new();
        let mut seen_dylibs: hashbrown::HashSet<&str> = hashbrown::HashSet::new();
        for obj in self.objs {
            for d in &obj.dylibs {
                if seen_dylibs.insert(d.as_str()) {
                    dylibs.push(d.clone());
                }
            }
        }
        for lib in self.shared_libs {
            if !lib.soname.is_empty() && seen_dylibs.insert(lib.soname.as_str()) {
                dylibs.push(lib.soname.clone());
            }
        }
        let mut import_dylib_map: BTreeMap<String, u32> = BTreeMap::new();
        for (i, obj) in self.objs.iter().enumerate() {
            let mut local_to_merged: Vec<u32> = Vec::with_capacity(obj.dylibs.len());
            for d in &obj.dylibs {
                // The merged list was built from these same entries, so
                // the position lookup cannot miss.
                let merged_idx = dylibs
                    .iter()
                    .position(|m| m == d)
                    .expect("merged dylib list contains every per-unit path")
                    as u32;
                local_to_merged.push(merged_idx);
            }
            for (name, idx) in &obj.import_dylib_map {
                let merged_idx = local_to_merged.get(*idx as usize).copied().ok_or_else(|| {
                    link_err(
                        Code::LINK,
                        MODULE,
                        &format!(
                            "object {i}: import `{name}` routes to dylib index {idx} \
                         out of range ({} dylibs declared)",
                            obj.dylibs.len(),
                        ),
                    )
                })?;
                match import_dylib_map.get(name) {
                    None => {
                        import_dylib_map.insert(name.clone(), merged_idx);
                    }
                    Some(&prev) if prev == merged_idx => {}
                    Some(&prev) => {
                        return Err(link_err(
                            Code::LINK,
                            MODULE,
                            &format!(
                                "import `{name}` routed to `{}` by one object and `{}` by another",
                                dylibs[prev as usize], dylibs[merged_idx as usize],
                            ),
                        ));
                    }
                }
            }
        }
        Ok((dylibs, import_dylib_map))
    }

    /// The `#pragma export` names across units, first-seen order.
    fn merge_exports(&self) -> Vec<String> {
        let mut exports: Vec<String> = Vec::new();
        let mut seen: hashbrown::HashSet<&str> = hashbrown::HashSet::new();
        for obj in self.objs {
            for name in &obj.exports {
                if seen.insert(name.as_str()) {
                    exports.push(name.clone());
                }
            }
        }
        exports
    }

    /// Data-import copy relocations, deduplicated across units: the
    /// binding is declared in a header, so the same `(local, host)`
    /// pair recurs in every unit that included it.
    fn merge_copy_relocs(&self) -> Vec<(String, String)> {
        let mut copy_relocs: Vec<(String, String)> = Vec::new();
        let mut seen: hashbrown::HashSet<(&str, &str)> = hashbrown::HashSet::new();
        for obj in self.objs {
            for pair in &obj.copy_relocs {
                if seen.insert((pair.0.as_str(), pair.1.as_str())) {
                    copy_relocs.push(pair.clone());
                }
            }
        }
        copy_relocs
    }

    /// Win64 `_tls_index` fixup sites in merged `.text` offsets; the PE
    /// writer patches each with the address of the `_tls_index` slot it
    /// lays out in the TLS directory.
    fn rebase_tls_index_fixups(&self) -> Vec<usize> {
        let mut fixups: Vec<usize> = Vec::new();
        for (i, obj) in self.objs.iter().enumerate() {
            for &off in &obj.tls_index_fixups {
                fixups.push(self.text_bases[i] + off);
            }
        }
        fixups
    }

    /// Mach-O TLV descriptors and fixups. Descriptors concatenate in
    /// unit order; each unit's fixups rebase `adrp_offset` by that
    /// unit's `.text` base and shift `descriptor_index` past the
    /// descriptors contributed by earlier units. A unit-local
    /// descriptor adds the unit's TLS base to its block offset; a
    /// symbol-keyed one (a cross-unit `extern _Thread_local` access)
    /// takes the variable's offset from the merged TLS symbol table.
    fn merge_tlv_descriptors(&self) -> Result<TlvMerge, C5Error> {
        let mut descriptors: Vec<u64> = Vec::new();
        let mut fixups: Vec<(usize, usize)> = Vec::new();
        for (i, obj) in self.objs.iter().enumerate() {
            let desc_base = descriptors.len();
            let sym_for: BTreeMap<usize, &str> = obj
                .macho_tlv_descriptor_syms
                .iter()
                .map(|(idx, name)| (*idx, name.as_str()))
                .collect();
            for (di, &off) in obj.macho_tlv_descriptors.iter().enumerate() {
                let resolved = match sym_for.get(&di) {
                    Some(name) => *self.tls_symbol_offsets.get(*name).ok_or_else(|| {
                        link_err(
                            Code::UNDEFINED_SYMBOL,
                            MODULE,
                            &format!("unresolved `extern _Thread_local` reference to `{name}`",),
                        )
                    })?,
                    None => self.tls_bases[i] as u64 + off,
                };
                descriptors.push(resolved);
            }
            for &(adrp, idx) in &obj.macho_tlv_fixups {
                fixups.push((self.text_bases[i] + adrp, desc_base + idx));
            }
        }
        Ok(TlvMerge {
            descriptors,
            fixups,
        })
    }

    /// Concatenate each unit's DWARF sections, shifting each
    /// relocation's `r_offset` by the unit's base so the writer can
    /// apply them once against the merged blob. A reloc's `sym_idx`
    /// stays per-unit -- it is read through that unit's symbol table.
    fn merge_debug_sections(&self) -> DebugMerge {
        let mut dbg = DebugMerge {
            info: DebugSectionMerge::default(),
            line: DebugSectionMerge::default(),
            abbrev: Vec::new(),
            str_fold: DebugStrFold::build(self.objs),
            info_bases: Vec::with_capacity(self.objs.len()),
            abbrev_bases: Vec::with_capacity(self.objs.len()),
            line_bases: Vec::with_capacity(self.objs.len()),
            info_relocs: Vec::new(),
            line_relocs: Vec::new(),
            unit_for_info_reloc: Vec::new(),
            unit_for_line_reloc: Vec::new(),
        };
        for (unit_idx, obj) in self.objs.iter().enumerate() {
            dbg.info_bases.push(dbg.info.bytes.len());
            dbg.abbrev_bases.push(dbg.abbrev.len());
            dbg.line_bases.push(dbg.line.bytes.len());
            let info_base = dbg.info.bytes.len() as u64;
            let line_base = dbg.line.bytes.len() as u64;
            dbg.info.bytes.extend_from_slice(&obj.debug_info);
            dbg.abbrev.extend_from_slice(&obj.debug_abbrev);
            dbg.line.bytes.extend_from_slice(&obj.debug_line);
            for r in &obj.debug_info_relocs {
                let mut shifted = *r;
                shifted.offset = r.offset.wrapping_add(info_base);
                dbg.info_relocs.push(shifted);
                dbg.unit_for_info_reloc.push(unit_idx);
            }
            for r in &obj.debug_line_relocs {
                let mut shifted = *r;
                shifted.offset = r.offset.wrapping_add(line_base);
                dbg.line_relocs.push(shifted);
                dbg.unit_for_line_reloc.push(unit_idx);
            }
        }
        dbg
    }

    /// The per-unit DWARF streams reference offsets into other DWARF
    /// sections (CU header debug_abbrev_offset, DW_AT_stmt_list ->
    /// debug_line, line-program addresses -> .text). Once each unit's
    /// base within the merged stream is known the section-relative
    /// writes land directly; absolute text-targeting writes still need
    /// the final-image text vmaddr the writer will commit, so they park
    /// on the merged blob with the intra-stream byte offset of the
    /// placeholder and the merged-text offset of the target.
    fn resolve_debug_relocs(&self, dbg: &mut DebugMerge) -> Result<(), C5Error> {
        let bases = DebugBases {
            abbrev: &dbg.abbrev_bases,
            line: &dbg.line_bases,
            str_fold: &dbg.str_fold,
        };
        self.resolve_debug_section(
            &mut dbg.info,
            &dbg.info_relocs,
            &dbg.unit_for_info_reloc,
            ".debug_info",
            &bases,
        )?;
        self.resolve_debug_section(
            &mut dbg.line,
            &dbg.line_relocs,
            &dbg.unit_for_line_reloc,
            ".debug_line",
            &bases,
        )
    }

    fn resolve_debug_section(
        &self,
        section: &mut DebugSectionMerge,
        relocs: &[NativeReloc],
        units: &[usize],
        name: &str,
        bases: &DebugBases<'_>,
    ) -> Result<(), C5Error> {
        for (i, reloc) in relocs.iter().enumerate() {
            let unit_idx = units[i];
            let obj = &self.objs[unit_idx];
            let sym = obj.symbols.get(reloc.sym_idx).ok_or_else(|| {
                internal_err(
                    MODULE,
                    &format!(
                        "link_native_objects: {} reloc references symbol index {} out of range",
                        &name[1..],
                        reloc.sym_idx,
                    ),
                )
            })?;
            self.resolve_debug_reloc(
                section,
                bases,
                unit_idx,
                RelocOrigin::in_object_section(obj, name),
                reloc,
                sym,
            )?;
        }
        Ok(())
    }

    fn resolve_debug_reloc(
        &self,
        section: &mut DebugSectionMerge,
        bases: &DebugBases<'_>,
        unit_idx: usize,
        origin: RelocOrigin<'_>,
        reloc: &NativeReloc,
        sym: &NativeSymbol,
    ) -> Result<(), C5Error> {
        let machine = self.machine;
        let section_bytes = &mut section.bytes;
        let patch_off = reloc.offset as usize;
        // A thread-local's debug location holds its offset within the
        // module's thread block: the unit's merged TLS base plus the
        // symbol's offset in that unit's block. It is not an address,
        // so no writer has to defer it.
        if matches!(
            (machine, reloc.rtype),
            (NativeMachine::X86_64, R_X86_64_DTPOFF64)
                | (NativeMachine::Aarch64, R_AARCH64_TLS_DTPREL64)
        ) {
            let end = patch_off + 8;
            if end > section_bytes.len() {
                return Err(internal_err(
                    MODULE,
                    &format!(
                        "link_native_objects: DWARF reloc patch at 0x{patch_off:x}+8 past section end \
                     ({} bytes)",
                        section_bytes.len(),
                    ),
                ));
            }
            if sym.section != NativeSymSection::Tls {
                return Err(link_err(
                    Code::RELOCATION,
                    MODULE,
                    &format!(
                        "thread-block offset in debug info against non-TLS symbol `{}`",
                        sym.name,
                    ),
                ));
            }
            let value = (self.tls_bases[unit_idx] as u64)
                .wrapping_add(sym.value)
                .wrapping_add(reloc.addend as u64);
            section_bytes[patch_off..end].copy_from_slice(&value.to_le_bytes());
            return Ok(());
        }
        // Resolve the reloc's symbol to a merged offset, noting which
        // image it lands in and whether it is resolvable at all. A
        // same-unit symbol uses this unit's merged section base.
        // `.text` and the data image both defer: their runtime bases
        // are the writer's to commit. An `Undef` symbol -- debug info
        // from another toolchain naming an external symbol -- resolves
        // through the global table, and a definition with no
        // debug-usable link-time address is left null rather than
        // aborting the link.
        let in_data = matches!(
            sym.section,
            NativeSymSection::RoData
                | NativeSymSection::RelRo
                | NativeSymSection::Data
                | NativeSymSection::Bss
        );
        let (merged_value, in_text, resolvable) = match sym.section {
            NativeSymSection::Text => (self.text_bases[unit_idx] as u64 + sym.value, true, true),
            NativeSymSection::RoData => (self.ro_map[unit_idx].at(sym.value), false, true),
            NativeSymSection::RelRo => (self.relro_map[unit_idx].at(sym.value), false, true),
            NativeSymSection::Data => (self.rw_map[unit_idx].at(sym.value), false, true),
            NativeSymSection::Bss => (
                self.data.len() as u64 + self.bss_map[unit_idx].at(sym.value),
                false,
                true,
            ),
            NativeSymSection::DebugAbbrev => {
                (bases.abbrev[unit_idx] as u64 + sym.value, false, true)
            }
            NativeSymSection::DebugLine => (bases.line[unit_idx] as u64 + sym.value, false, true),
            // The addend selects the string, so it is part of the lookup
            // into the folded table, not an offset from a per-unit base.
            NativeSymSection::DebugStr => (
                bases
                    .str_fold
                    .at(unit_idx, sym.value.wrapping_add(reloc.addend as u64)),
                false,
                true,
            ),
            NativeSymSection::Undef => match self.defined.get(sym.name.as_str()) {
                Some(m) if m.section == NativeSymSection::Text => (m.value, true, true),
                _ => (0, false, false),
            },
            // An absolute symbol, a common tentative or a TLS object has
            // no deferred debug-address path. Leave the reference null
            // rather than aborting the link on another toolchain's
            // debug info.
            _ => (0, false, false),
        };
        // The `.debug_str` lookup above consumed the addend.
        let resolved = if sym.section == NativeSymSection::DebugStr {
            merged_value
        } else {
            merged_value.wrapping_add(reloc.addend as u64)
        };
        let width = match (machine, reloc.rtype) {
            (NativeMachine::X86_64, R_X86_64_64) | (NativeMachine::Aarch64, R_AARCH64_ABS64) => 8u8,
            (NativeMachine::X86_64, R_X86_64_32) | (NativeMachine::Aarch64, R_AARCH64_ABS32) => 4u8,
            _ => {
                return Err(origin
                    .at(machine, reloc.rtype, &sym.name, reloc.offset)
                    .unsupported());
            }
        };
        let end = patch_off.checked_add(width as usize).ok_or_else(|| {
            internal_err(MODULE, &format!(
                "link_native_objects: DWARF reloc offset 0x{patch_off:x} + width {width} overflows",
            ))
        })?;
        if end > section_bytes.len() {
            return Err(internal_err(
                MODULE,
                &format!(
                    "link_native_objects: DWARF reloc patch at 0x{patch_off:x}+{width} past section end \
                 ({} bytes)",
                    section_bytes.len(),
                ),
            ));
        }
        if resolvable && in_text && width == 8 {
            // A 64-bit text reference is a runtime address: stash the
            // placeholder so the writer can patch once `.text`'s runtime
            // base is committed.
            section.text_relocs.push(DebugTextReloc {
                byte_offset: patch_off as u64,
                merged_text_offset: resolved,
                width,
            });
            // Leave it cleared so a writer that ignores
            // `debug_*_text_relocs` produces deterministic bytes.
            section_bytes[patch_off..end].fill(0);
        } else if resolvable && in_data && width == 8 {
            section.data_relocs.push(DebugDataReloc {
                byte_offset: patch_off as u64,
                merged_data_offset: resolved,
                width,
            });
            section_bytes[patch_off..end].fill(0);
        } else if resolvable {
            // A section-relative offset (debug-section cross-reference,
            // or a 32-bit slot) is already final.
            let bytes = &resolved.to_le_bytes()[..width as usize];
            section_bytes[patch_off..end].copy_from_slice(bytes);
        } else {
            // Unresolvable external reference (data/bss definition or a
            // dynamic import): no debug-usable link-time address, leave
            // it null.
            section_bytes[patch_off..end].fill(0);
        }
        Ok(())
    }

    fn finish(mut self) -> Result<MergedNative, C5Error> {
        let (dylibs, import_dylib_map) = self.merge_dylibs()?;
        let exports = self.merge_exports();
        let copy_relocs = self.merge_copy_relocs();
        let tls_index_fixups = self.rebase_tls_index_fixups();
        let tlv = self.merge_tlv_descriptors()?;
        let mut dbg = self.merge_debug_sections();
        self.resolve_debug_relocs(&mut dbg)?;
        // A name the note lists and a branch also reaches is code: the
        // note covers the slot-versus-stub choice at a site, not the
        // symbol's type.
        let branch_imports = &self.branch_imports;
        self.object_imports.retain(|i| !branch_imports.contains(i));
        let defined: BTreeMap<String, MergedSymbol> = self
            .defined
            .into_iter()
            .map(|(name, sym)| (name.into_owned(), sym))
            .collect();
        Ok(MergedNative {
            text: self.text,
            text_align: self.text_align,
            data: self.data,
            data_ro_len: self.data_ro_len,
            data_relro_len: self.data_relro_len,
            data_align: self.data_align,
            bss_size: self.bss_size,
            named_sections: self.named_sections,
            defined,
            imports: self.imports,
            pending_imports: self.pending_imports,
            applied_text_relocs: self.applied_text_relocs,
            data_abs_relocs: self.data_abs_relocs,
            data_pcrel_relocs: self.data_pcrel_relocs,
            data_import_refs: self.data_import_refs,
            machine: self.machine,
            dylibs,
            import_dylib_map,
            flat_imports: self.flat_imports,
            exports,
            tls_index_fixups,
            macho_tlv_descriptors: tlv.descriptors,
            macho_tlv_fixups: tlv.fixups,
            copy_relocs,
            object_imports: self.object_imports,
            debug_info: dbg.info.bytes,
            debug_abbrev: dbg.abbrev,
            debug_line: dbg.line.bytes,
            debug_str: dbg.str_fold.into_bytes(),
            debug_info_bases: dbg.info_bases,
            debug_abbrev_bases: dbg.abbrev_bases,
            debug_line_bases: dbg.line_bases,
            debug_info_relocs: dbg.info_relocs,
            debug_line_relocs: dbg.line_relocs,
            unit_for_debug_info_reloc: dbg.unit_for_info_reloc,
            unit_for_debug_line_reloc: dbg.unit_for_line_reloc,
            debug_info_text_relocs: dbg.info.text_relocs,
            debug_line_text_relocs: dbg.line.text_relocs,
            debug_info_data_relocs: dbg.info.data_relocs,
            prologue_ends: self.prologue_ends,
            local_funcs: self.local_funcs,
            tls_data: self.tls_data,
            tls_init_size: self.tls_init_size,
            tls_align: self.tls_align,
            tls_abs_relocs: self.tls_abs_relocs,
            init_fini_arrays: crate::c5::codegen::InitFiniArrays {
                init: (self.init_array.1 > self.init_array.0)
                    .then_some((self.init_array.0, self.init_array.1 - self.init_array.0)),
                fini: (self.fini_array.1 > self.fini_array.0)
                    .then_some((self.fini_array.0, self.fini_array.1 - self.fini_array.0)),
            },
            section_map: self.section_map,
        })
    }
}

/// Mach-O TLV descriptors resolved to per-thread offsets, and the
/// `adrp` sites that name them, in merged `.text` offsets.
struct TlvMerge {
    descriptors: Vec<u64>,
    fixups: Vec<(usize, usize)>,
}

/// One merged DWARF section with the relocations left for a writer.
/// The line program addresses code only, so its `data_relocs` are
/// another toolchain's shape and reach no writer.
#[derive(Default)]
struct DebugSectionMerge {
    bytes: Vec<u8>,
    text_relocs: Vec<DebugTextReloc>,
    data_relocs: Vec<DebugDataReloc>,
}

/// The merged DWARF streams: each unit's blob appended to the
/// corresponding merged section, with its base recorded.
struct DebugMerge {
    info: DebugSectionMerge,
    line: DebugSectionMerge,
    abbrev: Vec<u8>,
    str_fold: DebugStrFold,
    info_bases: Vec<usize>,
    abbrev_bases: Vec<usize>,
    line_bases: Vec<usize>,
    info_relocs: Vec<NativeReloc>,
    line_relocs: Vec<NativeReloc>,
    unit_for_info_reloc: Vec<usize>,
    unit_for_line_reloc: Vec<usize>,
}

/// The per-unit bases a DWARF cross-reference resolves against.
struct DebugBases<'m> {
    abbrev: &'m [usize],
    line: &'m [usize],
    str_fold: &'m DebugStrFold,
}

/// One text-targeting DWARF reloc that survives the link pass.
/// The placeholder at `byte_offset` inside its parent DWARF
/// section needs `text_vaddr + merged_text_offset` written into
/// the matching `width` bytes (8 for `R_X86_64_64`/`R_AARCH64_ABS64`,
/// 4 for `R_X86_64_32`/`R_AARCH64_ABS32`). `text_vaddr` is whatever
/// runtime address the final-image writer commits for the start of
/// the merged `.text`.
#[derive(Debug, Clone, Copy)]
pub struct DebugTextReloc {
    pub byte_offset: u64,
    pub merged_text_offset: u64,
    pub width: u8,
}

/// A DWARF placeholder naming a byte of the merged data image: the
/// `DW_OP_addr` of an object with static storage duration. The offset
/// follows [`merged_target`]'s convention, so a `.bss` object sits past
/// the image length and the writer's data-offset-to-address map places
/// it in the zero-fill tail.
#[derive(Debug, Clone, Copy)]
pub struct DebugDataReloc {
    pub byte_offset: u64,
    pub merged_data_offset: u64,
    pub width: u8,
}

/// Record the PLT pool `[pool_start, text.len())` as a linker-
/// materialized `.plt` contribution. No-op when no stub was emitted.
fn record_plt_contribution(merged: &mut MergedNative, pool_start: usize) {
    if merged.text.len() > pool_start {
        merged.section_map.text.push(SectionContribution {
            input: None,
            name: ".plt".to_string(),
            offset: pool_start as u64,
            size: (merged.text.len() - pool_start) as u64,
        });
    }
}

/// Every unit's `.debug_str` folded into one table with a single copy
/// of each distinct string, plus the map that rewrites a unit's
/// `DW_FORM_strp` offsets onto it. `SHF_MERGE | SHF_STRINGS` is what
/// makes that sound: an offset names a string, not a position.
struct DebugStrFold {
    bytes: Vec<u8>,
    /// Per unit, ascending by local offset: the offset of each string
    /// in that unit's blob paired with its offset in `bytes`.
    starts: Vec<Vec<(u64, u64)>>,
    /// Per unit, its blob's length, which bounds a reference.
    lens: Vec<u64>,
}

impl DebugStrFold {
    fn build(objs: &[super::object::NativeObject]) -> DebugStrFold {
        DebugStrFold::from_blobs(objs.iter().map(|o| &o.debug_str[..]))
    }

    fn from_blobs<'a>(blobs: impl Iterator<Item = &'a [u8]>) -> DebugStrFold {
        let mut bytes: Vec<u8> = Vec::new();
        let mut interned: HashMap<&'a [u8], u64> = HashMap::new();
        let mut starts: Vec<Vec<(u64, u64)>> = Vec::new();
        let mut lens: Vec<u64> = Vec::new();
        for blob in blobs {
            let mut unit: Vec<(u64, u64)> = Vec::new();
            let mut at = 0usize;
            while at < blob.len() {
                let end = blob[at..]
                    .iter()
                    .position(|&b| b == 0)
                    .map_or(blob.len(), |i| at + i);
                let s = &blob[at..end];
                let off = *interned.entry(s).or_insert_with(|| {
                    let o = bytes.len() as u64;
                    bytes.extend_from_slice(s);
                    bytes.push(0);
                    o
                });
                unit.push((at as u64, off));
                at = end + 1;
            }
            starts.push(unit);
            lens.push(blob.len() as u64);
        }
        DebugStrFold {
            bytes,
            starts,
            lens,
        }
    }

    /// Where a unit-local offset lands in the folded table. An offset
    /// inside a string names its tail, which the same copy provides.
    fn at(&self, unit: usize, local: u64) -> u64 {
        let Some(starts) = self.starts.get(unit) else {
            return 0;
        };
        if local >= self.lens[unit] {
            return 0;
        }
        let i = starts.partition_point(|&(l, _)| l <= local);
        match i.checked_sub(1) {
            Some(prev) => {
                let (l, merged) = starts[prev];
                merged + (local - l)
            }
            None => 0,
        }
    }

    fn into_bytes(self) -> Vec<u8> {
        self.bytes
    }
}

/// Per-import PLT trampoline metadata returned by [`emit_x86_64_plt`]
/// and [`emit_aarch64_plt`]. Each entry pairs the trampoline's byte
/// offset in `MergedNative::text` with the import-name index; the
/// final-image writer reads `text_offset` to know where the stub lives
/// and patches its GOT-slot fields once the GOT's runtime address is
/// known.
#[derive(Debug, Clone, Copy)]
pub struct PltTrampoline {
    /// Byte offset within `MergedNative::text` of the trampoline's
    /// first instruction.
    pub text_offset: usize,
    /// Index into [`MergedNative::imports`].
    pub import_index: usize,
}

/// One PLT stub with its GOT-slot fields zero, for the writer to patch:
/// the six-byte `jmp qword ptr [rip + disp32]` (`FF 25 disp32`) x86_64
/// ELF stubs use, or the aarch64 `adrp x16, page; ldr x16, [x16, off];
/// br x16` sequence.
fn plt_stub(machine: NativeMachine) -> Vec<u8> {
    match machine {
        NativeMachine::X86_64 => alloc::vec![0xFF, 0x25, 0x00, 0x00, 0x00, 0x00],
        NativeMachine::Aarch64 => [0x9000_0010u32, 0xF940_0210, 0xD61F_0200]
            .iter()
            .flat_map(|w| w.to_le_bytes())
            .collect(),
    }
}

/// A relocation a site may reach an import through. On aarch64 the
/// address-of pair (`adrp` + `add`) materializes the stub's address
/// for `&import`, so it needs a stub like a branch does.
fn plt_eligible(machine: NativeMachine, rtype: u32) -> bool {
    match machine {
        NativeMachine::X86_64 => matches!(rtype, R_X86_64_PLT32 | R_X86_64_PC32),
        NativeMachine::Aarch64 => matches!(
            rtype,
            R_AARCH64_CALL26
                | R_AARCH64_JUMP26
                | R_AARCH64_ADR_PREL_PG_HI21
                | R_AARCH64_ADD_ABS_LO12_NC
        ),
    }
}

/// Lower every `pending_imports` entry into a per-import PLT
/// trampoline appended to `MergedNative::text` (16-byte aligned, one
/// stub per import index in order of first occurrence; an import no
/// site reaches for gets none), then hand each call site to
/// `patch_site` with its trampoline's text offset. Data-ref entries
/// (`import_index == usize::MAX`) and slot-read sites are re-parked for
/// the writer, which resolves them against its own vmaddrs. A data
/// initializer naming an imported function resolves to that import's
/// stub through a Text-target `DataAbsReloc`.
fn emit_plt(
    merged: &mut MergedNative,
    mut patch_site: impl FnMut(
        &mut MergedNative,
        &PendingImportReloc,
        usize,
        &mut Vec<PendingImportReloc>,
    ) -> Result<(), C5Error>,
) -> Result<Vec<PltTrampoline>, C5Error> {
    let machine = merged.machine;
    let stub = plt_stub(machine);
    align_up(&mut merged.text, 16);
    let plt_pool_start = merged.text.len();
    let mut tramp_for_import: BTreeMap<usize, usize> = BTreeMap::new();
    let mut trampolines: Vec<PltTrampoline> = Vec::new();
    let pending = core::mem::take(&mut merged.pending_imports);
    let mut parked_back: Vec<PendingImportReloc> = Vec::new();
    for reloc in &pending {
        if reloc.import_index == usize::MAX || reloc.slot_load {
            parked_back.push(reloc.clone());
            continue;
        }
        if !plt_eligible(machine, reloc.rtype) {
            return Err(link_err(
                Code::RELOCATION,
                MODULE,
                &format!(
                    "unsupported {} against import `{}`: an imported symbol is reachable \
                 only through a PLT-eligible relocation",
                    reloc_desc(machine, reloc.rtype),
                    import_name(merged, reloc.import_index),
                ),
            ));
        }
        if let alloc::collections::btree_map::Entry::Vacant(e) =
            tramp_for_import.entry(reloc.import_index)
        {
            let text_offset = merged.text.len();
            e.insert(text_offset);
            trampolines.push(PltTrampoline {
                text_offset,
                import_index: reloc.import_index,
            });
            merged.text.extend_from_slice(&stub);
        }
    }
    for reloc in &pending {
        if reloc.import_index == usize::MAX || reloc.slot_load {
            continue;
        }
        let tramp = tramp_for_import
            .get(&reloc.import_index)
            .copied()
            .expect("every reloc has a stub from the first loop");
        patch_site(merged, reloc, tramp, &mut parked_back)?;
    }
    let data_import_refs = merged.data_import_refs.clone();
    for (slot, import_index) in data_import_refs {
        let stub_at = match tramp_for_import.get(&import_index) {
            Some(&off) => off,
            None => {
                let text_offset = merged.text.len();
                tramp_for_import.insert(import_index, text_offset);
                trampolines.push(PltTrampoline {
                    text_offset,
                    import_index,
                });
                merged.text.extend_from_slice(&stub);
                text_offset
            }
        };
        merged.data_abs_relocs.push(DataAbsReloc {
            slot_offset: slot,
            target: MergedTarget::Text(stub_at as i64),
            anchor: MergedTarget::Text(stub_at as i64),
        });
    }
    merged.pending_imports = parked_back;
    record_plt_contribution(merged, plt_pool_start);
    Ok(trampolines)
}

/// [`emit_plt`] for x86_64: each call site's disp32 reaches its
/// trampoline through the standard `R_X86_64_PLT32` (`(S + A) - P`)
/// formula. The site's `text_offset` points at the disp32 byte (the
/// codegen sets it to `instr_offset + 1`), so `S` is the trampoline
/// byte offset within the merged text.
pub fn emit_x86_64_plt(merged: &mut MergedNative) -> Result<Vec<PltTrampoline>, C5Error> {
    if merged.machine != NativeMachine::X86_64 {
        return Err(internal_err(
            MODULE,
            &format!(
                "emit_x86_64_plt: only NativeMachine::X86_64 is supported, got {:?}",
                merged.machine,
            ),
        ));
    }
    emit_plt(merged, |merged, reloc, tramp, _parked| {
        let name = import_name(merged, reloc.import_index).to_string();
        patch_x86_64_pc32(
            &mut merged.text,
            reloc.text_offset as usize,
            tramp as i64 + reloc.addend,
            &RelocOrigin::merged(".text").at(
                NativeMachine::X86_64,
                reloc.rtype,
                &name,
                reloc.text_offset,
            ),
        )
    })
}

/// [`emit_plt`] for aarch64. CALL26 / JUMP26 are PC-relative, so the
/// stub's `merged.text` offset patches in directly regardless of where
/// the text segment lands in vmaddr space. The address-of pair (`adrp`
/// + `add`) is page-relative, so its immediates depend on the stub's
/// final vmaddr, which the per-format writer assigns later (the text
/// segment is not page-aligned on Mach-O / PE); the pair re-parks as a
/// Text-section reference to the stub offset, which `synth_fixups`
/// projects into a `FuncFixup` the writer resolves against the real
/// vmaddr, exactly like a function-pointer literal.
pub fn emit_aarch64_plt(merged: &mut MergedNative) -> Result<Vec<PltTrampoline>, C5Error> {
    if merged.machine != NativeMachine::Aarch64 {
        return Err(internal_err(
            MODULE,
            &format!(
                "emit_aarch64_plt: only NativeMachine::Aarch64 is supported, got {:?}",
                merged.machine,
            ),
        ));
    }
    emit_plt(merged, |merged, reloc, tramp, parked_back| {
        match reloc.rtype {
            R_AARCH64_CALL26 | R_AARCH64_JUMP26 => {
                let name = import_name(merged, reloc.import_index).to_string();
                patch_aarch64_pcrel(
                    &mut merged.text,
                    reloc.text_offset as usize,
                    tramp as i64 + reloc.addend,
                    &RelocOrigin::merged(".text").at(
                        NativeMachine::Aarch64,
                        reloc.rtype,
                        &name,
                        reloc.text_offset,
                    ),
                )
            }
            R_AARCH64_ADR_PREL_PG_HI21 | R_AARCH64_ADD_ABS_LO12_NC => {
                parked_back.push(PendingImportReloc {
                    text_offset: reloc.text_offset,
                    import_index: usize::MAX,
                    rtype: reloc.rtype,
                    addend: tramp as i64,
                    target_section: NativeSymSection::Text,
                    slot_load: false,
                    sym_name: reloc.sym_name.clone(),
                });
                Ok(())
            }
            _ => unreachable!("the stub loop rejected every other rtype"),
        }
    })
}

/// Import name behind a [`PendingImportReloc::import_index`], for
/// diagnostics. Parked section references carry no import.
pub(crate) fn import_name(merged: &MergedNative, import_index: usize) -> &str {
    merged
        .imports
        .get(import_index)
        .map_or("<section reference>", |s| s.as_str())
}

/// Resolve a reference to an unresolved STB_WEAK UNDEF symbol to
/// address 0 (ELF behavior for a weak reference nothing on the link
/// line satisfies). A branch becomes a no-op, matching the GNU
/// linkers' AArch64 handling of branches to undefined weak symbols;
/// an address-materializing instruction is rewritten to produce the
/// constant 0 so the `if (fn) fn();` guard idiom reads a null
/// pointer. Instruction shapes outside the supported set are a
/// diagnostic, never a silent import.
fn resolve_weak_undef_to_zero(
    machine: NativeMachine,
    text: &mut [u8],
    patch_offset: usize,
    reloc: &NativeReloc,
    name: &str,
) -> Result<(), C5Error> {
    let unsupported = |what: &str| {
        link_err(
            Code::RELOCATION,
            MODULE,
            &format!("unresolved weak reference to `{name}`: cannot resolve {what} to address 0",),
        )
    };
    if patch_offset
        .checked_add(4)
        .is_none_or(|end| end > text.len())
    {
        return Err(internal_err(
            MODULE,
            &format!(
                "relocation patch offset 0x{patch_offset:x} past end of text (len {})",
                text.len(),
            ),
        ));
    }
    use crate::c5::object::weak_undef as wu;
    let ok = match (machine, reloc.rtype) {
        (NativeMachine::Aarch64, R_AARCH64_CALL26) | (NativeMachine::Aarch64, R_AARCH64_JUMP26) => {
            wu::aarch64_branch_to_nop(text, patch_offset)
        }
        (NativeMachine::Aarch64, R_AARCH64_ADR_PREL_PG_HI21) => {
            wu::aarch64_adrp_to_zero(text, patch_offset)
        }
        (NativeMachine::Aarch64, R_AARCH64_ADD_ABS_LO12_NC) => {
            wu::aarch64_add_lo12_to_zero(text, patch_offset)
        }
        // An unrelaxed GOT pair: the page half takes the same rewrite as
        // ADR_PREL, the load half becomes the null address itself.
        (NativeMachine::Aarch64, R_AARCH64_ADR_GOT_PAGE) => {
            wu::aarch64_adrp_to_zero(text, patch_offset)
        }
        (NativeMachine::Aarch64, R_AARCH64_LD64_GOT_LO12_NC) => {
            wu::aarch64_got_load_to_zero(text, patch_offset)
        }
        (NativeMachine::X86_64, R_X86_64_PLT32) | (NativeMachine::X86_64, R_X86_64_PC32) => {
            // `r_offset` names the disp32 field; the instruction starts
            // one byte ahead for `call rel32`, three for a rip-relative
            // `lea`.
            (patch_offset >= 1 && wu::x86_64_branch_to_nop(text, patch_offset - 1))
                || (patch_offset >= 3 && wu::x86_64_lea_to_zero(text, patch_offset - 3))
        }
        (NativeMachine::X86_64, R_X86_64_GOTPCREL)
        | (NativeMachine::X86_64, R_X86_64_REX_GOTPCRELX) => {
            patch_offset >= 3 && wu::x86_64_got_load_to_zero(text, patch_offset - 3)
        }
        _ => return Err(unsupported(&reloc_desc(machine, reloc.rtype))),
    };
    if ok {
        Ok(())
    } else {
        Err(unsupported("the referencing instruction"))
    }
}

/// A patch site derives from an object's `r_offset`, which is
/// untrusted input, so every patcher checks its field is inside the
/// stream before indexing rather than panicking on the slice bound.
fn check_patch_bounds(text: &[u8], offset: usize, width: usize) -> Result<(), C5Error> {
    if offset.checked_add(width).is_none_or(|end| end > text.len()) {
        return Err(internal_err(
            MODULE,
            &format!(
                "relocation patch offset 0x{offset:x} past end of text (len {})",
                text.len(),
            ),
        ));
    }
    Ok(())
}

fn apply_reloc(
    text: &mut [u8],
    patch_offset: usize,
    target: i64,
    site: &RelocSite<'_>,
) -> Result<(), C5Error> {
    check_patch_bounds(text, patch_offset, 4)?;
    if site.machine == NativeMachine::Aarch64 && aarch64_pcrel_imm_field(site.rtype).is_some() {
        return patch_aarch64_pcrel(text, patch_offset, target, site);
    }
    // A `.long x - .` / `.quad x - .` word inside an executable
    // section. Its value is a distance, so the merged offsets it is
    // computed from carry it without the image base.
    if let Some((width, check)) = pcrel_data_field(site.machine, site.rtype) {
        check_patch_bounds(text, patch_offset, width as usize)?;
        let disp = target - patch_offset as i64;
        return write_pcrel_field(&mut text[patch_offset..], disp, width, check, site);
    }
    match (site.machine, site.rtype) {
        (NativeMachine::X86_64, R_X86_64_PLT32) | (NativeMachine::X86_64, R_X86_64_PC32) => {
            patch_x86_64_pc32(text, patch_offset, target, site)
        }
        (NativeMachine::Aarch64, R_AARCH64_ADR_PREL_PG_HI21) => {
            patch_aarch64_adr_pg(text, patch_offset, target)
        }
        (NativeMachine::Aarch64, R_AARCH64_ADD_ABS_LO12_NC) => {
            patch_aarch64_add_lo12(text, patch_offset, target)
        }
        // `adr`: a byte-granular 21-bit displacement split across
        // immlo (30:29) and immhi (23:5), so it cannot ride the
        // contiguous-field table above.
        (NativeMachine::Aarch64, R_AARCH64_ADR_PREL_LO21) => {
            let disp = target - patch_offset as i64;
            if !(-(1i64 << 20)..(1i64 << 20)).contains(&disp) {
                return Err(site.truncated(disp));
            }
            let d = disp as u32;
            let mut instr =
                u32::from_le_bytes(text[patch_offset..patch_offset + 4].try_into().unwrap());
            instr = (instr & 0x9f00_001f) | ((d & 3) << 29) | (((d >> 2) & 0x7_ffff) << 5);
            text[patch_offset..patch_offset + 4].copy_from_slice(&instr.to_le_bytes());
            Ok(())
        }
        // An object carrying a relocation form this linker has no
        // patcher for is an unsupported input, not a broken invariant.
        _ => Err(site.unsupported()),
    }
}

/// Write `S + A` where the value is a link-time constant -- a
/// reference to an `SHN_ABS` symbol. Only the forms whose field holds
/// an absolute value apply: a PC-relative or page-relative form over a
/// constant needs the site's runtime address, which an image the loader
/// places has only at load time.
fn apply_absolute_reloc(
    text: &mut [u8],
    patch_offset: usize,
    value: i64,
    site: &RelocSite<'_>,
) -> Result<(), C5Error> {
    if site.machine == NativeMachine::Aarch64
        && let Some((group, signed, check)) = aarch64_movw_field(site.rtype)
    {
        use crate::c5::codegen::aarch64::patch;
        check_patch_bounds(text, patch_offset, 4)?;
        if let Some(bits) = check
            && !patch::movw_fits(value, bits, signed)
        {
            return Err(site.truncated(value));
        }
        let word = u32::from_le_bytes(text[patch_offset..patch_offset + 4].try_into().unwrap());
        let word = patch::movw_word(word, group, signed, value);
        text[patch_offset..patch_offset + 4].copy_from_slice(&word.to_le_bytes());
        return Ok(());
    }
    if let Some((width, check)) = super::image::abs_field(site.machine, site.rtype) {
        check_patch_bounds(text, patch_offset, width as usize)?;
        if !check.admits(value, width) {
            return Err(site.truncated(value));
        }
        let n = width as usize;
        text[patch_offset..patch_offset + n].copy_from_slice(&value.to_le_bytes()[..n]);
        return Ok(());
    }
    Err(site.unsupported())
}

/// Width and overflow rule of the plain data field a PC-relative
/// relocation writes `S + A - P` into, for either machine.
pub(crate) fn pcrel_data_field(machine: NativeMachine, rtype: u32) -> Option<(u32, AbsCheck)> {
    match machine {
        NativeMachine::X86_64 => x86_64_pcrel_data_field(rtype),
        NativeMachine::Aarch64 => aarch64_pcrel_data_field(rtype),
    }
}

/// Store a PC-relative displacement into a `width`-byte field,
/// rejecting one the field's overflow rule does not admit.
pub(crate) fn write_pcrel_field(
    dst: &mut [u8],
    disp: i64,
    width: u32,
    check: AbsCheck,
    site: &RelocSite<'_>,
) -> Result<(), C5Error> {
    if !check.admits(disp, width) {
        return Err(site.truncated(disp));
    }
    let n = width as usize;
    dst[..n].copy_from_slice(&disp.to_le_bytes()[..n]);
    Ok(())
}

/// Write `(target - offset) / scale` into the contiguous signed
/// immediate [`aarch64_pcrel_imm_field`] describes. Covers the branch
/// and PC-relative-literal forms: CALL26 / JUMP26, CONDBR19,
/// LD_PREL_LO19 and TSTBR14.
fn patch_aarch64_pcrel(
    text: &mut [u8],
    offset: usize,
    target: i64,
    site: &RelocSite<'_>,
) -> Result<(), C5Error> {
    let (lsb, width, scale) = aarch64_pcrel_imm_field(site.rtype).ok_or_else(|| {
        internal_err(
            MODULE,
            "patch_aarch64_pcrel: type carries no PC-relative immediate",
        )
    })?;
    check_patch_bounds(text, offset, 4)?;
    let disp = target - offset as i64;
    if disp.rem_euclid(scale as i64) != 0 {
        return Err(site.misaligned(disp, scale));
    }
    let units = disp / scale as i64;
    if !(-(1i64 << (width - 1))..(1i64 << (width - 1))).contains(&units) {
        return Err(site.truncated(disp));
    }
    let mask = ((1u32 << width) - 1) << lsb;
    let mut instr = u32::from_le_bytes(text[offset..offset + 4].try_into().unwrap());
    instr = (instr & !mask) | (((units as u32) << lsb) & mask);
    text[offset..offset + 4].copy_from_slice(&instr.to_le_bytes());
    Ok(())
}

fn patch_x86_64_pc32(
    text: &mut [u8],
    offset: usize,
    target: i64,
    site: &RelocSite<'_>,
) -> Result<(), C5Error> {
    // ELF AMD64 ABI section 4.4.1: `R_X86_64_PC32` / `R_X86_64_PLT32`
    // resolve to (`S + A`) - `P` where `S` is the symbol value,
    // `A` the addend, and `P` the patch site. `apply_reloc`
    // passes the sum `S + A` in `target`; the subtraction lives
    // here so the contract matches [`patch_aarch64_pcrel`]'s.
    check_patch_bounds(text, offset, 4)?;
    let disp = target - offset as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&disp) {
        return Err(site.truncated(disp));
    }
    text[offset..offset + 4].copy_from_slice(&(disp as i32).to_le_bytes());
    Ok(())
}

fn patch_aarch64_adr_pg(text: &mut [u8], offset: usize, target: i64) -> Result<(), C5Error> {
    crate::c5::codegen::aarch64::patch::patch_adrp(text, offset, offset as i64, target).map_err(
        |e| {
            internal_err(
                MODULE,
                &e.describe(&format!("ADR_PREL_PG_HI21 at 0x{offset:x}")),
            )
        },
    )
}

fn patch_aarch64_add_lo12(text: &mut [u8], offset: usize, target: i64) -> Result<(), C5Error> {
    crate::c5::codegen::aarch64::patch::patch_lo12(text, offset, target).map_err(|e| {
        internal_err(
            MODULE,
            &e.describe(&format!("ADD_ABS_LO12_NC at 0x{offset:x}")),
        )
    })
}

/// The `adrp` + low-12 pair materializes an address from the target
/// section's runtime vmaddr, which only the final-image writer knows,
/// so both halves park instead of patching in place. The low-12 half
/// is either an `add` immediate or one of the scaled load/store forms.
fn is_aarch64_text_pageref(machine: NativeMachine, rtype: u32) -> bool {
    matches!(machine, NativeMachine::Aarch64)
        && (matches!(
            rtype,
            R_AARCH64_ADR_PREL_PG_HI21 | R_AARCH64_ADD_ABS_LO12_NC
        ) || aarch64_ldst_lo12_scale(rtype).is_some())
}

/// A relocation whose value is an address rather than a distance
/// resolves only once the image's load address is fixed, which happens
/// in the writer. The merge pass parks these instead of patching, even
/// for a `.text` target whose merged offset it already knows.
fn needs_image_base(machine: NativeMachine, rtype: u32) -> bool {
    match machine {
        NativeMachine::Aarch64 => {
            is_aarch64_text_pageref(machine, rtype)
                || matches!(rtype, R_AARCH64_ABS64 | R_AARCH64_ABS32)
                // A MOVW group immediate holds a 16-bit group of the
                // target's runtime address.
                || aarch64_movw_field(rtype).is_some()
        }
        NativeMachine::X86_64 => x86_64_abs_field(rtype).is_some(),
    }
}

/// Relocation forms the parked-reference path can materialize once
/// the final-image writer commits each section's runtime address.
/// Screening them here, where the referencing symbol is still in
/// hand, keeps the diagnostic specific; the writers' own fallbacks
/// then only fire when a badc invariant broke.
fn parked_reloc_supported(machine: NativeMachine, rtype: u32) -> bool {
    needs_image_base(machine, rtype)
        || pcrel_data_field(machine, rtype).is_some()
        || match machine {
            NativeMachine::Aarch64 => aarch64_pcrel_imm_field(rtype).is_some(),
            NativeMachine::X86_64 => matches!(rtype, R_X86_64_PC32 | R_X86_64_PLT32),
        }
}

#[allow(clippy::too_many_arguments)]
fn park_section_ref(
    pending: &mut Vec<PendingImportReloc>,
    patch_offset: usize,
    reloc: &NativeReloc,
    target_offset: i64,
    target_section: NativeSymSection,
    site: &RelocSite<'_>,
) -> Result<(), C5Error> {
    if !parked_reloc_supported(site.machine, reloc.rtype) {
        return Err(site.unsupported());
    }
    // The reference resolves once the final-image writer
    // knows the runtime vmaddr of the target's section. Park
    // it in the `pending_imports` queue with a sentinel
    // import index of `usize::MAX`; the writer picks it up
    // the same way it handles PLT imports. `target_section`
    // tells the writer whether to apply `text_vaddr`,
    // `data_vaddr`, or `data_vaddr + data_size` as the base.
    pending.push(PendingImportReloc {
        text_offset: patch_offset as u64,
        import_index: usize::MAX,
        rtype: reloc.rtype,
        addend: target_offset,
        target_section,
        slot_load: false,
        // Every writer materializes the page pair and its low-12
        // halves, so a failure there means a badc invariant broke and
        // the writer's own diagnostic says so. The rest a writer may
        // still decline, and `import_index` names no symbol for a
        // section reference, so those keep the name. They are the rare
        // forms, so the common parked reference costs no allocation.
        sym_name: (!is_aarch64_text_pageref(site.machine, reloc.rtype)).then(|| site.symbol.into()),
    });
    Ok(())
}

fn park_data_ref(
    pending: &mut Vec<PendingImportReloc>,
    patch_offset: usize,
    reloc: &NativeReloc,
    target_offset: i64,
    site: &RelocSite<'_>,
) -> Result<(), C5Error> {
    park_section_ref(
        pending,
        patch_offset,
        reloc,
        target_offset,
        NativeSymSection::Data,
        site,
    )
}

/// Apply or park a `.rela.text` entry that [`merged_target`] resolved.
/// A `.text` target can be patched in place because the text segment's
/// vmaddr is anchored before the merge runs (except the aarch64 page
/// form, whose two halves the writer patches together); a data target
/// depends on the final-image writer's `.text`-to-`.data` gap, so it
/// is parked with the offset in the reloc's addend.
#[allow(clippy::too_many_arguments)]
fn resolve_merged_target(
    text: &mut [u8],
    pending: &mut Vec<PendingImportReloc>,
    applied: &mut Vec<AppliedTextReloc>,
    patch_offset: usize,
    reloc: &NativeReloc,
    target: MergedTarget,
    site: &RelocSite<'_>,
) -> Result<(), C5Error> {
    match target {
        MergedTarget::Text(off) => {
            if needs_image_base(site.machine, reloc.rtype) {
                park_section_ref(
                    pending,
                    patch_offset,
                    reloc,
                    off,
                    NativeSymSection::Text,
                    site,
                )?;
            } else {
                apply_reloc(text, patch_offset, off, site)?;
                applied.push(AppliedTextReloc {
                    text_offset: patch_offset as u64,
                    rtype: reloc.rtype,
                    target_text_offset: off,
                });
            }
        }
        MergedTarget::Data(off) => {
            park_data_ref(pending, patch_offset, reloc, off, site)?;
        }
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::linker::object::parse_native_elf;
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};

    use crate::c5::object::elf_reloc_types::{
        R_AARCH64_CONDBR19, R_AARCH64_LD_PREL_LO19, R_AARCH64_TSTBR14, R_X86_64_32S,
    };

    /// A relocation site with no containing object, for exercising a
    /// patcher directly.
    /// An object carrying nothing, for a test that fills in one aspect.
    fn blank_object(machine: NativeMachine) -> NativeObject {
        NativeObject {
            source: String::new(),
            sections: Vec::new(),
            discarded: Vec::new(),
            text_align: 16,
            rodata: Vec::new(),
            rodata_align: 8,
            relro: Vec::new(),
            relro_align: 1,
            relro_relocs: Vec::new(),
            machine,
            text: Vec::new(),
            data: Vec::new(),
            data_align: 1,
            bss_size: 0,
            bss_align: 1,
            tls_data: Vec::new(),
            tls_relocs: Vec::new(),
            tls_bss_size: 0,
            tls_align: 1,
            symbols: Vec::new(),
            text_relocs: Vec::new(),
            data_relocs: Vec::new(),
            init_funcs: Vec::new(),
            dylibs: Vec::new(),
            import_dylib_map: Vec::new(),
            exports: Vec::new(),
            tls_index_fixups: Vec::new(),
            macho_tlv_descriptors: Vec::new(),
            macho_tlv_fixups: Vec::new(),
            tls_symbols: Vec::new(),
            macho_tlv_descriptor_syms: Vec::new(),
            elf_tpoff_fixups: Vec::new(),
            copy_relocs: Vec::new(),
            prologue_ends: Vec::new(),
            extern_data_names: Vec::new(),
            debug_info: Vec::new(),
            debug_abbrev: Vec::new(),
            debug_line: Vec::new(),
            debug_str: Vec::new(),
            debug_info_relocs: Vec::new(),
            debug_line_relocs: Vec::new(),
        }
    }

    fn site(machine: NativeMachine, rtype: u32, offset: u64) -> RelocSite<'static> {
        RelocOrigin::merged(".text").at(machine, rtype, "gfar", offset)
    }

    /// The fold keeps one copy of each distinct string and maps every
    /// unit-local offset onto it, interior and out-of-range included.
    #[test]
    fn debug_str_fold_shares_one_copy_of_each_string() {
        let a: &[u8] = b"\0int\0Shape\0";
        let b: &[u8] = b"\0Shape\0width\0";
        let empty: &[u8] = b"";
        let fold = DebugStrFold::from_blobs([a, b, empty].into_iter());
        assert_eq!(fold.at(0, 0), 0, "the empty string sits at 0");
        assert_eq!(fold.at(1, 0), 0);
        assert_eq!(fold.at(0, 1), 1, "`int` follows it");
        assert_eq!(fold.at(0, 5), 5, "`Shape` follows `int`");
        assert_eq!(fold.at(1, 1), 5, "the second unit shares that copy");
        assert_eq!(fold.at(1, 7), 11, "`width` is the only new string");
        assert_eq!(fold.at(0, 6), 6, "an interior offset names the tail");
        assert_eq!(fold.at(0, 11), 0, "past the blob names nothing");
        assert_eq!(fold.at(2, 0), 0, "a unit with no pool names nothing");
        assert_eq!(fold.at(9, 0), 0, "nor does an out-of-range unit");
        assert_eq!(fold.into_bytes(), b"\0int\0Shape\0width\0");
    }

    /// Reference words GNU ld 2.46.1 wrote for
    /// `b.eq gfar` / `ldr x0, gfar` / `tbz x1, #3, gfar` at
    /// `.text` 0x400000 with `gfar` at 0x400010, taken from
    /// `objdump -s -j .text`. Each patcher must reproduce them from
    /// the same `S + A` and `P`.
    #[test]
    fn aarch64_pcrel_patchers_match_gnu_ld() {
        // (rtype, site offset, unpatched word, ld's word)
        let cases: &[(u32, usize, u32, u32)] = &[
            (R_AARCH64_CONDBR19, 0x0, 0x5400_0000, 0x5400_0080),
            (R_AARCH64_LD_PREL_LO19, 0x4, 0x5800_0000, 0x5800_0060),
            (R_AARCH64_TSTBR14, 0x8, 0x3618_0001, 0x3618_0041),
            (R_AARCH64_CALL26, 0xc, 0x9400_0000, 0x9400_0001),
        ];
        for &(rtype, off, before, want) in cases {
            let mut text = alloc::vec![0u8; 0x20];
            text[off..off + 4].copy_from_slice(&before.to_le_bytes());
            patch_aarch64_pcrel(
                &mut text,
                off,
                0x10,
                &site(NativeMachine::Aarch64, rtype, off as u64),
            )
            .expect("an in-range displacement patches");
            let got = u32::from_le_bytes(text[off..off + 4].try_into().unwrap());
            assert_eq!(
                got,
                want,
                "{} wrote {got:#010x}, GNU ld wrote {want:#010x}",
                reloc_desc(NativeMachine::Aarch64, rtype),
            );
        }
    }

    /// `R_AARCH64_ADR_PREL_LO21` splits its displacement across immlo
    /// and immhi; the patcher must agree with the shared `adr` encoder
    /// for a byte-granular target, and reject one past +-1 MiB.
    #[test]
    fn aarch64_adr_patcher_matches_the_shared_encoder() {
        use crate::c5::codegen::aarch64::encode::{Reg, enc_adr};
        for disp in [0x10i32, -0x24, (1 << 20) - 1, -(1 << 20)] {
            let mut text = alloc::vec![0u8; 4];
            text[..4].copy_from_slice(&enc_adr(Reg(7), 0).to_le_bytes());
            apply_reloc(
                &mut text,
                0,
                disp as i64,
                &site(NativeMachine::Aarch64, R_AARCH64_ADR_PREL_LO21, 0),
            )
            .expect("an in-range displacement patches");
            let got = u32::from_le_bytes(text[..4].try_into().unwrap());
            assert_eq!(got, enc_adr(Reg(7), disp), "disp {disp:#x}");
        }
        let mut text = alloc::vec![0u8; 4];
        text[..4].copy_from_slice(&enc_adr(Reg(7), 0).to_le_bytes());
        apply_reloc(
            &mut text,
            0,
            1 << 20,
            &site(NativeMachine::Aarch64, R_AARCH64_ADR_PREL_LO21, 0),
        )
        .expect_err("a displacement past +-1 MiB is a link error");
    }

    /// GNU ld reports `relocation truncated to fit` at 0x40000 for
    /// TSTBR14 and at 0x110000 for CONDBR19 / LD_PREL_LO19, and links
    /// both without complaint one unit inside the field's range.
    #[test]
    fn aarch64_pcrel_range_checks_match_gnu_ld() {
        // (rtype, first rejected displacement)
        let cases: &[(u32, i64)] = &[
            (R_AARCH64_TSTBR14, 1 << 15),
            (R_AARCH64_CONDBR19, 1 << 20),
            (R_AARCH64_LD_PREL_LO19, 1 << 20),
            (R_AARCH64_CALL26, 1 << 27),
        ];
        for &(rtype, limit) in cases {
            let mut text = alloc::vec![0u8; 8];
            let s = site(NativeMachine::Aarch64, rtype, 0);
            patch_aarch64_pcrel(&mut text, 0, limit - 4, &s)
                .unwrap_or_else(|e| panic!("{limit:#x}-4 is in range: {e}"));
            patch_aarch64_pcrel(&mut text, 0, -limit, &s)
                .unwrap_or_else(|e| panic!("-{limit:#x} is in range: {e}"));
            let over = patch_aarch64_pcrel(&mut text, 0, limit, &s)
                .expect_err("a displacement past the field's range is a link error");
            assert!(
                alloc::format!("{over}").contains("relocation truncated to fit"),
                "range diagnostic must read like GNU ld's: {over}"
            );
            patch_aarch64_pcrel(&mut text, 0, -limit - 4, &s)
                .expect_err("a displacement past the field's negative range is a link error");
            patch_aarch64_pcrel(&mut text, 0, 2, &s)
                .expect_err("an unaligned displacement has no encoding");
        }
    }

    /// A `.long x - .` / `.quad x - .` word inside `.text`. GNU ld
    /// 2.46.1 wrote `2c 00 10 00` and `28 00 10 00 00 00 00 00` for
    /// `gdata` at 0x500030 with the words at 0x400004 and 0x400008.
    #[test]
    fn aarch64_pcrel_data_words_match_gnu_ld() {
        use crate::c5::object::elf_reloc_types::{R_AARCH64_PREL32, R_AARCH64_PREL64};
        let mut text = alloc::vec![0u8; 0x20];
        let s32 = site(NativeMachine::Aarch64, R_AARCH64_PREL32, 4);
        apply_reloc(&mut text, 4, 0x10_0030, &s32).expect("PREL32 in text applies");
        assert_eq!(text[4..8], [0x2c, 0x00, 0x10, 0x00]);
        let s64 = site(NativeMachine::Aarch64, R_AARCH64_PREL64, 8);
        apply_reloc(&mut text, 8, 0x10_0030, &s64).expect("PREL64 in text applies");
        assert_eq!(
            text[8..16],
            [0x28, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00]
        );
        // AAELF64 checks PREL32 as `-2^31 <= X < 2^32`.
        apply_reloc(&mut text, 4, 0x1_0000_0004, &s32)
            .expect_err("a displacement past 32 bits is a link error");
    }

    /// An unsupported type names the ABI type, the symbol and the
    /// containing object, and is a link error rather than an internal
    /// one.
    #[test]
    fn unsupported_type_names_the_type_symbol_and_object() {
        use crate::c5::linker::object::InputSection;
        let sections = alloc::vec![InputSection {
            name: ".init.text".to_string(),
            family: SectionFamily::Text,
            offset: 0,
            size: 0x40,
            align: 4,
        }];
        let origin = RelocOrigin::in_input("vmlinux.o", &sections, SectionFamily::Text);
        // R_AARCH64_MOVW_PREL_G0 has no patcher in the native path.
        let e = origin
            .at(NativeMachine::Aarch64, 287, "primary_entry", 0x30)
            .unsupported();
        assert_eq!(
            alloc::format!("{e}"),
            "error: vmlinux.o(.init.text+0x30): unsupported R_AARCH64_MOVW_PREL_G0 (287) \
             against symbol `primary_entry` [B6012] [relocation]"
        );
    }

    /// An absolute form in a position-independent image is refused on
    /// the reference, not on a missing patcher, and names the output
    /// kind the way GNU ld does.
    #[test]
    fn an_absolute_in_a_pie_names_the_constraint_and_the_output_kind() {
        let origin = RelocOrigin::in_named_section("t.o", ".text");
        let site = origin.at(NativeMachine::X86_64, R_X86_64_32S, "per_slot_base", 0x4);
        assert_eq!(
            alloc::format!("{}", site.absolute_in_pie(false)),
            "error: t.o(.text+0x4): R_X86_64_32S (11) against symbol `per_slot_base` can not \
             be used when making a position-independent executable: the reference needs an \
             absolute address, which no load address supplies [B6012] [relocation]"
        );
        assert_eq!(
            alloc::format!("{}", site.absolute_in_pie(true)),
            "error: t.o(.text+0x4): R_X86_64_32S (11) against symbol `per_slot_base` can not \
             be used when making a shared object: the reference needs an absolute address, \
             which no load address supplies [B6012] [relocation]"
        );
    }

    /// Single-TU link: `main` + a helper in the same source.
    /// Exercises the section-concat + symbol-table population
    /// path. Cross-unit symbol resolution lands once the
    /// compile path drops the "must define main" check for
    /// `OutputKind::Relocatable` builds (currently
    /// `Compiler::compile()` errors without a main; the
    /// per-TU compile-then-link surface is a separate task).
    #[test]
    fn single_unit_link_records_defined_symbols() {
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let obj = compile_native(
            "int helper(void){return 7;}\nint main(void){return helper();}\n",
            target,
            opts,
        );
        let merged = link_native_objects(&[obj]).expect("link");
        let helper = merged
            .defined
            .get("helper")
            .expect("helper symbol in merged defined table");
        assert!(matches!(helper.section, NativeSymSection::Text));
        assert!(helper.size > 0);
        let main_sym = merged
            .defined
            .get("main")
            .expect("main symbol in merged defined table");
        assert!(matches!(main_sym.section, NativeSymSection::Text));
        // Sanity: every pending import resolves to a real
        // import slot or is parked as a data ref
        // (`usize::MAX`).
        for p in &merged.pending_imports {
            assert!(
                p.import_index == usize::MAX || p.import_index < merged.imports.len(),
                "pending import index {} out of range",
                p.import_index,
            );
        }
    }

    /// Cross-TU call resolves at link time. `b.c` defines
    /// `helper`; `a.c` extern-declares it and calls. After
    /// `link_native_objects`, the `bl 0x0` placeholder in a's
    /// `.text` has its imm26 patched to reach b's `helper`
    /// body at the merged offset, and `helper` no longer parks
    /// in `pending_imports`. Pins the end-to-end relocatable
    /// path: codegen emits the placeholder + reloc, reader
    /// surfaces the UNDEF symbol, link pass resolves in place.
    #[test]
    fn cross_unit_call_resolves_to_defined_symbol() {
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);

        let a = compile_native_with(
            "int helper(void); int caller(void){return helper();}\n",
            target,
            opts,
            copts.clone(),
        );
        let b = compile_native_with("int helper(void){return 7;}\n", target, opts, copts);

        // Snapshot a.o's text for a before-vs-after compare on
        // the patch site.
        let a_text_before = a.text.clone();
        let helper_call_site = a
            .text_relocs
            .iter()
            .find(|r| {
                a.symbols
                    .get(r.sym_idx)
                    .map(|s| s.name == "helper")
                    .unwrap_or(false)
            })
            .map(|r| r.offset as usize)
            .expect("a.o should carry a CALL26 reloc against helper");
        let placeholder = u32::from_le_bytes(
            a_text_before[helper_call_site..helper_call_site + 4]
                .try_into()
                .unwrap(),
        );
        assert_eq!(
            placeholder & 0x03ff_ffff,
            0,
            "expected bl placeholder's imm26 to be zero pre-link",
        );

        let merged = link_native_objects(&[a, b]).expect("link");
        let helper_def = merged
            .defined
            .get("helper")
            .expect("helper landed in merged defined table");
        assert!(matches!(helper_def.section, NativeSymSection::Text));

        // Every reloc against `helper` in the merged image
        // should have been resolved in place; nothing parks in
        // `pending_imports` with `helper` as its target.
        for p in &merged.pending_imports {
            let name = &merged.imports[p.import_index];
            assert_ne!(
                name, "helper",
                "expected helper reloc to resolve in place, but it parked as import",
            );
        }

        // Post-link the imm26 should reach helper_def.value
        // from helper_call_site. Decode + compare.
        let patched = u32::from_le_bytes(
            merged.text[helper_call_site..helper_call_site + 4]
                .try_into()
                .unwrap(),
        );
        let imm26 = patched & 0x03ff_ffff;
        let words = if imm26 & (1 << 25) != 0 {
            (imm26 | 0xfc00_0000) as i32 as i64
        } else {
            imm26 as i64
        };
        let resolved = helper_call_site as i64 + (words << 2);
        assert_eq!(
            resolved as u64, helper_def.value,
            "post-link bl should reach helper at 0x{:x}, got 0x{resolved:x}",
            helper_def.value,
        );
    }

    /// An otherwise-undefined reference resolves against a shared
    /// library's exports: the executable link succeeds instead of
    /// erroring, the symbol becomes a load-time import, and the
    /// library is recorded as a DT_NEEDED dependency by its SONAME.
    #[test]
    fn shared_library_data_object_resolves_as_data_import() {
        // A reference to a shared library's data object (a `STT_OBJECT`
        // export) must resolve to the object's address through the GOT --
        // a slot read -- not to a PLT stub, whose bytes are code. The
        // `data_exports` set drives this: it marks the site the way a
        // `#pragma binding(data ...)` local's is marked, so the PLT pass
        // skips a call stub for it.
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);
        let src = "extern unsigned short tbl[]; int f(void){ return tbl[3]; }\n";
        let obj = compile_native_with(src, target, opts, copts);

        let names = |n: &str| core::iter::once(alloc::string::String::from(n)).collect();
        let lib = SharedLibrary {
            soname: alloc::string::String::from("libext.so.1"),
            machine: NativeMachine::Aarch64,
            exports: names("tbl"),
            data_exports: names("tbl"),
        };
        let merged = link_native_objects_with_shared_libs(&[obj], false, &[lib])
            .expect("link resolves the data object against the shared library");
        let idx = merged
            .imports
            .iter()
            .position(|n| n == "tbl")
            .expect("tbl recorded as an import");
        assert!(
            merged
                .pending_imports
                .iter()
                .filter(|p| p.import_index == idx)
                .all(|p| p.slot_load),
            "a shared-library data object must route as a slot read, not a call stub",
        );
    }

    /// A shared library's own undefined references: the host supplies
    /// both at load time, so both become imports, but only the call gets
    /// a stub. A stub for the data symbol would leave every read of it
    /// returning the stub's instruction bytes.
    #[test]
    fn shared_library_undefined_data_reference_takes_no_call_stub() {
        let src = "extern int host_var;\nextern int host_fn(void);\n\
                   int read_var(void) { return host_var; }\n\
                   int call_fn(void) { return host_fn(); }\n";
        for target in [Target::LinuxX64, Target::LinuxAarch64] {
            let mut opts = NativeOptions::new().with_debug_info(false);
            opts.output_kind = OutputKind::Relocatable;
            let copts = crate::CompileOptions::default().with_no_entry_point(true);
            let obj = compile_native_with(src, target, opts, copts);
            let mut merged = link_native_objects_with_options(&[obj], true)
                .expect("a shared library admits both undefined references");
            let idx = |n: &str| {
                merged
                    .imports
                    .iter()
                    .position(|i| i == n)
                    .unwrap_or_else(|| panic!("{target:?}: {n} recorded as an import"))
            };
            let (data, code) = (idx("host_var"), idx("host_fn"));
            // `(sites reading the slot, sites branching)` per import.
            let sites = |i: usize| -> (usize, usize) {
                let mut counts = (0usize, 0usize);
                for p in merged
                    .pending_imports
                    .iter()
                    .filter(|p| p.import_index == i)
                {
                    if p.slot_load {
                        counts.0 += 1;
                    } else {
                        counts.1 += 1;
                    }
                }
                counts
            };
            let (data_reads, data_branches) = sites(data);
            assert!(
                data_reads > 0 && data_branches == 0,
                "{target:?}: every site of an undefined data reference reads its slot, \
                 got {data_reads} read(s) and {data_branches} branch(es)",
            );
            let (code_reads, code_branches) = sites(code);
            assert!(
                code_branches > 0 && code_reads == 0,
                "{target:?}: a call site branches, got {code_reads} read(s) and \
                 {code_branches} branch(es)",
            );
            let plt = match merged.machine {
                NativeMachine::X86_64 => emit_x86_64_plt(&mut merged),
                NativeMachine::Aarch64 => emit_aarch64_plt(&mut merged),
            }
            .expect("plt pass");
            assert!(
                plt.iter().all(|t| t.import_index != data),
                "{target:?}: the data import must get no call stub",
            );
            assert!(
                plt.iter().any(|t| t.import_index == code),
                "{target:?}: the call must get a stub",
            );
        }
    }

    #[test]
    fn shared_library_export_resolves_undefined_reference() {
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);
        let src = "int ext_fn(void); int caller(void){ return ext_fn(); }\n";
        let caller = compile_native_with(src, target, opts, copts.clone());

        // With no provider, an executable link rejects the reference.
        let unresolved = compile_native_with(src, target, opts, copts);
        let err = link_native_objects(&[unresolved]).unwrap_err();
        assert!(
            alloc::format!("{err}").contains("ext_fn"),
            "expected an undefined-reference error naming ext_fn, got {err}",
        );

        // A shared library that exports it turns the reference into a
        // load-time import and records the library as DT_NEEDED.
        let lib = SharedLibrary {
            soname: alloc::string::String::from("libext.so.1"),
            machine: NativeMachine::Aarch64,
            exports: core::iter::once(alloc::string::String::from("ext_fn")).collect(),
            data_exports: alloc::collections::BTreeSet::new(),
        };
        let merged = link_native_objects_with_shared_libs(&[caller], false, &[lib])
            .expect("link resolves ext_fn against the shared library");
        assert!(
            merged.dylibs.iter().any(|d| d == "libext.so.1"),
            "DT_NEEDED should include the shared library, got {:?}",
            merged.dylibs,
        );
        assert!(
            merged.imports.iter().any(|n| n == "ext_fn"),
            "ext_fn should be recorded as a runtime import",
        );
    }

    /// A file-scope function-pointer table entry naming a shared-library
    /// import (`static fn t = ext_fn;`, an address-of-import static
    /// initializer) links instead of erroring, and the PLT pass turns the
    /// data slot into a
    /// stub-targeting DataAbsReloc so the slot holds a valid pointer.
    #[test]
    fn shared_library_function_pointer_in_data_resolves_via_stub() {
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);
        let src = "int ext_fn(void);\n\
                   int (*tbl)(void) = ext_fn;\n\
                   int use_tbl(void){ return tbl != 0; }\n";
        let obj = compile_native_with(src, target, opts, copts);
        let lib = SharedLibrary {
            soname: alloc::string::String::from("libext.so.1"),
            machine: NativeMachine::Aarch64,
            exports: core::iter::once(alloc::string::String::from("ext_fn")).collect(),
            data_exports: alloc::collections::BTreeSet::new(),
        };
        let mut merged = link_native_objects_with_shared_libs(&[obj], false, &[lib])
            .expect("a data reference to a shared-library import must link");
        assert!(
            !merged.data_import_refs.is_empty(),
            "the function pointer in data should be recorded as a data import",
        );
        let before = merged.data_abs_relocs.len();
        let _ = emit_aarch64_plt(&mut merged).expect("plt pass");
        assert!(
            merged.data_abs_relocs.len() > before,
            "the PLT pass should emit a stub-targeting DataAbsReloc for the data import",
        );
    }

    /// A `b <target>` tail call (R_AARCH64_JUMP26, type 282, emitted by
    /// other toolchains' objects) patches its 26-bit branch immediate
    /// exactly like a `bl` CALL26, rather than erroring as an
    /// unimplemented relocation.
    #[test]
    fn jump26_reloc_patches_branch_immediate() {
        let mut text = alloc::vec![0u8; 0x40];
        // Branch from offset 0 to offset 0x20: imm26 = 0x20 >> 2 = 8.
        apply_reloc(
            &mut text,
            0,
            0x20,
            &site(NativeMachine::Aarch64, R_AARCH64_JUMP26, 0),
        )
        .expect("JUMP26 must be an implemented relocation");
        let instr = u32::from_le_bytes(text[0..4].try_into().unwrap());
        assert_eq!(
            instr & 0x03ff_ffff,
            8,
            "JUMP26 imm26 should encode the 0x20-byte forward branch",
        );
    }

    /// Linking the same TU twice triggers the duplicate-
    /// definition guard: every `STB_GLOBAL` defined symbol
    /// (main, helper, ...) appears in both objects.
    #[test]
    fn duplicate_global_definition_errors() {
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let a = compile_native("int main(void){return 0;}\n", target, opts);
        let b = compile_native("int main(void){return 0;}\n", target, opts);
        let err = link_native_objects(&[a, b]).unwrap_err();
        assert!(
            err.to_string().contains("multiple definition of"),
            "unexpected error: {err}",
        );
    }

    /// `emit_x86_64_plt` materialises one trampoline per
    /// unique import the merged image reaches for, then
    /// patches each call site's disp32 to reach its
    /// trampoline. Pins the shape: one `printf` import + one
    /// `puts` import => two trampolines past the original
    /// `.text` payload, each starting with `FF 25` (jmp
    /// qword ptr [rip + disp32]).
    #[test]
    fn emit_x86_64_plt_materialises_one_trampoline_per_import() {
        let target = Target::LinuxX64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);
        // `#include <stdio.h>` brings printf + puts into the
        // imports table even though only one is called;
        // calling both pins the trampoline emit for both.
        let a = compile_native_with(
            "#include <stdio.h>\nint hello(void) { return printf(\"hi\\n\") + puts(\"bye\"); }\n",
            target,
            opts,
            copts,
        );
        let mut merged = link_native_objects(&[a]).expect("link");
        let text_pre = merged.text.len();
        let pending_pre = merged.pending_imports.len();
        assert!(
            pending_pre >= 2,
            "expected at least two pending imports (printf + puts), got {pending_pre}",
        );

        let trampolines = emit_x86_64_plt(&mut merged).expect("plt");
        assert!(
            trampolines.len() >= 2,
            "expected >= 2 trampolines for printf + puts, got {}",
            trampolines.len(),
        );
        // Every PLT-resolvable pending import got lowered to a
        // trampoline; only `<data-ref>` parks (import_index ==
        // usize::MAX, surfaced by `park_data_ref`) remain.
        for r in &merged.pending_imports {
            assert_eq!(
                r.import_index,
                usize::MAX,
                "emit_x86_64_plt should drain every non-data-ref pending import",
            );
        }
        // Trampolines are appended past the original text.
        for t in &trampolines {
            assert!(
                t.text_offset >= text_pre,
                "trampoline @ {:#x} should sit past original text end {:#x}",
                t.text_offset,
                text_pre,
            );
            // Each trampoline starts with `FF 25` (JMP qword
            // ptr [rip + disp32]).
            assert_eq!(
                &merged.text[t.text_offset..t.text_offset + 2],
                &[0xFF, 0x25],
                "trampoline @ {:#x} prologue mismatch",
                t.text_offset,
            );
            // The disp32 is still zero (writer patches it).
            assert_eq!(
                u32::from_le_bytes(
                    merged.text[t.text_offset + 2..t.text_offset + 6]
                        .try_into()
                        .unwrap(),
                ),
                0,
                "trampoline @ {:#x} disp32 should start zero",
                t.text_offset,
            );
        }
        // Trampolines should be 16-byte aligned (alignment
        // pad lands between the original text and the first
        // trampoline).
        assert_eq!(
            trampolines[0].text_offset & 0xF,
            0,
            "first trampoline should be 16-byte aligned",
        );
    }

    /// Errors out cleanly on aarch64 -- that path needs an
    /// adrp+ldr+br trampoline, not the x86_64 jmp shape.
    #[test]
    fn emit_x86_64_plt_rejects_aarch64() {
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);
        let a = compile_native_with("int caller(void) { return 0; }\n", target, opts, copts);
        let mut merged = link_native_objects(&[a]).expect("link");
        let err = emit_x86_64_plt(&mut merged).unwrap_err();
        assert!(
            err.to_string().contains("X86_64"),
            "unexpected error: {err}",
        );
    }

    /// Aarch64 analogue of the x86_64 trampoline test. Compiles a
    /// libc-using TU for Linux aarch64, runs `emit_aarch64_plt`,
    /// and verifies one twelve-byte `adrp+ldr+br` trampoline per
    /// unique import. `pending_imports` drains of every
    /// `R_AARCH64_CALL26` reloc; data-ref parks stay.
    #[test]
    fn emit_aarch64_plt_materialises_one_trampoline_per_import() {
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);
        let a = compile_native_with(
            "#include <stdio.h>\nint hello(void) { return printf(\"hi\\n\") + puts(\"bye\"); }\n",
            target,
            opts,
            copts,
        );
        let mut merged = link_native_objects(&[a]).expect("link");
        let text_pre = merged.text.len();
        let pending_pre = merged.pending_imports.len();
        assert!(
            pending_pre >= 2,
            "expected at least two pending imports (printf + puts), got {pending_pre}",
        );

        let trampolines = emit_aarch64_plt(&mut merged).expect("plt");
        assert!(
            trampolines.len() >= 2,
            "expected >= 2 trampolines for printf + puts, got {}",
            trampolines.len(),
        );
        for r in &merged.pending_imports {
            assert_eq!(
                r.import_index,
                usize::MAX,
                "emit_aarch64_plt should drain every non-data-ref pending import",
            );
        }
        for t in &trampolines {
            assert!(
                t.text_offset >= text_pre,
                "trampoline @ {:#x} should sit past original text end {:#x}",
                t.text_offset,
                text_pre,
            );
            let adrp = u32::from_le_bytes(
                merged.text[t.text_offset..t.text_offset + 4]
                    .try_into()
                    .unwrap(),
            );
            let ldr = u32::from_le_bytes(
                merged.text[t.text_offset + 4..t.text_offset + 8]
                    .try_into()
                    .unwrap(),
            );
            let br = u32::from_le_bytes(
                merged.text[t.text_offset + 8..t.text_offset + 12]
                    .try_into()
                    .unwrap(),
            );
            // adrp x16, 0 -- immhi / immlo bits stay zero.
            assert_eq!(adrp, 0x9000_0010, "trampoline @ {:#x} adrp", t.text_offset);
            // ldr x16, [x16] -- imm12 stays zero.
            assert_eq!(ldr, 0xF940_0210, "trampoline @ {:#x} ldr", t.text_offset);
            // br x16
            assert_eq!(br, 0xD61F_0200, "trampoline @ {:#x} br", t.text_offset);
        }
        assert_eq!(
            trampolines[0].text_offset & 0xF,
            0,
            "first trampoline should be 16-byte aligned",
        );
    }

    /// Aarch64 emitter rejects x86_64 input.
    #[test]
    fn emit_aarch64_plt_rejects_x86_64() {
        let target = Target::LinuxX64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);
        let a = compile_native_with("int caller(void) { return 0; }\n", target, opts, copts);
        let mut merged = link_native_objects(&[a]).expect("link");
        let err = emit_aarch64_plt(&mut merged).unwrap_err();
        assert!(
            err.to_string().contains("Aarch64"),
            "unexpected error: {err}",
        );
    }

    /// Two units each declare an uninitialised `int common_var;`
    /// (parser surfaces as SHN_COMMON with size=4, alignment=4).
    /// C99 6.9.2: the linker reserves a single `.bss` slot of
    /// `max(size) == 4` bytes, aligned to `max(align) == 4`.
    /// Both units' references must resolve to that one slot.
    #[test]
    fn common_symbols_coalesce_to_single_bss_slot() {
        let mk_unit = |size: u64, align: u64| NativeObject {
            symbols: alloc::vec![
                super::super::object::NativeSymbol {
                    name: alloc::string::String::new(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: 0,
                    kind: 0,
                    visibility: 0,
                },
                super::super::object::NativeSymbol {
                    name: "common_var".to_string(),
                    section: NativeSymSection::Common,
                    value: align,
                    size,
                    binding: 1,
                    kind: 1,
                    visibility: 0,
                },
            ],
            ..blank_object(NativeMachine::X86_64)
        };
        // Unit A claims size=4 align=4; unit B claims size=8 align=8.
        // C99 6.9.2: max(size)=8, max(align)=8.
        let a = mk_unit(4, 4);
        let b = mk_unit(8, 8);
        let merged = link_native_objects(&[a, b]).expect("link");
        let def = merged
            .defined
            .get("common_var")
            .expect("coalesced common_var should be defined");
        assert!(matches!(def.section, NativeSymSection::Bss));
        assert_eq!(def.size, 8, "max size wins");
        // Total bss = sum-per-unit (0) + coalesced common (8, 8-aligned at offset 0).
        assert_eq!(merged.bss_size, 8);
        assert_eq!(
            def.value, 0,
            "common slot lands at the start of the post-unit bss extent"
        );
    }

    /// The merge keeps per-input-section identity: each contribution's
    /// stream offset is the owning unit's base plus the section's
    /// offset in that unit, and a coalesced COMMON slot is attributed
    /// to its declaring unit.
    #[test]
    fn section_map_records_placements_and_common_slots() {
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let mut a = compile_native(
            "int a_data = 1;\nint main(void) { return a_data; }\n",
            Target::LinuxX64,
            opts,
        );
        a.source = "a.o".to_string();
        let mut b = compile_native_with(
            "int b_data = 2;\nint bfn(void) { return b_data; }\n",
            Target::LinuxX64,
            opts,
            crate::CompileOptions::default().with_no_entry_point(true),
        );
        b.source = "lib.a(b.o)".to_string();
        // A tentative definition (SHN_COMMON) declared by unit B.
        b.symbols.push(super::super::object::NativeSymbol {
            name: "tentative".to_string(),
            section: NativeSymSection::Common,
            value: 8,
            size: 16,
            binding: 1,
            kind: 1,
            visibility: 0,
        });
        let a_text_len = a.text.len();
        let merged = link_native_objects(&[a, b]).expect("link");
        let sm = &merged.section_map;
        assert_eq!(
            sm.sources,
            alloc::vec!["a.o".to_string(), "lib.a(b.o)".to_string()]
        );
        let a_text = sm
            .text
            .iter()
            .find(|c| c.input == Some(0) && c.name == ".text")
            .expect("unit A .text contribution");
        assert_eq!(a_text.offset, 0);
        let b_text = sm
            .text
            .iter()
            .find(|c| c.input == Some(1) && c.name == ".text")
            .expect("unit B .text contribution");
        // Unit B's base: unit A's text, 16-aligned.
        assert_eq!(b_text.offset as usize, a_text_len.next_multiple_of(16));
        let bfn = merged.defined.get("bfn").expect("bfn defined");
        assert!(
            (b_text.offset..b_text.offset + b_text.size).contains(&bfn.value),
            "bfn (0x{:x}) must lie inside unit B's .text contribution",
            bfn.value,
        );
        let tent = merged.defined.get("tentative").expect("tentative defined");
        assert!(matches!(tent.section, NativeSymSection::Bss));
        let slot = sm
            .bss
            .iter()
            .find(|c| c.name == "COMMON")
            .expect("COMMON contribution");
        assert_eq!(slot.input, Some(1), "attributed to the declaring unit");
        assert_eq!(slot.offset, tent.value);
        assert_eq!(slot.size, 16);
    }

    /// A reloc against an SHN_COMMON symbol parks a *unified* data-byte
    /// offset, the same as one against a `.bss`-defined symbol: the
    /// coalesced slot offset is bss-relative, so it needs the merged
    /// `.data` length added. Without the bias the reference lands
    /// `data.len()` bytes low, inside `.data`.
    #[test]
    fn common_symbol_reloc_is_biased_past_merged_data() {
        let mk_unit = |data: alloc::vec::Vec<u8>, with_reloc: bool| NativeObject {
            text: alloc::vec![0u8; 16],
            data,
            symbols: alloc::vec![
                super::super::object::NativeSymbol {
                    name: alloc::string::String::new(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: 0,
                    kind: 0,
                    visibility: 0,
                },
                super::super::object::NativeSymbol {
                    name: "common_var".to_string(),
                    section: NativeSymSection::Common,
                    value: 4,
                    size: 4,
                    binding: 1,
                    kind: 1,
                    visibility: 0,
                },
            ],
            text_relocs: if with_reloc {
                alloc::vec![super::super::object::NativeReloc {
                    offset: 4,
                    sym_idx: 1,
                    rtype: R_X86_64_PC32,
                    addend: -4,
                }]
            } else {
                alloc::vec::Vec::new()
            },
            ..blank_object(NativeMachine::X86_64)
        };
        // Unit A contributes 24 `.data` bytes; unit B holds the reloc.
        let merged = link_native_objects(&[
            mk_unit(alloc::vec![7u8; 24], false),
            mk_unit(Vec::new(), true),
        ])
        .expect("link");
        assert_eq!(merged.data.len(), 24, "merged .data from unit A");
        let def = merged.defined.get("common_var").expect("coalesced");
        assert_eq!(def.value, 0, "common slot at the start of the bss extent");
        let parked: Vec<&PendingImportReloc> = merged
            .pending_imports
            .iter()
            .filter(|p| p.import_index == usize::MAX)
            .collect();
        assert_eq!(parked.len(), 1, "one parked reference to the common slot");
        assert!(matches!(parked[0].target_section, NativeSymSection::Data));
        assert_eq!(
            parked[0].addend,
            merged.data.len() as i64 + def.value as i64 - 4,
            "parked offset must clear the merged .data extent"
        );
    }

    /// SHN_COMMON tentative def + strong (Data) definition of
    /// the same name: per C99 6.9.2 the strong def wins, the
    /// Common is silently dropped. The linker must not error on
    /// the duplicate name nor allocate a second bss slot.
    #[test]
    fn common_yields_to_strong_definition() {
        let unit_common = NativeObject {
            symbols: alloc::vec![
                super::super::object::NativeSymbol {
                    name: alloc::string::String::new(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: 0,
                    kind: 0,
                    visibility: 0,
                },
                super::super::object::NativeSymbol {
                    name: "x".to_string(),
                    section: NativeSymSection::Common,
                    value: 4,
                    size: 4,
                    binding: 1,
                    kind: 1,
                    visibility: 0,
                },
            ],
            ..blank_object(NativeMachine::X86_64)
        };
        let unit_strong = NativeObject {
            data: alloc::vec![0u8; 4],
            symbols: alloc::vec![
                super::super::object::NativeSymbol {
                    name: alloc::string::String::new(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: 0,
                    kind: 0,
                    visibility: 0,
                },
                super::super::object::NativeSymbol {
                    name: "x".to_string(),
                    section: NativeSymSection::Data,
                    value: 0,
                    size: 4,
                    binding: 1,
                    kind: 1,
                    visibility: 0,
                },
            ],
            ..blank_object(NativeMachine::X86_64)
        };
        let merged = link_native_objects(&[unit_common, unit_strong]).expect("link");
        let def = merged
            .defined
            .get("x")
            .expect("x should resolve to the strong def");
        assert!(matches!(def.section, NativeSymSection::Data));
        assert_eq!(merged.bss_size, 0, "Common dropped, no bss slot");
    }

    // STB_WEAK defined symbols from a foreign object must resolve a
    // reference rather than being dropped (ELF/SysV: a weak definition
    // is a real, overridable definition). A strong definition of the
    // same name wins, order-independently, with no multiple-definition
    // error.
    #[test]
    fn weak_defined_symbol_resolves_and_yields_to_strong() {
        use super::super::object::{NativeReloc, NativeSymbol};
        let null_sym = || NativeSymbol {
            name: alloc::string::String::new(),
            section: NativeSymSection::Undef,
            value: 0,
            size: 0,
            binding: 0,
            kind: 0,
            visibility: 0,
        };
        let mk = |text: alloc::vec::Vec<u8>,
                  data: alloc::vec::Vec<u8>,
                  symbols: alloc::vec::Vec<NativeSymbol>,
                  text_relocs: alloc::vec::Vec<NativeReloc>|
         -> NativeObject {
            NativeObject {
                source: alloc::string::String::new(),
                sections: alloc::vec::Vec::new(),
                discarded: alloc::vec::Vec::new(),
                text_align: 16,
                rodata: Vec::new(),
                rodata_align: 8,
                relro: Vec::new(),
                relro_align: 1,
                relro_relocs: Vec::new(),
                machine: NativeMachine::X86_64,
                text,
                data,
                data_align: 1,
                bss_size: 0,
                bss_align: 1,
                tls_data: alloc::vec::Vec::new(),
                tls_relocs: alloc::vec::Vec::new(),
                tls_bss_size: 0,
                tls_align: 1,
                symbols,
                text_relocs,
                data_relocs: alloc::vec::Vec::new(),
                init_funcs: alloc::vec::Vec::new(),
                dylibs: alloc::vec::Vec::new(),
                import_dylib_map: alloc::vec::Vec::new(),
                exports: alloc::vec::Vec::new(),
                tls_index_fixups: alloc::vec::Vec::new(),
                macho_tlv_descriptors: alloc::vec::Vec::new(),
                macho_tlv_fixups: alloc::vec::Vec::new(),
                tls_symbols: alloc::vec::Vec::new(),
                macho_tlv_descriptor_syms: alloc::vec::Vec::new(),
                elf_tpoff_fixups: alloc::vec::Vec::new(),
                copy_relocs: alloc::vec::Vec::new(),
                prologue_ends: alloc::vec::Vec::new(),
                extern_data_names: alloc::vec::Vec::new(),
                debug_info: alloc::vec::Vec::new(),
                debug_abbrev: alloc::vec::Vec::new(),
                debug_line: alloc::vec::Vec::new(),
                debug_str: alloc::vec::Vec::new(),
                debug_info_relocs: alloc::vec::Vec::new(),
                debug_line_relocs: alloc::vec::Vec::new(),
            }
        };
        // Weak definition of `weak_target` in `.text`.
        let weak_unit = || {
            mk(
                alloc::vec![0xC3],
                alloc::vec::Vec::new(),
                alloc::vec![
                    null_sym(),
                    NativeSymbol {
                        name: "weak_target".to_string(),
                        section: NativeSymSection::Text,
                        value: 0,
                        size: 1,
                        binding: 2,
                        kind: 2,
                        visibility: 0,
                    },
                ],
                alloc::vec::Vec::new(),
            )
        };
        // `call weak_target` (R_X86_64_PC32) with an UNDEF reference.
        let ref_unit = mk(
            alloc::vec![0xE8, 0, 0, 0, 0],
            alloc::vec::Vec::new(),
            alloc::vec![
                null_sym(),
                NativeSymbol {
                    name: "weak_target".to_string(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: 1,
                    kind: 0,
                    visibility: 0,
                },
            ],
            alloc::vec![NativeReloc {
                offset: 1,
                sym_idx: 1,
                rtype: 2,
                addend: -4,
            }],
        );
        // A weak def now satisfies the reference (previously "undefined
        // reference to `weak_target`").
        let merged = link_native_objects(&[weak_unit(), ref_unit]).expect("weak def resolves");
        let def = merged.defined.get("weak_target").expect("weak def present");
        assert!(matches!(def.section, NativeSymSection::Text));

        // Strong definition in `.data`.
        let strong_unit = || {
            mk(
                alloc::vec::Vec::new(),
                alloc::vec![0u8; 4],
                alloc::vec![
                    null_sym(),
                    NativeSymbol {
                        name: "weak_target".to_string(),
                        section: NativeSymSection::Data,
                        value: 0,
                        size: 4,
                        binding: 1,
                        kind: 1,
                        visibility: 0,
                    },
                ],
                alloc::vec::Vec::new(),
            )
        };
        // Strong wins over weak, independent of link order, no error.
        for pair in [[weak_unit(), strong_unit()], [strong_unit(), weak_unit()]] {
            let merged = link_native_objects(&pair).expect("strong+weak links");
            let def = merged.defined.get("weak_target").expect("resolved");
            assert!(
                matches!(def.section, NativeSymSection::Data),
                "strong definition must win"
            );
        }
    }

    // A code reference and a data initializer that both name the same
    // wholly-zero global must resolve to the same byte in the `.bss`
    // region. Before the fix the code reference parked a bss-relative
    // offset tagged `Data`, aliasing a `.data` byte, while the data
    // initializer correctly reached `.bss` -- the two diverged.
    #[test]
    fn code_and_data_bss_references_agree() {
        let opts = NativeOptions {
            bss_segregate: true,
            output_kind: OutputKind::Relocatable,
            ..NativeOptions::new()
        };
        // `big` (partially non-zero) inflates `.data` so a bss-relative
        // offset is strictly smaller than the data length; `lead` and `g`
        // (wholly zero) land in `.bss`. `lead` keeps `g` off the region's
        // first byte, so the parked value stays inside the region under
        // the x86-64 pc-relative addend bias. `readg` makes a code
        // reference to `g`.
        let src = "long big[16] = {1}; long lead[8]; long g[8]; \
                   long *const gp = &g[0]; long *const lp = &lead[0]; \
                   long readg(void){ return g[0]; } \
                   int main(void){ return (int)readg() + (gp != 0) \
                   + (lp != 0) + (int)big[0]; }";
        let obj = compile_native(src, Target::LinuxX64, opts);
        let merged = link_native_objects(&[obj]).expect("link");
        assert!(merged.bss_size > 0, "the zero global must occupy bss");

        // The data initializer `gp = &g[0]` reaches the bss section.
        assert!(
            merged
                .data_abs_relocs
                .iter()
                .any(|r| matches!(r.target, MergedTarget::Data(_))),
            "gp initializer must target the bss section"
        );

        // The code reference to `g` parks a unified data-byte offset in
        // the bss region (at or past the data image); before the fix it
        // stayed bss-relative and aliased a `.data` byte.
        let data_len = merged.data.len() as i64;
        let bss_end = data_len + merged.bss_size as i64;
        assert!(
            merged
                .pending_imports
                .iter()
                .any(|p| p.import_index == usize::MAX
                    && p.addend >= data_len
                    && p.addend < bss_end),
            "code reference to a bss global must resolve into the bss region [{data_len}, {bss_end})"
        );
    }

    /// Two objects routing the same import name to different dylibs is a
    /// conflict; first-writer-wins previously bound the loser's calls
    /// against the wrong library with no diagnostic.
    #[test]
    fn conflicting_import_dylib_routing_errors() {
        let mk = |dylib: &str| NativeObject {
            dylibs: alloc::vec![dylib.to_string()],
            import_dylib_map: alloc::vec![("f".to_string(), 0u32)],
            ..blank_object(NativeMachine::X86_64)
        };
        // Same routing across units links fine.
        let merged = link_native_objects(&[mk("libA.so"), mk("libA.so")]).expect("consistent");
        assert_eq!(merged.import_dylib_map.get("f"), Some(&0));
        // Divergent routing errors and names both libraries.
        let err = link_native_objects(&[mk("libA.so"), mk("libB.so")]).unwrap_err();
        assert!(
            err.to_string().contains("libA.so") && err.to_string().contains("libB.so"),
            "error must name both dylibs: {err}"
        );
        // A per-unit dylib index past the unit's dylib list errors.
        let mut bad = mk("libA.so");
        bad.import_dylib_map = alloc::vec![("f".to_string(), 5u32)];
        let err = link_native_objects(&[bad]).unwrap_err();
        assert!(
            err.to_string().contains("out of range"),
            "expected an index diagnostic, got: {err}"
        );
    }

    fn compile_native(src: &str, target: Target, opts: NativeOptions) -> NativeObject {
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse")
    }

    fn compile_native_with(
        src: &str,
        target: Target,
        opts: NativeOptions,
        copts: crate::CompileOptions,
    ) -> NativeObject {
        let program = crate::Compiler::with_options(src.to_string(), target, copts)
            .compile()
            .expect("compile");
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse")
    }

    #[test]
    fn debug_reloc_to_external_symbol_resolves_or_nulls() {
        // Debug info from another toolchain (gcc -g) names symbols that are
        // Undef in the referencing unit: a text symbol defined in another unit
        // must defer to the merged text base; a symbol defined nowhere (a libc
        // import) has no debug-usable link-time address and is nulled. Neither
        // may abort the link.
        use super::super::object::{NativeReloc, NativeSymbol};
        let base = || NativeObject {
            ..blank_object(NativeMachine::X86_64)
        };
        let sym = |name: &str, section| NativeSymbol {
            name: name.to_string(),
            section,
            value: 0,
            size: 0,
            binding: 1,
            kind: 2,
            visibility: 0,
        };
        // Unit B defines `ext_fn` in .text.
        let mut b = base();
        b.text = alloc::vec![0x90u8; 16];
        b.symbols = alloc::vec![
            sym("", NativeSymSection::Undef),
            sym("ext_fn", NativeSymSection::Text),
        ];
        // Unit A's .debug_info holds three 64-bit references: to `ext_fn`
        // (defined in B) at offset 0, to `libc_import` (defined nowhere) at
        // offset 8, and to its own `.data` symbol at offset 16.
        let mut a = base();
        a.text = alloc::vec![0xC3u8; 8];
        a.data = alloc::vec![0u8; 8];
        a.symbols = alloc::vec![
            sym("", NativeSymSection::Undef),
            sym("ext_fn", NativeSymSection::Undef),
            sym("libc_import", NativeSymSection::Undef),
            sym("local_data", NativeSymSection::Data),
        ];
        a.debug_info = alloc::vec![0u8; 24];
        a.debug_info_relocs = alloc::vec![
            NativeReloc {
                offset: 0,
                sym_idx: 1,
                rtype: R_X86_64_64,
                addend: 0
            },
            NativeReloc {
                offset: 8,
                sym_idx: 2,
                rtype: R_X86_64_64,
                addend: 0
            },
            NativeReloc {
                offset: 16,
                sym_idx: 3,
                rtype: R_X86_64_64,
                addend: 0
            },
        ];
        let merged = link_native_objects(&[a, b]).expect("cross-unit debug reference must not ICE");
        let ext_off = merged.defined.get("ext_fn").expect("ext_fn defined").value;
        // Exactly one deferred text reloc -- the cross-unit function reference,
        // pointing where `ext_fn` landed. The import and data references defer
        // nothing and are left null in the merged section.
        assert_eq!(merged.debug_info_text_relocs.len(), 1);
        assert_eq!(merged.debug_info_text_relocs[0].byte_offset, 0);
        assert_eq!(merged.debug_info_text_relocs[0].merged_text_offset, ext_off);
        assert_eq!(&merged.debug_info[8..24], &[0u8; 16]);
    }
}
