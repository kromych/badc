use super::*;

/// Branch placeholder recorded mid-walk; resolved once every block's start
/// offset is known.
#[derive(Debug, Clone, Copy)]
pub(super) struct BranchFixup {
    /// Byte offset in `code` of the placeholder instruction.
    pub(super) site: usize,
    /// Target block in the function's `blocks` table.
    pub(super) target: BlockId,
    pub(super) kind: LocalBranchKind,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum LocalBranchKind {
    /// Unconditional B; `imm26` field, +/-128 MiB reach.
    B,
    /// CBZ Xt, label.
    Cbz(Reg),
    /// CBNZ Xt, label.
    Cbnz(Reg),
    /// B.cond label.
    Bcc(Cond),
}

impl LocalBranchKind {
    /// The branch word for the word displacement `imm`, or `None` when the
    /// displacement is outside the form's immediate field.
    fn word(self, imm: i32) -> Option<u32> {
        let bits = match self {
            LocalBranchKind::B => 26,
            _ => 19,
        };
        if !(-(1 << (bits - 1))..(1 << (bits - 1))).contains(&imm) {
            return None;
        }
        Some(match self {
            LocalBranchKind::B => enc_b(imm),
            LocalBranchKind::Cbz(rt) => enc_cbz(rt, imm),
            LocalBranchKind::Cbnz(rt) => enc_cbnz(rt, imm),
            LocalBranchKind::Bcc(cond) => enc_b_cond(cond, imm),
        })
    }
}

/// Lengths of the output tables at function entry. A bailed emit truncates
/// every table back to them, so queued fixups never point into discarded
/// code.
struct EmitSnapshot {
    code: usize,
    fixups: usize,
    plt_call_fixups: usize,
    data_fixups: usize,
    user_extern_data_refs: usize,
    asm_extern_call_sites: usize,
    asm_sym_fixups: usize,
    /// The section sink merges by name, so it restores full per-section
    /// state rather than a length.
    asm_sections: crate::c5::asm::AsmSectionsSnapshot,
    pending_func_fixups: usize,
    tls_index_fixups: usize,
    macho_tlv_fixups: usize,
    macho_tlv_descriptors: usize,
    elf_tpoff_fixups: usize,
}

/// The state of one function's emission: the output tables, the read-only
/// inputs bundled as the per-instruction context, and the sites that resolve
/// once every block is laid out.
struct FunctionEmitter<'a, 'b> {
    cx: &'a mut super::ssa::emit_common::EmitCtx<'b>,
    fixups: &'a mut Vec<Fixup>,
    macho_tlv_fixups: &'a mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &'a mut Vec<super::MachoTlvDescriptor>,
    asm_text_labels: &'a mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &'a mut Vec<super::AsmSectionTextRef>,
    text_map_state: &'a mut Option<super::super::map_syms::MapClass>,
    rodata: &'a mut super::RodataBuild,
    fcx: FnCtx<'a>,
    abs_jump_tables: bool,
    entry: super::FunctionEntry,
    snapshot: EmitSnapshot,
    block_offsets: Vec<usize>,
    branch_fixups: Vec<BranchFixup>,
    /// Template `%lK` branches that reach their label's block with no
    /// operand frame in the way; encoded against `block_offsets`.
    direct_goto_branches: Vec<AsmGotoDirectBranch>,
    /// `Inst::BlockAddr` sites: `(site, target_block, rd)` of each `ADR`
    /// placeholder.
    block_addr_fixups: Vec<(usize, BlockId, Reg)>,
    /// `(table_start, table_idx)` per `Terminator::JumpTable`.
    jump_table_fixups: Vec<(usize, u32)>,
    /// ALTERNATIVE `.subsection` replacements, appended after the body.
    deferred_regions: Vec<DeferredAsmRegion>,
}

/// Lower one function. Returns `true` when every block, instruction and
/// terminator was lowered; `false` leaves `cx` as it was on entry, and the
/// caller turns that into a compile error.
///
/// `fixups` is the function-pointer / direct-call fixup table the
/// surrounding writer maintains; the emit appends one `Fixup::Bl` per
/// `Inst::Call` for the `apply_fixups` post-pass.
#[allow(clippy::too_many_arguments)]
pub(crate) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    cx: &mut super::ssa::emit_common::EmitCtx,
    fixups: &mut Vec<Fixup>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    macho_tlv_fixups: &mut Vec<super::MachoTlvFixup>,
    macho_tlv_descriptors: &mut Vec<super::MachoTlvDescriptor>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    data_sym_offsets: &alloc::collections::BTreeMap<alloc::string::String, i64>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    // The mapping state spans the section: a body ending in data leaves the
    // padding to the next function's first instruction, as under GNU as.
    text_map_state: &mut Option<super::super::map_syms::MapClass>,
    no_fp_regs: bool,
    strict_align: bool,
    rodata: &mut super::RodataBuild,
    abs_jump_tables: bool,
    hardening: super::Hardening,
    stack_protect: super::StackProtect,
    entry: super::FunctionEntry,
    fixed_regs: super::FixedRegs,
) -> Emit {
    let abi = {
        let mut a = target.abi();
        a.no_fp_varargs = no_fp_regs;
        a.strict_align = strict_align;
        a.hardening = hardening;
        a.stack_protect = stack_protect;
        a.fixed_regs = fixed_regs;
        a
    };
    if let Some(bytes) = super::ssa::emit_common::locals_bytes_over_limit(func) {
        return fail(super::ssa::emit_common::frame_too_large_msg(bytes));
    }
    let frame = compute_frame(func, alloc, abi, target);
    if let Some(why) = super::ssa::reg_alloc::fp_scratch_shortfall(func, frame.fp_scratch) {
        return fail(why);
    }
    if frame.canary_bytes > 0 {
        cx.canary_frame_bytes
            .insert(func.ent_pc, frame.canary_bytes);
    }
    if frame.frame_bytes > super::ssa::emit_common::MAX_FRAME_BYTES {
        return fail(super::ssa::emit_common::frame_too_large_msg(
            frame.frame_bytes as i64,
        ));
    }
    let scratch = ScratchPool::new();
    let param_plan = param_placements(func, abi);
    let snapshot = EmitSnapshot {
        code: cx.code.len(),
        fixups: fixups.len(),
        plt_call_fixups: cx.plt_call_fixups.len(),
        data_fixups: cx.data_fixups.len(),
        user_extern_data_refs: cx.user_extern_data_refs.len(),
        asm_extern_call_sites: cx.asm_extern_call_sites.len(),
        asm_sym_fixups: cx.asm_sym_fixups.len(),
        asm_sections: cx.asm_sections.snapshot(),
        pending_func_fixups: cx.pending_func_fixups.len(),
        tls_index_fixups: cx.tls_index_fixups.len(),
        macho_tlv_fixups: macho_tlv_fixups.len(),
        macho_tlv_descriptors: macho_tlv_descriptors.len(),
        elf_tpoff_fixups: cx.elf_tpoff_fixups.len(),
    };
    let mut em = FunctionEmitter {
        cx,
        fixups,
        macho_tlv_fixups,
        macho_tlv_descriptors,
        asm_text_labels,
        asm_section_text_refs,
        text_map_state,
        rodata,
        fcx: FnCtx {
            func,
            alloc,
            frame,
            scratch: &scratch,
            abi,
            target,
            imports,
            variadic_targets,
            extern_tls_names,
            extern_data_names,
            param_plan: &param_plan,
            name2entpc,
            data_sym_offsets,
        },
        abs_jump_tables,
        entry,
        snapshot,
        block_offsets: alloc::vec![0; func.blocks.len()],
        branch_fixups: Vec::new(),
        direct_goto_branches: Vec::new(),
        block_addr_fixups: Vec::new(),
        jump_table_fixups: Vec::new(),
        deferred_regions: Vec::new(),
    };
    em.emit_entry();
    let mut prebatched: Vec<bool> = alloc::vec![false; func.insts.len()];
    em.place_int_params(&mut prebatched)?;
    em.place_fp_params(&mut prebatched);
    em.emit_blocks(&prebatched)?;
    em.resolve_layout()
}

/// Whether no two parameter homes name the same location, which is what
/// makes the entry placement a parallel copy.
fn homes_distinct(homes: &[Place]) -> bool {
    (0..homes.len()).all(|a| ((a + 1)..homes.len()).all(|b| !place_same_loc(homes[a], homes[b])))
}

