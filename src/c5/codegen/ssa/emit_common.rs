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
    /// A template label (`1b`, `name`) or a symbol, optionally
    /// PC-relative (`ref - .`). The emitter resolves a template label to
    /// a text offset; an unknown name is a symbol reference.
    Ref { name: alloc::string::String, pcrel: bool },
}

/// One item of an in-template section block, in source order.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSectionItem {
    /// A `.byte`-family directive: element width plus its values.
    Data {
        width: u8,
        values: alloc::vec::Vec<AsmSectionValue>,
    },
    /// `.balign n` (or `.align n`, byte-granular on both supported
    /// arches under GNU as when n is a byte count; `.p2align e` is the
    /// exponent form).
    Align(u32),
    /// `.org n`: pad with zero bytes to section offset `n`.
    Org(u32),
    /// `.ascii` / `.asciz` / `.string` payload (NUL included when the
    /// directive appends one).
    Bytes(alloc::vec::Vec<u8>),
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
    /// Largest `.balign` seen; the object writer aligns the section.
    pub align: u32,
}

/// Split a template into its code text and its section blocks. Returns
/// `None` when the template has no section directives (the common case).
/// The section stack starts at the code stream; `.pushsection` pushes a
/// named section, `.popsection` pops, `.section` replaces the top, and
/// `.previous` swaps the top two. Only data directives are accepted
/// inside a named section (code in sections is TODO).
pub(crate) fn extract_asm_sections(
    text: &str,
) -> Result<Option<(alloc::string::String, alloc::vec::Vec<AsmSectionBlock>)>, alloc::string::String>
{
    if !text.contains(".pushsection") && !text.contains(".section") {
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
            Some(idx) => blocks[idx].items.push(parse_section_item(tok, rest)?),
        }
    }
    Ok(Some((code, blocks)))
}

/// Parse the argument list of `.pushsection` / `.section`:
/// `name[,"flags"[,@type]]`.
fn parse_section_args(rest: &str) -> Result<AsmSectionBlock, alloc::string::String> {
    let mut parts = rest.split(',').map(str::trim);
    let name = parts
        .next()
        .filter(|n| !n.is_empty())
        .ok_or_else(|| alloc::string::String::from("inline asm: section name expected"))?;
    let mut flags = alloc::string::String::new();
    let mut sh_type = None;
    for p in parts {
        if let Some(f) = p.strip_prefix('"').and_then(|p| p.strip_suffix('"')) {
            flags = alloc::string::String::from(f);
        } else if let Some(t) = p.strip_prefix('@').or_else(|| p.strip_prefix('%')) {
            sh_type = Some(alloc::string::String::from(t));
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

/// Parse one directive inside a named section.
fn parse_section_item(tok: &str, rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    if let Some(w) = data_directive_width(tok) {
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
        ".balign" | ".align" => {
            let n = parse_raw_int(rest)
                .filter(|&n| n > 0 && (n as u64).is_power_of_two())
                .ok_or_else(|| alloc::format!("inline asm: bad alignment `{rest}`"))?;
            Ok(AsmSectionItem::Align(n as u32))
        }
        ".p2align" => {
            let e = parse_raw_int(rest)
                .filter(|&e| (0..=12).contains(&e))
                .ok_or_else(|| alloc::format!("inline asm: bad alignment `{rest}`"))?;
            Ok(AsmSectionItem::Align(1 << e))
        }
        ".org" => {
            let n = parse_raw_int(rest)
                .filter(|&n| n >= 0)
                .ok_or_else(|| alloc::format!("inline asm: bad `.org` offset `{rest}`"))?;
            Ok(AsmSectionItem::Org(n as u32))
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
        _ => Err(alloc::format!(
            "inline asm: unsupported directive `{tok}` in a named section"
        )),
    }
}

/// Parse one data-directive value: a constant, an operand reference, or
/// a label / symbol reference (optionally `- .` PC-relative).
fn parse_section_value(a: &str) -> Result<AsmSectionValue, alloc::string::String> {
    if let Some(v) = parse_raw_int(a) {
        return Ok(AsmSectionValue::Const(v));
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
    // `ref - .`: PC-relative against the field's own position.
    let (name, pcrel) = match a.split_once('-') {
        Some((l, r)) if r.trim() == "." => (l.trim(), true),
        None => (a, false),
        _ => return Err(alloc::format!("inline asm: unsupported expression `{a}`")),
    };
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    if name.is_empty() || !name.bytes().all(ident) {
        return Err(alloc::format!("inline asm: bad section value `{a}`"));
    }
    Ok(AsmSectionValue::Ref {
        name: alloc::string::String::from(name),
        pcrel,
    })
}

/// Materialize the parsed section blocks: resolve operand constants and
/// label references, lay out the bytes, and merge into the sink by
/// `(name, flags, sh_type)`. `const_of` yields an `i`-class operand's
/// constant; `label_off` resolves a template-label name to its text
/// offset (`None` means the name is a symbol).
pub(crate) fn materialize_asm_sections(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    label_off: &dyn Fn(&str) -> Option<usize>,
    sink: &mut alloc::vec::Vec<AsmSection>,
) -> Result<(), alloc::string::String> {
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
                    align: 1,
                });
                sink.last_mut().unwrap()
            }
        };
        for item in &b.items {
            match item {
                AsmSectionItem::Align(n) => {
                    sec.align = sec.align.max(*n);
                    while sec.bytes.len() % *n as usize != 0 {
                        sec.bytes.push(0);
                    }
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
                                sec.bytes
                                    .extend_from_slice(&(c as u64).to_le_bytes()[..*width as usize]);
                            }
                            AsmSectionValue::Ref { name, pcrel } => {
                                if !matches!(width, 4 | 8) {
                                    return Err(alloc::string::String::from(
                                        "inline asm: section reference needs a 4- or 8-byte field",
                                    ));
                                }
                                let target = match label_off(name) {
                                    Some(off) => AsmSectionTarget::Text(off),
                                    None => AsmSectionTarget::Symbol(name.clone()),
                                };
                                sec.relocs.push(AsmSectionReloc {
                                    offset: sec.bytes.len() as u32,
                                    width: *width,
                                    pcrel: *pcrel,
                                    target,
                                    addend: 0,
                                });
                                sec.bytes
                                    .extend_from_slice(&[0u8; 8][..*width as usize]);
                            }
                        }
                    }
                }
            }
        }
    }
    Ok(())
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
    let (neg, s) = match s.strip_prefix('-') {
        Some(r) => (true, r),
        None => (false, s),
    };
    let v = if let Some(h) = s.strip_prefix("0x").or_else(|| s.strip_prefix("0X")) {
        i64::from_str_radix(h, 16).ok()?
    } else {
        s.parse::<i64>().ok()?
    };
    Some(if neg { -v } else { v })
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
mod asm_section_tests {
    use super::*;

