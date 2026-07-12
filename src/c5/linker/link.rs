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

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::object::{
    ElfTpoffTarget, NativeMachine, NativeObject, NativeReloc, NativeSymSection, SharedLibrary,
};

/// AArch64 reloc-type constants. Kept in step with the writer
/// and the reader; a future common module lifts them out of
/// each individual file.
const R_X86_64_PC32: u32 = 2;
const R_X86_64_PLT32: u32 = 4;
const R_X86_64_GOTPCREL: u32 = 9;
const R_AARCH64_ADR_PREL_PG_HI21: u32 = 275;
const R_AARCH64_ADD_ABS_LO12_NC: u32 = 277;
const R_AARCH64_CALL26: u32 = 283;
// A tail-call `b <sym>` reaches its target the same way `bl` does --
// a 26-bit PC-relative branch immediate -- so JUMP26 shares CALL26's
// patch, PLT eligibility, and undefined-weak handling. Emitted by
// other toolchains' objects; c5's own codegen uses CALL26 for calls.
const R_AARCH64_JUMP26: u32 = 282;
const R_AARCH64_ADR_GOT_PAGE: u32 = 311;
const R_AARCH64_LD64_GOT_LO12_NC: u32 = 312;
const R_X86_64_TPOFF32: u32 = 23;
const R_AARCH64_TLSLE_ADD_TPREL_HI12: u32 = 549;
const R_AARCH64_TLSLE_ADD_TPREL_LO12_NC: u32 = 551;

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
    /// Concatenated `.data` bytes.
    pub data: Vec<u8>,
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
    /// Data-initializer slots that hold the address of an imported
    /// function: `(slot_data_offset, import_index)`. A function-pointer
    /// table entry naming a shared-library symbol (`static freefn t =
    /// g_free;`) resolves to that import's PLT stub -- a valid function
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
    /// Indices into [`Self::imports`] for `#pragma binding(data ...)`
    /// locals that reached the merge as an UNDEF (the host data symbol
    /// lives in a dylib; Mach-O routes the reference through the GOT).
    /// The PLT pass skips these -- a data import takes no call stub, and
    /// its reference loads the GOT slot directly rather than branching
    /// through a trampoline.
    pub data_import_indices: alloc::collections::BTreeSet<usize>,
    /// Concatenated standard DWARF byte streams from every
    /// input unit. Each unit's blob starts at
    /// `debug_*_bases[unit_idx]` inside the merged stream; the
    /// per-unit relocs (below) have their `r_offset` rebased to
    /// land inside the merged sections.
    pub debug_info: Vec<u8>,
    pub debug_abbrev: Vec<u8>,
    pub debug_line: Vec<u8>,
    pub debug_str: Vec<u8>,
    pub debug_info_bases: Vec<usize>,
    pub debug_abbrev_bases: Vec<usize>,
    pub debug_line_bases: Vec<usize>,
    pub debug_str_bases: Vec<usize>,
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
    pub debug_line_text_relocs: Vec<DebugTextReloc>,
    /// Post-prologue byte offset in [`Self::text`], keyed by the
    /// function's merged entry offset (name-keying would collapse
    /// same-named statics across units onto one anchor). Sourced
    /// from the writer's synthetic
    /// `.Lc5_prologue_end_<funcname>` STB_LOCAL STT_NOTYPE symbols
    /// (see `elf_reloc::PROLOGUE_END_PREFIX`), rebased by the
    /// per-unit text base. The synth path consults this to
    /// populate `Build::func_prologue_native` so
    /// `dwarf::build_debug_frame` emits
    /// `DW_CFA_advance_loc <prologue_size>` ahead of the
    /// post-prologue CFA rule.
    pub prologue_ends: BTreeMap<u64, u64>,
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
    /// `.init_array` / `.fini_array` placement in [`Self::data`] (Pass 1.5),
    /// forwarded to the dynamic-ELF writer so it emits DT_INIT_ARRAY /
    /// DT_FINI_ARRAY. The pointer slots already carry R_*_RELATIVE via
    /// [`Self::data_abs_relocs`].
    pub init_fini_arrays: crate::c5::codegen::InitFiniArrays,
}

/// Pending `R_*_64` relocation that the final-image writer
/// resolves once it knows the runtime vmaddrs.
#[derive(Debug, Clone, Copy)]
pub struct DataAbsReloc {
    /// Byte offset within `MergedNative::data` of the 8-byte
    /// slot to patch.
    pub slot_offset: u64,
    /// Byte offset within the merged image's section of the
    /// pointed-at target.
    pub target_offset: u64,
    /// Section the target lives in. `Data` -> writer patches
    /// `data_vaddr + target_offset`; `Text` -> writer patches
    /// `text_vaddr + target_offset`; `Bss` -> writer patches
    /// `data_vaddr + data_size + target_offset` (bss sits past
    /// `.data` in the runtime image).
    pub target_section: NativeSymSection,
}

