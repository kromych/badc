use super::super::PrologueStep;
use super::*;

/// The predecessor-exit moves for the `Inst::Phi`s at the head of every
/// CFG successor of `self_block`: register pairs through the parallel-copy
/// scheduler, spill destinations through the materialize helper.
///
/// TODO: FpReg sources and destinations, once the promotion path admits
/// them (`slot_stores_only_int` keeps them out today).
fn emit_phi_predecessor_moves(
    code: &mut CodeBuf,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
) -> super::ssa::emit_common::Emit {
    // The scratch holds no value the moves read or write; one a value lives
    // across the edge in is borrowed and given back ahead of the branch.
    let (plan, staged) = edge_plan(self_block, func, alloc, frame, pending_regs(code));
    begin_site(code, plan);
    let (hold, stage) = move_scratch(code, staged);
    let moved = super::ssa::emit_common::emit_phi_predecessor_moves(
        &super::ssa::emit_common::X64Backend,
        code,
        self_block,
        func,
        alloc,
        frame,
        hold.0,
        stage.0,
        frame.fp_scratch[1],
        frame.fp_scratch[0],
    );
    let ended = end_scratch(code);
    moved.and(ended)
}

/// The plan of the moves at the end of block `b`, and whether one of them
/// stages through scratch ([`moves_stage`]), as a constant feeding a
/// floating-point phi does: the registers of the phis it feeds and of
/// their incomes are touched, the rest of what lives out of `b` lives
/// across.
fn edge_plan(
    b: super::super::ir::BlockId,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    prefer: [Option<u8>; 2],
) -> (Option<ScratchPlan>, bool) {
    let block = &func.blocks[b as usize];
    let succs = super::ssa::mem2reg::successors(
        &block.terminator,
        &func.computed_goto_targets,
        &func.jump_tables,
    );
    let staged = succs.iter().any(|&s| {
        let m = super::ssa::emit_common::edge_moves(func, alloc, b, s);
        moves_stage(&m.int) || !m.fp_const.is_empty() || !m.pred.is_empty()
    });
    let Some(masks) = alloc.scratch_sites.as_ref().map(|s| &s.masks) else {
        return (None, staged);
    };
    let reg = |v: super::super::ir::ValueId| int_reg(place_of(alloc, v)).map_or(0u16, |r| 1 << r.0);
    let mut moved = 0u16;
    for s in succs {
        for id in func.blocks[s as usize].inst_range.clone() {
            let Inst::Phi { incoming, .. } = &func.insts[id as usize] else {
                break;
            };
            for &(p, src) in incoming {
                if p == b {
                    moved |= reg(id) | reg(src);
                }
            }
        }
    }
    let end = masks.block_end[b as usize];
    (
        plan_site(alloc, frame, (moved, end & !moved), &MOVE_ORDER, prefer),
        staged,
    )
}

/// The shared parallel-copy scheduler over the x86-64 leaves; `hold` and
/// `stage` hold no value the moves read or write.
fn schedule_place_moves(
    code: &mut CodeBuf,
    moves: &mut Vec<PlaceMove>,
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
pub(super) fn schedule_xmm_reg_moves(code: &mut CodeBuf, moves: &mut Vec<(u8, u8)>, scratch: Reg) {
    super::ssa::emit_common::schedule_reg_moves_via_scratch(
        code,
        moves,
        scratch.0,
        |code, t, s| emit_movapd_xmm_xmm(code, Reg(t), Reg(s)),
    );
}

/// The x86_64 moves the shared parallel-copy scheduler emits.
impl super::ssa::emit_common::EmitBackend for super::ssa::emit_common::X64Backend {
    const ARCH: &'static str = "x86_64";
    type Frame = Frame;
    fn fp_reg_mov(&self, code: &mut CodeBuf, dst: u8, src: u8) {
        emit_movapd_xmm_xmm(code, Reg(dst), Reg(src));
    }
    fn fp_spill_store(&self, code: &mut CodeBuf, frame: Frame, slot: u32, src: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_movsd_mem_xmm(code, sb, off, Reg(src));
    }
    fn fp_spill_load(&self, code: &mut CodeBuf, frame: Frame, slot: u32, dst: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_movsd_xmm_mem(code, Reg(dst), sb, off);
    }
    fn wide_reg_mov(&self, code: &mut CodeBuf, w: VecWidth, dst: u8, src: u8) {
        emit_wide_mov(code, w, Reg(dst), Reg(src));
    }
    fn wide_spill_store(&self, code: &mut CodeBuf, frame: Frame, w: VecWidth, slot: u32, src: u8) {
        let (sb, off) = wide_spill_addr(frame, w, slot);
        emit_wide_store(code, w, sb, off, Reg(src));
    }
    fn wide_spill_load(&self, code: &mut CodeBuf, frame: Frame, w: VecWidth, slot: u32, dst: u8) {
        let (sb, off) = wide_spill_addr(frame, w, slot);
        emit_wide_load(code, w, Reg(dst), sb, off);
    }
    fn wide_load_const(&self, code: &mut CodeBuf, dst: u8, scratch: u8, bits: i64) {
        self.int_reg_load_imm(code, scratch, bits);
        emit_vmovq_xmm_r(code, Reg(dst), Reg(scratch));
    }
    fn v128_reg_mov(&self, code: &mut CodeBuf, dst: u8, src: u8) {
        emit_movapd_xmm_xmm(code, Reg(dst), Reg(src));
    }
    fn v128_spill_store(&self, code: &mut CodeBuf, frame: Frame, slot: u32, src: u8) {
        let (sb, off) = v128_spill_addr(frame, slot);
        emit_movups_mem_xmm(code, sb, off, Reg(src));
    }
    fn v128_spill_load(&self, code: &mut CodeBuf, frame: Frame, slot: u32, dst: u8) {
        let (sb, off) = v128_spill_addr(frame, slot);
        emit_movups_xmm_mem(code, Reg(dst), sb, off);
    }
    fn int_reg_mov(&self, code: &mut CodeBuf, dst: u8, src: u8) {
        emit_mov_rr(code, Reg(dst), Reg(src));
    }
    fn int_reg_ext(&self, code: &mut CodeBuf, dst: u8, src: u8, kind: LoadKind) {
        emit_sign_extend(code, Reg(dst), Reg(src), kind);
    }
    fn int_reg_xchg(&self, code: &mut CodeBuf, a: u8, b: u8) -> bool {
        emit_xchg_rr(code, Reg(a), Reg(b));
        true
    }
    fn int_spill_store(&self, code: &mut CodeBuf, frame: Frame, slot: u32, src: u8, _base: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, off, Reg(src));
    }
    fn int_spill_load(&self, code: &mut CodeBuf, frame: Frame, slot: u32, dst: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_r_mem(code, Reg(dst), sb, off);
    }
    fn int_spill_store_staged(
        &self,
        code: &mut CodeBuf,
        frame: Frame,
        slot: u32,
        stage: u8,
        _hold: u8,
    ) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, off, Reg(stage));
    }
    fn int_spill_store_auto(&self, code: &mut CodeBuf, frame: Frame, slot: u32, src: u8) {
        let (sb, off) = spill_slot_addr(frame, slot);
        emit_mov_mem_r(code, sb, off, Reg(src));
    }
    fn int_reg_load_imm(&self, code: &mut CodeBuf, dst: u8, bits: i64) {
        emit_mov_r_imm64(code, Reg(dst), bits);
    }
    /// +0.0 by a zeroing xor; the rest through `stage`.
    fn fp_reg_load_const(&self, code: &mut CodeBuf, dst: u8, stage: u8, bits: i64, is_f64: bool) {
        if bits == 0 {
            emit_xorps(code, Reg(dst), Reg(dst));
        } else {
            self.int_reg_load_imm(code, stage, bits);
            self.fp_reg_from_int_reg(code, dst, stage, is_f64);
        }
    }
    fn fp_reg_from_int_reg(&self, code: &mut CodeBuf, dst: u8, src: u8, _is_f64: bool) {
        // `movq xmm, r` copies all 64 bits; for an f32 the constant occupies
        // the low 32 (the immediate load zero-extends), which a scalar-single
        // op reads, so one form serves both widths.
        emit_movq_xmm_r(code, Reg(dst), Reg(src));
    }
}