impl FunctionEmitter<'_, '_> {
    /// Discard everything this function emitted and queued, and return `e`
    /// as the emit's result.
    fn rollback<T>(&mut self, e: Unsupported) -> Emit<T> {
        let s = &self.snapshot;
        self.cx.code.truncate(s.code);
        self.fixups.truncate(s.fixups);
        self.cx.plt_call_fixups.truncate(s.plt_call_fixups);
        self.cx.data_fixups.truncate(s.data_fixups);
        self.cx
            .user_extern_data_refs
            .truncate(s.user_extern_data_refs);
        self.cx
            .asm_extern_call_sites
            .truncate(s.asm_extern_call_sites);
        self.cx.asm_sym_fixups.truncate(s.asm_sym_fixups);
        self.cx.asm_sections.restore(&s.asm_sections);
        self.cx.pending_func_fixups.truncate(s.pending_func_fixups);
        self.cx.tls_index_fixups.truncate(s.tls_index_fixups);
        self.cx.elf_tpoff_fixups.truncate(s.elf_tpoff_fixups);
        self.macho_tlv_fixups.truncate(s.macho_tlv_fixups);
        self.macho_tlv_descriptors.truncate(s.macho_tlv_descriptors);
        Err(e)
    }

    fn align_stream(&mut self) {
        a64_align_asm_stream(self.cx.code, self.cx.text_data_ranges, self.text_map_state);
    }

    fn patch_word(&mut self, site: usize, word: u32) {
        self.cx.code[site..site + 4].copy_from_slice(&word.to_le_bytes());
    }

    fn push_branch(&mut self, target: BlockId, kind: LocalBranchKind) {
        self.branch_fixups.push(BranchFixup {
            site: self.cx.code.len(),
            target,
            kind,
        });
    }

    /// Branch to `target` unless it is the next block in layout order.
    fn branch_unless_next(&mut self, block_idx: usize, target: BlockId) {
        if target as usize != block_idx + 1 {
            self.push_branch(target, LocalBranchKind::B);
            emit(self.cx.code, enc_b(0));
        }
    }

    /// The landing pad, patchable-entry NOPs, return-address signing and the
    /// prologue. A naked function's inline-asm body is the whole function,
    /// so it takes only the NOPs.
    fn emit_entry(&mut self) {
        let FnCtx {
            func,
            alloc,
            frame,
            abi,
            ..
        } = self.fcx;
        let signs = signs_return_address(func, frame, alloc, abi);
        if !func.is_naked {
            // The entry pays any realignment a preceding body left owing and
            // keeps the offset it was placed at, as a label does under GNU as.
            self.align_stream();
            // A function entry is reachable by `BLR` and by a `BR` through
            // x16/x17, so it takes a `BTI C`; `PACIASP` accepts both BTYPEs
            // itself and stands in for the pad where it is the first
            // instruction.
            if abi.hardening.bti && (self.entry.nops_after > 0 || !signs) {
                emit(self.cx.code, super::encode::BTI_C);
            }
        }
        // The `-fpatchable-function-entry` NOPs follow the landing pad and
        // precede the rest of the entry, as gcc orders them.
        for _ in 0..self.entry.nops_after {
            emit(self.cx.code, super::encode::NOP);
        }
        if !func.is_naked {
            if signs {
                emit(self.cx.code, super::encode::PACIASP);
            }
            emit_prologue(
                self.cx.code,
                func,
                alloc,
                frame,
                abi,
                self.cx.user_extern_data_refs,
            );
        }
        super::ssa::emit_common::record_post_prologue_pc(
            func,
            self.cx.prologue_native,
            self.cx.code.len(),
        );
    }

