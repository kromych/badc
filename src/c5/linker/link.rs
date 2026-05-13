//! Link a set of [`LinkUnit`]s and archives into a single
//! [`Program`].
//!
//! ## Pipeline
//!
//! 1. Seed the working set with the *root* objects -- every
//!    `.o` and every `.c` the user named on the command line.
//!    Source files reach this stage as already-compiled
//!    `LinkUnit`s; the CLI invokes the compiler ahead of the
//!    linker.
//! 2. Walk root units, recording every external name they
//!    define and every undefined external they reference.
//! 3. For each remaining undefined reference, search the
//!    archives in command-line order. If any archive's symbol
//!    index claims a member defines the name, parse the
//!    member, append it to the working set, and re-scan its
//!    own defined / undefined sets. Loop until convergence.
//! 4. Refuse the link if any external reference is still
//!    undefined.
//! 5. Concatenate every unit's `text`, `data`, and `tls_data`
//!    into the merged program, recording per-unit base
//!    offsets.
//! 6. Walk every word in `text` that holds a bc_pc or a
//!    data-segment offset (intra-unit references the compiler
//!    already resolved) and add the unit's base offset. Walk
//!    `data_relocs` / `code_relocs` and re-base both endpoints.
//! 7. Apply cross-TU relocations -- each [`Reloc`] points at a
//!    location whose final value depends on the resolved
//!    target symbol's merged-program position.
//! 8. Merge the per-unit metadata: dylib + binding table
//!    (remapping `Op::JsrExt` / `Op::TailExt` operands to the
//!    merged binding index), source-file table (remapping
//!    `source_file_indices`), struct registry, exports, the
//!    chosen entry symbol, etc.
//! 9. Construct the final [`Program`] and return it ready for
//!    `emit_native_with_options`.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use hashbrown::HashMap;

use crate::c5::CODE_BASE;
use crate::c5::error::C5Error;
use crate::c5::op::Op;
use crate::c5::preprocessor::{Binding, DylibSpec};
use crate::c5::program::{CodeReloc, DataReloc, ExportedFunction, Program};

use super::archive::{ArchiveMember, read_archive};
use super::object::read_object;
use super::reloc::{Reloc, RelocKind};
use super::symbol::SymbolKind;
use super::unit::LinkUnit;

/// Tunable knobs for [`link_units`]. Today this just toggles
/// the diagnostic shape; future per-link options (output kind
/// hints, archive search policy) will land here without
/// reshuffling the public signature.
#[derive(Debug, Clone, Default)]
pub struct LinkOptions {
    /// When set, the link refuses to pull in any archive
    /// member -- only the root units participate. Used by
    /// the CLI driver when the user asked to bundle a
    /// specific set of `.o` files without `-l`-driven
    /// archive search.
    pub no_archive_pullin: bool,
}

/// One archive-on-disk + its parsed members. The linker walks
/// `members` looking for any name that satisfies an unresolved
/// reference, and pulls in matching members on demand.
#[derive(Debug, Clone)]
pub struct LinkArchive {
    /// Filesystem path of the archive, for diagnostics.
    pub path: String,
    pub members: Vec<ArchiveMember>,
}

impl LinkArchive {
    /// Parse `bytes` and bundle them with `path`.
    pub fn parse(path: String, bytes: &[u8]) -> Result<Self, C5Error> {
        let members = read_archive(bytes)?;
        Ok(Self { path, members })
    }
}