/// Sequentialize register-to-register copies `(src, tgt)`: leaves first,
/// then a residual cycle broken with `xchg`, so no scratch is needed.
pub(super) fn schedule_int_reg_moves(code: &mut CodeBuf, moves: &mut Vec<(u8, u8)>) {
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
    extern_tls_names: &alloc::collections::BTreeMap<u32, crate::c5::codegen::TlsSymbolRef>,
    imports: &super::ResolvedImports,
    variadic_targets: &alloc::collections::BTreeSet<usize>,
    ret_tags: &alloc::collections::BTreeMap<usize, i64>,
    tls_total_size: usize,
    fn_unwind: &mut Vec<super::FnUnwind>,
    name2entpc: &alloc::collections::BTreeMap<alloc::string::String, usize>,
    asm_section_text_refs: &mut Vec<super::AsmSectionTextRef>,
    asm_text_abs_refs: &mut Vec<super::AsmTextAbsRef>,
    asm_text_labels: &mut Vec<super::AsmTextLabel>,
    abs_addr_refs: &mut Vec<super::AbsAddrRef>,
    no_fp_regs: bool,
    strict_align: bool,
    rodata: &mut super::RodataBuild,
    abs_jump_tables: bool,
    abs32_addrs: bool,
    hardening: super::Hardening,
    stack_protect: super::StackProtect,
    entry: super::FunctionEntry,
    fixed_regs: super::FixedRegs,
    // `-O`: the block plan may repeat a small test in place of a jump to it.
    repeat_tests: bool,
    (sibling_calls, red_zone): (bool, bool),
    padding: super::super::BranchPadding,
) -> Emit {
    let abi = {
        let mut a = target.abi_for(func.conv);
        a.sibling_calls = sibling_calls;
        a.red_zone = red_zone && target.abi().red_zone;
        a.no_fp_regs = no_fp_regs;
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
    // The frame and the emission read one decision on each block's tail call.
    let tail_calls: Vec<Option<TailCall<'_>>> = (func.blocks.iter())
        .map(|b| {
            detect_tail_call(
                func,
                alloc,
                b,
                abi,
                variadic_targets,
                ret_tags,
                imports,
                target,
            )
        })
        .collect();
    let tail_pcs: Vec<usize> = tail_calls.iter().flatten().map(|t| t.pc).collect();
    // The keep slots the frame reserves: none, then the ones its lowerings
    // took where the emission found them missing ([`super::keep`]).
    let mut keep = 0u32;
    loop {
        cx.code.take_kept();
        let frame =
            super::frame::compute_frame_with_tail_calls(func, alloc, abi, target, &tail_pcs, keep);
        if let Some(why) =
            super::ssa::reg_alloc::fp_scratch_shortfall(func, target, frame.fp_scratch)
                .or_else(|| super::ssa::emit_common::naked_refusal(func, alloc, target))
        {
            return fail(why);
        }
        if super::ssa::emit_common::needs_region_base(func, target) && frame.region_base.is_none() {
            return fail(super::ssa::emit_common::NO_REGION_BASE);
        }
        if frame.locals_shift() > 0 {
            cx.local_shift_bytes
                .insert(func.ent_pc, frame.locals_shift());
        }
        if func.n_params > 0 {
            cx.param_frame_offsets.insert(
                func.ent_pc,
                (0..func.n_params)
                    .map(|i| param_home(i, func, frame, abi))
                    .collect(),
            );
        }
        if !func.over_aligned.is_empty() {
            cx.region_frame_offsets.insert(
                func.ent_pc,
                super::ssa::emit_common::region_frame_offsets(func, frame.align_region_off),
            );
        }
        // A filter funclet gets the establisher frame, rbp less FrameOffset.
        if !func.funclet_slots.is_empty() {
            let mut offsets = Vec::with_capacity(func.funclet_slots.len());
            for &slot in &func.funclet_slots {
                let (base, disp) = super::mem::local_slot_base_disp(slot, func, frame, abi);
                if base != Reg::RBP {
                    return fail("a filter funclet reaches an object off the frame pointer");
                }
                offsets.push(i64::from(frame.saves_top) + disp);
            }
            cx.funclet_frames.insert(func.ent_pc, offsets);
        }
        if frame.frame_bytes > super::ssa::emit_common::MAX_FRAME_BYTES {
            return fail(super::ssa::emit_common::frame_too_large_msg(
                frame.frame_bytes as i64,
            ));
        }
        cx.frame_stack
            .insert(func.ent_pc, frame_stack(func, frame, alloc, abi));
        let param_from_home = compute_param_from_home(func, alloc, abi);
        let param_plan = param_placements(func, abi);
        // `-mno-sse` bars the SSE registers, `-mstrict-align` a store wider than the alignment.
        let bulk_xmm = (!abi.no_fp_regs && !abi.strict_align)
            .then(|| super::ssa::reg_alloc::free_fp_register(func, alloc, target, abi.fixed_regs))
            .flatten();
        let ends_path = super::ssa::emit_common::calls_ending_paths(func);
        let fcx = FnCtx {
            func,
            alloc,
            frame,
            abi,
            target,
            bulk_xmm,
            imports,
            variadic_targets,
            extern_tls_names,
            extern_data_names,
            extern_code_names,
            tls_total_size,
            param_from_home: &param_from_home,
            param_plan: &param_plan,
            name2entpc,
            ends_path: &ends_path,
        };
        // A full leaf builds no frame to leave ahead of, and `-pg` without
        // `-mfentry` calls `mcount` once the frame stands; the evaluation may
        // need more temporaries than it has.
        let mcount_frame = entry.profile.is_some_and(|call| call.after_prologue);
        let early_exit = if repeat_tests && !mcount_frame && !is_full_leaf(func, frame, alloc, abi)
        {
            super::ssa::early_exit::early_exit(func, &param_plan).filter(|exit| {
                emit_early_test(&mut CodeBuf::default(), exit, frame.fixed_regs).is_some()
                    && emit_early_return(
                        &mut CodeBuf::default(),
                        exit,
                        abi,
                        frame.fixed_regs,
                        &mut Vec::new(),
                    )
            })
        } else {
            None
        };
        let plan = super::ssa::block_plan::BlockPlan::build(
            func,
            alloc,
            repeat_tests,
            early_exit.as_ref(),
        );
        let endbr_targets = if abi.hardening.cf_protection_branch {
            plan.landing_pads(func)
        } else {
            alloc::collections::BTreeSet::new()
        };
        // The absolute table load reads an 8-byte entry.
        debug_assert!(!abs32_addrs || abs_jump_tables);
        let out = Out {
            cx,
            fixups,
            asm_section_text_refs,
            asm_text_abs_refs,
            asm_text_labels,
            abs_addr_refs,
            fp_literals: Vec::new(),
        };
        let entry_mark = out.mark();
        let steps = flag_steps(func, alloc);
        out.cx.code.windows = match padding {
            super::super::BranchPadding::Off => BranchWindows::default(),
            all_jumps => {
                let repeated = repeated_blocks(func);
                BranchWindows {
                    on: true,
                    pad: match all_jumps {
                        super::super::BranchPadding::All => Vec::new(),
                        _ => repeated.clone(),
                    },
                    pad_calls: repeated,
                    ..BranchWindows::default()
                }
            }
        };
        let mut fe = FnEmit {
            start: entry_mark.code,
            out,
            fcx,
            ret_tags,
            tail_calls: tail_calls.clone(),
            entry,
            early_exit,
            early_site: (0, 0),
            abs_jump_tables,
            abs32_addrs,
            endbr_targets,
            param_prebatched: alloc::vec![false; func.insts.len()],
            mem_dest: memory_destinations(func, alloc, &steps),
            frame_bases: frame_bases_only(func, alloc),
            flag_steps: steps,
            plan,
            block_offsets: alloc::vec![0; func.blocks.len()],
            branch_fixups: Vec::new(),
            branch_short: Vec::new(),
            seh_placed: Vec::new(),
            exits: Vec::new(),
            block_addr_fixups: Vec::new(),
            jump_table_fixups: Vec::new(),
        };
        let ran = fe.run(rodata);
        fe.out.cx.code.windows = BranchWindows::default();
        match ran {
            Ok(Ok(uw)) => {
                fn_unwind.push(uw);
                return Ok(());
            }
            Ok(Err(more)) => {
                fe.out.restore(&entry_mark);
                keep |= more;
            }
            Err(e) => {
                fe.out.restore(&entry_mark);
                return Err(e);
            }
        }
    }
}

/// Per block, whether it runs repeatedly: inside a loop, or anywhere in a
/// function that calls itself, which runs every block once per call.
fn repeated_blocks(func: &FunctionSsa) -> Vec<bool> {
    let recursive = (func.insts.iter())
        .any(|inst| matches!(inst, Inst::Call { target_pc, .. } if *target_pc == func.ent_pc));
    if recursive {
        return Vec::new();
    }
    let depths = crate::c5::codegen::passes::layout::loop_depths(func);
    depths.iter().map(|&d| d > 0).collect()
}

/// Per value, whether it is a frame object's address that only indexed
/// accesses read, as their base; an instruction that emits nothing reads
/// nothing.
fn frame_bases_only(func: &FunctionSsa, alloc: &Allocation) -> Vec<bool> {
    use super::super::ir::NO_VALUE;
    let n = func.insts.len();
    let mut only = alloc::vec![false; n];
    let mut read = alloc::vec![false; n];
    for (v, inst) in func.insts.iter().enumerate() {
        if matches!(inst, Inst::LocalAddr(_)) {
            only[v] = true;
        }
    }
    let mut other = |o: u32| {
        if let Some(x) = only.get_mut(o as usize) {
            *x = false;
        }
    };
    for (u, inst) in func.insts.iter().enumerate() {
        // A phi emits nothing, but its predecessors' exit moves read its operands.
        if !matches!(inst, Inst::Phi { .. })
            && super::ssa::emit_common::inst_emits_nothing(inst, u as u32, alloc)
        {
            continue;
        }
        let integer = |bytes: u8| matches!(bytes, 1 | 2 | 4 | 8);
        let base = match inst {
            // A double loads off the frame register as an integer does.
            Inst::LoadIndexed {
                base,
                kind,
                abs_base: false,
                ..
            } if (!super::is_fp_load(*kind) || *kind == super::super::ir::LoadKind::F64)
                && integer(kind.bytes()) =>
            {
                Some(*base)
            }
            Inst::StoreIndexed {
                base,
                kind,
                abs_base: false,
                ..
            } if !super::is_fp_store(*kind) && integer(kind.bytes()) => Some(*base),
            _ => None,
        };
        let mut seen_base = false;
        inst.for_each_operand(|o| {
            if Some(o) == base && !seen_base {
                seen_base = true;
                if let Some(r) = read.get_mut(o as usize) {
                    *r = true;
                }
            } else {
                other(o);
            }
        });
    }
    for block in &func.blocks {
        block.terminator.for_each_operand(&mut other);
        if block.exit_acc != NO_VALUE {
            other(block.exit_acc);
        }
    }
    only.iter().zip(&read).map(|(&o, &r)| o && r).collect()
}

/// State of one function's emission, shared by the phases below.
struct FnEmit<'a, 'b> {
    out: Out<'a, 'b>,
    fcx: FnCtx<'b>,
    ret_tags: &'b alloc::collections::BTreeMap<usize, i64>,
    /// Per block, the call it ends in as a tail call.
    tail_calls: Vec<Option<TailCall<'b>>>,
    entry: super::FunctionEntry,
    /// The return taken ahead of the frame, when the function has one.
    early_exit: Option<super::ssa::early_exit::EarlyExit>,
    /// The test's branch displacement and the frame path's start.
    early_site: (usize, usize),
    abs_jump_tables: bool,
    /// A table dispatch carries the table's address as its load's
    /// displacement ([`super::NativeOptions::abs32_addrs`]).
    abs32_addrs: bool,
    /// Offset of the function's first byte in `code`.
    start: usize,
    /// Blocks an indirect branch can enter; each opens with `endbr64`.
    endbr_targets: alloc::collections::BTreeSet<super::super::ir::BlockId>,
    /// `ParamRef` values the entry parallel copy already placed.
    param_prebatched: Vec<bool>,
    /// Steps whose flags a branch reads, and the comparisons they answer
    /// ([`flag_steps`]).
    flag_steps: Vec<Option<FlagStep>>,
    /// Loads, operations and stores one memory-destination instruction
    /// performs ([`memory_destinations`]).
    mem_dest: Vec<Option<MemDest>>,
    /// Frame objects' addresses read only as an indexed access's base, which
    /// addresses off the frame register instead ([`frame_bases_only`]).
    frame_bases: Vec<bool>,
    /// Which blocks are emitted and where each branch lands. Fixed before
    /// the first pass: the short forms are keyed by emission index, so both
    /// passes have to write the same branches.
    plan: super::ssa::block_plan::BlockPlan,
    block_offsets: Vec<usize>,
    branch_fixups: Vec<BranchFixup>,
    /// Per recorded branch, whether the layout pass chose the rel8 form;
    /// empty on the first pass.
    branch_short: Vec<bool>,
    /// `(lea_start, target_block)` per `Inst::BlockAddr`; the disp32 resolves
    /// against `block_offsets` once the layout is final.
    block_addr_fixups: Vec<(usize, u32)>,
    /// `(site, table_idx)` per `Terminator::JumpTable`, the site the `lea`
    /// or, under `abs32_addrs`, the load's displacement field; each table is
    /// materialized into the read-only blob once the layout is final.
    jump_table_fixups: Vec<(usize, u32)>,
    /// `(block, start)` of each block placed, in order, in a function with
    /// a `__try` region.
    seh_placed: Vec<(super::super::ir::BlockId, usize)>,
    /// The epilogues placed, at offsets from the function's start.
    exits: Vec<super::X64Exit>,
}

impl FnEmit<'_, '_> {
    /// Returns the function's unwind record, or `None` on a bail.
    /// The function's code and its unwind record; `Err` with the keep slots
    /// its lowerings took, which the frame must reserve before it is
    /// emitted again.
    fn run(&mut self, rodata: &mut super::RodataBuild) -> Emit<Result<super::FnUnwind, u32>> {
        let func = self.fcx.func;
        // Where a value holds the scratch pair, a lowering outside a site
        // the body plans has no scratch.
        let between = self.fcx.alloc.scratch_sites.is_some().then_some(NO_PLAN);
        self.out.cx.code.set_scratch_between(between);
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
        let frame = self.fcx.frame;
        let kept = self.out.cx.code.take_kept();
        let borrow = 1 << super::keep::BORROW_AREA;
        let slots = kept & !borrow;
        if (!frame.red_zone && slots & !frame.keep != 0)
            || (kept & borrow != 0 && !frame.borrow_area)
        {
            return Ok(Err(kept));
        }
        if func.has_seh() {
            let rows = super::ssa::emit_common::seh_rows(
                func,
                self.start,
                &self.seh_placed,
                self.out.cx.code.len(),
                &self.block_offsets,
            );
            self.out.cx.seh_rows.extend(rows);
        }
        self.emit_early_return();
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
        for (field, bits, width) in core::mem::take(&mut self.out.fp_literals) {
            rodata.literals.load_disp32(field, bits, width);
        }
        uw.end = self.out.cx.code.len() as u32;
        if !uw.leaf {
            uw.exits = core::mem::take(&mut self.exits);
        }
        self.out.cx.code.set_scratch_between(None);
        Ok(Ok(uw))
    }

    /// The function entry: a naked function's body is its whole machine
    /// code, so it gets no prologue; otherwise `endbr64` under
    /// indirect-branch tracking, the patchable-entry NOPs, the `-mfentry`
    /// call, the test of the early return, and the prologue.
    fn emit_entry(&mut self) -> super::FnUnwind {
        let FnCtx {
            func,
            alloc,
            frame,
            abi,
            ..
        } = self.fcx;
        let code = &mut *self.out.cx.code;
        // A naked body describes no frame: the unwinder keeps the entry
        // rule, as for a leaf.
        if func.is_naked {
            for _ in 0..self.entry.nops_after {
                super::encode::emit_nop(code);
            }
            return super::FnUnwind {
                leaf: true,
                ..super::FnUnwind::default()
            };
        }
        if abi.hardening.cf_protection_branch {
            super::encode::emit_endbr64(code);
        }
        for _ in 0..self.entry.nops_after {
            super::encode::emit_nop(code);
        }
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
        if let Some(exit) = &self.early_exit {
            super::ssa::emit_common::record_test_src(
                func,
                exit.test_block,
                code.len(),
                self.out.cx.ssa_line_rows,
            );
            // The test and the early return run on every call: they pad
            // where the blocks they stand for do.
            code.windows.enter_block(exit.test_block as usize);
            let mut probe = CodeBuf::default();
            emit_early_test(&mut probe, exit, self.fcx.frame.fixed_regs);
            pad_group(code, 0, probe.len(), Ends::Jump);
            let site = emit_early_test(code, exit, self.fcx.frame.fixed_regs);
            debug_assert!(site.is_some(), "the test fit its temporaries at planning");
            let site = site.unwrap_or(0);
            if exit.predicted {
                super::ssa::emit_common::record_block_src(
                    func,
                    exit.exit_block,
                    code.len(),
                    self.out.cx.ssa_line_rows,
                );
                let emitted = emit_early_return(
                    code,
                    exit,
                    abi,
                    self.fcx.frame.fixed_regs,
                    self.out.cx.asm_extern_call_sites,
                );
                debug_assert!(emitted, "the return fit its temporaries at planning");
                let frame_at = code.len();
                patch_early_branch(code, site, frame_at);
            }
            self.early_site = (site, code.len());
            (code.windows.here, code.windows.here_calls) = (false, false);
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

    /// The early return after the body, with the entry's test pointed at it,
    /// unless it follows the test; and the function recorded.
    fn emit_early_return(&mut self) {
        let Some(exit) = &self.early_exit else {
            return;
        };
        let code = &mut *self.out.cx.code;
        let exit_at = code.len();
        let (site, frame) = self.early_site;
        if exit.predicted {
            self.out.cx.early_returns.push(super::EarlyReturn {
                begin: self.start as u32,
                frame: (frame - self.start) as u32,
                exit: (exit_at - self.start) as u32,
            });
            return;
        }
        super::ssa::emit_common::record_block_src(
            self.fcx.func,
            exit.exit_block,
            exit_at,
            self.out.cx.ssa_line_rows,
        );
        code.windows.enter_block(exit.exit_block as usize);
        let emitted = emit_early_return(
            code,
            exit,
            self.fcx.abi,
            self.fcx.frame.fixed_regs,
            self.out.cx.asm_extern_call_sites,
        );
        debug_assert!(emitted, "the return fit its temporaries at planning");
        patch_early_branch(code, site, exit_at);
        self.out.cx.early_returns.push(super::EarlyReturn {
            begin: self.start as u32,
            frame: (frame - self.start) as u32,
            exit: (exit_at - self.start) as u32,
        });
    }

    /// Place the integer reads opening the entry block
    /// (`emit_common::entry_read_run`) from their argument registers as one
    /// parallel copy when their integer / spill homes are distinct;
    /// otherwise, and for every other read, each is placed at its position,
    /// where the allocator's incoming-register forbid keeps its source
    /// intact (`verify_allocation` checks it under `codegen_test`).
    fn place_entry_params(&mut self) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            abi,
            param_plan,
            ..
        } = self.fcx;
        let code = &mut *self.out.cx.code;
        let mut moves: Vec<PlaceMove> = Vec::new();
        let mut vids: Vec<usize> = Vec::new();
        let mut homes: Vec<Place> = Vec::new();
        for vid in super::ssa::emit_common::entry_read_run(func, &alloc.use_counts) {
            let inst = &func.insts[vid];
            let (Inst::ParamRef { kind, .. } | Inst::ParamPart { kind, .. }) = inst else {
                continue;
            };
            // A dead read is skipped by the per-inst path; an FP home stays
            // on that path too.
            let v = vid as super::super::ir::ValueId;
            if super::ssa::emit_common::is_dead_pure(inst, v, alloc) {
                continue;
            }
            let dst = alloc.places.get(vid).copied().unwrap_or(Place::None);
            if !matches!(dst, Place::IntReg(_) | Place::Spill(_)) {
                continue;
            }
            // The plan names the incoming register: an earlier FP parameter
            // does not shift the integer bank. A stack-passed parameter has
            // no register source and reads its home cell per inst.
            let Some((false, src)) = super::ssa::reg_alloc::incoming_reg(param_plan, inst) else {
                continue;
            };
            moves.push(PlaceMove {
                src: Place::IntReg(src),
                dst,
                ext: param_entry_ext(*kind, v, alloc),
            });
            vids.push(vid);
            homes.push(dst);
        }
        let homes_distinct = (0..homes.len())
            .all(|a| ((a + 1)..homes.len()).all(|b| !place_same_loc(homes[a], homes[b])));
        if moves.is_empty() || !homes_distinct {
            return Ok(());
        }
        // The scratch holds no argument register and no target.
        let mut touched = abi.int_arg_regs.iter().fold(0u16, |m, &r| m | 1 << r);
        for m in &moves {
            if let Place::IntReg(r) = m.dst {
                touched |= 1 << r;
            }
        }
        begin_site(
            code,
            plan_site(alloc, frame, (touched, 0), &MOVE_ORDER, [None; 2]),
        );
        let (hold, stage) = move_scratch(code, moves_stage(&moves));
        schedule_place_moves(code, &mut moves, frame, hold, stage)?;
        end_scratch(code)?;
        for vid in vids {
            self.param_prebatched[vid] = true;
        }
        Ok(())
    }

    /// The block loop. It runs once with every local branch in the rel32
    /// form and, when `relax_branches` finds shortenable branches or branch
    /// groups are kept off 32-byte boundaries, once more against the
    /// shortened and padded layout, re-recording every offset-keyed datum.
    /// Returns the mark taken where the body begins.
    fn emit_body(&mut self) -> Emit<OutputMark> {
        let body = self.out.mark();
        for pass in 0.. {
            self.block_addr_fixups.clear();
            self.out.fp_literals.clear();
            self.jump_table_fixups.clear();
            self.seh_placed.clear();
            self.exits.clear();
            for block_idx in 0..self.fcx.func.blocks.len() {
                if self.plan.is_skipped(block_idx) {
                    #[cfg(debug_assertions)]
                    self.assert_emits_nothing(block_idx)?;
                    continue;
                }
                if !self.plan.is_dead(block_idx) {
                    self.place_in_seh_region(block_idx);
                    self.emit_block(block_idx)?;
                }
            }
            // A block left out stands where its edges land, for every
            // reader of the offsets.
            for b in 0..self.fcx.func.blocks.len() {
                if self.plan.is_skipped(b) {
                    let lands = self.plan.resolve(b as super::super::ir::BlockId);
                    self.block_offsets[b] = self.block_offsets[lands as usize];
                }
            }
            if pass == 1 {
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
            self.branch_short = relax_branches(
                &branches,
                &self.block_offsets,
                &self.out.cx.code.windows.starts,
            );
            // The groups the first pass measured are padded in the second.
            if !self.out.cx.code.windows.on && !self.branch_short.iter().any(|&s| s) {
                break;
            }
            // pc_to_native is index-keyed and overwritten in place.
            self.out.restore(&body);
            self.block_offsets.fill(0);
            self.branch_fixups.clear();
            let w = &mut self.out.cx.code.windows;
            w.prev = core::mem::take(&mut w.now);
            w.closed_prev = core::mem::take(&mut w.closed_now);
            w.opens = 0;
            w.starts.clear();
            w.open = None;
        }
        Ok(body)
    }

    /// Record where block `block_idx` starts for the scope table. Where the
    /// region changes, a `nop` keeps the return address of a call ending
    /// the previous block inside that block's region: the language handler
    /// matches a frame's return address against the ranges.
    fn place_in_seh_region(&mut self, block_idx: usize) {
        let func = self.fcx.func;
        if !func.has_seh() {
            return;
        }
        let scope = func.seh_scope_of(block_idx as super::super::ir::BlockId);
        if let Some(&(prev, _)) = self.seh_placed.last()
            && func.seh_scope_of(prev) != scope
        {
            super::encode::emit_nop(self.out.cx.code);
        }
        let at = self.out.cx.code.len();
        self.seh_placed
            .push((block_idx as super::super::ir::BlockId, at));
    }

    /// A block the plan leaves out writes nothing when lowered: its
    /// instructions, then the moves of its outgoing edge.
    #[cfg(debug_assertions)]
    fn assert_emits_nothing(&mut self, block_idx: usize) -> Emit {
        let FnCtx {
            func, alloc, frame, ..
        } = self.fcx;
        let block = &func.blocks[block_idx];
        let (code, fixups) = (self.out.cx.code.len(), self.branch_fixups.len());
        for v in block.inst_range.clone() {
            self.emit_block_inst(block, v, None)?;
        }
        emit_phi_predecessor_moves(
            self.out.cx.code,
            block_idx as super::super::ir::BlockId,
            func,
            alloc,
            frame,
        )?;
        assert!(
            self.out.cx.code.len() == code && self.branch_fixups.len() == fixups,
            "block {block_idx} of `{}` is left out of the code but lowers to bytes",
            func.name
        );
        Ok(())
    }

    fn emit_block(&mut self, block_idx: usize) -> Emit {
        let FnCtx {
            func, alloc, frame, ..
        } = self.fcx;
        let block = &func.blocks[block_idx];
        self.block_offsets[block_idx] = self.out.cx.code.len();
        self.out.cx.code.begin_block();
        self.out.cx.code.label_block(block_idx as u32);
        self.out.cx.code.windows.enter_block(block_idx);
        // A `__try` handler is entered with rsp where the exception left it:
        // the prologue's rsp, realigned as the prologue realigns it.
        if func.is_seh_target(block_idx as super::super::ir::BlockId) {
            emit_lea_r_mem(
                self.out.cx.code,
                Reg::RSP,
                Reg::RBP,
                -(frame.frame_bytes as i32),
            );
            if frame.realign_align > 0 {
                emit_realign_rsp(self.out.cx.code, frame);
            }
        }
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
        // A direct or library call whose result the block returns lowers as
        // `marshal; epilogue; jmp` in the terminator; see `detect_tail_call`.
        let tail_call = self.tail_calls[block_idx];
        let saves = &alloc.loop_saves;
        let b = block_idx as super::super::ir::BlockId;
        for s in saves.loads_at_start_of(b) {
            call_save(self.out.cx.code, frame, s, false);
        }
        for s in saves.stores_at_start_of(b) {
            call_save(self.out.cx.code, frame, s, true);
        }
        for v in block.inst_range.clone() {
            if self.plan.lowers(block_idx, v) {
                self.emit_block_inst(block, v, tail_call)?;
            }
        }
        // A loop's saves go ahead of the moves into its header's phis, which
        // may take the saved registers.
        flush_scratch(self.out.cx.code);
        for s in saves.stores_at(b) {
            call_save(self.out.cx.code, frame, s, true);
        }
        // Predecessor-exit moves for the phis at every successor's head.
        emit_phi_predecessor_moves(
            self.out.cx.code,
            block_idx as super::super::ir::BlockId,
            func,
            alloc,
            frame,
        )?;
        flush_scratch(self.out.cx.code);
        for s in saves.loads_at_end_of(b) {
            call_save(self.out.cx.code, frame, s, false);
        }
        self.emit_terminator(block_idx, block, tail_call)
    }

    /// Instruction `v` under its scratch plan.
    fn emit_block_inst(
        &mut self,
        block: &super::super::ir::Block,
        v: super::super::ir::ValueId,
        tail_call: Option<TailCall<'_>>,
    ) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            target,
            ..
        } = self.fcx;
        let tls = super::ssa::reg_alloc::tls_addr_is_call(target, func);
        let call = super::ssa::reg_alloc::is_call_site(&func.insts[v as usize], tls);
        let plan = plan_inst(alloc, frame, v, call, pending_regs(self.out.cx.code));
        begin_site(self.out.cx.code, plan);
        let lowered = self.lower_block_inst(block, v, tail_call);
        let ended = end_scratch(self.out.cx.code);
        lowered.and(ended)
    }

    fn lower_block_inst(
        &mut self,
        block: &super::super::ir::Block,
        v: super::super::ir::ValueId,
        tail_call: Option<TailCall<'_>>,
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
        self.out.cx.code.begin_instruction();
        if super::ssa::emit_common::inst_emits_nothing(inst, v, alloc) {
            return Ok(());
        }
        if self.param_prebatched[v as usize] {
            return Ok(());
        }
        // The tail call's argument setup is part of the terminator.
        if let Some(tail) = tail_call
            && (v as usize) == tail.pc
        {
            return Ok(());
        }
        if self.frame_bases.get(v as usize) == Some(&true) {
            return Ok(());
        }
        // A conditional jump fuses with the instruction setting its flags:
        // the comparison it reads, or the step a counted loop closes on.
        let branch_reads = matches!(block.terminator,
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } if cond == v);
        if self.out.cx.code.windows.on
            && ((branch_reads && alloc.branch_fused.get(v as usize) == Some(&true))
                || matches!(
                    self.flag_steps.get(v as usize),
                    Some(Some(FlagStep::Sets { .. }))
                ))
        {
            self.open_branch_group(true);
        }
        super::ssa::emit_common::record_inst_src(
            func,
            v,
            self.out.cx.code.len(),
            self.out.cx.ssa_line_rows,
        );
        // A floating constant in an xmm register: +0.0 by a zeroing xor, the
        // rest by a load of a read-only literal of its precision.
        if let (Inst::Imm(bits), Place::FpReg(d)) = (inst, place)
            && !alloc.imm_held.get(v as usize).copied().unwrap_or(false)
        {
            let code = &mut *self.out.cx.code;
            if *bits == 0 {
                super::encode::emit_xorps(code, Reg(d), Reg(d));
            } else {
                let single = alloc.is_f32(v);
                let prefix = if single { 0xF3 } else { 0xF2 };
                let field = super::encode::emit_sse_mov_rip(code, prefix, false, Reg(d));
                self.out
                    .fp_literals
                    .push((field, *bits as u64, if single { 4 } else { 8 }));
            }
            return Ok(());
        }
        // `&&label`: a PC-relative lea whose disp32 resolves against this
        // function's block offsets once every block is laid out.
        if let Inst::BlockAddr(tb) = inst {
            let code = &mut *self.out.cx.code;
            let Some(rd) = int_or_spill_dst(code, place) else {
                return fail("BlockAddr: dst not int reg / spill");
            };
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
            && cfg!(feature = "inline-asm")
        {
            return emit_inline_asm(
                &mut self.out,
                asm,
                args,
                v,
                &self.fcx,
                Some(AsmGotoCtx {
                    row: &func.jump_tables[table as usize],
                    branch_fixups: &mut self.branch_fixups,
                    branch_short: &self.branch_short,
                }),
            );
        }
        let data_fixups_pre_inst = self.out.cx.data_fixups.len();
        let saves = (alloc.call_saves)
            .binary_search_by_key(&v, |&(site, _)| site)
            .map_or(&[][..], |i| alloc.call_saves[i].1.as_slice());
        for s in saves.iter().filter(|s| !s.stored) {
            call_save(self.out.cx.code, self.fcx.frame, s, true);
        }
        let lowered = emit_memory_destination(self.out.cx.code, v, &self.mem_dest, &self.fcx)
            .or_else(|| emit_flag_step(self.out.cx.code, v, &self.flag_steps, &self.fcx))
            .unwrap_or_else(|| emit_inst(&mut self.out, inst, v, place, &self.fcx));
        lowered.inspect_err(|_| {
            #[cfg(feature = "codegen_test")]
            if std::env::var("BADC_DUMP_SSA").is_ok() {
                eprintln!(
                    "ssa emit x86_64: bailed on inst v{v}: {:?} (place {:?})",
                    inst, place,
                );
            }
        })?;
        for s in saves {
            call_save(self.out.cx.code, self.fcx.frame, s, false);
        }
        name_extern_data_ref(
            self.out.cx,
            v,
            inst,
            extern_data_names,
            data_fixups_pre_inst,
        );
        self.out.cx.record_addresses(extern_data_names);
        Ok(())
    }

    /// The terminator of `block_idx` under its scratch plan: the registers
    /// of what lives out of the block or the terminator reads are touched,
    /// as no code runs past a branch to give a borrowed one back. A tail
    /// call and a jump through a register take the pair, which none of
    /// their operands and no value living out holds.
    fn emit_terminator(
        &mut self,
        block_idx: usize,
        block: &super::super::ir::Block,
        tail_call: Option<TailCall<'_>>,
    ) -> Emit {
        let FnCtx { alloc, frame, .. } = self.fcx;
        let plan = alloc.scratch_sites.as_ref().and_then(|sites| {
            let masks = &sites.masks;
            let pair = matches!(
                block.terminator,
                Terminator::JumpTable { .. } | Terminator::GotoIndirect { .. }
            ) || tail_call.is_some();
            if pair {
                Some(ScratchPlan::free(SCRATCH_PAIR))
            } else {
                plan_site(
                    alloc,
                    frame,
                    (masks.block_end[block_idx], 0),
                    &SCRATCH_ORDER,
                    [None; 2],
                )
            }
        });
        begin_site(self.out.cx.code, plan);
        let lowered = self.lower_terminator(block_idx, block, tail_call);
        let ended = end_scratch(self.out.cx.code);
        lowered.and(ended)
    }

    fn lower_terminator(
        &mut self,
        block_idx: usize,
        block: &super::super::ir::Block,
        tail_call: Option<TailCall<'_>>,
    ) -> Emit {
        let FnCtx {
            func,
            alloc,
            frame,
            abi,
            imports,
            ..
        } = self.fcx;
        if let Some(arm) = self.plan.entry_jump(block_idx) {
            return self.jump_unless_next(block_idx, arm);
        }
        match block.terminator {
            // A naked function's inline-asm body provides its own return.
            Terminator::Return(_) if func.is_naked => Ok(()),
            Terminator::Return(v) => {
                let mut steps = Vec::new();
                if let Some(tail) = tail_call {
                    emit_tail_call(
                        self.out.cx.code,
                        tail,
                        alloc,
                        frame,
                        abi,
                        self.out.fixups,
                        self.out.cx.plt_call_fixups,
                        func,
                        self.out.cx.asm_extern_call_sites,
                        self.out.cx.user_extern_data_refs,
                        &mut steps,
                    )?;
                    self.out.cx.record_addresses(self.fcx.extern_data_names);
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
                        &mut steps,
                    )?;
                }
                let rel = |at: usize| (at - self.start) as u32;
                if !steps.is_empty() {
                    self.exits.push(super::X64Exit {
                        steps: steps.into_iter().map(|(at, s)| (rel(at), s)).collect(),
                        end: rel(self.out.cx.code.len()),
                    });
                }
                Ok(())
            }
            Terminator::Jmp(t) | Terminator::FallThrough(t) => self.jump_unless_next(block_idx, t),
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => self.emit_cond_branch(block_idx, block_idx, cond, target, fall_through, true),
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => self.emit_cond_branch(block_idx, block_idx, cond, target, fall_through, false),
            Terminator::GotoIndirect { target } => self.emit_goto_indirect(target),
            // Table dispatch through the read-only blob; the preceding
            // bounds check proves the index in range. An image reads a
            // 32-bit table-relative entry and adds the base back; relocatable
            // output loads an 8-byte absolute entry.
            Terminator::JumpTable { idx, table } => {
                let code = &mut *self.out.cx.code;
                let iplace = place_of(alloc, idx);
                let Some(rt) = materialize_int(code, iplace, S0, frame) else {
                    return fail("JumpTable: idx Place not int reg / spill");
                };
                // rt is an allocated register or scratch 0, never scratch 1.
                // The lea's disp32 reaches into the blob; the writer patches
                // it. A static link indexes the table by its address instead.
                let (t, base) = (scratch(code, S0), scratch(code, S1));
                let site = if self.abs32_addrs {
                    super::encode::emit_load_disp32(
                        code,
                        LoadKind::I64,
                        t,
                        super::encode::Disp32Mem::Index(rt, 8),
                        true,
                    )
                } else {
                    let lea_start = code.len();
                    super::encode::emit_lea_r_rip32(code, base, 0);
                    if self.abs_jump_tables {
                        super::encode::emit_mov_r_sib(code, t, base, rt, 8);
                    } else {
                        super::encode::emit_movsxd_r_sib(code, t, base, rt, 4);
                        super::encode::emit_rr(code, Mnem::Add, 8, t, base);
                    }
                    lea_start
                };
                emit_hardened_jmp_r(code, t, abi, self.out.cx.asm_extern_call_sites);
                self.jump_table_fixups.push((site, table));
                Ok(())
            }
            // The label branches were lowered inside the `Inst::InlineAsm`;
            // only the fall-through edge (row entry 0) is emitted here.
            Terminator::AsmGoto { table } => {
                let fall = func.jump_tables[table as usize][0];
                self.jump_unless_next(block_idx, fall)
            }
            // A sys-trampoline body: the indirect call already placed every
            // argument, so control forwards through the PLT slot and the
            // callee's `ret` returns to the original caller.
            Terminator::TailExt(binding_idx) => {
                let Some(import_index) = imports.index_of_binding(binding_idx) else {
                    return fail("TailExt: no import slot for binding");
                };
                pad_group(self.out.cx.code, 0, 5, Ends::Jump);
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
                if !super::ssa::emit_common::block_ends_in_trap(func, block) {
                    super::encode::emit_ud2(self.out.cx.code);
                }
                Ok(())
            }
        }
    }

    /// `Bz` (`negate`) / `Bnz`: the fused compare when the allocator marked
    /// the condition, else `test rc, rc` with `je` / `jne`.
    fn emit_cond_branch(
        &mut self,
        block_idx: usize,
        owner: usize,
        cond: super::super::ir::ValueId,
        target: super::super::ir::BlockId,
        fall_through: super::super::ir::BlockId,
        negate: bool,
    ) -> Emit {
        use super::ssa::block_plan::CondShape;
        let FnCtx {
            func, alloc, frame, ..
        } = self.fcx;
        let plan = alloc.scratch_sites.as_ref().and_then(|s| {
            let end = s.masks.block_end[owner];
            plan_site(alloc, frame, (end, 0), &SCRATCH_ORDER, [None; 2])
        });
        begin_site(self.out.cx.code, plan);
        let (target, fall_through, negate) =
            match self
                .plan
                .cond_shape(block_idx, owner, target, fall_through, negate)
            {
                CondShape::Jump(t) => return self.jump_unless_next(block_idx, t),
                CondShape::Branch {
                    taken,
                    other,
                    negate,
                } => (taken, other, negate),
            };
        let owner_block = &func.blocks[owner];
        let stepped =
            flag_step_cc(&self.flag_steps, owner_block, cond, negate).map(FusedBranch::Jcc);
        if let Some(fused) = stepped.or_else(|| fused_branch_cc(func, alloc, cond, negate)) {
            let first = self.open_branch_group(false);
            emit_fused_branch(
                self.out.cx.code,
                &mut self.branch_fixups,
                &self.branch_short,
                fused,
                target,
                fall_through,
            );
            self.close_branch_group(first);
        } else {
            let code = &mut *self.out.cx.code;
            let cond_place = place_of(alloc, cond);
            let low_word = func.low_word_tests.get(owner).copied().unwrap_or(false);
            let width = if low_word { 4 } else { 8 };
            // A spilled condition no register just stored is compared in its
            // slot, which takes no scratch.
            let in_slot = match cond_place {
                Place::Spill(slot) => {
                    let (sb, off) = spill_slot_addr(frame, slot);
                    code.holding(sb.0, off, SpillWidth::Int)
                        .is_none()
                        .then_some((sb, off))
                }
                _ => None,
            };
            if let Some((sb, off)) = in_slot {
                self.open_branch_group(true);
                let code = &mut *self.out.cx.code;
                super::encode::emit_mi(code, Mnem::Cmp, width, sb, off, 0);
            } else {
                let Some(rc) = materialize_int(code, cond_place, S0, frame) else {
                    return fail(if negate {
                        "Bz: cond Place not int reg / spill / fp"
                    } else {
                        "Bnz: cond Place not int reg / spill / fp"
                    });
                };
                self.open_branch_group(true);
                let code = &mut *self.out.cx.code;
                super::encode::emit_rr(code, Mnem::Test, width, rc, rc);
            }
            let cc = if negate { Cc::E } else { Cc::Ne };
            self.emit_local(LocalBranchKind::Jcc(cc), target);
        }
        self.jump_unless_next(block_idx, fall_through)
    }

    fn emit_local(&mut self, kind: LocalBranchKind, target: super::super::ir::BlockId) {
        let first = self.open_branch_group(false);
        emit_local_branch(
            self.out.cx.code,
            &mut self.branch_fixups,
            &self.branch_short,
            kind,
            target,
        );
        self.close_branch_group(first);
    }

    /// Open a branch group at the current offset, unless `fresh` is unset
    /// and one is open, padding first when the group the previous pass
    /// measured would cross or end on a 32-byte boundary here. Returns the
    /// emission index of the group's first branch.
    fn open_branch_group(&mut self, fresh: bool) -> usize {
        let first = self.branch_fixups.len();
        let code = &mut *self.out.cx.code;
        let w = &code.windows;
        if !w.on || (!fresh && w.open.is_some()) {
            return first;
        }
        let len = usize::from(w.prev.get(first).copied().unwrap_or(0));
        let at = code.len() % 32;
        let closes = w.closed_prev.get(w.opens).copied().unwrap_or(false);
        if w.here && closes && len > 0 && len < 32 && at + len >= 32 {
            code.pad(|code| push_x86_nops(code, 32 - at));
        }
        let start = code.len();
        let w = &mut code.windows;
        w.open = Some(start);
        w.open_index = w.opens;
        w.opens += 1;
        w.closed_now.push(false);
        first
    }

    /// Close the open group, whose first branch has emission index `first`.
    fn close_branch_group(&mut self, first: usize) {
        let code = &mut *self.out.cx.code;
        let end = code.len();
        let w = &mut code.windows;
        let Some(start) = w.open.take() else {
            return;
        };
        let len = end - start;
        w.closed_now[w.open_index] = true;
        if w.now.len() <= first {
            w.now.resize(first + 1, 0);
        }
        w.now[first] = len.min(usize::from(u8::MAX)) as u8;
        w.starts.push((start, if len < 32 { len } else { 0 }));
    }

    /// Reach where an edge to `t` lands from the end of `block_idx`:
    /// nothing when its code runs into it, the plan's repeat of a small
    /// test, else a `jmp`.
    fn jump_unless_next(&mut self, block_idx: usize, t: super::super::ir::BlockId) -> Emit {
        flush_scratch(self.out.cx.code);
        if self.plan.falls_into(block_idx, t) {
            return Ok(());
        }
        if let Some(h) = self.plan.repeated_at(block_idx, t) {
            return self.emit_repeat(block_idx, h);
        }
        let t = self.plan.resolve(t);
        self.emit_local(LocalBranchKind::Jmp, t);
        Ok(())
    }

    /// Computed goto: `jmp r64` through the address `Inst::BlockAddr`
    /// materialized.
    fn emit_goto_indirect(&mut self, target: super::super::ir::ValueId) -> Emit {
        let FnCtx {
            alloc, frame, abi, ..
        } = self.fcx;
        let code = &mut *self.out.cx.code;
        // No value living out of the block, nor the target, holds the pair.
        begin_site(
            code,
            alloc
                .scratch_sites
                .as_ref()
                .map(|_| ScratchPlan::free(SCRATCH_PAIR)),
        );
        let tplace = place_of(alloc, target);
        let Some(rt) = materialize_int(code, tplace, S0, frame) else {
            return fail("GotoIndirect: target Place not int reg / spill");
        };
        emit_hardened_jmp_r(code, rt, abi, self.out.cx.asm_extern_call_sites);
        Ok(())
    }

    /// The instructions of block `h` and its branch, as the end of
    /// `block_idx`. A conditional's one arm is what this code runs into, so
    /// the branch closes it. A decided test goes, with what only it reads.
    fn emit_repeat(&mut self, block_idx: usize, h: super::super::ir::BlockId) -> Emit {
        let block = &self.fcx.func.blocks[h as usize];
        let decided = self.plan.decided_at(block_idx);
        for v in block.inst_range.clone() {
            if decided.is_none() || !self.plan.is_test_only(v) {
                self.emit_block_inst(block, v, None)?;
            }
        }
        if let Some(arm) = decided {
            return self.jump_unless_next(block_idx, arm);
        }
        match block.terminator {
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => self.emit_cond_branch(block_idx, h as usize, cond, target, fall_through, true),
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => self.emit_cond_branch(block_idx, h as usize, cond, target, fall_through, false),
            Terminator::GotoIndirect { target } => self.emit_goto_indirect(target),
            _ => unreachable!("the plan repeats a conditional or an indirect branch"),
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
            debug_assert!(
                fx.pinned_long
                    || fx.kind != LocalBranchKind::Jmp
                    || target_off != fx.site + if fx.short { 1 } else { 4 },
                "`{}`: a jmp to the next instruction",
                self.fcx.func.name
            );
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
        for &(site, table) in &self.jump_table_fixups {
            while !rodata.bytes.len().is_multiple_of(width) {
                rodata.bytes.push(0);
            }
            let base = rodata.bytes.len() as u64;
            if self.abs32_addrs {
                self.out.abs_addr_refs.push(super::AbsAddrRef {
                    field_offset: site,
                    target: super::AbsAddrTarget::Rodata(base),
                });
            } else {
                rodata.addr_fixups.push(super::RodataAddrFixup {
                    code_offset: site,
                    rodata_offset: base,
                    part: crate::c5::codegen::AddrPart::Whole,
                });
            }
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

/// Fill `n` bytes with the multi-byte NOPs of `X86_NOPS`, the longest form
/// first.
fn push_x86_nops(code: &mut CodeBuf, mut n: usize) {
    use crate::c5::asm::X86_NOPS;
    while n > 0 {
        let k = n.min(X86_NOPS.len());
        super::encode::emit_long_nop(code, k);
        n -= k;
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
/// `pads` holds, in offset order, where padding may go ahead of a branch
/// group and how much; a displacement counts all it spans, a backward one
/// the padding ahead of the branch's own group too.
pub(super) fn relax_branches(
    branches: &[(usize, usize, usize, bool)],
    block_offsets: &[usize],
    pads: &[(usize, usize)],
) -> alloc::vec::Vec<bool> {
    let n = branches.len();
    let mut short = alloc::vec![false; n];
    // pad_prefix[k] = padding pads[0..k] may take; a group's padding lies
    // after a block start at its offset.
    let mut pad_prefix = alloc::vec![0usize; pads.len() + 1];
    for (i, &(_, p)) in pads.iter().enumerate() {
        pad_prefix[i + 1] = pad_prefix[i] + p;
    }
    let padding_in = |lo: usize, hi: usize| -> i64 {
        let at = |off: usize| pad_prefix[pads.partition_point(|p| p.0 < off)];
        (at(hi) - at(lo)) as i64
    };
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
            let rel = if block_offsets[target] > opcode_start {
                rel + padding_in(opcode_start, block_offsets[target])
            } else {
                rel - padding_in(block_offsets[target], opcode_start + 1)
            };
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
pub(super) fn emit_stack_probe(code: &mut CodeBuf) {
    super::encode::emit_mi(code, Mnem::Mov, 8, Reg::RSP, 0, 0);
}

/// Reserve the realigned region and align rsp down to `realign_align` (C11
/// 6.7.5). The AND descends up to `realign_align - 1` bytes the probe
/// schedule cannot see; when that can outrun the unprobed margin, a probe
/// on each side keeps every step within a page of a touched address.
fn emit_realign_rsp(code: &mut CodeBuf, frame: Frame) {
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
pub(super) fn emit_stack_alloc(code: &mut CodeBuf, bytes: u32, scratch: Option<Reg>) {
    if bytes <= MAX_UNPROBED_STACK_STEP {
        emit_sub_rsp(code, bytes);
        return;
    }
    let steps = bytes / STACK_PROBE_PAGE;
    let residual = bytes % STACK_PROBE_PAGE;
    match scratch {
        Some(counter) if steps > STACK_PROBE_UNROLL_MAX => {
            super::encode::emit_mov_r_imm64(code, counter, steps as i64);
            let loop_start = code.len();
            emit_sub_rsp(code, STACK_PROBE_PAGE);
            emit_stack_probe(code);
            super::encode::emit_ri(code, Mnem::Sub, 8, counter, 1);
            super::encode::emit_jcc_rel32(code, super::encode::Cc::Ne, 0);
            let rel = ((loop_start as i64) - (code.len() as i64)) as i32;
            let patch_at = code.len() - 4;
            code[patch_at..patch_at + 4].copy_from_slice(&rel.to_le_bytes());
        }
        _ => {
            for _ in 0..steps {
                emit_sub_rsp(code, STACK_PROBE_PAGE);
                emit_stack_probe(code);
            }
        }
    }
    if residual > 0 {
        emit_sub_rsp(code, residual);
        if residual > MAX_UNPROBED_STACK_STEP {
            emit_stack_probe(code);
        }
    }
}

/// Bytes the prologue's pushes of the callee-saved GPRs reserve, which the
/// frame allocation leaves out.
fn pushed_gpr_bytes(alloc: &Allocation) -> u32 {
    alloc.gpr_used.len() as u32 * 8
}

/// rsp-relative offset of the first saved non-volatile xmm, above the GPR
/// slots at the frame bottom.
fn saved_xmm_off(alloc: &Allocation) -> i32 {
    super::ssa::emit_common::slots16(alloc.gpr_used.len() as u32) as i32
}

/// Save the callee-saved registers the allocator reported, with rsp
/// `pushed_gpr_bytes` above the frame bottom: the GPRs are pushed in
/// descending index order, so `gpr_used[i]` lands at `[rsp + 8 * i]` of the
/// completed frame, and the non-volatile xmms are stored above them
/// (full 128-bit `movups`, the caller may use the upper lanes). The offsets
/// have one source, so the prologue and every return path agree.
/// Each save goes to `uw` with its slot below rbp, which sits `alloc_bytes`
/// above rsp at the first push; `func_start` is the function's offset.
fn save_callee_saved(
    code: &mut CodeBuf,
    alloc: &Allocation,
    alloc_bytes: u32,
    uw: &mut super::FnUnwind,
    func_start: usize,
) {
    let mut below = alloc_bytes;
    let mut saved = |code: &Vec<u8>, reg: u8, xmm: bool, below_fp: u32| {
        uw.saves.push(super::X64Save {
            at: (code.len() - func_start) as u32,
            reg,
            xmm,
            below_fp,
        });
    };
    for &r in alloc.gpr_used.iter().rev() {
        emit_push_r(code, Reg(r));
        below += 8;
        saved(code, r, false, below);
    }
    let base = saved_xmm_off(alloc);
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        let off = base + (i as i32) * 16;
        emit_movups_mem_xmm(code, Reg::RSP, off, Reg(r));
        saved(code, r, true, below - off as u32);
    }
}

/// The Win64 callee-saved block, after `push rbp`: the GPRs pushed in
/// `gpr_used` order, `sub rsp` for a pad to 16 and the xmm saves stored at
/// its bottom, then `lea rbp, [rsp + saves_top]`, which puts rbp back on the
/// saved rbp. Each step is one `UNWIND_CODE`: the unwinder replays
/// `UWOP_SET_FPREG` (FrameOffset `saves_top / 16`) ahead of the xmm saves,
/// so their offsets hold against rsp at any later rsp, and the pushes after
/// it pop at the rsp it recovers (Microsoft, "x64 exception handling").
fn emit_win64_saves(
    code: &mut CodeBuf,
    alloc: &Allocation,
    frame: Frame,
    uw: &mut super::FnUnwind,
    func_start: usize,
) {
    let rel = |code: &Vec<u8>| (code.len() - func_start) as u32;
    for &r in &alloc.gpr_used {
        emit_push_r(code, Reg(r));
        uw.steps.push((rel(code), PrologueStep::Push(r)));
    }
    let below = frame.saves_top - pushed_gpr_bytes(alloc);
    if below > 0 {
        super::encode::emit_sub_rsp(code, below);
        uw.steps.push((rel(code), PrologueStep::Alloc(below)));
    }
    for (j, &x) in alloc.fp_used.iter().enumerate() {
        let off = j as u32 * 16;
        emit_movups_mem_xmm(code, Reg::RSP, off as i32, Reg(x));
        uw.steps
            .push((rel(code), PrologueStep::SaveXmm { xmm: x, off }));
    }
    emit_lea_r_mem(code, Reg::RBP, Reg::RSP, frame.saves_top as i32);
    uw.steps
        .push((rel(code), PrologueStep::SetFrame(frame.saves_top)));
}

/// Whether the epilogue re-establishes `rsp = rbp - frame_bytes`: a
/// dynamic-sp frame whose restores address from rsp. Without them `leave`
/// takes rsp from rbp; the Win64 block restores through rbp.
fn reestablishes_sp(frame: Frame, alloc: &Allocation) -> bool {
    frame.dynamic_sp
        && frame.saves_top == 0
        && (!alloc.gpr_used.is_empty() || !alloc.fp_used.is_empty())
}

/// Re-establish rsp ahead of the epilogue's rsp-relative restores where
/// [`reestablishes_sp`] holds. Every return path and the tail-call jump
/// call this ahead of [`restore_callee_saved`].
pub(super) fn restore_dynamic_sp(code: &mut CodeBuf, frame: Frame, alloc: &Allocation) {
    if reestablishes_sp(frame, alloc) {
        emit_lea_r_mem(code, Reg::RSP, Reg::RBP, -(frame.frame_bytes as i32));
    }
}

/// Restore what [`save_callee_saved`] saved, with rsp at the frame bottom:
/// the xmm loads, then the pops, which leave rsp `pushed_gpr_bytes` above it.
/// The Win64 block's xmm loads go through rbp, or rsp with no frame pointer;
/// its pops are the teardown's. No rsp-relative access may follow. Every
/// return path routes through this so the saved-region offsets cannot
/// drift. Each pop and xmm reload goes to `ex` at the offset past it.
pub(super) fn restore_callee_saved(
    code: &mut CodeBuf,
    frame: Frame,
    alloc: &Allocation,
    ex: &mut Vec<(usize, super::X64ExitStep)>,
) {
    if frame.saves_top > 0 || frame.saves_first {
        let (base, disp) = frame.fp_addr(-(frame.saves_top as i32));
        for (j, &r) in alloc.fp_used.iter().enumerate() {
            emit_movups_xmm_mem(code, Reg(r), base, disp + j as i32 * 16);
            ex.push((code.len(), super::X64ExitStep::LoadXmm(r)));
        }
        return;
    }
    if frame.omit_fp && frame.out > 0 {
        emit_add_rsp(code, frame.out);
        ex.push((code.len(), super::X64ExitStep::Dealloc(frame.out)));
    }
    let base = saved_xmm_off(alloc);
    for (i, &r) in alloc.fp_used.iter().enumerate() {
        emit_movups_xmm_mem(code, Reg(r), Reg::RSP, base + (i as i32) * 16);
        ex.push((code.len(), super::X64ExitStep::LoadXmm(r)));
    }
    for &r in alloc.gpr_used.iter() {
        emit_pop_r(code, Reg(r));
        ex.push((code.len(), super::X64ExitStep::Pop(r)));
    }
}

/// The prologue: `push rbp; mov rbp, rsp; sub rsp, N`, the register save
/// areas, the callee-saved registers (pushed, which completes the frame:
/// `N = frame_bytes - pushed_gpr_bytes`), the canary, the realignment, then
/// the parameters homed from their argument registers.
/// The return address stays where the caller pushed it, at `[rbp + 8]`
/// once rbp is set, and rsp only descends. `func_start` is `code.len()`
/// at entry; the returned [`super::FnUnwind`] records each frame
/// instruction boundary relative to it for the PE unwind table and the
/// DWARF CFI (`begin` / `end` are the caller's).
fn emit_prologue(
    code: &mut CodeBuf,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    func_start: usize,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) -> super::FnUnwind {
    let mut uw = super::FnUnwind::default();
    let rel = |code: &Vec<u8>| (code.len() - func_start) as u32;
    // A full leaf has no prologue work: it returns off the caller-pushed
    // return address with rsp unchanged.
    if is_full_leaf(func, frame, alloc, abi) {
        uw.leaf = true;
        return uw;
    }
    if frame.omit_fp {
        return emit_pointerless_prologue(code, func, alloc, frame, abi, extern_data_refs, uw, rel);
    }
    // Standard frame: push rbp; mov rbp, rsp; sub rsp, frame_bytes.
    emit_push_r(code, Reg::RBP);
    uw.steps.push((rel(code), PrologueStep::Push(Reg::RBP.0)));
    if frame.saves_top > 0 {
        emit_win64_saves(code, alloc, frame, &mut uw, func_start);
    } else {
        emit_mov_rr(code, Reg::RBP, Reg::RSP);
        uw.steps.push((rel(code), PrologueStep::SetFrame(0)));
    }
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
    let bottom_pushes = if frame.saves_top > 0 {
        0
    } else {
        pushed_gpr_bytes(alloc)
    };
    let alloc_bytes = frame.frame_bytes - frame.saves_top - bottom_pushes;
    if alloc_bytes > 0 {
        // A single `sub rsp, N` is describable with `UWOP_ALLOC`; a probed frame
        // stays undescribed, the frame-pointer rule recovering rsp at any body
        // fault.
        let single_sub = alloc_bytes <= MAX_UNPROBED_STACK_STEP;
        // r11 is caller-saved, is no target's argument register, and
        // carries no live value in the prologue.
        emit_stack_alloc(code, alloc_bytes, Some(Reg::R11));
        if single_sub {
            uw.steps.push((rel(code), PrologueStep::Alloc(alloc_bytes)));
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
        if !abi.no_fp_regs {
            // test al, al ; je past_fp_save
            super::encode::emit_test_al_al(code);
            super::encode::emit_jcc_rel32(code, Cc::E, 0);
            // The rel32 operand occupies the four bytes just emitted; the
            // jump is relative to the end of the je instruction (which is
            // where the XMM stores begin).
            let rel32_at = code.len() - 4;
            let fp_save_start = code.len();
            // The whole 128 bits: a vector argument occupies its register
            // across the full width (System V AMD64 psABI 3.2.3), and the
            // save slot is 16 bytes wide for exactly that reason.
            for i in 0..8u32 {
                let off = reg_save + SYSV_GP_SAVE_BYTES as i32 + (i as i32) * 16;
                super::encode::emit_movups_mem_xmm(code, Reg::RBP, off, Reg(i as u8));
            }
            let rel = (code.len() - fp_save_start) as i32;
            code[rel32_at..rel32_at + 4].copy_from_slice(&rel.to_le_bytes());
        }
    }
    // The pushed GPRs, then the movups saves of the non-volatile xmms the
    // allocator assigned (an `ms_abi` function off Win64; System V assigns
    // none), and of any callee-saved scratch a `-ffixed-` fallback moved off
    // the Win64 volatile set.
    if frame.saves_top == 0 {
        save_callee_saved(code, alloc, alloc_bytes, &mut uw, func_start);
    }
    // The canary slot is rbp-relative, so it is stored before the realign.
    emit_canary_store(code, frame, abi, extern_data_refs);
    // C11 6.7.5: the over-aligned region below the static frame, after the
    // callee-saved stores (which stay at rbp - frame_bytes, where
    // `restore_dynamic_sp` puts rsp back); reserving before aligning keeps
    // the AND inside the reserved bytes. The realign uses r11 alone, so the
    // argument registers reach the parameter marshalling after it, which
    // places a copy aligned above the slot in the realigned region.
    if frame.realign_align > 0 {
        emit_realign_rsp(code, frame);
    }
    if let Some(r) = frame.region_base {
        emit_mov_rr(code, Reg(r), Reg::RSP);
    }
    emit_param_homes(code, func, alloc, frame, abi);
    emit_struct_param_scatter(code, func, frame, abi);
    emit_struct_stack_param_copy(code, func, frame, abi);
    uw
}

/// The prologue of a frame with no pointer ([`super::frame::Frame::omit_fp`]):
/// `sub rsp, N` with the 8 bytes `push rbp` would take, so every region
/// keeps its offset from where rbp would stand, then the callee-saved
/// pushes, each a step the call-frame information follows, the canary and
/// the parameter homes. Eight bytes alone are a `push`: an explicit rsp
/// operand past the call costs a stack-pointer synchronization uop (Intel
/// optimization manual, "Stack Pointer Tracker").
#[allow(clippy::too_many_arguments)]
fn emit_pointerless_prologue(
    code: &mut CodeBuf,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
    mut uw: super::FnUnwind,
    rel: impl Fn(&Vec<u8>) -> u32,
) -> super::FnUnwind {
    if frame.saves_first {
        emit_saves_first(code, alloc, frame, &mut uw, rel);
        // Parameters in the caller's home area alone leave rsp at the return
        // address, as a full leaf does.
        uw.leaf = uw.steps.is_empty();
        emit_canary_store(code, frame, abi, extern_data_refs);
        emit_param_homes(code, func, alloc, frame, abi);
        emit_struct_param_scatter(code, func, frame, abi);
        emit_struct_stack_param_copy(code, func, frame, abi);
        return uw;
    }
    match frame.sp_alloc(pushed_gpr_bytes(alloc)) {
        0 => {}
        8 => {
            emit_push_r(code, Reg::RAX);
            uw.steps.push((rel(code), PrologueStep::Alloc(8)));
        }
        // Page by page, each step one the call-frame information follows.
        n => {
            let mut left = n;
            while left > 0 {
                let step = if left > MAX_UNPROBED_STACK_STEP {
                    left.min(STACK_PROBE_PAGE)
                } else {
                    left
                };
                emit_sub_rsp(code, step);
                if step > MAX_UNPROBED_STACK_STEP {
                    emit_stack_probe(code);
                }
                uw.steps.push((rel(code), PrologueStep::Alloc(step)));
                left -= step;
            }
        }
    }
    for &r in alloc.gpr_used.iter().rev() {
        emit_push_r(code, Reg(r));
        uw.steps.push((rel(code), PrologueStep::Push(r)));
    }
    if frame.out > 0 {
        emit_sub_rsp(code, frame.out);
        uw.steps.push((rel(code), PrologueStep::Alloc(frame.out)));
    }
    emit_canary_store(code, frame, abi, extern_data_refs);
    emit_param_homes(code, func, alloc, frame, abi);
    emit_struct_param_scatter(code, func, frame, abi);
    emit_struct_stack_param_copy(code, func, frame, abi);
    uw
}

/// The saves of a Win64 frame with no pointer ([`Frame::saves_first`]): the
/// pushes, one allocation, which past one unprobed step follows probes of
/// its pages ([`emit_probes_below_rsp`]), and the xmm stores into the block
/// below the pushes, each a step the unwind codes describe:
/// `UWOP_PUSH_NONVOL`, `UWOP_ALLOC_SMALL` or `UWOP_ALLOC_LARGE`, and
/// `UWOP_SAVE_XMM128` at its offset from the body's rsp. Eight bytes alone
/// are a `push`, as in [`emit_pointerless_prologue`].
fn emit_saves_first(
    code: &mut CodeBuf,
    alloc: &Allocation,
    frame: Frame,
    uw: &mut super::FnUnwind,
    rel: impl Fn(&Vec<u8>) -> u32,
) {
    for &r in &alloc.gpr_used {
        emit_push_r(code, Reg(r));
        uw.steps.push((rel(code), PrologueStep::Push(r)));
    }
    match frame.sp_alloc(pushed_gpr_bytes(alloc)) {
        0 => {}
        8 => emit_push_r(code, Reg::RAX),
        n if n > MAX_UNPROBED_STACK_STEP => {
            emit_probes_below_rsp(code, n);
            super::encode::emit_sub_rsp_probed(code, n);
        }
        n => emit_sub_rsp(code, n),
    }
    if let n @ 1.. = frame.sp_alloc(pushed_gpr_bytes(alloc)) {
        uw.steps.push((rel(code), PrologueStep::Alloc(n)));
    }
    let base = frame.frame_bytes - frame.saves_top;
    for (j, &x) in alloc.fp_used.iter().enumerate() {
        let off = base + j as u32 * 16;
        emit_movups_mem_xmm(code, Reg::RSP, off as i32, Reg(x));
        uw.steps
            .push((rel(code), PrologueStep::SaveXmm { xmm: x, off }));
    }
}

/// Touch each page an allocation of `bytes` will cover, from rsp down, with
/// rsp in place, so that one `sub` then takes them all as the stack's guard
/// page grows it, and that `sub` alone describes the allocation. Past
/// [`STACK_PROBE_UNROLL_MAX`] pages a loop counts down r11, which holds
/// nothing in the prologue.
fn emit_probes_below_rsp(code: &mut CodeBuf, bytes: u32) {
    let pages = bytes / STACK_PROBE_PAGE;
    let page = STACK_PROBE_PAGE as i32;
    if pages <= STACK_PROBE_UNROLL_MAX {
        for k in 1..=pages as i32 {
            super::encode::emit_mi(code, Mnem::Mov, 8, Reg::RSP, -k * page, 0);
        }
    } else {
        super::encode::emit_mov_r_imm64(code, Reg::R11, -i64::from(page));
        let top = code.len();
        super::encode::emit_mi_sib(code, Mnem::Mov, 8, (Reg::RSP, Reg::R11, 1, 0), 0);
        super::encode::emit_ri(code, Mnem::Sub, 8, Reg::R11, page);
        super::encode::emit_ri(code, Mnem::Cmp, 8, Reg::R11, -(pages as i32 + 1) * page);
        super::encode::emit_jcc_rel32(code, Cc::Ne, 0);
        let rel = (top as i64 - code.len() as i64) as i32;
        let at = code.len() - 4;
        code[at..at + 4].copy_from_slice(&rel.to_le_bytes());
    }
    if bytes % STACK_PROBE_PAGE > MAX_UNPROBED_STACK_STEP {
        super::encode::emit_mi(code, Mnem::Mov, 8, Reg::RSP, -(bytes as i32), 0);
    }
}

/// Store each register-passed scalar parameter into its home
/// (`param_home_off`) unless the store is dead (`param_home_store_dead`).
/// The argument registers are intact here: the frame setup uses rsp, rbp
/// and r11 alone. A variadic callee's register save area covers its
/// named parameters.
fn emit_param_homes(
    code: &mut CodeBuf,
    func: &FunctionSsa,
    alloc: &Allocation,
    frame: Frame,
    abi: super::Abi,
) {
    let dead = param_home_store_dead(func, alloc, abi);
    for (i, placement) in param_placements(func, abi).iter().enumerate() {
        if dead.get(i).copied().unwrap_or(false) {
            continue;
        }
        // A register-passed aggregate is scattered into its body local.
        let home = || frame.fp_addr(param_home_off(i, func, frame, abi) as i32);
        match *placement {
            super::ArgPlacement::IntReg(r) => {
                let (base, home) = home();
                emit_mov_mem_r(code, base, home, Reg(r));
            }
            super::ArgPlacement::FpReg(x) => {
                let (base, home) = home();
                emit_movsd_mem_xmm(code, base, home, Reg(x));
            }
            _ => {}
        }
    }
}

/// Copy each aggregate parameter passed inline on the stack (System V
/// AMD64 MEMORY class over 16 bytes, or a Win64 aggregate past the four
/// positional registers) from the caller's outgoing area, where
/// `param_home_off` places it, into its parser-reserved body local. The
/// prologue runs it ahead of any allocated value, through r10, which is no
/// argument register.
fn emit_struct_stack_param_copy(
    code: &mut CodeBuf,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_home_placements(func, abi);
    if !placements
        .iter()
        .any(|p| matches!(p, super::ArgPlacement::StructStack { .. }))
    {
        return;
    }
    for (i, &placement) in placements.iter().enumerate() {
        let super::ArgPlacement::StructStack { size, .. } = placement else {
            continue;
        };
        let slot = func.param_local_slots.get(i).copied().unwrap_or(0);
        if slot >= 0 {
            continue;
        }
        let (src_base, src_off) = frame.fp_addr64(param_home_off(i, func, frame, abi));
        let (dst_base, dst_off) = local_slot_base_disp(slot, func, frame, abi);
        let words = (size / 8) as i64;
        for w in 0..words {
            let o = w * 8;
            emit_mov_r_mem(code, Reg::R10, src_base, (src_off + o) as i32);
            emit_mov_mem_r(code, dst_base, (dst_off + o) as i32, Reg::R10);
        }
        // The tail in the widest moves that end inside the object.
        let mut o = words * 8;
        for width in [4, 2, 1] {
            if (size as i64) - o < width {
                continue;
            }
            let (src, dst) = ((src_off + o) as i32, (dst_off + o) as i32);
            match width {
                4 => {
                    super::encode::emit_mov_r32_mem(code, Reg::R10, src_base, src);
                    super::encode::emit_mov_mem32_r(code, dst_base, dst, Reg::R10);
                }
                2 => {
                    super::encode::emit_movzx_r_mem16(code, Reg::R10, src_base, src);
                    super::encode::emit_mov_mem16_r(code, dst_base, dst, Reg::R10);
                }
                _ => {
                    super::encode::emit_movzx_r_mem8(code, Reg::R10, src_base, src);
                    super::encode::emit_mov_mem8_r(code, dst_base, dst, Reg::R10);
                }
            }
            o += width;
        }
    }
}

/// Register slot classes of a by-value aggregate on this ABI, empty
/// when it is not passed or returned in registers.
fn reg_slot_classes(
    desc: &super::super::ir::AggDesc,
    abi: super::Abi,
    is_return: bool,
) -> alloc::vec::Vec<super::abi_classify::RegClass> {
    match super::abi_classify::classify_aggregate(desc, abi, is_return) {
        super::abi_classify::AggClass::Regs(c) => c,
        _ => alloc::vec::Vec::new(),
    }
}

/// Store each register-passed aggregate parameter's argument registers
/// (System V AMD64 3.2.3), still intact at this point, into its
/// parser-reserved body local.
fn emit_struct_param_scatter(
    code: &mut CodeBuf,
    func: &FunctionSsa,
    frame: Frame,
    abi: super::Abi,
) {
    if func.param_aggs.iter().all(Option::is_none) {
        return;
    }
    let placements = param_home_placements(func, abi);
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
        let (base_reg, base) = local_slot_base_disp(slot, func, frame, abi);
        let desc = &func.agg_descs[agg.unwrap() as usize];
        let classes = reg_slot_classes(desc, abi, false);
        let slots = super::abi_classify::register_slots(&classes);
        for ((class, off), cr) in slots.zip(regs.iter().take(*n as usize)) {
            let disp = (base + i64::from(off)) as i32;
            if cr.is_fp {
                emit_agg_store_slot_sse(code, class, base_reg, disp, Reg(cr.reg));
            } else {
                super::encode::emit_mov_mem_r(code, base_reg, disp, Reg(cr.reg));
            }
        }
    }
}

fn emit_return(
    code: &mut CodeBuf,
    value: u32,
    alloc: &Allocation,
    frame: Frame,
    func: &FunctionSsa,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
    ex: &mut Vec<(usize, super::X64ExitStep)>,
) -> Emit {
    // A return in registers moves its parts ahead of the restores: rax, rdx
    // and the xmm registers are not restored.
    if let Some(Inst::AggParts { parts, fp_mask, .. }) = func.insts.get(value as usize) {
        let pair = (scratch(code, S0), scratch(code, S1));
        emit_parts_return(code, parts, fp_mask, alloc, frame, pair)?;
        emit_canary_check(code, frame, abi, extern_sites, extern_data_refs);
        restore_dynamic_sp(code, frame, alloc);
        restore_callee_saved(code, frame, alloc, ex);
        emit_epilogue_ret(code, func, frame, alloc, abi, extern_sites, ex);
        return Ok(());
    }
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
    // address, staged through rcx; the eightbytes load into rax:rdx /
    // xmm0:xmm1, an x87 pair into st(0), while rsp is still below the object.
    if let Some(ai) = func.ret_agg {
        let desc = &func.agg_descs[ai as usize];
        let eb_classes = reg_slot_classes(desc, abi, true);
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
        // Place each eightbyte in its bank: System V returns SSE eightbytes
        // in xmm0/xmm1 and INTEGER eightbytes in rax/rdx, each in order.
        let int_ret = [Reg::RAX, Reg::RDX];
        let mut int_i = 0usize;
        let mut sse_i = 0u8;
        let t = scratch(code, S0);
        for (class, off) in super::abi_classify::register_slots(&eb_classes) {
            // The eightbyte, or what of it the object holds at its end.
            let width = desc.size.saturating_sub(off).clamp(1, 8);
            let off = off as i32;
            if class == super::abi_classify::RegClass::X87 {
                super::encode::emit_fld_m80(code, Reg::RCX, off);
            } else if class != super::abi_classify::RegClass::Integer {
                emit_agg_load_slot_sse(
                    code,
                    class,
                    Reg(Reg::XMM0.0 + sse_i),
                    Reg::RCX,
                    off,
                    width,
                    desc.align,
                    abi.strict_align,
                    t,
                    frame,
                );
                sse_i += 1;
            } else {
                emit_agg_load_int(
                    code,
                    int_ret[int_i],
                    Reg::RCX,
                    off,
                    width,
                    desc.align,
                    abi.strict_align,
                    t,
                );
                int_i += 1;
            }
        }
        emit_canary_check(code, frame, abi, extern_sites, extern_data_refs);
        restore_dynamic_sp(code, frame, alloc);
        restore_callee_saved(code, frame, alloc, ex);
        emit_epilogue_ret(code, func, frame, alloc, abi, extern_sites, ex);
        return Ok(());
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
    if !needs_staging {
        // A source outside the callee-saved registers goes to rax ahead of
        // the restore: rax is not restored, and a spill slot is addressed
        // through rsp, which the pops move. A source already in rax needs
        // no instruction.
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
    // The check calls out on a mismatch, so it runs while rsp is 16-aligned,
    // ahead of the pops.
    emit_canary_check(code, frame, abi, extern_sites, extern_data_refs);
    restore_dynamic_sp(code, frame, alloc);
    restore_callee_saved(code, frame, alloc, ex);
    if staged_int {
        emit_mov_rr(code, Reg::RAX, Reg::RCX);
    }
    // A floating-point return value is delivered in xmm0 only (SysV
    // AMD64 / Win64: scalar floating returns in xmm0). The receiving
    // call site is FP-classed (`Inst::Call::fp_return`) and reads
    // xmm0, so no rax mirror is emitted.
    emit_epilogue_ret(code, func, frame, alloc, abi, extern_sites, ex);
    Ok(())
}

/// Whether the result returns in a 256-bit register (System V AMD64 3.2.3
/// with AVX), whose upper bits the return keeps.
fn wide_result(func: &FunctionSsa, abi: super::Abi) -> bool {
    use super::abi_classify::{AggClass, RegClass, classify_aggregate};
    func.ret_agg.is_some_and(|i| {
        matches!(classify_aggregate(&func.agg_descs[i as usize], abi, true),
            AggClass::Regs(c) if c[..] == [RegClass::Vector256])
    })
}

/// A return in registers (System V AMD64 3.2.3): each part moves into its
/// class's register, the integer parts as one parallel copy through
/// `(hold, stage)`, the SSE parts through the FP scratch, and a constant's
/// bit pattern crossing banks between the two.
fn emit_parts_return(
    code: &mut CodeBuf,
    parts: &[super::super::ir::ValueId],
    fp_mask: &super::super::ir::FpMask,
    alloc: &Allocation,
    frame: Frame,
    (hold, stage): (Reg, Reg),
) -> Emit {
    let regs = super::ssa::reg_alloc::agg_part_regs(
        fp_mask,
        parts.len(),
        (&[Reg::RAX.0, Reg::RDX.0], &[Reg::XMM0.0, Reg::XMM0.0 + 1]),
    );
    let mut int_moves: Vec<PlaceMove> = Vec::new();
    let mut fp_moves: Vec<(Place, Place, crate::c5::codegen::ssa::reg_alloc::VecWidth)> =
        Vec::new();
    let mut cross: Vec<(Reg, Reg)> = Vec::new();
    for (&p, &(is_fp, r)) in parts.iter().zip(&regs) {
        let src = place_of(alloc, p);
        match (is_fp, src) {
            (false, Place::IntReg(_) | Place::Spill(_)) => {
                int_moves.push(PlaceMove::copy(src, Place::IntReg(r)));
            }
            (true, Place::FpReg(_) | Place::Spill(_)) => {
                fp_moves.push((src, Place::FpReg(r), alloc.width(p)))
            }
            (true, Place::IntReg(s)) => cross.push((Reg(r), Reg(s))),
            _ => return fail("AggParts: part not in a register or spill slot of its bank"),
        }
    }
    super::ssa::emit_common::schedule_fp_place_moves(
        &super::ssa::emit_common::X64Backend,
        code,
        &mut fp_moves,
        frame,
        frame.fp_scratch[1],
        frame.fp_scratch[0],
    );
    for (x, s) in cross {
        emit_movq_xmm_r(code, x, s);
    }
    schedule_place_moves(code, &mut int_moves, frame, hold, stage)
}

/// Frame teardown and `ret` after the canary check and the callee-saved
/// restores. A full leaf needs only the `ret`.
fn emit_epilogue_ret(
    code: &mut CodeBuf,
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    ex: &mut Vec<(usize, super::X64ExitStep)>,
) {
    clear_upper(code, frame, wide_result(func, abi));
    pad_epilogue(code, (func, frame, alloc, abi), ret_len(abi), Ends::Call);
    emit_frame_teardown(code, func, frame, alloc, abi, ex);
    emit_hardened_ret(code, abi, extern_sites);
    code.windows.quiet = false;
}

/// Drop the frame and restore rbp, after [`restore_callee_saved`]: `leave`,
/// or `pop rbp` alone when the pops left rsp at rbp (the pushes were the
/// whole frame). rsp only ascends and the return address stays where the
/// caller pushed it. Every return path and the tail-call jump route through
/// here; each pop and the `leave` go to `ex` at the offset past them.
pub(super) fn emit_frame_teardown(
    code: &mut CodeBuf,
    func: &FunctionSsa,
    frame: Frame,
    alloc: &Allocation,
    abi: super::Abi,
    ex: &mut Vec<(usize, super::X64ExitStep)>,
) {
    use super::X64ExitStep as S;
    if is_full_leaf(func, frame, alloc, abi) {
        return;
    }
    // A Win64 frame with no pointer: `add rsp` up to the pushes, the pops.
    // r11 holds no return value and no tail call's argument.
    if frame.saves_first {
        match frame.sp_alloc(pushed_gpr_bytes(alloc)) {
            0 => {}
            8 => emit_pop_r(code, Reg::R11),
            n => emit_add_rsp(code, n),
        }
        if let n @ 1.. = frame.sp_alloc(pushed_gpr_bytes(alloc)) {
            ex.push((code.len(), S::Dealloc(n)));
        }
        for &r in alloc.gpr_used.iter().rev() {
            emit_pop_r(code, Reg(r));
            ex.push((code.len(), S::Pop(r)));
        }
        return;
    }
    // The Win64 block: `lea rsp` onto the last push, the pops, `pop rbp`, the
    // epilogue form the unwinder recognizes; `leave` with no GPR to pop.
    if frame.saves_top > 0 && !alloc.gpr_used.is_empty() {
        let last = -(pushed_gpr_bytes(alloc) as i32);
        emit_lea_r_mem(code, Reg::RSP, Reg::RBP, last);
        for &r in alloc.gpr_used.iter().rev() {
            emit_pop_r(code, Reg(r));
            ex.push((code.len(), S::Pop(r)));
        }
        emit_pop_r(code, Reg::RBP);
        ex.push((code.len(), S::Pop(Reg::RBP.0)));
        return;
    }
    if frame.omit_fp {
        // The pops left rsp where the prologue's allocation did. r11 holds
        // no return value and no tail call's argument.
        let bytes = frame.sp_alloc(pushed_gpr_bytes(alloc));
        match bytes {
            0 => return,
            8 => emit_pop_r(code, Reg::R11),
            n => emit_add_rsp(code, n),
        }
        ex.push((code.len(), S::Dealloc(bytes)));
        return;
    }
    let rsp_at_bottom = !frame.dynamic_sp || reestablishes_sp(frame, alloc);
    if frame.frame_bytes > pushed_gpr_bytes(alloc) || !rsp_at_bottom {
        super::encode::emit_leave(code);
        ex.push((code.len(), S::Leave));
    } else {
        emit_pop_r(code, Reg::RBP);
        ex.push((code.len(), S::Pop(Reg::RBP.0)));
    }
}

/// Scratch for the stack-protector sequences: caller-saved, no ABI argument
/// or return register, and holding nothing live where the sequences run.
const CANARY_SCRATCH: Reg = Reg::R11;

/// Leave the guard value in `rd`. `-mstack-protector-guard=tls` reads
/// thread storage through a segment override -- at a fixed offset, or at a
/// named object's PC-relative address when a guard symbol is given. The
/// `global` form reads the object the target's C library exports.
fn emit_load_stack_guard(
    code: &mut CodeBuf,
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
            import_slot: false,
        });
        super::encode::emit_lea_r_rip32(code, rd, 0);
        code.name_last(|| t::Operand::Name(name.into()));
        emit_mov_r_mem(code, rd, rd, 0);
        return;
    };
    let prefix = match seg {
        super::GuardSeg::Fs => 0x64,
        super::GuardSeg::Gs => 0x65,
    };
    let at = code.len();
    code.push(prefix);
    code.push(if rd.high() { 0x4C } else { 0x48 });
    code.push(0x8B);
    let seg = if prefix == 0x64 { "%fs" } else { "%gs" };
    if symbol.is_empty() {
        // `mov rd, seg:offset`: mod=00 r/m=100 (SIB) with base=101,
        // index=100 -- the disp32-only addressing form.
        code.push(0x04 | (rd.lo() << 3));
        code.push(0x25);
        code.extend_from_slice(&offset.to_le_bytes());
        code.describe(at, || {
            alloc::format!("movq {seg}:{}, {}", t::hex(offset.into()), t::gpr(rd.0, 8))
        });
        return;
    }
    // `mov rd, seg:sym(%rip)`: mod=00 r/m=101. The named object supplies
    // the whole address, so the displacement carries only the -4 that
    // measures it from the end of the instruction. The relocation is
    // anchored at the REX byte, three bytes ahead of the displacement.
    let instr_offset = code.len() - 2;
    code.push(0x05 | (rd.lo() << 3));
    code.extend_from_slice(&0i32.to_le_bytes());
    code.describe(at, || {
        alloc::format!("movq {seg}:{symbol}(%rip), {}", t::gpr(rd.0, 8))
    });
    extern_data_refs.push(super::UserExternDataRef {
        instr_offset,
        symbol_name: symbol.into(),
        direct_pcrel: Some(-4),
        import_slot: false,
    });
}

/// Prologue half of the stack protector: store the guard into the canary
/// slot at `[rbp - 8]`, above every local and below the saved rbp, then
/// clear the scratch so the guard value does not outlive the store.
fn emit_canary_store(
    code: &mut CodeBuf,
    frame: Frame,
    abi: super::Abi,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    if frame.canary_bytes == 0 {
        return;
    }
    emit_load_stack_guard(code, CANARY_SCRATCH, abi, extern_data_refs);
    let (base, disp) = frame.fp_addr(frame.canary_slot_off());
    emit_mov_mem_r(code, base, disp, CANARY_SCRATCH);
    super::encode::emit_zero_r(code, CANARY_SCRATCH);
}

/// Epilogue half: compare the canary slot against the guard and call
/// `__stack_chk_fail` when they differ. Emitted on every path that leaves
/// the frame, ahead of the teardown, while rbp still addresses the slot.
pub(super) fn emit_canary_check(
    code: &mut CodeBuf,
    frame: Frame,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    if frame.canary_bytes == 0 {
        return;
    }
    emit_load_stack_guard(code, CANARY_SCRATCH, abi, extern_data_refs);
    let (base, disp) = frame.fp_addr(frame.canary_slot_off());
    emit_rm(code, Mnem::Cmp, 8, CANARY_SCRATCH, base, disp);
    super::encode::emit_jcc_rel8(code, Cc::E, 0);
    let rel8_at = code.len() - 1;
    emit_extern_branch(
        code,
        extern_sites,
        super::STACK_CHK_FAIL_SYMBOL,
        (true, Ends::Call),
    );
    code[rel8_at] = (code.len() - rel8_at - 1) as u8;
    super::encode::emit_zero_r(code, CANARY_SCRATCH);
}

/// What a group of fixed length ends in, which decides where it pads
/// ([`BranchWindows`]).
#[derive(Clone, Copy)]
pub(super) enum Ends {
    /// A jump out of the function, an indirect jump, or the entry's test.
    Jump,
    /// A call or a return.
    Call,
}

/// Pad ahead of a group of `len` bytes that follows `lead` bytes emitted
/// next, where the code pads groups ending as it does. Its length is known,
/// so the layout decides it.
pub(super) fn pad_group(code: &mut CodeBuf, lead: usize, len: usize, ends: Ends) {
    let w = &code.windows;
    let here = match ends {
        Ends::Jump => w.here,
        Ends::Call => w.here_calls,
    };
    if !w.on || w.quiet || !here || lead + len >= 32 {
        return;
    }
    let at = (code.len() + lead) % 32;
    if at + len >= 32 {
        code.pad(|code| push_x86_nops(code, 32 - at));
    }
    let start = code.len();
    let w = &mut code.windows;
    w.open = None;
    w.starts.push((start, len));
}

/// Pad ahead of an epilogue whose teardown precedes a transfer of `len`
/// bytes, and pad nothing inside it until the caller clears `quiet`: the
/// Win64 unwinder recognizes an epilogue only as `add rsp`, the pops and the
/// transfer.
pub(super) fn pad_epilogue(
    code: &mut CodeBuf,
    (func, frame, alloc, abi): (&FunctionSsa, Frame, &Allocation, super::Abi),
    len: usize,
    ends: Ends,
) {
    pad_group(code, teardown_len(func, frame, alloc, abi), len, ends);
    code.windows.quiet = true;
}

/// The bytes of `emit_frame_teardown`, which precede an epilogue's transfer.
fn teardown_len(func: &FunctionSsa, frame: Frame, alloc: &Allocation, abi: super::Abi) -> usize {
    let mut probe = CodeBuf::default();
    emit_frame_teardown(&mut probe, func, frame, alloc, abi, &mut Vec::new());
    probe.len()
}

/// The bytes of the return [`emit_hardened_ret`] emits, as a transfer.
fn ret_len(abi: super::Abi) -> usize {
    if abi.hardening.function_return_thunk {
        5
    } else {
        1
    }
}

/// A branch to a symbol this unit does not define: `E8` / `E9 rel32` with
/// a zero displacement and a by-name call site for the writer's
/// relocation, padded as `ends`. Returns where the instruction starts.
fn emit_extern_branch(
    code: &mut CodeBuf,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    symbol: &str,
    (is_call, ends): (bool, Ends),
) -> usize {
    pad_group(code, 0, 5, ends);
    let at = code.len();
    extern_sites.push(super::UserExternCallSite {
        instr_offset: at,
        symbol_name: symbol.into(),
        is_tail: !is_call,
    });
    if is_call {
        super::encode::emit_call_rel32(code, 0);
    } else {
        super::encode::emit_jmp_rel32(code, 0);
    }
    code.name_last(|| t::Operand::Name(symbol.into()));
    at
}

/// The `-pg` call site: `call __fentry__` / `call mcount` relocated by
/// name, or under `-mnop-mcount` a NOP of the call's width in its place.
/// `-mrecord-mcount` records the site either way.
fn emit_profile_call(
    code: &mut CodeBuf,
    call: super::ProfileCall,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    mcount_sites: &mut Vec<usize>,
) {
    if call.nop {
        mcount_sites.push(code.len());
        super::encode::emit_long_nop(code, 5);
    } else {
        let at = emit_extern_branch(code, extern_sites, call.symbol(), (true, Ends::Call));
        mcount_sites.push(at);
    }
}

/// Function return. `-mfunction-return=thunk-extern` replaces `ret` with
/// a jump to the external return thunk, which returns itself; the
/// straight-line-speculation trap then has no `ret` to guard.
pub(super) fn emit_hardened_ret(
    code: &mut CodeBuf,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    if abi.hardening.function_return_thunk {
        emit_extern_branch(
            code,
            extern_sites,
            super::encode::RETURN_THUNK_SYMBOL,
            (false, Ends::Call),
        );
        return;
    }
    pad_group(code, 0, 1, Ends::Call);
    emit_ret(code);
    if abi.hardening.sls_return {
        super::encode::emit_int3(code);
    }
}

/// `mov %reg, (%rsp)`: overwrite the return address the retpoline's
/// `call` pushed with the real branch target, so its `ret` transfers
/// there with the return predictor pinned to the capture loop.
fn emit_mov_r_to_rsp_slot(code: &mut CodeBuf, target: Reg) {
    let at = code.len();
    code.push(if target.0 >= 8 { 0x4C } else { 0x48 });
    code.push(0x89);
    code.push(0x04 | ((target.0 & 7) << 3));
    code.push(0x24);
    code.describe(at, || {
        alloc::format!("movq {}, (%rsp)", t::gpr(target.0, 8))
    });
}

/// The retpoline capture: `pause; lfence; jmp .-7`, then the slot
/// overwrite and `ret`. Entered by a `call` whose displacement lands
/// on the `mov`; the pushed return address keeps speculation in the
/// loop. The `-mindirect-branch=thunk-inline` body.
fn emit_retpoline_capture(code: &mut CodeBuf, target: Reg) {
    super::encode::emit_pause(code);
    super::encode::emit_lfence(code);
    // Back over both, a branch inside the capture that no site lowering sees.
    let at = code.len();
    code.extend_from_slice(&[0xEB, 0xF9]);
    code.describe(at, || {
        t::Text::with("jmp ", t::Operand::PcRel { field: 1, width: 1 }, "")
    });
    emit_mov_r_to_rsp_slot(code, target);
    super::encode::emit_ret(code);
}

/// Indirect call through `target`: a direct call to the register's thunk
/// under `-mindirect-branch=thunk-extern`, the embedded retpoline under
/// `thunk-inline`. A call has an architectural successor, so `-mharden-sls=`
/// places no trap here.
pub(super) fn emit_hardened_call_r(
    code: &mut CodeBuf,
    target: Reg,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    use crate::c5::codegen::IndirectBranch;
    match abi.hardening.indirect_branch {
        IndirectBranch::ThunkExtern => {
            let symbol = super::encode::indirect_thunk_symbol(target);
            emit_extern_branch(code, extern_sites, symbol, (true, Ends::Call));
        }
        IndirectBranch::ThunkInline => {
            // Over the thunk body, then the call of the capture.
            super::encode::emit_jmp_rel8(code, 0x11);
            super::encode::emit_call_rel32(code, 7);
            emit_retpoline_capture(code, target);
            // call back into the thunk head; the pushed address is the
            // continuation after this site.
            super::encode::emit_call_rel32(code, -0x16);
        }
        IndirectBranch::Keep => {
            pad_group(code, 0, 2 + usize::from(target.high()), Ends::Call);
            super::encode::emit_call_r(code, target);
        }
    }
}

/// The pointer `-mguard=cf` reaches an indirect call's target through.
const GUARD_DISPATCH: &str = "__guard_dispatch_icall_fptr";

/// An indirect call through `target`. Under `-mguard=cf` the target moves
/// to rax and the call goes to `__guard_dispatch_icall_fptr`, which checks it
/// against the image's table and jumps there; Win64 passes nothing in rax.
pub(super) fn emit_indirect_call(
    code: &mut CodeBuf,
    target: Reg,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
    extern_data_refs: &mut Vec<super::UserExternDataRef>,
) {
    if !abi.hardening.guard_cf {
        return emit_hardened_call_r(code, target, abi, extern_sites);
    }
    if target.0 != Reg::RAX.0 {
        emit_mov_rr(code, Reg::RAX, target);
    }
    // `rex.w call [rip + disp32]`: the REX byte keeps the displacement at
    // `instr_offset + 3`, where a direct reference's field lies.
    pad_group(code, 0, 7, Ends::Call);
    extern_data_refs.push(super::UserExternDataRef {
        instr_offset: code.len(),
        symbol_name: GUARD_DISPATCH.into(),
        direct_pcrel: Some(-4),
        import_slot: false,
    });
    let at = code.len();
    code.extend_from_slice(&[0x48, 0xFF, 0x15, 0, 0, 0, 0]);
    code.describe(at, || alloc::format!("callq *{GUARD_DISPATCH}(%rip)"));
}

/// Indirect jump through `target`, through the register's thunk or the
/// embedded retpoline under `-mindirect-branch=`;
/// `-mharden-sls=indirect-jmp` traps after the transfer in every form.
fn emit_hardened_jmp_r(
    code: &mut CodeBuf,
    target: Reg,
    abi: super::Abi,
    extern_sites: &mut Vec<super::UserExternCallSite>,
) {
    use crate::c5::codegen::IndirectBranch;
    match abi.hardening.indirect_branch {
        IndirectBranch::ThunkExtern => {
            let symbol = super::encode::indirect_thunk_symbol(target);
            emit_extern_branch(code, extern_sites, symbol, (false, Ends::Jump));
        }
        IndirectBranch::ThunkInline => {
            // The call of the capture.
            super::encode::emit_call_rel32(code, 7);
            emit_retpoline_capture(code, target);
        }
        IndirectBranch::Keep => {
            pad_group(code, 0, 2 + usize::from(target.high()), Ends::Jump);
            super::encode::emit_jmp_r(code, target);
        }
    }
    if abi.hardening.sls_indirect_jmp {
        super::encode::emit_int3(code);
    }
}

/// Store a register a call clobbers to its slot ahead of the call, or load
/// it back after ([`super::ssa::reg_alloc::Allocation::call_saves`]).
fn call_save(code: &mut CodeBuf, frame: Frame, s: &super::ssa::reg_alloc::CallSave, store: bool) {
    use super::ssa::reg_alloc::VecWidth;
    let (slot, r) = (Place::Spill(s.slot), Reg(s.reg));
    match (s.is_fp, s.wide, store) {
        (false, _, true) => spill_dst_to_slot(code, slot, r, frame),
        (false, _, false) => {
            materialize_int(code, slot, r, frame);
        }
        (true, VecWidth::Scalar, true) => fp_spill_dst_to_slot(code, slot, r, frame),
        (true, VecWidth::Scalar, false) => {
            materialize_fp(code, slot, r, frame);
        }
        (true, VecWidth::V128, true) => mirror_v128_dst(code, slot, r, frame),
        (true, VecWidth::V128, false) => {
            materialize_v128(code, slot, r, frame);
        }
        (true, w, true) => mirror_wide_dst(code, w, slot, r, frame),
        (true, w, false) => {
            materialize_wide(code, w, slot, r, frame);
        }
    }
}
