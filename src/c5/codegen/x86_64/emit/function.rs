use super::*;

/// The predecessor-exit moves for the `Inst::Phi`s at the head of every
/// CFG successor of `self_block`: register pairs through the parallel-copy
/// scheduler, spill destinations through the materialise helper.
///
/// TODO: FpReg sources and destinations, once the promotion path admits
/// them (`slot_stores_only_int` keeps them out today).
fn emit_phi_predecessor_moves(
    code: &mut Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> super::ssa::emit_common::Emit {
    // r10 / r11 (int) and the FP scratch pair are reserved scratch outside the
    // allocator's banks, so they hold no value live across the terminator.
    super::ssa::emit_common::emit_phi_predecessor_moves(
        &super::ssa::emit_common::X64Backend,
        code,
        self_block,
        func,
        alloc,
        frame,
        SCRATCH_R10.0,
        SCRATCH_R11.0,
        frame.fp_scratch[1],
        frame.fp_scratch[0],
    )
}

/// Sequentialize a parallel copy over integer registers and spill slots:
/// leaves (destinations no pending move reads) first; when only cycles
/// remain, one cycle source is saved in `hold` and every move reading it
/// redirected there, exposing a new leaf. `hold` and `stage` lie outside
/// the allocator's bank. An FP or `None` operand is an `Err`.
fn schedule_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<(Place, Place)>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) -> super::ssa::emit_common::Emit {
    super::ssa::emit_common::schedule_place_moves(
        &super::ssa::emit_common::X64Backend,
        code,
        moves,
        frame,
        hold.0,
        stage.0,
    )
}

/// Sequentialize a parallel copy over xmm registers: leaves first, then a
/// residual cycle through `scratch`, which lies outside the allocator's
/// xmm pool.
pub(super) fn schedule_xmm_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch.0,
        |code, t, s| emit_movapd_xmm_xmm(code, Reg(t), Reg(s)),
    );
}

/// The x86_64 moves the shared parallel-copy scheduler emits.
impl super::ssa::emit_common::EmitBackend for super::ssa::emit_common::X64Backend {
    type Frame = Frame;
    fn fp_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit_movapd_xmm_xmm(code, Reg(dst), Reg(src));
    }
    fn fp_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_movsd_mem_xmm(code, sb, off, Reg(src));
    }
    fn fp_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_movsd_xmm_mem(code, Reg(dst), sb, off);
    }
    fn int_reg_mov(&self, code: &mut Vec<u8>, dst: u8, src: u8) {
        emit_mov_rr(code, Reg(dst), Reg(src));
    }
    fn int_spill_store(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8, _base: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, off, Reg(src));
    }
    fn int_spill_load(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, dst: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_r_mem(code, Reg(dst), sb, off);
    }
    fn int_spill_to_spill(
        &self,
        code: &mut Vec<u8>,
        frame: Frame,
        src: u32,
        dst: u32,
        stage: u8,
        _hold: u8,
    ) {
        let (sb, src_off) = spill_slot_addr(frame, src);
        let (_, dst_off) = spill_slot_addr(frame, dst);
        emit_mov_r_mem(code, Reg(stage), sb, src_off);
        emit_mov_mem_r(code, sb, dst_off, Reg(stage));
    }
    fn int_spill_store_auto(&self, code: &mut Vec<u8>, frame: Frame, slot: u32, src: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, off, Reg(src));
    }
    fn break_place_cycle(
        &self,
        code: &mut Vec<u8>,
        moves: &mut Vec<(Place, Place)>,
        frame: Frame,
        hold: u8,
        stage: u8,
    ) {
        // A register-register edge breaks with `xchg`, which satisfies one move
        // and leaves the displaced value in the source; an edge touching a spill
        // slot routes one source through `hold`.
        if let Some(i) = moves
            .iter()
            .position(|(s, t)| matches!(s, Place::IntReg(_)) && matches!(t, Place::IntReg(_)))
        {
            let (s, t) = moves[i];
            let (Place::IntReg(sr), Place::IntReg(tr)) = (s, t) else {
                unreachable!()
            };
            emit_xchg_rr(code, Reg(sr), Reg(tr));
            moves.swap_remove(i);
            for m in moves.iter_mut() {
                if place_same_loc(m.0, t) {
                    m.0 = s;
                }
            }
            moves.retain(|(s, t)| !place_same_loc(*s, *t));
        } else {
            let cyc = moves
                .iter()
                .map(|(s, _)| *s)
                .find(|s| !place_same_loc(*s, Place::IntReg(hold)))
                .unwrap_or(moves[0].0);
            super::ssa::emit_common::emit_place_move(
                self,
                code,
                cyc,
                Place::IntReg(hold),
                frame,
                stage,
                hold,
            );
            for m in moves.iter_mut() {
                if place_same_loc(m.0, cyc) {
                    m.0 = Place::IntReg(hold);
                }
            }
        }
    }
    fn int_reg_load_imm(&self, code: &mut Vec<u8>, dst: u8, bits: i64) {
        emit_mov_r_imm64(code, Reg(dst), bits);
    }
    fn fp_reg_from_int_reg(&self, code: &mut Vec<u8>, dst: u8, src: u8, _is_f64: bool) {
        // `movq xmm, r` copies all 64 bits; for an f32 the constant occupies
        // the low 32 (the immediate load zero-extends), which a scalar-single
        // op reads, so one form serves both widths.
        emit_movq_xmm_r(code, Reg(dst), Reg(src));
    }
}

/// Sequentialize register-to-register copies `(src, tgt)`: leaves first,
/// then a residual cycle broken with `xchg`, so no scratch is needed.
pub(super) fn schedule_int_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>) {
    moves.retain(|(s, t)| s != t);
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(other_s, _)| *other_s == t);
            if !tgt_still_a_source {
                emit_mov_rr(code, Reg(t), Reg(s));
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            // Only cycle members remain: `xchg` satisfies one move and leaves the
            // displaced value in the source for the move that reads it.
            let (s, t) = moves[0];
            emit_xchg_rr(code, Reg(s), Reg(t));
            moves.swap_remove(0);
            for m in moves.iter_mut() {
                if m.0 == t {
                    m.0 = s;
                }
            }
            moves.retain(|(s, t)| s != t);
        }
    }
}

/// Lower `func` to machine code appended to `cx.code`. A shape outside
/// the implemented subset is an `Unsupported` naming it, with every output
/// buffer rolled back to its length on entry; the caller turns that into a
/// compile error.
#[allow(clippy::too_many_arguments)]
pub(crate) fn emit_function(
    func: &FunctionSsa,
    alloc: &Allocation,
    target: Target,
    cx: &mut super::ssa::emit_common::EmitCtx,
    fixups: &mut Vec<Fixup>,
    _got_fixups: &mut Vec<GotFixup>,
    extern_data_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_code_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    extern_tls_names: &alloc::collections::BTreeMap<u32, alloc::string::String>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    conv_targets: &alloc::collections::BTreeMap<usize, super::CallConv>,
    ret_tags: &alloc::collections::BTreeMap<usize, i64>,
    tls_total_size: usize,
    fn_unwind: &mut Vec<super::FnUnwind>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    asm_text_abs_refs: &mut Vec<super::AsmTextAbsRef>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
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
        let mut a = target.abi_for(func.conv);
        a.no_fp_varargs = no_fp_regs;
        a.strict_align = strict_align;
        a.hardening = hardening;
        a.stack_protect = stack_protect;
        a.mcount_frame = entry.profile.is_some_and(|call| call.after_prologue);
        a.fixed_regs = fixed_regs;
        a
    };
    if let Some(bytes) = super::ssa::emit_common::locals_bytes_over_limit(func) {
        return fail(super::ssa::emit_common::frame_too_large_msg(bytes));
    }
    let frame = compute_frame(func, alloc, abi);
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
    let param_from_home = compute_param_from_home(func, alloc, abi);
    let param_plan = param_placements(func, abi);
    let fcx = FnCtx {
        func,
        alloc,
        frame,
        abi,
        target,
        imports,
        variadic_targets,
        conv_targets,
        extern_tls_names,
        extern_data_names,
        extern_code_names,
        tls_total_size,
        param_from_home: &param_from_home,
        param_plan: &param_plan,
        name2entpc,
    };
    let endbr_targets = if abi.hardening.cf_protection_branch {
        super::indirect_branch_target_blocks(func)
    } else {
        alloc::collections::BTreeSet::new()
    };
    let out = Out {
        cx,
        fixups,
        asm_section_text_refs,
        asm_text_abs_refs,
        asm_text_labels,
    };
    let entry_mark = out.mark();
    let mut fe = FnEmit {
        start: entry_mark.code,
        out,
        fcx,
        ret_tags,
        entry,
        abs_jump_tables,
        endbr_targets,
        param_prebatched: alloc::vec![false; func.insts.len()],
        block_offsets: alloc::vec![0; func.blocks.len()],
        branch_fixups: Vec::new(),
        branch_short: Vec::new(),
        block_addr_fixups: Vec::new(),
        jump_table_fixups: Vec::new(),
    };
    match fe.run(rodata) {
        Ok(uw) => {
            fn_unwind.push(uw);
            Ok(())
        }
        Err(e) => {
            fe.out.restore(&entry_mark);
            Err(e)
        }
    }
}

