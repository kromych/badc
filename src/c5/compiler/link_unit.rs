//! Convert a finished [`Compiler`] (parsed source + per-function
//! SSA snapshots) into a [`LinkUnit`] for cross-TU linking.
//!
//! Live only under the `linker` feature -- single-TU consumers
//! get the existing `compile() -> Program` path unchanged.
//!
//! Two behaviours diverge from a regular [`Compiler::compile`]:
//!
//!   1. `code_relocs` / `code_reloc_sym_idx` entries whose
//!      target is an undefined extern become
//!      `RelocKind::DataCodeAbs64` relocations -- their
//!      `target_ent_pc` field would otherwise be left at `0`.
//!   2. `glo_imm_refs` entries (recorded at every
//!      data-offset immediate emit for a `Token::Glo` symbol) whose
//!      target is an undefined extern are dropped; the
//!      walker's `extern_imm_data_refs` (or
//!      `extern_tls_refs` for TLS globals) carries the
//!      reference, and `resolve_extern_refs` patches the
//!      slot from the merged symbol table.
//!
//! Internal-linkage symbols stay in the link unit's local
//! symbol table so cross-TU relocations can reference them
//! by index, but they're filtered out at archive-pull-in /
//! merged-symbol-map time -- the linker never surfaces an
//! internal name across the global namespace.

use alloc::string::String;
use alloc::vec::Vec;

use super::Compiler;
use crate::c5::Target;
use crate::c5::ast::FinishedFunction;
use crate::c5::error::{C5Error, fmt_internal_err};
use crate::c5::ir::FunctionSsa;
use crate::c5::linker::{LinkSymbol, LinkUnit, Reloc, RelocKind, SymbolKind};
use crate::c5::symbol::{Linkage, Symbol};
use crate::c5::token::Token;

fn walker_funcs_for(
    finished: &[FinishedFunction],
    symbols: &[Symbol],
    structs: &[super::StructDef],
    target: Target,
) -> Result<Vec<FunctionSsa>, C5Error> {
    let mut out = Vec::with_capacity(finished.len());
    for f in finished {
        let mut func = crate::c5::ast::walk::walk_function(
            &f.ast,
            symbols,
            structs,
            target,
            f.ent_pc,
            f.end_pc,
            f.n_params,
            f.is_variadic,
            f.n_locals,
            &f.param_tys,
            &f.param_local_slots,
            f.returns_struct,
            f.return_struct_size,
            f.alloca_top_slot,
        )
        .map_err(|e| {
            C5Error::Compile(fmt_internal_err(&alloc::format!(
                "ast::walk: function `{}` (ent_pc={}): {}",
                f.name,
                f.ent_pc,
                e,
            )))
        })?;
        let touched = walker_param_count(&func);
        // Struct-by-value params hide their slot-2 read inside
        // the entry-Mcpy, so use the declared count when the
        // touched scan would under-count.
        func.n_params = touched.max(f.n_params);
        out.push(func);
    }
    out.sort_by_key(|f| f.ent_pc);
    // Walker stamps the live unit-local `symbol.val` for every
    // Glo reference -- including ones the link-unit cleanup
    // re-classifies as undefined-here (extern with no defining
    // initializer in this TU). Those tentative offsets land in
    // the .o's user_ssa_funcs as ImmData(<unit-local>) but the
    // real definition lives in another unit; without resetting
    // them here, the linker's per-unit `data_off` shift plus the
    // merge's symbol-resolution patch loop both miss the case
    // (post-shift the value is non-zero, so the resolver's
    // "patch on 0" guard skips it). Zero out the ImmData for
    // those symbols here so the resolver gets a clean
    // placeholder slot to fill with the linker-resolved operand.
    use crate::c5::ir::Inst;
    use crate::c5::symbol::Linkage;
    let stale_extern_offs: alloc::collections::BTreeSet<i64> = symbols
        .iter()
        .filter(|s| {
            s.class == crate::c5::token::Token::Glo as i64
                && s.is_extern_decl
                && s.linkage == Linkage::External
                && !s.defined_here
                && s.val != 0
        })
        .map(|s| s.val)
        .collect();
    if !stale_extern_offs.is_empty() {
        for func in &mut out {
            for inst in &mut func.insts {
                if let Inst::ImmData(off) = inst
                    && stale_extern_offs.contains(off)
                {
                    *off = 0;
                }
            }
        }
    }
    Ok(out)
}

fn walker_param_count(func: &FunctionSsa) -> usize {
    use crate::c5::ir::Inst;
    let mut max_seen: Option<i64> = None;
    for inst in &func.insts {
        let slot = match inst {
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } | Inst::LocalAddr(off) => {
                Some(*off)
            }
            _ => None,
        };
        if let Some(s) = slot
            && s >= 2
        {
            max_seen = Some(max_seen.map_or(s, |m| m.max(s)));
        }
    }
    match max_seen {
        Some(s) => (s - 1).max(0) as usize,
        None => 0,
    }
}

