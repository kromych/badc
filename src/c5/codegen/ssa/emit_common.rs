//! Cross-target helpers for the SSA emit backends. Holds the
//! pieces of the per-arch lowering that are pure math or pure
//! formatting -- the shape that doesn't depend on a particular
//! ABI or instruction encoding -- so the per-arch modules
//! (`ssa_emit_x86_64.rs`, `ssa_emit_aarch64.rs`) don't carry
//! parallel copies.

/// Mutable emit output the two backends thread identically through their
/// per-instruction lowering: the machine-code buffer and the relocation/fixup
/// vectors whose element types are target-neutral. Bundling them collapses the
/// long `&mut` argument lists the emit helpers used to carry one at a time.
/// Target-specific output that one backend has and the other does not -- the
/// branch-`Fixup` vector (the `BranchKind` differs), x86 `got_fixups` /
/// `fn_unwind`, aarch64 `macho_tlv_*` -- stays a separate argument, so this
/// type is non-generic. Holds `&mut` field references so a per-function caller
/// constructs it from its own output vectors; grows as more helpers adopt it.
pub(crate) struct EmitCtx<'a> {
    pub(crate) code: &'a mut alloc::vec::Vec<u8>,
    pub(crate) plt_call_fixups: &'a mut alloc::vec::Vec<super::PltCallFixup>,
    pub(crate) data_fixups: &'a mut alloc::vec::Vec<super::DataFixup>,
    pub(crate) user_extern_data_refs: &'a mut alloc::vec::Vec<super::UserExternDataRef>,
    pub(crate) pending_func_fixups: &'a mut alloc::vec::Vec<(usize, usize)>,
    pub(crate) tls_index_fixups: &'a mut alloc::vec::Vec<super::TlsIndexFixup>,
    pub(crate) elf_tpoff_fixups: &'a mut alloc::vec::Vec<super::ElfTpoffFixup>,
    pub(crate) ssa_line_rows: &'a mut alloc::vec::Vec<(usize, u32, u32)>,
    pub(crate) pc_to_native: &'a mut [usize],
    pub(crate) prologue_native: &'a mut alloc::collections::BTreeMap<usize, usize>,
    /// Named sections accumulated from inline-asm `.pushsection` data
    /// directives; the object writers append them to the emitted object.
    pub(crate) asm_sections: &'a mut alloc::vec::Vec<AsmSection>,
    /// Branch sites an inline-asm `call`/`jmp` (`bl`/`b`) aimed at a symbol
    /// this unit does not define. The callee's address is a link-time
    /// decision, so each site becomes a call relocation against the name.
    pub(crate) asm_extern_call_sites: &'a mut alloc::vec::Vec<super::UserExternCallSite>,
}

/// Round `n` up to the next 16-byte multiple. AAPCS64, SysV
/// AMD64, and Win64 all require the call-site stack pointer to
/// hold 16-byte alignment after the prologue's frame allocation;
/// every frame-region byte count routes through this helper so
/// the alignment guarantee is one source of truth.
#[inline(never)]
pub(crate) fn align16(n: u32) -> u32 {
    (n + 15) & !15
}

/// Byte count for `n` 8-byte slots rounded to 16-byte alignment.
/// The SSA model stores every per-slot value as a raw 8-byte bit
/// pattern (the c5 cdecl convention), and every region in the
/// frame must end on a 16-byte boundary -- hence the unified
/// helper.
#[inline(never)]
pub(crate) fn slots16(n_slots: u32) -> u32 {
    align16(n_slots * 8)
}

/// True when the emitted form of `inst` addresses the locals region
/// (negative slot offset): slot loads / stores / address-takes, a
/// non-zero `AllocaInit` (its reserved slot keeps the locals region
/// live), and a call gathering an aggregate return into its
/// result-temp slot. Purely structural; whether the
/// instruction is emitted at all is `is_dead_pure`'s decision, and the
/// frame gate below combines the two so it cannot disagree with the
/// per-inst emit skip.
fn inst_addresses_local(inst: &super::super::ir::Inst) -> bool {
    use super::super::ir::Inst;
    match inst {
        Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } | Inst::LocalAddr(off) => {
            *off < 0
        }
        Inst::AllocaInit(slot) => *slot != 0,
        Inst::Call { ret_slot_local, .. }
        | Inst::CallIndirect { ret_slot_local, .. }
        | Inst::CallExt { ret_slot_local, .. } => *ret_slot_local < 0,
        _ => false,
    }
}

/// The frame regions both targets size identically: the locals region, the
/// allocator spill region, and the saved callee-GPR region, each a 16-byte
/// aligned byte count. The locals region is zero when no emitted instruction
/// references a user local (negative `off`); after mem2reg and dead-store
/// elimination such an object is never observed and needs no storage
/// (C99 6.2.4p2). An instruction the per-inst dispatch skips as dead pure
/// (`is_dead_pure`) produces no machine code and therefore no access; the
/// same predicate gates both decisions. Param cells use non-negative `off`
/// and are sized separately.
pub(crate) fn compute_frame_base(
    func: &super::super::ir::FunctionSsa,
    alloc: &super::reg_alloc::Allocation,
) -> (u32, u32, u32) {
    let declared_locals_bytes = slots16(func.locals.max(0) as u32);
    // Two prologue paths reach the locals region through FunctionSsa fields
    // rather than instructions and count as accesses on their own: saving
    // the caller-supplied indirect-result pointer into `indirect_result_slot`,
    // and scattering a by-value aggregate parameter into its body local.
    let any_local_access = func.indirect_result_slot < 0
        || func
            .param_aggs
            .iter()
            .zip(func.param_local_slots.iter())
            .any(|(agg, slot)| agg.is_some() && *slot < 0)
        || func.insts.iter().enumerate().any(|(idx, i)| {
            inst_addresses_local(i) && !is_dead_pure(i, idx as super::super::ir::ValueId, alloc)
        });
    let locals_bytes = if any_local_access {
        declared_locals_bytes
    } else {
        0
    };
    let alloc_spill_bytes = slots16(alloc.spill_count);
    let saved_gpr_bytes = slots16(alloc.gpr_used.len() as u32);
    (locals_bytes, alloc_spill_bytes, saved_gpr_bytes)
}

/// Classify the function's parameter cells (`off >= 2`) by how the body uses
/// them: the parameter indices reached by a `ParamRef`, the cell offsets whose
/// address is taken, and the cell offsets read by a surviving load or written
/// by a store. A cell's incoming spill is elidable only when its parameter is
/// seeded and the cell is neither address-taken nor needed.
#[allow(clippy::type_complexity)]
pub(crate) fn scan_param_slot_usage(
    func: &super::super::ir::FunctionSsa,
    alloc: &super::reg_alloc::Allocation,
) -> (
    alloc::collections::BTreeSet<u32>,
    alloc::collections::BTreeSet<i64>,
    alloc::collections::BTreeSet<i64>,
) {
    use super::super::ir::Inst;
    let mut seeded = alloc::collections::BTreeSet::new();
    let mut addr_taken = alloc::collections::BTreeSet::new();
    let mut needed = alloc::collections::BTreeSet::new();
    for (idx, inst) in func.insts.iter().enumerate() {
        match inst {
            Inst::ParamRef { idx: i, .. } => {
                seeded.insert(*i);
            }
            Inst::LocalAddr(off) if *off >= 2 => {
                addr_taken.insert(*off);
            }
            Inst::LoadLocal { off, .. } if *off >= 2 => {
                let alive = alloc.use_counts.get(idx).copied().unwrap_or(0) > 0;
                if alive {
                    needed.insert(*off);
                }
            }
            Inst::StoreLocal { off, .. } if *off >= 2 => {
                needed.insert(*off);
            }
            _ => {}
        }
    }
    (seeded, addr_taken, needed)
}

/// Whether the function issues no call and needs no scratch-clobbering
/// intrinsic or TLS access, so a leaf prologue/epilogue may be elided. The
/// frame and register-file conditions a leaf also requires are target-specific
/// and checked by the caller.
pub(crate) fn function_makes_no_calls(func: &super::super::ir::FunctionSsa) -> bool {
    use super::super::ir::Inst;
    !func.insts.iter().any(|inst| {
        matches!(
            inst,
            Inst::Call { .. }
                | Inst::CallIndirect { .. }
                | Inst::CallExt { .. }
                | Inst::TailExt(_)
                | Inst::Intrinsic { .. }
                | Inst::TlsAddr(_)
        )
    })
}

/// Whether two resolved locations name the same physical place. A move
/// between identical locations is elided by the move schedulers.
pub(crate) fn place_same_loc(a: super::reg_alloc::Place, b: super::reg_alloc::Place) -> bool {
    use super::reg_alloc::Place;
    match (a, b) {
        (Place::IntReg(x), Place::IntReg(y)) => x == y,
        (Place::Spill(x), Place::Spill(y)) => x == y,
        (Place::FpReg(x), Place::FpReg(y)) => x == y,
        _ => false,
    }
}

/// Per-backend encoding leaves the shared emit helpers dispatch through, so a
/// helper carries the instruction-selection structure once and the backend
/// supplies the target-specific register/memory transfers. Leaves take raw
/// register numbers; each backend wraps them in its own register newtype.
/// Grows as more emit families adopt it.
pub(crate) trait EmitBackend {
    /// The target's per-function stack-frame layout. Each backend defines its
    /// own fields; the shared helpers thread a value through to the leaves
    /// without inspecting it.
    type Frame: Copy;

    /// Copy one FP/vector register to another (`dst <- src`).
    fn fp_reg_mov(&self, code: &mut alloc::vec::Vec<u8>, dst: u8, src: u8);
    /// Store FP register `src` to spill slot `slot`.
    fn fp_spill_store(
        &self,
        code: &mut alloc::vec::Vec<u8>,
        frame: Self::Frame,
        slot: u32,
        src: u8,
    );
    /// Load FP register `dst` from spill slot `slot`.
    fn fp_spill_load(&self, code: &mut alloc::vec::Vec<u8>, frame: Self::Frame, slot: u32, dst: u8);
    /// Copy one integer register to another (`dst <- src`).
    fn int_reg_mov(&self, code: &mut alloc::vec::Vec<u8>, dst: u8, src: u8);
    /// Store integer register `src` to spill slot `slot`; `base` is a free
    /// scratch a backend may use to form an out-of-reach slot address.
    fn int_spill_store(
        &self,
        code: &mut alloc::vec::Vec<u8>,
        frame: Self::Frame,
        slot: u32,
        src: u8,
        base: u8,
    );
    /// Load integer register `dst` from spill slot `slot`.
    fn int_spill_load(
        &self,
        code: &mut alloc::vec::Vec<u8>,
        frame: Self::Frame,
        slot: u32,
        dst: u8,
    );
    /// Move a value from spill slot `src` to spill slot `dst`, staging through
    /// register `stage`; `hold` is a borrowable register for an out-of-reach
    /// destination address. The reach handling is target-specific.
    fn int_spill_to_spill(
        &self,
        code: &mut alloc::vec::Vec<u8>,
        frame: Self::Frame,
        src: u32,
        dst: u32,
        stage: u8,
        hold: u8,
    );
    /// Store integer register `src` to spill slot `slot`, resolving an
    /// out-of-reach slot address from a backend-internal scratch register
    /// (unlike [`int_spill_store`], the caller supplies no base). Used to write
    /// a computed result back to its spill home.
    fn int_spill_store_auto(
        &self,
        code: &mut alloc::vec::Vec<u8>,
        frame: Self::Frame,
        slot: u32,
        src: u8,
    );
    /// Break a residual cycle in an integer place-move set: emit one resolving
    /// transfer and rewrite the moves that read the displaced source. x86_64
    /// exchanges a register-register edge; aarch64 stages through `hold`.
    fn break_place_cycle(
        &self,
        code: &mut alloc::vec::Vec<u8>,
        moves: &mut alloc::vec::Vec<(super::reg_alloc::Place, super::reg_alloc::Place)>,
        frame: Self::Frame,
        hold: u8,
        stage: u8,
    );
    /// Load a raw integer immediate into integer register `dst`.
    fn int_reg_load_imm(&self, code: &mut alloc::vec::Vec<u8>, dst: u8, bits: i64);
    /// Reinterpret integer register `src`'s bits as a floating-point value in
    /// FP register `dst` (no numeric conversion): `fmov` / `movq`. `is_f64`
    /// selects the 8-byte vs 4-byte form.
    fn fp_reg_from_int_reg(&self, code: &mut alloc::vec::Vec<u8>, dst: u8, src: u8, is_f64: bool);
}

/// Stateless backend selectors. The per-target leaf implementations live in the
/// respective emitter modules; the shared generic helpers dispatch through one
/// of these.
pub(crate) struct X64Backend;
pub(crate) struct Aarch64Backend;

/// Emit a resolved FP location-to-location move. The four source/target
/// combinations are shared; the backend supplies the register and spill-slot
/// transfers. `stage` carries the value for a spill-to-spill move.
pub(crate) fn emit_fp_place_move<B: EmitBackend>(
    b: &B,
    code: &mut alloc::vec::Vec<u8>,
    src: super::reg_alloc::Place,
    dst: super::reg_alloc::Place,
    frame: B::Frame,
    stage: u8,
) {
    use super::reg_alloc::Place;
    match (src, dst) {
        (Place::FpReg(s), Place::FpReg(t)) => b.fp_reg_mov(code, t, s),
        (Place::FpReg(s), Place::Spill(slot)) => b.fp_spill_store(code, frame, slot, s),
        (Place::Spill(slot), Place::FpReg(t)) => b.fp_spill_load(code, frame, slot, t),
        (Place::Spill(ss), Place::Spill(ts)) => {
            b.fp_spill_load(code, frame, ss, stage);
            b.fp_spill_store(code, frame, ts, stage);
        }
        // Integer and None locations never reach here: an FP phi edge is
        // FP-classed on both ends.
        _ => {}
    }
}

/// Emit a resolved integer location-to-location move. The four source/target
/// combinations are shared; `stage` carries a spill-to-spill value and `hold`
/// backs an out-of-reach destination address on backends that need it.
pub(crate) fn emit_place_move<B: EmitBackend>(
    b: &B,
    code: &mut alloc::vec::Vec<u8>,
    src: super::reg_alloc::Place,
    dst: super::reg_alloc::Place,
    frame: B::Frame,
    stage: u8,
    hold: u8,
) {
    use super::reg_alloc::Place;
    match (src, dst) {
        (Place::IntReg(s), Place::IntReg(t)) => b.int_reg_mov(code, t, s),
        (Place::IntReg(s), Place::Spill(slot)) => b.int_spill_store(code, frame, slot, s, stage),
        (Place::Spill(slot), Place::IntReg(t)) => b.int_spill_load(code, frame, slot, t),
        (Place::Spill(ss), Place::Spill(ts)) => {
            b.int_spill_to_spill(code, frame, ss, ts, stage, hold)
        }
        // FP and None locations are filtered by the caller before scheduling.
        _ => {}
    }
}

/// Sequentialize parallel FP location-to-location moves, breaking a cycle by
/// staging one source through the `hold` register. Each move is emitted via
/// [`emit_fp_place_move`]; `stage` backs a spill-to-spill transfer.
pub(crate) fn schedule_fp_place_moves<B: EmitBackend>(
    b: &B,
    code: &mut alloc::vec::Vec<u8>,
    moves: &mut alloc::vec::Vec<(super::reg_alloc::Place, super::reg_alloc::Place)>,
    frame: B::Frame,
    hold: u8,
    stage: u8,
) {
    use super::reg_alloc::Place;
    moves.retain(|(s, t)| !place_same_loc(*s, *t));
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(os, _)| place_same_loc(*os, t));
            if !tgt_still_a_source {
                emit_fp_place_move(b, code, s, t, frame, stage);
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            // Only cycle members remain. Stage one cycle source into `hold` and
            // redirect every move that reads it.
            let cyc = moves
                .iter()
                .map(|(s, _)| *s)
                .find(|s| !place_same_loc(*s, Place::FpReg(hold)))
                .unwrap_or(moves[0].0);
            emit_fp_place_move(b, code, cyc, Place::FpReg(hold), frame, stage);
            for m in moves.iter_mut() {
                if place_same_loc(m.0, cyc) {
                    m.0 = Place::FpReg(hold);
                }
            }
        }
    }
}

/// Sequentialize parallel integer location-to-location moves. Returns false
/// (the caller falls back to per-instruction placement) if any endpoint is an
/// FP register or None. Each move is emitted via [`emit_place_move`]; a
/// residual cycle is broken by the backend's [`EmitBackend::break_place_cycle`].
/// `hold`/`stage` are scratch registers outside the allocator's bank.
pub(crate) fn schedule_place_moves<B: EmitBackend>(
    b: &B,
    code: &mut alloc::vec::Vec<u8>,
    moves: &mut alloc::vec::Vec<(super::reg_alloc::Place, super::reg_alloc::Place)>,
    frame: B::Frame,
    hold: u8,
    stage: u8,
) -> bool {
    use super::reg_alloc::Place;
    moves.retain(|(s, t)| !place_same_loc(*s, *t));
    if moves.iter().any(|(s, t)| {
        matches!(s, Place::FpReg(_) | Place::None) || matches!(t, Place::FpReg(_) | Place::None)
    }) {
        return false;
    }
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(os, _)| place_same_loc(*os, t));
            if !tgt_still_a_source {
                emit_place_move(b, code, s, t, frame, stage, hold);
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            b.break_place_cycle(code, moves, frame, hold, stage);
        }
    }
    true
}

/// Write an atomic operation's result register `src` to its destination
/// `dst`: a register copy (self-moves elide) or a spill-slot store.
pub(crate) fn write_atomic_result<B: EmitBackend>(
    b: &B,
    code: &mut alloc::vec::Vec<u8>,
    dst: super::reg_alloc::Place,
    src: u8,
    frame: B::Frame,
) {
    use super::reg_alloc::Place;
    match dst {
        Place::IntReg(r) => b.int_reg_mov(code, r, src),
        Place::Spill(slot) => b.int_spill_store_auto(code, frame, slot, src),
        _ => {}
    }
}

/// Emit the predecessor-exit phi moves for `self_block`: for each successor,
/// collect every phi's incoming value into one integer and one FP parallel copy
/// (the register files do not alias) and schedule each. Returns false if the
/// integer copy cannot be scheduled, so the caller bails. `int_*` / `fp_*` are
/// the reserved scratch registers each parallel copy may use.
#[allow(clippy::too_many_arguments)]
pub(crate) fn emit_phi_predecessor_moves<B: EmitBackend>(
    b: &B,
    code: &mut alloc::vec::Vec<u8>,
    self_block: super::super::ir::BlockId,
    func: &super::super::ir::FunctionSsa,
    alloc: &super::reg_alloc::Allocation,
    frame: B::Frame,
    int_hold: u8,
    int_stage: u8,
    fp_hold: u8,
    fp_stage: u8,
) -> bool {
    use super::super::ir::{Inst, LoadKind, Terminator};
    use super::reg_alloc::Place;
    let succs: alloc::vec::Vec<super::super::ir::BlockId> =
        match func.blocks[self_block as usize].terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => alloc::vec![t],
            Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            } => alloc::vec![target, fall_through],
            Terminator::GotoIndirect { .. } => func.computed_goto_targets.clone(),
            Terminator::JumpTable { table, .. } => {
                // Distinct targets only: entries repeat (holes point at
                // the default block) but each CFG edge's phi moves are
                // emitted once.
                let mut out: alloc::vec::Vec<super::super::ir::BlockId> = alloc::vec::Vec::new();
                for &t in &func.jump_tables[table as usize] {
                    if !out.contains(&t) {
                        out.push(t);
                    }
                }
                out
            }
            Terminator::AsmGoto { table } => {
                // Moves emitted here run on the fall-through path only;
                // the template's label branches bypass them. A label
                // target with a phi fed by this block therefore needs
                // the synthetic edge block `split_crit_edges` inserts;
                // seeing one here is an invariant violation, so fail
                // the emit rather than run the wrong moves.
                let row = &func.jump_tables[table as usize];
                for &t in &row[1..] {
                    if t == row[0] {
                        // Same block as the fall-through: the label
                        // trampoline reuses the fall-through path.
                        continue;
                    }
                    let range = func.blocks[t as usize].inst_range.clone();
                    for id in range {
                        let Inst::Phi { incoming, .. } = &func.insts[id as usize] else {
                            break;
                        };
                        if incoming.iter().any(|(p, _)| *p == self_block) {
                            return false;
                        }
                    }
                }
                alloc::vec![row[0]]
            }
            Terminator::Return(_) | Terminator::TailExt(_) | Terminator::Unreachable => {
                alloc::vec![]
            }
        };
    for succ in succs {
        let head = func.blocks[succ as usize].inst_range.start;
        let end = func.blocks[succ as usize].inst_range.end;
        // Collect every phi's predecessor-exit move as one location-to-location
        // parallel copy per register file: a register reg-to-reg move can
        // overwrite a register a pending spill store still reads, so register
        // and stack-slot operands must be scheduled together. An FP phi (kind
        // F32 / F64) is FP-classed; every other phi is integer-classed. The two
        // files do not alias, so the two copies are independent.
        let mut moves: alloc::vec::Vec<(Place, Place)> = alloc::vec::Vec::new();
        let mut fp_moves: alloc::vec::Vec<(Place, Place)> = alloc::vec::Vec::new();
        // (bits, dst_place, is_f64) for a float constant feeding an FP phi.
        // `result_kind` classes every `Imm` in the integer file, so an FP
        // phi's only integer-file operand is a float constant; `phi_class`
        // refuses to coalesce the class boundary and delegates the move
        // here. Re-materialising the constant reads only reserved scratch,
        // so it is independent of the register moves scheduled above.
        let mut fp_const_moves: alloc::vec::Vec<(i64, Place, bool)> = alloc::vec::Vec::new();
        for id in head..end {
            let Inst::Phi { incoming, kind } = &func.insts[id as usize] else {
                break;
            };
            let Some((_, src_v)) = incoming.iter().find(|(pred, _)| *pred == self_block) else {
                continue;
            };
            let dst_place = alloc
                .places
                .get(id as usize)
                .copied()
                .unwrap_or(Place::None);
            let src_place = alloc
                .places
                .get(*src_v as usize)
                .copied()
                .unwrap_or(Place::None);
            let phi_is_fp = matches!(kind, LoadKind::F32 | LoadKind::F64);
            if matches!(dst_place, Place::None) {
                continue;
            }
            if phi_is_fp {
                if let Inst::Imm(bits) = func.insts[*src_v as usize] {
                    fp_const_moves.push((bits, dst_place, matches!(kind, LoadKind::F64)));
                    continue;
                }
                debug_assert!(
                    !matches!(src_place, Place::IntReg(_)),
                    "FP phi integer-file operand must be a constant"
                );
                if matches!(src_place, Place::None) {
                    continue;
                }
                fp_moves.push((src_place, dst_place));
            } else {
                if matches!(src_place, Place::None) {
                    continue;
                }
                moves.push((src_place, dst_place));
            }
        }
        if !schedule_place_moves(b, code, &mut moves, frame, int_hold, int_stage) {
            return false;
        }
        schedule_fp_place_moves(b, code, &mut fp_moves, frame, fp_hold, fp_stage);
        // After both same-file parallel copies: any FP move reading a phi's
        // register as its source has already run, so overwriting the FP
        // destination here cannot clobber a still-pending read.
        for (bits, dst, is_f64) in fp_const_moves {
            b.int_reg_load_imm(code, int_stage, bits);
            match dst {
                Place::FpReg(t) => b.fp_reg_from_int_reg(code, t, int_stage, is_f64),
                Place::Spill(slot) => {
                    b.fp_reg_from_int_reg(code, fp_stage, int_stage, is_f64);
                    b.fp_spill_store(code, frame, slot, fp_stage);
                }
                _ => {}
            }
        }
    }
    true
}