/// Where a defined symbol lives in the merged image.
#[derive(Debug, Clone, Copy)]
pub struct MergedSymbol {
    pub section: NativeSymSection,
    /// Byte offset within the merged section (so
    /// `merged.text[value..]` is the symbol's body for a Text
    /// symbol, `merged.data[value..]` for a Data symbol).
    pub value: u64,
    pub size: u64,
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
pub fn link_native_objects_with_shared_libs(
    objs: &[NativeObject],
    allow_undefined: bool,
    shared_libs: &[SharedLibrary],
) -> Result<MergedNative, C5Error> {
    if objs.is_empty() {
        return Err(err("link_native_objects: no input objects"));
    }
    // Union of every shared library's exports: an undefined global
    // reference whose name appears here is a load-time import, not a
    // link error.
    let shlib_exports: BTreeSet<&str> = shared_libs
        .iter()
        .flat_map(|l| l.exports.iter().map(String::as_str))
        .collect();
    // The data-object subset. A reference to one resolves to the
    // object's address through the GOT (a data import), never to a PLT
    // stub -- a stub is code, so reading the object through it returns
    // instructions.
    let shlib_data_exports: BTreeSet<&str> = shared_libs
        .iter()
        .flat_map(|l| l.data_exports.iter().map(String::as_str))
        .collect();
    let machine = objs[0].machine;
    for (i, obj) in objs.iter().enumerate().skip(1) {
        if obj.machine != machine {
            return Err(err(&format!(
                "link_native_objects: object {i}'s machine {:?} differs from object 0's {:?}",
                obj.machine, machine,
            )));
        }
    }

    // `_Thread_local` storage. The Mach-O TLV model resolves each access
    // by a `__thread_vars` descriptor whose per-thread offset the linker
    // fills, so multiple units' TLS blocks concatenate freely: each unit
    // contributes [init bytes ++ zero-fill] to one merged block, and a
    // descriptor's offset is rebased by the unit's base (a unit-local
    // access) or set from the merged TLS symbol table (a cross-unit
    // `extern _Thread_local`). The ELF and Windows/aarch64 paths achieve
    // the same through `NT_BADC_ELF_TPOFF` fixups resolved in Pass 4.1
    // below (x86_64 variant-2 `sub imm32`, Linux/aarch64 variant-1 `add
    // imm12`, Windows/aarch64 TEB-indexed `add imm12`), so a multi-unit
    // link rebases each access against the merged layout. On the
    // Windows/aarch64 TEB path both a unit-local and an extern access
    // record a fixup, so a unit-local offset is rebased by its unit's
    // base in the merged block rather than kept as a baked offset.
    let uses_tlv = objs.iter().any(|o| {
        !o.macho_tlv_descriptors.is_empty()
            || !o.macho_tlv_fixups.is_empty()
            || !o.macho_tlv_descriptor_syms.is_empty()
    });
    let elf_tpoff_resolved = matches!(machine, NativeMachine::X86_64 | NativeMachine::Aarch64);
    let tls_objs: Vec<&NativeObject> = objs
        .iter()
        .filter(|o| !o.tls_data.is_empty() || o.tls_bss_size > 0)
        .collect();
    if !uses_tlv && !elf_tpoff_resolved && tls_objs.len() > 1 {
        return Err(link_err(
            "link_native_objects: more than one input object carries \
             `_Thread_local` storage -- merging multiple TLS blocks needs \
             per-unit TPOFF relocations against the merged layout, which \
             aren't wired yet (TODO). Combine the `_Thread_local` \
             definitions into a single translation unit.",
        ));
    }
    // Each unit's base in the merged TLS block (0 for units with no TLS
    // storage, which contribute nothing).
    let mut tls_bases: Vec<usize> = alloc::vec![0; objs.len()];
    let mut tls_data: Vec<u8> = Vec::new();
    let mut any_tls_init = false;
    for (i, obj) in objs.iter().enumerate() {
        tls_bases[i] = tls_data.len();
        if !obj.tls_data.is_empty() {
            any_tls_init = true;
        }
        tls_data.extend_from_slice(&obj.tls_data);
        tls_data.resize(tls_data.len() + obj.tls_bss_size, 0);
    }
    // The init boundary. Concatenating several units' [init ++ zero-fill]
    // blocks has no single `.tdata` / `.tbss` split point, so when more
    // than one unit contributes -- the Mach-O TLV path, or the multi-unit
    // x86_64 ELF path resolved through `NT_BADC_ELF_TPOFF` -- the whole
    // merged block is emitted as initialised data (the zero-fill regions
    // are already zero bytes) when any unit carries an init template. A
    // single TLS unit keeps the `.tdata` / `.tbss` split the writer
    // expects, so its zero-fill stays out of the file image.
    let multi_tls = tls_objs.len() > 1;
    let tls_init_size = if uses_tlv || (elf_tpoff_resolved && multi_tls) {
        if any_tls_init { tls_data.len() } else { 0 }
    } else {
        tls_objs.first().map(|o| o.tls_data.len()).unwrap_or(0)
    };
    // Merged TLS symbol table: each defined `_Thread_local` resolves to
    // its unit base plus its offset within that unit's block.
    let mut tls_symbol_offsets: BTreeMap<String, u64> = BTreeMap::new();
    for (i, obj) in objs.iter().enumerate() {
        for (name, off, _size) in &obj.tls_symbols {
            tls_symbol_offsets.insert(name.clone(), tls_bases[i] as u64 + off);
        }
    }

    // Pass 1 -- layout. Compute each unit's `.text` / `.data` /
    // `.bss` base in the merged image. 16-byte alignment for
    // `.text` (matches the writer's section header) and 8-byte
    // for `.data` / `.bss`, raised to a unit's own data alignment
    // (a foreign object's high-align sections, e.g. `.rodata.cst16`).
    let mut text_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut data_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut bss_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut text: Vec<u8> = Vec::new();
    let mut data: Vec<u8> = Vec::new();
    let mut bss_size: usize = 0;
    let mut data_align: usize = 8;
    for obj in objs {
        align_up(&mut text, 16);
        text_bases.push(text.len());
        text.extend_from_slice(&obj.text);
        align_up(&mut data, obj.data_align.max(8));
        data_align = data_align.max(obj.data_align);
        data_bases.push(data.len());
        data.extend_from_slice(&obj.data);
        // Each unit's bss offsets carry an alignment residue modulo 16
        // (the `.bss` sh_addralign the per-unit writer claims); a
        // 16-aligned unit base preserves it.
        bss_size = align_usize(bss_size, 16);
        bss_bases.push(bss_size);
        bss_size += obj.bss_size;
    }

    // Pass 1.5 -- `.init_array` / `.fini_array` materialisation. Collect
    // every unit's constructor / destructor entries, rebased to merged
    // `.text` offsets, and order them: prioritized ascending, then
    // unprioritized in link order (a stable sort over
    // `(priority.is_none(), priority)` keeps each unit's slot order). Two
    // contiguous pointer arrays are appended to `.data`; the startup
    // runtime walks `[__init_array_start, __init_array_end)` forward
    // before `main` and `[__fini_array_start, __fini_array_end)` backward
    // after. Each 8-byte slot is a `.text` pointer, so a `DataAbsReloc`
    // (Pass 5) gives the PIE its load-time R_*_RELATIVE. This is the same
    // `.init_array` a system linker + C library consume on the `-c` +
    // system-`cc` path, so both paths run the constructors.
    let mut init_entries: Vec<(Option<u32>, u64)> = Vec::new();
    let mut fini_entries: Vec<(Option<u32>, u64)> = Vec::new();
    for (i, obj) in objs.iter().enumerate() {
        for f in &obj.init_funcs {
            let off = text_bases[i] as u64 + f.unit_text_offset;
            if f.is_destructor {
                fini_entries.push((f.priority, off));
            } else {
                init_entries.push((f.priority, off));
            }
        }
    }
    init_entries.sort_by_key(|&(p, _)| (p.is_none(), p.unwrap_or(0)));
    fini_entries.sort_by_key(|&(p, _)| (p.is_none(), p.unwrap_or(0)));
    // A program with no constructors gets no `.data` change (start ==
    // end leaves the runtime's walk a no-op); only touch the layout when
    // there is something to lay out, so existing data offsets are stable.
    let (init_array_start, init_array_end, fini_array_start, fini_array_end) =
        if init_entries.is_empty() && fini_entries.is_empty() {
            let at = data.len() as u64;
            (at, at, at, at)
        } else {
            align_up(&mut data, 8);
            let init_start = data.len() as u64;
            data.resize(data.len() + init_entries.len() * 8, 0);
            let init_end = data.len() as u64;
            let fini_start = data.len() as u64;
            data.resize(data.len() + fini_entries.len() * 8, 0);
            let fini_end = data.len() as u64;
            (init_start, init_end, fini_start, fini_end)
        };

    // The merged bss region begins at `data.len()` in the unified
    // data-offset space; pad the file image so bss offsets keep their
    // per-unit alignment residues in the final image.
    if bss_size > 0 {
        align_up(&mut data, data_align.max(16));
    }

    // Pass 2 -- defined symbols. Every `STB_GLOBAL` symbol that
    // lives in a `.text` / `.data` / `.bss` section in some
    // unit becomes a defined entry in the merged table at the
    // matching base + the unit-local offset. Multiple
    // definitions (same name in two units) error out -- the
    // ELF rule for `STB_GLOBAL` is "exactly one definition".
    let mut defined: BTreeMap<String, MergedSymbol> = BTreeMap::new();
    // STB_WEAK (binding 2) defined symbols. ELF/SysV treats a weak
    // definition as a real but overridable definition: a strong
    // (STB_GLOBAL) definition of the same name wins with no
    // multiple-definition error, and a weak definition on its own
    // satisfies a reference. Collected separately, then folded into
    // `defined` for every name no strong definition claims.
    let mut weak_defined: BTreeMap<String, MergedSymbol> = BTreeMap::new();
    for (i, obj) in objs.iter().enumerate() {
        for sym in &obj.symbols {
            // STB_LOCAL (0) routes through the static-func pass; only
            // STB_GLOBAL (1) and STB_WEAK (2) join the merged table here.
            if sym.binding != 1 && sym.binding != 2 {
                continue;
            }
            if matches!(sym.section, NativeSymSection::Undef | NativeSymSection::Abs) {
                continue;
            }
            if sym.name.is_empty() {
                continue;
            }
            let base = match sym.section {
                NativeSymSection::Text => text_bases[i],
                NativeSymSection::Data => data_bases[i],
                NativeSymSection::Bss => bss_bases[i],
                _ => continue,
            };
            let merged = MergedSymbol {
                section: sym.section,
                value: base as u64 + sym.value,
                size: sym.size,
            };
            if sym.binding == 2 {
                // Multiple weak definitions -- keep the first, no error.
                weak_defined.entry(sym.name.clone()).or_insert(merged);
                continue;
            }
            if let Some(prev) = defined.get(&sym.name) {
                return Err(link_err(&format!(
                    "multiple definition of `{}` (first at offset 0x{:x}, also at 0x{:x})",
                    sym.name, prev.value, merged.value,
                )));
            }
            defined.insert(sym.name.clone(), merged);
        }
    }
    // Fold weak definitions in behind strong ones: a name a strong def
    // already claims keeps the strong entry (strong wins, silently);
    // every other weak name becomes its own defined entry.
    for (name, merged) in weak_defined {
        defined.entry(name).or_insert(merged);
    }

    // Pass 2.1 -- collect synthetic prologue-end anchors. The
    // per-`.o` writer (`elf_reloc.rs`) emits one
    // STB_LOCAL STT_NOTYPE symbol per function at the post-
    // prologue native byte offset, named with the
    // `PROLOGUE_END_PREFIX` prefix; rebase its value by the
    // unit's text base and key it on the *same unit's* function
    // entry offset. Name-keying would hand a later unit's
    // same-named static the first unit's anchor, describing a
    // framed function as frameless in the Win-x64 .pdata / DWARF
    // CFA output.
    let mut prologue_ends: BTreeMap<u64, u64> = BTreeMap::new();
    for (i, obj) in objs.iter().enumerate() {
        for sym in &obj.symbols {
            if !matches!(sym.section, NativeSymSection::Text) {
                continue;
            }
            let Some(fn_name) = sym.name.strip_prefix(PROLOGUE_END_PREFIX) else {
                continue;
            };
            if fn_name.is_empty() {
                continue;
            }
            // STT_FUNC = 2.
            let Some(fsym) = obj.symbols.iter().find(|s| {
                s.kind == 2 && matches!(s.section, NativeSymSection::Text) && s.name == fn_name
            }) else {
                continue;
            };
            prologue_ends.insert(
                text_bases[i] as u64 + fsym.value,
                text_bases[i] as u64 + sym.value,
            );
        }
    }

    // Pass 2.2 -- defined static functions. `STT_FUNC` `STB_LOCAL`
    // Text symbols, rebased by the unit text base. Kept as a flat list
    // (not a name-keyed map) so two units' same-named statics both
    // survive. The `STT_FUNC` filter excludes the synthetic
    // prologue-end `STT_NOTYPE` anchors collected above.
    let mut local_funcs: Vec<(String, u64)> = Vec::new();
    for (i, obj) in objs.iter().enumerate() {
        for sym in &obj.symbols {
            // STB_GLOBAL = 1, STT_FUNC = 2.
            if sym.binding == 1
                || sym.kind != 2
                || !matches!(sym.section, NativeSymSection::Text)
                || sym.name.is_empty()
            {
                continue;
            }
            local_funcs.push((sym.name.clone(), text_bases[i] as u64 + sym.value));
        }
    }

    // Pass 2.5 -- coalesce SHN_COMMON tentative definitions
    // (C99 6.9.2). For each Common symbol name not already
    // defined by a strong (Text/Data/Bss) entry, accumulate
    // `max(size)` and `max(alignment)` across every unit that
    // declares it, then reserve one zero-init slot per name
    // past the per-unit `.bss` extent and surface the slot as
    // a Bss-defined merged symbol.
    //
    // Common-vs-Strong: strong wins, Common drop. Common-vs-
    // Common: coalesce.
    let mut common_max: BTreeMap<String, (u64, u64)> = BTreeMap::new();
    for obj in objs.iter() {
        for sym in &obj.symbols {
            if !matches!(sym.section, NativeSymSection::Common) {
                continue;
            }
            if sym.name.is_empty() || defined.contains_key(&sym.name) {
                continue;
            }
            let entry = common_max.entry(sym.name.clone()).or_insert((0, 1));
            entry.0 = entry.0.max(sym.size);
            entry.1 = entry.1.max(sym.value.max(1));
        }
    }
    for (name, (size, align)) in &common_max {
        let align = (*align).max(1) as usize;
        bss_size = align_usize(bss_size, align);
        let slot_offset = bss_size as u64;
        bss_size += *size as usize;
        defined.insert(
            name.clone(),
            MergedSymbol {
                section: NativeSymSection::Bss,
                value: slot_offset,
                size: *size,
            },
        );
    }

    // Boundary symbols for the init/fini arrays laid out in Pass 1.5.
    // The startup runtime references them as `extern` arrays; defining
    // them here lets Pass 4 resolve those references against the merged
    // `.data`. Always defined (an empty array leaves start == end so the
    // runtime's walk is a no-op) so the runtime's references never dangle.
    for (name, off) in [
        ("__init_array_start", init_array_start),
        ("__init_array_end", init_array_end),
        ("__fini_array_start", fini_array_start),
        ("__fini_array_end", fini_array_end),
    ] {
        defined.insert(
            name.to_string(),
            MergedSymbol {
                section: NativeSymSection::Data,
                value: off,
                size: 0,
            },
        );
    }

    // Pass 3 -- imports. Walk every UNDEF reference; an entry
    // that doesn't match a defined symbol becomes an import.
    // The final-image writer turns each into a PLT trampoline.
    let mut imports: Vec<String> = Vec::new();
    let mut import_idx_for_name: BTreeMap<String, usize> = BTreeMap::new();
    // Names admitted as flat-namespace imports under `allow_undefined`
    // (a shared library's references the host supplies at `dlopen`).
    let mut flat_imports: alloc::collections::BTreeSet<String> =
        alloc::collections::BTreeSet::new();
    // Local names bound to a host data symbol via `#pragma binding(data
    // ...)`. A unit that references such a name carries no local
    // definition (the symbol lives in a dylib), so the reference reaches
    // the merged table as an UNDEF. On Mach-O it routes through the GOT
    // like a function import; ELF defines the local and uses a COPY
    // relocation instead, so the name never reaches the UNDEF arm there.
    let data_binding_locals: alloc::collections::BTreeSet<String> = objs
        .iter()
        .flat_map(|o| o.copy_relocs.iter().map(|(local, _host)| local.clone()))
        .collect();
    // Import indices for the data-binding locals admitted as GOT imports
    // (Mach-O). The PLT pass consults this to skip stub creation.
    let mut data_import_indices: alloc::collections::BTreeSet<usize> =
        alloc::collections::BTreeSet::new();
    // Names with dylib routing from any unit's binding map. The c5 `.o`
    // writer emits its libc imports as STB_WEAK UNDEF paired with a map
    // entry; a weak UNDEF *without* routing is a genuine unresolved weak
    // reference (typically from a foreign object) and resolves to
    // address 0 per ELF practice rather than becoming a required import.
    let routed_import_names: alloc::collections::BTreeSet<&str> = objs
        .iter()
        .flat_map(|o| o.import_dylib_map.iter().map(|(n, _)| n.as_str()))
        .collect();
    let record_import = |name: &str,
                         imports: &mut Vec<String>,
                         idx_for_name: &mut BTreeMap<String, usize>|
     -> usize {
        if let Some(&i) = idx_for_name.get(name) {
            return i;
        }
        let i = imports.len();
        imports.push(name.to_string());
        idx_for_name.insert(name.to_string(), i);
        i
    };

    // Pass 4 -- relocs. For each unit, walk its `text_relocs`,
    // resolve each against the merged symbol table, and apply
    // the patch in `text` at `text_bases[i] + reloc.offset`.
    let mut pending_imports: Vec<PendingImportReloc> = Vec::new();
    for (i, obj) in objs.iter().enumerate() {
        let text_base = text_bases[i];
        for reloc in &obj.text_relocs {
            let sym = obj.symbols.get(reloc.sym_idx).ok_or_else(|| {
                err(&format!(
                    "link_native_objects: object {i} reloc references symbol index {} out of \
                     range ({} symbols)",
                    reloc.sym_idx,
                    obj.symbols.len(),
                ))
            })?;
            let patch_offset = text_base + reloc.offset as usize;
            // Local-exec TLS relocations duplicate the note-channel TLS
            // fixups for external linkers; Pass 4.1 below patches the
            // same sites from the fixup records, so skip them here.
            // Other TLS models (initial-exec / general-dynamic, from
            // foreign objects) still land in the `NativeSymSection::Tls`
            // arm and error.
            if reloc.rtype == R_X86_64_TPOFF32
                || reloc.rtype == R_AARCH64_TLSLE_ADD_TPREL_HI12
                || reloc.rtype == R_AARCH64_TLSLE_ADD_TPREL_LO12_NC
            {
                continue;
            }
            // GOT-relaxation: badc's own image is ET_EXEC (no symbol
            // preemption), so an emitted GOT reference (adrp :got: + ldr) to a
            // resolvable symbol is materialized directly. Convert the pair to
            // ADR_PREL / ADD_ABS and rewrite the `ldr` back to the `add` it came
            // from; the rest of the loop then resolves it like any direct
            // page-relative reference. An external linker keeps the GOT.
            let relaxed_reloc;
            let reloc = if reloc.rtype == R_AARCH64_ADR_GOT_PAGE
                || reloc.rtype == R_AARCH64_LD64_GOT_LO12_NC
            {
                if reloc.rtype == R_AARCH64_LD64_GOT_LO12_NC && patch_offset + 4 <= text.len() {
                    let ldr = u32::from_le_bytes([
                        text[patch_offset],
                        text[patch_offset + 1],
                        text[patch_offset + 2],
                        text[patch_offset + 3],
                    ]);
                    let add = 0x9100_0000u32 | (ldr & 0x3ff); // add Xrd, Xrn, #0
                    text[patch_offset..patch_offset + 4].copy_from_slice(&add.to_le_bytes());
                }
                relaxed_reloc = NativeReloc {
                    rtype: if reloc.rtype == R_AARCH64_ADR_GOT_PAGE {
                        R_AARCH64_ADR_PREL_PG_HI21
                    } else {
                        R_AARCH64_ADD_ABS_LO12_NC
                    },
                    ..*reloc
                };
                &relaxed_reloc
            } else if reloc.rtype == R_X86_64_GOTPCREL {
                // x86_64 flavor of the same relaxation: turn the
                // `mov reg, [rip+disp32]` GOT load back into the `lea`
                // it came from (opcode 0x8b -> 0x8d, two bytes before
                // the disp32) and resolve as a direct PC32.
                if patch_offset >= 2 && text[patch_offset - 2] == 0x8b {
                    text[patch_offset - 2] = 0x8d;
                }
                relaxed_reloc = NativeReloc {
                    rtype: R_X86_64_PC32,
                    ..*reloc
                };
                &relaxed_reloc
            } else {
                reloc
            };
            match sym.section {
                NativeSymSection::Text => {
                    let target = text_bases[i] as i64 + sym.value as i64 + reloc.addend;
                    if is_aarch64_text_pageref(machine, reloc.rtype) {
                        park_section_ref(
                            machine,
                            &mut pending_imports,
                            patch_offset,
                            reloc,
                            target,
                            NativeSymSection::Text,
                        );
                    } else {
                        apply_reloc(machine, &mut text, patch_offset, reloc, target)?;
                    }
                }
                NativeSymSection::Data => {
                    // Resolved data offset within `merged.data`
                    // for the writer. We can't apply the reloc
                    // yet because the runtime vmaddr gap
                    // between `.text` and `.data` is unknown
                    // until the final-image writer commits a
                    // layout. Park the offset in the reloc's
                    // addend so the writer reads it back
                    // without rebuilding the per-unit base
                    // table.
                    let data_off = data_bases[i] as i64 + sym.value as i64 + reloc.addend;
                    park_data_ref(machine, &mut pending_imports, patch_offset, reloc, data_off);
                }
                NativeSymSection::Undef => {
                    if let Some(def) = defined.get(&sym.name) {
                        // Cross-unit reference to a globally
                        // defined symbol. Text-section targets
                        // can be patched in place because the
                        // text segment's vmaddr is anchored
                        // before the merge runs; data / bss
                        // targets depend on the final-image
                        // writer's `.text`-to-`.data` gap, so
                        // park them through the same path that
                        // local data refs use.
                        match def.section {
                            NativeSymSection::Text => {
                                let target = def.value as i64 + reloc.addend;
                                if is_aarch64_text_pageref(machine, reloc.rtype) {
                                    park_section_ref(
                                        machine,
                                        &mut pending_imports,
                                        patch_offset,
                                        reloc,
                                        target,
                                        NativeSymSection::Text,
                                    );
                                } else {
                                    apply_reloc(machine, &mut text, patch_offset, reloc, target)?;
                                }
                            }
                            NativeSymSection::Data => {
                                let data_off = def.value as i64 + reloc.addend;
                                park_data_ref(
                                    machine,
                                    &mut pending_imports,
                                    patch_offset,
                                    reloc,
                                    data_off,
                                );
                            }
                            NativeSymSection::Bss => {
                                // `.bss` sits past the merged `.data`; park a
                                // unified data-byte offset so the writer's
                                // data-offset-to-vaddr map lands the reference
                                // in the zero-fill tail. `data.len()` is final
                                // after Pass 1.
                                let bss_off = data.len() as i64 + def.value as i64 + reloc.addend;
                                park_data_ref(
                                    machine,
                                    &mut pending_imports,
                                    patch_offset,
                                    reloc,
                                    bss_off,
                                );
                            }
                            NativeSymSection::Undef
                            | NativeSymSection::Abs
                            | NativeSymSection::Common
                            | NativeSymSection::Tls
                            | NativeSymSection::DebugAbbrev
                            | NativeSymSection::DebugLine
                            | NativeSymSection::DebugStr => {
                                return Err(err(&format!(
                                    "link_native_objects: defined entry for `{}` has \
                                     non-progbits section {:?}",
                                    sym.name, def.section,
                                )));
                            }
                        }
                    } else if !sym.name.is_empty() {
                        // STB_GLOBAL UNDEF that doesn't resolve
                        // against any defining unit is a
                        // user-extern reference the program
                        // needs but the link set doesn't
                        // supply. STB_WEAK UNDEF entries are
                        // libc imports the dynamic linker
                        // resolves at load time; let them
                        // through to the PLT pass. With
                        // `allow_undefined` (a shared library), a
                        // global UNDEF is likewise a load-time
                        // import: it carries no dylib routing, so
                        // the per-format writer emits it as a
                        // flat-namespace bind (Mach-O) / undefined
                        // `.dynsym` entry (ELF) the host resolves
                        // through the `dlopen` global scope.
                        // A `#pragma binding(data ...)` local reaches the
                        // merged table as an UNDEF where the binding's host
                        // symbol lives in a dylib. Admit it as a flat import
                        // so the writer binds the host symbol through the GOT,
                        // rather than rejecting it as unresolved.
                        // A shared library's data object (`g_ascii_table`)
                        // is a data import too: its reference reaches the
                        // object through the GOT, never a PLT stub.
                        let is_data_binding = data_binding_locals.contains(&sym.name)
                            || shlib_data_exports.contains(sym.name.as_str());
                        // STB_WEAK = 2. An unresolved weak reference with
                        // no dylib routing resolves to address 0 (C
                        // practice; ELF leaves the symbol 0 so the
                        // `if (fn) fn();` guard idiom skips the call).
                        if sym.binding == 2
                            && !is_data_binding
                            && !routed_import_names.contains(sym.name.as_str())
                        {
                            resolve_weak_undef_to_zero(
                                machine,
                                &mut text,
                                patch_offset,
                                reloc,
                                &sym.name,
                            )?;
                            continue;
                        }
                        if sym.binding == 1
                            && !allow_undefined
                            && !is_data_binding
                            && !shlib_exports.contains(sym.name.as_str())
                        {
                            return Err(link_err(&format!(
                                "undefined reference to `{}`",
                                sym.name,
                            )));
                        }
                        // A global UNDEF admitted here has no dylib
                        // routing; mark it flat so the writer emits a
                        // load-time flat-namespace import.
                        if sym.binding == 1 {
                            flat_imports.insert(sym.name.clone());
                        }
                        let idx = record_import(&sym.name, &mut imports, &mut import_idx_for_name);
                        if is_data_binding {
                            data_import_indices.insert(idx);
                        }
                        pending_imports.push(PendingImportReloc {
                            text_offset: patch_offset as u64,
                            import_index: idx,
                            rtype: reloc.rtype,
                            addend: reloc.addend,
                            target_section: NativeSymSection::Undef,
                        });
                    } else {
                        // UNDEF with no name -- shouldn't
                        // happen from our writer (every reloc
                        // points at a named symbol).
                        return Err(err(&format!(
                            "link_native_objects: reloc at object {i} offset 0x{:x} points at \
                             unnamed UNDEF symbol",
                            reloc.offset,
                        )));
                    }
                }
                NativeSymSection::Bss => {
                    // `.bss` sits past `.data` in the merged image; park a
                    // unified data-byte offset (data length + bss-relative
                    // position) so the writer's data-offset-to-vaddr map
                    // resolves it into the zero-fill tail.
                    let bss_off =
                        data.len() as i64 + bss_bases[i] as i64 + sym.value as i64 + reloc.addend;
                    park_data_ref(machine, &mut pending_imports, patch_offset, reloc, bss_off);
                }
                NativeSymSection::Abs => {
                    // Absolute symbol -- the value goes in
                    // directly. None of our writer's symbols
                    // are ABS (only the file symbol is, and
                    // nothing relocs against it), so this is
                    // an unexpected shape.
                    return Err(err(&format!(
                        "link_native_objects: reloc against ABS symbol `{}` is not supported",
                        sym.name,
                    )));
                }
                NativeSymSection::Common => {
                    // C99 6.9.2 tentative definition: Pass 2.5
                    // coalesced this name into a `.bss` slot.
                    // Look the resolved Bss offset up in
                    // `defined` and route through `park_data_ref`
                    // -- same flow a cross-unit reference to a
                    // Bss-defined symbol takes.
                    let def = defined.get(&sym.name).ok_or_else(|| {
                        err(&format!(
                            "link_native_objects: SHN_COMMON `{}` not coalesced (internal: Pass 2.5 missed it)",
                            sym.name,
                        ))
                    })?;
                    let bss_off = def.value as i64 + reloc.addend;
                    park_data_ref(machine, &mut pending_imports, patch_offset, reloc, bss_off);
                }
                NativeSymSection::Tls => {
                    return Err(link_err(&format!(
                        "reloc against `_Thread_local` symbol `{}` -- \
                         native-linker TLS lowering not yet wired",
                        sym.name,
                    )));
                }
                NativeSymSection::DebugAbbrev
                | NativeSymSection::DebugLine
                | NativeSymSection::DebugStr => {
                    // `.rela.text` shouldn't target a DWARF section
                    // symbol; the producer routes those through
                    // `.rela.debug_info` / `.rela.debug_line` instead.
                    return Err(err(&format!(
                        "link_native_objects: `.rela.text` reloc targets {:?} symbol",
                        sym.section,
                    )));
                }
            }
        }
    }

    // Pass 4.1 -- TLS access fixups. Each unit's `elf_tpoff_fixups` marks
    // the instruction holding a TLS variable's offset immediate; the
    // per-unit emit baked a single-unit default (or a 0 placeholder for an
    // extern access), so re-resolve each against the merged layout. The
    // immediate's bias depends on the access model:
    //   * x86_64 (Linux variant-2) places the block below the thread
    //     pointer, so `imm32 = merged_size - merged_offset` and the access
    //     computes `TP - imm32` (glibc puts the block at `tp -
    //     roundup(memsz, align)`, matching the writer's PT_TLS `p_align`).
    //   * aarch64 Linux (variant-1) places the block above the thread
    //     pointer after a 16-byte TCB reserve, so `imm12 = 16 +
    //     merged_offset` baked into an `add`.
    //   * Windows (both arches) reaches the block through the TEB's TLS
    //     array (`r10`/`x16 = tls_array[_tls_index]`), so the register
    //     already holds the module's block base and the immediate is
    //     `merged_offset` with no bias (an x86_64 `lea` disp32, an aarch64
    //     `add` imm12).
    // `machine` does not separate the Windows and ELF models; the Windows
    // TEB sequence always records a `_tls_index` fixup, so an object
    // carrying any such fixup uses the Windows no-bias offset.
    let merged_tls_total = align_usize(tls_data.len(), 8) as u64;
    for (i, obj) in objs.iter().enumerate() {
        let win_teb = !obj.tls_index_fixups.is_empty();
        for (text_off, target) in &obj.elf_tpoff_fixups {
            let merged_offset = match target {
                ElfTpoffTarget::Local(off) => tls_bases[i] as u64 + off,
                ElfTpoffTarget::Extern(name) => match tls_symbol_offsets.get(name) {
                    Some(o) => *o,
                    None => {
                        return Err(err(&format!(
                            "link_native_objects: TLS access references undefined \
                             `_Thread_local` symbol `{name}`",
                        )));
                    }
                },
            };
            let patch = text_bases[i] + *text_off as usize;
            if patch + 4 > text.len() {
                return Err(err(&format!(
                    "link_native_objects: TLS fixup offset 0x{text_off:x} out of range in object {i}",
                )));
            }
            match machine {
                NativeMachine::X86_64 => {
                    // Windows: the `lea` adds disp32 to the TEB block base,
                    // so disp32 = merged_offset (no bias). Linux variant-2:
                    // the block sits below the thread pointer, so the `add`
                    // takes the negative TPOFF `merged_offset - merged_size`.
                    let value = if win_teb {
                        if merged_offset > i32::MAX as u64 {
                            return Err(err(&format!(
                                "link_native_objects: TLS offset 0x{merged_offset:x} exceeds the \
                                 i32 immediate",
                            )));
                        }
                        merged_offset as i64
                    } else {
                        merged_offset as i64 - merged_tls_total as i64
                    };
                    text[patch..patch + 4].copy_from_slice(&(value as i32).to_le_bytes());
                }
                NativeMachine::Aarch64 => {
                    let tpoff = if win_teb {
                        merged_offset
                    } else {
                        merged_offset + 16
                    };
                    if tpoff >= (1 << 24) {
                        return Err(err(&format!(
                            "link_native_objects: TLS TPOFF 0x{tpoff:x} exceeds the \
                             hi12/lo12 range",
                        )));
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
                            return Err(err(&format!(
                                "link_native_objects: TLS offset 0x{tpoff:x} exceeds the 12-bit \
                                 `add` immediate",
                            )));
                        }
                        patch_imm12(&mut text, patch, tpoff as u32);
                    } else {
                        // Variant-1 local-exec pair: `add #hi12, lsl 12`
                        // at the fixup, `add #lo12` right after it.
                        if patch + 8 > text.len() {
                            return Err(err(&format!(
                                "link_native_objects: TLS fixup offset 0x{text_off:x} out of \
                                 range in object {i}",
                            )));
                        }
                        patch_imm12(&mut text, patch, (tpoff >> 12) as u32);
                        patch_imm12(&mut text, patch + 4, (tpoff & 0xFFF) as u32);
                    }
                }
            }
        }
    }