    /// Place the integer `Inst::ParamRef` values from their argument
    /// registers into the allocator's homes as one parallel copy, so no home
    /// clobbers a later parameter's incoming register. Applies only when the
    /// homes are distinct; otherwise `emit_inst` places each in program order,
    /// which the allocator's self-home hint keeps sound
    /// (`param-shuffle-clobber` in `verify_allocation`).
    fn place_int_params(&mut self, prebatched: &mut [bool]) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            scratch,
            param_plan,
            ..
        } = self.fcx;
        let mut moves: Vec<(Place, Place)> = Vec::new();
        let mut exts: Vec<(Place, LoadKind)> = Vec::new();
        let mut vids: Vec<usize> = Vec::new();
        let mut homes: Vec<Place> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc)
            {
                continue;
            }
            let dst = place_of(alloc, vid as u32);
            if !matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
                continue;
            }
            // A stack-passed integer parameter has no register source and
            // stays on the per-inst home-cell path.
            let Some(super::ArgPlacement::IntReg(src)) = param_plan.get(*idx as usize).copied()
            else {
                continue;
            };
            moves.push((Place::IntReg(src), dst));
            vids.push(vid);
            homes.push(dst);
            // The caller passes the raw 64-bit value; the callee performs the
            // C99 6.5.2.2p4 conversion. An I32 extend touches only bits
            // 32..63 and is skipped when no consumer reads them.
            if matches!(kind, LoadKind::I8 | LoadKind::I16)
                || (matches!(kind, LoadKind::I32)
                    && alloc.high_observed.get(vid).copied().unwrap_or(true))
            {
                exts.push((dst, *kind));
            }
        }
        if moves.is_empty() || !homes_distinct(&homes) {
            return Ok(());
        }
        let code = &mut *self.cx.code;
        schedule_place_moves(code, &mut moves, frame, scratch.primary, scratch.secondary)?;
        for (dst, kind) in exts {
            let ext = |code: &mut Vec<u8>, r: Reg| match kind {
                LoadKind::I8 => emit(code, super::encode::enc_sxtb(r, r)),
                LoadKind::I16 => emit(code, super::encode::enc_sxth(r, r)),
                LoadKind::I32 => emit(code, super::encode::enc_sxtw(r, r)),
                _ => {}
            };
            match dst {
                Place::IntReg(r) => ext(code, Reg(r)),
                Place::Spill(slot) => {
                    let sp_off = spill_off(frame, slot);
                    emit_spill_ldr_x(code, frame, scratch.primary, sp_off);
                    ext(code, scratch.primary);
                    emit_spill_str_x(code, frame, scratch.primary, sp_off, scratch.secondary);
                }
                Place::None | Place::FpReg(_) => {}
            }
        }
        for vid in vids {
            prebatched[vid] = true;
        }
        Ok(())
    }

    /// The floating-point counterpart of [`Self::place_int_params`]: the
    /// FP scratch breaks cycles in the d-register bank.
    fn place_fp_params(&mut self, prebatched: &mut [bool]) {
        let FnCtx {
            func,
            alloc,
            frame,
            param_plan,
            ..
        } = self.fcx;
        let mut fp_moves: Vec<(Place, Place)> = Vec::new();
        let mut fp_vids: Vec<usize> = Vec::new();
        let mut fp_homes: Vec<Place> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            if !matches!(kind, LoadKind::F32 | LoadKind::F64) {
                continue;
            }
            if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc)
            {
                continue;
            }
            let dst = place_of(alloc, vid as u32);
            if !matches!(dst, Place::FpReg(_) | Place::Spill(_)) {
                continue;
            }
            let Some(super::ArgPlacement::FpReg(src)) = param_plan.get(*idx as usize).copied()
            else {
                continue;
            };
            fp_moves.push((Place::FpReg(src), dst));
            fp_vids.push(vid);
            fp_homes.push(dst);
        }
        if fp_moves.is_empty() || !homes_distinct(&fp_homes) {
            return;
        }
        super::ssa::emit_common::schedule_fp_place_moves(
            &super::ssa::emit_common::Aarch64Backend,
            self.cx.code,
            &mut fp_moves,
            frame,
            17,
            16,
        );
        for vid in fp_vids {
            prebatched[vid] = true;
        }
    }

    /// Walk the blocks in layout order: each block's landing pad,
    /// instructions, phi moves and terminator.
    fn emit_blocks(&mut self, prebatched: &[bool]) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            scratch,
            abi,
            ..
        } = self.fcx;
        // Blocks a `BR` can reach take a `BTI J` at their head, ahead of
        // the offset every branch fixup resolves to.
        let bti_targets = if abi.hardening.bti {
            super::super::indirect_branch_target_blocks(func)
        } else {
            alloc::collections::BTreeSet::new()
        };
        for (block_idx, block) in func.blocks.iter().enumerate() {
            let bti = bti_targets.contains(&(block_idx as BlockId));
            if bti {
                self.align_stream();
            }
            self.block_offsets[block_idx] = self.cx.code.len();
            super::ssa::emit_common::record_block_start_pc(
                block_idx,
                block.start_pc,
                self.cx.pc_to_native,
                self.cx.code.len(),
            );
            if bti {
                emit(self.cx.code, super::encode::BTI_J);
            }
            for v in block.inst_range.clone() {
                self.emit_block_inst(block, v, prebatched)?;
            }
            // The phi moves and the terminator are instructions, except for
            // a naked function's synthetic return, which emits nothing.
            if !(func.is_naked && matches!(block.terminator, Terminator::Return(_))) {
                self.align_stream();
            }
            if let Err(e) = emit_phi_predecessor_moves(
                self.cx.code,
                block_idx as super::super::ir::BlockId,
                func,
                alloc,
                scratch,
                frame,
            ) {
                return self.rollback(e);
            }
            self.emit_terminator(block_idx, block)?;
        }
        Ok(())
    }

    /// Lower instruction `v` of `block`, or skip it: a naked function keeps
    /// only its inline asm, a pure value nobody reads produces no code, and
    /// a `ParamRef` the entry batch placed is done.
    fn emit_block_inst(
        &mut self,
        block: &super::super::ir::Block,
        v: super::super::ir::ValueId,
        prebatched: &[bool],
    ) -> Emit {
        let FnCtx { func, alloc, .. } = self.fcx;
        let inst = &func.insts[v as usize];
        let place = place_of(alloc, v);
        if func.is_naked && !matches!(inst, Inst::InlineAsm { .. }) {
            return Ok(());
        }
        if super::ssa::emit_common::is_dead_pure(inst, v, alloc) {
            return Ok(());
        }
        if prebatched[v as usize] {
            return Ok(());
        }
        // An inline-asm block takes the mapping state itself.
        if !matches!(inst, Inst::InlineAsm { .. }) {
            self.align_stream();
        }
        super::ssa::emit_common::record_inst_src(
            func,
            v,
            self.cx.code.len(),
            self.cx.ssa_line_rows,
        );
        // The two forms that resolve against this function's block layout
        // are lowered here, where the fixup tables live.
        if let Inst::BlockAddr(tb) = inst {
            return self.emit_block_addr(v, place, *tb);
        }
        if let Inst::InlineAsm { asm, args } = inst
            && let Terminator::AsmGoto { table } = block.terminator
        {
            return self.emit_asm_goto(asm, args, table);
        }
        let data_fixups_pre_inst = self.cx.data_fixups.len();
        let lowered = emit_inst(
            self.cx,
            inst,
            v,
            place,
            &self.fcx,
            self.fixups,
            self.macho_tlv_fixups,
            self.macho_tlv_descriptors,
            &mut self.deferred_regions,
            self.text_map_state,
            self.asm_text_labels,
            self.asm_section_text_refs,
        );
        if let Err(e) = lowered {
            #[cfg(feature = "codegen_test")]
            if std::env::var("BADC_DUMP_SSA").is_ok() {
                eprintln!(
                    "ssa emit: bailed on inst v{v}: {:?} (place {:?})",
                    inst, place,
                );
            }
            return self.rollback(e);
        }
        // An `Inst::ImmData` naming a cross-TU object replaces its unit-local
        // `.data` fixup with a named reference, so the ET_REL writer emits an
        // undefined-data symbol and a relocation against it.
        if let Inst::ImmData(_) = inst
            && let Some(name) = self.fcx.extern_data_names.get(&v)
            && self.cx.data_fixups.len() > data_fixups_pre_inst
        {
            let popped = self.cx.data_fixups.pop().unwrap();
            self.cx
                .user_extern_data_refs
                .push(super::UserExternDataRef {
                    instr_offset: popped.instr_offset,
                    symbol_name: name.clone(),
                    direct_pcrel: None,
                });
        }
        Ok(())
    }

    /// GCC `&&label`: an `ADR rd, .` placeholder, patched against the block's
    /// final offset by [`Self::patch_block_addrs`].
    fn emit_block_addr(
        &mut self,
        v: super::super::ir::ValueId,
        place: Place,
        target: BlockId,
    ) -> Emit {
        let FnCtx { frame, scratch, .. } = self.fcx;
        let Some(rd) = int_or_spill_scratch(place, scratch) else {
            return self.rollback(bail("BlockAddr: dst not int reg / spill", v, place));
        };
        let code = &mut *self.cx.code;
        let adr_site = code.len();
        emit(code, enc_adr(rd, 0));
        self.block_addr_fixups.push((adr_site, target, rd));
        store_spilled_int(code, frame, place, rd);
        Ok(())
    }

    /// `asm goto`: the label branches patch against block offsets through
    /// this function's fixup lists, which `emit_inst` has no access to.
    fn emit_asm_goto(
        &mut self,
        asm: &super::super::ir::AsmBlock,
        args: &[u32],
        table: u32,
    ) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            name2entpc,
            extern_data_names,
            data_sym_offsets,
            ..
        } = self.fcx;
        let lowered = emit_inline_asm_aarch64(
            self.cx.code,
            asm,
            args,
            func,
            alloc,
            frame,
            self.fixups,
            name2entpc,
            extern_data_names,
            data_sym_offsets,
            self.cx.asm_sections,
            self.cx.asm_extern_call_sites,
            self.cx.asm_sym_fixups,
            &mut self.deferred_regions,
            self.cx.text_data_ranges,
            self.cx.text_align,
            self.text_map_state,
            self.asm_text_labels,
            self.asm_section_text_refs,
            Some(AsmGotoCtxA64 {
                row: &func.jump_tables[table as usize],
                branch_fixups: &mut self.branch_fixups,
                direct_goto: &mut self.direct_goto_branches,
            }),
        );
        if let Err(e) = lowered {
            return self.rollback(e);
        }
        Ok(())
    }

    fn emit_terminator(&mut self, block_idx: usize, block: &super::super::ir::Block) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            scratch,
            abi,
            imports,
            ..
        } = self.fcx;
        match block.terminator {
            // A naked function's inline-asm body provides its own return.
            Terminator::Return(_) if func.is_naked => {}
            Terminator::Return(v) => emit_return(
                self.cx.code,
                v,
                alloc,
                frame,
                scratch,
                func,
                abi,
                self.cx.asm_extern_call_sites,
                self.cx.user_extern_data_refs,
            ),
            Terminator::Jmp(t) | Terminator::FallThrough(t) => {
                self.branch_unless_next(block_idx, t)
            }
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => return self.emit_cond_branch(block_idx, cond, target, fall_through, true),
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => return self.emit_cond_branch(block_idx, cond, target, fall_through, false),
            // GCC computed goto: `br` through the address `Inst::BlockAddr`
            // materialized.
            Terminator::GotoIndirect { target } => {
                let tplace = place_of(alloc, target);
                let Some(rt) = materialize_int(self.cx.code, tplace, scratch.primary, frame) else {
                    return self.rollback(bail(
                        "GotoIndirect: target Place not int",
                        target,
                        tplace,
                    ));
                };
                emit(self.cx.code, enc_br(rt));
            }
            Terminator::JumpTable { idx, table } => return self.emit_jump_table(idx, table),
            // The label branches were lowered inside the `Inst::InlineAsm`;
            // only the fall-through edge (row entry 0) is emitted here.
            Terminator::AsmGoto { table } => {
                let fall = func.jump_tables[table as usize][0];
                self.branch_unless_next(block_idx, fall);
            }
            // Tail-jump through the GOT-patched trampoline; the writer fills
            // the adrp / ldr immediates once the target's RVA is final.
            Terminator::TailExt(binding_idx) => {
                let Some(import_index) = imports.index_of_binding(binding_idx) else {
                    return self.rollback(unsupported("TailExt: no import slot for binding"));
                };
                super::encode::emit_got_tail_jump(
                    self.cx.code,
                    self.cx.plt_call_fixups,
                    import_index,
                );
            }
            // Sealed after a noreturn call (C11 6.7.4p8): a trap, so a
            // mis-marked returning call faults rather than falling into the
            // next block.
            Terminator::Unreachable => emit(self.cx.code, 0xD420_0020), // brk #1
        }
        Ok(())
    }

    /// `Bz` (`negate`) and `Bnz`: a `B.cond` off the fused comparison's
    /// flags, else a `CBZ` / `CBNZ` on the condition's 64-bit bit pattern.
    /// An FP-placed condition is read through `fmov x, d` for that.
    fn emit_cond_branch(
        &mut self,
        block_idx: usize,
        cond: super::super::ir::ValueId,
        target: BlockId,
        fall_through: BlockId,
        negate: bool,
    ) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            scratch,
            ..
        } = self.fcx;
        if let Some(bcc) = fused_branch_cond(func, alloc, cond, negate) {
            self.push_branch(target, LocalBranchKind::Bcc(bcc));
            emit(self.cx.code, enc_b_cond(bcc, 0));
            self.branch_unless_next(block_idx, fall_through);
            return Ok(());
        }
        let cond_place = place_of(alloc, cond);
        let rt = if let Place::FpReg(dr) = cond_place {
            emit(self.cx.code, enc_fmov_d_to_x(scratch.primary, dr));
            scratch.primary
        } else {
            match materialize_int(self.cx.code, cond_place, scratch.primary, frame) {
                Some(r) => r,
                None => {
                    return self.rollback(bail("Bz/Bnz: cond Place not int", cond, cond_place));
                }
            }
        };
        let (kind, word) = if negate {
            (LocalBranchKind::Cbz(rt), enc_cbz(rt, 0))
        } else {
            (LocalBranchKind::Cbnz(rt), enc_cbnz(rt, 0))
        };
        self.push_branch(target, kind);
        emit(self.cx.code, word);
        self.branch_unless_next(block_idx, fall_through);
        Ok(())
    }

    /// Table dispatch through the read-only blob: image output reads a
    /// 32-bit table-relative entry and adds the base back; relocatable
    /// output loads an 8-byte absolute entry. The bounds check preceding
    /// the terminator proves the index in range.
    fn emit_jump_table(&mut self, idx: super::super::ir::ValueId, table: u32) -> Emit {
        let FnCtx {
            alloc,
            frame,
            scratch,
            ..
        } = self.fcx;
        let iplace = place_of(alloc, idx);
        let Some(rt) = materialize_int(self.cx.code, iplace, scratch.primary, frame) else {
            return self.rollback(bail("JumpTable: idx Place not int", idx, iplace));
        };
        // rt is never scratch.secondary, so the table base cannot alias it; the
        // writer patches the adrp+add pair (RodataAddrFixup).
        let code = &mut *self.cx.code;
        let tbl = scratch.secondary;
        let addr_site = code.len();
        emit(code, enc_adrp(tbl, 0));
        emit(code, enc_add_imm(tbl, tbl, 0));
        if self.abs_jump_tables {
            emit(code, enc_ldr_reg_lsl3(tbl, tbl, rt));
        } else {
            emit(code, enc_ldrsw_reg_lsl2(scratch.primary, tbl, rt));
            emit(code, enc_add_reg(tbl, tbl, scratch.primary));
        }
        emit(code, enc_br(tbl));
        self.jump_table_fixups.push((addr_site, table));
        Ok(())
    }

    /// Resolve everything that waited on the block layout.
    fn resolve_layout(&mut self) -> Emit {
        self.patch_block_addrs()?;
        let func = self.fcx.func;
        // Static-initializer slots holding one of this function's label
        // addresses, for the object writers to relocate against.
        for r in &func.label_data_relocs {
            self.cx.label_relocs.push(super::LabelReloc {
                data_offset: r.data_offset,
                text_offset: self.block_offsets[r.block as usize] as u64,
            });
        }
        // `asm goto` section fields (`.long %l0 - .`) take the label block's
        // final text offset; the entry snapshot scopes the rewrite to this
        // function's relocs.
        crate::c5::asm::resolve_asm_goto_relocs(
            self.cx.asm_sections.relocs_mut(),
            &self.snapshot.asm_sections,
            &|bid| self.block_offsets[bid as usize],
        );
        self.append_deferred_regions()?;
        self.patch_direct_goto_branches()?;
        self.patch_branch_fixups()?;
        self.materialize_jump_tables();
        Ok(())
    }

    /// Patch each `&&label` ADR against its block's final offset.
    fn patch_block_addrs(&mut self) -> Emit {
        for (site, target_block, rd) in core::mem::take(&mut self.block_addr_fixups) {
            let rel = self.block_offsets[target_block as usize] as i64 - site as i64;
            // ADR has a signed 21-bit byte immediate (+/-1 MiB).
            if !(-(1 << 20)..(1 << 20)).contains(&rel) {
                return self.rollback(unsupported("BlockAddr: ADR target out of +/-1MiB range"));
            }
            self.patch_word(site, enc_adr(rd, rel as i32));
        }
        Ok(())
    }

    /// Append each ALTERNATIVE replacement after the body, out of the main
    /// sequence's fall-through path (GNU as puts it at the end of the
    /// section); resolve the `.altinstructions` fields, symbol branches
    /// and `%l[...]` branches that point into or out of it.
    fn append_deferred_regions(&mut self) -> Emit {
        let name2entpc = self.fcx.name2entpc;
        let regions = core::mem::take(&mut self.deferred_regions);
        let mut deferred_bases: Vec<usize> = Vec::with_capacity(regions.len());
        if !regions.is_empty() {
            self.align_stream();
        }
        for region in &regions {
            let base = self.cx.code.len();
            deferred_bases.push(base);
            self.cx.code.extend_from_slice(&region.bytes);
            self.cx
                .text_data_ranges
                .extend(region.data_ranges.iter().map(|&(o, n)| (base + o, n)));
            // A replacement branch to a symbol becomes a call fixup (same
            // unit) or a relocation (link-time), as a main-stream one does.
            for sb in &region.sym_branches {
                let native_offset = base + sb.region_off;
                match name2entpc.get(sb.name.as_str()) {
                    Some(&ent_pc) => self.fixups.push(Fixup {
                        native_offset,
                        target_ent_pc: ent_pc,
                        kind: if sb.is_call {
                            BranchKind::Bl
                        } else {
                            BranchKind::B
                        },
                    }),
                    None => self
                        .cx
                        .asm_extern_call_sites
                        .push(super::UserExternCallSite {
                            instr_offset: native_offset,
                            symbol_name: sb.name.clone(),
                            is_tail: !sb.is_call,
                        }),
                }
            }
        }
        crate::c5::asm::resolve_asm_deferred_relocs(
            self.cx.asm_sections.relocs_mut(),
            &self.snapshot.asm_sections,
            &|idx| deferred_bases[idx as usize],
        );
        // Replacement `%l[...]` branches that leave the region: both the
        // region base and the block layout are known now.
        for (idx, region) in regions.iter().enumerate() {
            let base = deferred_bases[idx];
            for gb in &region.goto_branches {
                let target = match gb.target {
                    DeferredGotoTarget::Code(off) => off,
                    DeferredGotoTarget::Block(b) => self.block_offsets[b as usize],
                };
                let site = base + gb.region_off;
                let delta = target as i64 - site as i64;
                let word = match gb.kind {
                    LabelBranch::Adr { rd } if (-(1 << 20)..(1 << 20)).contains(&delta) => {
                        Ok(enc_adr(Reg(rd), delta as i32))
                    }
                    LabelBranch::Adr { .. } => Err(()),
                    ref kind => label_branch_word(kind, delta).map_err(|_| ()),
                };
                let Ok(w) = word else {
                    return self.rollback(unsupported(
                        "aarch64 inline asm: replacement goto branch target out of range",
                    ));
                };
                self.patch_word(site, w);
            }
        }
        Ok(())
    }

    /// Encode each template `%l[...]` branch that reaches its label's block
    /// with no operand frame in the way.
    fn patch_direct_goto_branches(&mut self) -> Emit {
        for gb in core::mem::take(&mut self.direct_goto_branches) {
            let delta = self.block_offsets[gb.target as usize] as i64 - gb.site as i64;
            match label_branch_word(&gb.kind, delta) {
                Ok(w) => self.patch_word(gb.site, w),
                Err(m) => {
                    return self.rollback(unsupported(m));
                }
            }
        }
        Ok(())
    }

    /// Patch the block-local branches recorded during the walk.
    fn patch_branch_fixups(&mut self) -> Emit {
        for fx in core::mem::take(&mut self.branch_fixups) {
            let rel = self.block_offsets[fx.target as usize] as i64 - fx.site as i64;
            if rel % 4 != 0 {
                return self.rollback(unsupported("branch fixup: rel not 4-aligned"));
            }
            let Some(word) = fx.kind.word((rel / 4) as i32) else {
                let m = if matches!(fx.kind, LocalBranchKind::B) {
                    "branch fixup: imm26 out of range"
                } else {
                    "branch fixup: imm19 out of range"
                };
                return self.rollback(unsupported(m));
            };
            self.patch_word(fx.site, word);
        }
        Ok(())
    }

    /// Materialize each jump table into the read-only blob: one address
    /// fixup for the adrp+add site, then one slot per entry (a 4-byte
    /// `target - table_base` difference, or the relocatable form's 8-byte
    /// absolute address left for the object's relocations). Runs past the
    /// last bail site so a bailed function leaves the blob untouched.
    fn materialize_jump_tables(&mut self) {
        let func = self.fcx.func;
        let width: usize = if self.abs_jump_tables { 8 } else { 4 };
        for (addr_site, table) in core::mem::take(&mut self.jump_table_fixups) {
            let rodata = &mut *self.rodata;
            while !rodata.bytes.len().is_multiple_of(width) {
                rodata.bytes.push(0);
            }
            let base = rodata.bytes.len() as u64;
            rodata.addr_fixups.push(super::RodataAddrFixup {
                code_offset: addr_site,
                rodata_offset: base,
            });
            for (i, &t) in func.jump_tables[table as usize].iter().enumerate() {
                let slot_offset = base + (i * width) as u64;
                let text_offset = self.block_offsets[t as usize] as u64;
                if self.abs_jump_tables {
                    rodata.abs64.push(super::RodataAbs64 {
                        slot_offset,
                        text_offset,
                    });
                } else {
                    rodata.rel32.push(super::RodataRel32 {
                        slot_offset,
                        base_offset: base,
                        text_offset,
                    });
                }
                rodata.bytes.resize(rodata.bytes.len() + width, 0);
            }
        }
    }
}

