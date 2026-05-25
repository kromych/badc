//! Native ELF link step -- consumes one or more
//! [`NativeObject`]s (produced by `codegen/elf_reloc.rs`,
//! parsed back by `native_object::parse_native_elf`) and
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

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::error::C5Error;

use super::native_object::{NativeMachine, NativeObject, NativeReloc, NativeSymSection};

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

/// Call-site reloc the linker couldn't resolve from the merged
/// units alone -- the target is an external import (libc
/// `printf` / `malloc` / ...). The final-image writer
/// materialises one PLT trampoline per import name, then
/// patches each placeholder at `text_offset` with the rel32 /
/// imm26 reaching the trampoline.
#[derive(Debug, Clone)]
pub struct PendingImportReloc {
    /// Byte offset within `MergedNative::text` of the
    /// placeholder.
    pub text_offset: u64,
    /// Index into `MergedNative::imports`.
    pub import_index: usize,
    /// ELF reloc kind (`R_AARCH64_CALL26` etc.).
    pub rtype: u32,
    /// The reloc's signed addend; mostly `-4` for x86_64
    /// `PLT32` and `0` for aarch64 `CALL26`.
    pub addend: i64,
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
                    apply_reloc(machine, &mut text, patch_offset, reloc, target)?;
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
                                apply_reloc(machine, &mut text, patch_offset, reloc, target)?;
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
                            NativeSymSection::Undef | NativeSymSection::Abs => {
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
                NativeSymSection::Undef => {
                    defined.get(&sym.name).map(|d| d.section).ok_or_else(|| {
                        link_err(&format!(
                            "undefined reference to `{}` (data initializer)",
                            sym.name,
                        ))
                    })?
                }
                other => other,
            };
            let resolved_value = match sym.section {
                NativeSymSection::Undef => defined.get(&sym.name).map(|d| d.value as i64).unwrap(),
                NativeSymSection::Data => data_bases[i] as i64 + sym.value as i64,
                NativeSymSection::Bss => bss_bases[i] as i64 + sym.value as i64,
                NativeSymSection::Text => text_bases[i] as i64 + sym.value as i64,
                NativeSymSection::Abs => {
                    return Err(err(&format!(
                        "link_native_objects: .rela.data points at ABS symbol `{}`",
                        sym.name,
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

    Ok(MergedNative {
        text,
        data,
        bss_size,
        defined,
        imports,
        pending_imports,
        data_abs_relocs,
        machine,
    })
}

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
/// Limited to `NativeMachine::X86_64` for now; aarch64 needs the
/// matching `adrp + ldr + br` shape and lands separately.
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

fn park_data_ref(
    _machine: NativeMachine,
    pending: &mut Vec<PendingImportReloc>,
    patch_offset: usize,
    reloc: &NativeReloc,
    target_offset: i64,
) {
    // The .data / .bss reference resolves once the final-image
    // writer knows the runtime page-relative distance between
    // `.text` and `.data`. Park the reloc in the
    // `pending_imports` queue with a sentinel import index of
    // `usize::MAX` so the writer can pick it up the same way it
    // handles PLT imports; the resolved data / bss byte offset
    // travels in the addend slot.
    pending.push(PendingImportReloc {
        text_offset: patch_offset as u64,
        import_index: usize::MAX,
        rtype: reloc.rtype,
        addend: target_offset,
    });
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
    use crate::c5::linker::native_object::parse_native_elf;
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