    // Pass 5 -- `.rela.data` entries. Each unit's data_relocs
    // points at an 8-byte slot in its own `.data` whose final
    // value is the runtime VA of another global. Resolve the
    // target to a merged-image data offset and queue it for
    // the writer to patch once `data_vaddr` is committed.
    let mut data_abs_relocs: Vec<DataAbsReloc> = Vec::new();
    // Data slots that name an imported function; the PLT pass turns each
    // into a stub-targeting `DataAbsReloc` (see `data_import_refs`).
    let mut data_import_refs: Vec<(u64, usize)> = Vec::new();
    for (i, obj) in objs.iter().enumerate() {
        for reloc in &obj.data_relocs {
            if reloc.sym_idx >= obj.symbols.len() {
                return Err(err(&format!(
                    "link_native_objects: .rela.data sym_idx {} out of range in object {i}",
                    reloc.sym_idx,
                )));
            }
            let sym = &obj.symbols[reloc.sym_idx];
            let slot_offset = data_bases[i] as u64 + reloc.offset;
            let resolved_section = match sym.section {
                NativeSymSection::Undef | NativeSymSection::Common => {
                    // Common targets are coalesced into `.bss` by
                    // Pass 2.5 and join `defined` with section
                    // == Bss; the lookup is the same as for an
                    // Undef cross-unit reference.
                    match defined.get(&sym.name) {
                        Some(d) => d.section,
                        // An unresolved weak reference in a data
                        // initializer takes the absolute value
                        // 0 + addend (ELF behavior); patch the
                        // slot now, no reloc survives.
                        None if sym.binding == 2
                            && !routed_import_names.contains(sym.name.as_str()) =>
                        {
                            let slot = slot_offset as usize;
                            if slot + 8 > data.len() {
                                return Err(err(&format!(
                                    "weak data reloc slot 0x{slot:x} past end of data (len {})",
                                    data.len(),
                                )));
                            }
                            data[slot..slot + 8]
                                .copy_from_slice(&(reloc.addend as u64).to_le_bytes());
                            continue;
                        }
                        // A data initializer naming an imported function
                        // (a function-pointer table entry, e.g.
                        // `static freefn t = g_free;`). Route it to the
                        // import's PLT stub -- a valid function pointer --
                        // recorded for the PLT pass to resolve.
                        None if shlib_exports.contains(sym.name.as_str())
                            || import_idx_for_name.contains_key(&sym.name) =>
                        {
                            let idx =
                                record_import(&sym.name, &mut imports, &mut import_idx_for_name);
                            flat_imports.insert(sym.name.clone());
                            data_import_refs.push((slot_offset, idx));
                            continue;
                        }
                        None => {
                            return Err(link_err(&format!(
                                "undefined reference to `{}` (data initializer)",
                                sym.name,
                            )));
                        }
                    }
                }
                NativeSymSection::Tls => {
                    return Err(link_err(&format!(
                        ".rela.data targets `_Thread_local` symbol `{}` -- \
                         native-linker TLS lowering not yet wired",
                        sym.name,
                    )));
                }
                other => other,
            };
            let resolved_value = match sym.section {
                NativeSymSection::Undef | NativeSymSection::Common => {
                    defined.get(&sym.name).map(|d| d.value as i64).unwrap()
                }
                NativeSymSection::Data => data_bases[i] as i64 + sym.value as i64,
                NativeSymSection::Bss => bss_bases[i] as i64 + sym.value as i64,
                NativeSymSection::Text => text_bases[i] as i64 + sym.value as i64,
                NativeSymSection::Tls => {
                    return Err(link_err(&format!(
                        ".rela.data points at `_Thread_local` symbol `{}` -- \
                         native-linker TLS lowering not yet wired",
                        sym.name,
                    )));
                }
                NativeSymSection::Abs => {
                    return Err(err(&format!(
                        "link_native_objects: .rela.data points at ABS symbol `{}`",
                        sym.name,
                    )));
                }
                NativeSymSection::DebugAbbrev
                | NativeSymSection::DebugLine
                | NativeSymSection::DebugStr => {
                    return Err(err(&format!(
                        "link_native_objects: .rela.data points at {:?} symbol `{}`",
                        sym.section, sym.name,
                    )));
                }
            };
            let target_offset = resolved_value + reloc.addend;
            if target_offset < 0 {
                return Err(err(&format!(
                    "link_native_objects: .rela.data resolved to negative offset {}",
                    target_offset,
                )));
            }
            if !matches!(
                resolved_section,
                NativeSymSection::Data | NativeSymSection::Bss | NativeSymSection::Text
            ) {
                return Err(err(&format!(
                    "link_native_objects: .rela.data target `{}` lives in {:?}",
                    sym.name, resolved_section,
                )));
            }
            data_abs_relocs.push(DataAbsReloc {
                slot_offset,
                target_offset: target_offset as u64,
                target_section: resolved_section,
            });
        }
    }
    // Init/fini array slots (laid out in Pass 1.5): each 8-byte slot
    // holds a `.text` function pointer, so it needs the same absolute
    // relocation as a function-pointer data initializer -- an
    // R_*_RELATIVE in the PIE the final-image writer emits.
    for (k, &(_, text_off)) in init_entries.iter().enumerate() {
        data_abs_relocs.push(DataAbsReloc {
            slot_offset: init_array_start + (k * 8) as u64,
            target_offset: text_off,
            target_section: NativeSymSection::Text,
        });
    }
    for (k, &(_, text_off)) in fini_entries.iter().enumerate() {
        data_abs_relocs.push(DataAbsReloc {
            slot_offset: fini_array_start + (k * 8) as u64,
            target_offset: text_off,
            target_section: NativeSymSection::Text,
        });
    }