/// Store through sp so the page the allocation just entered faults if
/// the stack ends there; `xzr` is always readable and the store sets no
/// flags.
pub(super) fn emit_stack_probe(code: &mut Vec<u8>) {
    emit(code, super::encode::enc_str_imm(Reg(31), Reg::SP, 0));
}

/// Reserve the realigned region and align sp down to `realign_align`
/// (C11 6.7.5). The AND descends by up to `realign_align - 1` bytes the
/// probe schedule cannot see, so when the two together can outrun the
/// unprobed margin a probe on each side of it keeps every step within a
/// page of a touched address. x16 stages the alignment, since
/// AND-immediate cannot read sp.
fn emit_realign_sp(code: &mut Vec<u8>, frame: Frame) {
    let slack = frame.realign_align - 1;
    let probe = frame.realign_region_bytes.saturating_add(slack) > MAX_UNPROBED_STACK_STEP;
    emit_stack_alloc(code, frame.realign_region_bytes, Some(Reg(16)));
    if probe {
        emit_stack_probe(code);
    }
    emit(code, enc_add_imm(Reg(16), Reg(31), 0));
    emit(
        code,
        super::encode::enc_and_sp_pow2(Reg(16), frame.realign_align.trailing_zeros()),
    );
    if probe {
        emit_stack_probe(code);
    }
}