/// State of one function's emission, shared by the phases below.
struct FnEmit<'a, 'b> {
    out: Out<'a, 'b>,
    fcx: FnCtx<'b>,
    ret_tags: &'b alloc::collections::BTreeMap<usize, i64>,
    entry: super::FunctionEntry,
    abs_jump_tables: bool,
    /// Offset of the function's first byte in `code`.
    start: usize,
    /// Blocks an indirect branch can enter; each opens with `endbr64`.
    endbr_targets: alloc::collections::BTreeSet<super::super::ir::BlockId>,
    /// `ParamRef` values the entry parallel copy already placed.
    param_prebatched: Vec<bool>,
    block_offsets: Vec<usize>,
    branch_fixups: Vec<BranchFixup>,
    /// Per recorded branch, whether the layout pass chose the rel8 form;
    /// empty on the first pass.
    branch_short: Vec<bool>,
    /// `(lea_start, target_block)` per `Inst::BlockAddr`; the disp32 resolves
    /// against `block_offsets` once the layout is final.
    block_addr_fixups: Vec<(usize, u32)>,
    /// `(lea_start, table_idx)` per `Terminator::JumpTable`; each table is
    /// materialized into the read-only blob once the layout is final.
    jump_table_fixups: Vec<(usize, u32)>,
}

impl FnEmit<'_, '_> {
    /// Returns the function's unwind record, or `None` on a bail.
    fn run(&mut self, rodata: &mut super::RodataBuild) -> Emit<super::FnUnwind> {
        let func = self.fcx.func;
        let mut uw = self.emit_entry();
        uw.begin = self.start as u32;
        // `-pg` without `-mfentry`: `call mcount` once the frame stands, so
        // the callee reads the return address through rbp. It runs ahead of
        // the parameter placement, so `mcount` must keep the argument
        // registers, as the C library's does.
        if let Some(call) = self.entry.profile
            && call.after_prologue
        {
            emit_profile_call(
                self.out.cx.code,
                call,
                self.out.cx.asm_extern_call_sites,
                self.out.cx.mcount_sites,
            );
        }
        super::ssa::emit_common::record_post_prologue_pc(
            func,
            self.out.cx.prologue_native,
            self.out.cx.code.len(),
        );
        self.place_entry_params()?;
        let body = self.emit_body()?;
        self.patch_block_addrs()?;
        for r in &func.label_data_relocs {
            self.out.cx.label_relocs.push(super::LabelReloc {
                data_offset: r.data_offset,
                text_offset: self.block_offsets[r.block as usize] as u64,
            });
        }
        // `asm goto` section fields (`.long %l0 - .`) take the label block's
        // final text offset; only this function's relocs are rewritten.
        crate::c5::asm::resolve_asm_goto_relocs(
            self.out.cx.asm_sections.relocs_mut(),
            &body.asm_sections,
            &|bid| self.block_offsets[bid as usize],
        );
        self.patch_branches()?;
        self.materialize_jump_tables(rodata);
        uw.end = self.out.cx.code.len() as u32;
        Ok(uw)
    }

    /// The function entry: a naked function's body is its whole machine
    /// code, so it gets no prologue; otherwise `endbr64` under
    /// indirect-branch tracking, the patchable-entry NOPs, the `-mfentry`
    /// call, and the prologue.
    fn emit_entry(&mut self) -> super::FnUnwind {
        let FnCtx {
            func,
            alloc,
            frame,
            abi,
            ..
        } = self.fcx;
        let code = &mut *self.out.cx.code;
        if func.is_naked {
            code.resize(code.len() + self.entry.nops_after as usize, 0x90);
            return super::FnUnwind::default();
        }
        if abi.hardening.cf_protection_branch {
            super::encode::emit_endbr64(code);
        }
        code.resize(code.len() + self.entry.nops_after as usize, 0x90);
        if let Some(call) = self.entry.profile
            && !call.after_prologue
        {
            emit_profile_call(
                code,
                call,
                self.out.cx.asm_extern_call_sites,
                self.out.cx.mcount_sites,
            );
        }
        emit_prologue(
            code,
            func,
            alloc,
            frame,
            abi,
            self.start,
            self.out.cx.user_extern_data_refs,
        )
    }

