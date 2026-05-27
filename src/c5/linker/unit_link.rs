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
//! 5. Concatenate every unit's `data` and `tls_data` into the
//!    merged program, recording per-unit base offsets.
//! 6. Walk the per-unit `data_relocs` / `code_relocs` and
//!    re-base both endpoints by the unit's data-base offset.
//! 7. Apply cross-TU `Reloc` entries -- only data-segment kinds
//!    survive (`RelocKind::Data*Abs64`). Each entry points at a
//!    `data` slot whose final value depends on the resolved
//!    target symbol's merged-program position.
//! 8. Merge the per-unit metadata: dylib + binding table
//!    (each unit's `Inst::CallExt::binding_idx` /
//!    `Terminator::TailExt(idx)` are remapped through
//!    `binding_remap_per_unit[i]`), struct registry, exports,
//!    the chosen entry symbol, etc.
//! 9. Rebase every SSA function's `ent_pc` / `end_pc` and the
//!    per-unit `Symbol::val` for `Token::Fun` symbols by the
//!    unit's `text_base[i]` (the cumulative `unit_text_extent`
//!    sum) so cross-TU function identifiers stay unique.
//! 10. Construct the final [`Program`] and return it.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use hashbrown::{HashMap, HashSet};

use crate::c5::error::C5Error;
use crate::c5::preprocessor::DylibSpec;
use crate::c5::program::{CodeReloc, DataReloc, ExportedFunction, Program};