/// Drive a multi-TU link from a set of root `LinkUnit`s plus a
/// list of archives. Returns the merged [`Program`].
pub fn link_units(
    mut units: Vec<LinkUnit>,
    archives: &[LinkArchive],
    options: LinkOptions,
) -> Result<Program, C5Error> {
    if units.is_empty() {
        return Err(err("no input objects to link"));
    }

    // Archive pull-in. Iterate until no new members are added.
    // Each pass collects every undefined external reference
    // across `units`, then walks archives in declared order
    // looking for a defining member; the first match wins.
    if !options.no_archive_pullin {
        loop {
            let (defined, undefined) = collect_defined_undefined(&units);
            let mut pulled = false;
            for needed in &undefined {
                if defined.contains_key(needed) {
                    continue;
                }
                for ar in archives {
                    if let Some(mem) = find_defining_member(&ar.members, needed)? {
                        units.push(read_object(&mem.bytes).map_err(|e| {
                            err(&format!(
                                "failed to parse archive `{}` member `{}`: {}",
                                ar.path, mem.name, e
                            ))
                        })?);
                        pulled = true;
                        break;
                    }
                }
            }
            if !pulled {
                break;
            }
        }
    }

    // Final unresolved-symbol check.
    let (defined, undefined) = collect_defined_undefined(&units);
    let mut undef_remaining: Vec<&String> = undefined
        .iter()
        .filter(|n| !defined.contains_key(*n))
        .collect();
    undef_remaining.sort();
    if !undef_remaining.is_empty() {
        let names: Vec<String> = undef_remaining.into_iter().take(20).cloned().collect();
        return Err(err(&format!(
            "undefined reference to: {}",
            names.join(", ")
        )));
    }

    merge(units, defined)
}

#[derive(Clone, Copy, Debug)]
struct GlobalSymbol {
    unit_idx: usize,
    sym_idx: usize,
}

fn collect_defined_undefined(
    units: &[LinkUnit],
) -> (
    HashMap<String, GlobalSymbol>,
    alloc::collections::BTreeSet<String>,
) {
    let mut defined: HashMap<String, GlobalSymbol> = HashMap::new();
    let mut undefined: alloc::collections::BTreeSet<String> = alloc::collections::BTreeSet::new();
    for (ui, unit) in units.iter().enumerate() {
        for (si, sym) in unit.symbols.iter().enumerate() {
            if matches!(sym.linkage, crate::c5::symbol::Linkage::Internal) {
                continue;
            }
            if matches!(sym.kind, SymbolKind::Undefined) {
                undefined.insert(sym.name.clone());
            } else {
                defined.insert(
                    sym.name.clone(),
                    GlobalSymbol {
                        unit_idx: ui,
                        sym_idx: si,
                    },
                );
            }
        }
    }
    (defined, undefined)
}

fn find_defining_member<'a>(
    members: &'a [ArchiveMember],
    name: &str,
) -> Result<Option<&'a ArchiveMember>, C5Error> {
    for m in members {
        let unit = read_object(&m.bytes).map_err(|e| {
            err(&format!(
                "failed to parse archive member `{}`: {}",
                m.name, e
            ))
        })?;
        for s in &unit.symbols {
            if s.name == name
                && !matches!(s.kind, SymbolKind::Undefined)
                && !matches!(s.linkage, crate::c5::symbol::Linkage::Internal)
            {
                return Ok(Some(m));
            }
        }
    }
    Ok(None)
}