impl Compiler {
    /// Compile the source and produce a pre-link translation
    /// unit. Mirrors [`Self::compile`] but defers cross-TU
    /// resolution: external function calls / data references
    /// to symbols not defined in this unit become
    /// [`Reloc`] entries the linker will patch.
    pub fn compile_to_link_unit(mut self) -> Result<LinkUnit, C5Error> {
        if let Some(e) = self.deferred_error.take() {
            return Err(e);
        }
        self.run_compile()?;
        // Trampolines land before fixups so their ent_pcs are
        // resolved when the local fixup pass runs.
        self.emit_sys_trampolines();
        // Re-classify `extern T x;` Glo declarations whose
        // body never landed in this TU. The single-TU
        // compile() path allocates tentative storage so a
        // standalone program with `extern int a; a = 1;`
        // works without a linker; for link-unit assembly we
        // strip that tentative allocation and surface the
        // symbol as Undefined so the link step resolves
        // through the defining TU. The leftover local zeros
        // in `self.data` are unreachable post-link -- nothing
        // references them after the relocations land.
        for sym in self.symbols.iter_mut() {
            if sym.class == Token::Fun as i64 {
                // Forward function prototype with no body. Mark
                // explicitly as not-defined-here so the link
                // table emits an undefined reference.
                if sym.linkage == Linkage::External && sym.val == 0 && !sym.defined_here {
                    // Nothing to do -- already classified.
                }
            }
            if sym.class == Token::Glo as i64
                && sym.linkage == Linkage::External
                && sym.is_extern_decl
                && !sym.has_initializer
            {
                sym.defined_here = false;
                // C99 6.7.1 + 6.9.2: an `extern T x;` / `extern
                // T x[N];` with no defining initializer in this
                // TU contributes no storage. The parser-time
                // tentative slot at `sym.val` is dropped from
                // the LinkUnit symbol table (kind = Undefined
                // below), so its in-unit offset is meaningless.
                // Clear `val` here so the walker's
                // `live_glo_addr` returns `GloAddr::Extern` and
                // the address producer routes through
                // `imm_data_extern`; otherwise the dummy offset
                // would ride through as an `Inst::ImmData` with
                // no `extern_imm_data_refs` entry and the
                // linker would have nothing to patch against
                // the defining TU.
                sym.val = 0;
            }
        }

        // Partition code_relocs (data-segment function-ptr
        // slots) similarly.
        let mut local_code_relocs: Vec<crate::c5::program::CodeReloc> = Vec::new();
        let mut local_code_reloc_sym_idx: Vec<usize> = Vec::new();
        let mut data_relocs_pending: Vec<(RelocKind, u64, usize)> = Vec::new();
        let code_relocs = core::mem::take(&mut self.code_relocs);
        let code_reloc_sym_idx = core::mem::take(&mut self.code_reloc_sym_idx);
        for (reloc, sym_idx) in code_relocs.into_iter().zip(code_reloc_sym_idx) {
            let sym = &self.symbols[sym_idx];
            let is_external_undefined = sym.linkage == Linkage::External && !sym.defined_here;
            if is_external_undefined {
                data_relocs_pending.push((RelocKind::DataCodeAbs64, reloc.data_offset, sym_idx));
            } else {
                local_code_relocs.push(reloc);
                local_code_reloc_sym_idx.push(sym_idx);
            }
        }
        self.code_relocs = local_code_relocs;
        self.code_reloc_sym_idx = local_code_reloc_sym_idx;

        // Partition data_relocs (data-segment address-of-data
        // slots) similarly. Entries whose originating symbol
        // is an undefined external -- `int *p = &x;` where `x`
        // lives in another TU -- become `DataDataAbs64`
        // relocations; the rest stay as intra-unit DataReloc
        // entries that the linker re-bases by the unit's
        // data offset.
        let mut local_data_relocs: Vec<crate::c5::program::DataReloc> = Vec::new();
        let mut local_data_reloc_sym_idx: Vec<usize> = Vec::new();
        let data_relocs = core::mem::take(&mut self.data_relocs);
        let data_reloc_sym_idx = core::mem::take(&mut self.data_reloc_sym_idx);
        for (reloc, sym_idx) in data_relocs.into_iter().zip(data_reloc_sym_idx) {
            if sym_idx == usize::MAX {
                // String-literal target -- intra-unit only.
                local_data_relocs.push(reloc);
                local_data_reloc_sym_idx.push(sym_idx);
                continue;
            }
            let sym = &self.symbols[sym_idx];
            let is_external_undefined = sym.linkage == Linkage::External && !sym.defined_here;
            if is_external_undefined {
                data_relocs_pending.push((RelocKind::DataDataAbs64, reloc.data_offset, sym_idx));
            } else {
                local_data_relocs.push(reloc);
                local_data_reloc_sym_idx.push(sym_idx);
            }
        }
        self.data_relocs = local_data_relocs;
        self.data_reloc_sym_idx = local_data_reloc_sym_idx;
        // Now run the standard local-fixup pass so resolved
        // intra-TU references get their operand bytes /
        // code_reloc target_ent_pc filled in.
        self.resolve_code_relocs()?;

        // Diagnose unsupported cross-TU `_Thread_local` Glo
        // references. The walker's `extern_tls_refs` channel
        // covers fully-resolved TLS references on systems c5
        // supports today; a cross-TU reference to a
        // `_Thread_local` global requires per-target rebase
        // bookkeeping that has not landed (TODO).
        let glo_imm_refs = core::mem::take(&mut self.glo_imm_refs);
        for sym_idx in glo_imm_refs {
            let sym = &self.symbols[sym_idx];
            let is_external_undefined = sym.class == Token::Glo as i64
                && sym.linkage == Linkage::External
                && !sym.defined_here;
            if is_external_undefined && sym.is_thread_local {
                return Err(self.compile_err(alloc::format!(
                    "cross-TU references to `_Thread_local` globals \
                     are not yet supported (`{}`); declare the variable \
                     in this translation unit",
                    sym.name
                )));
            }
        }

        // Lower every parser-finished function to FunctionSsa
        // up-front so the symbol-table build below can gate
        // undefined-external entries against the walker's
        // call / ImmCode / ImmData refs. Object-file round-trips
        // ship the FunctionSsa vector verbatim, so the codegen
        // reads SSA from `user_ssa_funcs` for both fresh compiles
        // and reloads.
        let mut user_ssa_funcs = walker_funcs_for(
            &self.finished_functions,
            &self.symbols,
            &self.structs,
            self.target,
        )?;

        // Compute the set of parser-symbol indices that are
        // *referenced* by a relocation or by a walker-tier
        // extern reference. Used to gate undefined-external
        // entries: an `extern int wprintf(...)` prototype in a
        // header that the user never actually calls shouldn't
        // create an undefined link symbol -- gcc / clang ld
        // only surface a name when a real use points to it.
        let mut referenced: alloc::collections::BTreeSet<usize> =
            alloc::collections::BTreeSet::new();
        for (_, _, sym_idx) in &data_relocs_pending {
            referenced.insert(*sym_idx);
        }
        for func in &user_ssa_funcs {
            for (_, sym_idx) in &func.extern_call_refs {
                referenced.insert(*sym_idx as usize);
            }
            for (_, sym_idx) in &func.extern_imm_code_refs {
                referenced.insert(*sym_idx as usize);
            }
            for (_, sym_idx) in &func.extern_imm_data_refs {
                referenced.insert(*sym_idx as usize);
            }
            for (_, sym_idx) in &func.extern_tls_refs {
                referenced.insert(*sym_idx as usize);
            }
        }

        // Build the per-unit symbol table. Defined external /
        // internal symbols always go in (other TUs may need
        // them); undefined external symbols are emitted only
        // when something here references them, so a header
        // prototype that the user never calls leaves no trace
        // in the link table. We map parser-symbol indices
        // through `sym_remap` so the relocation list can be
        // re-indexed against the compact LinkUnit table.
        let mut sym_remap: Vec<i32> = alloc::vec![-1; self.symbols.len()];
        let mut symbols: Vec<LinkSymbol> = Vec::new();
        for (i, sym) in self.symbols.iter().enumerate() {
            if sym.linkage == Linkage::None {
                continue;
            }
            let (kind, is_def) = if sym.class == Token::Fun as i64 {
                if sym.defined_here {
                    (SymbolKind::Function, true)
                } else {
                    (SymbolKind::Undefined, false)
                }
            } else if sym.class == Token::Glo as i64 {
                if sym.defined_here {
                    if sym.is_thread_local {
                        (SymbolKind::TlsData, true)
                    } else {
                        (SymbolKind::Data, true)
                    }
                } else {
                    (SymbolKind::Undefined, false)
                }
            } else {
                // Sys / Typedef / Num etc. -- no link
                // presence.
                continue;
            };
            if !is_def && !referenced.contains(&i) {
                continue;
            }
            sym_remap[i] = symbols.len() as i32;
            let value = if matches!(kind, SymbolKind::Undefined) {
                0
            } else {
                sym.val as u64
            };
            symbols.push(LinkSymbol {
                name: sym.name.clone(),
                linkage: sym.linkage,
                kind,
                value,
                size: 0, // computed at function-body close; left informational
                type_tag: sym.type_,
            });
        }

        // Translate the pending relocation list to use the
        // compact LinkUnit symbol indices. Only the data-side
        // `DataDataAbs64` / `DataCodeAbs64` kinds survive;
        // text-side references travel through
        // `FunctionSsa::extern_*_refs`.
        let mut relocs: Vec<Reloc> = Vec::with_capacity(data_relocs_pending.len());
        for (kind, location, sym_idx) in data_relocs_pending {
            let remapped = sym_remap.get(sym_idx).copied().unwrap_or(-1);
            if remapped < 0 {
                return Err(self.compile_err(
                    "internal: data relocation refers to a symbol not surfaced in the link table",
                ));
            }
            relocs.push(Reloc {
                kind,
                location,
                sym_index: remapped as u32,
                addend: 0,
            });
        }

        // Resolve the entry name through the regular helper so
        // the link unit records whichever entry the user named
        // via `#pragma entrypoint(...)`; if no such pragma
        // appears the field stays `None` and the linker picks
        // an entry from the merged symbol table.
        let entry_name = self.pp_entrypoint.clone();
        let exports = core::mem::take(&mut self.pending_exports)
            .into_iter()
            .map(|name| crate::c5::program::ExportedFunction { name, ent_pc: 0 })
            .collect::<Vec<_>>();
        // Resolve each export's ent_pc against the now-
        // finalised symbol table. Mirrors `resolve_exports`.
        let mut resolved_exports = Vec::with_capacity(exports.len());
        for e in exports {
            let Some(idx) =
                crate::c5::lexer::find_symbol(&self.symbols, &self.symbol_index, &e.name)
            else {
                return Err(self.compile_err(alloc::format!(
                    "`#pragma export({})` -- no such symbol; the name must \
                     refer to a function defined in this source",
                    e.name
                )));
            };
            if self.symbols[idx].class != Token::Fun as i64 {
                return Err(self.compile_err(alloc::format!(
                    "`#pragma export({})` -- expected a function",
                    e.name
                )));
            }
            resolved_exports.push(crate::c5::program::ExportedFunction {
                name: e.name,
                ent_pc: self.symbols[idx].val as usize,
            });
        }

        // DllMain: if a user-defined DllMain function is in
        // scope, record its ent_pc.
        let dllmain_pc = crate::c5::lexer::find_symbol(
            &self.symbols,
            &self.symbol_index,
            "DllMain",
        )
        .and_then(|idx| {
            if self.symbols[idx].class == Token::Fun as i64 && self.symbols[idx].defined_here {
                Some(self.symbols[idx].val as usize)
            } else {
                None
            }
        });

        // Remap each FunctionSsa's `extern_call_refs` sym_idx
        // from the parser-symbol space to the compact LinkUnit
        // symbol space via `sym_remap`. The linker later
        // resolves the LinkSymbol through the merged symbol map
        // and patches `Inst::Call::target_pc`. Entries whose
        // remap is -1 (the symbol was filtered out of the
        // LinkUnit table) are dropped; this can only happen if
        // the parser recorded the extern reference but no
        // relocation anchored the symbol, which itself would be
        // a walker / parser drift caught by the resolver.
        for func in &mut user_ssa_funcs {
            let remap = |refs: &mut alloc::vec::Vec<(u32, u32)>| {
                refs.retain_mut(|(_, sym_idx)| {
                    let remapped = sym_remap.get(*sym_idx as usize).copied().unwrap_or(-1);
                    if remapped < 0 {
                        return false;
                    }
                    *sym_idx = remapped as u32;
                    true
                });
            };
            remap(&mut func.extern_call_refs);
            remap(&mut func.extern_imm_code_refs);
            remap(&mut func.extern_imm_data_refs);
            remap(&mut func.extern_tls_refs);
        }

        Ok(LinkUnit {
            data: self.data,
            tls_data: self.tls_data,
            tls_init_size: self.tls_init_size,
            source_files: self.source_files,
            variables: self.variables,
            data_relocs: self.data_relocs,
            code_relocs: self.code_relocs,
            dylibs: self.dylibs,
            structs: self.structs,
            enums: self.enums,
            exports: resolved_exports,
            dllmain_pc,
            entry_name,
            subsystem: self.pp_subsystem,
            source_path: String::new(),
            warnings: self.warnings,
            symbols,
            relocs,
            finished_functions: self.finished_functions,
            parser_symbols: self.symbols,
            synthetic_ssa_funcs: self.synthetic_ssa_funcs,
            user_ssa_funcs,
        })
    }
}