    // Dedupe dylib paths across input units, preserving the
    // order each unit declared them. The final-image writer
    // emits a DT_NEEDED / LC_LOAD_DYLIB / IMAGE_IMPORT_DESCRIPTOR
    // per surviving entry, so order controls the dynamic loader's
    // search precedence. BTreeSet keeps the dedupe O(N log N) on
    // the full path count; a Vec-scan would be O(N^2) for the
    // 10+ dylibs a large multi-TU link sees.
    let mut dylibs: Vec<String> = Vec::new();
    let mut seen_dylibs: BTreeSet<String> = BTreeSet::new();
    for obj in objs {
        for d in &obj.dylibs {
            if seen_dylibs.insert(d.clone()) {
                dylibs.push(d.clone());
            }
        }
    }
    // Each `-l<name>` shared library is a DT_NEEDED dependency so the
    // dynamic loader resolves the flat imports admitted against its
    // exports above. Recorded by SONAME (the canonical name a
    // dependent names), deduped against the `#pragma dylib` set.
    for lib in shared_libs {
        if !lib.soname.is_empty() && seen_dylibs.insert(lib.soname.clone()) {
            dylibs.push(lib.soname.clone());
        }
    }
    // Build the merged import->dylib map. Each unit's per-import
    // dylib_index is local to that unit's `dylibs` list; translate
    // through `local_to_merged` so the value refers to the merged
    // `dylibs` order. Two units routing the same import to different
    // dylibs is a conflict: whichever entry won, the loser's calls
    // would bind against the wrong library, so reject it.
    let mut import_dylib_map: BTreeMap<String, u32> = BTreeMap::new();
    for (i, obj) in objs.iter().enumerate() {
        let mut local_to_merged: Vec<u32> = Vec::with_capacity(obj.dylibs.len());
        for d in &obj.dylibs {
            // The merged list was built from these same entries above,
            // so the position lookup cannot miss.
            let merged_idx = dylibs
                .iter()
                .position(|m| m == d)
                .expect("merged dylib list contains every per-unit path")
                as u32;
            local_to_merged.push(merged_idx);
        }
        for (name, idx) in &obj.import_dylib_map {
            let merged_idx = local_to_merged.get(*idx as usize).copied().ok_or_else(|| {
                link_err(&format!(
                    "object {i}: import `{name}` routes to dylib index {idx} \
                     out of range ({} dylibs declared)",
                    obj.dylibs.len(),
                ))
            })?;
            match import_dylib_map.get(name) {
                None => {
                    import_dylib_map.insert(name.clone(), merged_idx);
                }
                Some(&prev) if prev == merged_idx => {}
                Some(&prev) => {
                    return Err(link_err(&format!(
                        "import `{name}` routed to `{}` by one object and `{}` by another",
                        dylibs[prev as usize], dylibs[merged_idx as usize],
                    )));
                }
            }
        }
    }