use super::archive::{ArchiveMember, read_archive};
use super::unit::LinkUnit;
use super::unit_object::read_object;
use super::unit_reloc::{Reloc, RelocKind};
use super::unit_symbol::SymbolKind;

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
    let mut merged_data: Vec<u8> = alloc::vec![0u8; 8];
    let mut merged_tls: Vec<u8> = Vec::new();
    let mut merged_tls_init: usize = 0;

    // Pre-compute every per-unit base offset. `text_base[i]` is
    // the cumulative `unit_text_extent` -- the PC-space the unit
    // occupies for ent_pc / end_pc / Symbol::val arithmetic.
    // `data_base[i]` is the byte offset in the merged data
    // segment (with 8-byte padding between units so each unit's
    // intra-segment offsets stay 8-aligned). `tls_init_cum` is
    // the same for the initialised-TLS prefix region. We compute
    // these eagerly before the reloc-apply pass so each unit's
    // remap reads a stable base rather than chasing a moving
    // target.
    let mut text_cum = 0usize;
    let mut data_cum = merged_data.len();
    let mut tls_init_cum = 0usize;
    for unit in &units {
        text_base.push(text_cum);
        text_cum += unit_text_extent(unit);
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
    // offsets.
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
    // index remap so each unit's `Inst::CallExt::binding_idx` /
    // `Terminator::TailExt(idx)` can be retargeted at the
    // merged binding's new flat position.
    //
    // Two-pass to avoid a flat-index shift hazard. The walker-
    // emitted binding_idx encodes flat position as
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
        let text_off = text_base[ui];
        let data_off = data_base[ui];

        // Variables: shift function_bc_pc.
        for v in &unit.variables {
            merged_variables.push(crate::c5::program::VariableInfo {
                function_bc_pc: v.function_bc_pc + text_off as u64,
                name: v.name.clone(),
                type_tag: v.type_tag,
                fp_slot: v.fp_slot,
                is_parameter: v.is_parameter,
                decl_line: v.decl_line,
            });
        }
        for w in &unit.warnings {
            merged_warnings.push(w.clone());
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
                target_ent_pc: r.target_ent_pc + text_off as u64,
            });
        }

        // Exports: rebase the function's ent_pc onto the merged unit's PC space.
        for e in &unit.exports {
            merged_exports.push(ExportedFunction {
                name: e.name.clone(),
                ent_pc: e.ent_pc + text_off,
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
        let data_off = data_base[ui];
        for r in &unit.relocs {
            apply_reloc(
                &mut merged_data,
                &mut merged_data_relocs,
                &mut merged_code_relocs,
                ui,
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
    // encoding embeds a struct id per unit, but since c5 resolves
    // each member's offset at parser time, cross-TU type-tag
    // identity isn't required for runtime correctness. The merged
    // list is consumed only by the DWARF emitter.
    let mut merged_structs: Vec<crate::c5::compiler::StructDef> = Vec::new();
    // Per-unit struct-id remap: `struct_remap_per_unit[i][unit_local_id]`
    // is the index this struct lands at in `merged_structs`. The
    // walker reads `struct_size(ty)` against `merged_structs` for
    // every struct assignment / return / by-value param size, so
    // the AST snapshots that ride this `Program` need their `ty`
    // tags rebased.
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
        data: merged_data,
        entry_pc,
        warnings: merged_warnings,
        tls_data: merged_tls,
        tls_init_size: merged_tls_init,
        exports: merged_exports,
        data_relocs: merged_data_relocs,
        code_relocs: merged_code_relocs,
        dylibs: merged_dylibs,
        dllmain_pc,
        source_files: merged_source_files,
        source_path,
        variables: merged_variables,
        structs: merged_structs,
        entry_name,
        subsystem,
        // Linker propagates the AST tier so the post-link
        // codegen can drive SSA from the walker. Each unit's
        // `finished_functions` has unit-local `ent_pc`s; rebase
        // by the unit's `text_base` so the codegen-side ent_pc
        // stays consistent with the merged unit's PC space.
        // Single-unit links concatenate verbatim.
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
                    clone.end_pc += base;
                    // Parser-time `data_off` / Glo `val` snapshots
                    // are relative to this unit's own data segment
                    // start (post-`compile_to_link_unit`, before
                    // the linker placed the unit at `data_base[i]`
                    // in the merged image, which itself sits past
                    // the leading 8-byte NULL guard). Rebase each
                    // node so the walker emits the right absolute
                    // offset.
                    clone.ast.rebase_data_offsets(d_base);
                    // Token::Fun `val` snapshots are unit-local
                    // pre-link PCs. The walker reads them for
                    // in-unit `Expr::Call` targets when the
                    // merged `Symbol` table can't resolve the
                    // ident; shift by the unit's `text_base`.
                    clone.ast.rebase_function_pcs(t_base);
                    // Sym indices stored on AST Idents / Decls
                    // are unit-local; the linker concatenates
                    // each unit's `parser_symbols` below, so
                    // every ident has to point at its slot in
                    // the merged table.
                    clone.ast.rebase_sym_indices(s_base);
                    // Token::Sys `val` is the parser's per-unit
                    // flat binding index; pass-2's
                    // `binding_remap_per_unit[i]` shifts it
                    // into the merged image.
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
            // Concatenate each unit's `parser_symbols`. Token::Fun
            // defining entries (val > 0) get the unit's
            // `text_base` shift so the walker's `live_fun_val(sym)`
            // lands on a unique post-link PC; forward-declared
            // siblings (val == 0) are patched below from the
            // defining sibling's resolved PC. Token::Glo entries
            // keep their parser-time val here; the cross-unit
            // fixup below uses the merger's `defined: HashMap<
            // String, GlobalSymbol>` so a C99 6.9.2 tentative-
            // def shape (`extern T x;` across every TU with no
            // syntactic definition) still resolves.
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
            //    merged PC space -- usually `main`).
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
        // Populated below from each unit's per-TU
        // `synthetic_ssa_funcs` so the codegen reads SSA for
        // sys-trampolines that came through an archive boundary.
        synthetic_ssa_funcs: alloc::vec::Vec::new(),
        user_ssa_funcs: alloc::vec::Vec::new(),
        // Walker-tier `extern_call_refs` / `extern_imm_code_refs`
        // resolve every cross-TU function reference in place
        // post-merge; no placeholder PCs survive into the merged
        // program.
        extern_function_imports: alloc::vec::Vec::new(),
    })
    .map(|mut program| {
        // Walker covers every user-declared function via
        // `finished_functions`; the remaining sys-trampolines
        // come from each unit's `synthetic_ssa_funcs`. Pre-collect
        // the walker-covered ent_pcs + the unit-side synth ent_pcs
        // so we don't double-add a function the linker has
        // already merged.
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
        // `Inst::CallExt::binding_idx` and
        // `Terminator::TailExt(idx)` remap through the unit's
        // binding table (same logic the sys-trampoline loop
        // above runs). `Inst::Call::target_pc` and
        // `Inst::ImmCode` for in-unit references shift by
        // `text_off`; cross-TU externs ride through as
        // `value == 0` and are resolved by
        // `resolve_extern_refs` against the walker-recorded
        // `extern_*_refs` channels.
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
                        // patch through `extern_fun_refs` /
                        // `extern_imm_data_refs`. Inst::Call::target_pc
                        // and Inst::ImmCode hold unit-local function
                        // PCs -> shift by `text_off`; ImmData /
                        // TlsAddr hold unit-local data / TLS offsets.
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
                // Resolve every walker-recorded extern reference
                // via the unit's LinkSymbol table + global symbol
                // map.
                resolve_extern_refs(
                    &mut rebased,
                    unit,
                    &units,
                    &text_base,
                    &data_base,
                    &tls_base,
                    &tls_bss_base,
                    &defined,
                );
                program.user_ssa_funcs.push(rebased);
            }
        }
        // `covered` was used inside the loops above to dedupe;
        // it's no longer read after this point.
        let _ = covered;
        program
    })
}