/// Sequentialize a set of parallel register moves `(src, dst)` (raw register
/// numbers), breaking any cycle through `scratch`. A move whose target is no
/// longer a pending source is emitted first; when only a cycle remains, one
/// source is copied into `scratch`, the moves that read it are redirected, and
/// the loop continues. `emit_mov(code, dst, src)` emits the backend's register
/// copy. Used by every move scheduler whose backend breaks cycles with a
/// scratch register; the x86_64 integer scheduler uses `xchg` instead.
pub(crate) fn schedule_reg_moves_via_scratch(
    code: &mut alloc::vec::Vec<u8>,
    moves: &mut alloc::vec::Vec<(u8, u8)>,
    scratch: u8,
    mut emit_mov: impl FnMut(&mut alloc::vec::Vec<u8>, u8, u8),
) {
    moves.retain(|(s, t)| s != t);
    while !moves.is_empty() {
        let mut progress = false;
        let mut i = 0;
        while i < moves.len() {
            let (s, t) = moves[i];
            let tgt_still_a_source = moves.iter().any(|(other_s, _)| *other_s == t);
            if !tgt_still_a_source {
                emit_mov(code, t, s);
                moves.swap_remove(i);
                progress = true;
            } else {
                i += 1;
            }
        }
        if !progress {
            let cycle_src = moves
                .iter()
                .map(|(s, _)| *s)
                .find(|&s| s != scratch)
                .unwrap_or(moves[0].0);
            emit_mov(code, scratch, cycle_src);
            for m in moves.iter_mut() {
                if m.0 == cycle_src {
                    m.0 = scratch;
                }
            }
        }
    }
}

/// The per-parameter incoming-register plan, once the backend's entry guard has
/// decided the function spills its named parameters. Routes through the
/// scalar planner when no parameter is an aggregate, else through the
/// struct-aware planner. The backend supplies the guard (x86_64 skips variadic
/// callees; aarch64 consults `spills_named_params_on_entry`).
pub(crate) fn param_placements_common(
    func: &super::super::ir::FunctionSsa,
    abi: super::Abi,
) -> alloc::vec::Vec<super::ArgPlacement> {
    if func.param_aggs.iter().all(Option::is_none) {
        return super::plan_param_regs(func.n_params, func.param_fp_mask, abi).placements;
    }
    let aggs = build_arg_aggs(&func.param_aggs, &func.agg_descs, abi);
    super::plan_param_regs_aggs(func.n_params, func.param_fp_mask, abi, &aggs).placements
}

/// Resolve each call argument's aggregate descriptor to its ABI classification
/// for the marshalling pass. Empty when no argument is an aggregate.
pub(crate) fn build_arg_aggs(
    arg_aggs: &[Option<u32>],
    agg_descs: &[super::super::ir::AggDesc],
    abi: super::Abi,
) -> alloc::vec::Vec<Option<super::ArgAgg>> {
    if arg_aggs.iter().all(Option::is_none) {
        return alloc::vec::Vec::new();
    }
    arg_aggs
        .iter()
        .map(|o| {
            o.map(|idx| {
                let d = &agg_descs[idx as usize];
                super::ArgAgg {
                    class: super::abi_classify::classify_aggregate(
                        d.size, d.align, &d.fields, abi, false,
                    ),
                    size: d.size,
                }
            })
        })
        .collect()
}

/// Whether per-pass wall-clock instrumentation is enabled. The
/// `BADC_TIME_PASSES` environment variable is consulted only under the
/// `codegen_test` feature; a production build always reports `false`
/// and never reads the environment or pays the per-pass
/// `std::time::Instant` cost.
#[cfg(feature = "codegen_test")]
pub(crate) fn time_passes_enabled() -> bool {
    std::env::var("BADC_TIME_PASSES").is_ok()
}

#[cfg(all(feature = "std", not(feature = "codegen_test")))]
pub(crate) fn time_passes_enabled() -> bool {
    false
}

/// Run `f`, measure wall-clock with `Instant::elapsed`, and print one
/// `pass: <label> -- <us>us` line on stderr when `time_passes_enabled`.
/// Returns whatever `f` returned so the caller can wrap a
/// value-producing closure in place. A no-op (the closure still runs)
/// outside the `codegen_test` feature.
#[cfg(feature = "codegen_test")]
pub(crate) fn time_pass<R>(label: &str, f: impl FnOnce() -> R) -> R {
    if !time_passes_enabled() {
        return f();
    }
    let start = std::time::Instant::now();
    let r = f();
    let us = start.elapsed().as_micros();
    eprintln!("pass: {label} -- {us}us");
    r
}

#[cfg(not(feature = "codegen_test"))]
pub(crate) fn time_pass<R>(_label: &str, f: impl FnOnce() -> R) -> R {
    f()
}

/// Diagnostic surface for a per-function SSA-emit fallback. The
/// per-arch emit paths call this when they hit a shape they
/// don't cover; the message lands on stderr only under the
/// `codegen_test` feature when `BADC_DUMP_SSA` is set, so production
/// builds never read the environment. The caller passes its own
/// backend tag (`"x86_64"`, `"aarch64"`) so logs from a single run
/// with both targets emit can be disambiguated by source.
pub(crate) fn bail_msg(backend: &str, reason: &str) {
    #[cfg(feature = "codegen_test")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!("ssa emit {backend}: bailed -- {reason}");
    }
    #[cfg(feature = "std")]
    LAST_BAIL.with(|b| *b.borrow_mut() = Some(alloc::string::String::from(reason)));
    let _ = (backend, reason);
}

#[cfg(feature = "std")]
std::thread_local! {
    /// The most recent [`bail_msg`] reason on this thread. The native-emit
    /// driver clears it before each function and reads it on a failure, so an
    /// unencodable inline-asm form reports its specific cause rather than the
    /// generic "op outside the implemented subset" fallback.
    static LAST_BAIL: core::cell::RefCell<Option<alloc::string::String>> =
        const { core::cell::RefCell::new(None) };
}

/// Take (and clear) the most recent [`bail_msg`] reason on this thread.
#[cfg(feature = "std")]
pub(crate) fn take_bail() -> Option<alloc::string::String> {
    LAST_BAIL.with(|b| b.borrow_mut().take())
}

// ------------------------------------------------------------------
// In-template assembler sections: `.pushsection` / `.section` data
// directives accumulated into named sections of the emitted object.
// Shared by both arch template parsers; the emitter resolves operand
// and label references and appends the finished [`AsmSection`]s to the
// build's section sink.
// ------------------------------------------------------------------

/// One value of a section data directive.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSectionValue {
    Const(i64),
    /// `%N` / `%cN` / `%c[name]` (canonicalized): the operand's
    /// compile-time constant.
    OperandConst(u8),
    /// A template label (`1b`, `name`) or a symbol, optionally PC-relative
    /// (`ref - .`) and carrying a constant addend (`func - (. + 4)`, a
    /// static-call trampoline's `jmp.d32`; `1b - %c2 - .`, the user-pointer
    /// bound). The emitter resolves a template label to a text offset; an
    /// unknown name is a symbol reference. `addend` is a constant expression
    /// (literals and `%cN` operand constants) evaluated at materialize time,
    /// empty when absent.
    Ref {
        name: alloc::string::String,
        pcrel: bool,
        addend: alloc::string::String,
    },
    /// `label_a - label_b`: the byte distance between two template-label
    /// definitions. Both resolve to text offsets at materialize time, so the
    /// difference is a compile-time constant stored in the field. Either
    /// label may be a forward or a backward reference.
    LabelDiff {
        minuend: alloc::string::String,
        subtrahend: alloc::string::String,
    },
    /// A constant expression mixing integer literals with `%N` operand
    /// constants (`(1 << 15) | (%0)`). Stored as text and evaluated at
    /// materialize time, where the operand constants are known.
    Expr(alloc::string::String),
    /// A relocation whose base is an `i`-class operand naming a link-time
    /// address (`%cN`) or an `asm goto` label (`%lN`), optionally with a
    /// constant addend and `- .` PC-relative. `%c0 + %c1 - .` (a static-key
    /// jump entry) folds `%c1` into the addend; `.long %c0 - .` (the bug
    /// table's file pointer) has no addend.
    OperandReloc {
        idx: u8,
        /// `%l` (an `asm goto` label) rather than `%c` (an operand address).
        goto: bool,
        /// Constant addend expression (operand constants + literals), empty
        /// when absent.
        addend: alloc::string::String,
        pcrel: bool,
    },
}

/// One item of an in-template section block, in source order.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSectionItem {
    /// A `.byte`-family directive: element width plus its values.
    Data {
        width: u8,
        values: alloc::vec::Vec<AsmSectionValue>,
    },
    /// `.balign n` / `.p2align e`, resolved to a byte alignment.
    Align(u32),
    /// `.align n`: GNU as interprets the argument per target -- a byte
    /// count on x86 ELF, a power-of-two exponent on AArch64. Resolved by
    /// the materializer under the arch's convention.
    AlignArch(u32),
    /// `.org n`: pad with zero bytes to section offset `n`.
    Org(u32),
    /// `.org label + expr`: pad to a section-local label's offset plus a
    /// constant expression (`.org 2b + %c3`, the `__bug_table` entry size).
    /// The label and expression resolve at materialize time.
    OrgLabel {
        label: alloc::string::String,
        addend: alloc::string::String,
    },
    /// `.ascii` / `.asciz` / `.string` payload (NUL included when the
    /// directive appends one).
    Bytes(alloc::vec::Vec<u8>),
    /// `name:`: a label defining a symbol at the current section offset.
    Label(alloc::string::String),
    /// `.globl name` / `.global name`: give the named label external
    /// binding. May precede or follow the label's definition.
    Global(alloc::string::String),
    /// `.type name, @function|@object`: set the named label's ELF symbol
    /// type. The label must be defined in this section.
    Type {
        name: alloc::string::String,
        sym_type: AsmSymType,
    },
    /// `.size name, expr`: set the named label's `st_size`. `expr` is a
    /// byte count -- a constant or a difference `. - name` whose terms are
    /// the current section offset (`.`) or a section label, evaluated at
    /// materialize time.
    Size {
        name: alloc::string::String,
        expr: alloc::string::String,
    },
    /// A single instruction line inside an executable (`"ax"`) section, as
    /// source text -- the x86 ALTERNATIVE replacement (`call %c[new]`) that
    /// lands in `.altinstr_replacement`. The arch backend encodes it to
    /// `CodeBytes` before layout (`encode_x86_asm_section_code`); one still
    /// text at layout is a target that does not assemble replacement code.
    Code(alloc::string::String),
    /// A replacement instruction encoded to machine bytes, with its
    /// relocations at offsets within those bytes (the layout rebases them by
    /// the item's section offset). Produced from `Code` by the arch backend.
    CodeBytes {
        bytes: alloc::vec::Vec<u8>,
        relocs: alloc::vec::Vec<AsmSectionReloc>,
    },
}

/// A parsed `.pushsection` / `.section` block of a template.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSectionBlock {
    pub name: alloc::string::String,
    /// Flag letters from the `"flags"` argument (`a`, `w`, `x`, ...).
    pub flags: alloc::string::String,
    /// `@type` / `%type` argument (`progbits`, `nobits`, ...), if any.
    pub sh_type: Option<alloc::string::String>,
    pub items: alloc::vec::Vec<AsmSectionItem>,
}

/// A relocation of a materialized section against the object.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSectionReloc {
    /// Byte offset of the field within the section.
    pub offset: u32,
    /// Field width in bytes (4 or 8).
    pub width: u8,
    /// PC-relative (`ref - .`) rather than absolute.
    pub pcrel: bool,
    /// A branch reloc reaching its symbol through the PLT slot
    /// (`R_X86_64_PLT32`) rather than a plain PC-relative data reference
    /// (`R_X86_64_PC32`). Set for a replacement instruction's direct
    /// `call` / `jmp` to a symbol; a data reference leaves it clear.
    pub branch: bool,
    pub target: AsmSectionTarget,
    pub addend: i64,
}

/// Relocation target of a section field.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSectionTarget {
    /// A byte offset into the emitted text (a resolved template label).
    Text(usize),
    /// A named symbol.
    Symbol(alloc::string::String),
    /// A byte offset into the emitted data image (an `i`-class operand
    /// naming a link-time address, `.long %c0 - .`). Resolved against the
    /// `.data` / `.bss` section symbol like a `DataFixup`.
    Data(u64),
    /// An `asm goto` label's block (`.long %l0 - .`, a static-key jump
    /// entry). The block's text offset is not known when the section
    /// materializes -- the walker leaves `start_pc` at 0 and the block is
    /// laid out later -- so the block index is carried here and rewritten to
    /// [`Self::Text`] once the function's `block_offsets` are final. It never
    /// reaches the object writer.
    TextBlock(u32),
    /// A label in a deferred replacement region (the AArch64 ALTERNATIVE
    /// `.subsection`), appended to `.text` after the enclosing function body.
    /// The region's final text base is not known when the section
    /// materializes, so the region index and the label's byte offset within
    /// the region are carried here and rewritten to [`Self::Text`] once the
    /// region is placed (see [`resolve_asm_deferred_relocs`]). It never
    /// reaches the object writer.
    DeferredText { region: u32, off: u32 },
}

/// Where a template label a section field references is defined. `label_off`
/// returns this so a `.word 663f - .` in the AArch64 ALTERNATIVE
/// `.altinstructions` entry relocates against the replacement's eventual
/// text offset rather than an emitted-stream offset.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum LabelLoc {
    /// Final byte offset in the emitted text (the main instruction stream).
    Text(usize),
    /// A label in a deferred replacement region: region index plus the
    /// label's byte offset within it.
    Deferred { region: u32, off: usize },
}

/// The address space a label difference's terms live in; a difference is a
/// compile-time constant only when both terms share one. Distinguishes the
/// emitted text stream, a deferred replacement region, and a named section.
#[derive(PartialEq, Eq)]
enum DiffSpace<'a> {
    Text,
    Deferred(u32),
    Section(&'a str),
}

/// A materialized named section: bytes plus relocations, accumulated
/// across the unit's inline-asm statements. The object writers append
/// one output section per distinct `(name, flags, sh_type)`.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSection {
    pub name: alloc::string::String,
    pub flags: alloc::string::String,
    pub sh_type: Option<alloc::string::String>,
    pub bytes: alloc::vec::Vec<u8>,
    pub relocs: alloc::vec::Vec<AsmSectionReloc>,
    /// Labels defined in the section; each becomes a symbol whose section
    /// index is this section and whose value is `offset` within it.
    pub labels: alloc::vec::Vec<AsmSectionLabel>,
    /// Largest `.balign` seen; the object writer aligns the section.
    pub align: u32,
}

/// Offset marking a `.globl` seen before its label definition.
const PENDING_LABEL: u32 = u32::MAX;

/// ELF symbol type set by a section's `.type name, @function|@object`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum AsmSymType {
    #[default]
    NoType,
    Func,
    Object,
}

/// A label defined inside a named section.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSectionLabel {
    pub name: alloc::string::String,
    /// Byte offset of the definition within the section's own bytes.
    pub offset: u32,
    /// `.globl`-declared: external rather than local binding.
    pub global: bool,
    /// Symbol type from a `.type` directive (`STT_NOTYPE` when absent).
    pub sym_type: AsmSymType,
    /// `st_size` from a `.size` directive; `None` leaves it zero.
    pub size: Option<u64>,
}

/// A snapshot of the accumulated section sink, taken before a function
/// body is laid out. `materialize_asm_sections` merges into existing
/// sections, so a branch-relaxation re-emit or a bailed emit needs to
/// undo the merge; a plain length truncation of the outer vector would
/// leave the appended bytes / relocs / labels in a pre-existing section.
pub(crate) struct AsmSectionsSnapshot {
    len: usize,
    per_section: alloc::vec::Vec<(usize, usize, usize, u32)>,
}

/// Record the sink's outer length and each existing section's bytes,
/// relocs, labels, and alignment.
pub(crate) fn snapshot_asm_sections(sink: &[AsmSection]) -> AsmSectionsSnapshot {
    AsmSectionsSnapshot {
        len: sink.len(),
        per_section: sink
            .iter()
            .map(|s| (s.bytes.len(), s.relocs.len(), s.labels.len(), s.align))
            .collect(),
    }
}

/// Restore the sink to a prior [`snapshot_asm_sections`]: drop sections
/// created since, and truncate each pre-existing section's contents.
pub(crate) fn restore_asm_sections(
    sink: &mut alloc::vec::Vec<AsmSection>,
    snap: &AsmSectionsSnapshot,
) {
    sink.truncate(snap.len);
    for (s, &(bytes, relocs, labels, align)) in sink.iter_mut().zip(&snap.per_section) {
        s.bytes.truncate(bytes);
        s.relocs.truncate(relocs);
        s.labels.truncate(labels);
        s.align = align;
    }
}

/// Rewrite the `AsmSectionTarget::TextBlock` relocations a function's
/// `asm goto` section fields left behind (relative to `snap`, its entry
/// snapshot) to concrete text offsets, now that its `block_offsets` are
/// final. `block_off` maps a block index to its byte offset in the text.
pub(crate) fn resolve_asm_goto_relocs(
    sink: &mut [AsmSection],
    snap: &AsmSectionsSnapshot,
    block_off: &dyn Fn(u32) -> usize,
) {
    for (i, s) in sink.iter_mut().enumerate() {
        let start = snap
            .per_section
            .get(i)
            .map_or(0, |&(_, relocs, _, _)| relocs);
        for r in s.relocs.iter_mut().skip(start) {
            if let AsmSectionTarget::TextBlock(bid) = r.target {
                r.target = AsmSectionTarget::Text(block_off(bid));
            }
        }
    }
}

/// Rewrite the `AsmSectionTarget::DeferredText` relocations a function's
/// ALTERNATIVE `.subsection` fields left behind (relative to `snap`, its
/// entry snapshot) to concrete text offsets, now that each deferred region
/// is placed. `region_base` maps a region index to its byte offset in the
/// text; the label's within-region offset is already in the target.
pub(crate) fn resolve_asm_deferred_relocs(
    sink: &mut [AsmSection],
    snap: &AsmSectionsSnapshot,
    region_base: &dyn Fn(u32) -> usize,
) {
    for (i, s) in sink.iter_mut().enumerate() {
        let start = snap
            .per_section
            .get(i)
            .map_or(0, |&(_, relocs, _, _)| relocs);
        for r in s.relocs.iter_mut().skip(start) {
            if let AsmSectionTarget::DeferredText { region, off } = r.target {
                r.target = AsmSectionTarget::Text(region_base(region) + off as usize);
            }
        }
    }
}

/// Resolve constant assembler conditionals (`.if` / `.elseif` / `.else` /
/// `.endif`), keeping only the taken branch. `.if <expr>` and `.ifeq` /
/// `.ifne` / `.ifgt` / `.iflt` / `.ifge` / `.ifle` test a constant expression;
/// a non-constant condition is an error. Returns `None` when the template has
/// no conditional. This runs before section extraction so a dropped branch
/// takes its `.pushsection` with it. Statements are the `;` / newline pieces
/// the rest of the pipeline splits on, rejoined with newlines.
pub(crate) fn strip_asm_conditionals(
    text: &str,
) -> Result<Option<alloc::string::String>, alloc::string::String> {
    if !text.contains(".if") {
        return Ok(None);
    }
    // Each open conditional: (this branch emits, some branch already taken).
    let mut stack: alloc::vec::Vec<(bool, bool)> = alloc::vec::Vec::new();
    let emitting = |st: &[(bool, bool)]| st.iter().all(|&(on, _)| on);
    let cond_of = |tok: &str, rest: &str| -> Result<bool, alloc::string::String> {
        let v = eval_asm_if_condition(rest)
            .ok_or_else(|| alloc::format!("inline asm: non-constant `{tok}` condition `{rest}`"))?;
        Ok(match tok {
            ".ifeq" => v == 0,
            ".ifne" | ".if" => v != 0,
            ".ifgt" => v > 0,
            ".iflt" => v < 0,
            ".ifge" => v >= 0,
            ".ifle" => v <= 0,
            _ => {
                return Err(alloc::format!(
                    "inline asm: unsupported conditional `{tok}`"
                ));
            }
        })
    };
    let mut out = alloc::string::String::with_capacity(text.len());
    for piece in text.split([';', '\n']) {
        let trimmed = piece.trim();
        let (tok, rest) = match trimmed.find(char::is_whitespace) {
            Some(p) => (&trimmed[..p], trimmed[p..].trim()),
            None => (trimmed, ""),
        };
        match tok {
            ".if" | ".ifeq" | ".ifne" | ".ifgt" | ".iflt" | ".ifge" | ".ifle" => {
                let taken = emitting(&stack) && cond_of(tok, rest)?;
                stack.push((taken, taken));
            }
            ".elseif" => {
                let outer = emitting(&stack[..stack.len().saturating_sub(1)]);
                let frame = stack
                    .last_mut()
                    .ok_or("inline asm: `.elseif` without `.if`")?;
                let taken = outer && !frame.1 && cond_of(".if", rest)?;
                frame.0 = taken;
                frame.1 |= taken;
            }
            ".else" => {
                let outer = emitting(&stack[..stack.len().saturating_sub(1)]);
                let frame = stack
                    .last_mut()
                    .ok_or("inline asm: `.else` without `.if`")?;
                frame.0 = outer && !frame.1;
                frame.1 = true;
            }
            ".endif" => {
                stack.pop().ok_or("inline asm: `.endif` without `.if`")?;
            }
            _ => {
                if !trimmed.is_empty() && emitting(&stack) {
                    out.push_str(trimmed);
                    out.push('\n');
                }
            }
        }
    }
    if !stack.is_empty() {
        return Err(alloc::string::String::from(
            "inline asm: unterminated `.if`",
        ));
    }
    Ok(Some(out))
}