/// `sp -= bytes`. A decrement of at most `MAX_UNPROBED_STACK_STEP` cannot
/// pass the guard region; past that the allocation descends a page at a
/// time with a store through sp after each step, as a counted loop
/// through `scratch` when there are more than `STACK_PROBE_UNROLL_MAX`
/// steps and a register is available.
pub(super) fn emit_stack_alloc(code: &mut Vec<u8>, bytes: u32, scratch: Option<Reg>) {
    if bytes <= MAX_UNPROBED_STACK_STEP {
        emit_sub_sp_imm(code, bytes);
        return;
    }
    let steps = bytes / STACK_PROBE_PAGE;
    let residual = bytes % STACK_PROBE_PAGE;
    let page_step = super::encode::enc_sub_imm_lsl12(Reg::SP, Reg::SP, 1);
    match scratch {
        Some(counter) if steps > STACK_PROBE_UNROLL_MAX => {
            super::encode::load_imm64(code, counter, steps as u64);
            let loop_start = code.len();
            emit(code, page_step);
            emit_stack_probe(code);
            emit(code, super::encode::enc_subs_imm(counter, counter, 1));
            let off = ((loop_start as i64) - (code.len() as i64)) / 4;
            emit(
                code,
                super::encode::enc_b_cond(super::encode::Cond::Ne, off as i32),
            );
        }
        _ => {
            for _ in 0..steps {
                emit(code, page_step);
                emit_stack_probe(code);
            }
        }
    }
    if residual > 0 {
        emit(code, super::encode::enc_sub_imm(Reg::SP, Reg::SP, residual));
        if residual > MAX_UNPROBED_STACK_STEP {
            emit_stack_probe(code);
        }
    }
}

/// Emit the function prologue.
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    // A host-ABI variadic callee spills every argument register (a variadic
    // argument that landed in one must reach the save area for `va_arg`)
    // into the register save area above the saved fp/lr; see
    // `emit_register_save_area`. Neither is a full leaf, so the frame record
    // follows.
    if win_arm64_variadic_callee(func, abi) {
        debug_assert_eq!(
            frame.param_spill_bytes, WIN_ARM64_GR_SAVE_BYTES,
            "win-arm64 variadic prologue must reserve the full gr-save area"
        );
        emit_register_save_area(code, alloc, frame, abi, extern_data_refs, false);
        return;
    }
    if aarch64_host_variadic_callee(func, abi) {
        debug_assert_eq!(
            frame.param_spill_bytes, AARCH64_VA_SAVE_BYTES,
            "aapcs64 variadic prologue must reserve the full register save area"
        );
        emit_register_save_area(code, alloc, frame, abi, extern_data_refs, true);
        return;
    }
    // One 16-byte c5 cdecl cell per declared parameter above fp, with the
    // host-stack overflow restriped into cells; the epilogue drops
    // `frame.param_spill_bytes`.
    let entry_spill = if spills_named_params_on_entry(func, abi) {
        func.n_params
    } else {
        0
    };
    if entry_spill > 0 && frame.param_spill_bytes > 0 {
        if params_interleaved(func, abi) {
            emit_interleaved_param_cells(code, func, abi);
        } else {
            emit_param_cells(code, func, alloc, abi);
        }
    }
    if is_full_leaf(func, frame, alloc) {
        return;
    }
    emit_frame_and_saves(code, alloc, frame);
    if func.indirect_result_slot != 0 {
        // AAPCS64 6.9: save the caller-supplied x8 indirect-result pointer
        // into its body local; `return s;` writes the aggregate through it.
        let _ = emit_local_addr_fp(code, Place::IntReg(16), func.indirect_result_slot, frame);
        emit(code, enc_str_imm(Reg(8), Reg(16), 0));
    }
    // The canary slot is fp-relative, so it is stored before the sp
    // realignment (C11 6.7.5), which uses x16 alone and so leaves the
    // argument registers for the scatter that follows it: a parameter copy
    // aligned above the slot lives in the realigned region.
    emit_canary_store(code, frame, abi, extern_data_refs);
    if frame.realign_align > 0 {
        emit_realign_sp(code, frame);
    }
    emit_struct_param_scatter(code, func, abi, frame);
}

/// The host-ABI variadic register save area above the saved fp/lr: the
/// integer argument registers at an 8-byte stride and, for AAPCS64,
/// q0..q7 at a 16-byte stride after them. Under `no_fp_varargs` the
/// vector half stays reserved but unwritten (the store would fault) and
/// `va_start` marks it exhausted.
fn emit_register_save_area(
    code: &mut Vec<u8>,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
    vector: bool,
) {
    emit_sub_sp_imm(code, frame.param_spill_bytes);
    for (i, &r) in abi.int_arg_regs.iter().enumerate() {
        emit(code, enc_str_imm(Reg(r), Reg(31), (i as u32) * 8));
    }
    if vector && !abi.no_fp_varargs {
        for i in 0..8u32 {
            // `va_arg(double)` reads the low eightbyte of each 16-byte slot.
            emit(
                code,
                enc_str_d_imm(i as u8, Reg(31), AARCH64_GR_SAVE_BYTES + i * 16),
            );
        }
    }
    emit_frame_and_saves(code, alloc, frame);
    emit_canary_store(code, frame, abi, extern_data_refs);
}