    /// Place the entry `Inst::ParamRef` values from their argument registers
    /// as one parallel copy when their integer / spill homes are distinct;
    /// otherwise each `ParamRef` is placed in program order, which the
    /// allocator's self-home hint keeps sound (`verify_allocation` checks it
    /// under `codegen_test`).
    fn place_entry_params(&mut self) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            param_plan,
            ..
        } = self.fcx;
        let code = &mut *self.out.cx.code;
        let mut moves: Vec<(Place, Place)> = Vec::new();
        let mut exts: Vec<(Place, LoadKind)> = Vec::new();
        let mut vids: Vec<usize> = Vec::new();
        let mut homes: Vec<Place> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            // A dead `ParamRef` is skipped by the per-inst path; an FP home
            // stays on that path too.
            if super::ssa::emit_common::is_dead_pure(inst, vid as super::super::ir::ValueId, alloc)
            {
                continue;
            }
            let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
            if !matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
                continue;
            }
            // The plan names the incoming register: an earlier FP parameter
            // does not shift the integer bank. A stack-passed parameter has
            // no register source and reads its home cell per inst.
            let Some(super::ArgPlacement::IntReg(src)) = param_plan.get(*idx as usize).copied()
            else {
                continue;
            };
            moves.push((Place::IntReg(src), dst));
            vids.push(vid);
            homes.push(dst);
            // The callee performs the C99 6.5.2.2p4 conversion: an I8/I16
            // extend always, an I32 extend only when bits 32..63 are read.
            if matches!(kind, LoadKind::I8 | LoadKind::I16)
                || (matches!(kind, LoadKind::I32)
                    && alloc.high_observed.get(vid).copied().unwrap_or(true))
            {
                exts.push((dst, *kind));
            }
        }
        let homes_distinct = (0..homes.len())
            .all(|a| ((a + 1)..homes.len()).all(|b| !place_same_loc(homes[a], homes[b])));
        if moves.is_empty() || !homes_distinct {
            return Ok(());
        }
        // r10 / r11 are never argument registers nor in the allocator's
        // bank, so they cannot collide with a pending source or target.
        schedule_place_moves(code, &mut moves, frame, SCRATCH_R10, SCRATCH_R11)?;
        for (dst, kind) in exts {
            let ext = |code: &mut Vec<u8>, r: Reg| match kind {
                LoadKind::I8 => super::encode::emit_movsx_r_r8(code, r, r),
                LoadKind::I16 => super::encode::emit_movsx_r_r16(code, r, r),
                LoadKind::I32 => super::encode::emit_movsxd_r_r(code, r, r),
                _ => {}
            };
            match dst {
                Place::IntReg(r) => ext(code, Reg(r)),
                Place::Spill(slot) => {
                    let (sb, sp_off) = spill_slot_addr(frame, slot);
                    emit_mov_r_mem(code, SCRATCH_R10, sb, sp_off);
                    ext(code, SCRATCH_R10);
                    emit_mov_mem_r(code, sb, sp_off, SCRATCH_R10);
                }
                Place::None | Place::FpReg(_) => {}
            }
        }
        for vid in vids {
            self.param_prebatched[vid] = true;
        }
        Ok(())
    }

    /// The block loop. It runs once with every local branch in the rel32
    /// form and, when `relax_branches` finds shortenable branches, once
    /// more against the shortened layout, re-recording every offset-keyed
    /// datum. Returns the mark taken where the body begins.
    fn emit_body(&mut self) -> Emit<OutputMark> {
        let body = self.out.mark();
        loop {
            self.block_addr_fixups.clear();
            self.jump_table_fixups.clear();
            for block_idx in 0..self.fcx.func.blocks.len() {
                self.emit_block(block_idx)?;
            }
            if !self.branch_short.is_empty() {
                break;
            }
            let branches: Vec<(usize, usize, usize, bool)> = self
                .branch_fixups
                .iter()
                .map(|fx| {
                    let (opcode_start, long_size) = match fx.kind {
                        LocalBranchKind::Jmp => (fx.site - 1, 5),
                        LocalBranchKind::Jcc(_) => (fx.site - 2, 6),
                    };
                    (opcode_start, long_size, fx.target as usize, fx.pinned_long)
                })
                .collect();
            self.branch_short = relax_branches(&branches, &self.block_offsets);
            if !self.branch_short.iter().any(|&s| s) {
                break;
            }
            // pc_to_native is index-keyed and overwritten in place.
            self.out.restore(&body);
            self.block_offsets.fill(0);
            self.branch_fixups.clear();
        }
        Ok(body)
    }

    fn emit_block(&mut self, block_idx: usize) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            abi,
            target,
            variadic_targets,
            conv_targets,
            ..
        } = self.fcx;
        let block = &func.blocks[block_idx];
        self.block_offsets[block_idx] = self.out.cx.code.len();
        super::ssa::emit_common::record_block_start_pc(
            block_idx,
            block.start_pc,
            self.out.cx.pc_to_native,
            self.out.cx.code.len(),
        );
        if self
            .endbr_targets
            .contains(&(block_idx as super::super::ir::BlockId))
        {
            super::encode::emit_endbr64(self.out.cx.code);
        }
        // A direct call whose result the block returns lowers as `marshal;
        // epilogue; jmp` in the terminator; see `detect_tail_call`.
        let tail_call = detect_tail_call(
            func,
            block,
            abi,
            variadic_targets,
            conv_targets,
            self.ret_tags,
            target,
        );
        for v in block.inst_range.clone() {
            self.emit_block_inst(block, v, tail_call)?;
        }
        // Predecessor-exit moves for the phis at every successor's head.
        emit_phi_predecessor_moves(
            self.out.cx.code,
            block_idx as super::super::ir::BlockId,
            func,
            alloc,
            frame,
        )?;
        self.emit_terminator(block_idx, block, tail_call)
    }

    fn emit_block_inst(
        &mut self,
        block: &super::super::ir::Block,
        v: super::super::ir::ValueId,
        tail_call: Option<(usize, usize, &[u32])>,
    ) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            extern_data_names,
            ..
        } = self.fcx;
        let inst = &func.insts[v as usize];
        let place = place_of(alloc, v);
        // A naked function's machine code is exactly its inline asm.
        if func.is_naked && !matches!(inst, Inst::InlineAsm { .. }) {
            return Ok(());
        }
        if super::ssa::emit_common::is_dead_pure(inst, v, alloc) {
            return Ok(());
        }
        if self.param_prebatched[v as usize] {
            return Ok(());
        }
        // The tail call's argument setup is part of the terminator.
        if let Some((tail_pc, _, _)) = tail_call
            && (v as usize) == tail_pc
        {
            return Ok(());
        }
        super::ssa::emit_common::record_inst_src(
            func,
            v,
            self.out.cx.code.len(),
            self.out.cx.ssa_line_rows,
        );
        // `&&label`: a PC-relative lea whose disp32 resolves against this
        // function's block offsets once every block is laid out.
        if let Inst::BlockAddr(tb) = inst {
            let Some(rd) = int_or_spill_dst(place) else {
                return fail("BlockAddr: dst not int reg / spill");
            };
            let code = &mut *self.out.cx.code;
            let lea_start = code.len();
            super::encode::emit_lea_r_rip32(code, rd, 0);
            self.block_addr_fixups.push((lea_start, *tb));
            spill_dst_to_slot(code, place, rd, frame);
            return Ok(());
        }
        // `asm goto`: the label branches patch through this function's
        // branch fixups, which `emit_inst` has no access to.
        if let Inst::InlineAsm { asm, args } = inst
            && let Terminator::AsmGoto { table } = block.terminator
        {
            return emit_inline_asm(
                &mut self.out,
                asm,
                args,
                &self.fcx,
                Some(AsmGotoCtx {
                    row: &func.jump_tables[table as usize],
                    branch_fixups: &mut self.branch_fixups,
                    branch_short: &self.branch_short,
                }),
            );
        }
        let data_fixups_pre_inst = self.out.cx.data_fixups.len();
        emit_inst(&mut self.out, inst, v, place, &self.fcx).inspect_err(|_| {
            #[cfg(feature = "codegen_test")]
            if std::env::var("BADC_DUMP_SSA").is_ok() {
                eprintln!(
                    "ssa emit x86_64: bailed on inst v{v}: {:?} (place {:?})",
                    inst, place,
                );
            }
        })?;
        // An `ImmData` naming a cross-TU symbol: its local `.data` fixup
        // becomes a named reference.
        if let Inst::ImmData(_) = inst
            && let Some(name) = extern_data_names.get(&v)
            && self.out.cx.data_fixups.len() > data_fixups_pre_inst
        {
            let popped = self.out.cx.data_fixups.pop().unwrap();
            self.out
                .cx
                .user_extern_data_refs
                .push(super::UserExternDataRef {
                    instr_offset: popped.instr_offset,
                    symbol_name: name.clone(),
                    direct_pcrel: None,
                });
        }
        Ok(())
    }

    fn emit_terminator(
        &mut self,
        block_idx: usize,
        block: &super::super::ir::Block,
        tail_call: Option<(usize, usize, &[u32])>,
    ) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            abi,
            imports,
            ..
        } = self.fcx;
        match block.terminator {
            // A naked function's inline-asm body provides its own return.
            Terminator::Return(_) if func.is_naked => Ok(()),
            Terminator::Return(v) => {
                if let Some((tail_pc, target_pc, args)) = tail_call {
                    let fp_arg_mask = match &func.insts[tail_pc] {
                        Inst::Call { fp_arg_mask, .. } => *fp_arg_mask,
                        _ => 0,
                    };
                    emit_tail_call(
                        self.out.cx.code,
                        target_pc,
                        args,
                        alloc,
                        frame,
                        abi,
                        self.out.fixups,
                        func,
                        fp_arg_mask,
                        self.out.cx.asm_extern_call_sites,
                        self.out.cx.user_extern_data_refs,
                    )
                } else {
                    emit_return(
                        self.out.cx.code,
                        v,
                        alloc,
                        frame,
                        func,
                        abi,
                        self.out.cx.asm_extern_call_sites,
                        self.out.cx.user_extern_data_refs,
                    );
                    Ok(())
                }
            }
            Terminator::Jmp(t) | Terminator::FallThrough(t) => {
                self.jump_unless_next(block_idx, t);
                Ok(())
            }
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => self.emit_cond_branch(block_idx, cond, target, fall_through, true),
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => self.emit_cond_branch(block_idx, cond, target, fall_through, false),
            // Computed goto: `jmp r64` through the address `Inst::BlockAddr`
            // materialized.
            Terminator::GotoIndirect { target } => {
                let code = &mut *self.out.cx.code;
                let tplace = place_of(alloc, target);
                let Some(rt) = materialize_int(code, tplace, SCRATCH_R10, frame) else {
                    return fail("GotoIndirect: target Place not int reg / spill");
                };
                emit_hardened_jmp_r(code, rt, abi, self.out.cx.asm_extern_call_sites);
                Ok(())
            }
            // Table dispatch through the read-only blob; the preceding
            // bounds check proves the index in range. An image reads a
            // 32-bit table-relative entry and adds the base back; relocatable
            // output loads an 8-byte absolute entry.
            Terminator::JumpTable { idx, table } => {
                let code = &mut *self.out.cx.code;
                let iplace = place_of(alloc, idx);
                let Some(rt) = materialize_int(code, iplace, SCRATCH_R10, frame) else {
                    return fail("JumpTable: idx Place not int reg / spill");
                };
                // rt is an allocated register or r10, never r11. The lea's
                // disp32 reaches into the blob; the writer patches it.
                let lea_start = code.len();
                super::encode::emit_lea_r_rip32(code, SCRATCH_R11, 0);
                if self.abs_jump_tables {
                    super::encode::emit_mov_r_sib(code, SCRATCH_R10, SCRATCH_R11, rt, 8);
                } else {
                    super::encode::emit_movsxd_r_sib(code, SCRATCH_R10, SCRATCH_R11, rt, 4);
                    super::encode::emit_rr(code, Mnem::Add, 8, SCRATCH_R10, SCRATCH_R11);
                }
                emit_hardened_jmp_r(code, SCRATCH_R10, abi, self.out.cx.asm_extern_call_sites);
                self.jump_table_fixups.push((lea_start, table));
                Ok(())
            }
            // The label branches were lowered inside the `Inst::InlineAsm`;
            // only the fall-through edge (row entry 0) is emitted here.
            Terminator::AsmGoto { table } => {
                let fall = func.jump_tables[table as usize][0];
                self.jump_unless_next(block_idx, fall);
                Ok(())
            }
            // A sys-trampoline body: the indirect call already placed every
            // argument, so control forwards through the PLT slot and the
            // callee's `ret` returns to the original caller.
            Terminator::TailExt(binding_idx) => {
                let Some(import_index) = imports.index_of_binding(binding_idx) else {
                    return fail("TailExt: no import slot for binding");
                };
                self.out.cx.plt_call_fixups.push(PltCallFixup {
                    instr_offset: self.out.cx.code.len(),
                    import_index,
                    is_tail: true,
                    is_addr: false,
                });
                super::encode::emit_jmp_rel32(self.out.cx.code, 0);
                Ok(())
            }
            // Sealed after a noreturn call (C11 6.7.4p8): `ud2` so a
            // mis-marked returning call faults instead of running on.
            Terminator::Unreachable => {
                self.out.cx.code.extend_from_slice(&[0x0F, 0x0B]);
                Ok(())
            }
        }
    }

    /// `Bz` (`negate`) / `Bnz`: the fused compare when the allocator marked
    /// the condition, else `test rc, rc` with `je` / `jne`.
    fn emit_cond_branch(
        &mut self,
        block_idx: usize,
        cond: super::super::ir::ValueId,
        target: super::super::ir::BlockId,
        fall_through: super::super::ir::BlockId,
        negate: bool,
    ) -> Emit {
        let FnCtx {
            func, alloc, frame, ..
        } = self.fcx;
        if let Some(fused) = fused_branch_cc(func, alloc, cond, negate) {
            emit_fused_branch(
                self.out.cx.code,
                &mut self.branch_fixups,
                &self.branch_short,
                fused,
                target,
                fall_through,
            );
        } else {
            let code = &mut *self.out.cx.code;
            let cond_place = place_of(alloc, cond);
            let Some(rc) = materialize_int(code, cond_place, SCRATCH_R10, frame) else {
                return fail(if negate {
                    "Bz: cond Place not int reg / spill / fp"
                } else {
                    "Bnz: cond Place not int reg / spill / fp"
                });
            };
            super::encode::emit_rr(code, Mnem::Test, 8, rc, rc);
            let cc = if negate { Cc::E } else { Cc::Ne };
            self.emit_local(LocalBranchKind::Jcc(cc), target);
        }
        self.jump_unless_next(block_idx, fall_through);
        Ok(())
    }

    fn emit_local(&mut self, kind: LocalBranchKind, target: super::super::ir::BlockId) {
        emit_local_branch(
            self.out.cx.code,
            &mut self.branch_fixups,
            &self.branch_short,
            kind,
            target,
        );
    }

    /// A `jmp` to `t` unless it is the next block in layout.
    fn jump_unless_next(&mut self, block_idx: usize, t: super::super::ir::BlockId) {
        if t as usize != block_idx + 1 {
            self.emit_local(LocalBranchKind::Jmp, t);
        }
    }

    /// Patch each `&&label` lea: the disp32 sits 3 bytes into the 7-byte
    /// instruction and is measured from its end.
    fn patch_block_addrs(&mut self) -> Emit {
        for &(lea_start, target_block) in &self.block_addr_fixups {
            let target_off = self.block_offsets[target_block as usize] as i64;
            let rel = target_off - (lea_start as i64 + super::encode::LEA_RIP32_LEN as i64);
            let Ok(imm) = i32::try_from(rel) else {
                return fail("BlockAddr: lea disp32 out of range");
            };
            self.out.cx.code[lea_start + 3..lea_start + 7].copy_from_slice(&imm.to_le_bytes());
        }
        Ok(())
    }

    /// Patch the recorded branches. The displacement is measured from the
    /// byte after the field: `site + 1` for rel8, `site + 4` for rel32;
    /// `relax_branches` guarantees a short branch's target is in range.
    fn patch_branches(&mut self) -> Emit {
        let code = &mut *self.out.cx.code;
        for fx in &self.branch_fixups {
            let target_off = self.block_offsets[fx.target as usize];
            if fx.short {
                let rel = (target_off as i64) - (fx.site as i64 + 1);
                let Ok(imm) = i8::try_from(rel) else {
                    return fail("branch fixup: rel8 out of range");
                };
                code[fx.site] = imm as u8;
            } else {
                let rel = (target_off as i64) - (fx.site as i64 + 4);
                let Ok(imm) = i32::try_from(rel) else {
                    return fail("branch fixup: rel32 out of range");
                };
                code[fx.site..fx.site + 4].copy_from_slice(&imm.to_le_bytes());
            }
        }
        Ok(())
    }

    /// Materialize each jump table into the read-only blob: an address fixup
    /// for the lea site, then one slot per entry (a 4-byte table-relative
    /// difference, or the relocatable form's 8-byte absolute address).
    fn materialize_jump_tables(&mut self, rodata: &mut super::RodataBuild) {
        let width: usize = if self.abs_jump_tables { 8 } else { 4 };
        for &(lea_start, table) in &self.jump_table_fixups {
            while !rodata.bytes.len().is_multiple_of(width) {
                rodata.bytes.push(0);
            }
            let base = rodata.bytes.len() as u64;
            rodata.addr_fixups.push(super::RodataAddrFixup {
                code_offset: lea_start,
                rodata_offset: base,
            });
            for (i, &t) in self.fcx.func.jump_tables[table as usize].iter().enumerate() {
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

/// Which local branches take the 2-byte rel8 form instead of the 5 / 6-byte
/// rel32 form. `branches` holds `(opcode_start, long_size, target_block,
/// pinned_long)` per branch in emission order against the all-long layout
/// in `block_offsets`; a pinned branch stays long. Shortening one branch
/// only reduces the other displacements, so the set is a monotone
/// fixpoint: a branch is marked short once its displacement, less the
/// bytes the branches marked so far remove and excluding its own saving,
/// fits a signed byte, so a short branch fits in the final layout.
pub(super) fn relax_branches(
    branches: &[(usize, usize, usize, bool)],
    block_offsets: &[usize],
) -> alloc::vec::Vec<bool> {
    let n = branches.len();
    let mut short = alloc::vec![false; n];
    loop {
        // prefix[k] = bytes removed by short branches among branches[0..k].
        // `opcode_start` is non-decreasing in emission order, so the bytes
        // removed before an offset are a prefix indexed by partition_point.
        let mut prefix = alloc::vec![0usize; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + if short[i] { branches[i].1 - 2 } else { 0 };
        }
        let saved_before =
            |off: usize| -> usize { prefix[branches.partition_point(|b| b.0 < off)] };
        let mut changed = false;
        for i in 0..n {
            if short[i] || branches[i].3 {
                continue;
            }
            let (opcode_start, _long, target, _) = branches[i];
            let instr_end = (opcode_start - saved_before(opcode_start)) + 2;
            let tgt = block_offsets[target] - saved_before(block_offsets[target]);
            let rel = tgt as i64 - instr_end as i64;
            if (-128..=127).contains(&rel) {
                short[i] = true;
                changed = true;
            }
        }
        if !changed {
            break;
        }
    }
    short
}

/// Store a word through rsp to take the fault, if the stack ends here,
/// on the page the allocation just entered. Immediate source and
/// `mov`'s flag transparency keep the probe usable at any point in the
/// lowering: it needs no register and preserves the flags.
pub(super) fn emit_stack_probe(code: &mut Vec<u8>) {
    super::encode::emit_mi(code, Mnem::Mov, 8, Reg::RSP, 0, 0);
}

/// Reserve the realigned region and align rsp down to `realign_align` (C11
/// 6.7.5). The AND descends up to `realign_align - 1` bytes the probe
/// schedule cannot see; when that can outrun the unprobed margin, a probe
/// on each side keeps every step within a page of a touched address.
fn emit_realign_rsp(code: &mut Vec<u8>, frame: Frame) {
    let slack = frame.realign_align - 1;
    let probe = frame.realign_region_bytes.saturating_add(slack) > MAX_UNPROBED_STACK_STEP;
    emit_stack_alloc(code, frame.realign_region_bytes, Some(Reg::R11));
    if probe {
        emit_stack_probe(code);
    }
    super::encode::emit_ri(code, Mnem::And, 8, Reg::RSP, -(frame.realign_align as i32));
    if probe {
        emit_stack_probe(code);
    }
}

/// `rsp -= bytes`. A decrement of at most [`MAX_UNPROBED_STACK_STEP`]
/// cannot pass the guard region; past that rsp walks down a page at a time
/// with a store after each step, so an overflow faults in the guard. Given
/// `scratch`, more than [`STACK_PROBE_UNROLL_MAX`] steps become a counted
/// loop.
pub(super) fn emit_stack_alloc(code: &mut Vec<u8>, bytes: u32, scratch: Option<Reg>) {
    if bytes <= MAX_UNPROBED_STACK_STEP {
        emit_sub_rsp_imm32(code, bytes);
        return;
    }
    let steps = bytes / STACK_PROBE_PAGE;
    let residual = bytes % STACK_PROBE_PAGE;
    match scratch {
        Some(counter) if steps > STACK_PROBE_UNROLL_MAX => {
            super::encode::emit_mov_r_imm64(code, counter, steps as i64);
            let loop_start = code.len();
            emit_sub_rsp_imm32(code, STACK_PROBE_PAGE);
            emit_stack_probe(code);
            super::encode::emit_ri(code, Mnem::Sub, 8, counter, 1);
            super::encode::emit_jcc_rel32(code, super::encode::Cc::Ne, 0);
            let rel = ((loop_start as i64) - (code.len() as i64)) as i32;
            let patch_at = code.len() - 4;
            code[patch_at..patch_at + 4].copy_from_slice(&rel.to_le_bytes());
        }
        _ => {
            for _ in 0..steps {
                emit_sub_rsp_imm32(code, STACK_PROBE_PAGE);
                emit_stack_probe(code);
            }
        }
    }
    if residual > 0 {
        emit_sub_rsp_imm32(code, residual);
        if residual > MAX_UNPROBED_STACK_STEP {
            emit_stack_probe(code);
        }
    }
}

/// Save the callee-saved registers the allocator reported: the non-volatile
/// xmm scratch at the frame bottom (full 128-bit `movups`, the caller may
/// use the upper lanes) and the callee-saved GPRs above it. The offsets
/// have one source, so the prologue and every return path agree.
fn save_callee_saved(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame) {
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        emit_movups_mem_xmm(code, Reg::RSP, (i as i32) * 16, Reg(r));
    }
    let saved_fpr_bytes = frame.saved_fpr_bytes as i32;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        super::encode::emit_mov_mem_r(code, Reg::RSP, saved_fpr_bytes + (i as i32) * 8, Reg(r));
    }
}

/// Re-establish `rsp = rbp - frame_bytes` in a dynamic-sp frame before
/// the epilogue's rsp-relative restores. No-op for static frames. Every
/// return path calls this ahead of [`restore_callee_saved`].
fn restore_dynamic_sp(code: &mut Vec<u8>, frame: Frame) {
    if frame.dynamic_sp {
        emit_lea_r_mem(code, Reg::RSP, Reg::RBP, -(frame.frame_bytes as i32));
    }
}

/// Restore what [`save_callee_saved`] saved, in mirror order. Every return
/// path routes through this so the saved-region offsets cannot drift.
pub(super) fn restore_callee_saved(code: &mut Vec<u8>, alloc: &Allocation, frame: Frame) {
    let saved_fpr_bytes = frame.saved_fpr_bytes as i32;
    for (i, &r) in alloc.gpr_used.iter().enumerate() {
        super::encode::emit_mov_r_mem(code, Reg(r), Reg::RSP, saved_fpr_bytes + (i as i32) * 8);
    }
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        emit_movups_xmm_mem(code, Reg(r), Reg::RSP, (i as i32) * 16);
    }
}

