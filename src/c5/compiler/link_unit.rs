//! Convert a finished [`Compiler`] (parsed source + emitted
//! bytecode) into a [`LinkUnit`] suitable for cross-TU linking.
//!
//! Live only under the `linker` feature -- single-TU consumers
//! get the existing `compile() -> Program` path unchanged.
//!
//! Three behaviours diverge from a regular [`Compiler::compile`]:
//!
//!   1. `fn_call_fixups` entries whose target symbol is an
//!      undefined extern become [`Reloc`]s instead of having
//!      their operand bytes overwritten with `0`. Locally-
//!      defined targets resolve in place the same way they
//!      do today.
//!   2. `code_relocs` / `code_reloc_sym_idx` entries whose
//!      target is an undefined extern become
//!      `RelocKind::DataCodeAbs64` relocations -- their
//!      `target_bc_pc` field would otherwise be left at `0`.
//!   3. `glo_imm_refs` entries (recorded at every `Op::Imm
//!      <data_offset>` emit for a `Token::Glo` symbol) whose
//!      target is an undefined extern become
//!      `RelocKind::ImmDataAddr` relocations; the operand
//!      bytes already in `self.text` are kept at `0` so the
//!      linker's patch lands on a clean slot.
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
use crate::c5::op::Op;
use crate::c5::symbol::{Linkage, Symbol};
use crate::c5::token::Token;