/// The contiguous-prefix cell layout: the host-stack overflow restriped
/// into cells, then one 16-byte pre-decrement push per register-passed
/// parameter from the last to the first; the stores of ParamRef-seeded,
/// unaddressed cells are elided into one coalesced `sub sp`.
fn emit_param_cells(code: &mut Vec<u8>, func: &FunctionSsa, alloc: &Allocation, abi: super::Abi) {
    let (n_reg, n_stack) = param_reg_stack_split(func, abi);
    let placements = param_placements(func, abi);
    if n_stack > 0 {
        let overflow_bytes = (n_stack as u32) * 16;
        emit_stack_alloc(code, overflow_bytes, None);
        // The planner's offset accounts for any by-value aggregate stack
        // parameter (StructStack) that precedes the scalar.
        let mut slot_i = 0u32;
        for p in &placements {
            if let super::ArgPlacement::Stack(off) = p {
                let host_off = *off + overflow_bytes;
                let c5_off = slot_i * 16;
                emit(code, enc_ldr_imm(Reg(16), Reg(31), host_off));
                emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
                slot_i += 1;
            }
        }
    }
    let (seeded_params, addr_taken_slots, needed_slots) =
        super::ssa::emit_common::scan_param_slot_usage(func, alloc);
    let mut pending_sub: u32 = 0;
    for i in (0..n_reg).rev() {
        let slot = (i as i64) + 2;
        let skip = seeded_params.contains(&(i as u32))
            && !addr_taken_slots.contains(&slot)
            && !needed_slots.contains(&slot);
        if skip {
            pending_sub += 16;
            continue;
        }
        if pending_sub > 0 {
            emit_stack_alloc(code, pending_sub, None);
            pending_sub = 0;
        }
        // An FP parameter's bits move through x16 into the same cell push.
        match placements.get(i).copied() {
            Some(super::ArgPlacement::FpReg(d)) => {
                emit(code, enc_fmov_d_to_x(Reg(16), d));
                emit(code, enc_str_pre(Reg(16), Reg(31), -16));
            }
            Some(super::ArgPlacement::IntReg(r)) => emit(code, enc_str_pre(Reg(r), Reg(31), -16)),
            // An aggregate passed in registers keeps them for
            // `emit_struct_param_scatter`; a stack-passed parameter's cell was
            // filled by the restripe above. Either reserves its cell.
            _ => emit_sub_sp_imm(code, 16),
        }
    }
    if pending_sub > 0 {
        emit_stack_alloc(code, pending_sub, None);
    }
}

/// Position-indexed cells for an interleaved register / stack placement:
/// one block of `n_params` cells, each parameter written into its own
/// position's cell at `[fp + 16 + position*16]` (`local_slot_off`), a
/// stack-passed scalar copied from the overflow slot above the block.
/// Aggregates keep their argument registers for
/// `emit_struct_param_scatter`; x16 is the only scratch.
fn emit_interleaved_param_cells(code: &mut Vec<u8>, func: &FunctionSsa, abi: super::Abi) {
    let placements = param_placements(func, abi);
    let cells = func.n_params as u32 * 16;
    emit_stack_alloc(code, cells, None);
    for (i, p) in placements.iter().enumerate() {
        let c5_off = (i as u32) * 16;
        match p {
            super::ArgPlacement::IntReg(r) => {
                emit(code, enc_str_imm(Reg(*r), Reg(31), c5_off));
            }
            super::ArgPlacement::FpReg(d) => {
                emit(code, enc_fmov_d_to_x(Reg(16), *d));
                emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
            }
            super::ArgPlacement::Stack(off) => {
                let host_off = cells + *off;
                emit(code, enc_ldr_imm(Reg(16), Reg(31), host_off));
                emit(code, enc_str_imm(Reg(16), Reg(31), c5_off));
            }
            // By-reference aggregates are rejected upstream on AAPCS64.
            _ => {}
        }
    }
}

/// Store each register-passed aggregate parameter's argument registers
/// into its parser-reserved body local, once the frame is established
/// and before anything clobbers x0..x7 / d0..d7. The body reads the
/// aggregate from that local; its 16-byte argument cell stays unused.
fn emit_struct_param_scatter(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    abi: super::Abi,
    frame: Frame,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    for (i, agg) in func.param_aggs.iter().enumerate() {
        let Some(agg_idx) = agg else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        match placements.get(i) {
            Some(super::ArgPlacement::StructRegs { regs, n, .. }) => {
                // An integer eightbyte stores at offset 8k; an HFA member at its own
                // offset and size (d for 8 bytes, s for 4). x16 is never an argument
                // register.
                let hfa = super::abi_classify::hfa_member_layout(
                    &func.agg_descs[*agg_idx as usize].fields,
                );
                let _ = emit_local_addr(code, Place::IntReg(16), slot, func, frame);
                for (k, cr) in regs.iter().take(*n as usize).enumerate() {
                    if cr.is_fp {
                        let (off, msize) = hfa
                            .as_ref()
                            .and_then(|m| m.get(k).copied())
                            .unwrap_or(((k as u32) * 8, 8));
                        if msize == 8 {
                            emit(code, super::encode::enc_str_d_imm(cr.reg, Reg(16), off));
                        } else {
                            emit(code, super::encode::enc_str_s_imm(cr.reg, Reg(16), off));
                        }
                    } else {
                        emit(code, enc_str_imm(Reg(cr.reg), Reg(16), (k as u32) * 8));
                    }
                }
            }
            Some(super::ArgPlacement::StructStack { off, size, .. }) => {
                // The aggregate sits in the caller's stack argument area, above the
                // saved fp/lr and the c5 parameter cells; its own reserved cell stays
                // unused. AAPCS64 5.4.2 rounds the slot up to 8 bytes: whole eightbytes
                // through x17, then the sub-eightbyte tail.
                let src = 16 + frame.param_spill_bytes + *off;
                let size = *size;
                debug_assert!(
                    src + size <= 4096 * 8,
                    "stack-arg offset beyond ldr imm12 reach"
                );
                let _ = emit_local_addr(code, Place::IntReg(16), slot, func, frame);
                let mut o = 0u32;
                while o + 8 <= size {
                    emit(code, enc_ldr_imm(Reg(17), Reg(29), src + o));
                    emit(code, enc_str_imm(Reg(17), Reg(16), o));
                    o += 8;
                }
                if o + 4 <= size {
                    emit(
                        code,
                        super::encode::enc_ldr32_imm(Reg(17), Reg(29), src + o),
                    );
                    emit(code, super::encode::enc_str32_imm(Reg(17), Reg(16), o));
                    o += 4;
                }
                if o + 2 <= size {
                    emit(code, super::encode::enc_ldrh_imm(Reg(17), Reg(29), src + o));
                    emit(code, super::encode::enc_strh_imm(Reg(17), Reg(16), o));
                    o += 2;
                }
                if o < size {
                    emit(code, super::encode::enc_ldrb_imm(Reg(17), Reg(29), src + o));
                    emit(code, super::encode::enc_strb_imm(Reg(17), Reg(16), o));
                }
            }
            _ => continue,
        }
    }
}

/// Save the allocator's callee-saved GPRs and FP registers at the bottom
/// of the frame, adjacent slots as `stp` pairs, then x19 when the
/// function clobbers it (its slot is reserved either way). The region
/// sits just above sp, within reach of the pair imm7 and the scaled
/// imm12. With `fold != 0` (see `frame_fold_bytes`) the first save
/// pre-indexes the whole allocation, frame plus the fp/lr pair, in place
/// of the prologue's `stp x29, x30, [sp, #-16]!` / `sub sp`; every other
/// offset is unchanged.
fn emit_prologue_saved_regs(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame, fold: u32) {
    let mut alloc_pending = fold != 0;
    let fp = &alloc.fp_used;
    let mut i = 0usize;
    while i + 1 < fp.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(
                code,
                enc_stp_d_pre(fp[i], fp[i + 1], Reg(31), -(fold as i32)),
            );
        } else {
            emit(
                code,
                enc_stp_d_off(fp[i], fp[i + 1], Reg(31), (i as i32) * 8),
            );
        }
        i += 2;
    }
    if i < fp.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_d_pre(fp[i], Reg(31), -(fold as i32)));
        } else {
            emit(code, enc_str_d_imm(fp[i], Reg(31), (i as u32) * 8));
        }
    }
    let saved_fpr_bytes = super::ssa::emit_common::slots16(fp.len() as u32);
    let gpr = &alloc.gpr_used;
    let mut i = 0usize;
    while i + 1 < gpr.len() {
        let off = (saved_fpr_bytes + (i as u32) * 8) as i32;
        if core::mem::take(&mut alloc_pending) {
            emit(
                code,
                enc_stp_pre(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), -(fold as i32)),
            );
        } else {
            emit(
                code,
                enc_stp_off(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), off),
            );
        }
        i += 2;
    }
    if i < gpr.len() {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_pre(Reg(gpr[i]), Reg(31), -(fold as i32)));
        } else {
            let off = saved_fpr_bytes + (i as u32) * 8;
            emit(code, enc_str_imm(Reg(gpr[i]), Reg(31), off));
        }
    }
    if frame.uses_x19 {
        if core::mem::take(&mut alloc_pending) {
            emit(code, enc_str_pre(Reg(19), Reg(31), -(fold as i32)));
        } else {
            let saved_gpr_bytes = super::ssa::emit_common::slots16(gpr.len() as u32);
            emit(
                code,
                enc_str_imm(Reg(19), Reg(31), saved_fpr_bytes + saved_gpr_bytes),
            );
        }
    }
    debug_assert!(!alloc_pending, "frame fold requested with no callee save");
}

