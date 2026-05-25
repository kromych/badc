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

use hashbrown::{HashMap, HashSet};

use crate::c5::CODE_BASE;
use crate::c5::error::C5Error;
use crate::c5::op::Op;
use crate::c5::preprocessor::DylibSpec;
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
        return Err(link_err("no input objects to link"));
    }

    // Archive pull-in. Iterate until no new members are added.
    // Each pass collects every undefined external reference
    // across `units`, then walks archives in declared order
    // looking for a defining member; the first match wins.
    //
    // Within one pass, after pulling member `M` to satisfy
    // `needed_a`, the same member typically also defines
    // `needed_b` from the same iteration's undefined list. We
    // mark that name as just-satisfied so the next `needed_b`
    // iteration doesn't pull `M` a second time -- otherwise the
    // produced link unit would carry duplicate definitions and
    // trip the multiple-definition check below.
    if !options.no_archive_pullin {
        loop {
            let (defined, undefined) = collect_defined_undefined(&units);
            let mut pulled = false;
            let mut just_pulled_defs: HashSet<String> = HashSet::new();
            for needed in &undefined {
                if defined.contains_key(needed) || just_pulled_defs.contains(needed) {
                    continue;
                }
                for ar in archives {
                    if let Some(mem) = find_defining_member(&ar.members, needed)? {
                        let pulled_unit = read_object(&mem.bytes).map_err(|e| {
                            link_err(&format!(
                                "failed to parse archive `{}` member `{}`: {}",
                                ar.path, mem.name, e
                            ))
                        })?;
                        for sym in &pulled_unit.symbols {
                            if matches!(sym.linkage, crate::c5::symbol::Linkage::External)
                                && !matches!(sym.kind, SymbolKind::Undefined)
                            {
                                just_pulled_defs.insert(sym.name.clone());
                            }
                        }
                        units.push(pulled_unit);
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
        return Err(link_err(&format!(
            "undefined reference to: {}",
            names.join(", ")
        )));
    }

    // Duplicate-definition check. Two TUs that each emit a body
    // for the same external function name produce
    // `error: multiple definition of `foo``. We scope this to
    // `SymbolKind::Function` for now: data symbols can be
    // C99-6.9.2 tentative definitions (`int x;` in two TUs is
    // legal and merges to one zero-initialised storage), which
    // c5's `LinkSymbol` doesn't yet distinguish from a defining
    // definition. Duplicate function bodies are always a hard
    // error in C99, so the narrow check catches the common
    // user mistake without false-firing on tentative data.
    let mut function_defs: HashMap<String, usize> = HashMap::new();
    let mut dup_funcs: Vec<String> = Vec::new();
    for unit in &units {
        for sym in &unit.symbols {
            if !matches!(sym.linkage, crate::c5::symbol::Linkage::External) {
                continue;
            }
            if !matches!(sym.kind, SymbolKind::Function) {
                continue;
            }
            let count = function_defs.entry(sym.name.clone()).or_insert(0);
            *count += 1;
            if *count == 2 {
                dup_funcs.push(sym.name.clone());
            }
        }
    }
    if !dup_funcs.is_empty() {
        dup_funcs.sort();
        let names: Vec<String> = dup_funcs.into_iter().take(20).collect();
        return Err(link_err(&format!(
            "multiple definition of `{}`",
            names.join("`, `")
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
            link_err(&format!(
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
    let mut merged_variadic_functions: alloc::collections::BTreeSet<usize> =
        alloc::collections::BTreeSet::new();
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
    //
    // Two-pass to avoid a flat-index shift hazard. The
    // parser-emitted operand encodes binding position as
    // `sum(prior dylibs' sizes) + within-dylib position`. If
    // we built `merged_dylibs` and computed each unit's remap
    // in the same loop, a later unit appending to (say) libc
    // would grow libc and shift libm's start -- silently
    // moving the merged-program index that was supposed to
    // name `sin`. The single-unit prelude path doesn't notice
    // because nothing appends to libc after it. The fix:
    //
    //   * pass 1: dedupe dylibs by name into `merged_dylibs`
    //     and concatenate every unit's bindings to the right
    //     dylib. Record only the (dylib_idx, position) per
    //     binding so the remap can be computed once sizes are
    //     final.
    //   * pass 2: cumulative dylib starts are known; each
    //     binding's merged flat index is
    //     `dylib_starts[dylib_idx] + position_within_dylib`.
    let mut merged_dylibs: Vec<DylibSpec> = Vec::new();
    let mut binding_remap_per_unit: Vec<Vec<i64>> = Vec::with_capacity(n);
    // Per-unit, per-binding: (merged_dylib_idx, within_dylib_pos).
    // Same shape as the parser's flat binding indices, split into
    // the two pieces required post-merge to compute the final flat
    // offset.
    let mut binding_positions_per_unit: Vec<Vec<(usize, usize)>> = Vec::with_capacity(n);

    for unit in &units {
        // Source file table: dedupe per-unit names into one
        // merged table.
        let file_offset = merged_source_files.len() as u16;
        source_file_offset_per_unit.push(file_offset);
        merged_source_files.extend(unit.source_files.iter().cloned());

        let mut positions: Vec<(usize, usize)> = Vec::new();
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
                let pos = merged_dylibs[merged_dylib_idx].bindings.len();
                merged_dylibs[merged_dylib_idx].bindings.push(b.clone());
                positions.push((merged_dylib_idx, pos));
            }
        }
        binding_positions_per_unit.push(positions);
    }

    // Pass 2: cumulative dylib starts are now stable -- compute
    // each unit's flat-index remap.
    let mut dylib_starts: Vec<usize> = Vec::with_capacity(merged_dylibs.len());
    let mut cum = 0;
    for d in &merged_dylibs {
        dylib_starts.push(cum);
        cum += d.bindings.len();
    }
    for positions in &binding_positions_per_unit {
        let mut remap: Vec<i64> = Vec::with_capacity(positions.len());
        for &(mdi, pos) in positions {
            remap.push((dylib_starts[mdi] + pos) as i64);
        }
        binding_remap_per_unit.push(remap);
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
        for &pc in &unit.variadic_functions {
            merged_variadic_functions.insert(pc + text_off);
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
    // Per-unit struct-id remap: `struct_remap_per_unit[i][unit_local_id]`
    // is the index this struct lands at in `merged_structs`. The
    // walker reads `struct_size(ty)` against `merged_structs` for
    // every struct assignment / return / by-value param size, so
    // the AST snapshots that ride this `Program` need their `ty`
    // tags rebased. The bytecode tier baked sizes at parse time
    // (`Op::Mcpy <size>` etc.) and never re-consults the table,
    // which is why this hadn't surfaced before the walker landed.
    let mut struct_remap_per_unit: Vec<Vec<usize>> = Vec::with_capacity(units.len());
    for unit in &units {
        let mut remap = Vec::with_capacity(unit.structs.len());
        for s in &unit.structs {
            let merged_idx = if !s.name.is_empty()
                && let Some(existing) = merged_structs.iter().position(|m| m.name == s.name)
            {
                existing
            } else {
                merged_structs.push(s.clone());
                merged_structs.len() - 1
            };
            remap.push(merged_idx);
        }
        struct_remap_per_unit.push(remap);
    }

    Ok(Program {
        text: merged_text,
        data: merged_data,
        entry_pc,
        warnings: merged_warnings,
        data_imm_positions: merged_data_imm_positions,
        code_imm_positions: merged_code_imm_positions,
        call_fp_arg_masks: merged_call_fp_arg_masks,
        variadic_functions: merged_variadic_functions,
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
        // The linker concatenates pre-optimizer object bytes;
        // the merged Program has not been through `optimize()`.
        optimized: false,
        // Linker propagates the AST tier so the post-link
        // codegen can drive SSA from the walker. Each unit's
        // `finished_functions` has unit-local `ent_pc`s; rebase
        // by the unit's `text_base` so the codegen-side ent_pc
        // stays consistent with the merged bytecode. Single-unit
        // links are the immediate target and concatenate
        // verbatim.
        finished_functions: {
            // Cumulative sym-base per unit so multi-TU AST
            // snapshots see the merged `parser_symbols` table.
            let mut sym_base: alloc::vec::Vec<u32> = alloc::vec::Vec::with_capacity(units.len());
            let mut cum: u32 = 0;
            for unit in units.iter() {
                sym_base.push(cum);
                cum += unit.parser_symbols.len() as u32;
            }
            let mut all: alloc::vec::Vec<crate::c5::ast::FinishedFunction> = alloc::vec::Vec::new();
            for (i, unit) in units.iter().enumerate() {
                let base = text_base[i];
                let d_base = data_base[i] as i64;
                let t_base = base as i64;
                let s_base = sym_base[i];
                for f in &unit.finished_functions {
                    let mut clone = f.clone();
                    clone.ent_pc += base;
                    // Parser-time `data_off` / Glo `val` snapshots
                    // are relative to this unit's own data segment
                    // start (post-`compile_to_link_unit`, before
                    // the linker placed the unit at `data_base[i]`
                    // in the merged image, which itself sits past
                    // the leading 8-byte NULL guard). Rebase each
                    // node so the walker emits the right absolute
                    // offset.
                    clone.ast.rebase_data_offsets(d_base);
                    // Token::Fun `val` snapshots are also unit-
                    // local pre-link PCs. The walker reads them
                    // for in-unit `Expr::Call` targets when the
                    // merged `Symbol` table can't resolve the
                    // ident. Shift by the same `text_base`
                    // `Op::Jsr` operands get under `apply_reloc`.
                    clone.ast.rebase_function_pcs(t_base);
                    // Sym indices stored on AST Idents / Decls
                    // are unit-local; the linker concatenates
                    // each unit's `parser_symbols` below, so
                    // every ident has to point at its slot in
                    // the merged table.
                    clone.ast.rebase_sym_indices(s_base);
                    // Token::Sys `val` is the parser's per-unit
                    // flat binding index; the merger's pass-2
                    // computed `binding_remap_per_unit[i]` to
                    // shift it into the merged image, the same
                    // remap `apply_reloc` uses to rewrite
                    // `Op::JsrExt` / `Op::TailExt` operands.
                    clone
                        .ast
                        .rebase_sys_binding_indices(&binding_remap_per_unit[i]);
                    // Struct type tags carry unit-local struct
                    // ids; rebase to the merged-list ids the
                    // walker consults via `self.structs`. Also
                    // remap per-parameter type tags so the walker
                    // sizes struct-by-value entry-Mcpys against
                    // the merged struct.
                    clone.ast.rebase_struct_ids(&struct_remap_per_unit[i]);
                    for ty in &mut clone.param_tys {
                        *ty = crate::c5::ast::remap_struct_ty(*ty, &struct_remap_per_unit[i]);
                    }
                    // Source-file indices on `expr_src` / `stmt_src`
                    // / `decl_src` are unit-local; the linker
                    // concatenates each unit's `source_files` into
                    // one merged table starting at
                    // `source_file_offset_per_unit[i]`. Shift the
                    // AST's parallel position arrays so DWARF rows
                    // emitted by the walker land on the correct
                    // file entry post-merge.
                    clone
                        .ast
                        .rebase_source_file_indices(source_file_offset_per_unit[i]);
                    all.push(clone);
                }
            }
            all
        },
        symbols: {
            // Multi-TU: concatenate each unit's `parser_symbols`,
            // shift each defining `Token::Fun` symbol's `val` by
            // the unit's `text_base`, then patch every
            // forward-declared `Token::Fun` symbol (`val == 0`)
            // to the post-link PC of its definition in another
            // unit. The lookup is by `Symbol::name`; the same
            // shape `apply_reloc` uses to resolve `Op::Jsr`
            // operands across units, restated here so the
            // walker's `live_fun_val(sym)` lands on the correct
            // PC instead of staying at 0 (which collides with
            // the first emitted function).
            // Concatenate each unit's `parser_symbols`. Token::Fun
            // gets a `text_base` shift on defining entries (val > 0);
            // forward-declared siblings (val == 0) are patched
            // below from the defining sibling's resolved PC.
            // Token::Glo entries are left at their parser-time val
            // here; the cross-unit fixup below uses the merger's
            // `defined: HashMap<String, GlobalSymbol>` so a
            // tentative-def shape (C99 6.9.2 -- `extern T x;` in
            // every TU with no syntactic definition) still
            // resolves through the `LinkUnit::symbols` canonical
            // entry, the same way `apply_reloc` patches
            // bytecode-tier `Op::Imm <data_off>` operands.
            let mut merged: alloc::vec::Vec<crate::c5::symbol::Symbol> = alloc::vec::Vec::new();
            let fun_class = crate::c5::token::Token::Fun as i64;
            let glo_class = crate::c5::token::Token::Glo as i64;
            for (i, unit) in units.iter().enumerate() {
                let base = text_base[i] as i64;
                for sym in &unit.parser_symbols {
                    let mut s = sym.clone();
                    // C99 6.9 + the c5 ABI: a function's `val`
                    // is the entry PC; rebase by `text_base[i]`
                    // when `defined_here` is set (body emitted
                    // in this unit). `val == 0` is a valid
                    // defining PC for the first function in
                    // unit 0, so the rebase tracks the parser's
                    // `defined_here` flag rather than the val
                    // itself; forward declarations
                    // (`defined_here == false`, `val == 0`)
                    // stay at zero and the cross-unit pass
                    // below patches them from the merged
                    // defining sibling.
                    if s.class == fun_class && s.defined_here {
                        s.val += base;
                    }
                    // Symbol::type_ and Symbol::params carry
                    // unit-local struct ids; rebase to the
                    // merged-list ids so the walker's
                    // `is_struct_ty(sym.type_)` / `struct_size`
                    // queries hit the right entry.
                    s.type_ = crate::c5::ast::remap_struct_ty(s.type_, &struct_remap_per_unit[i]);
                    for p in &mut s.params {
                        *p = crate::c5::ast::remap_struct_ty(*p, &struct_remap_per_unit[i]);
                    }
                    merged.push(s);
                }
            }
            // Forward-decl resolution for Token::Fun. A Sys
            // binding's `val` is the binding-flat index, not a
            // PC, so the class check excludes it.
            //
            // Sources for the (name -> post-link PC) map:
            //  * `merged` (concatenated parser_symbols) for units
            //    parsed in this invocation -- their `defined_here`
            //    bit + the `text_base`-shifted val already point at
            //    the right PC.
            //  * Each unit's [`LinkSymbol`] table for archive-pulled
            //    units. `read_object` does not round-trip
            //    `parser_symbols`, so those entries never reach
            //    `merged`; the c5 object format carries the same
            //    function names through the standard SYMTAB section
            //    instead. Pull them in here so the walker's
            //    `live_fun_val(sym)` resolves cross-unit
            //    archive-defined callees instead of returning 0
            //    (which collides with the first function in the
            //    merged bytecode -- usually `main`).
            use crate::c5::symbol::Linkage;
            let mut fun_def_by_name: alloc::collections::BTreeMap<alloc::string::String, i64> =
                alloc::collections::BTreeMap::new();
            for s in &merged {
                if s.class == fun_class && s.defined_here && s.linkage == Linkage::External {
                    fun_def_by_name.insert(s.name.clone(), s.val);
                }
            }
            for (i, unit) in units.iter().enumerate() {
                let base = text_base[i] as i64;
                for ls in &unit.symbols {
                    if !matches!(ls.kind, SymbolKind::Function) {
                        continue;
                    }
                    if !matches!(ls.linkage, Linkage::External) {
                        continue;
                    }
                    fun_def_by_name
                        .entry(ls.name.clone())
                        .or_insert(base + ls.value as i64);
                }
            }
            for s in &mut merged {
                if s.class == fun_class
                    && !s.defined_here
                    && s.linkage == Linkage::External
                    && let Some(&resolved) = fun_def_by_name.get(&s.name)
                {
                    s.val = resolved;
                }
            }
            // Cross-unit Token::Glo resolution. Walker reads
            // `live_glo_val(sym)` for externally-linked
            // `is_extern_decl` Globals so it must find the
            // post-link absolute offset on the merged symbol.
            // The merger's `defined` map already knows the
            // canonical defining unit -- query it for every
            // qualifying entry. Static locals (`linkage == None`)
            // and file-scope `static` (`linkage == Internal`)
            // are excluded by the linkage check; only true
            // `extern` references with no in-unit storage get
            // their val rewritten.
            for s in &mut merged {
                if s.class != glo_class
                    || !s.is_extern_decl
                    || s.is_thread_local
                    || s.linkage != Linkage::External
                {
                    continue;
                }
                let Some(g) = defined.get(&s.name) else {
                    continue;
                };
                let Some(target) = units[g.unit_idx].symbols.get(g.sym_idx) else {
                    continue;
                };
                if matches!(target.kind, SymbolKind::Data) {
                    s.val = (data_base[g.unit_idx] as i64) + target.value as i64;
                }
            }
            merged
        },
        // Populated below from the merged bytecode tape so the
        // codegen-side `produce_ssa_funcs` no longer needs its
        // own lift-recovery loop for sys-trampolines that came
        // through an archive boundary.
        synthetic_ssa_funcs: alloc::vec::Vec::new(),
        user_ssa_funcs: alloc::vec::Vec::new(),
        // Bytecode linker resolves every cross-TU function call
        // in place via `RelocKind::JsrPc`; no placeholder PCs
        // survive into the merged program.
        extern_function_imports: alloc::vec::Vec::new(),
    })
    .and_then(|mut program| {
        // Walker covers every user-declared function via
        // `finished_functions`; the remaining sys-trampolines
        // come from either the per-unit `synthetic_ssa_funcs`
        // (in-memory compile+link, or .o files that carry the
        // synthesised SSA blob) or the bytecode lift (legacy
        // .o files without the blob). Pre-collect the walker-
        // covered ent_pcs + the unit-side synth ent_pcs so we
        // don't double-add through the lift fallback.
        let walker_pcs: alloc::collections::BTreeSet<usize> = program
            .finished_functions
            .iter()
            .map(|f| f.ent_pc)
            .collect();
        let mut covered: alloc::collections::BTreeSet<usize> = walker_pcs.clone();
        for (i, unit) in units.iter().enumerate() {
            let text_off = text_base[i];
            let binding_remap = &binding_remap_per_unit[i];
            for f in &unit.synthetic_ssa_funcs {
                let mut rebased = f.clone();
                rebased.ent_pc += text_off;
                rebased.end_pc += text_off;
                // Trampolines reach exactly one libc binding;
                // the index lives in `Inst::CallExt::binding_idx`
                // (variadic / fixed-param shape) or in
                // `Terminator::TailExt(idx)` (zero-arg shape).
                // Remap both through the unit's binding table.
                for inst in &mut rebased.insts {
                    if let crate::c5::ir::Inst::CallExt { binding_idx, .. } = inst
                        && let Some(remapped) = binding_remap.get(*binding_idx as usize)
                    {
                        *binding_idx = *remapped;
                    }
                }
                for blk in &mut rebased.blocks {
                    if let crate::c5::ir::Terminator::TailExt(idx) = &mut blk.terminator
                        && let Some(remapped) = binding_remap.get(*idx as usize)
                    {
                        *idx = *remapped;
                    }
                }
                if covered.insert(rebased.ent_pc) {
                    program.synthetic_ssa_funcs.push(rebased);
                }
            }
        }
        // User SSA from each unit's compile_to_link_unit path.
        // Per-unit ent_pcs are unit-local; rebase by text_base.
        // Inst::CallExt::binding_idx and Terminator::TailExt(idx)
        // remap through the unit's binding table (same logic the
        // sys-trampoline loop above runs). Inst::Call::target_pc
        // and Inst::ImmCode are resolved by the post-merge pass
        // below against the patched bytecode tape -- the linker
        // has already rewritten Op::Jsr / function-pointer Imm
        // operands to their merged target PCs there.
        for (i, unit) in units.iter().enumerate() {
            let text_off = text_base[i];
            let data_off = data_base[i];
            let tls_off = tls_base[i];
            let binding_remap = &binding_remap_per_unit[i];
            for f in &unit.user_ssa_funcs {
                let mut rebased = f.clone();
                rebased.ent_pc += text_off;
                rebased.end_pc += text_off;
                for inst in &mut rebased.insts {
                    use crate::c5::ir::Inst;
                    match inst {
                        Inst::CallExt { binding_idx, .. } => {
                            if let Some(remapped) = binding_remap.get(*binding_idx as usize) {
                                *binding_idx = *remapped;
                            }
                        }
                        // Walker stamps the live unit-local
                        // `symbol.val` for in-unit references. Shift
                        // by the matching section base so the value
                        // points at the merged segment. Cross-TU
                        // externs arrive as 0 (walker has no live
                        // val); leave those for the resolver to
                        // patch from the linker-rewritten bytecode
                        // operand. Inst::Call::target_pc and
                        // Inst::ImmCode hold unit-local function PCs
                        // -> shift by `text_off`; ImmData / TlsAddr
                        // hold unit-local data / TLS offsets.
                        Inst::Call { target_pc, .. } if *target_pc != 0 => {
                            *target_pc += text_off;
                        }
                        Inst::ImmCode(pc) if *pc != 0 => {
                            *pc += text_off;
                        }
                        Inst::ImmData(off) if *off != 0 => {
                            *off += data_off as i64;
                        }
                        Inst::TlsAddr(off) if *off != 0 => {
                            *off += tls_off as i64;
                        }
                        _ => {}
                    }
                }
                for blk in &mut rebased.blocks {
                    if let crate::c5::ir::Terminator::TailExt(idx) = &mut blk.terminator
                        && let Some(remapped) = binding_remap.get(*idx as usize)
                    {
                        *idx = *remapped;
                    }
                }
                program.user_ssa_funcs.push(rebased);
            }
        }
        // Resolve Inst::Call::target_pc and Inst::ImmCode against
        // the linker-patched bytecode tape. The walker emits one
        // Inst::Call per Op::Jsr in the source order; the i-th
        // Inst::Call in each function's `insts` matches the i-th
        // Op::Jsr in `program.text[ent_pc..end_pc]`. The same
        // 1:1 ordering holds between Inst::ImmCode and the
        // function-pointer literals recorded in
        // `code_imm_positions` for that function's range.
        resolve_user_ssa_call_targets(&mut program)?;
        // `covered` is unused now that the lift fallback below
        // retired; the post-merge synth + user SSA cover every
        // ent_pc the codegen reaches.
        let _ = covered;
        Ok(program)
    })
}

/// Patch every `Inst::Call::target_pc` and `Inst::ImmCode`
/// across `program.user_ssa_funcs` from the matching bytecode-
/// side operand. The walker emits one `Inst::Call` per `Op::Jsr`
/// and one `Inst::ImmCode` per function-pointer `Op::Imm` in
/// source order, so the i-th occurrence in `insts` aligns with
/// the i-th matching operand in `program.text[ent_pc..end_pc]`.
/// The linker has already rewritten those operands to their
/// merged target PCs (locally-defined targets via the per-unit
/// `text_base` shift; cross-TU externs via the relocation
/// pass), so reading them back propagates the resolution to the
/// SSA side uniformly.
fn resolve_user_ssa_call_targets(program: &mut Program) -> Result<(), C5Error> {
    use crate::c5::ir::Inst;
    use crate::c5::op::Op;

    let code_imm_positions: alloc::collections::BTreeSet<usize> =
        program.code_imm_positions.iter().copied().collect();
    let data_imm_positions: alloc::collections::BTreeSet<usize> =
        program.data_imm_positions.iter().copied().collect();

    for f in &mut program.user_ssa_funcs {
        let mut jsr_targets: Vec<i64> = Vec::new();
        let mut imm_code_targets: Vec<i64> = Vec::new();
        let mut imm_data_targets: Vec<i64> = Vec::new();
        let mut tls_targets: Vec<i64> = Vec::new();
        let mut pc = f.ent_pc;
        while pc < f.end_pc && pc < program.text.len() {
            let raw = program.text[pc];
            let Some(op) = Op::from_i64(raw) else {
                return Err(err(&alloc::format!(
                    "user_ssa_funcs: non-op word at bc_pc {pc} during resolver scan",
                )));
            };
            let operand_pc = pc + 1;
            match op {
                Op::Jsr => {
                    if operand_pc >= program.text.len() {
                        return Err(err("user_ssa_funcs: dangling Op::Jsr at end of text"));
                    }
                    jsr_targets.push(program.text[operand_pc]);
                }
                Op::Imm if code_imm_positions.contains(&operand_pc) => {
                    if operand_pc >= program.text.len() {
                        return Err(err("user_ssa_funcs: dangling Op::Imm at end of text"));
                    }
                    imm_code_targets.push(program.text[operand_pc]);
                }
                Op::Imm if data_imm_positions.contains(&operand_pc) => {
                    if operand_pc >= program.text.len() {
                        return Err(err("user_ssa_funcs: dangling Op::Imm at end of text"));
                    }
                    imm_data_targets.push(program.text[operand_pc]);
                }
                Op::TlsLea => {
                    if operand_pc >= program.text.len() {
                        return Err(err("user_ssa_funcs: dangling Op::TlsLea at end of text"));
                    }
                    tls_targets.push(program.text[operand_pc]);
                }
                _ => {}
            }
            pc += op.word_size();
        }
        // The order-zip below pairs the i-th Inst with the i-th
        // bytecode operand of the matching kind. That contract
        // only holds when the counts match exactly; a drift
        // means at least one Inst would receive an operand
        // intended for a different expression. Count first and
        // reject the link on mismatch rather than continuing
        // with a partial zip whose surviving entries silently
        // load wild data at run time.
        let inst_call_count = f
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::Call { .. }))
            .count();
        let inst_imm_code_count = f
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::ImmCode(_)))
            .count();
        let inst_imm_data_count = f
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::ImmData(_)))
            .count();
        let inst_tls_count = f
            .insts
            .iter()
            .filter(|i| matches!(i, Inst::TlsAddr(_)))
            .count();
        let mismatched = inst_call_count != jsr_targets.len()
            || inst_imm_code_count != imm_code_targets.len()
            || inst_imm_data_count != imm_data_targets.len()
            || inst_tls_count != tls_targets.len();
        if let Ok(target) = std::env::var("BADC_DUMP_USER_SSA_FUNC") {
            let name = program
                .source_functions
                .get(f.ent_pc)
                .cloned()
                .unwrap_or_default();
            if name == target {
                std::eprintln!(
                    "==== walker user_ssa_func {} ent_pc={} ====",
                    name,
                    f.ent_pc
                );
                for (i, inst) in f.insts.iter().enumerate() {
                    std::eprintln!("  v{:<4} {:?}", i, inst);
                }
                for (bi, blk) in f.blocks.iter().enumerate() {
                    std::eprintln!(
                        "  block {} insts {}..{} term {:?}",
                        bi,
                        blk.inst_range.start,
                        blk.inst_range.end,
                        blk.terminator,
                    );
                }
                let walker_imm_data: alloc::vec::Vec<(usize, i64, u32)> = f
                    .insts
                    .iter()
                    .enumerate()
                    .filter_map(|(i, inst)| {
                        if let Inst::ImmData(off) = inst {
                            let line = f.inst_src.get(i).map(|&(l, _)| l).unwrap_or(0);
                            Some((i, *off, line))
                        } else {
                            None
                        }
                    })
                    .collect();
                std::eprintln!(
                    "---- walker ImmData (idx,value,line): {:?}",
                    walker_imm_data
                );
                std::eprintln!("---- bytecode imm_data_targets: {:?}", imm_data_targets);
                let walker_imm_code: alloc::vec::Vec<usize> = f
                    .insts
                    .iter()
                    .filter_map(|i| {
                        if let Inst::ImmCode(pc) = i {
                            Some(*pc)
                        } else {
                            None
                        }
                    })
                    .collect();
                std::eprintln!("---- walker ImmCode values: {:?}", walker_imm_code);
                std::eprintln!("---- bytecode imm_code_targets: {:?}", imm_code_targets);
            }
        }
        if mismatched {
            let name = program
                .source_functions
                .get(f.ent_pc)
                .cloned()
                .unwrap_or_default();
            return Err(err(&alloc::format!(
                "user_ssa_funcs: walker / parser drift in {:?} (ent_pc={}): \
                 Call {} vs Op::Jsr {}, ImmCode {} vs {}, ImmData {} vs {}, TlsAddr {} vs Op::TlsLea {}",
                name,
                f.ent_pc,
                inst_call_count,
                jsr_targets.len(),
                inst_imm_code_count,
                imm_code_targets.len(),
                inst_imm_data_count,
                imm_data_targets.len(),
                inst_tls_count,
                tls_targets.len(),
            )));
        }
        let mut jsr_iter = jsr_targets.into_iter();
        let mut imm_code_iter = imm_code_targets.into_iter();
        let mut imm_data_iter = imm_data_targets.into_iter();
        let mut tls_iter = tls_targets.into_iter();
        // For every Inst variant the resolver handles, the merge
        // loop above already shifted any walker-stamped non-zero
        // value by the matching section base, so we patch from the
        // bytecode operand only when the walker stamped 0 (the
        // cross-TU extern case where parser_symbol.val was 0
        // because the defining unit hadn't been linked yet).
        // Drift between walker-stamped values and bytecode-side
        // operands marks a walker / parser layout divergence (the
        // most recent case was the for-loop body / step block
        // order, fixed in commit b86eec5). Strict mode -- gated by
        // BADC_STRICT_RESOLVER=1 -- fails the link so the next
        // divergence surfaces immediately; otherwise the bytecode
        // operand wins and the divergence emits a single warning
        // line per function on stderr so it shows up in CI logs
        // without breaking builds. TODO: retire the bytecode-side
        // operand entirely once every Inst variant carries enough
        // information for the linker to resolve cross-TU references
        // from the symbol table directly.
        #[cfg(feature = "std")]
        let strict = std::env::var("BADC_STRICT_RESOLVER").is_ok();
        #[cfg(not(feature = "std"))]
        let strict = false;
        let mut drift_reported_for_this_fn = false;
        let mut report_drift = |kind: &str, walker_val: i64, bytecode_val: i64| {
            if drift_reported_for_this_fn {
                return;
            }
            drift_reported_for_this_fn = true;
            #[cfg(feature = "std")]
            std::eprintln!(
                "[resolver] {kind} drift in {:?} (ent_pc={}): walker={walker_val}, bytecode={bytecode_val} -- bytecode wins",
                program
                    .source_functions
                    .get(f.ent_pc)
                    .cloned()
                    .unwrap_or_default(),
                f.ent_pc,
            );
        };
        for inst in &mut f.insts {
            match inst {
                Inst::Call { target_pc, .. } => {
                    if let Some(t) = jsr_iter.next() {
                        if *target_pc == 0 {
                            *target_pc = t as usize;
                        } else if *target_pc != t as usize {
                            if strict {
                                return Err(err(&alloc::format!(
                                    "Inst::Call::target_pc drift in {:?} (ent_pc={}): walker={}, bytecode={}",
                                    program
                                        .source_functions
                                        .get(f.ent_pc)
                                        .cloned()
                                        .unwrap_or_default(),
                                    f.ent_pc,
                                    *target_pc,
                                    t,
                                )));
                            }
                            report_drift("Inst::Call::target_pc", *target_pc as i64, t);
                            *target_pc = t as usize;
                        }
                    }
                }
                Inst::ImmCode(pc) => {
                    if let Some(t) = imm_code_iter.next() {
                        // Bytecode side stores CODE_BASE + bc_pc;
                        // the SSA side stores the bare bc_pc.
                        let bytecode_pc = (t - crate::c5::CODE_BASE as i64) as usize;
                        if *pc == 0 {
                            *pc = bytecode_pc;
                        } else if *pc != bytecode_pc {
                            if strict {
                                return Err(err(&alloc::format!(
                                    "Inst::ImmCode drift in {:?} (ent_pc={}): walker={}, bytecode={}",
                                    program
                                        .source_functions
                                        .get(f.ent_pc)
                                        .cloned()
                                        .unwrap_or_default(),
                                    f.ent_pc,
                                    *pc,
                                    bytecode_pc,
                                )));
                            }
                            report_drift("Inst::ImmCode", *pc as i64, bytecode_pc as i64);
                            *pc = bytecode_pc;
                        }
                    }
                }
                Inst::ImmData(off) => {
                    if let Some(t) = imm_data_iter.next() {
                        if *off == 0 {
                            *off = t;
                        } else if *off != t {
                            if strict {
                                return Err(err(&alloc::format!(
                                    "Inst::ImmData drift in {:?} (ent_pc={}): walker={}, bytecode={}",
                                    program
                                        .source_functions
                                        .get(f.ent_pc)
                                        .cloned()
                                        .unwrap_or_default(),
                                    f.ent_pc,
                                    *off,
                                    t,
                                )));
                            }
                            report_drift("Inst::ImmData", *off, t);
                            *off = t;
                        }
                    }
                }
                Inst::TlsAddr(off) => {
                    if let Some(t) = tls_iter.next() {
                        if *off == 0 {
                            *off = t;
                        } else if *off != t {
                            if strict {
                                return Err(err(&alloc::format!(
                                    "Inst::TlsAddr drift in {:?} (ent_pc={}): walker={}, bytecode={}",
                                    program
                                        .source_functions
                                        .get(f.ent_pc)
                                        .cloned()
                                        .unwrap_or_default(),
                                    f.ent_pc,
                                    *off,
                                    t,
                                )));
                            }
                            report_drift("Inst::TlsAddr", *off, t);
                            *off = t;
                        }
                    }
                }
                _ => {}
            }
        }
    }
    Ok(())
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
    Err(link_err(&format!(
        "{}() not defined",
        preferred.first().map(|s| s.as_str()).unwrap_or("main")
    )))
}

/// User-level link diagnostic (undefined reference, no inputs,
/// malformed archive, ...). Routed through the `error:` prefix
/// without the `internal compiler error:` marker so consumers
/// don't misread a missing extern as a c5 bug.
fn link_err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_link_err(msg))
}

/// Genuine internal-consistency violation in the linker
/// (dangling operand, reloc location out of range, non-op word in
/// a TU's text segment). These are c5 bugs surfaced through the
/// link path; keep the ICE marker.
fn err(msg: &str) -> C5Error {
    C5Error::Compile(crate::c5::error::fmt_internal_err(msg))
}