/// The prologue: the argument registers spilled into the c5 cdecl cells the
/// body addresses as locals with slot `N >= 2` (`[rbp + 16*(N-1)]`), then
/// the frame and the callee-saved registers. The return address sits above
/// the cells, so it is popped into r10 and pushed back after the cells are
/// filled. `func_start` is `code.len()` at entry; the returned
/// [`super::FnUnwind`] records each prologue instruction boundary relative
/// to it for the PE unwind table (`begin` / `end` are the caller's).
fn emit_prologue(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    func_start: usize,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) -> super::FnUnwind {
    let mut uw = super::FnUnwind {
        param_spill_bytes: frame.param_spill_bytes,
        frame_bytes: frame.frame_bytes,
        ..super::FnUnwind::default()
    };
    let rel = |code: &Vec<u8>| (code.len() - func_start) as u32;
    // `frame.param_spill_bytes` is read by the epilogue too; it is 0, and the
    // return address stays where the caller pushed it, for a variadic callee,
    // a fully elided one and a zero-parameter one.
    let entry_spill = if func.is_variadic { 0 } else { func.n_params };
    if entry_spill > 0 && frame.param_spill_bytes > 0 {
        emit_pop_r(code, Reg::R10);
        let (elidable, _n_reg, _n_stack) = param_elidable_mask(func, alloc, abi);
        let placements = param_placements(func, abi);
        // `n_params` 16-byte cells; parameter `i` reads cell `[rsp + 16*i]`
        // (`[rbp + 16*(i+1)]` once the frame stands). The incoming argument area
        // begins at `[rsp + cells]`. Each cell fills from its own placement, so
        // register-passed and stack-passed parameters may interleave (a System V
        // MEMORY-class aggregate between register parameters, or a Win64
        // aggregate past the positional registers).
        let cells = frame.param_spill_bytes;
        debug_assert_eq!(cells, (func.n_params as u32) * 16);
        // The argument registers hold the incoming values and r10 the
        // popped return address, so the walk takes no scratch register.
        emit_stack_alloc(code, cells, None);
        for i in 0..func.n_params {
            let cell = (i as i32) * 16;
            match placements.get(i).copied() {
                // A register parameter whose home cell is unobserved
                // (mem2reg promoted it, no LocalAddr / live LoadLocal)
                // has a dead store per C99 6.2.4p2; the cell stays
                // reserved so the other parameters keep their offsets.
                Some(super::ArgPlacement::IntReg(r)) => {
                    if !elidable.get(i).copied().unwrap_or(false) {
                        emit_mov_mem_r(code, Reg::RSP, cell, Reg(r));
                    }
                }
                Some(super::ArgPlacement::FpReg(x)) => {
                    if !elidable.get(i).copied().unwrap_or(false) {
                        emit_movsd_mem_xmm(code, Reg::RSP, cell, Reg(x));
                    }
                }
                // Stack-overflow scalar: restripe from the incoming stack
                // into the cell. `off` already includes any shadow space.
                Some(super::ArgPlacement::Stack(off)) => {
                    let src = (cells as i32) + off as i32;
                    emit_mov_r_mem(code, Reg::RAX, Reg::RSP, src);
                    emit_mov_mem_r(code, Reg::RSP, cell, Reg::RAX);
                }
                // Aggregate parameters keep a dead cell; their value is
                // placed later from the argument registers
                // (`emit_struct_param_scatter`) or copied from the
                // incoming stack (`emit_struct_stack_param_copy`).
                _ => {}
            }
        }
        emit_push_r(code, Reg::R10);
        // Net stack effect of the group is -M; the unwinder recovers
        // it as one UWOP_ALLOC at the end of the re-push.
        uw.arg_spill_end = rel(code);
    }

    // A full leaf has no prologue work: it returns off the caller-pushed
    // return address with rsp unchanged.
    if is_full_leaf(func, frame, alloc, abi) {
        uw.leaf = true;
        return uw;
    }
    // Standard frame: push rbp; mov rbp, rsp; sub rsp, frame_bytes.
    emit_push_r(code, Reg::RBP);
    uw.push_rbp_end = rel(code);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);
    uw.set_fpreg_end = rel(code);
    // Win64 variadic callee: rcx/rdx/r8/r9 spill into the 32-byte home area at
    // `[rbp + 16 + i*8]`, which joins the incoming stack into one 8-byte-stride
    // region the body reads through its cells (stride 8) and `va_arg` walks.
    // All four spill, named or not, since a variadic argument in a register
    // must reach the home area and the caller reserves the full area.
    if win64_variadic_callee(func, abi) {
        for (i, &reg) in abi.int_arg_regs.iter().enumerate() {
            let home_off = (16 + i * 8) as i32;
            emit_mov_mem_r(code, Reg::RBP, home_off, Reg(reg));
        }
    }
    if frame.frame_bytes > 0 {
        // A single `sub rsp, N` is describable with `UWOP_ALLOC`; a probed frame
        // stays undescribed (`frame_alloc_end == 0`), the frame-pointer rule
        // recovering rsp at any body fault.
        let single_sub = frame.frame_bytes <= MAX_UNPROBED_STACK_STEP;
        // r11 is caller-saved, is no target's argument register, and
        // carries no live value in the prologue.
        emit_stack_alloc(code, frame.frame_bytes, Some(Reg::R11));
        if single_sub {
            uw.frame_alloc_end = rel(code);
        }
    }
    // System V variadic callee: rdi rsi rdx rcx r8 r9 spill into the gp area
    // at `[reg_save .. 48]` and xmm0..xmm7 into the fp area at
    // `[reg_save + 48 .. 176]` (ABI 3.5.7), through rbp so the body's rsp
    // moves do not matter. The named parameters read from there too
    // (`local_slot_off`). The XMM spill is guarded by `al`, the caller's XMM
    // count (ABI 3.2.3); the integer spill is unconditional.
    if sysv_variadic_callee(func, abi) {
        let reg_save = frame.va_reg_save_off;
        for (i, &reg) in abi.int_arg_regs.iter().enumerate() {
            emit_mov_mem_r(code, Reg::RBP, reg_save + (i as i32) * 8, Reg(reg));
        }
        // Under `-mno-sse` the XMM save is omitted entirely: the target
        // environment faults on any XMM access and its callers do not
        // maintain the `al` count, so even the guarded form is unsafe.
        if !abi.no_fp_varargs {
            // test al, al ; je past_fp_save
            super::encode::emit_test_al_al(code);
            super::encode::emit_jcc_rel32(code, Cc::E, 0);
            // The rel32 operand occupies the four bytes just emitted; the
            // jump is relative to the end of the je instruction (which is
            // where the XMM stores begin).
            let rel32_at = code.len() - 4;
            let fp_save_start = code.len();
            for i in 0..8u32 {
                let off = reg_save + SYSV_GP_SAVE_BYTES as i32 + (i as i32) * 16;
                emit_movsd_mem_xmm(code, Reg::RBP, off, Reg(i as u8));
            }
            let rel = (code.len() - fp_save_start) as i32;
            code[rel32_at..rel32_at + 4].copy_from_slice(&rel.to_le_bytes());
        }
    }
    // The allocator never assigns a non-volatile xmm (`callee_fprs` is empty);
    // `fp_used` lists the fixed FP scratch of a Win64 function doing FP work,
    // saved at the frame bottom with the full 128-bit `movups`.
    save_callee_saved(code, alloc, frame);
    emit_struct_param_scatter(code, func, frame, abi);
    emit_struct_stack_param_copy(code, func, frame, abi);
    // After the parameter marshalling, which uses the same scratch, and
    // before the realign: the slot is rbp-relative, so the rsp move that
    // follows does not reach it.
    emit_canary_store(code, frame, abi, extern_data_refs);
    // C11 6.7.5: the over-aligned region below the static frame, after the
    // callee-saved stores (which stay at rbp - frame_bytes, where
    // `restore_dynamic_sp` puts rsp back); reserving before aligning keeps
    // the AND inside the reserved bytes.
    if frame.realign_align > 0 {
        emit_realign_rsp(code, frame);
    }
    uw
}