fn merge(units: Vec<LinkUnit>, defined: HashMap<String, GlobalSymbol>) -> Result<Program, C5Error> {
    let n = units.len();
    let mut text_base: Vec<usize> = Vec::with_capacity(n);
    let mut data_base: Vec<usize> = Vec::with_capacity(n);
    let mut tls_base: Vec<usize> = Vec::with_capacity(n);

    // Reserve the leading 8-byte zero pad in `.data` (the
    // NULL-pointer guard rail the single-TU compile uses).
    let mut merged_text: Vec<i64> = Vec::new();
    let mut merged_data: Vec<u8> = alloc::vec![0u8; 8];
    let mut merged_tls: Vec<u8> = Vec::new();
    let mut merged_tls_init: usize = 0;

    // Pre-compute every per-unit base offset. Text bases are
    // the cumulative bytecode-word counts (one i64 word per
    // bytecode op), data bases are byte offsets into the
    // merged data segment (with 8-byte padding between units
    // so each unit's intra-segment offsets stay 8-aligned),
    // and tls init bases are byte offsets within the
    // initialised-TLS prefix region. We do this before any
    // text or relocation work because the text-walk pass and
    // the reloc-apply pass both consult these to remap unit-
    // local addresses, and computing them eagerly avoids the
    // bug-magnet of "base = current merged length" reading
    // out-of-date values inside a loop that's also growing
    // the destination.
    let mut text_cum = 0usize;
    let mut data_cum = merged_data.len();
    let mut tls_init_cum = 0usize;
    for unit in &units {
        text_base.push(text_cum);
        text_cum += unit.text.len();
        // Pad data to 8 alignment between units so each unit's
        // own intra-segment offsets stay valid after the base
        // shift.
        while !data_cum.is_multiple_of(8) {
            data_cum += 1;
        }
        data_base.push(data_cum);
        data_cum += unit.data.len();
        tls_base.push(tls_init_cum);
        tls_init_cum += unit.tls_init_size.min(unit.tls_data.len());
    }

    // Now lay out merged_data + merged_tls (init prefix) so
    // their actual byte content matches the pre-computed
    // offsets. The text pass below populates merged_text into
    // the matching text_base slots.
    for (i, unit) in units.iter().enumerate() {
        while merged_data.len() < data_base[i] {
            merged_data.push(0);
        }
        merged_data.extend_from_slice(&unit.data);
        let unit_init = unit.tls_init_size.min(unit.tls_data.len());
        merged_tls.extend_from_slice(&unit.tls_data[..unit_init]);
        merged_tls_init += unit_init;
    }

    // Second pass for tls_data: append every unit's bss tail
    // *after* every unit's init prefix. The cumulative bss
    // bytes live at offsets `[merged_tls_init, merged_tls.len())`
    // in the merged segment. Per-unit bss starts at
    // `tls_base[i] + tls_init_size[i]`, but since we shifted the
    // init prefix into a contiguous block at the start of
    // `merged_tls`, the per-unit base needs adjustment.
    //
    // For simplicity we restart the build of merged_tls + the
    // tls_base table here: walk units, allocate each one's
    // init prefix contiguously, then go back and allocate each
    // one's bss tail contiguously. Each unit's "base" is the
    // init-prefix start; relocations against TLS targets pick
    // the matching segment by their `tls_init_size` flag.
    //
    // First pass laid down init prefixes contiguously already
    // (merged_tls.len() == sum of unit_init). Now append
    // per-unit bss tails, recording per-unit bss base.
    let mut tls_bss_base: Vec<usize> = Vec::with_capacity(n);
    for unit in &units {
        let unit_init = unit.tls_init_size.min(unit.tls_data.len());
        let bss_len = unit.tls_data.len() - unit_init;
        tls_bss_base.push(merged_tls.len());
        merged_tls.extend(core::iter::repeat_n(0u8, bss_len));
    }

    // Now emit text per unit with bytecode-PC remapping for
    // intra-unit references that carry unit-local PCs:
    //   * Op::Jsr <bc_pc>: add text_base[i]
    //   * Op::Imm <CODE_BASE + bc_pc> (in code_imm_positions):
    //       add text_base[i] to the operand
    //   * Op::Imm <data_offset> (in data_imm_positions): add
    //       data_base[i]
    //
    // Then walk symbolic relocations in a second pass.
    //
    // To find each operand's PC, walk the bytecode using
    // Op::operand_count(). The compiler already records
    // code_imm_positions and data_imm_positions so the
    // function-pointer / data Imm sites can be distinguished
    // from ordinary integer-constant Imms.

    let mut merged_code_imm_positions: Vec<usize> = Vec::new();
    let mut merged_data_imm_positions: Vec<usize> = Vec::new();
    let mut merged_call_fp_arg_masks: Vec<(usize, u32)> = Vec::new();
    let mut merged_source_lines: Vec<u32> = Vec::new();
    let mut merged_source_functions: Vec<String> = Vec::new();
    let mut merged_source_file_indices: Vec<u16> = Vec::new();
    let mut merged_source_files: Vec<String> = Vec::new();
    let mut source_file_offset_per_unit: Vec<u16> = Vec::with_capacity(n);
    let mut merged_variables: Vec<crate::c5::program::VariableInfo> = Vec::new();
    let mut merged_data_relocs: Vec<DataReloc> = Vec::new();
    let mut merged_code_relocs: Vec<CodeReloc> = Vec::new();
    let mut merged_exports: Vec<ExportedFunction> = Vec::new();
    let mut merged_warnings: Vec<String> = Vec::new();
    let mut entry_name: Option<String> = None;
    let mut subsystem: Option<crate::c5::preprocessor::Subsystem> = None;
    let mut dllmain_pc: Option<usize> = None;
    let mut source_path: String = String::new();

    // Merged dylib + binding table, with a per-unit binding-
    // index remap so each unit's Op::JsrExt operands can be
    // rewritten as we copy text.
    let mut merged_dylibs: Vec<DylibSpec> = Vec::new();
    let mut binding_remap_per_unit: Vec<Vec<i64>> = Vec::with_capacity(n);

    for unit in &units {
        // Source file table: dedupe per-unit names into one
        // merged table.
        let file_offset = merged_source_files.len() as u16;
        source_file_offset_per_unit.push(file_offset);
        merged_source_files.extend(unit.source_files.iter().cloned());

        // Dylibs + bindings.
        let mut unit_binding_remap: Vec<i64> = Vec::new();
        for spec in &unit.dylibs {
            let merged_dylib_idx = match merged_dylibs.iter().position(|d| d.name == spec.name) {
                Some(i) => i,
                None => {
                    merged_dylibs.push(DylibSpec {
                        name: spec.name.clone(),
                        path: spec.path.clone(),
                        bindings: Vec::new(),
                    });
                    merged_dylibs.len() - 1
                }
            };
            for b in &spec.bindings {
                let new_flat_idx = flat_binding_index(&mut merged_dylibs, merged_dylib_idx, b);
                unit_binding_remap.push(new_flat_idx as i64);
            }
        }
        binding_remap_per_unit.push(unit_binding_remap);
    }

    for (ui, unit) in units.iter().enumerate() {
        // Walk this unit's bytecode, emit into merged_text
        // with PC remapping.
        let text_off = text_base[ui];
        let data_off = data_base[ui];
        let tls_off = tls_base[ui]; // init region
        let tls_bss_off = tls_bss_base[ui];
        let tls_init_local = unit.tls_init_size.min(unit.tls_data.len());

        // First record per-PC bookkeeping (source_lines /
        // source_functions / source_file_indices /
        // call_fp_arg_masks) -- these are PC-indexed parallel
        // arrays. Pad to text_off so indices align after the
        // append.
        // source_lines + source_functions + source_file_indices
        // must end up parallel to merged_text. We extend by
        // unit.text.len() so the indices match the bytecode
        // length copy below.
        merged_source_lines.extend(unit.source_lines.iter().copied());
        merged_source_functions.extend(unit.source_functions.iter().cloned());
        let fo = source_file_offset_per_unit[ui];
        for &idx in &unit.source_file_indices {
            // Cap to avoid wrap-around if a unit's source_file_indices
            // somehow exceeds its source_files (would be a bug).
            let new_idx = (idx as u32) + (fo as u32);
            merged_source_file_indices.push(new_idx.min(u16::MAX as u32) as u16);
        }
        // Pad PC-indexed columns up to text_off + unit.text.len()
        // if any of them happens to be shorter (units produced
        // by paths that didn't fill them).
        let want = merged_text.len() + unit.text.len();
        if merged_source_lines.len() < want {
            merged_source_lines.resize(want, 0);
        }
        if merged_source_functions.len() < want {
            merged_source_functions.resize(want, String::new());
        }
        if merged_source_file_indices.len() < want {
            merged_source_file_indices.resize(want, 0);
        }
        for &(pc, mask) in &unit.call_fp_arg_masks {
            merged_call_fp_arg_masks.push((pc + text_off, mask));
        }
        // Variables: shift function_bc_pc.
        for v in &unit.variables {
            merged_variables.push(crate::c5::program::VariableInfo {
                function_bc_pc: v.function_bc_pc + text_off as u64,
                name: v.name.clone(),
                type_tag: v.type_tag,
                fp_slot: v.fp_slot,
                is_parameter: v.is_parameter,
            });
        }
        for w in &unit.warnings {
            merged_warnings.push(w.clone());
        }

        // Walk text, remapping operand words.
        let code_imm_set: alloc::collections::BTreeSet<usize> =
            unit.code_imm_positions.iter().copied().collect();
        let data_imm_set: alloc::collections::BTreeSet<usize> =
            unit.data_imm_positions.iter().copied().collect();
        let mut pc = 0usize;
        let binding_remap = &binding_remap_per_unit[ui];
        while pc < unit.text.len() {
            let raw = unit.text[pc];
            merged_text.push(raw);
            let op = Op::from_i64(raw);
            match op {
                Some(Op::Imm) => {
                    let operand_pc = pc + 1;
                    if operand_pc >= unit.text.len() {
                        return Err(err("dangling Imm operand at end of text"));
                    }
                    let operand = unit.text[operand_pc];
                    let new = if code_imm_set.contains(&operand_pc) {
                        // CODE_BASE + bc_pc -> CODE_BASE + (bc_pc + text_off)
                        let bc_pc = operand - CODE_BASE as i64;
                        CODE_BASE as i64 + bc_pc + text_off as i64
                    } else if data_imm_set.contains(&operand_pc) {
                        operand + data_off as i64
                    } else {
                        operand
                    };
                    merged_text.push(new);
                    if code_imm_set.contains(&operand_pc) {
                        merged_code_imm_positions.push(merged_text.len() - 1);
                    }
                    if data_imm_set.contains(&operand_pc) {
                        merged_data_imm_positions.push(merged_text.len() - 1);
                    }
                    pc += 2;
                }
                Some(Op::Jsr) | Some(Op::Jmp) | Some(Op::Bz) | Some(Op::Bnz) => {
                    // Each of these carries a single intra-unit
                    // bytecode-PC operand. Internally-resolved
                    // already at parse time, so the operand
                    // holds the unit-local PC; shift by the
                    // unit's text offset to get the merged-
                    // program PC.
                    let operand_pc = pc + 1;
                    if operand_pc >= unit.text.len() {
                        return Err(err("dangling branch operand"));
                    }
                    let bc_pc = unit.text[operand_pc];
                    merged_text.push(bc_pc + text_off as i64);
                    pc += 2;
                }
                Some(Op::JsrExt) | Some(Op::TailExt) => {
                    let operand_pc = pc + 1;
                    if operand_pc >= unit.text.len() {
                        return Err(err("dangling JsrExt operand"));
                    }
                    let local_idx = unit.text[operand_pc];
                    let new_idx = binding_remap
                        .get(local_idx as usize)
                        .copied()
                        .unwrap_or(local_idx);
                    merged_text.push(new_idx);
                    pc += 2;
                }
                Some(Op::TlsLea) => {
                    let operand_pc = pc + 1;
                    if operand_pc >= unit.text.len() {
                        return Err(err("dangling TlsLea operand"));
                    }
                    // TLS offsets: if the operand points into the
                    // init region (< tls_init_local), it shifts
                    // by `tls_off`; otherwise by
                    // `tls_bss_off - tls_init_local`.
                    let raw = unit.text[operand_pc] as usize;
                    let new = if raw < tls_init_local {
                        (tls_off + raw) as i64
                    } else {
                        (tls_bss_off + (raw - tls_init_local)) as i64
                    };
                    merged_text.push(new);
                    pc += 2;
                }
                Some(other) => {
                    // Copy any operand words verbatim; remaining
                    // operand-bearing ops don't carry PC / data /
                    // binding references.
                    for k in 0..other.operand_count() {
                        let operand_pc = pc + 1 + k;
                        if operand_pc >= unit.text.len() {
                            return Err(err("dangling operand at end of text"));
                        }
                        merged_text.push(unit.text[operand_pc]);
                    }
                    pc += other.word_size();
                }
                None => {
                    // Operand word leaking into the op-decode
                    // stream means a previous op was miscounted.
                    return Err(err(&format!("non-op word at bc_pc {pc} in unit {}", ui)));
                }
            }
        }

        // Apply intra-unit data_relocs (shift both endpoints).
        for r in &unit.data_relocs {
            merged_data_relocs.push(DataReloc {
                data_offset: r.data_offset + data_off as u64,
                target_offset: r.target_offset + data_off as u64,
            });
            // Update the embedded little-endian bytes in
            // merged_data too -- the codegen reads
            // target_offset from the reloc table, but the VM
            // and any tooling that walks raw bytes expects the
            // slot to hold the value already.
            let slot = (r.data_offset + data_off as u64) as usize;
            let target = (r.target_offset + data_off as u64).to_le_bytes();
            if slot + 8 <= merged_data.len() {
                merged_data[slot..slot + 8].copy_from_slice(&target);
            }
        }
        for r in &unit.code_relocs {
            merged_code_relocs.push(CodeReloc {
                data_offset: r.data_offset + data_off as u64,
                target_bc_pc: r.target_bc_pc + text_off as u64,
            });
        }

        // Exports: rebase bytecode_pc onto the merged text.
        for e in &unit.exports {
            merged_exports.push(ExportedFunction {
                name: e.name.clone(),
                bytecode_pc: e.bytecode_pc + text_off,
            });
        }

        // Prefer the first source_path / entry_name we see.
        if source_path.is_empty() && !unit.source_path.is_empty() {
            source_path = unit.source_path.clone();
        }
        if entry_name.is_none()
            && let Some(e) = &unit.entry_name
        {
            entry_name = Some(e.clone());
        }
        if subsystem.is_none() {
            subsystem = unit.subsystem;
        }
        if dllmain_pc.is_none()
            && let Some(pc) = unit.dllmain_pc
        {
            dllmain_pc = Some(pc + text_off);
        }
    }

    // Cross-TU symbolic relocations.
    for (ui, unit) in units.iter().enumerate() {
        let text_off = text_base[ui];
        let data_off = data_base[ui];
        for r in &unit.relocs {
            apply_reloc(
                &mut merged_text,
                &mut merged_data,
                &mut merged_data_relocs,
                &mut merged_code_relocs,
                ui,
                text_off,
                data_off,
                r,
                unit,
                &units,
                &defined,
                &text_base,
                &data_base,
                &tls_base,
                &tls_bss_base,
            )?;
        }
    }

    // Resolve the entry point. If any unit set entry_name (the
    // first one wins above), find a defined function symbol of
    // that name in the merged symbol table; else fall back to
    // searching `main` / `wmain` / `WinMain` / `wWinMain` per
    // the historical single-TU rules.
    let (entry_pc, resolved_entry_name) =
        resolve_entry_pc(&entry_name, &defined, &units, &text_base)?;
    // Override the propagated `entry_name` (which only carries
    // `#pragma entrypoint(...)` overrides) with whatever the
    // resolver actually picked. Without this, a source whose
    // entry function is `wmain` / `WinMain` / `wWinMain`
    // (resolved through the fallback list) leaves `entry_name`
    // at `None`, and the PE writer falls back to the
    // narrow-console `__getmainargs` import -- argv comes
    // through as `char**` even though the user's signature
    // declared `wchar_t**`.
    let entry_name = resolved_entry_name.or(entry_name);

    // Struct registry: union all units' struct lists. This is
    // a soft merge -- two units may define the same struct via
    // a shared header; we keep one copy by name. The type tag
    // encoding embeds a struct id per unit, but since c5 bakes
    // member offsets into the bytecode at the parser site,
    // cross-TU type-tag identity isn't required for runtime
    // correctness. The merged list is consumed only by the
    // DWARF emitter.
    let mut merged_structs: Vec<crate::c5::compiler::StructDef> = Vec::new();
    for unit in &units {
        for s in &unit.structs {
            if !merged_structs
                .iter()
                .any(|m| m.name == s.name && !s.name.is_empty())
            {
                merged_structs.push(s.clone());
            }
        }
    }

    Ok(Program {
        text: merged_text,
        data: merged_data,
        entry_pc,
        warnings: merged_warnings,
        data_imm_positions: merged_data_imm_positions,
        code_imm_positions: merged_code_imm_positions,
        call_fp_arg_masks: merged_call_fp_arg_masks,
        tls_data: merged_tls,
        tls_init_size: merged_tls_init,
        exports: merged_exports,
        data_relocs: merged_data_relocs,
        code_relocs: merged_code_relocs,
        dylibs: merged_dylibs,
        dllmain_pc,
        source_lines: merged_source_lines,
        source_functions: merged_source_functions,
        source_files: merged_source_files,
        source_file_indices: merged_source_file_indices,
        source_path,
        variables: merged_variables,
        structs: merged_structs,
        entry_name,
        subsystem,
    })
}