/// A local macro defined by `.macro` inside one inline-asm block.
struct GasMacro {
    params: alloc::vec::Vec<alloc::string::String>,
    body: alloc::vec::Vec<alloc::string::String>,
}

const GAS_MACRO_DEPTH_LIMIT: usize = 64;

/// Expand the GNU as macro directives an inline-asm block uses to generate
/// instructions: `.irp`/`.endr` (repeat), `.macro`/`.endm`/`.purgem` (local
/// macro definition, invocation, removal), `.equ`/`.set` (symbol assignment),
/// and `.inst` (emit an `inst_width`-byte instruction word). `.inst`
/// expressions fold to a `.byte` run, macro invocations to their expanded
/// bodies, and `.equ` symbols resolve in every expression. `None` when the
/// template uses none of these (the common case).
///
/// `subst` resolves an operand reference (`%0` / `%w0` / `%c0`) to its
/// register-name or constant text, applied across the template before the
/// directives run -- mirroring the compiler substitution that precedes the
/// assembler, so an operand register is concrete before the `.equ`
/// register-number table (`.L__gpr_num_x1 = 1`) resolves it. The macro and
/// symbol tables are call-local, giving two expansions in one unit the
/// independence GNU as gives a `.purgem`'d macro.
pub(crate) fn expand_asm_gas_macros(
    text: &str,
    inst_width: usize,
    subst: &dyn Fn(&str) -> Option<alloc::string::String>,
) -> Result<Option<alloc::string::String>, alloc::string::String> {
    if !(text.contains(".irp")
        || text.contains(".macro")
        || text.contains(".inst")
        || text.contains(".equ")
        || text.contains(".set")
        || text.contains(".purgem"))
    {
        return Ok(None);
    }
    let substituted = subst_asm_operands(text, subst);
    let stmts: alloc::vec::Vec<alloc::string::String> = substituted
        .split([';', '\n'])
        .map(|s| alloc::string::String::from(s.trim()))
        .collect();
    let mut macros: alloc::collections::BTreeMap<alloc::string::String, GasMacro> =
        alloc::collections::BTreeMap::new();
    let mut equ: alloc::collections::BTreeMap<alloc::string::String, i64> =
        alloc::collections::BTreeMap::new();
    let mut out = alloc::string::String::with_capacity(text.len());
    expand_gas_statements(&stmts, &mut macros, &mut equ, &mut out, inst_width, 0)?;
    Ok(Some(out))
}

fn expand_gas_statements(
    stmts: &[alloc::string::String],
    macros: &mut alloc::collections::BTreeMap<alloc::string::String, GasMacro>,
    equ: &mut alloc::collections::BTreeMap<alloc::string::String, i64>,
    out: &mut alloc::string::String,
    inst_width: usize,
    depth: usize,
) -> Result<(), alloc::string::String> {
    if depth > GAS_MACRO_DEPTH_LIMIT {
        return Err(alloc::string::String::from(
            "inline asm: macro expansion nested too deep",
        ));
    }
    let mut i = 0usize;
    while i < stmts.len() {
        let s = stmts[i].as_str();
        i += 1;
        if s.is_empty() {
            continue;
        }
        let (tok, rest) = match s.find(char::is_whitespace) {
            Some(p) => (&s[..p], s[p..].trim()),
            None => (s, ""),
        };
        match tok {
            ".macro" => {
                let (name, params) = parse_gas_macro_header(rest)?;
                let (body, next) = collect_gas_body(stmts, i, ".macro", ".endm")?;
                macros.insert(name, GasMacro { params, body });
                i = next;
            }
            ".endm" => {
                return Err(alloc::string::String::from(
                    "inline asm: `.endm` without `.macro`",
                ));
            }
            ".purgem" => {
                let name = rest.trim();
                if macros.remove(name).is_none() {
                    return Err(alloc::format!(
                        "inline asm: `.purgem` of undefined macro `{name}`"
                    ));
                }
            }
            ".irp" => {
                let (var, values) = parse_gas_irp_header(rest)?;
                let (body, next) = collect_gas_body(stmts, i, ".irp", ".endr")?;
                i = next;
                for val in &values {
                    let mut map = alloc::collections::BTreeMap::new();
                    map.insert(var.clone(), val.clone());
                    let expanded: alloc::vec::Vec<alloc::string::String> =
                        body.iter().map(|l| subst_gas_params(l, &map)).collect();
                    expand_gas_statements(&expanded, macros, equ, out, inst_width, depth + 1)?;
                }
            }
            ".endr" => {
                return Err(alloc::string::String::from(
                    "inline asm: `.endr` without `.irp`",
                ));
            }
            ".equ" | ".set" | ".equiv" => {
                // A single-argument `.set` (`.set noreorder`) is not a symbol
                // assignment; pass it through unchanged.
                let Some((sym, expr)) = rest.split_once(',') else {
                    out.push_str(s);
                    out.push('\n');
                    continue;
                };
                let table = &*equ;
                let v = eval_asm_expr_with_labels(expr.trim(), &|t| table.get(t).copied())
                    .ok_or_else(|| {
                        alloc::format!("inline asm: `{tok} {}` value is not constant", sym.trim())
                    })?;
                equ.insert(alloc::string::String::from(sym.trim()), v);
            }
            ".inst" | ".inst.n" | ".inst.w" => {
                for arg in split_top_commas(rest) {
                    let table = &*equ;
                    let v = eval_asm_expr_with_labels(arg, &|t| table.get(t).copied()).ok_or_else(
                        || alloc::format!("inline asm: `.inst` operand `{arg}` is not constant"),
                    )?;
                    let bytes = (v as u64).to_le_bytes();
                    out.push_str(".byte ");
                    for (k, b) in bytes.iter().take(inst_width).enumerate() {
                        if k > 0 {
                            out.push_str(", ");
                        }
                        out.push_str(&alloc::format!("0x{b:02x}"));
                    }
                    out.push('\n');
                }
            }
            _ => {
                if macros.contains_key(tok) {
                    // Bind arguments to parameters, then expand and re-process
                    // the body (which may define, invoke, or purge macros).
                    let def = &macros[tok];
                    let params = def.params.clone();
                    let body = def.body.clone();
                    let args = split_top_commas(rest);
                    let mut map = alloc::collections::BTreeMap::new();
                    for (p, a) in params.iter().zip(args.iter()) {
                        map.insert(p.clone(), alloc::string::String::from(*a));
                    }
                    for p in params.iter().skip(args.len()) {
                        map.insert(p.clone(), alloc::string::String::new());
                    }
                    let expanded: alloc::vec::Vec<alloc::string::String> =
                        body.iter().map(|l| subst_gas_params(l, &map)).collect();
                    expand_gas_statements(&expanded, macros, equ, out, inst_width, depth + 1)?;
                } else {
                    // A pass-through line. Resolve any `.equ` symbol so a
                    // `.short`/`.long` value (the exception-table register
                    // field) is constant when the section pass reads it.
                    if equ.is_empty() {
                        out.push_str(s);
                    } else {
                        out.push_str(&subst_asm_idents(s, &|t| equ.get(t).copied()));
                    }
                    out.push('\n');
                }
            }
        }
    }
    Ok(())
}

/// Expand GNU as `.rept N` / `.endr` (repeat the enclosed lines N times) into
/// straight-line text. `None` when the text has no `.rept` (the common case).
/// `N` is a constant expression; a non-constant count, a stray `.endr`, or an
/// unclosed `.rept` is an error as in GNU as, and `N <= 0` emits the body zero
/// times. Nested `.rept` expand through the same pass. An AArch64 ALTERNATIVE
/// replacement uses it to pad (a repeated `nop`) the out-of-line replacement to
/// the original sequence's length.
pub(crate) fn expand_asm_rept(
    text: &str,
) -> Result<Option<alloc::string::String>, alloc::string::String> {
    if !text.contains(".rept") {
        return Ok(None);
    }
    let stmts: alloc::vec::Vec<alloc::string::String> = text
        .split([';', '\n'])
        .map(|s| alloc::string::String::from(s.trim()))
        .collect();
    let mut out = alloc::string::String::with_capacity(text.len());
    expand_rept_statements(&stmts, &mut out, 0)?;
    Ok(Some(out))
}

fn expand_rept_statements(
    stmts: &[alloc::string::String],
    out: &mut alloc::string::String,
    depth: usize,
) -> Result<(), alloc::string::String> {
    if depth > GAS_MACRO_DEPTH_LIMIT {
        return Err(alloc::string::String::from(
            "inline asm: `.rept` nested too deep",
        ));
    }
    let mut i = 0usize;
    while i < stmts.len() {
        let s = stmts[i].as_str();
        i += 1;
        let (tok, rest) = match s.find(char::is_whitespace) {
            Some(p) => (&s[..p], s[p..].trim()),
            None => (s, ""),
        };
        match tok {
            ".rept" => {
                let n = eval_asm_expr_with_labels(rest, &|_| None).ok_or_else(|| {
                    alloc::format!("inline asm: `.rept` count `{rest}` is not constant")
                })?;
                let (body, next) = collect_gas_body(stmts, i, ".rept", ".endr")?;
                i = next;
                for _ in 0..n.max(0) as usize {
                    expand_rept_statements(&body, out, depth + 1)?;
                }
            }
            ".endr" => {
                return Err(alloc::string::String::from(
                    "inline asm: `.endr` without `.rept`",
                ));
            }
            _ => {
                out.push_str(s);
                out.push('\n');
            }
        }
    }
    Ok(())
}

/// Collect a `.macro` / `.irp` / `.rept` body up to its matching `close`,
/// nesting-aware.
fn collect_gas_body(
    stmts: &[alloc::string::String],
    start: usize,
    open: &str,
    close: &str,
) -> Result<(alloc::vec::Vec<alloc::string::String>, usize), alloc::string::String> {
    let mut depth = 1i32;
    let mut body = alloc::vec::Vec::new();
    let mut i = start;
    while i < stmts.len() {
        let first = stmts[i]
            .split(char::is_whitespace)
            .next()
            .unwrap_or(stmts[i].as_str());
        if first == open {
            depth += 1;
        } else if first == close {
            depth -= 1;
            if depth == 0 {
                return Ok((body, i + 1));
            }
        }
        body.push(stmts[i].clone());
        i += 1;
    }
    Err(alloc::format!("inline asm: `{open}` without `{close}`"))
}

/// Parse a `.macro` header `NAME[,] p1[, p2 ...]`; a `=default` / `:qualifier`
/// on a parameter is dropped (parameters bind positionally).
fn parse_gas_macro_header(
    rest: &str,
) -> Result<
    (
        alloc::string::String,
        alloc::vec::Vec<alloc::string::String>,
    ),
    alloc::string::String,
> {
    let mut it = rest
        .split(|c: char| c == ',' || c.is_whitespace())
        .filter(|t| !t.is_empty());
    let name = it.next().ok_or("inline asm: `.macro` without a name")?;
    let params = it
        .map(|p| alloc::string::String::from(p.split(['=', ':']).next().unwrap_or(p)))
        .collect();
    Ok((alloc::string::String::from(name), params))
}

/// Parse a `.irp` header `VAR,v1,v2,...`; with no values the body expands once
/// with the symbol empty (GNU as convention).
fn parse_gas_irp_header(
    rest: &str,
) -> Result<
    (
        alloc::string::String,
        alloc::vec::Vec<alloc::string::String>,
    ),
    alloc::string::String,
> {
    let rest = rest.trim();
    let end = rest
        .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
        .unwrap_or(rest.len());
    if end == 0 {
        return Err(alloc::string::String::from(
            "inline asm: `.irp` without a symbol",
        ));
    }
    let var = alloc::string::String::from(&rest[..end]);
    let mut values: alloc::vec::Vec<alloc::string::String> = rest[end..]
        .split(|c: char| c == ',' || c.is_whitespace())
        .filter(|t| !t.is_empty())
        .map(alloc::string::String::from)
        .collect();
    if values.is_empty() {
        values.push(alloc::string::String::new());
    }
    Ok((var, values))
}

/// Substitute `\param` in a macro / `.irp` body with its bound value. `\()`
/// is an empty name separator; an unbound `\name` stays verbatim.
fn subst_gas_params(
    line: &str,
    map: &alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
) -> alloc::string::String {
    if !line.contains('\\') {
        return alloc::string::String::from(line);
    }
    let mut out = alloc::string::String::with_capacity(line.len());
    let mut rest = line;
    while let Some(pos) = rest.find('\\') {
        out.push_str(&rest[..pos]);
        let after = &rest[pos + 1..];
        if let Some(tail) = after.strip_prefix("()") {
            rest = tail;
            continue;
        }
        let end = after
            .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_'))
            .unwrap_or(after.len());
        let name = &after[..end];
        match map.get(name) {
            Some(v) => {
                out.push_str(v);
                rest = &after[end..];
            }
            None => {
                out.push('\\');
                rest = after;
            }
        }
    }
    out.push_str(rest);
    out
}

/// Substitute operand references (`%0` / `%w0` / `%c0`) with the text `subst`
/// yields; `%%` is a literal percent. An unresolved reference stays a bare `%`,
/// which the downstream parser rejects rather than mis-encodes.
fn subst_asm_operands(
    text: &str,
    subst: &dyn Fn(&str) -> Option<alloc::string::String>,
) -> alloc::string::String {
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut rest = text;
    while let Some(pos) = rest.find('%') {
        out.push_str(&rest[..pos]);
        let after = &rest[pos + 1..];
        let ab = after.as_bytes();
        if ab.first() == Some(&b'%') {
            out.push('%');
            rest = &after[1..];
            continue;
        }
        // `%` + optional modifier letter + digits.
        let mut j = 0;
        if ab.first().is_some_and(u8::is_ascii_alphabetic) {
            j += 1;
        }
        let dig = j;
        while j < ab.len() && ab[j].is_ascii_digit() {
            j += 1;
        }
        if j > dig
            && let Some(r) = subst(&rest[pos..pos + 1 + j])
        {
            out.push_str(&r);
            rest = &after[j..];
            continue;
        }
        out.push('%');
        rest = after;
    }
    out.push_str(rest);
    out
}

/// Split a directive argument list on top-level commas, ignoring commas nested
/// in `()` / `[]` / `{}`. Empty pieces are dropped.
fn split_top_commas(s: &str) -> alloc::vec::Vec<&str> {
    let mut parts = alloc::vec::Vec::new();
    let b = s.as_bytes();
    let mut depth = 0i32;
    let mut start = 0usize;
    for (i, &c) in b.iter().enumerate() {
        match c {
            b'(' | b'[' | b'{' => depth += 1,
            b')' | b']' | b'}' => depth -= 1,
            b',' if depth == 0 => {
                let p = s[start..i].trim();
                if !p.is_empty() {
                    parts.push(p);
                }
                start = i + 1;
            }
            _ => {}
        }
    }
    let p = s[start..].trim();
    if !p.is_empty() {
        parts.push(p);
    }
    parts
}

/// Split an AArch64 ALTERNATIVE template into its main stream and the
/// `.subsection` replacement code GNU as appends to the section after the
/// main content. The kernel `ALTERNATIVE` macro places the replacement in
/// `.subsection 1` bracketed by `.previous`, out of the main sequence's
/// fall-through path. Returns `(main, deferred)`; `deferred` is empty (and
/// `main` is `text` unchanged) when there is no `.subsection` or when its
/// shape is one this pass does not lift: nested in a `.pushsection`, without
/// a closing `.previous`, a second region in the same template, or a
/// non-numeric subsection number. `extract_asm_sections` then rejects the
/// left-in `.subsection` rather than this dropping it silently.
pub(crate) fn split_asm_subsections(text: &str) -> (alloc::string::String, alloc::string::String) {
    let unchanged = || {
        (
            alloc::string::String::from(text),
            alloc::string::String::new(),
        )
    };
    if !text.contains(".subsection") {
        return unchanged();
    }
    let mut main = alloc::string::String::with_capacity(text.len());
    let mut deferred = alloc::string::String::new();
    // `.pushsection` / `.popsection` nesting; a `.subsection` is a code-stream
    // directive only at depth 0. `seen` guards against a second region.
    let mut push_depth: i32 = 0;
    let mut in_deferred = false;
    let mut seen = false;
    for line in text.split('\n') {
        let t = line.trim();
        let tok = t.split(char::is_whitespace).next().unwrap_or("");
        match tok {
            ".pushsection" | ".section" if !in_deferred => {
                push_depth += 1;
            }
            ".popsection" if !in_deferred => {
                push_depth -= 1;
            }
            ".subsection" if push_depth == 0 && !in_deferred && !seen => {
                let n = t[tok.len()..].trim();
                match n.parse::<u32>() {
                    Ok(0) => return unchanged(),
                    Ok(_) => {
                        in_deferred = true;
                        seen = true;
                        continue;
                    }
                    Err(_) => return unchanged(),
                }
            }
            ".subsection" => return unchanged(),
            ".previous" if in_deferred => {
                in_deferred = false;
                continue;
            }
            _ => {}
        }
        if in_deferred {
            deferred.push_str(line);
            deferred.push('\n');
        } else {
            main.push_str(line);
            main.push('\n');
        }
    }
    // A region left open (no `.previous`) is a shape this pass does not lift.
    if in_deferred {
        return unchanged();
    }
    (main, deferred)
}

/// Split a template into its code text and its section blocks. Returns
/// `None` when the template has no section directives (the common case).
/// The section stack starts at the code stream; `.pushsection` pushes a
/// named section, `.popsection` pops, `.section` replaces the top, and
/// `.previous` swaps the top two. Only data directives are accepted
/// inside a named section (code in sections is TODO).
pub(crate) fn extract_asm_sections(
    text: &str,
    is_aarch64: bool,
) -> Result<Option<(alloc::string::String, alloc::vec::Vec<AsmSectionBlock>)>, alloc::string::String>
{
    if !text.contains(".pushsection") && !text.contains(".section") && !text.contains(".subsection")
    {
        return Ok(None);
    }
    let mut code = alloc::string::String::with_capacity(text.len());
    let mut blocks: alloc::vec::Vec<AsmSectionBlock> = alloc::vec::Vec::new();
    // Stack of indices into `blocks`; `None` is the code stream.
    let mut stack: alloc::vec::Vec<Option<usize>> = alloc::vec![None];
    for piece in text.split([';', '\n']) {
        let piece = piece.trim();
        let (tok, rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        match tok {
            ".pushsection" | ".section" => {
                let block = parse_section_args(rest)?;
                let idx = blocks.len();
                blocks.push(block);
                if tok == ".pushsection" {
                    stack.push(Some(idx));
                } else {
                    *stack.last_mut().unwrap() = Some(idx);
                }
                continue;
            }
            ".popsection" => {
                if stack.len() < 2 {
                    return Err(alloc::string::String::from(
                        "inline asm: `.popsection` without `.pushsection`",
                    ));
                }
                stack.pop();
                continue;
            }
            ".previous" => {
                if stack.len() >= 2 {
                    let n = stack.len();
                    stack.swap(n - 1, n - 2);
                } else {
                    // A `.section` at stack bottom returns to the code
                    // stream.
                    stack[0] = None;
                }
                continue;
            }
            // `.subsection N` defers its code to a region appended to the
            // section (the cpucap ALTERNATIVE replacement). Emitting it
            // inline would fall through from the main sequence into the
            // replacement -- both would execute. TODO assemble the replacement
            // into the appended region with its relocations; until then reject
            // rather than miscompile.
            ".subsection" => {
                return Err(alloc::string::String::from(
                    "inline asm: `.subsection` is not supported (deferred replacement code)",
                ));
            }
            _ => {}
        }
        if piece.is_empty() {
            continue;
        }
        match *stack.last().unwrap() {
            None => {
                code.push_str(piece);
                code.push('\n');
            }
            Some(idx) => {
                // Peel any leading `name:` labels; GNU as allows a directive
                // to follow a label on the same line.
                let (mut tok, mut rest) = (tok, rest);
                while let Some(name) = tok.strip_suffix(':') {
                    // A numeric label (`2:`, `14470:`) is a GNU as local label;
                    // the materializer gives each a per-instance-unique symbol.
                    if !is_asm_symbol_name(name) && !is_numeric_label(name) {
                        return Err(alloc::format!("inline asm: bad label `{tok}:`"));
                    }
                    blocks[idx]
                        .items
                        .push(AsmSectionItem::Label(alloc::string::String::from(name)));
                    let (t, r) = match rest.find(char::is_whitespace) {
                        Some(p) => (&rest[..p], rest[p..].trim()),
                        None => (rest, ""),
                    };
                    if t.is_empty() {
                        tok = t;
                        break;
                    }
                    tok = t;
                    rest = r;
                }
                if !tok.is_empty() {
                    // An `"ax"`-flagged section may hold replacement
                    // instructions (the x86 ALTERNATIVE), kept as text for the
                    // arch backend to encode; a data section rejects code.
                    let exec = blocks[idx].flags.contains('x');
                    blocks[idx]
                        .items
                        .push(parse_section_item(tok, rest, is_aarch64, exec)?);
                }
            }
        }
    }
    Ok(Some((code, blocks)))
}

/// Parse the argument list of `.pushsection` / `.section`:
/// `name[,"flags"[,@type]]`.
fn parse_section_args(rest: &str) -> Result<AsmSectionBlock, alloc::string::String> {
    let mut parts = rest.split(',').map(str::trim);
    // The name may be quoted (`.section ".export_symbol","a"`); the quotes
    // are syntax, not part of the section name.
    let name = parts
        .next()
        .map(|n| {
            n.strip_prefix('"')
                .and_then(|n| n.strip_suffix('"'))
                .unwrap_or(n)
        })
        .filter(|n| !n.is_empty())
        .ok_or_else(|| alloc::string::String::from("inline asm: section name expected"))?;
    let mut flags = alloc::string::String::new();
    let mut sh_type = None;
    for p in parts {
        if let Some(f) = p.strip_prefix('"').and_then(|p| p.strip_suffix('"')) {
            flags = alloc::string::String::from(f);
        } else if let Some(t) = p.strip_prefix('@').or_else(|| p.strip_prefix('%')) {
            sh_type = Some(alloc::string::String::from(t));
        } else if parse_raw_int(p).is_some() {
            // The entsize of a `M`-flagged mergeable section
            // (`.rodata.str,"aMS",@progbits,1`). The merge/strings flags are
            // dropped for a relocatable object, so its entsize is too.
        } else if !p.is_empty() {
            return Err(alloc::format!("inline asm: bad section argument `{p}`"));
        }
    }
    Ok(AsmSectionBlock {
        name: alloc::string::String::from(name),
        flags,
        sh_type,
        items: alloc::vec::Vec::new(),
    })
}

/// An assembler symbol name: identifier characters, not starting with a
/// digit (which would be a local numeric label, not a symbol definition).
fn is_asm_symbol_name(name: &str) -> bool {
    !name.is_empty()
        && !name.as_bytes()[0].is_ascii_digit()
        && name
            .bytes()
            .all(|c| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$'))
}

/// A GNU as local numeric label: all decimal digits (`2`, `14470`). Its
/// definition (`2:`) and references (`2b` / `2f`) are local to one asm
/// instance, so the materializer renames each to a unique symbol.
fn is_numeric_label(name: &str) -> bool {
    !name.is_empty() && name.bytes().all(|c| c.is_ascii_digit())
}

/// Split a numeric-label reference into its digits, dropping a trailing
/// GNU as direction suffix (`14472b` / `14471f` -> `14472` / `14471`).
/// Returns `None` when the reference is not a numeric label.
fn numeric_label_digits(name: &str) -> Option<&str> {
    let digits = name.strip_suffix(['b', 'f']).unwrap_or(name);
    is_numeric_label(digits).then_some(digits)
}

/// One GNU as local (numeric) label occurrence in a template: a definition
/// (`2:`) or a reference (`2f` / `2b`). `start`..`end` spans the token in the
/// source text -- the digits for a definition (the `:` stays), the digits and
/// the direction letter for a reference.
struct LocalLabelTok<'a> {
    start: usize,
    end: usize,
    num: &'a str,
    /// `Some(forward)` for a reference, `None` for a definition.
    reference: Option<bool>,
}

/// Scan a template for GNU as local (numeric) label definitions (`2:`) and
/// references (`2f` / `2b`). A digit run is a label token only at a token
/// boundary -- so `0x1f`, `sym1`, and a fractional `0.5f` are skipped -- and,
/// for a reference, only when the direction letter ends the token (`2foo` is a
/// symbol, not `2f`).
fn scan_local_label_tokens(text: &str) -> alloc::vec::Vec<LocalLabelTok<'_>> {
    let b = text.as_bytes();
    let n = b.len();
    let mut out = alloc::vec::Vec::new();
    let mut i = 0;
    while i < n {
        if !b[i].is_ascii_digit() {
            i += 1;
            continue;
        }
        let boundary = i == 0 || {
            let p = b[i - 1];
            !(p.is_ascii_alphanumeric() || matches!(p, b'_' | b'.'))
        };
        let ds = i;
        while i < n && b[i].is_ascii_digit() {
            i += 1;
        }
        let de = i;
        if !boundary {
            continue;
        }
        if i < n && (b[i] == b'b' || b[i] == b'f') {
            let ends = i + 1 >= n || !(b[i + 1].is_ascii_alphanumeric() || b[i + 1] == b'_');
            if ends {
                out.push(LocalLabelTok {
                    start: ds,
                    end: i + 1,
                    num: &text[ds..de],
                    reference: Some(b[i] == b'f'),
                });
                i += 1;
                continue;
            }
        }
        if i < n && b[i] == b':' {
            out.push(LocalLabelTok {
                start: ds,
                end: de,
                num: &text[ds..de],
                reference: None,
            });
        }
    }
    out
}