/// Patch every `Inst::{Call,ImmCode,ImmData,TlsAddr}` whose
/// walker-stamped value was 0 (cross-TU extern) by resolving the
/// recorded symbol reference through the unit's `LinkSymbol`
/// table and the global `defined` map. The four refs vectors
/// were populated by the walker and remapped to LinkUnit symbol
/// indices in `link_unit`.
#[allow(clippy::too_many_arguments)]
fn resolve_extern_refs(
    rebased: &mut crate::c5::ir::FunctionSsa,
    unit: &LinkUnit,
    units: &[LinkUnit],
    text_base: &[usize],
    data_base: &[usize],
    tls_base: &[usize],
    tls_bss_base: &[usize],
    defined: &HashMap<String, GlobalSymbol>,
) {
    use crate::c5::ir::Inst;

    // Helper: look up the target_value (mirrors apply_reloc's
    // symbol-resolution logic) for a given (link_sym_idx, expected
    // kind). Returns None when the symbol can't be resolved or
    // doesn't match the expected kind; callers leave the Inst at
    // 0, which the codegen surfaces as a relocation if the symbol
    // is genuinely unresolved at link time.
    let resolve = |link_sym_idx: u32, want_kind: SymbolKind| -> Option<i64> {
        let link_sym = unit.symbols.get(link_sym_idx as usize)?;
        let target = if matches!(link_sym.linkage, crate::c5::symbol::Linkage::Internal) {
            (
                units.iter().position(|u| core::ptr::eq(u, unit))?,
                link_sym.clone(),
            )
        } else {
            let g = defined.get(&link_sym.name)?;
            (g.unit_idx, units[g.unit_idx].symbols[g.sym_idx].clone())
        };
        let (target_unit_idx, target_sym_def) = target;
        if !std::mem::discriminant(&target_sym_def.kind).eq(&std::mem::discriminant(&want_kind)) {
            return None;
        }
        let v = match target_sym_def.kind {
            SymbolKind::Function => {
                (text_base[target_unit_idx] as i64) + target_sym_def.value as i64
            }
            SymbolKind::Data => (data_base[target_unit_idx] as i64) + target_sym_def.value as i64,
            SymbolKind::TlsData => {
                let owner = &units[target_unit_idx];
                let init_local = owner.tls_init_size.min(owner.tls_data.len());
                if (target_sym_def.value as usize) < init_local {
                    (tls_base[target_unit_idx] as i64) + target_sym_def.value as i64
                } else {
                    (tls_bss_base[target_unit_idx] as i64)
                        + (target_sym_def.value as i64 - init_local as i64)
                }
            }
            SymbolKind::Undefined => return None,
        };
        Some(v)
    };

    for &(inst_idx, link_sym_idx) in &rebased.extern_call_refs {
        if let Some(target_pc) = resolve(link_sym_idx, SymbolKind::Function)
            && let Some(Inst::Call {
                target_pc: slot, ..
            }) = rebased.insts.get_mut(inst_idx as usize)
            && *slot == 0
        {
            *slot = target_pc as usize;
        }
    }
    for &(inst_idx, link_sym_idx) in &rebased.extern_imm_code_refs {
        if let Some(target_pc) = resolve(link_sym_idx, SymbolKind::Function)
            && let Some(Inst::ImmCode(slot)) = rebased.insts.get_mut(inst_idx as usize)
            && *slot == 0
        {
            *slot = target_pc as usize;
        }
    }
    for &(inst_idx, link_sym_idx) in &rebased.extern_imm_data_refs {
        if let Some(off) = resolve(link_sym_idx, SymbolKind::Data)
            && let Some(Inst::ImmData(slot)) = rebased.insts.get_mut(inst_idx as usize)
            && *slot == 0
        {
            *slot = off;
        }
    }
    for &(inst_idx, link_sym_idx) in &rebased.extern_tls_refs {
        if let Some(off) = resolve(link_sym_idx, SymbolKind::TlsData)
            && let Some(Inst::TlsAddr(slot)) = rebased.insts.get_mut(inst_idx as usize)
            && *slot == 0
        {
            *slot = off;
        }
    }
}

#[allow(clippy::too_many_arguments)]
fn apply_reloc(
    merged_data: &mut [u8],
    merged_data_relocs: &mut Vec<DataReloc>,
    merged_code_relocs: &mut Vec<CodeReloc>,
    ui: usize,
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
                target_ent_pc: resolved as u64,
            });
        }
    }
    Ok(())
}

/// Resolve the program's entry function. Returns the entry's
/// `ent_pc` plus the resolved symbol name (e.g. `wmain` /
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

/// Per-unit PC extent: the max `end_pc` across every SSA-func
/// vector the unit carries. The merge adds this to the running
/// `text_cum` to compute the next unit's `text_base`, keeping
/// every function's ent_pc / end_pc identifier unique across the
/// merged program.
fn unit_text_extent(unit: &LinkUnit) -> usize {
    let mut max_pc = 0usize;
    for f in &unit.finished_functions {
        if f.end_pc > max_pc {
            max_pc = f.end_pc;
        }
    }
    for f in &unit.synthetic_ssa_funcs {
        if f.end_pc > max_pc {
            max_pc = f.end_pc;
        }
    }
    for f in &unit.user_ssa_funcs {
        if f.end_pc > max_pc {
            max_pc = f.end_pc;
        }
    }
    max_pc
}
