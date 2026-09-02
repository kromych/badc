use super::*;

/// Resolve a set of register-to-register copies `(src, tgt)` so
/// no copy writes to a register still needed as the source of
/// another pending copy. Mirrors the AArch64 emit's scheduler:
/// drain leaves (target not a source of any other pending move)
/// first, then break cycles by routing one source through
/// `scratch`. The caller must pass a `scratch` whose register
/// lives outside the allocator's bank.
/// Emit the predecessor-exit moves for each `Inst::Phi` at the head
/// of every CFG successor of `self_block`. Mirrors the aarch64
/// helper: IntReg -> IntReg pairs schedule through the parallel-copy
/// helper, which breaks register cycles with `xchg` (no scratch) and
/// routes a spill-touching cycle through `hold`; Spill destinations
/// route through the materialise helper and a store against rsp.
///
/// TODO: extend to FpReg dst / src once a real fixture demands it;
/// the current promotion path admits only int-store slots
/// (`slot_stores_only_int`) so the FP case never arises today.
fn emit_phi_predecessor_moves(
    code: &mut Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> bool {
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

/// Compare two `Place`s by physical location identity. Distinct
/// `Place` variants never alias; same-variant places alias when their
/// register number or spill slot matches.
/// Emit a single resolved location-to-location move. `stage` is a
/// scratch register used only for the spill-to-spill case (load then
/// store); it must lie outside the allocator's bank.
/// Sequentialize a parallel copy over physical locations (integer
/// registers and stack spill slots). Leaves -- destinations that are
/// not the source of any other pending move -- are emitted first;
/// when only cycles remain, one cycle source is saved into the
/// persistent `hold` register and every move reading that location is
/// redirected to read `hold`, exposing a new leaf. `hold` and `stage`
/// must lie outside the allocator's bank so they cannot collide with
/// any pending source or destination. Returns false if any operand is
/// an FP or `None` location, which this path does not lower.
fn schedule_place_moves(
    code: &mut Vec<u8>,
    moves: &mut Vec<(Place, Place)>,
    frame: Frame,
    hold: Reg,
    stage: Reg,
) -> bool {
    super::ssa::emit_common::schedule_place_moves(
        &super::ssa::emit_common::X64Backend,
        code,
        moves,
        frame,
        hold.0,
        stage.0,
    )
}

/// Sequentialize a parallel copy over xmm registers. Mirrors
/// [`schedule_int_reg_moves`] with `movapd` for the register copies:
/// drain leaves (a target that is not the source of any other
/// pending move) first; break a residual cycle by routing one cycle
/// source through `scratch`. `scratch` must lie outside the
/// allocator's xmm pool so it collides with no pending source or
/// target.
pub(super) fn schedule_xmm_reg_moves(code: &mut Vec<u8>, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch.0,
        |code, t, s| emit_movapd_xmm_xmm(code, Reg(t), Reg(s)),
    );
}

/// Emit a single resolved FP location-to-location move over `FpReg`
/// and `Spill` places. `stage` is the scratch xmm for the
/// spill-to-spill case (load then store); it must lie outside the
/// allocator's xmm pool. `IntReg` and `None` places never reach here
/// (an FP phi's home and its operands are FP-classed).
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
        // Break a register-register edge with `xchg` (no scratch, not locked
        // for register operands): the exchange satisfies that move and leaves
        // the displaced value in the source for the move that reads it. An edge
        // touching a spill slot has no register swap, so route one such source
        // through `hold`. A single cycle drains before the next break.
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

/// Sequentialize a parallel copy over FP locations (xmm registers and
/// stack spill slots) for FP-classed phi predecessor moves. Mirrors
/// [`schedule_place_moves`] with `movsd` / `movapd`: leaves first,
/// then break a residual cycle by holding one cycle source in `hold`.
/// `hold` and `stage` must lie outside the allocator's xmm pool so
/// they collide with no pending source or destination.
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
            // Only cycle members remain, all register to register, so
            // break a cycle with `xchg` (no scratch): the exchange
            // satisfies one move -- the target receives the source's
            // value -- and leaves the displaced value in the source for
            // the move that reads it.
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

/// Lower `func` to machine code appended to `cx.code`. Returns `false`,
/// with every output buffer rolled back to its length on entry, when the
/// function contains a shape outside the implemented subset; the caller
/// turns that into a compile error.
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
) -> bool {
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
        bail_msg(&super::ssa::emit_common::frame_too_large_msg(bytes));
        return false;
    }
    let frame = compute_frame(func, alloc, abi);
    if let Some(why) = super::ssa::reg_alloc::fp_scratch_shortfall(func, frame.fp_scratch) {
        bail_msg(why);
        return false;
    }
    if frame.canary_bytes > 0 {
        cx.canary_frame_bytes
            .insert(func.ent_pc, frame.canary_bytes);
    }
    if frame.frame_bytes > super::ssa::emit_common::MAX_FRAME_BYTES {
        bail_msg(&super::ssa::emit_common::frame_too_large_msg(
            frame.frame_bytes as i64,
        ));
        return false;
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
        Some(uw) => {
            fn_unwind.push(uw);
            true
        }
        None => {
            fe.out.restore(&entry_mark);
            false
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
    fn run(&mut self, rodata: &mut super::RodataBuild) -> Option<super::FnUnwind> {
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
        if !self.place_entry_params() {
            return None;
        }
        let body = self.emit_body()?;
        if !self.patch_block_addrs() {
            return None;
        }
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
        if !self.patch_branches() {
            return None;
        }
        self.materialize_jump_tables(rodata);
        uw.end = self.out.cx.code.len() as u32;
        Some(uw)
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
    /// as one parallel copy, when the integer / spill homes are distinct:
    /// emitting each `ParamRef` in instruction order would let an earlier
    /// parameter's destination overwrite a later parameter's incoming
    /// register. When two parameters share a home the set is not a
    /// permutation, so each `ParamRef` is placed in program order instead;
    /// the allocator's self-home hint keeps that path sound
    /// (`verify_allocation` checks it under `codegen_test`).
    fn place_entry_params(&mut self) -> bool {
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
            return true;
        }
        // r10 / r11 are never argument registers nor in the allocator's
        // bank, so they cannot collide with a pending source or target.
        if !schedule_place_moves(code, &mut moves, frame, SCRATCH_R10, SCRATCH_R11) {
            return false;
        }
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
        true
    }

    /// The block loop. It runs once with every local branch in the rel32
    /// form and, when `relax_branches` finds shortenable branches, once
    /// more against the shortened layout, re-recording every offset-keyed
    /// datum. Returns the mark taken where the body begins.
    fn emit_body(&mut self) -> Option<OutputMark> {
        let body = self.out.mark();
        loop {
            self.block_addr_fixups.clear();
            self.jump_table_fixups.clear();
            for block_idx in 0..self.fcx.func.blocks.len() {
                if !self.emit_block(block_idx) {
                    return None;
                }
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
        Some(body)
    }

    fn emit_block(&mut self, block_idx: usize) -> bool {
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
            if !self.emit_block_inst(block, v, tail_call) {
                return false;
            }
        }
        // Predecessor-exit moves for the phis at every successor's head.
        if !emit_phi_predecessor_moves(
            self.out.cx.code,
            block_idx as super::super::ir::BlockId,
            func,
            alloc,
            frame,
        ) {
            return false;
        }
        self.emit_terminator(block_idx, block, tail_call)
    }

    fn emit_block_inst(
        &mut self,
        block: &super::super::ir::Block,
        v: super::super::ir::ValueId,
        tail_call: Option<(usize, usize, &[u32])>,
    ) -> bool {
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
            return true;
        }
        if super::ssa::emit_common::is_dead_pure(inst, v, alloc) {
            return true;
        }
        if self.param_prebatched[v as usize] {
            return true;
        }
        // The tail call's argument setup is part of the terminator.
        if let Some((tail_pc, _, _)) = tail_call
            && (v as usize) == tail_pc
        {
            return true;
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
            return true;
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
        if !emit_inst(&mut self.out, inst, v, place, &self.fcx) {
            #[cfg(feature = "codegen_test")]
            if std::env::var("BADC_DUMP_SSA").is_ok() {
                eprintln!(
                    "ssa emit x86_64: bailed on inst v{v}: {:?} (place {:?})",
                    inst, place,
                );
            }
            return false;
        }
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
        true
    }

    fn emit_terminator(
        &mut self,
        block_idx: usize,
        block: &super::super::ir::Block,
        tail_call: Option<(usize, usize, &[u32])>,
    ) -> bool {
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
            Terminator::Return(_) if func.is_naked => true,
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
                    true
                }
            }
            Terminator::Jmp(t) | Terminator::FallThrough(t) => {
                self.jump_unless_next(block_idx, t);
                true
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
                true
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
                true
            }
            // The label branches were lowered inside the `Inst::InlineAsm`;
            // only the fall-through edge (row entry 0) is emitted here.
            Terminator::AsmGoto { table } => {
                let fall = func.jump_tables[table as usize][0];
                self.jump_unless_next(block_idx, fall);
                true
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
                true
            }
            // Sealed after a noreturn call (C11 6.7.4p8): `ud2` so a
            // mis-marked returning call faults instead of running on.
            Terminator::Unreachable => {
                self.out.cx.code.extend_from_slice(&[0x0F, 0x0B]);
                true
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
    ) -> bool {
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
        true
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
    fn patch_block_addrs(&mut self) -> bool {
        for &(lea_start, target_block) in &self.block_addr_fixups {
            let target_off = self.block_offsets[target_block as usize] as i64;
            let rel = target_off - (lea_start as i64 + super::encode::LEA_RIP32_LEN as i64);
            let Ok(imm) = i32::try_from(rel) else {
                return fail("BlockAddr: lea disp32 out of range");
            };
            self.out.cx.code[lea_start + 3..lea_start + 7].copy_from_slice(&imm.to_le_bytes());
        }
        true
    }

    /// Patch the recorded branches. The displacement is measured from the
    /// byte after the field: `site + 1` for rel8, `site + 4` for rel32;
    /// `relax_branches` guarantees a short branch's target is in range.
    fn patch_branches(&mut self) -> bool {
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
        true
    }

    /// Materialize each jump table into the read-only blob: an address
    /// fixup for the lea site, then one slot per entry (a 4-byte
    /// `target - table_base` difference, or the relocatable form's 8-byte
    /// absolute address left to the object's relocations). Runs past the
    /// last bail site so a bailed function leaves the blob untouched.
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

/// Decide, per local branch, whether its target is close enough to use
/// the 2-byte rel8 encoding (`EB`/`7x`) instead of the 5/6-byte rel32
/// form (`E9`/`0F 8x`).
///
/// Each entry of `branches` is `(opcode_start, long_size, target_block,
/// pinned_long)` in emission order, where `opcode_start` is the all-long
/// byte offset of the instruction's first byte, `long_size` is 5 (jmp) or
/// 6 (jcc), and `block_offsets` holds each block's all-long byte offset.
/// Both short forms are 2 bytes, so a shortened branch removes
/// `long_size - 2` bytes at its `opcode_start`. A pinned branch keeps the
/// long form whatever its displacement.
///
/// Shortening one branch only reduces the magnitude of every other
/// branch's displacement, so the shortenable set is a monotone fixpoint:
/// start all-long and repeatedly mark a branch short once its
/// displacement -- recomputed against the bytes already removed by the
/// branches marked short so far -- fits a signed 8-bit field. The check
/// excludes a forward branch's own saving, so the estimate is never
/// optimistic: a branch marked short fits in the final layout.
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

/// Reserve the realigned region and align rsp down to `realign_align`
/// (C11 6.7.5). The reservation descends in probed steps; the AND then
/// descends by up to `realign_align - 1` further bytes, which the probe
/// schedule cannot see. When the two together can outrun the unprobed
/// margin, a probe on each side of the AND keeps every step from a touched
/// address within one page, so a stack overflow still faults in the guard.
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

/// Lower `rsp -= bytes`, descending in probed steps when the amount is
/// larger than one step can safely cover.
///
/// A decrement of at most [`MAX_UNPROBED_STACK_STEP`] cannot place rsp
/// below the guard region, so it needs no probe. Past that the
/// allocation walks down one page at a time and stores through rsp after
/// each step, so an overflow faults inside the guard region instead of
/// writing into whatever mapping lies below it. `scratch` is a register
/// the caller does not need across the allocation; given one, a step
/// count above [`STACK_PROBE_UNROLL_MAX`] becomes a counted loop instead
/// of straight-line steps.
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

/// then save rbp and proceed.
///
/// `func_start` is `code.len()` at function entry; the returned
/// [`super::FnUnwind`] records every prologue instruction boundary
/// relative to it so the PE writer can build a Win64 `UNWIND_INFO`
/// for the frame. `begin` / `end` are filled by the caller.
/// Save the callee-saved registers the allocator reported: the non-volatile
/// xmm scratch at the frame bottom (full 128-bit movups, the caller's value
/// may occupy the upper lanes) and the callee-saved GPRs directly above at
/// sp + saved_fpr_bytes. SysV leaves fp_used empty. One source for the
/// offsets so the prologue and every return path agree.
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

/// Emit the function prologue: spill the host-ABI argument registers
/// into the c5 cdecl parameter cells the body references via
/// address-of-local with slot index `N >= 2` (the first declared
/// parameter at `[rbp + 16]`, the second at `[rbp + 32]`, ...), then
/// establish the frame and save the callee-saved registers. SysV /
/// Win64 push the return address before `call`, so the cell block is
/// interleaved with the saved rbp: pop the return address into r10,
/// reserve the cells, fill each from its placement, push the return
/// address back.
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
    // Host-arg-reg spill. `frame.param_spill_bytes` is the
    // single source of truth for how many bytes get allocated
    // here; the epilogue reads the same value to undo the same
    // bytes. Variadic callees, fully-Native callees with every
    // parameter `ParamRef`-seeded, and 0-param callees all
    // produce 0 and skip the entire `pop r10` / `push r10`
    // sequence (the return address stays at the top of the stack
    // where the caller pushed it).
    let entry_spill = if func.is_variadic { 0 } else { func.n_params };
    if entry_spill > 0 && frame.param_spill_bytes > 0 {
        emit_pop_r(code, Reg::R10);
        let (elidable, _n_reg, _n_stack) = param_elidable_mask(func, alloc, abi);
        let placements = param_placements(func, abi);
        // One contiguous c5 cdecl cell block, `n_params` 16-byte cells.
        // Parameter `i` reads its value through `LoadLocal { off: i+2 }`
        // from cell `[rsp + 16*i]` here (equivalently `[rbp + 16*(i+1)]`
        // after the frame is established). The incoming argument area --
        // the caller's outgoing stack, including any shadow space --
        // begins at `[rsp + cells]`; a stack-passed parameter sits at the
        // planner's byte offset within it. Filling each cell by its own
        // placement (rather than as a contiguous register prefix plus a
        // contiguous stack suffix) lets a register-passed parameter and a
        // stack-passed one interleave, which happens when a by-value
        // aggregate that consumes no argument register sits between
        // register parameters (System V MEMORY class), or when a Win64
        // aggregate overflows past the four positional registers.
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

    // Leaf-function elision: a function that makes no calls
    // (the caller's return address stays at top of stack), has no
    // frame to allocate, spills no params, and saves no callee
    // regs has no work in the standard prologue. SysV / Win64 let
    // it ret directly off the caller-pushed return address with
    // rsp unchanged.
    if is_full_leaf(func, frame, alloc, abi) {
        uw.leaf = true;
        return uw;
    }
    // Standard frame: push rbp; mov rbp, rsp; sub rsp, frame_bytes.
    emit_push_r(code, Reg::RBP);
    uw.push_rbp_end = rel(code);
    emit_mov_rr(code, Reg::RBP, Reg::RSP);
    uw.set_fpreg_end = rel(code);
    // Win64 variadic callee home-area spill (Microsoft x64 calling
    // convention). The caller passes the first four arguments in
    // rcx/rdx/r8/r9 by position and reserves 32 bytes of home area
    // above the return address; the callee spills those registers into
    // the home slots at `[rbp + 16 + i*8]` so the named parameters are
    // readable through the body's c5 cdecl cell path (cell stride 8,
    // set on `Frame`) and the home area joins the incoming stack
    // overflow into one contiguous 8-byte-stride region the variadic
    // tail occupies. Arguments past the fourth already sit on the
    // incoming stack at `[rbp + 16 + i*8]`, so they need no spill. The
    // Win64 host variadic ABI (Microsoft x64 calling convention) routes
    // every argument (named and variadic) through the integer registers
    // as a raw 8-byte value (the caller widens floating-point arguments
    // to double and passes `fp_arg_mask = 0`), so the spill is uniformly
    // integer.
    //
    // Spill ALL four argument registers, not just the named ones: a
    // variadic argument that landed in a register (rdx/r8/r9 for the
    // second through fourth argument position) must reach the home area
    // for `va_arg` to read it, and the caller reserves the full 32-byte
    // home regardless of the argument count, so the stores never fall
    // outside it. The body reads only the named slots; the surplus
    // stores feed `va_arg`.
    if win64_variadic_callee(func, abi) {
        for (i, &reg) in abi.int_arg_regs.iter().enumerate() {
            let home_off = (16 + i * 8) as i32;
            emit_mov_mem_r(code, Reg::RBP, home_off, Reg(reg));
        }
    }
    if frame.frame_bytes > 0 {
        // A single `sub rsp,N` lowers to one instruction the unwinder
        // can describe with `UWOP_ALLOC`; a probed frame lowers to a
        // multi-step walk with no single `sub` and is left undescribed
        // (SizeOfProlog still covers it, and the frame-pointer rule
        // recovers RSP exactly at any body fault, which is where the
        // unwinder samples). `frame_alloc_end == 0` is the "no single
        // sub" sentinel `build_unwind_codes` reads.
        let single_sub = frame.frame_bytes <= MAX_UNPROBED_STACK_STEP;
        // r11 is caller-saved, is no target's argument register, and
        // carries no live value in the prologue.
        emit_stack_alloc(code, frame.frame_bytes, Some(Reg::R11));
        if single_sub {
            uw.frame_alloc_end = rel(code);
        }
    }
    // System V variadic callee register save area (System V AMD64
    // 3.5.7). Spill the six integer argument registers rdi rsi rdx rcx
    // r8 r9 into the gp area at `[reg_save + 0 .. 48]` and the eight XMM
    // argument registers xmm0..xmm7 into the fp area at
    // `[reg_save + 48 .. 176]`. The named parameters read their values
    // from this area too (`local_slot_off` redirects positive c5 cdecl
    // slots here), and `va_start` / `va_arg` walk it for the variadic
    // tail. `reg_save` is `[rbp + va_reg_save_off]`; the spill writes
    // address it through rbp so it is independent of the rsp moves the
    // body makes for outgoing-call scratch.
    //
    // The XMM spill is guarded by the caller-passed XMM-register count
    // in `al` (System V AMD64 3.2.3): when the caller passed no
    // floating-point arguments (`al == 0`) the XMM save area is unused,
    // and skipping the eight `movsd` stores avoids touching xmm regs the
    // caller never set. The integer spill is unconditional -- the gp
    // area always holds the (named + variadic) integer arguments.
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
    // The allocator's FP register pool (`callee_fprs`) is empty for both
    // SysV and Win64, so it never assigns an SSA value to a non-volatile
    // xmm. The only non-volatile xmm exposure is the emit pass's fixed
    // FP scratch, which the allocator lists in `fp_used`
    // for Win64 functions that perform FP work. Save those at the bottom
    // of the frame (lowest addresses) with the full 128-bit `movups`,
    // since the caller's value may occupy the upper lanes. SysV leaves
    // `fp_used` empty.
    save_callee_saved(code, alloc, frame);
    emit_struct_param_scatter(code, func, frame, abi);
    emit_struct_stack_param_copy(code, func, frame, abi);
    // After the parameter marshalling, which uses the same scratch, and
    // before the realign: the slot is rbp-relative, so the rsp move that
    // follows does not reach it.
    emit_canary_store(code, frame, abi, extern_data_refs);
    // C11 6.7.5: reserve the over-aligned objects' region below the static
    // frame and align rsp down into it. Done last, after the callee-saved
    // stores (which stay at rbp-frame_bytes, where the epilogue's
    // restore_dynamic_sp puts rsp back); the objects live at [rsp + region_off].
    // Reserving before aligning keeps the AND's descent inside bytes the
    // reservation already claimed, so the region cannot overlap the frame.
    if frame.realign_align > 0 {
        emit_realign_rsp(code, frame);
    }
    uw
}

/// Copy each aggregate parameter the host ABI passes inline on the
/// stack (System V AMD64 MEMORY class with size > 16, or a Win64
/// aggregate that overflows past the four positional registers) into its
/// parser-reserved body local. The caller placed the struct in its
/// outgoing argument area, which sits above the return address at callee
/// entry; after the c5 cdecl entry spill (`n_params` 16-byte cells) it is
/// reachable at `[rbp + 16 + n_params*16 + off]`, where `off` is the
/// planner's byte offset of the parameter in the outgoing area. The dead
/// cell the entry spill reserves for the aggregate keeps the slot->cell
/// map positional; the body reads the struct from the synthetic body
/// local this copy fills. Runs after the frame is set up, so the
/// addresses are rbp-relative and SCRATCH_R10 is free.
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

/// Store each register-passed aggregate parameter's incoming argument
/// registers into its parser-reserved body local (System V AMD64
/// 3.2.3). Runs after the frame is established; the argument registers
/// still hold the caller-supplied values, since nothing between entry
/// and here clobbers them. The body reads the aggregate from this
/// local, so the entry argument cell stays unused.
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
    // Staging through rcx is needed only when the return value
    // itself lives in a callee-saved register the epilogue is about
    // to restore (e.g. rbx, r12): the restore would overwrite the
    // source before it reaches rax. rcx is caller-saved and never in
    // `gpr_used`, so it survives the restore. In every other case --
    // the value already in rax, in a caller-saved register, or in a
    // spill slot the restore does not touch -- the epilogue restores
    // first, then places the value into rax directly (`mov rax, src`,
    // or nothing when src already lives in rax). FP returns ride xmm0
    // directly;
    // xmm0 is outside the GPR restore loop, but the integer
    // mirror into rax happens after the restore so the bit
    // pattern is available to int-shaped callers.
    let return_place = if value != super::super::ir::NO_VALUE {
        place_of(alloc, value)
    } else {
        Place::None
    };
    // Host-ABI aggregate return (System V AMD64 3.2.3): `value` is the
    // struct's address. A <= 16-byte integer aggregate returns its
    // eightbytes in rax:rdx (x86_64 has no x8 indirect-result path --
    // the > 16-byte case keeps the out-pointer convention, so `ret_agg`
    // is only ever set here for the register case). Stage the address
    // through rcx (caller-saved, untouched by the callee-saved restore)
    // before the restore, then load the eightbytes after it.
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
        // Restore callee-saved GPRs and saved non-volatile xmm scratch
        // (the prologue places xmm at the bottom, GPRs above by
        // saved_fpr_bytes). rcx already holds the struct address and is
        // caller-saved, so the restore does not disturb it; the return
        // eightbytes load into the volatile rax/rdx/xmm0/xmm1 below.
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
    // A floating-point scalar return rides xmm0 (C99 6.2.5p10). The
    // declared return type is authoritative: a bare FP constant
    // materializes as an integer immediate in a GPR, and any value whose
    // producing instruction is integer-classed lands in a GPR, yet an
    // `fp_return` caller reads xmm0. `materialize_fp` reinterprets the
    // GPR / spill bit pattern into an xmm via `movq` / `movsd`.
    let return_is_fp = func.ret_is_fp
        || matches!(return_place, Place::FpReg(_))
        || (value != super::super::ir::NO_VALUE
            && (value as usize) < func.insts.len()
            && super::ssa::reg_alloc::produces_fp_result(&func.insts[value as usize]));
    let needs_staging = matches!(return_place, Place::IntReg(r) if alloc.gpr_used.contains(&r));
    // An integer return value sitting in a callee-saved register goes
    // straight to rax BEFORE the restore loop: rax is caller-saved (never
    // in gpr_used), so the restore cannot clobber it and no post-restore
    // move is needed -- one `mov` instead of staging through rcx and
    // copying back. FP returns keep the rcx staging below so the xmm0 path
    // and the int-shaped-caller mirror are undisturbed.
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

/// Frame teardown + `ret` (callee-saved restores already ran): drop
/// the frame, pop rbp, and drop the prologue's c5 cdecl parameter
/// cells, parking the return address in r11 across the drop.
/// `frame.param_spill_bytes` is the single source of truth both the
/// prologue and this epilogue read, so the two sides agree across
/// every prologue branch (variadic, host-stack overflow,
/// ParamRef-elided, n_params == 0). A full leaf emitted no save and
/// no frame, so only the `ret` is needed.
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

/// Branch to a symbol this unit does not define: `E8`/`E9 rel32` with a
/// zero displacement plus the by-name call site the writer turns into a
/// relocation against an undefined symbol.
/// Scratch for the stack-protector sequences. r11 is caller-saved, is
/// neither ABI's argument or return register, and carries no live value at
/// the end of the prologue or at any point a return path is taken.
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

/// Indirect call through `target`. `-mindirect-branch=thunk-extern`
/// replaces `call *%reg` with a direct call to the register's thunk;
/// `thunk-inline` embeds the retpoline (gcc's shape: hop over the
/// 17-byte thunk body, then call into it, so the continuation follows
/// the site). A call has an architectural successor either way, so
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

/// Indirect jump through `target` (computed goto, switch-table
/// dispatch), routed through the register's thunk under
/// `-mindirect-branch=thunk-extern` and embedded as the retpoline
/// sequence under `thunk-inline`; `-mharden-sls=indirect-jmp` traps
/// after the transfer in every form.
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