/// Rewrite GNU as local (numeric) labels defined more than once in one asm
/// instance to per-definition unique names, binding each `Nf` / `Nb`
/// reference to the nearest definition in its direction by source position
/// (`f` a greater position, `b` a not-greater one). The rest of the pipeline
/// resolves a label as a single-definition symbol, so this turns the
/// multiple-definition case -- a template reusing `1:` across nested
/// replacement blocks -- into the handled named-label case. A number defined
/// once keeps its numeric form (the common case), so the result is `None` when
/// no number is defined more than once.
pub(crate) fn rewrite_multidef_local_labels(text: &str) -> Option<alloc::string::String> {
    let toks = scan_local_label_tokens(text);
    let mut def_counts: alloc::collections::BTreeMap<&str, usize> =
        alloc::collections::BTreeMap::new();
    for t in &toks {
        if t.reference.is_none() {
            *def_counts.entry(t.num).or_default() += 1;
        }
    }
    if def_counts.values().all(|&c| c < 2) {
        return None;
    }
    let uniq = ASM_INSTANCE.fetch_add(1, core::sync::atomic::Ordering::Relaxed);
    // Each multiply-defined number's definitions in source order, paired with
    // the unique name assigned to that definition.
    let mut defs: alloc::collections::BTreeMap<
        &str,
        alloc::vec::Vec<(usize, alloc::string::String)>,
    > = alloc::collections::BTreeMap::new();
    for t in &toks {
        if t.reference.is_none() && def_counts[t.num] >= 2 {
            let v = defs.entry(t.num).or_default();
            let name = alloc::format!(".Lc5ll_{uniq}_{}_{}", t.num, v.len());
            v.push((t.start, name));
        }
    }
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut last = 0;
    for t in &toks {
        let Some(list) = defs.get(t.num) else {
            continue; // defined once: keep the numeric form
        };
        let name = match t.reference {
            None => list.iter().find(|(p, _)| *p == t.start).map(|(_, s)| s),
            Some(true) => list
                .iter()
                .filter(|(p, _)| *p > t.start)
                .min_by_key(|(p, _)| *p)
                .map(|(_, s)| s),
            Some(false) => list
                .iter()
                .filter(|(p, _)| *p <= t.start)
                .max_by_key(|(p, _)| *p)
                .map(|(_, s)| s),
        };
        let Some(name) = name else {
            continue; // no definition in the reference's direction: leave it
        };
        out.push_str(&text[last..t.start]);
        out.push_str(name);
        last = t.end;
    }
    out.push_str(&text[last..]);
    Some(out)
}

/// Parse one directive inside a named section. `exec` marks an
/// `"ax"`-flagged section, where a non-directive token is a replacement
/// instruction kept as text; a data section rejects one.
fn parse_section_item(
    tok: &str,
    rest: &str,
    is_aarch64: bool,
    exec: bool,
) -> Result<AsmSectionItem, alloc::string::String> {
    if let Some(w) = data_directive_width(tok) {
        // `.word` is target-dependent: 2 bytes on x86 ELF, 4 on AArch64.
        let w = if tok == ".word" && is_aarch64 { 4 } else { w };
        let mut values = alloc::vec::Vec::new();
        for a in rest.split(',') {
            values.push(parse_section_value(a.trim())?);
        }
        return Ok(AsmSectionItem::Data {
            width: w as u8,
            values,
        });
    }
    match tok {
        ".balign" => {
            let n = parse_raw_int(rest)
                .filter(|&n| n > 0 && (n as u64).is_power_of_two())
                .ok_or_else(|| alloc::format!("inline asm: bad alignment `{rest}`"))?;
            Ok(AsmSectionItem::Align(n as u32))
        }
        ".align" => {
            let n = parse_raw_int(rest)
                .filter(|&n| (1..=4096).contains(&n))
                .ok_or_else(|| alloc::format!("inline asm: bad alignment `{rest}`"))?;
            Ok(AsmSectionItem::AlignArch(n as u32))
        }
        ".p2align" => {
            let e = parse_raw_int(rest)
                .filter(|&e| (0..=12).contains(&e))
                .ok_or_else(|| alloc::format!("inline asm: bad alignment `{rest}`"))?;
            Ok(AsmSectionItem::Align(1 << e))
        }
        ".org" => {
            if let Some(n) = parse_raw_int(rest).filter(|&n| n >= 0) {
                return Ok(AsmSectionItem::Org(n as u32));
            }
            // `.org label + expr`: the target is a section-local label's offset
            // plus a constant. Split on the first `+`; the label must be a
            // backward numeric reference or a symbol name.
            let (label, addend) = rest
                .split_once('+')
                .map(|(l, r)| (l.trim(), r.trim()))
                .unwrap_or((rest.trim(), "0"));
            if numeric_label_digits(label).is_none() && !is_asm_symbol_name(label) {
                return Err(alloc::format!("inline asm: bad `.org` offset `{rest}`"));
            }
            Ok(AsmSectionItem::OrgLabel {
                label: alloc::string::String::from(label),
                addend: alloc::string::String::from(addend),
            })
        }
        ".ascii" | ".asciz" | ".string" => {
            let s = rest
                .strip_prefix('"')
                .and_then(|r| r.strip_suffix('"'))
                .ok_or_else(|| {
                    alloc::format!("inline asm: string literal expected after `{tok}`")
                })?;
            let mut bytes: alloc::vec::Vec<u8> = alloc::vec::Vec::new();
            let mut it = s.bytes();
            while let Some(b) = it.next() {
                // The template already went through C string parsing; only
                // the simple escapes survive here.
                if b == b'\\' {
                    match it.next() {
                        Some(b'n') => bytes.push(b'\n'),
                        Some(b't') => bytes.push(b'\t'),
                        Some(b'0') => bytes.push(0),
                        Some(c) => bytes.push(c),
                        None => break,
                    }
                } else {
                    bytes.push(b);
                }
            }
            if tok != ".ascii" {
                bytes.push(0);
            }
            Ok(AsmSectionItem::Bytes(bytes))
        }
        ".globl" | ".global" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            Ok(AsmSectionItem::Global(alloc::string::String::from(name)))
        }
        ".type" => parse_type_directive(rest),
        ".size" => parse_size_directive(rest),
        // A non-directive token inside an executable section is a replacement
        // instruction (`.pushsection .altinstr_replacement,"ax"`). Keep it as
        // text; the arch backend encodes it to bytes and relocations. A data
        // section rejects code rather than drop it, which would leave the
        // `.altinstructions` entry pointing at absent bytes.
        _ if exec && !tok.starts_with('.') => {
            let line = if rest.is_empty() {
                alloc::string::String::from(tok)
            } else {
                alloc::format!("{tok} {rest}")
            };
            Ok(AsmSectionItem::Code(line))
        }
        _ => Err(alloc::format!(
            "inline asm: unsupported directive `{tok}` in a named section"
        )),
    }
}

/// `.type name, @function|@object`. GNU as also spells the type with a
/// leading `%` on some targets and accepts a bare word; only `function`
/// and `object` occur in inline asm, any other is rejected.
fn parse_type_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let (name, ty) = rest
        .split_once(',')
        .ok_or_else(|| alloc::format!("inline asm: `.type` expects `name, @type`, got `{rest}`"))?;
    let name = name.trim();
    if !is_asm_symbol_name(name) {
        return Err(alloc::format!("inline asm: bad `.type` symbol `{name}`"));
    }
    let ty = ty.trim();
    let sym_type = match ty.strip_prefix(['@', '%']).unwrap_or(ty) {
        "function" => AsmSymType::Func,
        "object" => AsmSymType::Object,
        _ => return Err(alloc::format!("inline asm: unsupported `.type` `{ty}`")),
    };
    Ok(AsmSectionItem::Type {
        name: alloc::string::String::from(name),
        sym_type,
    })
}

/// `.size name, expr`. The expression is a byte count evaluated at
/// materialize time; parsing keeps it as text since label offsets are not
/// yet known.
fn parse_size_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let (name, expr) = rest
        .split_once(',')
        .ok_or_else(|| alloc::format!("inline asm: `.size` expects `name, expr`, got `{rest}`"))?;
    let name = name.trim();
    let expr = expr.trim();
    if !is_asm_symbol_name(name) {
        return Err(alloc::format!("inline asm: bad `.size` symbol `{name}`"));
    }
    if expr.is_empty() {
        return Err(alloc::string::String::from(
            "inline asm: empty `.size` expression",
        ));
    }
    Ok(AsmSectionItem::Size {
        name: alloc::string::String::from(name),
        expr: alloc::string::String::from(expr),
    })
}

/// If `s` is a single parenthesised group (the leading `(` matches the
/// trailing `)`), return its interior; otherwise `None`.
fn enclosed_by_parens(s: &str) -> Option<&str> {
    let b = s.as_bytes();
    if b.first() != Some(&b'(') || b.last() != Some(&b')') {
        return None;
    }
    let mut depth = 0u32;
    for (i, &c) in b.iter().enumerate() {
        match c {
            b'(' => depth += 1,
            b')' => depth = depth.checked_sub(1)?,
            _ => {}
        }
        if depth == 0 && i + 1 < b.len() {
            return None; // the leading paren closed before the end
        }
    }
    (depth == 0).then(|| s[1..s.len() - 1].trim())
}

/// Strip fully-enclosing parentheses from a label operand. `_ASM_EXTABLE`
/// wraps its label in parentheses (`.long (1b) - .`); the parentheses are
/// grouping, so `(1b)` names the same label as `1b`.
fn strip_label_parens(s: &str) -> &str {
    let mut s = s.trim();
    while let Some(inner) = enclosed_by_parens(s) {
        s = inner;
    }
    s
}

/// If `s` ends with `- .` (subtract the field's own position), return the
/// base expression before it; otherwise `None`.
fn strip_trailing_pcrel(s: &str) -> Option<&str> {
    let base = s
        .trim_end()
        .strip_suffix('.')?
        .trim_end()
        .strip_suffix('-')?;
    Some(base.trim_end())
}

/// Parse an operand / goto-label relocation value: a `%cN` operand address
/// or `%lN` goto label, with an optional `+ addend` constant expression and
/// `- .` PC-relative marker. Returns `None` when `a` is not such a form (a
/// bare `%cN` stays a constant operand handled by the caller).
fn parse_operand_reloc(a: &str) -> Option<Result<AsmSectionValue, alloc::string::String>> {
    let rest = a.strip_prefix('%')?;
    let (goto, rest) = if let Some(r) = rest.strip_prefix('l') {
        (true, r)
    } else {
        // `%c` / `%P` name an operand address; anything else is not this form.
        (
            false,
            rest.strip_prefix('c').or_else(|| rest.strip_prefix('P'))?,
        )
    };
    let end = rest
        .bytes()
        .position(|c| !c.is_ascii_digit())
        .unwrap_or(rest.len());
    let idx: u8 = rest.get(..end)?.parse().ok()?;
    let (tail, pcrel) = match strip_trailing_pcrel(rest[end..].trim()) {
        Some(base) => (base, true),
        None => (rest[end..].trim(), false),
    };
    // A `%l` goto label always relocates; a `%c` operand only when it is
    // PC-relative or carries an addend (a bare `%cN` is a plain constant).
    let addend = match tail.strip_prefix('+') {
        Some(rest) => rest.trim(),
        None if tail.is_empty() => "",
        None => return None,
    };
    if !goto && !pcrel && addend.is_empty() {
        return None;
    }
    Some(Ok(AsmSectionValue::OperandReloc {
        idx,
        goto,
        addend: alloc::string::String::from(addend),
        pcrel,
    }))
}

/// Parse one data-directive value: a constant, an operand reference, or
/// a label / symbol reference (optionally `- .` PC-relative).
fn parse_section_value(a: &str) -> Result<AsmSectionValue, alloc::string::String> {
    if let Some(v) = parse_raw_int(a) {
        return Ok(AsmSectionValue::Const(v));
    }
    // A fully-enclosing parenthesis group is grouping only; strip it so
    // `((insn) - .)` (the aarch64 exception table) reduces like `(insn) - .`
    // and `(((x)))` like `x`. A group that closes before the end
    // (`(a) - (b)`, `(1 << 15) | (%0)`) is left for the handling below.
    let a = strip_label_parens(a);
    // `%c0 - .` / `%c0 + %c1 - .` / `%l0 - .`: a relocation to an operand's
    // link-time address or an `asm goto` label.
    if let Some(v) = parse_operand_reloc(a) {
        return v;
    }
    if let Some(rest) = a.strip_prefix('%') {
        let body = rest
            .strip_prefix('c')
            .or_else(|| rest.strip_prefix('P'))
            .unwrap_or(rest);
        if !body.is_empty() && body.bytes().all(|c| c.is_ascii_digit()) {
            let idx: u8 = body
                .parse()
                .map_err(|_| alloc::format!("inline asm: bad operand reference `{a}`"))?;
            return Ok(AsmSectionValue::OperandConst(idx));
        }
        return Err(alloc::format!("inline asm: bad section value `{a}`"));
    }
    // A constant expression mixing integer literals with `%N` operand
    // constants (`(1 << 15) | (%0)`); deferred as text and resolved at
    // materialize time. Label / symbol references are not constants and fall
    // through to the forms below.
    if a.contains('%') && eval_const_expr_ops(a, &|_| Some(0)).is_some() {
        return Ok(AsmSectionValue::Expr(alloc::string::String::from(a)));
    }
    // A relocatable expression: one symbolic base (a label or symbol) plus a
    // constant addend, optionally `- .` PC-relative; or `label_a - label_b`, a
    // constant distance.
    parse_reloc_expr(a)
}

/// Whether `s` has a `+` or `-` at parenthesis depth zero past its first byte:
/// a real additive split rather than a leading sign on a single leaf.
fn has_top_level_addsub(s: &str) -> bool {
    let mut depth = 0i32;
    for (i, &c) in s.as_bytes().iter().enumerate() {
        match c {
            b'(' => depth += 1,
            b')' => depth -= 1,
            b'+' | b'-' if depth == 0 && i > 0 => return true,
            _ => {}
        }
    }
    false
}

/// Append one additive term to `out`, distributing a `- ( ... )` sign into a
/// parenthesised sub-sum; a group wrapping a single leaf (`(1b)`) is unwrapped
/// and kept whole. Returns false on a malformed (empty) term.
fn push_reloc_term<'a>(
    term: &'a str,
    neg: bool,
    out: &mut alloc::vec::Vec<(bool, &'a str)>,
) -> bool {
    let t = term.trim();
    if t.is_empty() {
        return false;
    }
    if let Some(inner) = enclosed_by_parens(t)
        && has_top_level_addsub(inner)
    {
        return flatten_addsub_terms(inner, neg, out);
    }
    out.push((neg, strip_label_parens(t)));
    true
}

/// Flatten `s` into its additive terms, each tagged with whether it is
/// subtracted from the whole value. `outer_neg` is the sign inherited from an
/// enclosing `- ( ... )`. Returns false on unbalanced parentheses.
fn flatten_addsub_terms<'a>(
    s: &'a str,
    outer_neg: bool,
    out: &mut alloc::vec::Vec<(bool, &'a str)>,
) -> bool {
    let b = s.as_bytes();
    let mut i = 0usize;
    while i < b.len() && b[i].is_ascii_whitespace() {
        i += 1;
    }
    let mut neg = outer_neg ^ (b.get(i) == Some(&b'-'));
    if matches!(b.get(i), Some(b'+' | b'-')) {
        i += 1;
    }
    let (mut depth, mut start) = (0i32, i);
    while i < b.len() {
        match b[i] {
            b'(' => depth += 1,
            b')' => {
                depth -= 1;
                if depth < 0 {
                    return false;
                }
            }
            b'+' | b'-' if depth == 0 => {
                if !push_reloc_term(&s[start..i], neg, out) {
                    return false;
                }
                neg = outer_neg ^ (b[i] == b'-');
                start = i + 1;
            }
            _ => {}
        }
        i += 1;
    }
    depth == 0 && push_reloc_term(&s[start..], neg, out)
}

/// Parse a section data value as a relocatable expression: a single symbolic
/// base (a label or symbol) plus a constant addend that folds literals and
/// `%cN` operand constants, optionally `- .` PC-relative. Two bare labels with
/// no addend are a constant distance ([`AsmSectionValue::LabelDiff`]).
fn parse_reloc_expr(a: &str) -> Result<AsmSectionValue, alloc::string::String> {
    let unsupported = || alloc::format!("inline asm: unsupported expression `{a}`");
    let mut terms = alloc::vec::Vec::new();
    if !flatten_addsub_terms(a, false, &mut terms) {
        return Err(unsupported());
    }
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let is_name = |s: &str| !s.is_empty() && s.bytes().all(ident);
    // A term is a constant when it evaluates with the operand resolver treated
    // as present; a label or symbol reference does not.
    let is_const = |t: &str| eval_const_expr_ops(t, &|_| Some(0)).is_some();
    let (mut base, mut neg_name) = (None, None);
    let (mut names, mut dots) = (0usize, 0usize);
    let mut addend = alloc::string::String::new();
    for &(neg, t) in &terms {
        if t == "." {
            dots += 1;
            if !neg {
                return Err(unsupported());
            }
        } else if is_const(t) {
            addend.push_str(if neg { " - " } else { " + " });
            addend.push_str(t);
        } else if is_name(t) {
            names += 1;
            if neg {
                neg_name = Some(t);
            } else {
                base = Some(t);
            }
        } else {
            return Err(alloc::format!("inline asm: bad section value `{t}`"));
        }
    }
    // `label_a - label_b`: a constant distance, no PC-relative term or addend.
    if names == 2
        && dots == 0
        && addend.is_empty()
        && let (Some(m), Some(s)) = (base, neg_name)
    {
        return Ok(AsmSectionValue::LabelDiff {
            minuend: alloc::string::String::from(m),
            subtrahend: alloc::string::String::from(s),
        });
    }
    // A single relocation base with a folded constant addend. `- .` marks it
    // PC-relative; the addend is prefixed with `0` so its leading sign parses.
    match base {
        Some(name) if names == 1 && dots <= 1 => Ok(AsmSectionValue::Ref {
            name: alloc::string::String::from(name),
            pcrel: dots == 1,
            addend: if addend.is_empty() {
                addend
            } else {
                alloc::format!("0{addend}")
            },
        }),
        _ => Err(unsupported()),
    }
}

/// Whether a signed constant fits a data-directive field of `width` bytes,
/// accepting either a signed or an unsigned reading (`-128..=255` for a byte,
/// and so on). An 8-byte field holds any `i64`.
fn value_fits_width(v: i64, width: u8) -> bool {
    let bits = width as u32 * 8;
    if bits >= 64 {
        return true;
    }
    let signed_min = -(1i64 << (bits - 1));
    let unsigned_max = (1i64 << bits) - 1;
    (signed_min..=unsigned_max).contains(&v)
}