    // Union the `#pragma export` names across units, first-seen
    // order. Each name resolves against the merged `defined` table
    // when the final-image writer builds the export table.
    let mut exports: Vec<String> = Vec::new();
    let mut seen_exports: BTreeSet<String> = BTreeSet::new();
    for obj in objs {
        for name in &obj.exports {
            if seen_exports.insert(name.clone()) {
                exports.push(name.clone());
            }
        }
    }

    // Data-import copy relocations, deduplicated across units. The
    // binding is declared in a header, so the same `(local, host)` pair
    // recurs in every unit that included it.
    let mut copy_relocs: Vec<(String, String)> = Vec::new();
    let mut seen_copy: BTreeSet<(String, String)> = BTreeSet::new();
    for obj in objs {
        for pair in &obj.copy_relocs {
            if seen_copy.insert(pair.clone()) {
                copy_relocs.push(pair.clone());
            }
        }
    }

    // Win64 `_tls_index` fixup sites, rebased from each unit's local
    // `.text` offset to the merged `.text` offset. The PE writer
    // patches each with the address of the `_tls_index` slot it lays
    // out in the TLS directory.
    let mut tls_index_fixups: Vec<usize> = Vec::new();
    for (i, obj) in objs.iter().enumerate() {
        for &off in &obj.tls_index_fixups {
            tls_index_fixups.push(text_bases[i] + off);
        }
    }

    // Mach-O TLV descriptors + fixups. Descriptors concatenate in unit
    // order; each unit's fixups rebase `adrp_offset` by that unit's
    // `.text` base and shift `descriptor_index` past the descriptors
    // contributed by earlier units. Each descriptor's per-thread offset
    // is resolved here: a unit-local descriptor adds the unit's TLS base
    // to its block offset; a symbol-keyed descriptor (a cross-unit
    // `extern _Thread_local` access) takes the variable's offset from the
    // merged TLS symbol table.
    let mut macho_tlv_descriptors: Vec<u64> = Vec::new();
    let mut macho_tlv_fixups: Vec<(usize, usize)> = Vec::new();
    for (i, obj) in objs.iter().enumerate() {
        let desc_base = macho_tlv_descriptors.len();
        let sym_for: BTreeMap<usize, &str> = obj
            .macho_tlv_descriptor_syms
            .iter()
            .map(|(idx, name)| (*idx, name.as_str()))
            .collect();
        for (di, &off) in obj.macho_tlv_descriptors.iter().enumerate() {
            let resolved = match sym_for.get(&di) {
                Some(name) => *tls_symbol_offsets.get(*name).ok_or_else(|| {
                    link_err(&format!(
                        "unresolved `extern _Thread_local` reference to `{name}`",
                    ))
                })?,
                None => tls_bases[i] as u64 + off,
            };
            macho_tlv_descriptors.push(resolved);
        }
        for &(adrp, idx) in &obj.macho_tlv_fixups {
            macho_tlv_fixups.push((text_bases[i] + adrp, desc_base + idx));
        }
    }

    // Merge DWARF sections + their relocs. Each unit's blob is
    // appended to the corresponding merged section; relocs have
    // their `r_offset` shifted by the per-unit base so the
    // writer can apply them once against the merged blob. The
    // reloc's `sym_idx` stays per-unit -- the writer reads it
    // through that unit's symbol table to learn whether the
    // reloc target is `.text` / `.debug_line` / `.debug_abbrev`.
    let mut debug_info: Vec<u8> = Vec::new();
    let mut debug_abbrev: Vec<u8> = Vec::new();
    let mut debug_line: Vec<u8> = Vec::new();
    let mut debug_str: Vec<u8> = Vec::new();
    let mut debug_info_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut debug_abbrev_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut debug_line_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut debug_str_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut debug_info_relocs: Vec<super::object::NativeReloc> = Vec::new();
    let mut debug_line_relocs: Vec<super::object::NativeReloc> = Vec::new();
    let mut unit_for_debug_info_reloc: Vec<usize> = Vec::new();
    let mut unit_for_debug_line_reloc: Vec<usize> = Vec::new();
    for (unit_idx, obj) in objs.iter().enumerate() {
        debug_info_bases.push(debug_info.len());
        debug_abbrev_bases.push(debug_abbrev.len());
        debug_line_bases.push(debug_line.len());
        debug_str_bases.push(debug_str.len());
        let info_base = debug_info.len() as u64;
        let line_base = debug_line.len() as u64;
        debug_info.extend_from_slice(&obj.debug_info);
        debug_abbrev.extend_from_slice(&obj.debug_abbrev);
        debug_line.extend_from_slice(&obj.debug_line);
        debug_str.extend_from_slice(&obj.debug_str);
        for r in &obj.debug_info_relocs {
            let mut shifted = *r;
            shifted.offset = r.offset.wrapping_add(info_base);
            debug_info_relocs.push(shifted);
            unit_for_debug_info_reloc.push(unit_idx);
        }
        for r in &obj.debug_line_relocs {
            let mut shifted = *r;
            shifted.offset = r.offset.wrapping_add(line_base);
            debug_line_relocs.push(shifted);
            unit_for_debug_line_reloc.push(unit_idx);
        }
    }

    // Pass 6 -- DWARF reloc resolution. The per-unit DWARF
    // streams reference offsets into other DWARF sections (CU
    // header debug_abbrev_offset, DW_AT_stmt_list -> debug_line,
    // line-program addresses -> .text). Once each unit's base
    // offset within the merged stream is known the section-
    // relative writes can land directly; absolute text-targeting
    // writes still need the final-image text vmaddr the writer
    // will commit, so they get parked on the merged blob with the
    // intra-stream byte offset of the placeholder and the merged-
    // text offset of the target.
    let mut debug_info_text_relocs: Vec<DebugTextReloc> = Vec::new();
    let mut debug_line_text_relocs: Vec<DebugTextReloc> = Vec::new();
    for (i, reloc) in debug_info_relocs.iter().enumerate() {
        let unit_idx = unit_for_debug_info_reloc[i];
        let obj = &objs[unit_idx];
        let sym = obj.symbols.get(reloc.sym_idx).ok_or_else(|| {
            err(&format!(
                "link_native_objects: debug_info reloc references symbol index {} out of range",
                reloc.sym_idx,
            ))
        })?;
        resolve_debug_reloc(
            machine,
            &mut debug_info,
            &mut debug_info_text_relocs,
            unit_idx,
            reloc,
            sym,
            &text_bases,
            &debug_abbrev_bases,
            &debug_line_bases,
            &debug_str_bases,
        )?;
    }
    for (i, reloc) in debug_line_relocs.iter().enumerate() {
        let unit_idx = unit_for_debug_line_reloc[i];
        let obj = &objs[unit_idx];
        let sym = obj.symbols.get(reloc.sym_idx).ok_or_else(|| {
            err(&format!(
                "link_native_objects: debug_line reloc references symbol index {} out of range",
                reloc.sym_idx,
            ))
        })?;
        resolve_debug_reloc(
            machine,
            &mut debug_line,
            &mut debug_line_text_relocs,
            unit_idx,
            reloc,
            sym,
            &text_bases,
            &debug_abbrev_bases,
            &debug_line_bases,
            &debug_str_bases,
        )?;
    }

    Ok(MergedNative {
        text,
        data,
        data_align,
        bss_size,
        defined,
        imports,
        pending_imports,
        data_abs_relocs,
        data_import_refs,
        machine,
        dylibs,
        import_dylib_map,
        flat_imports,
        exports,
        tls_index_fixups,
        macho_tlv_descriptors,
        macho_tlv_fixups,
        copy_relocs,
        data_import_indices,
        debug_info,
        debug_abbrev,
        debug_line,
        debug_str,
        debug_info_bases,
        debug_abbrev_bases,
        debug_line_bases,
        debug_str_bases,
        debug_info_relocs,
        debug_line_relocs,
        unit_for_debug_info_reloc,
        unit_for_debug_line_reloc,
        debug_info_text_relocs,
        debug_line_text_relocs,
        prologue_ends,
        local_funcs,
        tls_data,
        tls_init_size,
        init_fini_arrays: crate::c5::codegen::InitFiniArrays {
            init: (init_array_end > init_array_start)
                .then_some((init_array_start, init_array_end - init_array_start)),
            fini: (fini_array_end > fini_array_start)
                .then_some((fini_array_start, fini_array_end - fini_array_start)),
        },
    })
}

/// Name prefix the per-`.o` writer (`elf_reloc.rs`) gives the
/// synthetic STB_LOCAL STT_NOTYPE symbol that anchors each
/// function's post-prologue native byte offset. The suffix is
/// the source function name. Kept in sync with
/// `elf_reloc::PROLOGUE_END_PREFIX`.
pub(super) const PROLOGUE_END_PREFIX: &str = ".Lc5_prologue_end_";

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

