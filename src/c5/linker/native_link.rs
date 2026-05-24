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
    /// Architecture of the merged image. Every unit must agree;
    /// the link errors out if they don't.
    pub machine: NativeMachine,
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
                return Err(err(&format!(
                    "link_native_objects: symbol `{}` is defined in multiple objects (first at \
                     offset 0x{:x}, also at 0x{:x})",
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
                    let target =
                        (data_bases[i] as i64 + sym.value as i64 + reloc.addend) - text_base as i64;
                    // The reloc encodes a section-relative
                    // offset in the addend; the writer expects
                    // the resolved value to point at the
                    // section's runtime base + the addend. For
                    // a position-independent merge the target
                    // address has to wait for the final-image
                    // writer (which knows the runtime vmaddr
                    // gap between `.text` and `.data`). Park
                    // these as pending data refs for that pass.
                    let _ = target;
                    park_data_ref(machine, &mut pending_imports, patch_offset, reloc);
                }
                NativeSymSection::Undef => {
                    if let Some(def) = defined.get(&sym.name) {
                        // Cross-unit reference to a globally-
                        // defined symbol. Resolve in place.
                        let base = match def.section {
                            NativeSymSection::Text => 0i64,
                            NativeSymSection::Data => 0i64,
                            _ => 0i64,
                        };
                        let target = def.value as i64 + reloc.addend + base;
                        apply_reloc(machine, &mut text, patch_offset, reloc, target)?;
                    } else if !sym.name.is_empty() {
                        // Library import -- park for the
                        // PLT pass.
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
                    let target =
                        (bss_bases[i] as i64 + sym.value as i64 + reloc.addend) - text_base as i64;
                    let _ = target;
                    park_data_ref(machine, &mut pending_imports, patch_offset, reloc);
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

    Ok(MergedNative {
        text,
        data,
        bss_size,
        defined,
        imports,
        pending_imports,
        machine,
    })
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
    let disp = target;
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
) {
    // The .data / .bss reference resolves once the final-image
    // writer knows the runtime page-relative distance between
    // `.text` and `.data`. We park the reloc in the
    // `pending_imports` queue with a sentinel import index of
    // `usize::MAX` so the writer can pick it up the same way it
    // handles PLT imports -- a refactor pass will rename the
    // queue once both directions land cleanly.
    pending.push(PendingImportReloc {
        text_offset: patch_offset as u64,
        import_index: usize::MAX,
        rtype: reloc.rtype,
        addend: reloc.addend,
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
            err.to_string().contains("defined in multiple objects"),
            "unexpected error: {err}",
        );
    }

    fn compile_native(src: &str, target: Target, opts: NativeOptions) -> NativeObject {
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse")
    }
}