/// Resolve an `i`-class operand's SSA value to a section field's relocation
/// target (`.long %c0 - .`) plus a base addend folded from a constant pointer
/// offset (`&key + branch`, the arm64 static branch). Returns `(target,
/// addend)`.
///
/// A local `.data` / `.bss` address (`Inst::ImmData` whose value-id names no
/// external symbol) relocates against the section symbol with the offset in
/// the target and a zero base addend. A cross-TU address (the same `ImmData`
/// whose value-id appears in `extern_imm_data_refs`, so `extern_name` yields
/// its symbol) relocates against that symbol, with any constant offset folded
/// into the addend the writer applies to the symbol -- a `.data + off`
/// relocation would name this unit's data image, not the referenced symbol.
pub(crate) fn asm_operand_data_target(
    insts: &[crate::c5::ir::Inst],
    arg: u32,
    extern_name: &dyn Fn(u32) -> Option<alloc::string::String>,
) -> Option<(AsmSectionTarget, i64)> {
    use crate::c5::ir::{BinOp, Inst};
    let target = |data_vid: u32, off: i64| -> (AsmSectionTarget, i64) {
        match extern_name(data_vid) {
            Some(name) => (AsmSectionTarget::Symbol(name), off),
            None => (AsmSectionTarget::Data(off as u64), 0),
        }
    };
    match insts.get(arg as usize)? {
        Inst::ImmData(off) => Some(target(arg, *off)),
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        } => match insts.get(*lhs as usize) {
            Some(Inst::ImmData(off)) => Some(target(*lhs, *off + *rhs_imm)),
            _ => None,
        },
        Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        } => match (insts.get(*lhs as usize), insts.get(*rhs as usize)) {
            (Some(Inst::ImmData(off)), Some(Inst::Imm(c))) => Some(target(*lhs, *off + *c)),
            (Some(Inst::Imm(c)), Some(Inst::ImmData(off))) => Some(target(*rhs, *off + *c)),
            _ => None,
        },
        _ => None,
    }
}

/// Section-relative offsets of the labels one materialize call defines.
/// A same-section label difference (`775f - 774f`, an alternatives
/// replacement length) folds to a constant from these even when the field
/// referencing it sits in another section, and the main stream's `.skip`
/// padding sizes itself from them. Offsets are measured from zero per call:
/// only differences within one section are asked of the map, so a section's
/// pre-existing sink length cancels.
pub(crate) struct SectionLabelOffsets {
    map: alloc::collections::BTreeMap<alloc::string::String, (alloc::string::String, i64)>,
}

impl SectionLabelOffsets {
    /// The section-relative offset of a label reference (`774f` / a name),
    /// or `None` when the name is not a label this call defines.
    pub(crate) fn offset(&self, name: &str) -> Option<i64> {
        self.map
            .get(numeric_label_digits(name).unwrap_or(name))
            .map(|(_, off)| *off)
    }
    /// The section key a label reference is defined in; two labels fold to a
    /// constant difference only when this agrees.
    pub(crate) fn section(&self, name: &str) -> Option<&str> {
        self.map
            .get(numeric_label_digits(name).unwrap_or(name))
            .map(|(s, _)| s.as_str())
    }
}

/// Measure the section-relative offset of every label the blocks define,
/// before the field values (or the main stream) are laid out. Each item's
/// byte length is structural -- data width times count, string length,
/// alignment / `.org` padding -- so a forward label difference and the
/// `.skip` replacement padding resolve without the values.
pub(crate) fn measure_asm_section_offsets(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
) -> Result<SectionLabelOffsets, alloc::string::String> {
    let mut map: alloc::collections::BTreeMap<alloc::string::String, (alloc::string::String, i64)> =
        alloc::collections::BTreeMap::new();
    let mut lens: alloc::collections::BTreeMap<alloc::string::String, i64> =
        alloc::collections::BTreeMap::new();
    for b in blocks {
        let key = alloc::format!("{}\u{0}{}\u{0}{:?}", b.name, b.flags, b.sh_type);
        let mut at = *lens.get(&key).unwrap_or(&0);
        for item in &b.items {
            match item {
                AsmSectionItem::Label(name) => {
                    let digits = numeric_label_digits(name).unwrap_or(name);
                    map.insert(alloc::string::String::from(digits), (key.clone(), at));
                }
                // Symbol attributes, not layout: no bytes.
                AsmSectionItem::Global(_)
                | AsmSectionItem::Type { .. }
                | AsmSectionItem::Size { .. } => {}
                AsmSectionItem::Data { width, values } => {
                    at += *width as i64 * values.len() as i64;
                }
                AsmSectionItem::Bytes(bs) => at += bs.len() as i64,
                AsmSectionItem::CodeBytes { bytes, .. } => at += bytes.len() as i64,
                AsmSectionItem::Code(text) => {
                    return Err(alloc::format!(
                        "inline asm: replacement instruction `{text}` in a named section is not \
                         assembled for this target"
                    ));
                }
                AsmSectionItem::Align(n) => {
                    let mask = *n as i64 - 1;
                    at = (at + mask) & !mask;
                }
                AsmSectionItem::AlignArch(n) => {
                    let bytes = if align_is_p2 {
                        1i64 << (*n).min(12)
                    } else {
                        *n as i64
                    };
                    let mask = bytes - 1;
                    at = (at + mask) & !mask;
                }
                AsmSectionItem::Org(n) => at = at.max(*n as i64),
                AsmSectionItem::OrgLabel { label, addend } => {
                    let digits = numeric_label_digits(label).unwrap_or(label);
                    let base = map
                        .get(digits)
                        .filter(|(sk, _)| *sk == key)
                        .map(|(_, o)| *o)
                        .ok_or_else(|| {
                            alloc::format!(
                                "inline asm: `.org` label `{label}` is not defined above"
                            )
                        })?;
                    let add = eval_const_expr_ops(addend, &|i| const_of(i)).ok_or_else(|| {
                        alloc::string::String::from("inline asm: non-constant `.org` addend")
                    })?;
                    at = (base + add).max(at);
                }
            }
        }
        lens.insert(key, at);
    }
    Ok(SectionLabelOffsets { map })
}

/// Materialize the parsed section blocks: resolve operand constants and
/// label references, lay out the bytes, and merge into the sink by
/// `(name, flags, sh_type)`. `const_of` yields an `i`-class operand's
/// constant; `label_off` resolves a template-label name to its location --
/// an emitted-stream text offset or a deferred replacement region
/// ([`LabelLoc`]); `None` means the name is a symbol. `operand_sym` yields
/// the relocation target of an `i`-class operand that names a link-time
/// address (`.long %c0 - .`) rather than a constant; `goto_block` yields
/// the block index of an `asm goto` label (`.long %l0 - .`).
pub(crate) fn materialize_asm_sections(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    label_off: &dyn Fn(&str) -> Option<LabelLoc>,
    operand_sym: &dyn Fn(u8) -> Option<(AsmSectionTarget, i64)>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
    align_is_p2: bool,
    sink: &mut alloc::vec::Vec<AsmSection>,
) -> Result<(), alloc::string::String> {
    // GNU as numeric labels (`2:`, `14470:`) are local to one asm instance;
    // the same digits recur across every expansion of a macro like the bug
    // table, so the accumulating sink would collide them. Rename each
    // definition to a per-instance-unique symbol. Built once for the whole
    // call so a reference in one block resolves a definition in another (the
    // bug table's `.long 14472b - .` reaches a label defined in `.rodata.str`).
    let uniq = ASM_INSTANCE.fetch_add(1, core::sync::atomic::Ordering::Relaxed);
    let mut num_unique: alloc::collections::BTreeMap<&str, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    for name in blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::Label(n) if is_numeric_label(n) => Some(n.as_str()),
            _ => None,
        })
    {
        if num_unique
            .insert(name, alloc::format!(".Lc5_asmsec_{uniq}_{name}"))
            .is_some()
        {
            return Err(alloc::format!(
                "inline asm: numeric label `{name}` defined twice in one asm instance"
            ));
        }
    }
    // Offsets of every section label, so a difference to a label defined in a
    // later block (the replacement length `775f - 774f`, whose field sits in
    // the earlier `.altinstructions`) folds to a constant.
    let measured = measure_asm_section_offsets(blocks, const_of, align_is_p2)?;
    for b in blocks {
        let sec = match sink
            .iter_mut()
            .find(|s| s.name == b.name && s.flags == b.flags && s.sh_type == b.sh_type)
        {
            Some(s) => s,
            None => {
                sink.push(AsmSection {
                    name: b.name.clone(),
                    flags: b.flags.clone(),
                    sh_type: b.sh_type.clone(),
                    bytes: alloc::vec::Vec::new(),
                    relocs: alloc::vec::Vec::new(),
                    labels: alloc::vec::Vec::new(),
                    align: 1,
                });
                sink.last_mut().unwrap()
            }
        };
        for item in &b.items {
            // `.align`'s argument is a byte count on x86 ELF, a
            // power-of-two exponent on AArch64 (GNU as convention).
            let resolved;
            let item = match item {
                AsmSectionItem::AlignArch(n) => {
                    let bytes = if align_is_p2 { 1u32 << n.min(&12) } else { *n };
                    if !bytes.is_power_of_two() {
                        return Err(alloc::string::String::from(
                            "inline asm: `.align` is not a power of two",
                        ));
                    }
                    resolved = AsmSectionItem::Align(bytes);
                    &resolved
                }
                other => other,
            };
            match item {
                AsmSectionItem::AlignArch(_) => unreachable!("resolved above"),
                AsmSectionItem::Align(n) => {
                    sec.align = sec.align.max(*n);
                    while sec.bytes.len() % *n as usize != 0 {
                        sec.bytes.push(0);
                    }
                }
                AsmSectionItem::OrgLabel { label, addend } => {
                    // Resolve the label's offset within this section (defined
                    // above), then pad to that plus the constant addend.
                    let lname = numeric_label_digits(label)
                        .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                        .unwrap_or(label);
                    let base = sec
                        .labels
                        .iter()
                        .find(|l| l.name == lname && l.offset != PENDING_LABEL)
                        .map(|l| l.offset)
                        .ok_or_else(|| {
                            alloc::format!(
                                "inline asm: `.org` label `{label}` is not defined above"
                            )
                        })?;
                    let add =
                        eval_const_expr_ops(addend, &|idx| const_of(idx)).ok_or_else(|| {
                            alloc::string::String::from("inline asm: non-constant `.org` addend")
                        })?;
                    let target = base as i64 + add;
                    if target < sec.bytes.len() as i64 {
                        return Err(alloc::string::String::from(
                            "inline asm: `.org` moves backwards",
                        ));
                    }
                    sec.bytes.resize(target as usize, 0);
                }
                AsmSectionItem::Org(n) => {
                    if (*n as usize) < sec.bytes.len() {
                        return Err(alloc::string::String::from(
                            "inline asm: `.org` moves backwards",
                        ));
                    }
                    sec.bytes.resize(*n as usize, 0);
                }
                AsmSectionItem::Bytes(bs) => sec.bytes.extend_from_slice(bs),
                AsmSectionItem::Label(name) => {
                    // A numeric label carries its per-instance-unique symbol.
                    let name = num_unique
                        .get(name.as_str())
                        .map(alloc::string::String::as_str)
                        .unwrap_or(name);
                    let at = sec.bytes.len() as u32;
                    match sec.labels.iter_mut().find(|l| l.name == *name) {
                        // A pending `.globl` entry is the definition site.
                        Some(l) if l.offset == PENDING_LABEL => l.offset = at,
                        Some(_) => {
                            return Err(alloc::format!(
                                "inline asm: duplicate label `{name}` in a named section"
                            ));
                        }
                        None => sec.labels.push(AsmSectionLabel {
                            name: alloc::string::String::from(name),
                            offset: at,
                            global: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                        }),
                    }
                }
                AsmSectionItem::Global(name) => {
                    match sec.labels.iter_mut().find(|l| l.name == *name) {
                        // `.globl` may precede its label; record the pending name
                        // as a zero-length forward entry the definition fills in.
                        Some(l) => l.global = true,
                        None => sec.labels.push(AsmSectionLabel {
                            name: name.clone(),
                            offset: PENDING_LABEL,
                            global: true,
                            sym_type: AsmSymType::NoType,
                            size: None,
                        }),
                    }
                }
                AsmSectionItem::Type { name, sym_type } => {
                    let lname = numeric_label_digits(name)
                        .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                        .unwrap_or(name);
                    let l = sec
                        .labels
                        .iter_mut()
                        .find(|l| l.name == *lname && l.offset != PENDING_LABEL)
                        .ok_or_else(|| {
                            alloc::format!("inline asm: `.type` names undefined label `{name}`")
                        })?;
                    l.sym_type = *sym_type;
                }
                AsmSectionItem::Size { name, expr } => {
                    // `.` is the offset at the directive; a term is that,
                    // a section label's offset, or a constant. `A - B`
                    // yields the byte distance the symbol spans.
                    let cur = sec.bytes.len() as i64;
                    let term = |t: &str| -> Option<i64> {
                        let t = t.trim();
                        if t == "." {
                            return Some(cur);
                        }
                        let ln = numeric_label_digits(t)
                            .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                            .unwrap_or(t);
                        if let Some(l) = sec
                            .labels
                            .iter()
                            .find(|l| l.name == ln && l.offset != PENDING_LABEL)
                        {
                            return Some(l.offset as i64);
                        }
                        eval_const_expr_ops(t, &|i| const_of(i))
                    };
                    let bad = || alloc::format!("inline asm: bad `.size` expression `{expr}`");
                    let val = match expr.split_once('-') {
                        Some((a, b)) => term(a).ok_or_else(bad)? - term(b).ok_or_else(bad)?,
                        None => term(expr).ok_or_else(bad)?,
                    };
                    if val < 0 {
                        return Err(alloc::format!(
                            "inline asm: `.size` expression `{expr}` is negative"
                        ));
                    }
                    let tname = numeric_label_digits(name)
                        .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                        .unwrap_or(name);
                    let l = sec
                        .labels
                        .iter_mut()
                        .find(|l| l.name == *tname && l.offset != PENDING_LABEL)
                        .ok_or_else(|| {
                            alloc::format!("inline asm: `.size` names undefined label `{name}`")
                        })?;
                    l.size = Some(val as u64);
                }
                AsmSectionItem::Data { width, values } => {
                    for v in values {
                        match v {
                            AsmSectionValue::Const(c) => sec
                                .bytes
                                .extend_from_slice(&(*c as u64).to_le_bytes()[..*width as usize]),
                            AsmSectionValue::OperandConst(idx) => {
                                let c = const_of(*idx).ok_or_else(|| {
                                    alloc::string::String::from(
                                        "inline asm: non-constant section data value",
                                    )
                                })?;
                                sec.bytes.extend_from_slice(
                                    &(c as u64).to_le_bytes()[..*width as usize],
                                );
                            }
                            AsmSectionValue::Expr(text) => {
                                let c = eval_const_expr_ops(text, &|idx| const_of(idx))
                                    .ok_or_else(|| {
                                        alloc::string::String::from(
                                            "inline asm: non-constant section data value",
                                        )
                                    })?;
                                sec.bytes.extend_from_slice(
                                    &(c as u64).to_le_bytes()[..*width as usize],
                                );
                            }
                            AsmSectionValue::Ref {
                                name,
                                pcrel,
                                addend,
                            } => {
                                if !matches!(width, 4 | 8) {
                                    return Err(alloc::string::String::from(
                                        "inline asm: section reference needs a 4- or 8-byte field",
                                    ));
                                }
                                // A template text label resolves to a text
                                // offset; a deferred-region label to a
                                // rewritten-after-placement target; a numeric
                                // section label to its per-instance-unique
                                // symbol; any other name is a plain symbol.
                                let target = match label_off(name) {
                                    Some(LabelLoc::Text(off)) => AsmSectionTarget::Text(off),
                                    Some(LabelLoc::Deferred { region, off }) => {
                                        AsmSectionTarget::DeferredText {
                                            region,
                                            off: off as u32,
                                        }
                                    }
                                    None => match numeric_label_digits(name)
                                        .and_then(|d| num_unique.get(d))
                                    {
                                        Some(uni) => AsmSectionTarget::Symbol(uni.clone()),
                                        None => AsmSectionTarget::Symbol(name.clone()),
                                    },
                                };
                                let add = if addend.is_empty() {
                                    0
                                } else {
                                    eval_const_expr_ops(addend, &|i| const_of(i)).ok_or_else(
                                        || {
                                            alloc::string::String::from(
                                                "inline asm: non-constant section reloc addend",
                                            )
                                        },
                                    )?
                                };
                                sec.relocs.push(AsmSectionReloc {
                                    offset: sec.bytes.len() as u32,
                                    width: *width,
                                    pcrel: *pcrel,
                                    branch: false,
                                    target,
                                    addend: add,
                                });
                                sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                            }
                            AsmSectionValue::LabelDiff {
                                minuend,
                                subtrahend,
                            } => {
                                // A label difference is a constant when both
                                // labels resolve and share a space: the
                                // emitted text stream, one deferred replacement
                                // region (`664f-663f`, the ALTERNATIVE
                                // replacement length), or a named section
                                // (`measured`). A cross-space difference is not
                                // a constant. The space tag distinguishes them.
                                let resolve = |n: &str| -> Result<
                                    (DiffSpace, i64),
                                    alloc::string::String,
                                > {
                                    match label_off(n) {
                                        Some(LabelLoc::Text(off)) => {
                                            return Ok((DiffSpace::Text, off as i64));
                                        }
                                        Some(LabelLoc::Deferred { region, off }) => {
                                            return Ok((DiffSpace::Deferred(region), off as i64));
                                        }
                                        None => {}
                                    }
                                    match (measured.section(n), measured.offset(n)) {
                                        (Some(s), Some(off)) => Ok((DiffSpace::Section(s), off)),
                                        _ => Err(alloc::format!(
                                            "inline asm: label difference needs defined labels, `{n}` is not one"
                                        )),
                                    }
                                };
                                let (ms, mo) = resolve(minuend)?;
                                let (ss, so) = resolve(subtrahend)?;
                                if ms != ss {
                                    return Err(alloc::format!(
                                        "inline asm: label difference `{minuend} - {subtrahend}` is not a constant (crosses sections)"
                                    ));
                                }
                                let diff = mo - so;
                                if !value_fits_width(diff, *width) {
                                    return Err(alloc::format!(
                                        "inline asm: label difference {diff} does not fit a {width}-byte field"
                                    ));
                                }
                                sec.bytes.extend_from_slice(
                                    &(diff as u64).to_le_bytes()[..*width as usize],
                                );
                            }
                            AsmSectionValue::OperandReloc {
                                idx,
                                goto,
                                addend,
                                pcrel,
                            } => {
                                if !matches!(width, 4 | 8) {
                                    return Err(alloc::string::String::from(
                                        "inline asm: section reference needs a 4- or 8-byte field",
                                    ));
                                }
                                let (target, base_add) = if *goto {
                                    let bid = goto_block(*idx).ok_or_else(|| {
                                        alloc::format!(
                                            "inline asm: `%l{idx}` names no `asm goto` label"
                                        )
                                    })?;
                                    (AsmSectionTarget::TextBlock(bid), 0)
                                } else {
                                    operand_sym(*idx).ok_or_else(|| {
                                        alloc::format!(
                                            "inline asm: operand `%c{idx}` does not name a link-time address"
                                        )
                                    })?
                                };
                                let add = base_add
                                    + if addend.is_empty() {
                                        0
                                    } else {
                                        eval_const_expr_ops(addend, &|i| const_of(i)).ok_or_else(
                                            || {
                                                alloc::string::String::from(
                                                    "inline asm: non-constant section reloc addend",
                                                )
                                            },
                                        )?
                                    };
                                sec.relocs.push(AsmSectionReloc {
                                    offset: sec.bytes.len() as u32,
                                    width: *width,
                                    pcrel: *pcrel,
                                    branch: false,
                                    target,
                                    addend: add,
                                });
                                sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                            }
                        }
                    }
                }
                AsmSectionItem::CodeBytes { bytes, relocs } => {
                    // A replacement instruction's relocs are at offsets within
                    // its own bytes; rebase each to the section offset the
                    // instruction lands at, then append the machine bytes.
                    let base = sec.bytes.len() as u32;
                    for r in relocs {
                        let mut r = r.clone();
                        r.offset += base;
                        sec.relocs.push(r);
                    }
                    sec.bytes.extend_from_slice(bytes);
                }
                AsmSectionItem::Code(text) => {
                    return Err(alloc::format!(
                        "inline asm: replacement instruction `{text}` in a named section is not \
                         assembled for this target"
                    ));
                }
            }
        }
    }
    // A `.globl` naming no label in the section declares an external symbol,
    // not a definition here; it defines no section symbol.
    for s in sink.iter_mut() {
        s.labels.retain(|l| l.offset != PENDING_LABEL);
    }
    Ok(())
}

/// Materialize a unit's file-scope `asm("...")` templates into `sink`.
/// The parse validated each template as section data directives only,
/// so there is no code stream: label references resolve as named-symbol
/// relocations and there are no operands.
pub(crate) fn materialize_file_asm(
    templates: &[alloc::string::String],
    align_is_p2: bool,
    comments: AsmComments,
    encode_code: &dyn Fn(&mut [AsmSectionBlock]) -> Result<(), alloc::string::String>,
    sink: &mut alloc::vec::Vec<AsmSection>,
) -> Result<(), alloc::string::String> {
    for text in templates {
        let stripped = strip_asm_comments(text, comments);
        let text = stripped.as_deref().unwrap_or(text);
        if let Some((_code, mut blocks)) = extract_asm_sections(text, align_is_p2)? {
            // Assemble the section's instructions to bytes before layout; the
            // file-scope path has no operand context to resolve against.
            encode_code(&mut blocks)?;
            materialize_asm_sections(
                &blocks,
                &|_| None,
                &|_| None,
                &|_| None,
                &|_| None,
                align_is_p2,
                sink,
            )?;
        }
    }
    Ok(())
}

/// How a target prints an `i`-class operand reference that appears inside a
/// branch-target symbol name. A reference only spells part of a name when it
/// prints as bare text; a `$`-prefixed form cannot.
pub(crate) struct AsmSymbolSubst {
    /// Modifier letters that print the operand bare. x86 accepts `%c` and
    /// `%P`; AArch64 accepts `%c`, and gives `%P` an unrelated meaning.
    pub(crate) bare_modifiers: &'static [u8],
    /// Whether an unmodified `%N` prints bare. It does on AArch64; x86 prints
    /// `$N`.
    pub(crate) plain_is_bare: bool,
}

pub(crate) const X64_SYMBOL_SUBST: AsmSymbolSubst = AsmSymbolSubst {
    bare_modifiers: b"cP",
    plain_is_bare: false,
};

pub(crate) const A64_SYMBOL_SUBST: AsmSymbolSubst = AsmSymbolSubst {
    bare_modifiers: b"c",
    plain_is_bare: true,
};