/// Copy each aggregate parameter passed inline on the stack (System V
/// AMD64 MEMORY class over 16 bytes, or a Win64 aggregate past the four
/// positional registers) from the caller's outgoing area at
/// `[rbp + 16 + n_params*16 + off]` into its parser-reserved body local;
/// the entry cell reserved for it keeps the slot-to-cell map positional.
fn emit_struct_stack_param_copy(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    if !placements
        .iter()
        .any(|p| matches!(p, super::ArgPlacement::StructStack { .. }))
    {
        return;
    }
    let base = 16 + (func.n_params as i64) * 16;
    for (i, &placement) in placements.iter().enumerate() {
        let super::ArgPlacement::StructStack { off, size, .. } = placement else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        let src_off = base + off as i64;
        let dst_off = local_slot_off(slot, func, frame, abi);
        let words = (size / 8) as i64;
        for w in 0..words {
            let o = w * 8;
            emit_mov_r_mem(code, SCRATCH_R10, Reg::RBP, (src_off + o) as i32);
            emit_mov_mem_r(code, Reg::RBP, (dst_off + o) as i32, SCRATCH_R10);
        }
        for b in (words * 8)..(size as i64) {
            super::encode::emit_movzx_r_mem8(code, SCRATCH_R10, Reg::RBP, (src_off + b) as i32);
            super::encode::emit_mov_mem8_r(code, Reg::RBP, (dst_off + b) as i32, SCRATCH_R10);
        }
    }
}