#[allow(clippy::too_many_arguments)]
fn resolve_debug_reloc(
    machine: NativeMachine,
    section_bytes: &mut [u8],
    text_relocs_out: &mut Vec<DebugTextReloc>,
    unit_idx: usize,
    reloc: &super::object::NativeReloc,
    sym: &super::object::NativeSymbol,
    text_bases: &[usize],
    debug_abbrev_bases: &[usize],
    debug_line_bases: &[usize],
    debug_str_bases: &[usize],
) -> Result<(), C5Error> {
    let patch_off = reloc.offset as usize;
    let unit_target_base = match sym.section {
        NativeSymSection::Text => text_bases[unit_idx] as u64,
        NativeSymSection::DebugAbbrev => debug_abbrev_bases[unit_idx] as u64,
        NativeSymSection::DebugLine => debug_line_bases[unit_idx] as u64,
        NativeSymSection::DebugStr => debug_str_bases[unit_idx] as u64,
        other => {
            return Err(err(&format!(
                "link_native_objects: DWARF reloc targets {other:?}; only Text / DebugAbbrev / \
                 DebugLine / DebugStr are supported",
            )));
        }
    };
    let resolved = unit_target_base
        .wrapping_add(sym.value)
        .wrapping_add(reloc.addend as u64);
    let (width, is_text_targeting) =
        match (machine, reloc.rtype, sym.section) {
            (NativeMachine::X86_64, R_X86_64_64, NativeSymSection::Text)
            | (NativeMachine::Aarch64, R_AARCH64_ABS64, NativeSymSection::Text) => (8u8, true),
            (NativeMachine::X86_64, R_X86_64_32, _)
            | (NativeMachine::Aarch64, R_AARCH64_ABS32, _) => (4u8, false),
            (NativeMachine::X86_64, R_X86_64_64, _)
            | (NativeMachine::Aarch64, R_AARCH64_ABS64, _) => (8u8, false),
            _ => {
                return Err(err(&format!(
                    "link_native_objects: unsupported DWARF reloc type {} for {:?}",
                    reloc.rtype, machine,
                )));
            }
        };
    let end = patch_off.checked_add(width as usize).ok_or_else(|| {
        err(&format!(
            "link_native_objects: DWARF reloc offset 0x{patch_off:x} + width {width} overflows",
        ))
    })?;
    if end > section_bytes.len() {
        return Err(err(&format!(
            "link_native_objects: DWARF reloc patch at 0x{patch_off:x}+{width} past section end \
             ({} bytes)",
            section_bytes.len(),
        )));
    }
    if is_text_targeting {
        // Stash the section-relative placeholder so the writer can
        // patch once `.text`'s runtime address is committed.
        text_relocs_out.push(DebugTextReloc {
            byte_offset: patch_off as u64,
            merged_text_offset: resolved,
            width,
        });
        // Leave the placeholder cleared so a writer that ignores
        // `debug_*_text_relocs` produces deterministic bytes.
        section_bytes[patch_off..end].fill(0);
    } else {
        let bytes = &resolved.to_le_bytes()[..width as usize];
        section_bytes[patch_off..end].copy_from_slice(bytes);
    }
    Ok(())
}

const R_X86_64_64: u32 = 1;
const R_X86_64_32: u32 = 10;
const R_AARCH64_ABS64: u32 = 257;
const R_AARCH64_ABS32: u32 = 258;

/// Per-import PLT trampoline metadata returned by
/// [`emit_x86_64_plt`]. Each entry pairs the trampoline's byte
/// offset in `MergedNative::text` with the import-name index;
/// the final-image writer reads `text_offset` to know where the
/// `JMP qword ptr [rip + disp32]` lives and patches its disp32
/// to reach the matching GOT slot once the GOT's runtime
/// address is known.
#[derive(Debug, Clone, Copy)]
pub struct PltTrampoline {
    /// Byte offset within `MergedNative::text` of the trampoline's
    /// first instruction.
    pub text_offset: usize,
    /// Index into [`MergedNative::imports`].
    pub import_index: usize,
}

/// Lower every `pending_imports` entry into a per-import PLT
/// trampoline appended to `MergedNative::text`, then patch each
/// pending call-site's disp32 to reach its trampoline.
///
/// Each trampoline is the six-byte `JMP qword ptr [rip+disp32]`
/// (`FF 25 disp32`) that x86_64 ELF stubs use. The disp32 is
/// emitted as zero; the final-image writer patches it once it
/// knows the runtime address of the GOT slot for this import.
///
/// On return:
///   * `MergedNative::text` carries the trampoline pool past
///     the original `.text` payload, 16-byte aligned.
///   * Every `pending_imports` entry's call-site has been
///     resolved in place to reach its trampoline via the
///     standard `R_X86_64_PLT32` (`(S + A) - P`) formula.
///   * `MergedNative::pending_imports` is cleared.
///   * The returned `Vec<PltTrampoline>` lists every emitted
///     trampoline in order of first occurrence (one entry per
///     import index that had at least one call-site reloc).
///
/// Limited to `NativeMachine::X86_64`.
/// TODO: emit the matching aarch64 `adrp + ldr + br` trampoline shape.
pub fn emit_x86_64_plt(merged: &mut MergedNative) -> Result<Vec<PltTrampoline>, C5Error> {
    if merged.machine != NativeMachine::X86_64 {
        return Err(err(&format!(
            "emit_x86_64_plt: only NativeMachine::X86_64 is supported, got {:?}",
            merged.machine,
        )));
    }
    // Align the trampoline pool to 16 bytes so a future writer's
    // section-header alignment doesn't have to backfill padding
    // before the first trampoline.
    align_up(&mut merged.text, 16);

    // One trampoline per unique import index, in order of first
    // occurrence in `pending_imports`. An import that no call
    // site reaches for (none of `pending_imports` references it)
    // skips trampoline emission entirely -- the writer's
    // dynamic-link bookkeeping still keeps the import name for
    // symbol-table purposes.
    let mut tramp_for_import: BTreeMap<usize, usize> = BTreeMap::new();
    let mut trampolines: Vec<PltTrampoline> = Vec::new();
    // Drain `pending_imports` into a local; data-ref entries
    // (`import_index == usize::MAX`, parked by `park_data_ref`)
    // get put back so the writer can resolve them against its
    // own `.data` vmaddr later.
    let pending = core::mem::take(&mut merged.pending_imports);
    let data_imports = merged.data_import_indices.clone();
    let mut parked_back: Vec<PendingImportReloc> = Vec::new();
    for reloc in &pending {
        if reloc.import_index == usize::MAX {
            parked_back.push(reloc.clone());
            continue;
        }
        // A data import takes no call stub: its reference loads the
        // IAT slot directly. Re-park the reloc unchanged so
        // `synth_fixups` projects it to a data-load GotFixup
        // (lea -> mov against the slot).
        if data_imports.contains(&reloc.import_index) {
            parked_back.push(reloc.clone());
            continue;
        }
        if reloc.rtype != R_X86_64_PLT32 && reloc.rtype != R_X86_64_PC32 {
            return Err(err(&format!(
                "emit_x86_64_plt: pending reloc at text[{:#x}] has rtype {} \
                 (only PLT32/PC32 supported on x86_64)",
                reloc.text_offset, reloc.rtype,
            )));
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
            // `jmp qword ptr [rip + 0]`. The disp32 stays zero
            // until the writer patches it with the GOT slot's
            // rel32. Six bytes total: `FF 25 00 00 00 00`.
            merged
                .text
                .extend_from_slice(&[0xFF, 0x25, 0x00, 0x00, 0x00, 0x00]);
        }
    }

    // Pass 2 -- patch each call-site's disp32 to reach its
    // trampoline using the same `(S + A) - P` formula that the
    // standard R_X86_64_PLT32 reloc uses. The site's `text_offset`
    // points at the disp32 byte (the codegen sets it to
    // `instr_offset + 1`), so `S` is the trampoline byte offset
    // within the merged text.
    for reloc in &pending {
        if reloc.import_index == usize::MAX {
            continue;
        }
        if data_imports.contains(&reloc.import_index) {
            continue;
        }
        let site = reloc.text_offset as usize;
        let tramp = tramp_for_import
            .get(&reloc.import_index)
            .copied()
            .expect("every reloc has a tramp entry from pass 1");
        let target = tramp as i64 + reloc.addend;
        patch_x86_64_pc32(&mut merged.text, site, target)?;
    }

    // A data initializer naming an imported function resolves to that
    // import's PLT stub. Create a stub for an import referenced only
    // from data, then record a Text-target DataAbsReloc so the writer
    // patches the slot to the stub's vmaddr (a valid function pointer).
    let data_import_refs = merged.data_import_refs.clone();
    for (slot, import_index) in data_import_refs {
        let stub = match tramp_for_import.get(&import_index) {
            Some(&off) => off,
            None => {
                let text_offset = merged.text.len();
                tramp_for_import.insert(import_index, text_offset);
                trampolines.push(PltTrampoline {
                    text_offset,
                    import_index,
                });
                merged
                    .text
                    .extend_from_slice(&[0xFF, 0x25, 0x00, 0x00, 0x00, 0x00]);
                text_offset
            }
        };
        merged.data_abs_relocs.push(DataAbsReloc {
            slot_offset: slot,
            target_offset: stub as u64,
            target_section: NativeSymSection::Text,
        });
    }

    merged.pending_imports = parked_back;
    Ok(trampolines)
}