fn walker_funcs_for(
    finished: &[FinishedFunction],
    symbols: &[Symbol],
    structs: &[super::StructDef],
    target: Target,
    text_len: usize,
) -> Result<Vec<FunctionSsa>, C5Error> {
    let mut out = Vec::with_capacity(finished.len());
    for f in finished {
        let mut func = crate::c5::ast::walk::walk_function(
            &f.ast,
            symbols,
            structs,
            target,
            f.ent_pc,
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
    // them here, the linker's per-unit `data_off` shift plus
    // the merge's resolver-from-bytecode patch loop both miss
    // the case (post-shift the value is non-zero, so the
    // resolver's "patch on 0" guard skips it). Zero out the
    // ImmData for those symbols here so the resolver gets a
    // clean placeholder slot to fill with the linker-resolved
    // operand.
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
    // SsaBuilder seeds end_pc at ent_pc; the walker has no
    // way to know where the function's bytecode body ends. In
    // a sorted-by-ent_pc list the next function's ent_pc is
    // the current one's end_pc; the trailing entry runs up to
    // `text_len`. Mirrors what `lift_program` already sets.
    let n = out.len();
    for i in 0..n {
        let end = if i + 1 < n {
            out[i + 1].ent_pc
        } else {
            text_len
        };
        out[i].end_pc = end;
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
        // Trampolines land before fixups so their bc_pcs are
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
            }
        }

        // Partition fn_call_fixups: locally-defined targets
        // keep the existing apply_fn_call_fixups behaviour;
        // undefined externals become relocations.
        let mut local_fn_fixups: Vec<(usize, usize)> = Vec::new();
        let mut text_relocs: Vec<(RelocKind, u64, usize)> = Vec::new();
        // Take the fixup list so we can hand the "local"
        // subset back to apply_fn_call_fixups.
        let fn_fixups = core::mem::take(&mut self.fn_call_fixups);
        for (operand_pc, sym_idx) in fn_fixups {
            let sym = &self.symbols[sym_idx];
            let is_external_undefined = sym.linkage == Linkage::External && !sym.defined_here;
            if is_external_undefined {
                // The preceding word distinguishes a Jsr call
                // from a function-pointer literal (`Op::Imm`).
                // Mirrors the bias-decision in
                // apply_fn_call_fixups.
                let prev_op = if operand_pc >= 1 {
                    self.text[operand_pc - 1]
                } else {
                    0
                };
                let kind = if prev_op == Op::Imm as i64 {
                    RelocKind::ImmCodeAddr
                } else {
                    RelocKind::JsrPc
                };
                // Clear the operand slot so the linker patches
                // a clean zero. `apply_fn_call_fixups` skipped
                // it; without zeroing, the stale forward-decl
                // placeholder (typically `0`) would still be
                // there, which is harmless but easier to debug
                // when explicit.
                self.text[operand_pc] = 0;
                text_relocs.push((kind, operand_pc as u64, sym_idx));
            } else {
                local_fn_fixups.push((operand_pc, sym_idx));
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
        self.fn_call_fixups = local_fn_fixups;

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
        // code_reloc target_bc_pc filled in.
        self.apply_fn_call_fixups()?;

        // glo_imm_refs: external Glo references become
        // ImmDataAddr relocations; defined-locally entries
        // need no fixup (the operand already holds `val`).
        //
        // The push to `glo_imm_refs` happens at parse time when
        // the symbol's class / val reflect the inner-scope binding;
        // by the time we iterate here, block_symbols restoration
        // has rolled class / val back to the outer scope. C99
        // 6.2.1p4 lets an inner-scope `static T arr[];` shadow an
        // outer file-scope declaration of the same name, including
        // one whose outer class is `Token::Fun` (a function
        // prototype). After restore the symbol's class returns to
        // the outer Token::Fun even though the operand at
        // `operand_pc` already encodes the static-local's data
        // offset. Filter on `sym.class == Token::Glo` so the reloc
        // only fires for genuine cross-TU global references that
        // survived the restore.
        let glo_imm_refs = core::mem::take(&mut self.glo_imm_refs);
        for (operand_pc, sym_idx) in glo_imm_refs {
            let sym = &self.symbols[sym_idx];
            let is_external_undefined = sym.class == Token::Glo as i64
                && sym.linkage == Linkage::External
                && !sym.defined_here;
            if is_external_undefined {
                if sym.is_thread_local {
                    return Err(self.compile_err(alloc::format!(
                        "cross-TU references to `_Thread_local` globals \
                         are not yet supported (`{}`); declare the variable \
                         in this translation unit",
                        sym.name
                    )));
                }
                // Operand was emitted with the tentative-storage
                // offset; clear it so the linker resolves to the
                // defining unit instead of this unit's placeholder.
                self.text[operand_pc] = 0;
                text_relocs.push((RelocKind::ImmDataAddr, operand_pc as u64, sym_idx));
            }
        }

        // Compute the set of parser-symbol indices that are
        // *referenced* by a relocation. Used to gate undefined-
        // external entries: an `extern int wprintf(...)`
        // prototype in a header that the user never actually
        // calls shouldn't create an undefined link symbol --
        // gcc / clang ld only surface a name when a real use
        // points to it.
        let mut referenced: alloc::collections::BTreeSet<usize> =
            alloc::collections::BTreeSet::new();
        for (_, _, sym_idx) in &text_relocs {
            referenced.insert(*sym_idx);
        }
        for (_, _, sym_idx) in &data_relocs_pending {
            referenced.insert(*sym_idx);
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
        // compact LinkUnit symbol indices.
        let mut relocs: Vec<Reloc> =
            Vec::with_capacity(text_relocs.len() + data_relocs_pending.len());
        for (kind, location, sym_idx) in text_relocs {
            let remapped = sym_remap.get(sym_idx).copied().unwrap_or(-1);
            if remapped < 0 {
                return Err(self.compile_err(alloc::format!(
                    "internal: relocation refers to a symbol not surfaced in the link table \
                     (sym idx {sym_idx})"
                )));
            }
            // For text-operand relocations, `location` is the
            // i64 word index (`operand_pc`). Stored verbatim
            // in `Reloc::location`.
            relocs.push(Reloc {
                kind,
                location,
                sym_index: remapped as u32,
                addend: 0,
            });
        }
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
            .map(|name| crate::c5::program::ExportedFunction {
                name,
                bytecode_pc: 0,
            })
            .collect::<Vec<_>>();
        // Resolve each export's bytecode PC against the now-
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
                bytecode_pc: self.symbols[idx].val as usize,
            });
        }

        // DllMain: if a user-defined DllMain function is in
        // scope, record its bytecode PC.
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

        // Eagerly lower every parser-finished function to
        // FunctionSsa so the resulting LinkUnit carries SSA
        // directly. The bytecode-side lift survives only for
        // unit reloads whose user_ssa_funcs arrived empty
        // (older .o files); once every .o producer is updated,
        // lift_program retires.
        let mut user_ssa_funcs = walker_funcs_for(
            &self.finished_functions,
            &self.symbols,
            &self.structs,
            self.target,
            self.text.len(),
        )?;

        // Remap each FunctionSsa's `extern_call_refs` sym_idx
        // from the parser-symbol space to the compact LinkUnit
        // symbol space via `sym_remap`. The linker later
        // resolves the LinkSymbol through the merged symbol map
        // and patches `Inst::Call::target_pc` without the
        // bytecode-tape order-zip. Entries whose remap is -1
        // (the symbol was filtered out of the LinkUnit table)
        // are dropped; this can only happen if the parser
        // recorded the extern reference but no relocation
        // anchored the symbol, which itself would be a
        // walker / parser drift caught by the resolver.
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
            text: self.text,
            data: self.data,
            tls_data: self.tls_data,
            tls_init_size: self.tls_init_size,
            data_imm_positions: self.data_imm_positions,
            code_imm_positions: self.code_imm_positions,
            source_lines: self.source_lines,
            source_functions: self.source_functions,
            source_files: self.source_files,
            source_file_indices: self.source_file_indices,
            variables: self.variables,
            data_relocs: self.data_relocs,
            code_relocs: self.code_relocs,
            dylibs: self.dylibs,
            structs: self.structs,
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