/// Split a `%`-reference at the start of `s` into `(modifier, index, rest)`.
/// A modifier is a single letter; the index is the digits that follow.
fn split_operand_ref(s: &str) -> Option<(Option<u8>, u8, &str)> {
    let b = s.as_bytes();
    let mut i = 0;
    let modifier = match b.first() {
        Some(&c) if c.is_ascii_alphabetic() => {
            i = 1;
            Some(c)
        }
        _ => None,
    };
    let start = i;
    while i < b.len() && b[i].is_ascii_digit() {
        i += 1;
    }
    if i == start {
        return None;
    }
    let idx: u8 = s[start..i].parse().ok()?;
    Some((modifier, idx, &s[i..]))
}

/// True when `s` can spell a branch-target symbol name: an identifier body
/// that may embed operand references (`__get_user_%c0`). The leading
/// identifier character keeps a whole-operand target (`*%rax`, `%c0`) out.
/// Whether each reference is substitutable is settled at emit time, once the
/// operands' constants are known.
pub(crate) fn is_asm_symbol_template(s: &str) -> bool {
    if !s
        .bytes()
        .next()
        .is_some_and(|c| c.is_ascii_alphabetic() || c == b'_')
    {
        return false;
    }
    let mut rest = s;
    while let Some(p) = rest.find('%') {
        if !rest[..p]
            .bytes()
            .all(|c| c.is_ascii_alphanumeric() || c == b'_')
        {
            return false;
        }
        match split_operand_ref(&rest[p + 1..]) {
            Some((_, _, tail)) => rest = tail,
            None => return false,
        }
    }
    rest.bytes().all(|c| c.is_ascii_alphanumeric() || c == b'_')
}

/// Substitute the operand references in a branch-target symbol name, so the
/// target is resolved from the text the template spells after substitution.
/// `const_of` yields an `i`-class operand's constant.
pub(crate) fn resolve_asm_symbol_target(
    template: &str,
    subst: &AsmSymbolSubst,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<alloc::string::String, alloc::string::String> {
    let mut out = alloc::string::String::with_capacity(template.len());
    let mut rest = template;
    while let Some(p) = rest.find('%') {
        out.push_str(&rest[..p]);
        let Some((modifier, idx, tail)) = split_operand_ref(&rest[p + 1..]) else {
            return Err(alloc::format!(
                "inline asm: bad operand reference in branch target `{template}`"
            ));
        };
        match modifier {
            Some(m) if subst.bare_modifiers.contains(&m) => {}
            None if subst.plain_is_bare => {}
            _ => {
                return Err(alloc::format!(
                    "inline asm: operand reference in branch target `{template}` \
                     does not print a bare symbol name; use `%c`"
                ));
            }
        }
        let Some(v) = const_of(idx) else {
            return Err(alloc::format!(
                "inline asm: branch target `{template}` needs a constant operand"
            ));
        };
        out.push_str(&alloc::format!("{v}"));
        rest = tail;
    }
    out.push_str(rest);
    Ok(out)
}

/// Assembler comment syntax of a target.
///
/// Both targets accept `/* */` block comments anywhere, keep `;` and newline
/// as statement separators, and never strip inside a string literal. They
/// differ in the line-comment characters:
///
/// * x86-64: `#` starts a comment anywhere in a line. GNU as rejects `//` as
///   junk after an operand, so no valid template relies on it and treating it
///   as a comment matches the clang integrated assembler.
/// * aarch64: `//` starts a comment anywhere. `#` prefixes an immediate
///   (`mov x0, #1`) and starts a comment only as the first token of a
///   statement, which is where the `#`-prefixed line markers appear.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(crate) enum AsmComments {
    X86,
    A64,
}

/// Strip assembler comments from an inline-asm template. A block comment
/// becomes one space so the tokens around it stay separate; a line comment
/// runs to the newline, which is kept because it separates statements.
/// Returns `None` when the template has no comment character.
///
/// Comments go before statement splitting: a line comment swallows any `;`
/// after it, and a `;` or newline inside a block comment does not separate
/// statements.
pub(crate) fn strip_asm_comments(text: &str, syntax: AsmComments) -> Option<alloc::string::String> {
    if !text.contains("/*") && !text.contains("//") && !text.contains('#') {
        return None;
    }
    let b = text.as_bytes();
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut i = 0;
    // A statement starts at the template start and after every separator;
    // leading whitespace and label definitions do not end it, matching GNU
    // as, which comments `1: # text` but rejects `.balign 4 # text`.
    let mut at_stmt_start = true;
    // Everything seen since the statement start is label text or whitespace,
    // so a `:` here closes a label definition rather than ending the start.
    let mut in_label_prefix = true;
    while i < b.len() {
        let c = b[i];
        if c == b'"' {
            let start = i;
            i += 1;
            while i < b.len() && b[i] != b'"' {
                i += if b[i] == b'\\' { 2 } else { 1 };
            }
            i = b.len().min(i + 1);
            out.push_str(&text[start..i]);
            at_stmt_start = false;
            in_label_prefix = false;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'*') {
            // An unterminated block comment runs to the end of the template.
            i = text[i + 2..].find("*/").map_or(b.len(), |p| i + 2 + p + 2);
            out.push(' ');
            continue;
        }
        let line_comment = (c == b'/' && b.get(i + 1) == Some(&b'/'))
            || (c == b'#' && (syntax == AsmComments::X86 || at_stmt_start));
        if line_comment {
            while i < b.len() && b[i] != b'\n' {
                i += 1;
            }
            continue;
        }
        if c == b'\n' || c == b';' {
            at_stmt_start = true;
            in_label_prefix = true;
        } else if c == b':' && in_label_prefix {
            at_stmt_start = true;
        } else if !c.is_ascii_whitespace() {
            at_stmt_start = false;
            in_label_prefix &= c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
        }
        out.push(char::from(c));
        i += 1;
    }
    Some(out)
}

/// Per-process counter behind the `%=` template escape.
static ASM_INSTANCE: core::sync::atomic::AtomicU32 = core::sync::atomic::AtomicU32::new(0);

/// Expand the `%=` template escape: every occurrence in one template gets the
/// same number, unique per expansion (GCC gives each asm instance its own).
/// `%%` is the literal-percent escape, so its trailing `%` never starts a
/// `%=`. Returns `None` when the template has no `%=` (the common case).
pub(crate) fn expand_template_uniq(text: &str) -> Option<alloc::string::String> {
    if !text.contains("%=") {
        return None;
    }
    let uniq = ASM_INSTANCE.fetch_add(1, core::sync::atomic::Ordering::Relaxed);
    let mut out = alloc::string::String::with_capacity(text.len() + 8);
    let mut it = text.chars().peekable();
    while let Some(c) = it.next() {
        if c != '%' {
            out.push(c);
            continue;
        }
        match it.peek() {
            Some('%') => {
                out.push_str("%%");
                it.next();
            }
            Some('=') => {
                out.push_str(&alloc::format!("{uniq}"));
                it.next();
            }
            _ => out.push('%'),
        }
    }
    Some(out)
}

/// Parse an inline-asm template whose every piece is raw machine bytes,
/// returning the concatenated little-endian bytes, or `None` when any piece is
/// a mnemonic the caller must encode itself. A piece is raw bytes when it is a
/// run of 2-hex-digit tokens (`CC C3 90`) or a `.byte` / `.word` / `.long` /
/// `.quad` directive of integer constants. Arch-neutral so both backends emit
/// raw-byte asm identically.
pub(crate) fn parse_raw_template(template: &[u8]) -> Option<alloc::vec::Vec<u8>> {
    let text = core::str::from_utf8(template).ok()?;
    let mut out = alloc::vec::Vec::new();
    let mut any = false;
    for piece in text.split([';', '\n']) {
        let piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        any = true;
        out.extend_from_slice(&parse_raw_piece(piece)?);
    }
    any.then_some(out)
}

/// Element width of a `.byte`-family data directive keyword, or `None`.
pub(crate) fn data_directive_width(tok: &str) -> Option<usize> {
    Some(match tok {
        ".byte" => 1,
        ".word" | ".2byte" | ".short" | ".hword" => 2,
        ".long" | ".4byte" | ".int" => 4,
        ".quad" | ".8byte" => 8,
        _ => return None,
    })
}

fn parse_raw_piece(piece: &str) -> Option<alloc::vec::Vec<u8>> {
    let width = data_directive_width(piece.split_whitespace().next()?);
    if let Some(w) = width {
        let args = piece[piece.find(char::is_whitespace)?..].trim();
        let mut out = alloc::vec::Vec::new();
        for a in args.split(',') {
            out.extend_from_slice(&(parse_raw_int(a.trim())? as u64).to_le_bytes()[..w]);
        }
        return Some(out);
    }
    // Bare hex-byte run: every whitespace-delimited token is exactly two hex
    // digits, so a mnemonic (letters) is never mistaken for one.
    let toks: alloc::vec::Vec<&str> = piece.split_whitespace().collect();
    (!toks.is_empty()
        && toks
            .iter()
            .all(|t| t.len() == 2 && t.bytes().all(|b| b.is_ascii_hexdigit())))
    .then(|| {
        toks.iter()
            .map(|t| u8::from_str_radix(t, 16).unwrap())
            .collect()
    })
}

fn parse_raw_int(s: &str) -> Option<i64> {
    eval_const_expr(s)
}

/// Evaluate an assembler integer constant expression: decimal / hex literals
/// combined with the C operators an assembler accepts, and parentheses.
/// Returns `None` when the text is not a self-contained constant, which is
/// how a label or symbol reference is distinguished from an expression.
pub(crate) fn eval_const_expr(s: &str) -> Option<i64> {
    eval_const_expr_ops(s, &|_| None)
}

/// Evaluate a constant expression whose leaves may include `%N` / `%cN` /
/// `%PN` operand references, resolved through `op` (an operand's compile-time
/// constant). With `op` yielding `None` this is the literal-only evaluator
/// above; a section value defers `op` to materialize time, where the operand
/// constants are known.
pub(crate) fn eval_const_expr_ops(s: &str, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let b = s.as_bytes();
    let mut i = 0usize;
    let v = const_bitor(b, &mut i, op)?;
    skip_ws(b, &mut i);
    (i == b.len()).then_some(v)
}

/// Evaluate an assembler `.if` condition: a constant expression that may
/// compare with the relational operators (`==`, `!=`, `<`, `>`, `<=`, `>=`),
/// which bind looser than the arithmetic operators (GNU as convention). A
/// non-zero result is true. `None` when the condition is not a constant.
pub(crate) fn eval_asm_if_condition(s: &str) -> Option<i64> {
    let b = s.as_bytes();
    let mut i = 0usize;
    let v = const_relational(b, &mut i, &|_| None)?;
    skip_ws(b, &mut i);
    (i == b.len()).then_some(v)
}