    #[test]
    fn extract_and_materialize() {
        let text = "1: nop\n.pushsection .discard.t,\"aw\",@progbits\n.balign 8\n.quad 1b\n.long 1b - .\n.long %c0, 7\n.asciz \"hi\"\n.popsection\nnop\n";
        let (code, blocks) = extract_asm_sections(text).unwrap().unwrap();
        assert_eq!(code, "1: nop\nnop\n");
        assert_eq!(blocks.len(), 1);
        assert_eq!(blocks[0].name, ".discard.t");
        assert_eq!(blocks[0].flags, "aw");
        assert_eq!(blocks[0].sh_type.as_deref(), Some("progbits"));
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(
            &blocks,
            &|idx| (idx == 0).then_some(42),
            &|name| (name == "1b").then_some(0x40),
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
                target: AsmSectionTarget::Text(0x40),
                addend: 0
            }
        );
    }

    #[test]
    fn section_previous_and_symbols() {
        // `.section` + `.previous` return to the code stream; an unknown
        // name resolves as a symbol target.
        let text = "nop\n.section .fixup,\"ax\"\n.quad handler\n.previous\nnop\n";
        let (code, blocks) = extract_asm_sections(text).unwrap().unwrap();
        assert_eq!(code, "nop\nnop\n");
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(&blocks, &|_| None, &|_| None, &mut sink).unwrap();
        assert_eq!(
            sink[0].relocs[0].target,
            AsmSectionTarget::Symbol(alloc::string::String::from("handler"))
        );
        // Two blocks naming one section merge; a `.popsection` without a
        // push is rejected.
        let text = ".pushsection .a,\"a\"\n.long 1\n.popsection\n.pushsection .a,\"a\"\n.long 2\n.popsection\n";
        let (_, blocks) = extract_asm_sections(text).unwrap().unwrap();
        let mut sink = alloc::vec::Vec::new();
        materialize_asm_sections(&blocks, &|_| None, &|_| None, &mut sink).unwrap();
        assert_eq!(sink.len(), 1);
        assert_eq!(sink[0].bytes.len(), 8);
        assert!(
            extract_asm_sections(".pushsection .a,\"a\"\n.popsection\n.popsection").is_err()
        );
        // No section directives: the fast path returns None.
        assert!(extract_asm_sections("nop").unwrap().is_none());
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