/// Lower every `pending_imports` entry on an aarch64 merged
/// image into a per-import PLT trampoline appended to
/// `MergedNative::text`, then patch each pending call-site's
/// imm26 to reach its trampoline.
///
/// Each trampoline is the standard twelve-byte `adrp + ldr + br`
/// sequence the codegen's PLT emitter uses:
/// ```text
///   adrp x16, page-of-got-slot   // 0x90000010, immhi/immlo = 0
///   ldr  x16, [x16, off]         // 0xF9400210, imm12      = 0
///   br   x16                     // 0xD61F0200
/// ```
/// The adrp's page-relative immediate and the ldr's offset stay
/// zero; the final-image writer patches them once it knows the
/// runtime address of the GOT slot for this import (the standard
/// `R_AARCH64_ADR_PREL_PG_HI21` + `R_AARCH64_ADD_ABS_LO12_NC`
/// shape, retargeted at the ldr's imm12 here).
///
/// On return:
///   * `MergedNative::text` carries the trampoline pool past the
///     original `.text`, 16-byte aligned.
///   * Every `pending_imports` entry with `rtype ==
///     R_AARCH64_CALL26` has its imm26 patched in place to reach
///     its trampoline.
///   * `MergedNative::pending_imports` is drained of
///     PLT-resolvable entries; data-ref parks remain.
pub fn emit_aarch64_plt(merged: &mut MergedNative) -> Result<Vec<PltTrampoline>, C5Error> {
    if merged.machine != NativeMachine::Aarch64 {
        return Err(err(&format!(
            "emit_aarch64_plt: only NativeMachine::Aarch64 is supported, got {:?}",
            merged.machine,
        )));
    }
    align_up(&mut merged.text, 16);

    let mut tramp_for_import: BTreeMap<usize, usize> = BTreeMap::new();
    let mut trampolines: Vec<PltTrampoline> = Vec::new();
    let pending = core::mem::take(&mut merged.pending_imports);
    let data_imports = merged.data_import_indices.clone();
    let mut parked_back: Vec<PendingImportReloc> = Vec::new();
    for reloc in &pending {
        if reloc.import_index == usize::MAX {
            parked_back.push(reloc.clone());
            continue;
        }
        // A data import takes no call stub: its reference loads the GOT
        // slot directly. Re-park the reloc unchanged so `synth_fixups`
        // projects it to a GotFixup (adrp + ldr) against the slot.
        if data_imports.contains(&reloc.import_index) {
            parked_back.push(reloc.clone());
            continue;
        }
        // CALL26 reaches the stub as a branch; the address-of pair
        // (`adrp` + `add`, `R_AARCH64_ADR_PREL_PG_HI21` +
        // `R_AARCH64_ADD_ABS_LO12_NC`) materializes the stub's
        // address for `&import`. Both need one stub per import.
        if reloc.rtype != R_AARCH64_CALL26
            && reloc.rtype != R_AARCH64_JUMP26
            && reloc.rtype != R_AARCH64_ADR_PREL_PG_HI21
            && reloc.rtype != R_AARCH64_ADD_ABS_LO12_NC
        {
            return Err(err(&format!(
                "emit_aarch64_plt: pending reloc at text[{:#x}] has rtype {} \
                 (only CALL26 / JUMP26 / ADR_PREL_PG_HI21 / ADD_ABS_LO12_NC supported on aarch64)",
                reloc.text_offset, reloc.rtype,
            )));
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
            // adrp x16, 0
            merged.text.extend_from_slice(&0x9000_0010u32.to_le_bytes());
            // ldr x16, [x16]
            merged.text.extend_from_slice(&0xF940_0210u32.to_le_bytes());
            // br x16
            merged.text.extend_from_slice(&0xD61F_0200u32.to_le_bytes());
        }
    }

    for reloc in &pending {
        if reloc.import_index == usize::MAX {
            continue;
        }
        if data_imports.contains(&reloc.import_index) {
            continue;
        }
        let site = reloc.text_offset as usize;
        let tramp = tramp_for_import
            .get(&reloc.import_index)
            .copied()
            .expect("every reloc has a tramp entry from pass 1");
        match reloc.rtype {
            // CALL26 / JUMP26 are PC-relative, so the stub's
            // `merged.text` offset patches in directly regardless of
            // where the text segment lands in vmaddr space.
            R_AARCH64_CALL26 | R_AARCH64_JUMP26 => {
                patch_aarch64_call26(&mut merged.text, site, tramp as i64 + reloc.addend)?
            }
            // The address-of pair (`adrp` + `add`) is page-relative,
            // so its immediates depend on the stub's final vmaddr,
            // which the per-format writer assigns later (the text
            // segment is not page-aligned on Mach-O / PE). Re-park
            // the pair as a Text-section reference to the stub
            // offset; `synth_fixups` projects it into a `FuncFixup`
            // the writer resolves against the real vmaddr, exactly
            // like a function-pointer literal.
            R_AARCH64_ADR_PREL_PG_HI21 | R_AARCH64_ADD_ABS_LO12_NC => {
                parked_back.push(PendingImportReloc {
                    text_offset: reloc.text_offset,
                    import_index: usize::MAX,
                    rtype: reloc.rtype,
                    addend: tramp as i64,
                    target_section: NativeSymSection::Text,
                });
            }
            _ => unreachable!("pass 1 rejected every other rtype"),
        }
    }

    // A data initializer naming an imported function resolves to that
    // import's PLT stub. Create a stub for an import referenced only
    // from data, then record a Text-target DataAbsReloc so the writer
    // patches the slot to the stub's vmaddr (a valid function pointer).
    let data_import_refs = merged.data_import_refs.clone();
    for (slot, import_index) in data_import_refs {
        let stub = match tramp_for_import.get(&import_index) {
            Some(&off) => off,
            None => {
                let text_offset = merged.text.len();
                tramp_for_import.insert(import_index, text_offset);
                trampolines.push(PltTrampoline {
                    text_offset,
                    import_index,
                });
                // adrp x16, 0 ; ldr x16, [x16] ; br x16
                merged.text.extend_from_slice(&0x9000_0010u32.to_le_bytes());
                merged.text.extend_from_slice(&0xF940_0210u32.to_le_bytes());
                merged.text.extend_from_slice(&0xD61F_0200u32.to_le_bytes());
                text_offset
            }
        };
        merged.data_abs_relocs.push(DataAbsReloc {
            slot_offset: slot,
            target_offset: stub as u64,
            target_section: NativeSymSection::Text,
        });
    }

    merged.pending_imports = parked_back;
    Ok(trampolines)
}

// ---- Reloc application ----

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
        err(&format!(
            "unresolved weak reference to `{name}`: cannot resolve {what} to address 0",
        ))
    };
    if patch_offset
        .checked_add(4)
        .is_none_or(|end| end > text.len())
    {
        return Err(err(&format!(
            "relocation patch offset 0x{patch_offset:x} past end of text (len {})",
            text.len(),
        )));
    }
    const AARCH64_NOP: u32 = 0xd503_201f;
    match (machine, reloc.rtype) {
        (NativeMachine::Aarch64, R_AARCH64_CALL26) | (NativeMachine::Aarch64, R_AARCH64_JUMP26) => {
            text[patch_offset..patch_offset + 4].copy_from_slice(&AARCH64_NOP.to_le_bytes());
            Ok(())
        }
        (NativeMachine::Aarch64, R_AARCH64_ADR_PREL_PG_HI21) => {
            // `adrp xd, <page>` -> `movz xd, #0`.
            let instr =
                u32::from_le_bytes(text[patch_offset..patch_offset + 4].try_into().unwrap());
            let rd = instr & 0x1f;
            let movz = 0xd280_0000 | rd;
            text[patch_offset..patch_offset + 4].copy_from_slice(&movz.to_le_bytes());
            Ok(())
        }
        (NativeMachine::Aarch64, R_AARCH64_ADD_ABS_LO12_NC) => {
            // The pair's ADRP already produced 0 in `xn`; keep the
            // destination 0 whether or not it aliases the source.
            let instr =
                u32::from_le_bytes(text[patch_offset..patch_offset + 4].try_into().unwrap());
            let rd = instr & 0x1f;
            let rn = (instr >> 5) & 0x1f;
            let repl = if rd == rn {
                AARCH64_NOP
            } else {
                0xd280_0000 | rd
            };
            text[patch_offset..patch_offset + 4].copy_from_slice(&repl.to_le_bytes());
            Ok(())
        }
        (NativeMachine::X86_64, R_X86_64_PLT32) | (NativeMachine::X86_64, R_X86_64_PC32) => {
            // `r_offset` names the disp32 field; classify by the
            // instruction bytes ahead of it.
            if patch_offset >= 1 && text[patch_offset - 1] == 0xE8 {
                // `call rel32` -> 5-byte NOP (0F 1F 44 00 00).
                text[patch_offset - 1..patch_offset + 4]
                    .copy_from_slice(&[0x0F, 0x1F, 0x44, 0x00, 0x00]);
                return Ok(());
            }
            if patch_offset >= 3
                && (0x40..=0x4f).contains(&text[patch_offset - 3])
                && text[patch_offset - 2] == 0x8D
                && text[patch_offset - 1] & 0xC7 == 0x05
            {
                // `lea reg, [rip+disp32]` -> `mov reg, 0` (C7 /0
                // imm32). The modrm reg field moves to rm, so the
                // REX.R bit becomes REX.B; REX.W carries over.
                let rex = text[patch_offset - 3];
                let reg = (text[patch_offset - 1] >> 3) & 0x7;
                text[patch_offset - 3] = 0x40 | (rex & 0x08) | ((rex & 0x04) >> 2);
                text[patch_offset - 2] = 0xC7;
                text[patch_offset - 1] = 0xC0 | reg;
                text[patch_offset..patch_offset + 4].copy_from_slice(&[0, 0, 0, 0]);
                return Ok(());
            }
            Err(unsupported("the referencing instruction"))
        }
        _ => Err(unsupported(&format!("reloc type {}", reloc.rtype))),
    }
}

fn apply_reloc(
    machine: NativeMachine,
    text: &mut [u8],
    patch_offset: usize,
    reloc: &NativeReloc,
    target: i64,
) -> Result<(), C5Error> {
    // `patch_offset` derives from the object's r_offset, which is
    // untrusted input. Every patch below writes a 4-byte instruction
    // word; validate the site is in bounds before indexing so a
    // malformed object yields a diagnostic, not a slice-index panic.
    if patch_offset
        .checked_add(4)
        .is_none_or(|end| end > text.len())
    {
        return Err(err(&format!(
            "relocation patch offset 0x{patch_offset:x} past end of text (len {})",
            text.len(),
        )));
    }
    match (machine, reloc.rtype) {
        (NativeMachine::Aarch64, R_AARCH64_CALL26) | (NativeMachine::Aarch64, R_AARCH64_JUMP26) => {
            patch_aarch64_call26(text, patch_offset, target)
        }
        (NativeMachine::X86_64, R_X86_64_PLT32) | (NativeMachine::X86_64, R_X86_64_PC32) => {
            patch_x86_64_pc32(text, patch_offset, target)
        }
        (NativeMachine::Aarch64, R_AARCH64_ADR_PREL_PG_HI21) => {
            patch_aarch64_adr_pg(text, patch_offset, target)
        }
        (NativeMachine::Aarch64, R_AARCH64_ADD_ABS_LO12_NC) => {
            patch_aarch64_add_lo12(text, patch_offset, target)
        }
        _ => Err(err(&format!(
            "apply_reloc: machine {:?} reloc type {} (0x{:x}) not implemented",
            machine, reloc.rtype, reloc.rtype,
        ))),
    }
}

fn patch_aarch64_call26(text: &mut [u8], offset: usize, target: i64) -> Result<(), C5Error> {
    // imm26 is bits 0..25 of the BL/B instruction, encoded as
    // (target - offset) >> 2 (instruction-relative, in 4-byte
    // units). Signed 26-bit fit check.
    let disp = target - offset as i64;
    if disp.rem_euclid(4) != 0 {
        return Err(err(&format!(
            "CALL26 disp 0x{disp:x} not 4-byte aligned at offset 0x{offset:x}",
        )));
    }
    let words = disp >> 2;
    if !(-(1 << 25)..(1 << 25)).contains(&words) {
        return Err(err(&format!(
            "CALL26 disp 0x{disp:x} doesn't fit in 26 bits (target 0x{target:x}, site 0x{offset:x})",
        )));
    }
    let imm26 = (words as u32) & 0x03ff_ffff;
    let mut instr = u32::from_le_bytes(text[offset..offset + 4].try_into().unwrap());
    instr = (instr & !0x03ff_ffff) | imm26;
    text[offset..offset + 4].copy_from_slice(&instr.to_le_bytes());
    Ok(())
}