#[allow(clippy::too_many_arguments)]
fn apply_reloc(
    merged_text: &mut [i64],
    merged_data: &mut [u8],
    merged_data_relocs: &mut Vec<DataReloc>,
    merged_code_relocs: &mut Vec<CodeReloc>,
    ui: usize,
    text_off: usize,
    data_off: usize,
    r: &Reloc,
    unit: &LinkUnit,
    units: &[LinkUnit],
    defined: &HashMap<String, GlobalSymbol>,
    text_base: &[usize],
    data_base: &[usize],
    tls_base: &[usize],
    tls_bss_base: &[usize],
) -> Result<(), C5Error> {
    let target_sym = unit.symbols.get(r.sym_index as usize).ok_or_else(|| {
        err(&format!(
            "reloc references missing symbol index {}",
            r.sym_index
        ))
    })?;

    // Resolve the symbol's owning unit + section base. Internal
    // symbols stay in `ui`; external symbols resolve through
    // the merged `defined` map.
    let (target_unit_idx, target_sym_def) = match target_sym.linkage {
        crate::c5::symbol::Linkage::Internal => {
            // Internal symbols never appear in `defined`; the
            // local copy is the one to use.
            (ui, target_sym.clone())
        }
        _ => {
            let g = defined.get(&target_sym.name).ok_or_else(|| {
                err(&format!(
                    "internal: relocation against `{}` left undefined",
                    target_sym.name
                ))
            })?;
            (g.unit_idx, units[g.unit_idx].symbols[g.sym_idx].clone())
        }
    };

    let target_value: i64 = match target_sym_def.kind {
        SymbolKind::Function => (text_base[target_unit_idx] as i64) + target_sym_def.value as i64,
        SymbolKind::Data => (data_base[target_unit_idx] as i64) + target_sym_def.value as i64,
        SymbolKind::TlsData => {
            // Decide between init (.tdata) and bss (.tbss) by
            // comparing against the owning unit's tls_init_size.
            let owner = &units[target_unit_idx];
            let init_local = owner.tls_init_size.min(owner.tls_data.len());
            if (target_sym_def.value as usize) < init_local {
                (tls_base[target_unit_idx] as i64) + target_sym_def.value as i64
            } else {
                (tls_bss_base[target_unit_idx] as i64)
                    + (target_sym_def.value as i64 - init_local as i64)
            }
        }
        SymbolKind::Undefined => {
            return Err(err(&format!(
                "internal: relocation against undefined symbol `{}` survived to merge",
                target_sym_def.name
            )));
        }
    };

    let resolved = target_value + r.addend;
    match r.kind {
        RelocKind::JsrPc => {
            let loc = (text_off as i64) + r.location as i64;
            let slot = loc as usize;
            if slot >= merged_text.len() {
                return Err(err("JsrPc reloc location out of merged text"));
            }
            merged_text[slot] = resolved;
        }
        RelocKind::ImmCodeAddr => {
            let loc = (text_off as i64) + r.location as i64;
            let slot = loc as usize;
            if slot >= merged_text.len() {
                return Err(err("ImmCodeAddr reloc location out of merged text"));
            }
            merged_text[slot] = CODE_BASE as i64 + resolved;
        }
        RelocKind::ImmDataAddr => {
            let loc = (text_off as i64) + r.location as i64;
            let slot = loc as usize;
            if slot >= merged_text.len() {
                return Err(err("ImmDataAddr reloc location out of merged text"));
            }
            merged_text[slot] = resolved;
        }
        RelocKind::DataDataAbs64 => {
            let slot = data_off + r.location as usize;
            if slot + 8 > merged_data.len() {
                return Err(err("DataDataAbs64 reloc location out of merged data"));
            }
            merged_data[slot..slot + 8].copy_from_slice(&(resolved as u64).to_le_bytes());
            merged_data_relocs.push(DataReloc {
                data_offset: slot as u64,
                target_offset: resolved as u64,
            });
        }
        RelocKind::DataCodeAbs64 => {
            let slot = data_off + r.location as usize;
            if slot + 8 > merged_data.len() {
                return Err(err("DataCodeAbs64 reloc location out of merged data"));
            }
            merged_code_relocs.push(CodeReloc {
                data_offset: slot as u64,
                target_bc_pc: resolved as u64,
            });
        }
    }
    Ok(())
}