/// The stack-protector sequences' scratch: x16 / x17, free at the end
/// of the prologue and on every return path.
const CANARY_SCRATCH: Reg = Reg(16);

const CANARY_SCRATCH2: Reg = Reg(17);

/// Leave the guard value in `rd`: `-mstack-protector-guard=sysreg` reads
/// it at an offset from a system register; the `global` form reads the
/// object the C library exports, resolved directly or through the GOT.
fn emit_load_stack_guard(
    code: &mut Vec<u8>,
    rd: Reg,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    let ssp = abi.stack_protect;
    if let super::StackGuard::Sysreg { sysreg, offset } = ssp.guard {
        emit(code, super::encode::enc_mrs(rd, sysreg));
        emit_guard_load_at_offset(code, rd, rd, offset);
        return;
    }
    let symbol = ssp.guard_symbol.as_str();
    let name = if symbol.is_empty() {
        super::STACK_GUARD_SYMBOL
    } else {
        symbol
    };
    extern_data_refs.push(super::UserExternDataRef {
        instr_offset: code.len(),
        symbol_name: name.into(),
        direct_pcrel: None,
    });
    emit(code, enc_adrp(rd, 0));
    emit(code, enc_add_imm(rd, rd, 0));
    emit(code, enc_ldr_imm(rd, rd, 0));
}

/// `ldr rd, [rn, #off]` for either sign: scaled unsigned, unscaled
/// signed, or an explicit address in `CANARY_SCRATCH2` past both ranges.
fn emit_guard_load_at_offset(code: &mut Vec<u8>, rd: Reg, rn: Reg, off: i32) {
    if (0..=32760).contains(&off) && off % 8 == 0 {
        emit(code, enc_ldr_imm(rd, rn, off as u32));
    } else if (-256..256).contains(&off) {
        emit(code, super::encode::enc_ldur(rd, rn, off));
    } else {
        super::encode::load_imm64(code, CANARY_SCRATCH2, off as i64 as u64);
        emit(
            code,
            super::encode::enc_add_reg(CANARY_SCRATCH2, rn, CANARY_SCRATCH2),
        );
        emit(code, enc_ldr_imm(rd, CANARY_SCRATCH2, 0));
    }
}

/// Prologue half of the stack protector: store the guard into the canary
/// slot at `[fp - 8]`, above every local and below the saved fp/lr, then
/// clear the scratch so the guard value does not outlive the store.
fn emit_canary_store(
    code: &mut Vec<u8>,
    frame: Frame,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    if frame.canary_bytes == 0 {
        return;
    }
    emit_load_stack_guard(code, CANARY_SCRATCH, abi, extern_data_refs);
    emit(
        code,
        super::encode::enc_stur(
            CANARY_SCRATCH,
            Reg(29),
            super::ssa::emit_common::CANARY_SLOT_OFF,
        ),
    );
    emit(code, enc_movz(CANARY_SCRATCH, 0, 0));
}

/// Epilogue half: compare the canary slot against the guard and call
/// `__stack_chk_fail` when they differ. Emitted on every path that leaves
/// the frame, ahead of the teardown, while fp still addresses the slot.
fn emit_canary_check(
    code: &mut Vec<u8>,
    frame: Frame,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    if frame.canary_bytes == 0 {
        return;
    }
    emit_load_stack_guard(code, CANARY_SCRATCH, abi, extern_data_refs);
    emit(
        code,
        super::encode::enc_ldur(
            CANARY_SCRATCH2,
            Reg(29),
            super::ssa::emit_common::CANARY_SLOT_OFF,
        ),
    );
    emit(
        code,
        super::encode::enc_cmp_reg(CANARY_SCRATCH, CANARY_SCRATCH2),
    );
    // Two instructions ahead: over the `bl` to the handler.
    emit(code, super::encode::enc_b_cond(super::encode::Cond::Eq, 2));
    extern_sites.push(super::UserExternCallSite {
        instr_offset: code.len(),
        symbol_name: super::STACK_CHK_FAIL_SYMBOL.into(),
        is_tail: false,
    });
    emit(code, super::encode::enc_bl(0));
    // Both scratch registers held the guard value; neither may reach the
    // caller with it.
    emit(code, enc_movz(CANARY_SCRATCH, 0, 0));
    emit(code, enc_movz(CANARY_SCRATCH2, 0, 0));
}

/// Re-establish `sp = fp - frame_bytes` in a dynamic-sp frame before the
/// sp-relative restores, committed with one write so sp never rests
/// above unrestored frame bytes (a signal delivered mid-sequence pushes
/// its frame below sp).
fn restore_dynamic_sp(code: &mut Vec<u8>, frame: Frame) {
    if !frame.dynamic_sp {
        return;
    }
    let bytes = frame.frame_bytes;
    if bytes < 4096 {
        emit(code, enc_sub_imm(Reg(31), Reg(29), bytes));
    } else {
        emit_fp_minus_off(code, Reg(16), bytes);
        emit(code, enc_add_imm(Reg(31), Reg(16), 0));
    }
}