fn patch_x86_64_pc32(text: &mut [u8], offset: usize, target: i64) -> Result<(), C5Error> {
    // ELF AMD64 ABI section 4.4.1: `R_X86_64_PC32` / `R_X86_64_PLT32`
    // resolve to (`S + A`) - `P` where `S` is the symbol value,
    // `A` the addend, and `P` the patch site. `apply_reloc`
    // passes the sum `S + A` in `target`; the subtraction lives
    // here so the contract matches `patch_aarch64_call26`'s.
    let disp = target - offset as i64;
    if !(i32::MIN as i64..=i32::MAX as i64).contains(&disp) {
        return Err(err(&format!(
            "PC32 disp 0x{disp:x} doesn't fit in 32 bits at offset 0x{offset:x}",
        )));
    }
    text[offset..offset + 4].copy_from_slice(&(disp as i32).to_le_bytes());
    Ok(())
}

fn patch_aarch64_adr_pg(text: &mut [u8], offset: usize, target: i64) -> Result<(), C5Error> {
    // ADRP encodes bits 32..12 of the 4-KiB-page distance from
    // the instruction's PC. Split into immlo (bits 30..29) and
    // immhi (bits 23..5).
    let pc_page = (offset as i64) & !0xfff;
    let target_page = target & !0xfff;
    let delta = target_page - pc_page;
    let pages = delta >> 12;
    if !(-(1 << 20)..(1 << 20)).contains(&pages) {
        return Err(err(&format!(
            "ADR_PREL_PG_HI21 disp 0x{delta:x} out of +-2^32 range at 0x{offset:x}",
        )));
    }
    let immlo = (pages as u32) & 0x3;
    let immhi = ((pages as u32) >> 2) & 0x7ffff;
    let mut instr = u32::from_le_bytes(text[offset..offset + 4].try_into().unwrap());
    instr = (instr & !0x60ff_ffe0) | (immlo << 29) | (immhi << 5);
    text[offset..offset + 4].copy_from_slice(&instr.to_le_bytes());
    Ok(())
}

fn patch_aarch64_add_lo12(text: &mut [u8], offset: usize, target: i64) -> Result<(), C5Error> {
    // ADD (immediate) carries the low 12 bits of the target as
    // imm12 (bits 21..10) of the instruction.
    let imm12 = ((target & 0xfff) as u32) & 0xfff;
    let mut instr = u32::from_le_bytes(text[offset..offset + 4].try_into().unwrap());
    instr = (instr & !0x003f_fc00) | (imm12 << 10);
    text[offset..offset + 4].copy_from_slice(&instr.to_le_bytes());
    Ok(())
}

fn is_aarch64_text_pageref(machine: NativeMachine, rtype: u32) -> bool {
    matches!(machine, NativeMachine::Aarch64)
        && matches!(
            rtype,
            R_AARCH64_ADR_PREL_PG_HI21 | R_AARCH64_ADD_ABS_LO12_NC
        )
}

fn park_section_ref(
    _machine: NativeMachine,
    pending: &mut Vec<PendingImportReloc>,
    patch_offset: usize,
    reloc: &NativeReloc,
    target_offset: i64,
    target_section: NativeSymSection,
) {
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
    });
}

fn park_data_ref(
    machine: NativeMachine,
    pending: &mut Vec<PendingImportReloc>,
    patch_offset: usize,
    reloc: &NativeReloc,
    target_offset: i64,
) {
    park_section_ref(
        machine,
        pending,
        patch_offset,
        reloc,
        target_offset,
        NativeSymSection::Data,
    );
}

// ---- helpers ----

fn align_up(v: &mut Vec<u8>, alignment: usize) {
    while !v.len().is_multiple_of(alignment) {
        v.push(0);
    }
}

fn align_usize(v: usize, alignment: usize) -> usize {
    v.div_ceil(alignment) * alignment
}

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(msg))
}

fn link_err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_link_err(msg))
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::linker::object::parse_native_elf;
    use crate::{Compiler, NativeOptions, OutputKind, Target, emit_native_with_options};

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
        // export, e.g. glib's `g_ascii_table`) must resolve to the
        // object's address through the GOT -- a data import -- not to a
        // PLT stub, whose bytes are code. The `data_exports` set drives
        // this: it routes the reference like a `#pragma binding(data ...)`
        // local so the PLT pass skips a call stub for it.
        let target = Target::LinuxAarch64;
        let mut opts = NativeOptions::new().with_debug_info(false);
        opts.output_kind = OutputKind::Relocatable;
        let copts = crate::CompileOptions::default().with_no_entry_point(true);
        let src = "extern unsigned short tbl[]; int f(void){ return tbl[3]; }\n";
        let obj = compile_native_with(src, target, opts, copts);

        let names = |n: &str| core::iter::once(alloc::string::String::from(n)).collect();
        let lib = SharedLibrary {
            soname: alloc::string::String::from("libext.so.1"),
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
            merged.data_import_indices.contains(&idx),
            "a shared-library data object must route as a data import, not a call stub",
        );
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
    /// import (`static fn t = ext_fn;`, the qemu TypeInfo shape) links
    /// instead of erroring, and the PLT pass turns the data slot into a
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
        let reloc = super::super::object::NativeReloc {
            offset: 0,
            sym_idx: 0,
            rtype: R_AARCH64_JUMP26,
            addend: 0,
        };
        apply_reloc(NativeMachine::Aarch64, &mut text, 0, &reloc, 0x20)
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
            machine: NativeMachine::X86_64,
            text: alloc::vec::Vec::new(),
            data: alloc::vec::Vec::new(),
            data_align: 1,
            bss_size: 0,
            tls_data: alloc::vec::Vec::new(),
            tls_bss_size: 0,
            symbols: alloc::vec![
                super::super::object::NativeSymbol {
                    name: alloc::string::String::new(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: 0,
                    kind: 0,
                },
                super::super::object::NativeSymbol {
                    name: "common_var".to_string(),
                    section: NativeSymSection::Common,
                    value: align,
                    size,
                    binding: 1,
                    kind: 1,
                },
            ],
            text_relocs: alloc::vec::Vec::new(),
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
            debug_info: alloc::vec::Vec::new(),
            debug_abbrev: alloc::vec::Vec::new(),
            debug_line: alloc::vec::Vec::new(),
            debug_str: alloc::vec::Vec::new(),
            debug_info_relocs: alloc::vec::Vec::new(),
            debug_line_relocs: alloc::vec::Vec::new(),
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

    /// SHN_COMMON tentative def + strong (Data) definition of
    /// the same name: per C99 6.9.2 the strong def wins, the
    /// Common is silently dropped. The linker must not error on
    /// the duplicate name nor allocate a second bss slot.
    #[test]
    fn common_yields_to_strong_definition() {
        let unit_common = NativeObject {
            machine: NativeMachine::X86_64,
            text: alloc::vec::Vec::new(),
            data: alloc::vec::Vec::new(),
            data_align: 1,
            bss_size: 0,
            tls_data: alloc::vec::Vec::new(),
            tls_bss_size: 0,
            symbols: alloc::vec![
                super::super::object::NativeSymbol {
                    name: alloc::string::String::new(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: 0,
                    kind: 0,
                },
                super::super::object::NativeSymbol {
                    name: "x".to_string(),
                    section: NativeSymSection::Common,
                    value: 4,
                    size: 4,
                    binding: 1,
                    kind: 1,
                },
            ],
            text_relocs: alloc::vec::Vec::new(),
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
            debug_info: alloc::vec::Vec::new(),
            debug_abbrev: alloc::vec::Vec::new(),
            debug_line: alloc::vec::Vec::new(),
            debug_str: alloc::vec::Vec::new(),
            debug_info_relocs: alloc::vec::Vec::new(),
            debug_line_relocs: alloc::vec::Vec::new(),
        };
        let unit_strong = NativeObject {
            machine: NativeMachine::X86_64,
            text: alloc::vec::Vec::new(),
            data: alloc::vec![0u8; 4],
            data_align: 1,
            bss_size: 0,
            tls_data: alloc::vec::Vec::new(),
            tls_bss_size: 0,
            symbols: alloc::vec![
                super::super::object::NativeSymbol {
                    name: alloc::string::String::new(),
                    section: NativeSymSection::Undef,
                    value: 0,
                    size: 0,
                    binding: 0,
                    kind: 0,
                },
                super::super::object::NativeSymbol {
                    name: "x".to_string(),
                    section: NativeSymSection::Data,
                    value: 0,
                    size: 4,
                    binding: 1,
                    kind: 1,
                },
            ],
            text_relocs: alloc::vec::Vec::new(),
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
            debug_info: alloc::vec::Vec::new(),
            debug_abbrev: alloc::vec::Vec::new(),
            debug_line: alloc::vec::Vec::new(),
            debug_str: alloc::vec::Vec::new(),
            debug_info_relocs: alloc::vec::Vec::new(),
            debug_line_relocs: alloc::vec::Vec::new(),
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
        };
        let mk = |text: alloc::vec::Vec<u8>,
                  data: alloc::vec::Vec<u8>,
                  symbols: alloc::vec::Vec<NativeSymbol>,
                  text_relocs: alloc::vec::Vec<NativeReloc>|
         -> NativeObject {
            NativeObject {
                machine: NativeMachine::X86_64,
                text,
                data,
                data_align: 1,
                bss_size: 0,
                tls_data: alloc::vec::Vec::new(),
                tls_bss_size: 0,
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
        // offset is strictly smaller than the data length; `g` (wholly
        // zero) lands in `.bss`. `readg` makes a code reference to `g`.
        let src = "long big[16] = {1}; long g[8]; long *const gp = &g[0]; \
                   long readg(void){ return g[0]; } \
                   int main(void){ return (int)readg() + (gp != 0) + (int)big[0]; }";
        let obj = compile_native(src, Target::LinuxX64, opts);
        let merged = link_native_objects(&[obj]).expect("link");
        assert!(merged.bss_size > 0, "the zero global must occupy bss");

        // The data initializer `gp = &g[0]` reaches the bss section.
        assert!(
            merged
                .data_abs_relocs
                .iter()
                .any(|r| matches!(r.target_section, NativeSymSection::Bss)),
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
            machine: NativeMachine::X86_64,
            text: alloc::vec::Vec::new(),
            data: alloc::vec::Vec::new(),
            data_align: 1,
            bss_size: 0,
            tls_data: alloc::vec::Vec::new(),
            tls_bss_size: 0,
            symbols: alloc::vec::Vec::new(),
            text_relocs: alloc::vec::Vec::new(),
            data_relocs: alloc::vec::Vec::new(),
            init_funcs: alloc::vec::Vec::new(),
            dylibs: alloc::vec![dylib.to_string()],
            import_dylib_map: alloc::vec![("f".to_string(), 0u32)],
            exports: alloc::vec::Vec::new(),
            tls_index_fixups: alloc::vec::Vec::new(),
            macho_tlv_descriptors: alloc::vec::Vec::new(),
            macho_tlv_fixups: alloc::vec::Vec::new(),
            tls_symbols: alloc::vec::Vec::new(),
            macho_tlv_descriptor_syms: alloc::vec::Vec::new(),
            elf_tpoff_fixups: alloc::vec::Vec::new(),
            copy_relocs: alloc::vec::Vec::new(),
            debug_info: alloc::vec::Vec::new(),
            debug_abbrev: alloc::vec::Vec::new(),
            debug_line: alloc::vec::Vec::new(),
            debug_str: alloc::vec::Vec::new(),
            debug_info_relocs: alloc::vec::Vec::new(),
            debug_line_relocs: alloc::vec::Vec::new(),
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
}