/// Store each register-passed aggregate parameter's argument registers
/// (System V AMD64 3.2.3), still intact at this point, into its
/// parser-reserved body local.
fn emit_struct_param_scatter(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_placements(func, abi);
    for (i, agg) in func.param_aggs.iter().enumerate() {
        if agg.is_none() {
            continue;
        }
        let Some(super::ArgPlacement::StructRegs { regs, n, .. }) = placements.get(i) else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        let base = local_slot_off(slot, func, frame, abi);
        for (k, cr) in regs.iter().take(*n as usize).enumerate() {
            let off = (base + (k as i64) * 8) as i32;
            if cr.is_fp {
                super::encode::emit_movsd_mem_xmm(code, Reg::RBP, off, Reg(cr.reg));
            } else {
                super::encode::emit_mov_mem_r(code, Reg::RBP, off, Reg(cr.reg));
            }
        }
    }
}

fn emit_return(
    code: &mut Vec<u8>,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    // A return value in a callee-saved register stages through rcx
    // (caller-saved, never in `gpr_used`) across the restore; any other
    // source moves into rax after it. The integer mirror of an FP return
    // into rax follows the restore too.
    let return_place = if value != super::super::ir::NO_VALUE {
        place_of(alloc, value)
    } else {
        Place::None
    };
    // A register-returned aggregate (System V AMD64 3.2.3): `value` is its
    // address, staged through rcx across the restore; the eightbytes load
    // into rax:rdx / xmm0:xmm1 after it.
    if let Some(ai) = func.ret_agg {
        let desc = &func.agg_descs[ai as usize];
        let eb_classes = match super::abi_classify::classify_aggregate(
            desc.size,
            desc.align,
            &desc.fields,
            abi,
            true,
        ) {
            super::abi_classify::AggClass::Regs(c) => c,
            _ => alloc::vec::Vec::new(),
        };
        match return_place {
            Place::IntReg(r) => {
                if r != Reg::RCX.0 {
                    emit_mov_rr(code, Reg::RCX, Reg(r));
                }
            }
            Place::Spill(slot) => {
                let (sb, sp_off) = spill_slot_addr(frame, slot);
                super::encode::emit_mov_r_mem(code, Reg::RCX, sb, sp_off);
            }
            _ => {}
        }
        restore_dynamic_sp(code, frame);
        restore_callee_saved(code, alloc, frame);
        // Place each eightbyte in its bank: System V returns SSE eightbytes
        // in xmm0/xmm1 and INTEGER eightbytes in rax/rdx, each in order.
        let int_ret = [Reg::RAX, Reg::RDX];
        let mut int_i = 0usize;
        let mut sse_i = 0u8;
        for (k, class) in eb_classes.iter().enumerate() {
            let off = (k as i32) * 8;
            if matches!(class, super::abi_classify::RegClass::Sse) {
                emit_agg_load_sse(
                    code,
                    Reg(Reg::XMM0.0 + sse_i),
                    Reg::RCX,
                    off,
                    desc.align,
                    abi.strict_align,
                    SCRATCH_R10,
                );
                sse_i += 1;
            } else {
                emit_agg_load_int(
                    code,
                    int_ret[int_i],
                    Reg::RCX,
                    off,
                    8,
                    desc.align,
                    abi.strict_align,
                    SCRATCH_R10,
                );
                int_i += 1;
            }
        }
        emit_epilogue_ret(
            code,
            func,
            frame,
            alloc,
            abi,
            extern_sites,
            extern_data_refs,
        );
        return;
    }
    // An FP return rides xmm0 (C99 6.2.5p10); the declared type decides, since
    // an FP constant or an integer-classed producer leaves the bits in a GPR,
    // which `materialize_fp` reinterprets.
    let return_is_fp = func.ret_is_fp
        || matches!(return_place, Place::FpReg(_))
        || (value != super::super::ir::NO_VALUE
            && (value as usize) < func.insts.len()
            && super::ssa::reg_alloc::produces_fp_result(&func.insts[value as usize]));
    let needs_staging = matches!(return_place, Place::IntReg(r) if alloc.gpr_used.contains(&r));
    // An integer return in a callee-saved register moves to rax before the
    // restore: rax is caller-saved, so one `mov` replaces the rcx staging.
    let staged_rax = needs_staging && !return_is_fp;
    if staged_rax
        && let Place::IntReg(r) = return_place
        && r != Reg::RAX.0
    {
        emit_mov_rr(code, Reg::RAX, Reg(r));
    }
    let staged_int = if needs_staging && !staged_rax {
        match return_place {
            Place::IntReg(r) if r != Reg::RCX.0 => {
                emit_mov_rr(code, Reg::RCX, Reg(r));
                true
            }
            Place::IntReg(_) => true,
            Place::Spill(slot) => {
                let (sb, sp_off) = spill_slot_addr(frame, slot);
                super::encode::emit_mov_r_mem(code, Reg::RCX, sb, sp_off);
                true
            }
            _ => false,
        }
    } else {
        false
    };
    if return_is_fp {
        // the first FP scratch is outside the allocator's pool, so a
        // spilled f64 lands there without clobbering an
        // allocator-held xmm.
        if let Some(dn) = materialize_fp(code, return_place, Reg(frame.fp_scratch[0]), frame)
            && dn.0 != Reg::XMM0.0
        {
            emit_movapd_xmm_xmm(code, Reg::XMM0, dn);
        }
    }
    // Restore callee-saved GPRs and saved non-volatile xmm scratch
    // (mirror of the prologue's saves: xmm at the bottom, GPRs above).
    restore_dynamic_sp(code, frame);
    restore_callee_saved(code, alloc, frame);
    if staged_int {
        emit_mov_rr(code, Reg::RAX, Reg::RCX);
    } else if !needs_staging {
        // No callee-saved restore to navigate around; place the
        // return value into rax directly. A source that already
        // lives in rax needs no instruction.
        match return_place {
            Place::IntReg(r) if r != Reg::RAX.0 => {
                emit_mov_rr(code, Reg::RAX, Reg(r));
            }
            Place::Spill(slot) => {
                let (sb, sp_off) = spill_slot_addr(frame, slot);
                super::encode::emit_mov_r_mem(code, Reg::RAX, sb, sp_off);
            }
            _ => {}
        }
    }
    // A floating-point return value is delivered in xmm0 only (SysV
    // AMD64 / Win64: scalar floating returns in xmm0). The receiving
    // call site is FP-classed (`Inst::Call::fp_return`) and reads
    // xmm0, so no rax mirror is emitted.
    emit_epilogue_ret(
        code,
        func,
        frame,
        alloc,
        abi,
        extern_sites,
        extern_data_refs,
    );
}