fn flat_binding_index(
    merged_dylibs: &mut [DylibSpec],
    dylib_idx: usize,
    binding: &Binding,
) -> usize {
    // Append unconditionally inside the chosen dylib. Some
    // headers re-declare the same `local_name`/`real_symbol`
    // pair with slightly different prototypes (e.g.
    // `msvcrt::printf` appears in both `<stdio.h>` and
    // `msvc_compat.h` with different `is_variadic` /
    // `return_type_tag` shadow fields). Dedup-by-name here
    // would pick the first occurrence's metadata for both
    // call sites, which the bytecode caller wasn't typed
    // against. Keeping every binding preserves the parser's
    // per-binding flat index across the link; the resulting
    // IAT carries a duplicate import name per duplicate, which
    // the per-format writer treats as harmless overhead.
    let mut flat: usize = 0;
    for (i, d) in merged_dylibs.iter().enumerate() {
        if i == dylib_idx {
            break;
        }
        flat += d.bindings.len();
    }
    let dy = &mut merged_dylibs[dylib_idx];
    let pos = dy.bindings.len();
    dy.bindings.push(binding.clone());
    flat + pos
}

/// Resolve the program's entry function. Returns the entry's
/// bytecode PC plus the resolved symbol name (e.g. `wmain` /
/// `WinMain` / `main`). The PE writer reads
/// `Program::entry_name` to pick between `__getmainargs` and
/// `__wgetmainargs` -- a single-TU `Compiler::compile` records
/// the same name on its `Program`, and the link path has to
/// keep that field accurate so the wide-console entry path
/// stays in scope.
fn resolve_entry_pc(
    entry_name: &Option<String>,
    defined: &HashMap<String, GlobalSymbol>,
    units: &[LinkUnit],
    text_base: &[usize],
) -> Result<(usize, Option<String>), C5Error> {
    let preferred: Vec<String> = match entry_name {
        Some(n) => alloc::vec![n.clone()],
        None => alloc::vec![
            "main".to_string(),
            "wmain".to_string(),
            "WinMain".to_string(),
            "wWinMain".to_string()
        ],
    };
    for n in &preferred {
        if let Some(g) = defined.get(n) {
            let sym = &units[g.unit_idx].symbols[g.sym_idx];
            if matches!(sym.kind, SymbolKind::Function) {
                return Ok((text_base[g.unit_idx] + sym.value as usize, Some(n.clone())));
            }
        }
    }
    // Shared-library output may legitimately have no main; the
    // caller decides whether to require one. For now we report
    // the same diagnostic the single-TU path uses.
    Err(err(&format!(
        "{}() not defined",
        preferred.first().map(|s| s.as_str()).unwrap_or("main")
    )))
}

fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(msg))
}