/// Evaluate a GNU as constant expression whose leaves may be label
/// references, resolved through `resolve` (a label name to its value). The
/// alternatives `.skip` count mixes template-label and section-label
/// differences (`-(((775f-774f)-(772b-771b)) > 0) * (...)`). Each identifier
/// the resolver knows is substituted with its value; a numeric literal is
/// left for the evaluator. `None` when a leaf is unresolved or the result is
/// not a constant.
pub(crate) fn eval_asm_expr_with_labels(
    expr: &str,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> Option<i64> {
    eval_asm_if_condition(&subst_asm_idents(expr, resolve))
}

/// Substitute each identifier `resolve` knows with its value, leaving other
/// tokens -- numeric literals, unknown symbols, the location counter `.` --
/// as written. Identifier characters are the assembler's: alphanumeric plus
/// `_` / `.` / `$`.
pub(crate) fn subst_asm_idents(
    text: &str,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> alloc::string::String {
    let b = text.as_bytes();
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut i = 0;
    while i < b.len() {
        if ident(b[i]) {
            let start = i;
            while i < b.len() && ident(b[i]) {
                i += 1;
            }
            let tok = &text[start..i];
            match resolve(tok) {
                Some(v) => out.push_str(&alloc::format!("{v}")),
                None => out.push_str(tok),
            }
        } else {
            out.push(b[i] as char);
            i += 1;
        }
    }
    out
}

fn const_relational(b: &[u8], i: &mut usize, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let mut v = const_bitor(b, i, op)?;
    loop {
        skip_ws(b, i);
        let (rel, len): (fn(i64, i64) -> bool, usize) = match (b.get(*i), b.get(*i + 1)) {
            (Some(b'='), Some(b'=')) => (|a, c| a == c, 2),
            (Some(b'!'), Some(b'=')) => (|a, c| a != c, 2),
            (Some(b'<'), Some(b'=')) => (|a, c| a <= c, 2),
            (Some(b'>'), Some(b'=')) => (|a, c| a >= c, 2),
            (Some(b'<'), n) if n != Some(&b'<') => (|a, c| a < c, 1),
            (Some(b'>'), n) if n != Some(&b'>') => (|a, c| a > c, 1),
            _ => return Some(v),
        };
        *i += len;
        let rhs = const_bitor(b, i, op)?;
        // GNU as yields -1 (all bits set) for a true comparison, 0 for false;
        // the alternatives `.skip` padding `-((rlen-slen) > 0) * (rlen-slen)`
        // relies on the -1 to recover a positive count.
        v = if rel(v, rhs) { -1 } else { 0 };
    }
}

fn skip_ws(b: &[u8], i: &mut usize) {
    while *i < b.len() && b[*i].is_ascii_whitespace() {
        *i += 1;
    }
}

/// `|` is the loosest binding operator modelled; each level below consumes
/// its tighter operand first, giving C's precedence.
fn const_bitor(b: &[u8], i: &mut usize, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let mut v = const_bitxor(b, i, op)?;
    loop {
        skip_ws(b, i);
        // `||` is not an assembler expression operator; only a single `|`.
        if *i < b.len() && b[*i] == b'|' && b.get(*i + 1) != Some(&b'|') {
            *i += 1;
            v |= const_bitxor(b, i, op)?;
        } else {
            return Some(v);
        }
    }
}

fn const_bitxor(b: &[u8], i: &mut usize, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let mut v = const_bitand(b, i, op)?;
    loop {
        skip_ws(b, i);
        if *i < b.len() && b[*i] == b'^' {
            *i += 1;
            v ^= const_bitand(b, i, op)?;
        } else {
            return Some(v);
        }
    }
}

fn const_bitand(b: &[u8], i: &mut usize, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let mut v = const_shift(b, i, op)?;
    loop {
        skip_ws(b, i);
        if *i < b.len() && b[*i] == b'&' && b.get(*i + 1) != Some(&b'&') {
            *i += 1;
            v &= const_shift(b, i, op)?;
        } else {
            return Some(v);
        }
    }
}

fn const_shift(b: &[u8], i: &mut usize, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let mut v = const_add(b, i, op)?;
    loop {
        skip_ws(b, i);
        let sh = match (b.get(*i), b.get(*i + 1)) {
            (Some(b'<'), Some(b'<')) => b'<',
            (Some(b'>'), Some(b'>')) => b'>',
            _ => return Some(v),
        };
        *i += 2;
        let rhs = const_add(b, i, op)?;
        // A shift count outside the width is not a constant this evaluator
        // will invent a value for.
        if !(0..64).contains(&rhs) {
            return None;
        }
        v = if sh == b'<' { v << rhs } else { v >> rhs };
    }
}

fn const_add(b: &[u8], i: &mut usize, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let mut v = const_mul(b, i, op)?;
    loop {
        skip_ws(b, i);
        let add = match b.get(*i) {
            Some(&c @ (b'+' | b'-')) => c,
            _ => return Some(v),
        };
        *i += 1;
        let rhs = const_mul(b, i, op)?;
        v = if add == b'+' {
            v.checked_add(rhs)?
        } else {
            v.checked_sub(rhs)?
        };
    }
}

fn const_mul(b: &[u8], i: &mut usize, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let mut v = const_unary(b, i, op)?;
    loop {
        skip_ws(b, i);
        let mul = match b.get(*i) {
            Some(&c @ (b'*' | b'/' | b'%')) => c,
            _ => return Some(v),
        };
        *i += 1;
        let rhs = const_unary(b, i, op)?;
        v = match mul {
            b'*' => v.checked_mul(rhs)?,
            _ if rhs == 0 => return None,
            b'/' => v.checked_div(rhs)?,
            _ => v.checked_rem(rhs)?,
        };
    }
}

fn const_unary(b: &[u8], i: &mut usize, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    skip_ws(b, i);
    match b.get(*i) {
        Some(b'-') => {
            *i += 1;
            const_unary(b, i, op)?.checked_neg()
        }
        Some(b'+') => {
            *i += 1;
            const_unary(b, i, op)
        }
        Some(b'~') => {
            *i += 1;
            Some(!const_unary(b, i, op)?)
        }
        Some(b'(') => {
            *i += 1;
            // A parenthesised group may itself compare (`((rlen-slen) > 0)` in
            // the alternatives `.skip`), so parse the full expression grammar,
            // relational included, not just the arithmetic below it.
            let v = const_relational(b, i, op)?;
            skip_ws(b, i);
            (b.get(*i) == Some(&b')')).then(|| {
                *i += 1;
                v
            })
        }
        // `%N` / `%cN` / `%PN`: an operand's compile-time constant, resolved
        // by the caller. A bare `%` or a non-operand form is not a constant.
        Some(b'%') => {
            *i += 1;
            if matches!(b.get(*i), Some(b'c' | b'P')) {
                *i += 1;
            }
            let start = *i;
            while *i < b.len() && b[*i].is_ascii_digit() {
                *i += 1;
            }
            let idx: u8 = core::str::from_utf8(&b[start..*i]).ok()?.parse().ok()?;
            op(idx)
        }
        _ => const_literal(b, i),
    }
}

fn const_literal(b: &[u8], i: &mut usize) -> Option<i64> {
    skip_ws(b, i);
    let start = *i;
    let (radix, digits_at) = if b[*i..].starts_with(b"0x") || b[*i..].starts_with(b"0X") {
        (16, start + 2)
    } else {
        (10, start)
    };
    let mut j = digits_at;
    while j < b.len() && (b[j] as char).is_digit(radix) {
        j += 1;
    }
    if j == digits_at {
        return None;
    }
    let text = core::str::from_utf8(&b[digits_at..j]).ok()?;
    let v = i64::from_str_radix(text, radix).ok()?;
    *i = j;
    Some(v)
}

/// Translate a c5-stack slot index (the operand of an
/// address-of-local emit) into a byte offset relative to fp /
/// rbp. Locals (`off < 0`) sit at `off * 8`; parameters
/// (`off >= 2`) sit at `16 + (off - 2) * param_stride`.
///
/// The first parameter cell starts at a fixed 16-byte offset above
/// fp / rbp: on x86_64 the saved rbp and the return address occupy
/// `[rbp + 0]` and `[rbp + 8]`; on aarch64 the saved fp/lr pair
/// occupies `[fp + 0]` and `[fp + 8]`. The prologue places the
/// parameter cells just above that pair, so parameter slot `off`
/// (the first parameter is `off == 2`) lands `(off - 2)` strides
/// past the base.
///
/// `param_stride` is the per-function parameter-cell stride the
/// prologue allocated -- 16, the c5 cdecl cell width that `va_arg`
/// also walks. Splitting it out of the offset separates the fixed
/// saved-register base from the cell width, so a later phase can
/// shrink non-variadic cells without re-deriving the base. The
/// prologue's cell allocation and this offset must use the same
/// stride; passing `Frame::param_cell_stride` keeps them in
/// agreement. At stride 16 the result equals `(off - 1) * 16`.
pub(crate) fn c5_slot_to_fp_offset(off: i64, param_stride: i64) -> i64 {
    if off >= 2 {
        16 + (off - 2) * param_stride
    } else {
        off * 8
    }
}

/// SP-relative byte offset of an allocator spill slot. The
/// caller passes the frame's `frame_bytes` and `alloc_spill_base`
/// because the Frame struct shape differs slightly between
/// backends (aarch64 carries extra saved-FPR / saved-x19 fields).
/// Slot 0 sits 8 bytes below `alloc_spill_base`; slot N sits a
/// further `N * 8` bytes down. The fp + sp relationship
/// `sp = fp - frame_bytes` then yields the SP-relative offset.
pub(crate) fn spill_slot_sp_offset(frame_bytes: u32, alloc_spill_base: u32, slot: u32) -> u32 {
    frame_bytes - alloc_spill_base - (slot + 1) * 8
}

/// True when the body allocates stack at runtime (`alloca` or a C99
/// 6.7.6.2 VLA): the walker emits a non-zero `AllocaInit` slot for such
/// functions. The per-arch emits then address spill slots through the
/// frame pointer, since sp moves at the allocation sites, and their
/// epilogues re-establish sp from the frame pointer.
pub(crate) fn uses_dynamic_alloca(func: &super::super::ir::FunctionSsa) -> bool {
    func.insts
        .iter()
        .any(|i| matches!(i, super::super::ir::Inst::AllocaInit(slot) if *slot != 0))
}

/// Record a `.debug_line` row for the instruction `v`. The
/// walker stamps each SSA inst with the source position of the
/// statement that produced it (`FunctionSsa::inst_src`); the
/// per-arch emit calls this once before lowering the inst so
/// the DWARF builder can map every byte of emitted code back to
/// a source line. Suppresses zero entries (insts the walker
/// didn't stamp, e.g. lift-produced functions) and adjacent
/// duplicates (consecutive insts that came from the same
/// statement compress into one row).
pub(crate) fn record_inst_src(
    func: &super::super::ir::FunctionSsa,
    v: super::super::ir::ValueId,
    code_len: usize,
    ssa_line_rows: &mut alloc::vec::Vec<(usize, u32, u32)>,
) {
    let idx = v as usize;
    let (line, file_idx) = func.inst_src.get(idx).copied().unwrap_or((0, 0));
    if line == 0 {
        return;
    }
    if let Some(&(last_pc, last_line, last_file)) = ssa_line_rows.last()
        && last_line == line
        && last_file == file_idx
        && last_pc == code_len
    {
        return;
    }
    if let Some(&(_, last_line, last_file)) = ssa_line_rows.last()
        && last_line == line
        && last_file == file_idx
    {
        return;
    }
    ssa_line_rows.push((code_len, line, file_idx));
}

/// Record the byte offset of the first post-prologue instruction,
/// keyed by the function's `ent_pc`. The DWARF CFI pass reads this
/// to encode `DW_CFA_advance_loc <prologue bytes>` so the post-
/// prologue CFA / saved-reg rule installs at the right PC. Keyed by
/// `ent_pc` (unique per function) so a neighbouring function's PC
/// can't alias the entry, which a derived `pc_to_native` slot
/// allowed for adjacent small functions.
pub(crate) fn record_post_prologue_pc(
    func: &super::super::ir::FunctionSsa,
    prologue_native: &mut alloc::collections::BTreeMap<usize, usize>,
    code_len: usize,
) {
    prologue_native.insert(func.ent_pc, code_len);
}

/// True when an SSA inst can be skipped entirely because its
/// result has no consumers and the inst itself has no side effects.
/// Per-arch emit dispatch checks this before invoking `emit_inst`;
/// dead pure values produce no machine code. Side-effectful insts
/// (stores, calls, intrinsics, alloca init, vstack spills) are
/// always emitted regardless of use count.
pub(crate) fn is_dead_pure(
    inst: &super::super::ir::Inst,
    v: super::super::ir::ValueId,
    alloc: &super::reg_alloc::Allocation,
) -> bool {
    use super::super::ir::Inst::*;
    // A volatile load is never pure: the access itself is the side
    // effect (C99 5.1.2.3p2 / 6.7.3p6), so it is emitted even with no
    // consumers, at every optimization level.
    let pure = matches!(
        inst,
        Imm(_)
            | ImmData(_)
            | ImmCode(_)
            | LocalAddr(_)
            | TlsAddr(_)
            | Load {
                volatile: false,
                ..
            }
            | LoadLocal {
                volatile: false,
                ..
            }
            | LoadIndexed { .. }
            | Binop { .. }
            | BinopI { .. }
            | Fneg(_)
            | FpCast { .. }
            | Extend { .. }
    );
    if !pure {
        return false;
    }
    let idx = v as usize;
    alloc.use_counts.get(idx).copied().unwrap_or(0) == 0
}

/// Record the native byte offset of a block's first
/// instruction against its ent_pc. Skips the entry block
/// because the outer codegen walk already pinned the
/// function's entry PC to the prologue start; overwriting
/// it would redirect every `bl <function>` to land past the
/// prologue's setup.
pub(crate) fn record_block_start_pc(
    block_idx: usize,
    block_start_pc: usize,
    pc_to_native: &mut [usize],
    code_len: usize,
) {
    // Skip `block_start_pc == 0` to avoid clobbering the
    // function-entry slot (`pc_to_native[ent_pc]`)
    // written before this routine runs. The lift's inner
    // blocks always carry a non-zero ent_pc (the entry
    // block holds 0 but `block_idx > 0` filters it). The
    // walker leaves `start_pc` at 0 for every block because
    // its IR doesn't have ent_pcs at all -- without the
    // 0-guard, walker output would overwrite
    // `pc_to_native[0]` once per inner block and the
    // post-emit entry-offset resolution would land in the
    // middle (or end) of `main` instead of its prologue.
    if block_idx > 0 && block_start_pc != 0 && block_start_pc < pc_to_native.len() {
        pc_to_native[block_start_pc] = code_len;
    }
}

#[cfg(test)]
mod asm_comment_tests {
    use super::*;

    fn x86(t: &str) -> alloc::string::String {
        strip_asm_comments(t, AsmComments::X86).unwrap_or_else(|| t.into())
    }
    fn a64(t: &str) -> alloc::string::String {
        strip_asm_comments(t, AsmComments::A64).unwrap_or_else(|| t.into())
    }

    /// A template with no comment character is returned untouched.
    #[test]
    fn no_comment_chars_is_none() {
        assert!(strip_asm_comments("mov %rax, %rbx", AsmComments::X86).is_none());
        assert!(strip_asm_comments("mov x0, x1", AsmComments::A64).is_none());
    }

    /// Block comments are stripped on both targets, including multi-line and
    /// mid-instruction forms, and leave a separator behind.
    #[test]
    fn block_comments_stripped_on_both_targets() {
        assert_eq!(x86("mov %rax, %rbx /* tail */"), "mov %rax, %rbx  ");
        assert_eq!(a64("mov x0, x1 /* tail */"), "mov x0, x1  ");
        // Multi-line: the newline inside the comment does not separate.
        assert_eq!(x86("/* a\nb */ nop"), "  nop");
        // Mid-instruction: the surrounding tokens stay separate.
        assert_eq!(x86("mov %rax,/* c */%rbx"), "mov %rax, %rbx");
        // A `;` inside a block comment does not split a statement.
        assert_eq!(a64("mov x0, x1 /* a ; b */"), "mov x0, x1  ");
        // A block comment spanning a newline joins the statements around it,
        // which GNU as also does (and then rejects the run-on statement).
        assert_eq!(
            a64("mov x0, x1 /* a\nb */ mov x2, x3"),
            "mov x0, x1   mov x2, x3"
        );
    }

    /// x86-64 takes `#` as a line comment anywhere in the line; the comment
    /// swallows a following `;` because it runs to the newline.
    #[test]
    fn x86_hash_is_a_line_comment() {
        assert_eq!(x86("mov %rax, %rbx # trailing"), "mov %rax, %rbx ");
        assert_eq!(x86("nop # a ; nop\nnop"), "nop \nnop");
        assert_eq!(x86("# whole line\nnop"), "\nnop");
    }

    /// aarch64 takes `#` as the immediate prefix, not a comment, unless it
    /// opens a statement (template start, after a newline, or after a `;`).
    #[test]
    fn a64_hash_is_an_immediate_not_a_comment() {
        assert_eq!(a64("mov x0, #1"), "mov x0, #1");
        assert_eq!(
            a64("movz x3, #0x1234, lsl #16"),
            "movz x3, #0x1234, lsl #16"
        );
        // Statement-opening `#` comments to end of line, leading whitespace
        // included, and swallows a `;` after it.
        assert_eq!(a64("   # lead\nmov x0, #1"), "   \nmov x0, #1");
        assert_eq!(
            a64("mov x0, #1 ; # c ; mov x2, #3\nnop"),
            "mov x0, #1 ; \nnop"
        );
        // A label definition does not end the statement start, so a `#` after
        // one comments; after a directive operand it stays an immediate.
        assert_eq!(a64("1: # c\nmov x0, #1"), "1: \nmov x0, #1");
        assert_eq!(a64("lbl: # c\nmov x0, #1"), "lbl: \nmov x0, #1");
        assert_eq!(
            a64(".balign 4 # not a comment"),
            ".balign 4 # not a comment"
        );
    }

    /// `//` is a line comment on both targets: it is aarch64's comment
    /// character, and GNU as rejects it on x86-64 so no template relies on it.
    #[test]
    fn slash_slash_is_a_line_comment() {
        assert_eq!(a64("mov x0, x1 // tail"), "mov x0, x1 ");
        assert_eq!(x86("mov %rax, %rbx // tail"), "mov %rax, %rbx ");
        assert_eq!(a64("// whole\nmov x0, x1"), "\nmov x0, x1");
    }

    /// `;` separates statements on both targets and is never a comment.
    #[test]
    fn semicolon_is_a_separator_not_a_comment() {
        assert_eq!(x86("nop ; nop # c"), "nop ; nop ");
        assert_eq!(a64("mov x0, #1 ; mov x2, #3"), "mov x0, #1 ; mov x2, #3");
    }

    /// A comment character inside a string literal is data: GNU as keeps it,
    /// so a quoted section name or `.ascii` payload survives intact.
    #[test]
    fn comment_chars_inside_strings_are_kept() {
        assert_eq!(x86(".ascii \"a /* b\""), ".ascii \"a /* b\"");
        assert_eq!(x86(".section \"a#b\",\"a\" # c"), ".section \"a#b\",\"a\" ");
        assert_eq!(a64(".ascii \"x // y\""), ".ascii \"x // y\"");
        // An escaped quote does not end the literal.
        assert_eq!(x86(".ascii \"a\\\" /* b\""), ".ascii \"a\\\" /* b\"");
    }

    /// The condition-code output macro shape from the sweep: a block comment
    /// between two instructions of one template.
    #[test]
    fn block_comment_between_instructions() {
        let t = "btl %2,%1\n\t/* output condition code c*/\n\tsetc %[_cc_c]\n";
        assert_eq!(x86(t), "btl %2,%1\n\t \n\tsetc %[_cc_c]\n");
    }
}

#[cfg(test)]
mod asm_section_tests {
    use super::*;

    #[test]
    fn extract_and_materialize() {
        let text = "1: nop\n.pushsection .discard.t,\"aw\",@progbits\n.balign 8\n.quad 1b\n.long 1b - .\n.long %c0, 7\n.asciz \"hi\"\n.popsection\nnop\n";
        let (code, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        assert_eq!(code, "1: nop\nnop\n");
        assert_eq!(blocks.len(), 1);
        assert_eq!(blocks[0].name, ".discard.t");
        assert_eq!(blocks[0].flags, "aw");
        assert_eq!(blocks[0].sh_type.as_deref(), Some("progbits"));
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|idx| (idx == 0).then_some(42),
            &|name| (name == "1b").then_some(LabelLoc::Text(0x40)),
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        assert_eq!(sink.len(), 1);
        let s = &sink[0];
        assert_eq!(s.align, 8);
        // 8 (quad) + 4 (pcrel long) + 4 + 4 (consts) + 3 ("hi\0").
        assert_eq!(s.bytes.len(), 23);
        assert_eq!(&s.bytes[12..16], &42u32.to_le_bytes());
        assert_eq!(&s.bytes[16..20], &7u32.to_le_bytes());
        assert_eq!(&s.bytes[20..23], b"hi\0");
        assert_eq!(s.relocs.len(), 2);
        assert_eq!(
            s.relocs[0],
            AsmSectionReloc {
                offset: 0,
                width: 8,
                pcrel: false,
                branch: false,
                target: AsmSectionTarget::Text(0x40),
                addend: 0
            }
        );
        assert_eq!(
            s.relocs[1],
            AsmSectionReloc {
                offset: 8,
                width: 4,
                pcrel: true,
                branch: false,
                target: AsmSectionTarget::Text(0x40),
                addend: 0
            }
        );
    }

    #[test]
    fn section_label_difference_parses() {
        // `label_a - label_b` is a constant distance; `label - .` stays
        // PC-relative; a bare name stays a plain reference.
        assert_eq!(
            parse_section_value("662b - 661b").unwrap(),
            AsmSectionValue::LabelDiff {
                minuend: alloc::string::String::from("662b"),
                subtrahend: alloc::string::String::from("661b"),
            }
        );
        assert_eq!(
            parse_section_value("662f-661b").unwrap(),
            AsmSectionValue::LabelDiff {
                minuend: alloc::string::String::from("662f"),
                subtrahend: alloc::string::String::from("661b"),
            }
        );
        assert_eq!(
            parse_section_value("661b - .").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("661b"),
                pcrel: true,
                addend: alloc::string::String::new(),
            }
        );
        assert_eq!(
            parse_section_value("sym").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("sym"),
                pcrel: false,
                addend: alloc::string::String::new(),
            }
        );
        // Three bare labels are still unsupported (only one relocation base).
        assert!(parse_section_value("a - b - c").is_err());
    }

    #[test]
    fn section_reloc_addend_parses() {
        // `func - (. + 4)` (a static-call trampoline's `jmp.d32` to an external
        // symbol): PC-relative against `func`, the inner `+ 4` folding into the
        // addend as `- 4`.
        assert_eq!(
            parse_section_value("func - (. + 4)").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("func"),
                pcrel: true,
                addend: alloc::string::String::from("0 - 4"),
            }
        );
        // `1b - %c2 - .` (the user-pointer bound): PC-relative against the
        // template label `1b`, the operand constant `%c2` folding into the
        // addend.
        assert_eq!(
            parse_section_value("1b - %c2 - .").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("1b"),
                pcrel: true,
                addend: alloc::string::String::from("0 - %c2"),
            }
        );
        // An absolute (non-PC-relative) base plus a constant addend.
        assert_eq!(
            parse_section_value("sym + 8").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("sym"),
                pcrel: false,
                addend: alloc::string::String::from("0 + 8"),
            }
        );
        // Two relocation bases with an addend cannot be a single relocation.
        assert!(parse_section_value("a - b + 4").is_err());
        // A `+ .` (positive location counter) is not a supported relocation.
        assert!(parse_section_value("sym + .").is_err());
    }

    #[test]
    fn section_value_strips_enclosing_parens() {
        // A fully-enclosing paren group is grouping only. The aarch64
        // exception table wraps the whole PC-relative expression
        // (`.long ((insn) - .)`); it must reduce like the single-paren form.
        assert_eq!(
            parse_section_value("((1b) - .)").unwrap(),
            parse_section_value("(1b) - .").unwrap(),
        );
        assert_eq!(
            parse_section_value("((1b) - .)").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("1b"),
                pcrel: true,
                addend: alloc::string::String::new(),
            }
        );
        assert_eq!(
            parse_section_value("(((sym)))").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("sym"),
                pcrel: false,
                addend: alloc::string::String::new(),
            }
        );
        // A group closing before the end is not a full enclosure: the two
        // parenthesised labels stay a constant distance.
        assert_eq!(
            parse_section_value("(662b) - (661b)").unwrap(),
            AsmSectionValue::LabelDiff {
                minuend: alloc::string::String::from("662b"),
                subtrahend: alloc::string::String::from("661b"),
            }
        );
    }

    #[test]
    fn section_operand_constant_expression() {
        // `(1 << 15) | (%0)`: a constant expression whose leaves are integer
        // literals and an operand constant. It parses as a deferred `Expr` and
        // materializes with the operand resolved (a cpucap number 37, so
        // 0x8000 | 37 = 0x8025).
        assert_eq!(
            parse_section_value("(1 << 15) | (%0)").unwrap(),
            AsmSectionValue::Expr(alloc::string::String::from("(1 << 15) | (%0)")),
        );
        let text = ".pushsection .altinstructions,\"a\"\n.hword (1 << 15) | (%0)\n.popsection\n";
        let (_code, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|idx| (idx == 0).then_some(37),
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        assert_eq!(sink[0].bytes, alloc::vec![0x25, 0x80]);
        // A non-constant operand leaves the expression unresolved.
        let mut sink2 = alloc::vec::Vec::new();
        let err = materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink2,
        )
        .unwrap_err();
        assert!(err.contains("non-constant"), "{err}");
    }

    #[test]
    fn section_parenthesised_label_reference() {
        // `_ASM_EXTABLE` wraps its label in parentheses (`.long (1b) - .`).
        // The parentheses are grouping, so it resolves like the bare `1b - .`,
        // and a parenthesised label distance like the bare form.
        assert_eq!(
            parse_section_value("(1b) - .").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("1b"),
                pcrel: true,
                addend: alloc::string::String::new(),
            },
        );
        assert_eq!(
            parse_section_value("(2b) - (1b)").unwrap(),
            AsmSectionValue::LabelDiff {
                minuend: alloc::string::String::from("2b"),
                subtrahend: alloc::string::String::from("1b"),
            },
        );
        // The materialized field is a PC-relative reloc to the label's text
        // offset, as for the unparenthesised reference.
        let text = "1: nop\n.pushsection __ex_table,\"a\"\n.long (1b) - .\n.popsection\n";
        let (_code, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|n| (n == "1b").then_some(LabelLoc::Text(0x40)),
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        assert_eq!(
            sink[0].relocs,
            alloc::vec![AsmSectionReloc {
                offset: 0,
                width: 4,
                pcrel: true,
                branch: false,
                target: AsmSectionTarget::Text(0x40),
                addend: 0,
            }],
        );
    }

    #[test]
    fn asm_conditionals_keep_the_taken_branch() {
        // `.if <expr>` compares with the relational operators; a non-zero
        // result keeps the branch. A true comparison is -1, as in GNU as.
        // `.else` / `.elseif` select the live arm, and a dropped branch takes
        // its `.pushsection` with it.
        assert_eq!(eval_asm_if_condition("1 == 1"), Some(-1));
        assert_eq!(eval_asm_if_condition("1 != 1"), Some(0));
        assert_eq!(eval_asm_if_condition("(1 << 2) >= 4"), Some(-1));
        assert_eq!(eval_asm_if_condition("nop"), None);
        let reduce = |t: &str| strip_asm_conditionals(t).unwrap().unwrap();
        assert_eq!(reduce(".if 1 == 1\nnop\n.endif\n"), "nop\n");
        assert_eq!(reduce(".if 0\nbad\n.else\ngood\n.endif\n"), "good\n");
        assert_eq!(
            reduce(".if 0\n.pushsection .x\n.byte 1\n.popsection\n.endif\nkeep\n"),
            "keep\n"
        );
        // A false outer branch suppresses a true inner one.
        assert_eq!(reduce(".if 0\n.if 1\nx\n.endif\n.endif\ny\n"), "y\n");
        // Unbalanced and non-constant conditions are rejected.
        assert!(strip_asm_conditionals(".if 1\nnop\n").is_err());
        assert!(strip_asm_conditionals(".if x\n.endif\n").is_err());
        // A template with no conditional is left untouched.
        assert!(strip_asm_conditionals("nop\n").unwrap().is_none());
    }

    #[test]
    fn word_directive_width_is_target_dependent() {
        // GNU as `.word` is 2 bytes on x86 ELF, 4 on AArch64. The alternatives
        // metadata stores a label reference with `.word`, which needs a 4- or
        // 8-byte field, so it resolves only under the AArch64 width.
        let width = |is_a64: bool| -> u8 {
            let (_c, blocks) =
                extract_asm_sections(".pushsection .x,\"a\"\n.word 0x1234\n.popsection\n", is_a64)
                    .unwrap()
                    .unwrap();
            match &blocks[0].items[0] {
                AsmSectionItem::Data { width, .. } => *width,
                _ => panic!("expected data"),
            }
        };
        assert_eq!(width(false), 2);
        assert_eq!(width(true), 4);
        // On AArch64 `.word 1b - .` fits its PC-relative reloc.
        let (_c, blocks) =
            extract_asm_sections(".pushsection .x,\"a\"\n.word 1b - .\n.popsection\n", true)
                .unwrap()
                .unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|n| (n == "1b").then_some(LabelLoc::Text(0)),
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        assert_eq!(sink[0].relocs[0].width, 4);
    }

    #[test]
    fn section_label_difference_bytes() {
        // Distances between two template labels are constants sized to the
        // field, forward or backward, byte-verified against GNU as (a 4-byte
        // instruction between the labels: `.byte 2b - 1b` is 0x04, `1b - 2b`
        // is 0xFC).
        let text = "1: nop\n2: nop\n.pushsection .x,\"a\"\n\
                    .byte 2b - 1b\n.short 2b - 1b\n.long 2b - 1b\n.byte 1b - 2b\n\
                    .popsection\n";
        let (_code, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|name| match name {
                "1b" => Some(LabelLoc::Text(0)),
                "2b" => Some(LabelLoc::Text(4)),
                _ => None,
            },
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        let s = &sink[0];
        assert_eq!(
            s.bytes,
            alloc::vec![0x04, 0x04, 0x00, 0x04, 0x00, 0x00, 0x00, 0xFC]
        );
        assert!(s.relocs.is_empty());
    }

    #[test]
    fn cross_section_label_difference_folds_to_replacement_length() {
        // The alternatives entry's `.byte 775f - 774f` measures a distance
        // between two labels in a later section (`.altinstr_replacement`), while
        // the field itself sits in `.altinstructions`. GNU as folds it to the
        // replacement length (3 here). A difference across sections is rejected.
        let text = ".pushsection .altinstructions,\"a\"\n.byte 775f - 774f\n.popsection\n\
                    .pushsection .altinstr_replacement,\"ax\"\n\
                    774:\n.byte 0x0f,0x01,0xca\n775:\n.popsection\n";
        let (_code, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        let entry = sink.iter().find(|s| s.name == ".altinstructions").unwrap();
        assert_eq!(
            entry.bytes,
            alloc::vec![3],
            "775f - 774f is the repl length"
        );
        assert!(
            entry.relocs.is_empty(),
            "a same-section distance is constant"
        );
    }

    #[test]
    fn cross_section_label_difference_across_sections_is_rejected() {
        // `774f` and `1b` live in different sections, so their difference is not
        // a constant; it is rejected rather than folded to a bogus byte.
        let text = "1: nop\n.pushsection .a,\"a\"\n.byte 774f - 1b\n.popsection\n\
                    .pushsection .b,\"ax\"\n774:\n.byte 0\n.popsection\n";
        let (_code, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        let err = materialize_asm_sections(
            &blocks,
            &|_| None,
            &|name| (name == "1b").then_some(LabelLoc::Text(0)),
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .expect_err("cross-section difference is not a constant");
        assert!(err.contains("crosses sections"), "{err}");
    }

    #[test]
    fn skip_count_expression_matches_gnu_as() {
        // The ALTERNATIVE `.skip` count `-(((rlen)-(slen)) > 0) * ((rlen)-(slen))`
        // pads by `max(0, rlen - slen)`: a relational is -1 for true (GNU as),
        // so a longer replacement yields a positive count and a shorter one
        // zero. Labels resolve through the passed closure.
        let expr = "-(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b))";
        let pad = |rlen: i64, slen: i64| {
            eval_asm_expr_with_labels(expr, &|n| match n {
                "775f" => Some(rlen),
                "774f" => Some(0),
                "772b" => Some(slen),
                "771b" => Some(0),
                _ => None,
            })
        };
        assert_eq!(pad(3, 0), Some(3), "replacement longer: pad the difference");
        assert_eq!(pad(1, 4), Some(0), "replacement shorter: no padding");
        assert_eq!(pad(2, 2), Some(0), "equal length: no padding");
        // A constant count needs no labels; an unknown label is not a constant.
        assert_eq!(eval_asm_expr_with_labels("16", &|_| None), Some(16));
        assert_eq!(eval_asm_expr_with_labels("7f - 6b", &|_| None), None);
    }

    #[test]
    fn measure_offsets_locate_section_labels() {
        // Structural measurement places each label at its byte offset within the
        // section, so a forward difference resolves before the values are laid
        // out: `774` at 0, `775` after the 3 replacement bytes.
        let text = ".pushsection .altinstr_replacement,\"ax\"\n\
                    774:\n.byte 0x0f,0x01,0xca\n775:\n.popsection\n";
        let (_code, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let m = measure_asm_section_offsets(&blocks, &|_| None, false).unwrap();
        assert_eq!(m.offset("774f"), Some(0));
        assert_eq!(m.offset("775f"), Some(3));
        assert_eq!(m.section("774f"), m.section("775f"), "same section");
    }

    #[test]
    fn section_label_difference_overflow_rejected() {
        // A distance outside the field width is rejected, not truncated.
        let text = "1: nop\n2: nop\n.pushsection .x,\"a\"\n.byte 2b - 1b\n.popsection\n";
        let (_c, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        let err = materialize_asm_sections(
            &blocks,
            &|_| None,
            &|name| match name {
                "1b" => Some(LabelLoc::Text(0)),
                "2b" => Some(LabelLoc::Text(256)),
                _ => None,
            },
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .expect_err("256 does not fit a byte");
        assert!(err.contains("does not fit"), "{err}");
    }

    #[test]
    fn subsection_is_rejected() {
        // The AArch64 emitter lifts the ALTERNATIVE `.subsection` replacement
        // with `split_asm_subsections` before this; `extract_asm_sections` is
        // the backstop for any `.subsection` that reaches it (a shape the split
        // did not lift). Emitting it inline would run both the main and the
        // replacement sequence, so it is rejected rather than miscompiled.
        let with = "661: nop\n.pushsection .altinstructions,\"a\"\n.byte 0\n\
                    .popsection\n.subsection 1\n663: nop\n.previous\n";
        let err = extract_asm_sections(with, true).unwrap_err();
        assert!(err.contains(".subsection"), "{err}");
        let bare = "nop\n.subsection 1\nnop\n.previous\n";
        let err = extract_asm_sections(bare, true).unwrap_err();
        assert!(err.contains(".subsection"), "{err}");
    }

    #[test]
    fn split_asm_subsections_lifts_supported_shape() {
        // The clean ALTERNATIVE shape -- a `.subsection N` bracketed by
        // `.previous` at code-stream level -- is lifted: its lines move to the
        // deferred stream and leave the main stream free of `.subsection`, so
        // `extract_asm_sections` then processes it.
        let text = "661:\nmrs x0, tpidr_el1\n662:\n\
                    .pushsection .altinstructions,\"a\"\n.byte 0\n.popsection\n\
                    .subsection 1\n663:\nmrs x0, tpidr_el2\n664:\n.previous\n";
        let (main, deferred) = split_asm_subsections(text);
        assert!(!main.contains(".subsection"), "main: {main}");
        assert!(main.contains("tpidr_el1") && main.contains(".altinstructions"));
        assert!(deferred.contains("tpidr_el2") && deferred.contains("663:"));
        assert!(!deferred.contains("tpidr_el1"));
        // Shapes the split does not lift are left intact for the backstop: an
        // open region (no `.previous`), a second region, and a `.subsection`
        // nested in a `.pushsection`.
        for unlifted in [
            "nop\n.subsection 1\nnop\n",
            ".subsection 1\nnop\n.previous\n.subsection 1\nnop\n.previous\n",
            ".pushsection .x,\"ax\"\n.subsection 1\nnop\n.previous\n.popsection\n",
        ] {
            let (main, deferred) = split_asm_subsections(unlifted);
            assert_eq!(main, unlifted, "left intact");
            assert!(deferred.is_empty());
        }
        // A template without `.subsection` is returned unchanged.
        let (main, deferred) = split_asm_subsections("nop\nret\n");
        assert_eq!(main, "nop\nret\n");
        assert!(deferred.is_empty());
    }

    #[test]
    fn deferred_org_length_expression_via_label_evaluator() {
        // The deferred `.org` target reuses `eval_asm_expr_with_labels` with a
        // resolver mapping the location counter `.` to the current offset and
        // each `Nb` label to its offset. `. - (664b-663b) + (662b-661b)` moves
        // `.` by (old_len - new_len): a no-op when the lengths match, backward
        // (an error at the call site) when the replacement is longer.
        let at = |cur: i64, m: &[(&'static str, i64)]| {
            eval_asm_expr_with_labels(". - (664b-663b) + (662b-661b)", &|n| {
                if n == "." {
                    return Some(cur);
                }
                m.iter().find(|(k, _)| *k == n).map(|(_, v)| *v)
            })
        };
        // new_len 8, old_len 8: target equals `.`.
        assert_eq!(
            at(8, &[("663b", 0), ("664b", 8), ("661b", 0), ("662b", 8)]),
            Some(8)
        );
        // new_len 8, old_len 4: target 8 - 8 + 4 = 4, a backward move.
        assert_eq!(
            at(8, &[("663b", 0), ("664b", 8), ("661b", 0), ("662b", 4)]),
            Some(4)
        );
    }

    #[test]
    fn replacement_instruction_kept_as_code_for_executable_section() {
        // The x86 ALTERNATIVE places its replacement in a `.pushsection
        // .altinstr_replacement,"ax"`. An instruction there is kept as a `Code`
        // item; the arch backend encodes it (a direct call/jmp to a symbol or a
        // self-contained instruction) or rejects an un-encodable one (see the
        // linker test `x86_alternative_call_replacement_encodes_and_relocates`).
        let exec = "771: nop\n.pushsection .altinstr_replacement,\"ax\"\n\
                    774: call foo\n775:\n.popsection\n";
        let (_code, blocks) = extract_asm_sections(exec, false).unwrap().unwrap();
        let repl = blocks
            .iter()
            .find(|b| b.name == ".altinstr_replacement")
            .unwrap();
        assert!(
            repl.items
                .iter()
                .any(|it| matches!(it, AsmSectionItem::Code(t) if t == "call foo")),
            "instruction kept as Code: {:?}",
            repl.items
        );
        // A data section is not executable, so an instruction there is rejected
        // rather than dropped, which would leave a data entry pointing at absent
        // bytes.
        let data = "771: nop\n.pushsection .altinstructions,\"a\"\n\
                    774: wrmsr\n775:\n.popsection\n";
        let err = extract_asm_sections(data, false).unwrap_err();
        assert!(
            err.contains("wrmsr") && err.contains("named section"),
            "{err}"
        );
    }

    #[test]
    fn data_field_fit_boundaries() {
        // Signed-or-unsigned fit per width, matching GNU as's accept set.
        assert!(value_fits_width(255, 1) && value_fits_width(-128, 1));
        assert!(!value_fits_width(256, 1) && !value_fits_width(-129, 1));
        assert!(value_fits_width(65535, 2) && value_fits_width(-32768, 2));
        assert!(!value_fits_width(65536, 2));
        assert!(value_fits_width(0xFFFF_FFFF, 4) && !value_fits_width(0x1_0000_0000, 4));
        assert!(value_fits_width(i64::MIN, 8) && value_fits_width(i64::MAX, 8));
    }

    #[test]
    fn section_previous_and_symbols() {
        // `.section` + `.previous` return to the code stream; an unknown
        // name resolves as a symbol target.
        let text = "nop\n.section .fixup,\"ax\"\n.quad handler\n.previous\nnop\n";
        let (code, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        assert_eq!(code, "nop\nnop\n");
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        assert_eq!(
            sink[0].relocs[0].target,
            AsmSectionTarget::Symbol(alloc::string::String::from("handler"))
        );
        // Two blocks naming one section merge; a `.popsection` without a
        // push is rejected.
        let text = ".pushsection .a,\"a\"\n.long 1\n.popsection\n.pushsection .a,\"a\"\n.long 2\n.popsection\n";
        let (_, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        assert_eq!(sink.len(), 1);
        assert_eq!(sink[0].bytes.len(), 8);
        assert!(
            extract_asm_sections(".pushsection .a,\"a\"\n.popsection\n.popsection", false).is_err()
        );
        // No section directives: the fast path returns None.
        assert!(extract_asm_sections("nop", false).unwrap().is_none());
    }

    #[test]
    fn align_convention_per_arch() {
        // `.align 3` is 2^3 = 8 bytes under the AArch64 convention and a
        // (rejected, non-power-of-two) byte count under the x86 one.
        let text = ".pushsection .t,\"a\"\n.align 3\n.byte 1\n.popsection";
        let (_, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            true,
            &mut sink,
        )
        .unwrap();
        assert_eq!(sink[0].align, 8);
        let mut sink = alloc::vec::Vec::new();
        assert!(
            materialize_asm_sections(
                &blocks,
                &|_| None,
                &|_| None,
                &|_| None,
                &|_| None,
                false,
                &mut sink
            )
            .is_err()
        );
        // `.align 8` under the x86 convention is 8 bytes.
        let text = ".pushsection .t,\"a\"\n.align 8\n.byte 1\n.popsection";
        let (_, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        assert_eq!(sink[0].align, 8);
    }

    #[test]
    fn section_labels_become_offsets() {
        // A label records its offset in the section; `.globl` sets external
        // binding whether it precedes or follows the definition, and a
        // quoted section name is unquoted.
        let text = ".section \".export\",\"a\"\n                    first:\n                    .asciz \"GPL\"\n                    .balign 8\n                    .globl second\n                    second: .quad 0\n                    .globl nowhere\n                    .previous\n";
        let (_, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        assert_eq!(blocks[0].name, ".export");
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        let s = &sink[0];
        assert_eq!(s.bytes.len(), 16);
        assert_eq!(
            s.labels,
            alloc::vec![
                AsmSectionLabel {
                    name: alloc::string::String::from("first"),
                    offset: 0,
                    global: false,
                    sym_type: AsmSymType::NoType,
                    size: None,
                },
                AsmSectionLabel {
                    name: alloc::string::String::from("second"),
                    offset: 8,
                    global: true,
                    sym_type: AsmSymType::NoType,
                    size: None,
                },
            ],
            "a `.globl` naming no label here defines no symbol",
        );
    }

    #[test]
    fn section_type_and_size_set_symbol_attributes() {
        // The static-call trampoline shape: `.type name, @function` sets the
        // label's ELF type, `.size name, . - name` its byte extent (the
        // distance from the label to the directive). gas emits STT_FUNC with
        // st_size = 8 for this body.
        let text = ".pushsection .static_call.text, \"ax\"\n\
                    .globl tramp\n\
                    tramp:\n\
                    .byte 0xe9, 0x11, 0x22, 0x33, 0x44\n\
                    .byte 0x0f, 0xb9, 0xcc\n\
                    .type tramp, @function\n\
                    .size tramp, . - tramp\n\
                    .popsection\n";
        let (_, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        let l = &sink[0].labels[0];
        assert_eq!(l.name, "tramp");
        assert!(l.global);
        assert_eq!(l.sym_type, AsmSymType::Func);
        assert_eq!(l.size, Some(8));
    }

    #[test]
    fn section_type_object_and_bad_forms_rejected() {
        let materialize = |text: &str| {
            let (_, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
            let mut sink = alloc::vec::Vec::new();
            materialize_asm_sections(
                &blocks,
                &|_| None,
                &|_| None,
                &|_| None,
                &|_| None,
                false,
                &mut sink,
            )
            .map(|_| sink)
        };
        // `@object` is accepted and sets STT_OBJECT.
        let sink = materialize(
            ".pushsection .d,\"a\"\nv:\n.quad 0\n.type v, @object\n.size v, . - v\n.popsection\n",
        )
        .unwrap();
        assert_eq!(sink[0].labels[0].sym_type, AsmSymType::Object);
        assert_eq!(sink[0].labels[0].size, Some(8));
        // An unknown type name is rejected at parse rather than mis-typed.
        let err = extract_asm_sections(
            ".pushsection .t,\"a\"\nv:\n.type v, @weird\n.popsection\n",
            false,
        )
        .expect_err("unknown .type must be rejected");
        assert!(err.contains("unsupported `.type`"), "{err}");
        // `.type` / `.size` on a symbol not defined in the section is rejected.
        let err = materialize(".pushsection .t,\"a\"\n.type ext, @function\n.popsection\n")
            .expect_err("`.type` on an undefined label must be rejected");
        assert!(err.contains("undefined label"), "{err}");
    }

    #[test]
    fn duplicate_section_label_is_rejected() {
        let text = ".pushsection .t,\"a\"\ndup:\n.quad 0\ndup:\n.popsection\n";
        let (_, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        let err = materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .expect_err("duplicate label must be rejected");
        assert!(err.contains("duplicate label"), "{err}");
    }

    #[test]
    fn tab_separated_directives_and_trailing_whitespace() {
        // Preprocessed templates separate the directive from its arguments
        // with tabs and leave trailing whitespace after a label.
        let text = ".section\t\".initcall7.init\", \"a\"\t\t\n                    __initcall_probe7:\t\t\t\n                    .long\tprobe - .\t\n                    .previous\t\t\t\n";
        let (_, blocks) = extract_asm_sections(text, false).unwrap().unwrap();
        assert_eq!(blocks[0].name, ".initcall7.init");
        assert_eq!(blocks[0].flags, "a");
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|_| None,
            &|_| None,
            &|_| None,
            &|_| None,
            false,
            &mut sink,
        )
        .unwrap();
        let s = &sink[0];
        assert_eq!(s.bytes.len(), 4);
        assert_eq!(s.labels.len(), 1);
        assert_eq!(s.labels[0].name, "__initcall_probe7");
        assert_eq!(s.labels[0].offset, 0);
        assert!(!s.labels[0].global);
        assert_eq!(s.relocs.len(), 1, "the pc-relative reference survives");
    }

    #[test]
    fn gas_macro_sysreg_read_folds_to_inst_word() {
        // The read_sysreg_s construct: an `.irp`-generated `.L__gpr_num_*`
        // table, a local `mrs_s` macro, its invocation, and `.purgem`. `%0`
        // stands for the destination register x1.
        let text = concat!(
            "\t.irp\tnum,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n",
            "\t.equ\t.L__gpr_num_x\\num, \\num\n",
            "\t.equ\t.L__gpr_num_w\\num, \\num\n",
            "\t.endr\n",
            "\t.equ\t.L__gpr_num_xzr, 31\n",
            "\t.equ\t.L__gpr_num_wzr, 31\n",
            "\t.macro\tmrs_s, rt, sreg\n",
            "\t.inst (0xd5200000|(\\sreg)|(.L__gpr_num_\\rt))\n",
            "\t.endm\n",
            "\tmrs_s %0, (((3) << 19) | ((0) << 16) | ((0) << 12) | ((0) << 8) | ((0) << 5))\n",
            "\t.purgem\tmrs_s\n",
        );
        let subst = |t: &str| (t == "%0").then(|| alloc::string::String::from("x1"));
        let out = expand_asm_gas_macros(text, 4, &subst).unwrap().unwrap();
        // sys_reg(3,0,0,0,0) is 0x180000, mrs base 0xd5200000, Rt=1: 0xd5380001.
        assert_eq!(out.trim(), ".byte 0x01, 0x00, 0x38, 0xd5", "{out}");
    }

    #[test]
    fn gas_macro_expansions_are_independent_per_call() {
        // A second expansion redefines the macro and equates cleanly: the
        // per-call tables are what makes two read_sysreg_s in one unit work.
        let block = |sreg: &str, reg: &str| {
            let text = alloc::format!(
                concat!(
                    "\t.irp\tnum,0,1,2\n",
                    "\t.equ\t.L__gpr_num_x\\num, \\num\n",
                    "\t.endr\n",
                    "\t.macro\tmrs_s, rt, sreg\n",
                    "\t.inst (0xd5200000|(\\sreg)|(.L__gpr_num_\\rt))\n",
                    "\t.endm\n",
                    "\tmrs_s %0, {sreg}\n",
                    "\t.purgem\tmrs_s\n"
                ),
                sreg = sreg
            );
            let subst = move |t: &str| (t == "%0").then(|| alloc::string::String::from(reg));
            expand_asm_gas_macros(&text, 4, &subst)
                .unwrap()
                .unwrap()
                .trim()
                .to_string()
        };
        assert_eq!(block("(3 << 19)", "x1"), ".byte 0x01, 0x00, 0x38, 0xd5");
        assert_eq!(
            block("((3 << 19) | (4 << 8))", "x0"),
            ".byte 0x00, 0x04, 0x38, 0xd5"
        );
    }

    #[test]
    fn gas_macro_extable_short_resolves_register_field() {
        // The exception-table register field: a `.short` inside a section
        // whose value references the `.L__gpr_num_*` table with a `%w0`
        // operand. The operand substitutes to w2, then the table resolves it.
        let text = concat!(
            "\t.irp\tnum,0,1,2\n",
            "\t.equ\t.L__gpr_num_w\\num, \\num\n",
            "\t.endr\n",
            "\t.equ\t.L__gpr_num_wzr, 31\n",
            "\t.pushsection __ex_table, \"a\"\n",
            "\t.short (((.L__gpr_num_%w0) << 0) | ((.L__gpr_num_wzr) << 5))\n",
            "\t.popsection\n",
        );
        let subst = |t: &str| (t == "%w0").then(|| alloc::string::String::from("w2"));
        let out = expand_asm_gas_macros(text, 4, &subst).unwrap().unwrap();
        assert!(out.contains(".short (((2) << 0) | ((31) << 5))"), "{out}");
        assert!(out.contains(".pushsection __ex_table"), "{out}");
    }

    #[test]
    fn gas_macro_malformed_forms_are_rejected() {
        let none = |_: &str| None;
        // No directives at all: not this pass's business.
        assert!(
            expand_asm_gas_macros("add x0, x0, x1\n", 4, &none)
                .unwrap()
                .is_none()
        );
        // `.purgem` of a macro that was never defined.
        assert!(
            expand_asm_gas_macros(".purgem foo\n", 4, &none)
                .unwrap_err()
                .contains("purgem")
        );
        // `.macro` with no closing `.endm`.
        assert!(
            expand_asm_gas_macros(".macro foo\nnop\n", 4, &none)
                .unwrap_err()
                .contains(".endm")
        );
        // A non-constant `.inst` value is rejected, never mis-encoded.
        assert!(
            expand_asm_gas_macros(".inst (0xd5200000 | undefined_sym)\n", 4, &none)
                .unwrap_err()
                .contains(".inst")
        );
    }

    #[test]
    fn rept_expands_repeats_and_rejects_malformed() {
        // No `.rept`: not this pass's business.
        assert!(expand_asm_rept("nop\nret\n").unwrap().is_none());
        // `.rept 3` repeats the body three times (the ALTERNATIVE nop
        // padding); `.rept 0` drops it; nested counts multiply.
        let out = expand_asm_rept("swpb w0, w1, [x2]\n.rept 3\nnop\n.endr\n")
            .unwrap()
            .unwrap();
        assert_eq!(out.matches("nop").count(), 3, "{out}");
        assert!(out.contains("swpb"));
        assert_eq!(
            expand_asm_rept(".rept 0\nnop\n.endr\n")
                .unwrap()
                .unwrap()
                .matches("nop")
                .count(),
            0
        );
        assert_eq!(
            expand_asm_rept(".rept 2\n.rept 3\nnop\n.endr\n.endr\n")
                .unwrap()
                .unwrap()
                .matches("nop")
                .count(),
            6
        );
        // A non-constant count, a stray `.endr`, and an unclosed `.rept` are
        // errors rather than a mis-counted expansion.
        assert!(
            expand_asm_rept(".rept 1b-2b\nnop\n.endr\n")
                .unwrap_err()
                .contains("not constant")
        );
        assert!(
            expand_asm_rept("nop\n.rept 2\nnop\n.endr\n.endr\n")
                .unwrap_err()
                .contains(".endr")
        );
        assert!(
            expand_asm_rept(".rept 2\nnop\n")
                .unwrap_err()
                .contains(".endr")
        );
    }
}

#[cfg(test)]
mod raw_template_tests {
    use super::parse_raw_template;

    #[test]
    fn bare_hex_and_directives() {
        // Bare hex-byte run (`;` / whitespace separated), read as hex.
        assert_eq!(
            parse_raw_template(b"CC; C3; 90").unwrap(),
            [0xCC, 0xC3, 0x90]
        );
        assert_eq!(
            parse_raw_template(b"1f 20 03 d5").unwrap(),
            [0x1f, 0x20, 0x03, 0xd5]
        );
        // `.byte` / `.word` / `.long` / `.quad`, little-endian at width.
        assert_eq!(
            parse_raw_template(b".byte 0x1f, 0x20, 0x03, 0xd5").unwrap(),
            [0x1f, 0x20, 0x03, 0xd5]
        );
        assert_eq!(parse_raw_template(b".word 0x1234").unwrap(), [0x34, 0x12]);
        assert_eq!(parse_raw_template(b".byte 144").unwrap(), [0x90]);
        // Mixed directive + hex-run pieces concatenate.
        assert_eq!(parse_raw_template(b".byte 0x90; 90").unwrap(), [0x90, 0x90]);
    }

    #[test]
    fn rejects_mnemonics_and_empty() {
        // A piece that is a mnemonic (letters) is not a raw-byte template.
        assert!(parse_raw_template(b"nop").is_none());
        assert!(parse_raw_template(b".byte 0x90; add %rax, %rbx").is_none());
        // An empty template carries no bytes.
        assert!(parse_raw_template(b"").is_none());
        assert!(parse_raw_template(b"   ").is_none());
    }
}

#[cfg(test)]
mod const_expr_tests {
    use super::eval_const_expr;

    #[test]
    fn literals_and_arithmetic() {
        assert_eq!(eval_const_expr("42"), Some(42));
        assert_eq!(eval_const_expr("0x1F"), Some(31));
        assert_eq!(eval_const_expr("0X10"), Some(16));
        assert_eq!(eval_const_expr("-7"), Some(-7));
        assert_eq!(eval_const_expr("  12  "), Some(12));
        // The feature-word encoding an assembler folds for a section value.
        assert_eq!(eval_const_expr("(16*32+22)"), Some(534));
        // Displacement expressions in a memory operand.
        assert_eq!(eval_const_expr("0*8"), Some(0));
        assert_eq!(eval_const_expr("3*8"), Some(24));
    }

    #[test]
    fn precedence_and_grouping() {
        assert_eq!(eval_const_expr("2+3*4"), Some(14));
        assert_eq!(eval_const_expr("(2+3)*4"), Some(20));
        assert_eq!(eval_const_expr("1<<3"), Some(8));
        assert_eq!(eval_const_expr("(1<<3)|2"), Some(10));
        assert_eq!(eval_const_expr("0xF0|0x0F"), Some(255));
        assert_eq!(eval_const_expr("0xFF&0x0F"), Some(15));
        assert_eq!(eval_const_expr("5^3"), Some(6));
        assert_eq!(eval_const_expr("~0"), Some(-1));
        assert_eq!(eval_const_expr("-(2+3)"), Some(-5));
        assert_eq!(eval_const_expr("17%5"), Some(2));
        assert_eq!(eval_const_expr("17/5"), Some(3));
        assert_eq!(eval_const_expr("1<<3|2"), Some(10));
        assert_eq!(eval_const_expr("64>>2"), Some(16));
    }

    /// Anything that is not a self-contained constant yields `None`, which is
    /// how a label or symbol reference stays distinguishable.
    #[test]
    fn non_constants_reject() {
        assert_eq!(eval_const_expr("foo"), None);
        assert_eq!(eval_const_expr("1b"), None);
        assert_eq!(eval_const_expr("775f-774f"), None);
        assert_eq!(eval_const_expr(""), None);
        assert_eq!(eval_const_expr("(1+2"), None);
        assert_eq!(eval_const_expr("1+"), None);
        assert_eq!(eval_const_expr("1/0"), None);
        assert_eq!(eval_const_expr("1%0"), None);
        assert_eq!(eval_const_expr("1<<64"), None);
        assert_eq!(eval_const_expr("2 3"), None);
    }
}