/// Frame teardown and `ret` after the callee-saved restores: drop the frame,
/// pop rbp, drop the c5 cdecl cells with the return address parked in r11.
/// `frame.param_spill_bytes` is the value the prologue used. A full leaf
/// needs only the `ret`.
fn emit_epilogue_ret(
    code: &mut Vec<u8>,
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    emit_canary_check(code, frame, abi, extern_sites, extern_data_refs);
    if !is_full_leaf(func, frame, alloc, abi) {
        if frame.frame_bytes > 0 {
            emit_add_rsp_imm32(code, frame.frame_bytes);
        }
        emit_pop_r(code, Reg::RBP);
        if frame.param_spill_bytes > 0 {
            emit_pop_r(code, Reg::R11);
            emit_add_rsp_imm32(code, frame.param_spill_bytes);
            emit_push_r(code, Reg::R11);
        }
    }
    emit_hardened_ret(code, abi, extern_sites);
}

/// Scratch for the stack-protector sequences: caller-saved, no ABI argument
/// or return register, and holding nothing live where the sequences run.
const CANARY_SCRATCH: Reg = Reg::R11;

/// Leave the guard value in `rd`. `-mstack-protector-guard=tls` reads
/// thread storage through a segment override -- at a fixed offset, or at a
/// named object's PC-relative address when a guard symbol is given. The
/// `global` form reads the object the target's C library exports.
fn emit_load_stack_guard(
    code: &mut Vec<u8>,
    rd: Reg,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    let ssp = abi.stack_protect;
    let symbol = ssp.guard_symbol.as_str();
    let super::StackGuard::Tls { seg, offset } = ssp.guard else {
        // `global`: the writer turns the `lea` into a GOT load of the
        // object's address, so a second load reaches its contents.
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
        super::encode::emit_lea_r_rip32(code, rd, 0);
        emit_mov_r_mem(code, rd, rd, 0);
        return;
    };
    let prefix = match seg {
        super::GuardSeg::Fs => 0x64,
        super::GuardSeg::Gs => 0x65,
    };
    code.push(prefix);
    code.push(if rd.high() { 0x4C } else { 0x48 });
    code.push(0x8B);
    if symbol.is_empty() {
        // `mov rd, seg:offset`: mod=00 r/m=100 (SIB) with base=101,
        // index=100 -- the disp32-only addressing form.
        code.push(0x04 | (rd.lo() << 3));
        code.push(0x25);
        code.extend_from_slice(&offset.to_le_bytes());
        return;
    }
    // `mov rd, seg:sym(%rip)`: mod=00 r/m=101. The named object supplies
    // the whole address, so the displacement carries only the -4 that
    // measures it from the end of the instruction. The relocation is
    // anchored at the REX byte, three bytes ahead of the displacement.
    let instr_offset = code.len() - 2;
    code.push(0x05 | (rd.lo() << 3));
    code.extend_from_slice(&0i32.to_le_bytes());
    extern_data_refs.push(super::UserExternDataRef {
        instr_offset,
        symbol_name: symbol.into(),
        direct_pcrel: Some(-4),
    });
}

