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

use super::object::{NativeMachine, NativeObject, NativeReloc, NativeSymSection};

/// AArch64 reloc-type constants. Kept in step with the writer
/// and the reader; a future common module lifts them out of
/// each individual file.
const R_X86_64_PC32: u32 = 2;
const R_X86_64_PLT32: u32 = 4;
const R_AARCH64_ADR_PREL_PG_HI21: u32 = 275;
const R_AARCH64_ADD_ABS_LO12_NC: u32 = 277;
const R_AARCH64_CALL26: u32 = 283;

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
    /// Per-function post-prologue byte offset in [`Self::text`].
    /// Sourced from the writer's synthetic
    /// `.Lc5_prologue_end_<funcname>` STB_LOCAL STT_NOTYPE symbols
    /// (see `elf_reloc::PROLOGUE_END_PREFIX`), rebased by the
    /// per-unit text base. The synth path consults this to
    /// populate `Build::func_prologue_native` so
    /// `dwarf::build_debug_frame` emits
    /// `DW_CFA_advance_loc <prologue_size>` ahead of the
    /// post-prologue CFA rule.
    pub prologue_ends: BTreeMap<String, u64>,
    /// Per-thread TLS image for the merged executable. The first
    /// [`Self::tls_init_size`] bytes are the initialised `.tdata`
    /// template; the remainder is `.tbss` zero-fill. The per-format
    /// writers consume this as `Build::tls_data` / `tls_init_size`
    /// to lay out PT_TLS (ELF), the TLV section (Mach-O), or the
    /// `.tls` directory (PE). Empty when no input object carries
    /// `_Thread_local` storage.
    pub tls_data: Vec<u8>,
    pub tls_init_size: usize,
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
    if objs.is_empty() {
        return Err(err("link_native_objects: no input objects"));
    }
    let machine = objs[0].machine;
    for (i, obj) in objs.iter().enumerate().skip(1) {
        if obj.machine != machine {
            return Err(err(&format!(
                "link_native_objects: object {i}'s machine {:?} differs from object 0's {:?}",
                obj.machine, machine,
            )));
        }
    }

    // `_Thread_local` storage. A single TLS-bearing object carries
    // its layout through verbatim: `Inst::TlsAddr` on the local-exec
    // model bakes `tpoff = tls_total_size - offset` straight into
    // `.text`, and the relinked PT_TLS block keeps the same size, so
    // the baked offset stays valid (ELF gABI variant-2 TLS). Two or
    // more TLS objects would each have baked an offset against their
    // own block; merging the blocks shifts those offsets, so the
    // multi-object case needs `R_X86_64_TPOFF32` / `R_AARCH64_TLSLE_*`
    // relocations to re-derive each offset against the merged block.
    // That isn't wired yet, so reject more than one TLS contributor.
    let tls_objs: Vec<&NativeObject> = objs
        .iter()
        .filter(|o| !o.tls_data.is_empty() || o.tls_bss_size > 0)
        .collect();
    if tls_objs.len() > 1 {
        return Err(link_err(
            "link_native_objects: more than one input object carries \
             `_Thread_local` storage -- merging multiple TLS blocks needs \
             per-unit TPOFF relocations against the merged layout, which \
             aren't wired yet (TODO). Combine the `_Thread_local` \
             definitions into a single translation unit.",
        ));
    }
    let (tls_data, tls_init_size) = match tls_objs.first() {
        Some(o) => {
            let init = o.tls_data.len();
            let mut buf = o.tls_data.clone();
            buf.resize(init + o.tls_bss_size, 0);
            (buf, init)
        }
        None => (Vec::new(), 0),
    };

    // Pass 1 -- layout. Compute each unit's `.text` / `.data` /
    // `.bss` base in the merged image. 16-byte alignment for
    // `.text` (matches the writer's section header) and 8-byte
    // for `.data` / `.bss`.
    let mut text_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut data_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut bss_bases: Vec<usize> = Vec::with_capacity(objs.len());
    let mut text: Vec<u8> = Vec::new();
    let mut data: Vec<u8> = Vec::new();
    let mut bss_size: usize = 0;
    for obj in objs {
        align_up(&mut text, 16);
        text_bases.push(text.len());
        text.extend_from_slice(&obj.text);
        align_up(&mut data, 8);
        data_bases.push(data.len());
        data.extend_from_slice(&obj.data);
        bss_size = align_usize(bss_size, 8);
        bss_bases.push(bss_size);
        bss_size += obj.bss_size;
    }

    // Pass 2 -- defined symbols. Every `STB_GLOBAL` symbol that
    // lives in a `.text` / `.data` / `.bss` section in some
    // unit becomes a defined entry in the merged table at the
    // matching base + the unit-local offset. Multiple
    // definitions (same name in two units) error out -- the
    // ELF rule for `STB_GLOBAL` is "exactly one definition".
    let mut defined: BTreeMap<String, MergedSymbol> = BTreeMap::new();
    for (i, obj) in objs.iter().enumerate() {
        for sym in &obj.symbols {
            if sym.binding != 1 {
                // STB_GLOBAL = 1
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
            if let Some(prev) = defined.get(&sym.name) {
                return Err(link_err(&format!(
                    "multiple definition of `{}` (first at offset 0x{:x}, also at 0x{:x})",
                    sym.name, prev.value, merged.value,
                )));
            }
            defined.insert(sym.name.clone(), merged);
        }
    }

    // Pass 2.1 -- collect synthetic prologue-end anchors. The
    // per-`.o` writer (`elf_reloc.rs`) emits one
    // STB_LOCAL STT_NOTYPE symbol per function at the post-
    // prologue native byte offset, named with the
    // `PROLOGUE_END_PREFIX` prefix; rebase its value by the
    // unit's text base and key it on the source function name
    // (the suffix). Duplicate names lose to the first writer
    // (matches the `defined` rule for STB_GLOBAL above).
    let mut prologue_ends: BTreeMap<String, u64> = BTreeMap::new();
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
            let merged_offset = text_bases[i] as u64 + sym.value;
            prologue_ends
                .entry(fn_name.to_string())
                .or_insert(merged_offset);
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

    // Pass 3 -- imports. Walk every UNDEF reference; an entry
    // that doesn't match a defined symbol becomes an import.
    // The final-image writer turns each into a PLT trampoline.
    let mut imports: Vec<String> = Vec::new();
    let mut import_idx_for_name: BTreeMap<String, usize> = BTreeMap::new();
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
                                let bss_off = def.value as i64 + reloc.addend;
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
                        // through to the PLT pass.
                        if sym.binding == 1 {
                            return Err(link_err(&format!(
                                "undefined reference to `{}`",
                                sym.name,
                            )));
                        }
                        let idx = record_import(&sym.name, &mut imports, &mut import_idx_for_name);
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
                    // `.bss` sits past `.data` in the merged
                    // image; same parking rule as Data, with
                    // the offset taken against the bss base.
                    let bss_off = bss_bases[i] as i64 + sym.value as i64 + reloc.addend;
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

    // Pass 5 -- `.rela.data` entries. Each unit's data_relocs
    // points at an 8-byte slot in its own `.data` whose final
    // value is the runtime VA of another global. Resolve the
    // target to a merged-image data offset and queue it for
    // the writer to patch once `data_vaddr` is committed.
    let mut data_abs_relocs: Vec<DataAbsReloc> = Vec::new();
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
                    defined.get(&sym.name).map(|d| d.section).ok_or_else(|| {
                        link_err(&format!(
                            "undefined reference to `{}` (data initializer)",
                            sym.name,
                        ))
                    })?
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
    // Build the merged import->dylib map. Each unit's per-import
    // dylib_index is local to that unit's `dylibs` list; translate
    // through `merged_idx_for[unit_idx][per_unit_idx]` so the value
    // refers to the merged `dylibs` order. First entry per import
    // name wins -- a sibling unit redeclaring the same name picks
    // up the same dylib through cross-TU resolution anyway.
    let mut import_dylib_map: BTreeMap<String, u32> = BTreeMap::new();
    for obj in objs {
        let mut local_to_merged: Vec<u32> = Vec::with_capacity(obj.dylibs.len());
        for d in &obj.dylibs {
            let merged_idx = dylibs.iter().position(|m| m == d).unwrap_or(0) as u32;
            local_to_merged.push(merged_idx);
        }
        for (name, idx) in &obj.import_dylib_map {
            if import_dylib_map.contains_key(name) {
                continue;
            }
            let merged_idx = local_to_merged.get(*idx as usize).copied().unwrap_or(0);
            import_dylib_map.insert(name.clone(), merged_idx);
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
    // contributed by earlier units.
    let mut macho_tlv_descriptors: Vec<u64> = Vec::new();
    let mut macho_tlv_fixups: Vec<(usize, usize)> = Vec::new();
    for (i, obj) in objs.iter().enumerate() {
        let desc_base = macho_tlv_descriptors.len();
        macho_tlv_descriptors.extend_from_slice(&obj.macho_tlv_descriptors);
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
        bss_size,
        defined,
        imports,
        pending_imports,
        data_abs_relocs,
        machine,
        dylibs,
        import_dylib_map,
        exports,
        tls_index_fixups,
        macho_tlv_descriptors,
        macho_tlv_fixups,
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
        tls_data,
        tls_init_size,
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
    let mut parked_back: Vec<PendingImportReloc> = Vec::new();
    for reloc in &pending {
        if reloc.import_index == usize::MAX {
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
        let site = reloc.text_offset as usize;
        let tramp = tramp_for_import
            .get(&reloc.import_index)
            .copied()
            .expect("every reloc has a tramp entry from pass 1");
        let target = tramp as i64 + reloc.addend;
        patch_x86_64_pc32(&mut merged.text, site, target)?;
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
    let mut parked_back: Vec<PendingImportReloc> = Vec::new();
    for reloc in &pending {
        if reloc.import_index == usize::MAX {
            parked_back.push(reloc.clone());
            continue;
        }
        if reloc.rtype != R_AARCH64_CALL26 {
            return Err(err(&format!(
                "emit_aarch64_plt: pending reloc at text[{:#x}] has rtype {} \
                 (only R_AARCH64_CALL26 supported on aarch64)",
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
        let site = reloc.text_offset as usize;
        let tramp = tramp_for_import
            .get(&reloc.import_index)
            .copied()
            .expect("every reloc has a tramp entry from pass 1");
        // CALL26 wants the absolute target; `patch_aarch64_call26`
        // computes `(target - site) >> 2` internally.
        patch_aarch64_call26(&mut merged.text, site, tramp as i64 + reloc.addend)?;
    }

    merged.pending_imports = parked_back;
    Ok(trampolines)
}

// ---- Reloc application ----

fn apply_reloc(
    machine: NativeMachine,
    text: &mut [u8],
    patch_offset: usize,
    reloc: &NativeReloc,
    target: i64,
) -> Result<(), C5Error> {
    match (machine, reloc.rtype) {
        (NativeMachine::Aarch64, R_AARCH64_CALL26) => {
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
            dylibs: alloc::vec::Vec::new(),
            import_dylib_map: alloc::vec::Vec::new(),
            exports: alloc::vec::Vec::new(),
            tls_index_fixups: alloc::vec::Vec::new(),
            macho_tlv_descriptors: alloc::vec::Vec::new(),
            macho_tlv_fixups: alloc::vec::Vec::new(),
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
            dylibs: alloc::vec::Vec::new(),
            import_dylib_map: alloc::vec::Vec::new(),
            exports: alloc::vec::Vec::new(),
            tls_index_fixups: alloc::vec::Vec::new(),
            macho_tlv_descriptors: alloc::vec::Vec::new(),
            macho_tlv_fixups: alloc::vec::Vec::new(),
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
            dylibs: alloc::vec::Vec::new(),
            import_dylib_map: alloc::vec::Vec::new(),
            exports: alloc::vec::Vec::new(),
            tls_index_fixups: alloc::vec::Vec::new(),
            macho_tlv_descriptors: alloc::vec::Vec::new(),
            macho_tlv_fixups: alloc::vec::Vec::new(),
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