/// Restore what `emit_prologue_saved_regs` saved, in mirror order so the
/// offset-0 access comes last and, with `fold != 0`, post-indexes the
/// whole frame plus the fp/lr pair back.
fn emit_epilogue_restore_regs(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame, fold: u32) {
    let saved_fpr_bytes = super::ssa::emit_common::slots16(alloc.fp_used.len() as u32);
    let gpr = &alloc.gpr_used;
    if frame.uses_x19 {
        let saved_gpr_bytes = super::ssa::emit_common::slots16(gpr.len() as u32);
        let off = saved_fpr_bytes + saved_gpr_bytes;
        if off == 0 && fold != 0 {
            emit(code, enc_ldr_post(Reg(19), Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_imm(Reg(19), Reg(31), off));
        }
    }
    let mut i = gpr.len();
    if i % 2 == 1 {
        i -= 1;
        let off = saved_fpr_bytes + (i as u32) * 8;
        if off == 0 && fold != 0 {
            emit(code, enc_ldr_post(Reg(gpr[i]), Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_imm(Reg(gpr[i]), Reg(31), off));
        }
    }
    while i >= 2 {
        i -= 2;
        let off = (saved_fpr_bytes + (i as u32) * 8) as i32;
        if off == 0 && fold != 0 {
            emit(
                code,
                enc_ldp_post(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), fold as i32),
            );
        } else {
            emit(
                code,
                enc_ldp_off(Reg(gpr[i]), Reg(gpr[i + 1]), Reg(31), off),
            );
        }
    }
    let fp = &alloc.fp_used;
    let mut i = fp.len();
    if i % 2 == 1 {
        i -= 1;
        if i == 0 && fold != 0 {
            emit(code, enc_ldr_d_post(fp[i], Reg(31), fold as i32));
        } else {
            emit(code, enc_ldr_d_imm(fp[i], Reg(31), (i as u32) * 8));
        }
    }
    while i >= 2 {
        i -= 2;
        if i == 0 && fold != 0 {
            emit(code, enc_ldp_d_post(fp[i], fp[i + 1], Reg(31), fold as i32));
        } else {
            emit(
                code,
                enc_ldp_d_off(fp[i], fp[i + 1], Reg(31), (i as i32) * 8),
            );
        }
    }
}

/// Frame bytes the folded prologue / epilogue shape carries, or 0. The
/// fold extends the frame by the fp/lr pair: the first callee save
/// pre-indexes `-(frame_bytes + 16)`, fp/lr store / load at
/// `[sp, #frame_bytes]`, and the last restore post-indexes it all back.
/// The scaled imm7 pair forms reach 504, so a pair-first frame folds up
/// to 480; a single-register bottom save takes the unscaled imm9 (255)
/// and folds up to 224.
fn frame_fold_bytes(alloc: &Allocation, frame: Frame) -> u32 {
    // A realigning function keeps the unfolded shape so
    // `restore_dynamic_sp` returns sp to the static frame bottom first.
    if frame.realign_align != 0 {
        return 0;
    }
    let n_bottom = if !alloc.fp_used.is_empty() {
        alloc.fp_used.len()
    } else if !alloc.gpr_used.is_empty() {
        alloc.gpr_used.len()
    } else if frame.uses_x19 {
        1
    } else {
        return 0;
    };
    debug_assert!(frame.frame_bytes >= 16, "saves imply a non-empty frame");
    let limit = if n_bottom >= 2 { 480 } else { 224 };
    if frame.frame_bytes <= limit {
        frame.frame_bytes
    } else {
        0
    }
}

/// The frame record, fp, the frame allocation and the callee saves. The
/// folded shape allocates everything with the first save's pre-index and
/// keeps fp and every offset identical to the unfolded
/// `stp fp/lr; mov fp, sp; sub sp` shape.
fn emit_frame_and_saves(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame) {
    let fold = frame_fold_bytes(alloc, frame);
    if fold != 0 {
        emit_prologue_saved_regs(code, alloc, frame, fold + 16);
        emit(code, enc_stp_off(Reg(29), Reg(30), Reg(31), fold as i32));
        emit(code, enc_add_imm(Reg(29), Reg(31), fold));
        return;
    }
    emit(code, enc_stp_pre(Reg(29), Reg(30), Reg(31), -16));
    emit(code, enc_add_imm(Reg(29), Reg(31), 0));
    if frame.frame_bytes > 0 {
        emit_stack_alloc(code, frame.frame_bytes, Some(Reg(16)));
    }
    emit_prologue_saved_regs(code, alloc, frame, 0);
}

/// The `B.cond` condition for a comparison the allocator flagged as
/// branch-fused; `negate` for `Bz`. `None` when fusion does not apply.
/// `Cond::flip` is an exact NZCV complement, so an inverted FP branch is
/// taken on the unordered state exactly when C99 6.5.8p6 / 6.5.9p3
/// require the negated comparison to hold.
fn fused_branch_cond(
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    cond: super::super::ir::ValueId,
    negate: bool,
) -> Option<super::encode::Cond> {
    if !alloc
        .branch_fused
        .get(cond as usize)
        .copied()
        .unwrap_or(false)
    {
        return None;
    }
    let op = match func.insts.get(cond as usize)? {
        Inst::Binop { op, .. } | Inst::BinopI { op, .. } => *op,
        _ => return None,
    };
    let positive = compare_cond(op).or_else(|| fp_compare_cond(op))?;
    Some(if negate { positive.flip() } else { positive })
}

/// Emit the function epilogue + `ret` for a Return terminator.
#[allow(clippy::too_many_arguments)]
pub(super) fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    func: &FunctionSsa,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    if let Some(ai) = func.ret_agg {
        emit_aggregate_return(code, value, ai, alloc, frame, scratch, func, abi);
    } else if value != super::super::ir::NO_VALUE {
        emit_scalar_return(code, value, alloc, frame, scratch, func);
    }
    // A full leaf saved nothing.
    if is_full_leaf(func, frame, alloc) {
        emit(code, enc_ret(Reg(30)));
        return;
    }
    emit_canary_check(code, frame, abi, extern_sites, extern_data_refs);
    restore_dynamic_sp(code, frame);
    // The folded shape restores fp/lr first (the lr load feeds `ret`) and
    // tears the frame down with the last restore's post-index.
    let fold = frame_fold_bytes(alloc, frame);
    if fold != 0 {
        emit(code, enc_ldp_off(Reg(29), Reg(30), Reg(31), fold as i32));
        emit_epilogue_restore_regs(code, alloc, frame, fold + 16);
    } else {
        emit_epilogue_restore_regs(code, alloc, frame, 0);
        if frame.frame_bytes > 0 {
            // x16 carries no result and is free for a frame size past the
            // immediate reach.
            super::encode::emit_add_sp_imm_scratch(code, frame.frame_bytes, Reg(16));
        }
        emit(code, enc_ldp_post(Reg(29), Reg(30), Reg(31), 16));
    }
    if frame.param_spill_bytes > 0 {
        emit_add_sp_imm(code, frame.param_spill_bytes);
    }
    // sp holds the value `paciasp` signed against.
    if signs_return_address(func, frame, alloc, abi) {
        emit(code, super::encode::AUTIASP);
    }
    emit(code, enc_ret(Reg(30)));
}

/// Host-ABI aggregate return (AAPCS64 6.9). `value` is the struct's
/// address. An HFA returns member k in v[k]; an aggregate of at most 16
/// bytes returns its eightbytes in x0/x1; a larger one is copied through
/// the caller-supplied x8 pointer (saved to `indirect_result_slot` by the
/// prologue) and that pointer is returned in x0.
#[allow(clippy::too_many_arguments)]
fn emit_aggregate_return(
    code: &mut Vec<u8>,
    value: u32,
    ai: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    func: &FunctionSsa,
    abi: super::Abi,
) {
    let desc = &func.agg_descs[ai as usize];
    let size = desc.size;
    let saddr = materialize_int(code, place_of(alloc, value), scratch.primary, frame)
        .unwrap_or(scratch.primary);
    if saddr.0 != scratch.primary.0 {
        emit_mov_reg(code, scratch.primary, saddr);
    }
    let base = scratch.primary;
    if let Some(members) = super::abi_classify::hfa_member_layout(&desc.fields) {
        for (k, (off, msize)) in members.iter().enumerate() {
            emit_agg_load_fp(
                code,
                k as u8,
                base,
                *off,
                *msize,
                desc.align,
                abi.strict_align,
                scratch.secondary,
            );
        }
        return;
    }
    if size <= 16 {
        if size > 8 {
            emit_agg_load_int(
                code,
                Reg(1),
                base,
                8,
                8,
                desc.align,
                abi.strict_align,
                scratch.secondary,
            );
        }
        emit_agg_load_int(
            code,
            Reg(0),
            base,
            0,
            8,
            desc.align,
            abi.strict_align,
            scratch.secondary,
        );
        return;
    }
    let dst = scratch.secondary;
    let _ = emit_local_addr_fp(code, Place::IntReg(dst.0), func.indirect_result_slot, frame);
    emit(code, enc_ldr_imm(dst, dst, 0));
    // The caller's object bounds the transfer unit. `WINDOW` keeps every
    // byte-form offset under 4096; a longer copy advances both bases.
    let unit = super::super::access_chunk(desc.align, abi.strict_align, 8);
    const WINDOW: u32 = 4088;
    let mut pos = 0u32;
    while pos < size {
        let run = (size - pos).min(WINDOW);
        let mut copied = 0u32;
        while copied + unit <= run {
            emit_copy_unit(code, unit, Reg(0), base, copied, dst, copied);
            copied += unit;
        }
        while copied < run {
            emit(code, enc_ldrb_imm(Reg(0), base, copied));
            emit(code, enc_strb_imm(Reg(0), dst, copied));
            copied += 1;
        }
        pos += run;
        if pos < size {
            emit(code, super::encode::enc_add_imm(base, base, run));
            emit(code, super::encode::enc_add_imm(dst, dst, run));
        }
    }
    if size > WINDOW {
        // The advanced `dst` no longer names the caller's buffer; re-read
        // the saved indirect-result pointer to return it.
        let _ = emit_local_addr_fp(code, Place::IntReg(dst.0), func.indirect_result_slot, frame);
        emit(code, enc_ldr_imm(dst, dst, 0));
    }
    emit_mov_reg(code, Reg(0), dst);
}

/// Move a scalar return value into its register: d0 for a floating-point
/// scalar (C99 6.2.5p10 / AAPCS64 6.4.2; a `float` is the s0 half, which
/// the 8-byte forms preserve), decided by the producing instruction even
/// when the value is spilled or integer-materialized; x0 otherwise.
fn emit_scalar_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    scratch: &ScratchPool,
    func: &FunctionSsa,
) {
    let place = place_of(alloc, value);
    let returns_fp = func.ret_is_fp
        || ((value as usize) < func.insts.len()
            && super::ssa::reg_alloc::produces_fp_result(&func.insts[value as usize]));
    if let Place::FpReg(r) = place {
        if r != 0 {
            emit(code, super::encode::enc_fmov_d_d(0, r));
        }
    } else if returns_fp {
        match place {
            Place::Spill(slot) => {
                let sp_off = spill_off(frame, slot);
                emit_spill_ldr_d_auto(code, frame, 0, sp_off);
            }
            _ => {
                let src =
                    materialize_int(code, place, scratch.primary, frame).unwrap_or(scratch.primary);
                emit(code, enc_fmov_x_to_d(0, src));
            }
        }
    } else if let Some(src) = materialize_int(code, place, scratch.primary, frame)
        && src.0 != 0
    {
        emit_mov_reg(code, Reg(0), src);
    }
}