/// Prologue half of the stack protector: store the guard into the canary
/// slot at `[rbp - 8]`, above every local and below the saved rbp, then
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
    emit_mov_mem_r(
        code,
        Reg::RBP,
        super::ssa::emit_common::CANARY_SLOT_OFF,
        CANARY_SCRATCH,
    );
    emit_rr(code, Mnem::Xor, 8, CANARY_SCRATCH, CANARY_SCRATCH);
}

/// Epilogue half: compare the canary slot against the guard and call
/// `__stack_chk_fail` when they differ. Emitted on every path that leaves
/// the frame, ahead of the teardown, while rbp still addresses the slot.
pub(super) fn emit_canary_check(
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
    emit_rm(
        code,
        Mnem::Cmp,
        8,
        CANARY_SCRATCH,
        Reg::RBP,
        super::ssa::emit_common::CANARY_SLOT_OFF,
    );
    super::encode::emit_jcc_rel8(code, Cc::E, 0);
    let rel8_at = code.len() - 1;
    emit_extern_branch(code, extern_sites, super::STACK_CHK_FAIL_SYMBOL, true);
    code[rel8_at] = (code.len() - rel8_at - 1) as u8;
    emit_rr(code, Mnem::Xor, 8, CANARY_SCRATCH, CANARY_SCRATCH);
}

/// A branch to a symbol this unit does not define: `E8` / `E9 rel32` with
/// a zero displacement and a by-name call site for the writer's
/// relocation.
fn emit_extern_branch(
    code: &mut Vec<u8>,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    symbol: &str,
    is_call: bool,
) {
    extern_sites.push(super::UserExternCallSite {
        instr_offset: code.len(),
        symbol_name: symbol.into(),
        is_tail: !is_call,
    });
    if is_call {
        super::encode::emit_call_rel32(code, 0);
    } else {
        super::encode::emit_jmp_rel32(code, 0);
    }
}

/// The `-pg` call site: `call __fentry__` / `call mcount` relocated by
/// name, or under `-mnop-mcount` a NOP of the call's width in its place.
/// `-mrecord-mcount` records the site either way.
fn emit_profile_call(
    code: &mut Vec<u8>,
    call: super::ProfileCall,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    mcount_sites: &mut Vec<usize>,
) {
    mcount_sites.push(code.len());
    if call.nop {
        code.extend_from_slice(&[0x0F, 0x1F, 0x44, 0x00, 0x00]);
    } else {
        emit_extern_branch(code, extern_sites, call.symbol(), true);
    }
}

/// Function return. `-mfunction-return=thunk-extern` replaces `ret` with
/// a jump to the external return thunk, which returns itself; the
/// straight-line-speculation trap then has no `ret` to guard.
fn emit_hardened_ret(
    code: &mut Vec<u8>,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    if abi.hardening.function_return_thunk {
        emit_extern_branch(
            code,
            extern_sites,
            super::encode::RETURN_THUNK_SYMBOL,
            false,
        );
        return;
    }
    emit_ret(code);
    if abi.hardening.sls_return {
        super::encode::emit_int3(code);
    }
}

/// `mov %reg, (%rsp)`: overwrite the return address the retpoline's
/// `call` pushed with the real branch target, so its `ret` transfers
/// there with the return predictor pinned to the capture loop.
fn emit_mov_r_to_rsp_slot(code: &mut Vec<u8>, target: Reg) {
    code.push(if target.0 >= 8 { 0x4C } else { 0x48 });
    code.push(0x89);
    code.push(0x04 | ((target.0 & 7) << 3));
    code.push(0x24);
}

/// The retpoline capture: `pause; lfence; jmp .-7`, then the slot
/// overwrite and `ret`. Entered by a `call` whose displacement lands
/// on the `mov`; the pushed return address keeps speculation in the
/// loop. Mirrors gcc's `-mindirect-branch=thunk-inline` body.
fn emit_retpoline_capture(code: &mut Vec<u8>, target: Reg) {
    code.extend_from_slice(&[0xF3, 0x90]); // pause
    code.extend_from_slice(&[0x0F, 0xAE, 0xE8]); // lfence
    code.extend_from_slice(&[0xEB, 0xF9]); // jmp back over both
    emit_mov_r_to_rsp_slot(code, target);
    code.push(0xC3); // ret
}

/// Indirect call through `target`: a direct call to the register's thunk
/// under `-mindirect-branch=thunk-extern`, the embedded retpoline (gcc's
/// shape) under `thunk-inline`. A call has an architectural successor, so
/// `-mharden-sls=` places no trap here.
pub(super) fn emit_hardened_call_r(
    code: &mut Vec<u8>,
    target: Reg,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    use crate::c5::codegen::IndirectBranch;
    match abi.hardening.indirect_branch {
        IndirectBranch::ThunkExtern => {
            let symbol = super::encode::indirect_thunk_symbol(target);
            emit_extern_branch(code, extern_sites, symbol, true);
        }
        IndirectBranch::ThunkInline => {
            code.extend_from_slice(&[0xEB, 0x11]); // jmp over the thunk body
            code.extend_from_slice(&[0xE8, 0x07, 0x00, 0x00, 0x00]); // call the capture
            emit_retpoline_capture(code, target);
            // call back into the thunk head; the pushed address is the
            // continuation after this site.
            code.extend_from_slice(&[0xE8, 0xEA, 0xFF, 0xFF, 0xFF]);
        }
        IndirectBranch::Keep => super::encode::emit_call_r(code, target),
    }
}

/// Indirect jump through `target`, through the register's thunk or the
/// embedded retpoline under `-mindirect-branch=`;
/// `-mharden-sls=indirect-jmp` traps after the transfer in every form.
fn emit_hardened_jmp_r(
    code: &mut Vec<u8>,
    target: Reg,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    use crate::c5::codegen::IndirectBranch;
    match abi.hardening.indirect_branch {
        IndirectBranch::ThunkExtern => {
            let symbol = super::encode::indirect_thunk_symbol(target);
            emit_extern_branch(code, extern_sites, symbol, false);
        }
        IndirectBranch::ThunkInline => {
            code.extend_from_slice(&[0xE8, 0x07, 0x00, 0x00, 0x00]); // call the capture
            emit_retpoline_capture(code, target);
        }
        IndirectBranch::Keep => super::encode::emit_jmp_r(code, target),
    }
    if abi.hardening.sls_indirect_jmp {
        super::encode::emit_int3(code);
    }
}
