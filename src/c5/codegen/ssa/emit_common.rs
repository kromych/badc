//! Cross-target helpers for the SSA emit backends. Holds the
//! pieces of the per-arch lowering that are pure math or pure
//! formatting -- the shape that doesn't depend on a particular
//! ABI or instruction encoding -- so the per-arch modules
//! (`ssa_emit_x86_64.rs`, `ssa_emit_aarch64.rs`) don't carry
//! parallel copies.

use crate::c5::codegen::map_syms::{MapClass, MapMarks};

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
    pub(crate) asm_sections: &'a mut AsmSectionSink,
    /// Branch sites an inline-asm `call`/`jmp` (`bl`/`b`) aimed at a symbol
    /// this unit does not define. The callee's address is a link-time
    /// decision, so each site becomes a call relocation against the name.
    pub(crate) asm_extern_call_sites: &'a mut alloc::vec::Vec<super::UserExternCallSite>,
    /// Function-body inline-asm symbol-operand sites (aarch64 only).
    pub(crate) asm_sym_fixups: &'a mut alloc::vec::Vec<super::AsmSymFixup>,
    /// Alignment the text stream requires in the image, raised by an
    /// inline-asm alignment directive above the section default.
    pub(crate) text_align: &'a mut usize,
    /// Static-initializer data slots holding a `&&label` address,
    /// resolved to text offsets once the function's block layout is
    /// final.
    pub(crate) label_relocs: &'a mut alloc::vec::Vec<super::super::LabelReloc>,
    /// `(offset, len)` of every run of data the backend puts in the text
    /// stream -- an embedded jump table, an inline-asm data directive --
    /// in ascending order. Everything else in the stream is instructions,
    /// so this is what the AArch64 mapping symbols mark.
    pub(crate) text_data_ranges: &'a mut alloc::vec::Vec<(usize, usize)>,
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

/// Page size the stack-allocation step assumes. 4 KiB is the smallest
/// page any supported target uses, so stepping by it also touches every
/// page of a target configured for a larger one.
pub(crate) const STACK_PROBE_PAGE: u32 = 4096;

/// Largest stack-pointer decrement that needs no probe. A stack whose
/// end is protected by a guard region reports an overflow only when the
/// access that oversteps the end lands inside that region; the smallest
/// such region in practice is one page (a Windows thread's guard page, a
/// pthread stack's default guard, a kernel vmap stack's unmapped page).
/// Decrementing by at most `STACK_PROBE_PAGE - 16` from an address the
/// stack still covers leaves the pointer at least 16 bytes above the
/// guard region's base, so both the frame's own stores at non-negative
/// offsets and a nested call's pushed return address fall inside the
/// guard rather than below it. A larger allocation descends in
/// `STACK_PROBE_PAGE` steps and stores through the stack pointer after
/// each one, which is where the fault is taken.
pub(crate) const MAX_UNPROBED_STACK_STEP: u32 = STACK_PROBE_PAGE - 16;

/// Page-walk steps emitted straight-line before switching to a counted
/// loop. A loop needs a scratch register; the straight-line form needs
/// none, so it is the only option where every register is live. Two
/// instructions per step against a loop's fixed overhead put the
/// crossover at a handful of steps.
pub(crate) const STACK_PROBE_UNROLL_MAX: u32 = 4;

/// Largest stack frame the backends can address. Every frame byte
/// offset is emitted as a signed 32-bit displacement -- x86-64 `disp32`,
/// the aarch64 frame-address sequence -- and the prologue's stack
/// adjustment carries the same width, so a larger frame has no
/// representation. gcc reports the equivalent target limit rather than
/// emitting an unrepresentable frame.
pub(crate) const MAX_FRAME_BYTES: u32 = i32::MAX as u32;

/// Byte size of the function's declared local slots, checked against
/// [`MAX_FRAME_BYTES`] before `compute_frame_base` narrows the i64 slot
/// count to `u32`. `Some(bytes)` rejects the function.
pub(crate) fn locals_bytes_over_limit(func: &super::super::ir::FunctionSsa) -> Option<i64> {
    let bytes = func.locals.max(0).saturating_mul(8);
    (bytes > MAX_FRAME_BYTES as i64).then_some(bytes)
}

/// Diagnostic for a frame the target's frame addressing cannot reach.
pub(crate) fn frame_too_large_msg(bytes: i64) -> alloc::string::String {
    alloc::format!("stack frame of {bytes} bytes exceeds the {MAX_FRAME_BYTES}-byte maximum")
}

/// Reject any function whose declared local slots already exceed
/// [`MAX_FRAME_BYTES`], before the optimizer and the per-slot passes walk a
/// frame no backend can emit. The per-function emit re-checks the summed
/// frame, which the inliner can grow past this point.
pub(crate) fn check_frame_limits(
    funcs: &[super::super::ir::FunctionSsa],
) -> Result<(), crate::c5::error::C5Error> {
    for f in funcs {
        if let Some(bytes) = locals_bytes_over_limit(f) {
            return Err(crate::c5::error::C5Error::Compile(alloc::format!(
                "error: function `{name}`: {body}",
                name = f.name,
                body = frame_too_large_msg(bytes),
            )));
        }
    }
    Ok(())
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
    // A parameter a whole-program constant reached keeps no `ParamRef`:
    // its incoming register has no reader, so its cell needs no entry
    // spill for the same reason a seeded one does not.
    for i in 0..64u32 {
        if func.const_params & (1u64 << i) != 0 {
            seeded.insert(i);
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
                    align: d.align,
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
    /// Held at 128 bits so `.octa` carries its full field.
    Const(i128),
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
    /// A general expression over locations -- labels, the location counter
    /// `.`, and constants under the full operator set (`(end - .) / 8`).
    /// Evaluated at materialize time under GNU as value rules: a same-space
    /// difference folds, a lone location or symbol relocates, a base minus a
    /// location of the deposit space is PC-relative.
    LocExpr(alloc::string::String),
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
    /// An alignment directive. `spec` is the byte alignment, or the
    /// expression the layout resolves one from. `fill` is an explicit fill
    /// unit; `None` selects the default (the target NOP in an executable
    /// section, zero otherwise). `max` is the GNU as maximum skip: the
    /// alignment is dropped when it would need more than `max` bytes.
    Align {
        spec: AlignSpec,
        fill: Option<AlignFill>,
        max: Option<u32>,
    },
    /// `.org n[, fill]`: pad to section offset `n` with `fill`, zero by
    /// default.
    Org(u32, u8),
    /// `.org label + expr[, fill]`: pad to a section-local label's offset plus
    /// a constant expression (`.org 2b + %c3`, the `__bug_table` entry size).
    /// The label and expression resolve at materialize time.
    OrgLabel {
        label: alloc::string::String,
        addend: alloc::string::String,
        fill: u8,
    },
    /// `.org expr[, fill]` over locations (`.org . - (664b-663b) +
    /// (662b-661b)`, the alternatives length equalizer): the target offset is
    /// the expression's value, an absolute or a location of this section.
    OrgExpr(alloc::string::String, u8),
    /// `.rept count` whose count reads section labels, deferred past macro
    /// expansion; the body repeats `count` times at layout.
    Rept {
        count: alloc::string::String,
        items: alloc::vec::Vec<AsmSectionItem>,
    },
    /// `.skip` / `.space` / `.zero` / `.fill`: `count` repetitions of the low
    /// `unit` bytes of `value`. `.skip n, f` and `.space n, f` repeat the fill
    /// byte, `.zero n` fixes the value at zero, `.fill r, s, v` gives all
    /// three. GNU as renders the value as the low bytes of a zero-extended
    /// 32-bit number, so a unit above four pads with zeros. `count` is an
    /// expression resolved at materialize time.
    Fill {
        count: alloc::string::String,
        unit: u8,
        value: u32,
    },
    /// `.ascii` / `.asciz` / `.string` payload (NUL included when the
    /// directive appends one).
    Bytes(alloc::vec::Vec<u8>),
    /// `name:`: a label defining a symbol at the current section offset.
    Label(alloc::string::String),
    /// `.globl name` / `.global name`: give the named label external
    /// binding. May precede or follow the label's definition.
    Global(alloc::string::String),
    /// `.local name`: force local binding. A section label is local by
    /// default, so this only cancels a `.globl` on the same name.
    Local(alloc::string::String),
    /// `.hidden` / `.internal` / `.protected name`: the `st_other` visibility.
    /// Visibility is a unit-level property of the name, independent of which
    /// section defines it.
    Visibility {
        name: alloc::string::String,
        vis: crate::c5::program::SymVisibility,
    },
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
    /// `short` is a narrower encoding of the same branch, taken when the
    /// layout finds the target in this section within the short field's
    /// reach.
    CodeBytes {
        bytes: alloc::vec::Vec<u8>,
        relocs: alloc::vec::Vec<AsmSectionReloc>,
        short: Option<AsmShortBranch>,
    },
    /// `.weak name`: weak symbol binding. The materializer marks a label
    /// defined in this statement's sections; a name defined elsewhere in the
    /// unit (or nowhere) is returned to the caller as a unit-level weak name.
    Weak(alloc::string::String),
    /// `.set name, sym` / `.equ name, sym`: `name` aliases the symbol `sym`.
    /// Constant assignments are consumed by the macro expander; only the
    /// symbol-valued form reaches the section parser. Returned to the caller;
    /// the object writer emits the alias at the target's definition.
    SymSet {
        name: alloc::string::String,
        target: alloc::string::String,
    },
    /// `.set name, expr` whose value is an expression over section-local
    /// locations (`.set .Lsz, . - f`) rather than a constant or a plain
    /// symbol. `name` takes the expression's value at the assignment, and
    /// expressions materialized afterwards resolve the name to it.
    SetExpr {
        name: alloc::string::String,
        expr: alloc::string::String,
    },
    /// `.set name, <constant>`, which GNU as records as an absolute symbol.
    /// The expander folds a constant assignment into the expressions that
    /// read it and re-emits the statement only for a name the unit gave
    /// external linkage, which is where the symbol is what a reader needs.
    AbsSet {
        name: alloc::string::String,
        value: i64,
    },
    /// An AArch64 literal pool: the values the `ldr Rt, =value` loads since
    /// the previous flush deposit here. Parsed from `.ltorg` with no entries;
    /// the arch backend assigns them before layout, and also appends one at
    /// the end of each section, which is where GNU as flushes what `.ltorg`
    /// did not.
    LiteralPool(alloc::vec::Vec<AsmPoolEntry>),
    /// A `.if` whose condition reads section labels and whose branches emit
    /// no bytes, so the layout that values the condition cannot depend on the
    /// outcome. Evaluated after layout; the first arm whose condition holds
    /// raises its `.error`.
    CondDiag(alloc::vec::Vec<AsmCondArm>),
    /// A `.cfi_*` directive. It deposits no bytes; the section offset it
    /// reaches is the point its unwind rule takes effect from, so the
    /// materializer records the pair and the frame tables are built from the
    /// unit's whole stream.
    Cfi(super::cfi::CfiOp),
    /// `.reloc offset, TYPE, sym + addend`: a relocation of a named ELF type
    /// at a section-relative offset, deposited without a field of its own.
    Reloc {
        offset: u32,
        rtype: u32,
        target: alloc::string::String,
        addend: i64,
    },
}

/// One branch of a deferred conditional. `tok` is the `.if`-family directive
/// that opened the branch, empty for `.else`; `error` is the diagnostic the
/// branch raises, absent when it raises none.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmCondArm {
    pub tok: alloc::string::String,
    pub cond: alloc::string::String,
    pub error: Option<alloc::string::String>,
}

/// One AArch64 literal-pool entry. `label` is the synthetic symbol the
/// loads' 19-bit displacements resolve against; several loads share an
/// entry when they request the same width and value.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmPoolEntry {
    /// Entry width in bytes: 4, 8, or 16.
    pub size: u8,
    pub label: alloc::string::String,
    pub value: AsmPoolValue,
}

/// A literal-pool entry's value: a constant truncated to the entry width, or
/// a link-time address the entry relocates to.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmPoolValue {
    Const(i128),
    Sym {
        name: alloc::string::String,
        addend: i64,
    },
}

/// Offsets a literal pool's entries take when flushed at `at`, and the
/// offset just past the pool. GNU as deposits the entries in width-ascending
/// groups, keeps first-reference order within a group, and aligns each group
/// to its own width.
pub(crate) fn literal_pool_layout(
    entries: &[AsmPoolEntry],
    at: i64,
) -> (alloc::vec::Vec<i64>, i64) {
    let mut offs = alloc::vec![0i64; entries.len()];
    let mut at = at;
    for size in [4u8, 8, 16] {
        for i in (0..entries.len()).filter(|&i| entries[i].size == size) {
            at += align_gap(at, size as i64, None);
            offs[i] = at;
            at += size as i64;
        }
    }
    (offs, at)
}

/// A parsed `.pushsection` / `.section` block of a template.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSectionBlock {
    pub name: alloc::string::String,
    /// Flag letters from the `"flags"` argument (`a`, `w`, `x`, ...).
    pub flags: alloc::string::String,
    /// `@type` / `%type` argument (`progbits`, `nobits`, ...), if any.
    pub sh_type: Option<alloc::string::String>,
    /// `.subsection` number. Subsections share the section's identity and
    /// space; layout orders a section's blocks by this number, so
    /// subsection 1 lands after every subsection-0 block.
    pub subsection: u32,
    pub items: alloc::vec::Vec<AsmSectionItem>,
}

/// Instruction-field flavor of a section relocation. `Data` is a plain
/// data field described by `pcrel` / `branch` / `signed`; the AArch64
/// kinds name the instruction field the value patches. The PC-relative
/// kinds resolve at materialize time when the target is a local label of
/// the same section (GNU as emits no relocation there; a global or weak
/// name may bind to another definition at link time, so a reference to
/// one keeps its relocation); the page/lo12 kinds always reach the
/// object writer.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum AsmRelocKind {
    #[default]
    Data,
    /// 26-bit branch (`b` / `bl`); `link` selects CALL26 over JUMP26.
    A64Branch26 { link: bool },
    /// 19-bit conditional branch (`b.cond`, `cbz`, `cbnz`).
    A64Condbr19,
    /// 14-bit test-bit branch (`tbz`, `tbnz`).
    A64Tstbr14,
    /// `adr` 21-bit byte displacement.
    A64Adr21,
    /// `adrp` 21-bit page displacement.
    A64AdrpPage21,
    /// `add Rd, Rn, :lo12:sym` low-12 absolute immediate.
    A64AddLo12,
    /// Load/store `:lo12:` scaled immediate; the access size in bytes.
    A64LdstLo12(u8),
    /// `ldr Rt, label` 19-bit literal load displacement.
    A64LdrLit19,
    /// `movz` / `movk` with `:abs_gN[_s|_nc]:` -- one 16-bit group of an
    /// absolute value. `check` is the value width GNU as admits when the
    /// expression folds here; the link applies the ABI's own, which is
    /// wider for the signed forms.
    A64MovwAbs {
        group: u8,
        signed: bool,
        check: Option<u32>,
    },
    /// A relaxable x86 jump displacement (`jmp` / `jcc`). GNU as computes it
    /// while relaxing the branch, which resolves any same-section target
    /// whatever its binding; only a weak one, which the link may rebind,
    /// keeps the long form and its relocation. `call` is not relaxable and
    /// takes `Data`, where a global target does keep its relocation.
    JumpRel,
    /// `.reloc`: the ELF relocation type is named in the source, and the
    /// section deposits no field for it.
    Explicit(u32),
}

impl AsmRelocKind {
    /// Whether the field's value is measured from the field's own address. A
    /// data field carries that on the relocation's `pcrel` flag; an
    /// instruction field carries it in the kind, the page and low-12 forms
    /// being the ones that resolve against a link-time address instead.
    fn self_relative(self) -> bool {
        matches!(
            self,
            AsmRelocKind::A64Branch26 { .. }
                | AsmRelocKind::A64Condbr19
                | AsmRelocKind::A64Tstbr14
                | AsmRelocKind::A64Adr21
                | AsmRelocKind::A64LdrLit19
        )
    }
}

/// A relocation of a materialized section against the object.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSectionReloc {
    /// Byte offset of the field within the section. For an AArch64
    /// instruction kind, the offset of the instruction word.
    pub offset: u32,
    /// Field width in bytes (4 or 8).
    pub width: u8,
    /// Instruction-field flavor; `Data` for a data directive's field.
    pub kind: AsmRelocKind,
    /// PC-relative (`ref - .`) rather than absolute.
    pub pcrel: bool,
    /// A branch reloc reaching its symbol through the PLT slot
    /// (`R_X86_64_PLT32`) rather than a plain PC-relative data reference
    /// (`R_X86_64_PC32`). Set for a replacement instruction's direct
    /// `call` / `jmp` to a symbol; a data reference leaves it clear.
    pub branch: bool,
    /// A sign-extended absolute 32-bit field (`R_X86_64_32S`) rather than the
    /// zero-extended `R_X86_64_32` a data directive takes. Set for a `push
    /// $symbol` immediate, whose imm32 the CPU sign-extends. Only meaningful
    /// for an absolute 4-byte x86_64 field.
    pub signed: bool,
    pub target: AsmSectionTarget,
    pub addend: i64,
}

/// An instruction's short encoding, supplied by the arch encoder next to the
/// long one. The two differ only in one field's width, so a single
/// relocation describes the short form; the layout selects it when the
/// narrow field holds what the field resolves to -- a branch whose target is
/// a label of its own section, or an immediate whose expression folds. GNU
/// as makes the same choice by the same rule.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmShortBranch {
    pub bytes: alloc::vec::Vec<u8>,
    pub reloc: AsmSectionReloc,
}

/// Relocation target of a section field.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSectionTarget {
    /// A byte offset into the emitted text (a resolved template label).
    Text(usize),
    /// A named symbol.
    Symbol(alloc::string::String),
    /// An expression over symbols and labels written in an instruction
    /// operand (`$(sym - base)`, `(sym - 1b)(%ecx)`). Evaluated where the
    /// section materializes and the layout is known: a result with no
    /// symbolic term left is folded into the field, one with a symbol
    /// becomes a relocation against it. It never reaches the object writer.
    Expr(alloc::string::String),
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
    /// A byte offset within the section the relocation itself lives in
    /// (`.quad .`): the writer resolves it against that section's own
    /// symbol.
    OwnSection(u32),
    /// The start of a named section, by its identity key: a bare section
    /// name used as a symbol. The writer resolves it against that
    /// section's own symbol.
    SectionStart(alloc::string::String),
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

/// The address space a location-valued expression term lives in; two terms
/// fold to a constant difference only when they share one. Distinguishes the
/// emitted text stream, a deferred replacement region, and a named section.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSpace {
    Text,
    Deferred(u32),
    /// A named section, by its `(name, flags, sh_type)` key.
    Section(alloc::string::String),
}

/// One symbolic term of an expression value: where the location lives when
/// it is laid out in this unit (`None` for an undefined symbol), and the
/// relocation target a field referencing it takes. The offset participates
/// in same-space folding only; a relocation's addend never includes it,
/// because the target itself carries the position.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmExprTerm {
    pub space: Option<(AsmSpace, i64)>,
    pub target: AsmSectionTarget,
}

/// An assembler expression value, as GNU as models it: a constant plus at
/// most one added and one subtracted symbolic base. Same-space bases cancel
/// into the constant; any richer combination is rejected.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmExprValue {
    add: i64,
    pos: Option<AsmExprTerm>,
    neg: Option<AsmExprTerm>,
}

impl AsmExprValue {
    /// The symbol this value names when it is a single term with nothing
    /// subtracted from it -- the shape whose PC-relativity comes from the
    /// encoding rather than from a difference written in the source.
    fn lone_symbol(&self) -> Option<&str> {
        match (&self.pos, &self.neg) {
            (Some(t), None) => match &t.target {
                AsmSectionTarget::Symbol(n) => Some(n.as_str()),
                _ => None,
            },
            _ => None,
        }
    }

    /// The constant part of the value.
    fn constant(&self) -> i64 {
        self.add
    }
}

/// The constant distance from `n` to `p`: locations of one space differ by
/// their offsets, two references to one undefined symbol cancel.
fn term_distance(p: &AsmExprTerm, n: &AsmExprTerm) -> Option<i64> {
    match (&p.space, &n.space) {
        (Some((ps, po)), Some((ns, no))) if ps == ns => Some(po - no),
        (None, None) if p.target == n.target => Some(0),
        _ => None,
    }
}

/// A resolved leaf of an expression: an absolute value (a literal, an
/// operand constant, a `.set` symbol) or a location-valued term.
pub(crate) enum AsmExprLeaf {
    Abs(i64),
    Loc(AsmExprTerm),
}

/// Leaf resolution for [`eval_asm_value`]. `resolve` answers identifiers and
/// the location counter `"."`; an unresolved identifier is an undefined
/// symbol. `const_of` answers `%N` operand references. `lax_div` folds a
/// division or remainder by zero to zero instead of failing, for the
/// parse-time syntax check that runs with placeholder leaf values.
pub(crate) struct AsmExprCtx<'a> {
    pub resolve: &'a dyn Fn(&str) -> Option<AsmExprLeaf>,
    pub const_of: &'a dyn Fn(u8) -> Option<i64>,
    pub lax_div: bool,
}

/// What a fully evaluated expression deposits: a folded constant, or a
/// relocation with the addend the object writer applies on top of the
/// target's own position.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmResolved {
    Abs(i64),
    Reloc {
        target: AsmSectionTarget,
        addend: i64,
        pcrel: bool,
    },
}

/// What an instruction field's expression target resolves to against the
/// layout. `pcrel` is `None` where the encoding's own PC-relativity stands:
/// the reference names a symbol the link binds, so the field keeps the
/// relocation the encoding asked for.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmFieldTarget {
    Abs(i64),
    Reloc {
        target: AsmSectionTarget,
        addend: i64,
        pcrel: Option<bool>,
    },
}

impl AsmExprValue {
    fn abs(v: i64) -> Self {
        AsmExprValue {
            add: v,
            pos: None,
            neg: None,
        }
    }
    fn from_term(t: AsmExprTerm) -> Self {
        AsmExprValue {
            add: 0,
            pos: Some(t),
            neg: None,
        }
    }
    pub(crate) fn to_abs(&self) -> Option<i64> {
        (self.pos.is_none() && self.neg.is_none()).then_some(self.add)
    }
    /// Combine `self + rhs` (`self - rhs` when `sub`), cancelling a positive
    /// against a negative base defined in one space.
    fn combine(mut self, rhs: Self, sub: bool) -> Result<Self, alloc::string::String> {
        let (rpos, rneg) = if sub {
            (rhs.neg, rhs.pos)
        } else {
            (rhs.pos, rhs.neg)
        };
        self.add = self
            .add
            .checked_add(if sub {
                rhs.add.checked_neg().ok_or("overflow")?
            } else {
                rhs.add
            })
            .ok_or("overflow in expression")?;
        let place = |slot: &mut Option<AsmExprTerm>,
                     t: Option<AsmExprTerm>|
         -> Result<(), alloc::string::String> {
            match t {
                None => Ok(()),
                Some(t) if slot.is_none() => {
                    *slot = Some(t);
                    Ok(())
                }
                Some(_) => Err(alloc::string::String::from(
                    "expression combines two symbols",
                )),
            }
        };
        place(&mut self.pos, rpos)?;
        place(&mut self.neg, rneg)?;
        // A positive and a negative location in one space are a constant
        // distance; fold them so the bases free up. Two references to one
        // undefined symbol cancel outright (GNU as folds `x - x`, which is
        // what lets `.if \base == %rsp` compare register text).
        if let (Some(p), Some(n)) = (&self.pos, &self.neg)
            && let Some(delta) = term_distance(p, n)
        {
            self.add += delta;
            self.pos = None;
            self.neg = None;
        }
        Ok(self)
    }
}

/// Resolve an evaluated expression at its deposit point. `deposit` names the
/// space and offset the value lands at; a subtracted base defined in that
/// space makes the result PC-relative (`ref - .`), with the distance between
/// the base and the field folded into the addend.
pub(crate) fn resolve_asm_value(
    v: AsmExprValue,
    deposit: Option<(&AsmSpace, i64)>,
) -> Result<AsmResolved, alloc::string::String> {
    match (v.pos, v.neg) {
        (None, None) => Ok(AsmResolved::Abs(v.add)),
        (Some(p), None) => Ok(AsmResolved::Reloc {
            target: p.target,
            addend: v.add,
            pcrel: false,
        }),
        (Some(p), Some(n)) => {
            let Some((dspace, doff)) = deposit else {
                return Err(alloc::string::String::from(
                    "expression subtracts a symbol outside a data field",
                ));
            };
            match n.space {
                Some((ns, no)) if ns == *dspace => Ok(AsmResolved::Reloc {
                    target: p.target,
                    addend: v.add + (doff - no),
                    pcrel: true,
                }),
                Some(_) => Err(alloc::string::String::from(
                    "label difference crosses sections and is not PC-relative",
                )),
                None => Err(alloc::string::String::from(
                    "expression subtracts an undefined symbol",
                )),
            }
        }
        (None, Some(_)) => Err(alloc::string::String::from(
            "expression subtracts a symbol from a constant",
        )),
    }
}

/// Resolve an instruction field's expression target at `place` in `space`:
/// the expression plus the encoding's own addend, made PC-relative where the
/// field measures from itself. GNU as folds a difference of symbols whatever
/// their binding, but a lone symbol the link binds keeps its relocation, so
/// naming it leaves the encoding's PC-relativity in place.
pub(crate) fn resolve_asm_field_expr(
    text: &str,
    ctx: &AsmExprCtx,
    space: &AsmSpace,
    place: i64,
    addend: i64,
    self_rel: bool,
    non_local: &alloc::collections::BTreeSet<alloc::string::String>,
) -> Result<AsmFieldTarget, alloc::string::String> {
    let named = |e: alloc::string::String| alloc::format!("inline asm: `{text}`: {e}");
    let mut v = eval_asm_value(text, ctx)
        .and_then(|v| v.combine(AsmExprValue::abs(addend), false))
        .map_err(named)?;
    if let Some(n) = v.lone_symbol().filter(|n| non_local.contains(*n)) {
        return Ok(AsmFieldTarget::Reloc {
            target: AsmSectionTarget::Symbol(alloc::string::String::from(n)),
            addend: v.constant(),
            pcrel: None,
        });
    }
    if self_rel {
        v = v
            .combine(
                AsmExprValue::from_term(AsmExprTerm {
                    space: Some((space.clone(), place)),
                    target: AsmSectionTarget::OwnSection(place as u32),
                }),
                true,
            )
            .map_err(named)?;
    }
    Ok(
        match resolve_asm_value(v, Some((space, place))).map_err(named)? {
            AsmResolved::Abs(c) => AsmFieldTarget::Abs(c),
            AsmResolved::Reloc {
                target,
                addend,
                pcrel,
            } => AsmFieldTarget::Reloc {
                target,
                addend,
                pcrel: Some(pcrel),
            },
        },
    )
}

/// Split an operand expression into one symbol and a constant addend. This
/// is what a field outside a materialized section can carry: the in-function
/// relocation channels name a symbol and an offset, with no layout to fold a
/// label difference against. `None` for any richer expression.
pub(crate) fn asm_expr_sym_addend(expr: &str) -> Option<(alloc::string::String, i64)> {
    let ctx = AsmExprCtx {
        resolve: &|_| None,
        const_of: &|_| None,
        lax_div: false,
    };
    match resolve_asm_value(eval_asm_value(expr, &ctx).ok()?, None).ok()? {
        AsmResolved::Reloc {
            target: AsmSectionTarget::Symbol(name),
            addend,
            pcrel: false,
        } => Some((name, addend)),
        _ => None,
    }
}

/// Patch a PC-relative instruction field whose target resolved within the
/// section, so no relocation is emitted (as GNU as resolves same-section
/// fixups). `disp` is target plus addend minus the field's own offset.
/// Returns `false` for a kind that must keep its relocation: an absolute
/// data field, and the page / lo12 forms whose value is a link-time
/// address.
pub(crate) fn patch_asm_insn_field(
    buf: &mut [u8],
    at: usize,
    kind: AsmRelocKind,
    pcrel: bool,
    width: u8,
    disp: i64,
) -> Result<bool, alloc::string::String> {
    let words = |bits: u32| -> Result<u32, alloc::string::String> {
        if disp % 4 != 0 {
            return Err(alloc::string::String::from(
                "inline asm: branch target is not word-aligned",
            ));
        }
        let w = disp / 4;
        let lim = 1i64 << (bits - 1);
        if !(-lim..lim).contains(&w) {
            return Err(alloc::string::String::from(
                "inline asm: branch target out of range",
            ));
        }
        Ok((w as u32) & ((1u32 << bits) - 1))
    };
    let or_word = |buf: &mut [u8], v: u32| {
        let w = u32::from_le_bytes(buf[at..at + 4].try_into().expect("4-byte field")) | v;
        buf[at..at + 4].copy_from_slice(&w.to_le_bytes());
    };
    match kind {
        // A same-section PC-relative reference resolves here, at whatever
        // width the field is: 2 bytes for a `.code16` near branch, 1 for a
        // short one. Leaving it to a relocation would work but would put
        // one in the object for a distance the assembler already knows.
        AsmRelocKind::Data | AsmRelocKind::JumpRel if pcrel && matches!(width, 1 | 2 | 4) => {
            let w = width as usize;
            let lim = 1i64 << (8 * w - 1);
            if !(-lim..lim).contains(&disp) {
                return Err(alloc::string::String::from(
                    "inline asm: PC-relative field out of range",
                ));
            }
            buf[at..at + w].copy_from_slice(&disp.to_le_bytes()[..w]);
            Ok(true)
        }
        AsmRelocKind::Data | AsmRelocKind::JumpRel => Ok(false),
        AsmRelocKind::A64Branch26 { .. } => {
            or_word(buf, words(26)?);
            Ok(true)
        }
        AsmRelocKind::A64Condbr19 | AsmRelocKind::A64LdrLit19 => {
            or_word(buf, words(19)? << 5);
            Ok(true)
        }
        AsmRelocKind::A64Tstbr14 => {
            or_word(buf, words(14)? << 5);
            Ok(true)
        }
        AsmRelocKind::A64Adr21 => {
            if !(-(1i64 << 20)..(1i64 << 20)).contains(&disp) {
                return Err(alloc::string::String::from(
                    "inline asm: `adr` target out of range",
                ));
            }
            let d = disp as u32;
            or_word(buf, ((d & 3) << 29) | (((d >> 2) & 0x7_FFFF) << 5));
            Ok(true)
        }
        // `.reloc` names no field, so there is nothing to patch and the
        // relocation always reaches the object writer.
        AsmRelocKind::A64AdrpPage21
        | AsmRelocKind::A64AddLo12
        | AsmRelocKind::A64LdstLo12(_)
        | AsmRelocKind::A64MovwAbs { .. }
        | AsmRelocKind::Explicit(_) => Ok(false),
    }
}

/// Store the constant an operand expression folded to into its field, the
/// relocation the field would otherwise have taken standing for its width
/// and flavor. A `Data` field takes the value little-endian at its own
/// width; an instruction-field kind takes the same encoding a PC-relative
/// patch writes, the field being the same one. A kind whose value is a
/// link-time address has no constant form and is rejected rather than
/// encoded wrong.
pub(crate) fn store_asm_insn_const(
    buf: &mut [u8],
    at: usize,
    r: &AsmSectionReloc,
    v: i64,
) -> Result<(), alloc::string::String> {
    if r.kind == AsmRelocKind::Data {
        if !value_fits_width(v, r.width) {
            return Err(alloc::format!(
                "value {v} does not fit a {}-byte field",
                r.width
            ));
        }
        let w = r.width as usize;
        buf[at..at + w].copy_from_slice(&v.to_le_bytes()[..w]);
        return Ok(());
    }
    // A MOVW group has a constant form: the value's own group goes in the
    // immediate, as GNU as resolves it when the expression folds. The
    // checked forms reject a value outside the width the specifier names.
    if let AsmRelocKind::A64MovwAbs {
        group,
        signed,
        check,
    } = r.kind
    {
        use crate::c5::codegen::aarch64::patch;
        let word = u32::from_le_bytes(buf[at..at + 4].try_into().expect("4-byte field"));
        let word = patch::movw_const_word(word, group, signed, check, v)?;
        buf[at..at + 4].copy_from_slice(&word.to_le_bytes());
        return Ok(());
    }
    patch_asm_insn_field(buf, at, r.kind, true, r.width, v)?
        .then_some(())
        .ok_or_else(|| alloc::string::String::from("expression has no constant form in this field"))
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
    /// Whether the section's last byte-emitting item was an instruction.
    /// x86 alignment padding depends on it (see
    /// [`push_x86_exec_align_fill`]); the state carries across the blocks
    /// that merge into one section. A fresh section starts at the
    /// assembler's section-start boundary.
    pub after_insn: bool,
    /// The mapping state GNU as tracks per section: none before any
    /// content, then data or instructions. On AArch64 an instruction
    /// emitted while it is data is aligned to 4 first.
    pub map_state: Option<MapClass>,
    /// Code / data run starts, for the AArch64 mapping symbols the object
    /// writer emits.
    pub map: MapMarks,
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

/// Binding a symbol directive requests; `Default` leaves the symbol's own.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum AsmSymBind {
    #[default]
    Default,
    Global,
    Local,
    Weak,
}

/// The value a `.set` / `.equ` / `.equiv` outside any section assigned: a
/// constant, which binds the name `SHN_ABS`, or another symbol, whose
/// definition the name takes.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSymValue {
    Abs(i64),
    Sym(alloc::string::String),
}

/// A symbol directive an asm template carried outside any section. GNU as
/// scopes `.globl` / `.local` / `.weak` / `.type` / `.size` and the
/// assignments to the unit, so the name may be defined by this template's
/// code stream, by another statement's section, by C, or by nothing in the
/// unit. TODO `.globl` on a C symbol of the unit: the linkage split is
/// decided from the parse, which a function-scope template runs after. The
/// file-scope parse applies it.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub(crate) struct AsmSymDecl {
    pub name: alloc::string::String,
    pub bind: AsmSymBind,
    pub sym_type: AsmSymType,
    pub size: Option<u64>,
    /// Assigned value, when a `.set` family directive named it.
    pub value: Option<AsmSymValue>,
}

/// A label defined inside a named section.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub(crate) struct AsmSectionLabel {
    pub name: alloc::string::String,
    /// Byte offset of the definition within the section's own bytes.
    pub offset: u32,
    /// `.globl`-declared: external rather than local binding.
    pub global: bool,
    /// `.weak`-declared: weak rather than global or local binding.
    pub weak: bool,
    /// Symbol type from a `.type` directive (`STT_NOTYPE` when absent).
    pub sym_type: AsmSymType,
    /// `st_size` from a `.size` directive; `None` leaves it zero.
    pub size: Option<u64>,
    /// Value of a `.set` / `=` assignment that folded to a constant. The
    /// symbol is `SHN_ABS` and `offset` does not apply, as in GNU as.
    pub absolute: Option<i64>,
}

/// A snapshot of the accumulated section sink, taken before a function
/// body is laid out. `materialize_asm_sections` merges into existing
/// sections, so a branch-relaxation re-emit or a bailed emit needs to
/// undo the merge; a plain length truncation of the outer vector would
/// leave the appended bytes / relocs / labels in a pre-existing section.
pub(crate) struct AsmSectionsSnapshot {
    len: usize,
    /// The declarations verbatim: a merge onto an entry that predates the
    /// snapshot is not undone by a length truncation.
    decls: alloc::vec::Vec<AsmSymDecl>,
    /// Recorded `.cfi_*` directives at the snapshot, so a re-laid-out
    /// function does not describe its frame twice.
    cfi: usize,
    /// Per section: bytes, relocs, labels, alignment, instruction-boundary
    /// state, mapping state.
    per_section: alloc::vec::Vec<(usize, usize, usize, u32, bool, Option<MapClass>)>,
}

/// The accumulated inline-asm sections and the indexes that make a lookup
/// against them independent of how much the sink already holds. A unit's
/// file-scope asm can push a uniquely named section and a label per
/// exported symbol -- modpost's `.vmlinux.export.c` pushes tens of
/// thousands of both -- and every [`materialize_asm_sections`] call has to
/// resolve a section identity and the labels earlier calls defined, so
/// scanning the sink for either makes a unit quadratic in its own asm.
#[derive(Debug, Default)]
pub(crate) struct AsmSectionSink {
    sections: alloc::vec::Vec<AsmSection>,
    /// `(name, flags, sh_type)` identity -> index into `sections`.
    by_key: hashbrown::HashMap<alloc::string::String, usize>,
    /// Label name -> its section's identity key and its offset there.
    /// Carries only labels of completed calls: that is what a call's
    /// location expressions resolve against, its own coming from the
    /// measurement. Keyed by identity rather than index so a lookup stays
    /// disjoint from a mutable borrow of the section being laid out.
    labels: AsmSinkLabels,
    /// Unit-level symbol declarations the unit's templates made outside any
    /// section, merged by name. Applied by the object writer, which is where
    /// every definition the unit holds is known.
    sym_decls: alloc::vec::Vec<AsmSymDecl>,
    /// `.cfi_*` directives in the order the unit wrote them, each carrying
    /// the section and offset it reached. Turned into frame tables by
    /// [`Self::emit_cfi_sections`] once every section is laid out.
    cfi: alloc::vec::Vec<super::cfi::CfiRecord>,
}

/// Label name -> (owning section's identity key, offset within it).
pub(crate) type AsmSinkLabels =
    hashbrown::HashMap<alloc::string::String, (alloc::string::String, i64)>;

impl core::ops::Deref for AsmSectionSink {
    type Target = [AsmSection];

    fn deref(&self) -> &[AsmSection] {
        &self.sections
    }
}

impl AsmSectionSink {
    /// Mutable access for the relocation-retarget passes. Section identity
    /// and the label lists are indexed, so a caller must not add, remove,
    /// or rename either through this.
    pub(crate) fn relocs_mut(&mut self) -> &mut [AsmSection] {
        &mut self.sections
    }

    /// The accumulated sections and unit-level symbol declarations, for the
    /// object writers. The indexes serve materialization only and are
    /// dropped with the sink.
    pub(crate) fn into_parts(self) -> (alloc::vec::Vec<AsmSection>, alloc::vec::Vec<AsmSymDecl>) {
        (self.sections, self.sym_decls)
    }

    /// Append the frame tables the unit's `.cfi_*` directives describe. Runs
    /// once every section is laid out, since an FDE spans a code range whose
    /// end the closing directive fixes.
    pub(crate) fn emit_cfi_sections(
        &mut self,
        target: super::cfi::CfiTarget,
    ) -> Result<(), alloc::string::String> {
        if self.cfi.is_empty() {
            return Ok(());
        }
        let built = super::cfi::build_cfi_sections(&self.cfi, target)?;
        for s in built {
            let key = section_key_of(&s);
            self.by_key.insert(key, self.sections.len());
            self.sections.push(s);
        }
        Ok(())
    }

    /// Merge the symbol directives a template carried outside any section
    /// into the unit's declarations, later directives on a name winning.
    /// A `.size` needs a section's layout to value `.`, so one here must
    /// fold to a constant. TODO `.size` over code-stream labels.
    pub(crate) fn push_sym_decls(
        &mut self,
        items: &[AsmSectionItem],
    ) -> Result<(), alloc::string::String> {
        for item in items {
            let (name, bind, sym_type, size, value) = match item {
                AsmSectionItem::Global(n) => {
                    (n, AsmSymBind::Global, AsmSymType::NoType, None, None)
                }
                AsmSectionItem::Local(n) => (n, AsmSymBind::Local, AsmSymType::NoType, None, None),
                AsmSectionItem::Weak(n) => (n, AsmSymBind::Weak, AsmSymType::NoType, None, None),
                AsmSectionItem::Type { name, sym_type } => {
                    (name, AsmSymBind::Default, *sym_type, None, None)
                }
                AsmSectionItem::Size { name, expr } => {
                    let ctx = AsmExprCtx {
                        resolve: &|_| None,
                        const_of: &|_| None,
                        lax_div: false,
                    };
                    let v = eval_asm_value(expr, &ctx)
                        .ok()
                        .and_then(|v| v.to_abs())
                        .filter(|v| *v >= 0)
                        .ok_or_else(|| {
                            alloc::format!(
                                "inline asm: `.size {name}, {expr}` outside a section needs a \
                                 constant size"
                            )
                        })?;
                    (
                        name,
                        AsmSymBind::Default,
                        AsmSymType::NoType,
                        Some(v as u64),
                        None,
                    )
                }
                // An assignment defines the name for the unit: a constant
                // binds it `SHN_ABS`, a symbol makes it that symbol's alias.
                AsmSectionItem::AbsSet { name, value } => (
                    name,
                    AsmSymBind::Default,
                    AsmSymType::NoType,
                    None,
                    Some(AsmSymValue::Abs(*value)),
                ),
                AsmSectionItem::SymSet { name, target } => (
                    name,
                    AsmSymBind::Default,
                    AsmSymType::NoType,
                    None,
                    Some(AsmSymValue::Sym(target.clone())),
                ),
                // Outside a section there is no layout to value a location
                // expression against, so one here must fold to a constant.
                AsmSectionItem::SetExpr { name, expr } => {
                    let ctx = AsmExprCtx {
                        resolve: &|_| None,
                        const_of: &|_| None,
                        lax_div: false,
                    };
                    let v = eval_asm_value(expr, &ctx)
                        .ok()
                        .and_then(|v| v.to_abs())
                        .ok_or_else(|| {
                            alloc::format!(
                                "inline asm: `.set {name}, {expr}` outside a section needs a \
                                 constant value"
                            )
                        })?;
                    (
                        name,
                        AsmSymBind::Default,
                        AsmSymType::NoType,
                        None,
                        Some(AsmSymValue::Abs(v)),
                    )
                }
                // `.set .,` moves the location counter of the section it sits
                // in; the code stream's is the enclosing function's, which the
                // arch backend lays out.
                AsmSectionItem::Org(..)
                | AsmSectionItem::OrgLabel { .. }
                | AsmSectionItem::OrgExpr(..) => {
                    return Err(alloc::string::String::from(
                        "inline asm: `.set .` outside a section",
                    ));
                }
                _ => continue,
            };
            let d = match self.sym_decls.iter().position(|d| d.name == *name) {
                Some(i) => &mut self.sym_decls[i],
                None => {
                    self.sym_decls.push(AsmSymDecl {
                        name: name.clone(),
                        ..Default::default()
                    });
                    self.sym_decls.last_mut().expect("just pushed")
                }
            };
            if bind != AsmSymBind::Default {
                d.bind = bind;
            }
            if sym_type != AsmSymType::NoType {
                d.sym_type = sym_type;
            }
            if size.is_some() {
                d.size = size;
            }
            if value.is_some() {
                d.value = value;
            }
        }
        Ok(())
    }

    /// Index of the section carrying `b`'s identity, if the sink has one.
    fn index_of(&self, b: &AsmSectionBlock) -> Option<usize> {
        self.by_key.get(&section_key(b)).copied()
    }

    /// Index of `b`'s section, appending an empty one when the sink holds
    /// no section of that identity yet.
    fn get_or_insert(&mut self, b: &AsmSectionBlock) -> usize {
        let key = section_key(b);
        if let Some(&i) = self.by_key.get(&key) {
            return i;
        }
        self.sections.push(AsmSection {
            name: b.name.clone(),
            flags: b.flags.clone(),
            sh_type: b.sh_type.clone(),
            bytes: alloc::vec::Vec::new(),
            relocs: alloc::vec::Vec::new(),
            labels: alloc::vec::Vec::new(),
            align: 1,
            after_insn: true,
            map_state: None,
            map: MapMarks::default(),
        });
        let i = self.sections.len() - 1;
        self.by_key.insert(key, i);
        i
    }

    /// Publish the labels section `sec_idx` gained past `from`, so the next
    /// call resolves them. Runs once a call's pending entries are settled.
    fn publish_labels(&mut self, sec_idx: usize, from: usize) {
        let sec = &self.sections[sec_idx];
        let key = section_key_of(sec);
        for l in &sec.labels[from..] {
            self.labels
                .insert(l.name.clone(), (key.clone(), l.offset as i64));
        }
    }

    /// Record the sink's outer length and each existing section's bytes,
    /// relocs, labels, alignment, and instruction-boundary state.
    pub(crate) fn snapshot(&self) -> AsmSectionsSnapshot {
        AsmSectionsSnapshot {
            len: self.sections.len(),
            decls: self.sym_decls.clone(),
            cfi: self.cfi.len(),
            per_section: self
                .sections
                .iter()
                .map(|s| {
                    (
                        s.bytes.len(),
                        s.relocs.len(),
                        s.labels.len(),
                        s.align,
                        s.after_insn,
                        s.map_state,
                    )
                })
                .collect(),
        }
    }

    /// Restore the sink to a prior [`AsmSectionSink::snapshot`]: drop
    /// sections created since, and truncate each pre-existing section's
    /// contents. The indexes shed exactly what the truncation drops. A
    /// snapshot the sink has already shrunk past restores nothing, so a
    /// caller may restore the same one more than once.
    pub(crate) fn restore(&mut self, snap: &AsmSectionsSnapshot) {
        if self.sym_decls.len() >= snap.decls.len() {
            self.sym_decls.clone_from(&snap.decls);
        }
        self.cfi.truncate(snap.cfi.min(self.cfi.len()));
        for s in self.sections.drain(snap.len.min(self.sections.len())..) {
            self.by_key.remove(&section_key_of(&s));
            for l in &s.labels {
                self.labels.remove(&l.name);
            }
        }
        for (s, &(bytes, relocs, labels, align, after_insn, map_state)) in
            self.sections.iter_mut().zip(&snap.per_section)
        {
            s.bytes.truncate(bytes);
            s.map.truncate(bytes);
            s.relocs.truncate(relocs);
            for l in s.labels.drain(labels.min(s.labels.len())..) {
                self.labels.remove(&l.name);
            }
            s.align = align;
            s.after_insn = after_insn;
            s.map_state = map_state;
        }
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
            .map_or(0, |&(_, relocs, _, _, _, _)| relocs);
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
            .map_or(0, |&(_, relocs, _, _, _, _)| relocs);
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
    for piece in split_asm_statements(text) {
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

/// One `.macro` parameter: its name, the `=default` bound when the
/// invocation supplies no argument, and whether `:vararg` makes it swallow
/// the remaining argument text.
#[derive(Clone)]
struct GasParam {
    name: alloc::string::String,
    default: alloc::string::String,
    vararg: bool,
}

type GasParams = alloc::vec::Vec<GasParam>;

/// A local macro defined by `.macro` inside one inline-asm block.
struct GasMacro {
    params: GasParams,
    body: alloc::vec::Vec<alloc::string::String>,
}

const GAS_MACRO_DEPTH_LIMIT: usize = 64;

/// Expand the GNU as macro directives an inline-asm block uses to generate
/// instructions: `.rept`/`.rep`/`.irp`/`.irpc`/`.endr` (repeat),
/// `.macro`/`.endm`/`.purgem`
/// (local macro definition, invocation, removal), `.equ`/`.set` (symbol
/// assignment), and `.inst` (emit an `inst_width`-byte instruction word).
/// `.inst` expressions fold to a `.byte` run, macro invocations to their
/// expanded bodies, and `.equ` symbols resolve in every expression. `None`
/// when the template uses none of these (the common case).
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
        || text.contains(".rep")
        || text.contains(".macro")
        || text.contains(".inst")
        || text.contains(".equ")
        || text.contains(".set")
        || text.contains(".purgem")
        || text.contains(".req")
        || text.contains(".if")
        || has_gas_assignment(text))
    {
        return Ok(None);
    }
    let substituted = subst_asm_operands(text, subst);
    let stmts: alloc::vec::Vec<alloc::string::String> = split_asm_statements(&substituted)
        .into_iter()
        .map(|s| alloc::string::String::from(s.trim()))
        .collect();
    let mut st = GasExpandState {
        exported: gas_exported_names(&stmts),
        forward_set: gas_forward_set_names(&stmts),
        ..Default::default()
    };
    let mut out = alloc::string::String::with_capacity(text.len());
    expand_gas_statements(&stmts, &mut st, &mut out, inst_width, 0)?;
    Ok(Some(out))
}

/// State a macro expansion carries and mutates: the macro table, `.equ`
/// values, `.req` register aliases, and whether `.altmacro` is in effect.
/// Nested expansions share one instance, so a definition or a mode change
/// inside a macro body is visible to what it invokes.
#[derive(Default)]
struct GasExpandState {
    macros: alloc::collections::BTreeMap<alloc::string::String, GasMacro>,
    equ: alloc::collections::BTreeMap<alloc::string::String, i64>,
    aliases: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    altmacro: bool,
    /// Names the unit declares `.globl` / `.global` / `.weak`. A folded
    /// `.set` over one of them stays in the stream so the section parse
    /// defines the absolute symbol the declaration promises; folding it
    /// away would leave the declaration naming nothing.
    exported: alloc::collections::BTreeSet<alloc::string::String>,
    /// Names an earlier statement read before any `.set` assigned them.
    /// Folding such an assignment away would leave that read naming nothing,
    /// so it stays in the stream for the section layer to define.
    forward_set: alloc::collections::BTreeSet<alloc::string::String>,
    /// Names defined by the statements expanded so far, which is what
    /// `.ifdef` answers against: a label, an assignment, or a common block,
    /// in any section, taken only from branches that emit. A declaration
    /// (`.globl`) or a reference to an undefined name defines nothing.
    defined: alloc::collections::BTreeSet<alloc::string::String>,
}

impl GasExpandState {
    /// Re-emit a folded assignment whose name a reader still needs: one with
    /// external linkage, or one an earlier statement already referenced.
    fn keep_exported_set(&self, name: &str, value: i64, out: &mut alloc::string::String) {
        if self.exported.contains(name) || self.forward_set.contains(name) {
            out.push_str(&alloc::format!(".set {name}, {value}\n"));
        }
    }
}

/// Names a statement reads before any `.set` / `.equ` assigns them. The
/// expander has no value to substitute at such a read, so it passes the name
/// through and the later assignment has to stay in the stream to define it.
/// A reassignment is not one of these: every read after the first assignment
/// folds, so re-emitting it would put a directive in a stream that only holds
/// instructions.
fn gas_forward_set_names(
    stmts: &[alloc::string::String],
) -> alloc::collections::BTreeSet<alloc::string::String> {
    let ident = |c: char| c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$');
    let mut used: alloc::collections::BTreeSet<&str> = alloc::collections::BTreeSet::new();
    let mut assigned: alloc::collections::BTreeSet<&str> = alloc::collections::BTreeSet::new();
    let mut out = alloc::collections::BTreeSet::new();
    for s in stmts {
        let (_, body) = split_leading_labels(s);
        let (tok, rest) = split_first_token(body);
        if matches!(tok, ".equ" | ".set" | ".equiv")
            && let Some((sym, _)) = rest.split_once(',')
        {
            let sym = sym.trim();
            if used.contains(sym) && !assigned.contains(sym) {
                out.insert(alloc::string::String::from(sym));
            }
            assigned.insert(sym);
        }
        used.extend(body.split(|c: char| !ident(c)).filter(|t| !t.is_empty()));
    }
    out
}

/// The `.globl` / `.global` / `.weak` names a statement list declares.
fn gas_exported_names(
    stmts: &[alloc::string::String],
) -> alloc::collections::BTreeSet<alloc::string::String> {
    let mut out = alloc::collections::BTreeSet::new();
    for s in stmts {
        let (_, s) = split_leading_labels(s);
        let (tok, rest) = split_first_token(s);
        if matches!(tok, ".globl" | ".global" | ".weak") {
            for name in rest.split(',') {
                let name = name.trim();
                if is_asm_symbol_name(name) {
                    out.insert(alloc::string::String::from(name));
                }
            }
        }
    }
    out
}

fn expand_gas_statements(
    stmts: &[alloc::string::String],
    st: &mut GasExpandState,
    out: &mut alloc::string::String,
    inst_width: usize,
    depth: usize,
) -> Result<(), alloc::string::String> {
    if depth > GAS_MACRO_DEPTH_LIMIT {
        return Err(alloc::string::String::from(
            "inline asm: macro expansion nested too deep",
        ));
    }
    // Conditional-assembly stack, evaluated as the macro expands so a `.ifc` /
    // `.if` can test a `.set` symbol or a substituted operand: each frame is
    // (this branch emits, some branch already taken).
    let mut cond: alloc::vec::Vec<(bool, bool)> = alloc::vec::Vec::new();
    let emitting = |c: &[(bool, bool)]| c.iter().all(|&(on, _)| on);
    let mut i = 0usize;
    while i < stmts.len() {
        let s = stmts[i].as_str();
        i += 1;
        if s.is_empty() {
            continue;
        }
        // Labels may share a statement with what follows them
        // (`1: .irp ...`). Peel them so the directive is the first token;
        // one statement each names the same address.
        let (labels, s) = split_leading_labels(s);
        if emitting(&cond) {
            for l in &labels {
                st.defined
                    .insert(alloc::string::String::from(l.trim_end_matches(':')));
                out.push_str(l);
                out.push('\n');
            }
        }
        if s.is_empty() {
            continue;
        }
        let (tok, rest) = split_first_token(s);
        // A common block defines its name, whichever branch below routes the
        // statement itself.
        if emitting(&cond)
            && matches!(tok, ".comm" | ".lcomm")
            && let Some(name) = rest.split(',').next()
        {
            st.defined.insert(alloc::string::String::from(name.trim()));
        }
        // GNU as ends a directive or macro name at the first character that
        // cannot be part of one, so no space is needed before a parenthesized
        // operand list: `.inst(expr)`, and a macro invoked in the C-macro
        // spelling (`STACK_FRAME_NON_STANDARD(func)`).
        let (tok, rest) = match tok.find('(') {
            Some(p)
                if (tok.starts_with(".inst") && p >= 5) || st.macros.contains_key(&tok[..p]) =>
            {
                (&tok[..p], &s[p..])
            }
            _ => (tok, rest),
        };
        // Conditional directives are tracked whether or not the enclosing
        // branch emits, so nesting stays balanced across dead branches.
        match tok {
            ".if" | ".ifeq" | ".ifne" | ".ifgt" | ".iflt" | ".ifge" | ".ifle" => {
                // A condition over names only the layout can value, guarding
                // branches that emit no bytes: copy the region through so the
                // section layer values it once the labels are placed. GNU as
                // reads the same difference at the `.if`, which it can only
                // do while the two labels sit in one fixed-size run.
                if emitting(&cond)
                    && gas_cond_reads_symbols(rest, &st.equ)
                    && let Some(next) = gas_cond_region_is_diagnostic_only(stmts, i)
                {
                    for s in &stmts[i - 1..next] {
                        out.push_str(s);
                        out.push('\n');
                    }
                    i = next;
                    continue;
                }
                let taken = emitting(&cond) && gas_if_taken(tok, rest, &st.equ)?;
                cond.push((taken, taken));
                continue;
            }
            ".ifc" | ".ifnc" => {
                let taken = emitting(&cond) && gas_ifc_taken(tok, rest);
                cond.push((taken, taken));
                continue;
            }
            // Blank test: true when the argument is empty after macro
            // substitution (`.ifb \tmp`).
            ".ifb" | ".ifnb" => {
                let taken = emitting(&cond) && (rest.trim().is_empty() == (tok == ".ifb"));
                cond.push((taken, taken));
                continue;
            }
            // Defined test against what the expansion has defined so far
            // (`.ifdef .Lframe_regcount`, a label an earlier macro expansion
            // placed). GNU as answers it one-pass, so a definition further
            // down the stream does not count.
            ".ifdef" | ".ifndef" | ".ifnotdef" => {
                let defined = st.defined.contains(rest.trim());
                let taken = emitting(&cond) && (defined == (tok == ".ifdef"));
                cond.push((taken, taken));
                continue;
            }
            ".elseif" => {
                let outer = emitting(&cond[..cond.len().saturating_sub(1)]);
                let f = cond
                    .last_mut()
                    .ok_or("inline asm: `.elseif` without `.if`")?;
                let taken = outer && !f.1 && gas_if_taken(".if", rest, &st.equ)?;
                f.0 = taken;
                f.1 |= taken;
                continue;
            }
            ".else" => {
                let outer = emitting(&cond[..cond.len().saturating_sub(1)]);
                let f = cond.last_mut().ok_or("inline asm: `.else` without `.if`")?;
                f.0 = outer && !f.1;
                f.1 = true;
                continue;
            }
            ".endif" => {
                cond.pop().ok_or("inline asm: `.endif` without `.if`")?;
                continue;
            }
            _ => {}
        }
        if !emitting(&cond) {
            // A dead branch: skip it, but consume any macro / repeat body so its
            // `.endm` / `.endr` does not leak into the enclosing stream.
            match tok {
                ".macro" => i = collect_gas_body(stmts, i, ".macro", ".endm")?.1,
                ".irp" | ".irpc" | ".rept" | ".rep" => i = collect_gas_repeat_body(stmts, i)?.1,
                _ => {}
            }
            continue;
        }
        match tok {
            ".error" => {
                let msg = rest.trim().trim_matches('"');
                return Err(alloc::format!("inline asm: `.error` {msg}"));
            }
            ".macro" => {
                let (name, params) = parse_gas_macro_header(rest)?;
                let (body, next) = collect_gas_body(stmts, i, ".macro", ".endm")?;
                st.macros.insert(name, GasMacro { params, body });
                i = next;
            }
            ".endm" => {
                return Err(alloc::string::String::from(
                    "inline asm: `.endm` without `.macro`",
                ));
            }
            ".purgem" => {
                let name = rest.trim();
                if st.macros.remove(name).is_none() {
                    return Err(alloc::format!(
                        "inline asm: `.purgem` of undefined macro `{name}`"
                    ));
                }
            }
            // Alternate macro syntax. Only the `%expr` argument evaluation is
            // interpreted; the mode carries into nested expansions, which is
            // where an invocation written inside a macro body reads it.
            ".altmacro" | ".noaltmacro" => st.altmacro = tok == ".altmacro",
            ".irp" | ".irpc" => {
                let (var, values) = parse_gas_irp_header(rest, tok == ".irpc")?;
                let (body, next) = collect_gas_repeat_body(stmts, i)?;
                i = next;
                for val in &values {
                    let mut map = alloc::collections::BTreeMap::new();
                    map.insert(var.clone(), val.clone());
                    let expanded = subst_gas_body(&body, &map, None);
                    expand_gas_statements(&expanded, st, out, inst_width, depth + 1)?;
                }
            }
            ".rept" | ".rep" => {
                let table = &st.equ;
                let (body, next) = collect_gas_repeat_body(stmts, i)?;
                i = next;
                match eval_asm_expr_with_labels(rest, &|t| table.get(t).copied()) {
                    Some(n) => {
                        for _ in 0..n.max(0) {
                            expand_gas_statements(&body, st, out, inst_width, depth + 1)?;
                        }
                    }
                    // A count over labels (`(662b-661b) / 4`) defers to the
                    // section layer, which knows the offsets; the body
                    // expands once here.
                    None => {
                        out.push_str(".rept ");
                        out.push_str(rest);
                        out.push('\n');
                        expand_gas_statements(&body, st, out, inst_width, depth + 1)?;
                        out.push_str(".endr\n");
                    }
                }
            }
            ".endr" => {
                return Err(alloc::string::String::from(
                    "inline asm: `.endr` without `.rept` or `.irp`",
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
                st.defined.insert(alloc::string::String::from(sym.trim()));
                let table = &st.equ;
                match eval_asm_expr_with_labels(expr.trim(), &|t| table.get(t).copied()) {
                    Some(v) => {
                        st.equ.insert(alloc::string::String::from(sym.trim()), v);
                        st.keep_exported_set(sym.trim(), v, out);
                    }
                    None if bind_register_equate(sym.trim(), expr.trim(), st) => {}
                    // A value the expander cannot fold names a symbol or reads
                    // the location counter; neither is known before layout, so
                    // pass it through for the section parser.
                    None => {
                        out.push_str(s);
                        out.push('\n');
                    }
                }
            }
            ".inst" | ".inst.n" | ".inst.w" => {
                for arg in split_top_commas(rest) {
                    let table = &st.equ;
                    let v = eval_asm_expr_with_labels(arg, &|t| table.get(t).copied()).ok_or_else(
                        || alloc::format!("inline asm: `.inst` operand `{arg}` is not constant"),
                    )?;
                    let bytes = (v as u64).to_le_bytes();
                    out.push_str(INST_BYTES_DIRECTIVE);
                    out.push(' ');
                    for (k, b) in bytes.iter().take(inst_width).enumerate() {
                        if k > 0 {
                            out.push_str(", ");
                        }
                        out.push_str(&alloc::format!("0x{b:02x}"));
                    }
                    out.push('\n');
                }
            }
            ".unreq" => {
                st.aliases.remove(rest.trim());
            }
            _ => {
                // `name = expr`: the GNU as assignment spelling of `.set`.
                // A foldable value joins the symbol table; one over
                // locations is rewritten to `.set` for the section parser.
                let assign = if is_asm_symbol_name(tok) {
                    rest.strip_prefix('=')
                        .filter(|r| !r.starts_with('='))
                        .map(|e| (tok, alloc::string::String::from(e.trim())))
                } else {
                    tok.split_once('=')
                        .filter(|(n, e)| is_asm_symbol_name(n) && !e.starts_with('='))
                        .map(|(n, e)| (n, alloc::format!("{e} {rest}")))
                };
                if let Some((aname, aexpr)) = assign {
                    let aexpr = aexpr.trim();
                    st.defined.insert(alloc::string::String::from(aname));
                    let table = &st.equ;
                    match eval_asm_expr_with_labels(aexpr, &|t| table.get(t).copied()) {
                        Some(v) => {
                            st.equ.insert(alloc::string::String::from(aname), v);
                            st.keep_exported_set(aname, v, out);
                        }
                        None if bind_register_equate(aname, aexpr, st) => {}
                        None => {
                            out.push_str(&alloc::format!(".set {aname}, {aexpr}\n"));
                        }
                    }
                    continue;
                }
                // `alias .req reg` defines a register alias; every later
                // identifier use of the alias substitutes the register.
                if let Some(reg) = rest.strip_prefix(".req").and_then(|r| {
                    let reg = r.trim();
                    (r.starts_with(char::is_whitespace) && !reg.is_empty()).then_some(reg)
                }) {
                    let resolved = st.aliases.get(reg).cloned();
                    st.aliases.insert(
                        alloc::string::String::from(tok),
                        resolved.unwrap_or_else(|| alloc::string::String::from(reg)),
                    );
                } else if st.macros.contains_key(tok) {
                    // Bind arguments to parameters, then expand and re-process
                    // the body (which may define, invoke, or purge st.macros).
                    // Each invocation takes a fresh `\@` instance number.
                    let def = &st.macros[tok];
                    let params = def.params.clone();
                    let body = def.body.clone();
                    let map = bind_gas_macro_args(&params, rest, st.altmacro);
                    let inst = next_asm_instance();
                    let expanded = subst_gas_body(&body, &map, Some(inst));
                    expand_gas_statements(&expanded, st, out, inst_width, depth + 1)?;
                } else {
                    // A pass-through line. Resolve any `.equ` symbol and
                    // register alias so a `.short`/`.long` value (the
                    // exception-table register field) is constant and an
                    // aliased operand names its register when the section
                    // pass reads it. An alias with an arrangement suffix
                    // (`cbciv.16b`) substitutes the register part.
                    if st.equ.is_empty() && st.aliases.is_empty() {
                        out.push_str(s);
                    } else {
                        out.push_str(&subst_asm_idents_text(s, &|t| {
                            if let Some(a) = st.aliases.get(t) {
                                return Some(a.clone());
                            }
                            if let Some((head, tail)) = t.split_once('.')
                                && let Some(a) = st.aliases.get(head)
                            {
                                return Some(alloc::format!("{a}.{tail}"));
                            }
                            st.equ.get(t).map(|v| alloc::format!("{v}"))
                        }));
                    }
                    out.push('\n');
                }
            }
        }
    }
    if !cond.is_empty() {
        return Err(alloc::string::String::from(
            "inline asm: unterminated `.if` in macro expansion",
        ));
    }
    Ok(())
}

/// Whether the text holds a `name = expr` assignment, the GNU as spelling of
/// `.set`. An `=` that is part of a comparison or a compound operator is not
/// one, and neither is a macro parameter's `=default`, which the directives
/// above already trigger on.
fn has_gas_assignment(text: &str) -> bool {
    const OPS: &[u8] = b"=!<>+-*/%&|^";
    let b = text.as_bytes();
    (0..b.len()).any(|i| {
        b[i] == b'='
            && b.get(i + 1) != Some(&b'=')
            && !i.checked_sub(1).is_some_and(|p| OPS.contains(&b[p]))
    })
}

/// `name = %reg` / `.set name, %reg`: the GNU as register equate, the same
/// binding `name .req reg` makes. Records the alias and reports that the
/// assignment defined no symbol; a value that is neither a register name nor
/// an established alias leaves the assignment for the section parser.
fn bind_register_equate(name: &str, expr: &str, st: &mut GasExpandState) -> bool {
    let reg = match st.aliases.get(expr) {
        Some(r) => r.clone(),
        None => {
            let bare = expr.strip_prefix('%').unwrap_or("");
            if bare.is_empty() || !bare.bytes().all(|c| c.is_ascii_alphanumeric()) {
                return false;
            }
            alloc::string::String::from(expr)
        }
    };
    st.aliases.insert(alloc::string::String::from(name), reg);
    true
}

/// Whether a GNU as `.if`-family directive takes its branch: evaluate the
/// condition expression against the current `.set` symbol table and apply the
/// directive's relation to zero.
fn gas_if_taken(
    tok: &str,
    rest: &str,
    equ: &alloc::collections::BTreeMap<alloc::string::String, i64>,
) -> Result<bool, alloc::string::String> {
    let v = eval_asm_expr_with_labels(rest, &|t| equ.get(t).copied())
        .ok_or_else(|| alloc::format!("inline asm: non-constant `{tok}` condition `{rest}`"))?;
    gas_if_relation(tok, v)
}

/// The relation to zero a `.if`-family directive applies to its condition's
/// value.
pub(crate) fn gas_if_relation(tok: &str, v: i64) -> Result<bool, alloc::string::String> {
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
}

/// Whether a `.if` condition reads a name the expansion cannot value: a
/// label, or a symbol defined elsewhere in the unit. Numeric literals,
/// assignments the expansion has made, and the register text a `%`-prefixed
/// name spells are all valued here.
fn gas_cond_reads_symbols(
    rest: &str,
    equ: &alloc::collections::BTreeMap<alloc::string::String, i64>,
) -> bool {
    let b = rest.as_bytes();
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let mut i = 0usize;
    while i < b.len() {
        if !ident(b[i]) {
            i += 1;
            continue;
        }
        let start = i;
        while i < b.len() && ident(b[i]) {
            i += 1;
        }
        let tok = &rest[start..i];
        let register_text = start > 0 && b[start - 1] == b'%';
        let numeric = tok.as_bytes()[0].is_ascii_digit()
            && numeric_label_digits(tok).is_none_or(|d| d.len() == tok.len())
            && parse_asm_number(tok).is_some();
        if !register_text && !numeric && !equ.contains_key(tok) {
            return true;
        }
    }
    false
}

/// Statement index just past the `.endif` of a conditional region whose
/// branches emit no bytes, so its outcome cannot change the section layout
/// and the condition may be valued after it. `from` is the statement after
/// the `.if`. `None` when a branch emits, or when the region nests another
/// conditional, whose liveness the outer condition would decide.
fn gas_cond_region_is_diagnostic_only(
    stmts: &[alloc::string::String],
    from: usize,
) -> Option<usize> {
    for (n, s) in stmts.iter().enumerate().skip(from) {
        let (labels, s) = split_leading_labels(s);
        if !labels.is_empty() {
            return None;
        }
        if s.is_empty() {
            continue;
        }
        match split_first_token(s).0 {
            ".endif" => return Some(n + 1),
            ".error" | ".else" | ".elseif" => {}
            _ => return None,
        }
    }
    None
}

/// Whether a GNU as `.ifc` / `.ifnc` string-comparison takes its branch. The
/// two arguments are separated by a comma and compared after trimming
/// surrounding whitespace (`.ifc %eax, %eax`).
fn gas_ifc_taken(tok: &str, rest: &str) -> bool {
    let (a, b) = match rest.split_once(',') {
        Some((a, b)) => (a.trim(), b.trim()),
        None => (rest.trim(), ""),
    };
    (a == b) == (tok == ".ifc")
}

/// Replace each character constant in a macro argument with its numeric
/// value, as GNU as does when it binds one (`m 'r'` binds `114`).
fn fold_char_consts(a: &str) -> alloc::string::String {
    if !a.contains('\'') {
        return alloc::string::String::from(a);
    }
    let b = a.as_bytes();
    let mut out = alloc::string::String::with_capacity(a.len());
    let mut i = 0usize;
    while i < b.len() {
        match parse_asm_char_const(b, i) {
            Some((v, next)) => {
                out.push_str(&alloc::format!("{v}"));
                i = next;
            }
            None => {
                out.push(b[i] as char);
                i += 1;
            }
        }
    }
    out
}

/// Strip one level of enclosing double quotes from a macro / `.irp`
/// argument, as GNU as does when binding it.
fn unquote_gas_arg(a: &str) -> &str {
    a.strip_prefix('"')
        .and_then(|r| r.strip_suffix('"'))
        .unwrap_or(a)
}

/// Bind a GNU as macro invocation's arguments to its parameters. A `key=value`
/// argument whose key names a parameter binds by keyword; the rest fill the
/// still-unbound parameters positionally, in order. An enclosing quote pair
/// is stripped from each bound value. An unsupplied parameter binds to its
/// `=default`, or to the empty string; a `:vararg` parameter takes the whole
/// remaining argument text.
fn bind_gas_macro_args(
    params: &GasParams,
    rest: &str,
    altmacro: bool,
) -> alloc::collections::BTreeMap<alloc::string::String, alloc::string::String> {
    let args = split_macro_args(rest);
    // Under `.altmacro` a `%`-led argument is an expression evaluated at the
    // invocation and bound as its decimal value. A `:vararg` parameter takes
    // the raw text, so this applies only where a single argument binds.
    let value = |a: &str| match altmacro.then(|| a.strip_prefix('%')).flatten() {
        Some(e) => match eval_const_expr(e) {
            Some(v) => alloc::format!("{v}"),
            None => alloc::string::String::from(unquote_gas_arg(a)),
        },
        None => fold_char_consts(unquote_gas_arg(a)),
    };
    let is_keyword = |a: &str| {
        a.split_once('=')
            .is_some_and(|(k, _)| params.iter().any(|p| p.name == k.trim()))
    };
    let mut map = alloc::collections::BTreeMap::new();
    for a in &args {
        if is_keyword(a) {
            let (k, v) = a.split_once('=').unwrap();
            map.insert(alloc::string::String::from(k.trim()), value(v.trim()));
        }
    }
    let unbound: alloc::vec::Vec<&GasParam> = params
        .iter()
        .filter(|p| !map.contains_key(&p.name))
        .collect();
    let mut positional = args.iter().enumerate().filter(|(_, a)| !is_keyword(a));
    for p in unbound {
        if p.vararg {
            // The raw remaining argument text, separators included.
            let text = match positional.next() {
                Some((i, a)) => {
                    let off = a.as_ptr() as usize - rest.as_ptr() as usize;
                    let _ = i;
                    alloc::string::String::from(rest[off..].trim())
                }
                None => alloc::string::String::new(),
            };
            map.insert(p.name.clone(), text);
            break;
        }
        // An argument supplied empty takes the parameter's default, as GNU as
        // binds it; a parameter with no default takes the empty string either
        // way.
        match positional.next() {
            Some((_, a)) if !a.is_empty() => {
                map.insert(p.name.clone(), value(a));
            }
            _ => {
                map.insert(p.name.clone(), p.default.clone());
            }
        }
    }
    for p in params {
        map.entry(p.name.clone())
            .or_insert_with(|| p.default.clone());
    }
    map
}

/// The directive a statement names, with any leading labels peeled as the
/// expansion loop peels them (`1: .endr`).
fn stmt_directive(s: &str) -> &str {
    split_first_token(split_leading_labels(s).1).0
}

/// Collect a `.macro` body up to its matching `close`, nesting-aware.
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
        let first = stmt_directive(stmts[i].as_str());
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

/// Collect a `.rept` / `.irp` body up to its matching `.endr`. GNU as closes
/// every repeat directive with `.endr`, so the nesting count spans the family
/// rather than one spelling: a `.rept` inside an `.irp` closes first.
fn collect_gas_repeat_body(
    stmts: &[alloc::string::String],
    start: usize,
) -> Result<(alloc::vec::Vec<alloc::string::String>, usize), alloc::string::String> {
    let mut depth = 1i32;
    let mut body = alloc::vec::Vec::new();
    let mut i = start;
    while i < stmts.len() {
        match stmt_directive(stmts[i].as_str()) {
            ".rept" | ".rep" | ".irp" | ".irpc" => depth += 1,
            ".endr" => {
                depth -= 1;
                if depth == 0 {
                    return Ok((body, i + 1));
                }
            }
            _ => {}
        }
        body.push(stmts[i].clone());
        i += 1;
    }
    Err(alloc::string::String::from(
        "inline asm: `.rept` / `.irp` without `.endr`",
    ))
}

/// Parse a `.macro` header `NAME[,] p1[, p2 ...]`. A parameter may carry a
/// `=default` (bound when the invocation supplies no argument), a `:req`
/// qualifier (dropped; binding is positional either way), or `:vararg`
/// (binds the rest of the argument text).
fn parse_gas_macro_header(
    rest: &str,
) -> Result<(alloc::string::String, GasParams), alloc::string::String> {
    // Parameters split like invocation arguments: a parenthesised
    // `=default` may contain spaces.
    let toks = split_macro_args(rest);
    let mut it = toks.into_iter().filter(|t| !t.is_empty());
    let name = it.next().ok_or("inline asm: `.macro` without a name")?;
    let params = it
        .map(|p| {
            // GNU as scans the formal name, then the `=` / `:` separator and
            // the text after it as separate tokens, so whitespace may border
            // either (`regsize = 64`, `tsk : req`).
            let (head, default) = match p.split_once('=') {
                Some((h, d)) => (h.trim_end(), alloc::string::String::from(d.trim())),
                None => (p, alloc::string::String::new()),
            };
            let (pname, qual) = match head.split_once(':') {
                Some((n, q)) => (n.trim_end(), q.trim()),
                None => (head, ""),
            };
            GasParam {
                name: alloc::string::String::from(pname),
                default,
                vararg: qual == "vararg",
            }
        })
        .collect();
    Ok((alloc::string::String::from(name), params))
}

/// Parse a `.irp` header `VAR,v1,v2,...`; with no values the body expands once
/// with the symbol empty (GNU as convention). `per_char` selects `.irpc`,
/// whose values are the individual characters of the operands.
fn parse_gas_irp_header(
    rest: &str,
    per_char: bool,
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
    let items = rest[end..].split(|c: char| c == ',' || c.is_whitespace());
    let mut values: alloc::vec::Vec<alloc::string::String> = if per_char {
        items.flat_map(|t| t.chars()).map(Into::into).collect()
    } else {
        items
            .filter(|t| !t.is_empty())
            .map(alloc::string::String::from)
            .collect()
    };
    if values.is_empty() {
        values.push(alloc::string::String::new());
    }
    Ok((var, values))
}

/// Substitute a macro / `.irp` body's parameters and re-split the result into
/// statements. An argument may itself hold `;`-separated statements (the
/// kernel's ALTERNATIVE macros pass a whole instruction sequence as one
/// argument), and GNU as re-scans the expansion, so a separator that arrives
/// through a parameter separates.
fn subst_gas_body(
    body: &[alloc::string::String],
    map: &alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    instance: Option<u32>,
) -> alloc::vec::Vec<alloc::string::String> {
    let mut out = alloc::vec::Vec::with_capacity(body.len());
    for line in body {
        let line = subst_gas_params(line, map, instance);
        if line.contains(';') {
            out.extend(
                split_asm_statements(&line)
                    .into_iter()
                    .map(|s| alloc::string::String::from(s.trim())),
            );
        } else {
            out.push(line);
        }
    }
    out
}

/// Substitute `\param` in a macro / `.irp` body with its bound value. `\()`
/// is an empty name separator; `\@` is the macro-instance counter when one
/// is given (a macro invocation); an unbound `\name` stays verbatim.
fn subst_gas_params(
    line: &str,
    map: &alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    instance: Option<u32>,
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
        if let Some(tail) = after.strip_prefix('@')
            && let Some(n) = instance
        {
            out.push_str(&alloc::format!("{n}"));
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

/// Split a macro invocation's arguments as GNU as scans them: commas
/// separate; whitespace separates unless it borders an expression operator
/// (`ldr_l x1, sym + 24` keeps `sym + 24` whole, `m 3 4` splits) or the
/// argument began with `(` (`nops (662b-661b) / 4`). Quoted runs and
/// bracketed groups are opaque. A comma with no argument before it supplies
/// an empty one (`m 1,,3` binds three), so only whitespace runs collapse.
fn split_macro_args(s: &str) -> alloc::vec::Vec<&str> {
    let b = s.as_bytes();
    // `%` is not one of them: GNU as splits `m 1 % 2` into three arguments,
    // and an AT&T register operand leads with it (`m %r8 %r9` is two).
    let is_op = |c: u8| {
        matches!(
            c,
            b'+' | b'-' | b'*' | b'/' | b'|' | b'&' | b'^' | b'~' | b'<' | b'>' | b'='
        )
    };
    let mut parts: alloc::vec::Vec<&str> = alloc::vec::Vec::new();
    let mut depth = 0i32;
    let mut quoted = false;
    let mut start = 0usize;
    let mut paren_led = false;
    let mut in_arg = false;
    // Whether whitespace closed the previous argument, so a comma reaching
    // this one is its separator rather than an empty argument.
    let mut ws_terminated = false;
    let mut last_comma = false;
    let mut i = 0usize;
    while i < b.len() {
        let c = b[i];
        // A character constant is one token, separators included: GNU as
        // binds `m 'r', ' ', ':'` as three arguments.
        if !quoted
            && c == b'\''
            && let Some((_, next)) = parse_asm_char_const(b, i)
        {
            in_arg = true;
            i = next;
            continue;
        }
        if !in_arg && !c.is_ascii_whitespace() {
            in_arg = true;
            paren_led = c == b'(';
        }
        let split = match c {
            b'"' => {
                quoted = !quoted;
                false
            }
            _ if quoted => false,
            b'(' | b'[' | b'{' => {
                depth += 1;
                false
            }
            b')' | b']' | b'}' => {
                depth -= 1;
                false
            }
            b',' => depth == 0,
            _ if depth == 0 && c.is_ascii_whitespace() && in_arg && !paren_led => {
                let prev = b[..i].iter().rev().find(|c| !c.is_ascii_whitespace());
                let next = b[i..].iter().find(|c| !c.is_ascii_whitespace());
                !(prev.copied().is_some_and(is_op) || next.copied().is_some_and(is_op))
            }
            _ => false,
        };
        if split {
            let p = s[start..i].trim();
            let comma = c == b',';
            // A comma terminates an argument even when it is empty, except
            // where whitespace already terminated the one before it
            // (`m 1 , 2` is two arguments, `m 1,,2` is three).
            if !p.is_empty() || (comma && !ws_terminated) {
                parts.push(p);
                ws_terminated = !comma;
            } else if comma {
                ws_terminated = false;
            }
            last_comma = comma;
            start = i + 1;
            in_arg = false;
        }
        i += 1;
    }
    let p = s[start..].trim();
    if !p.is_empty() || last_comma {
        parts.push(p);
    }
    parts
}

/// Split a directive argument list on top-level commas, ignoring commas
/// nested in `()` / `[]` / `{}` or inside a double-quoted run (an
/// ALTERNATIVE macro argument quotes a whole instruction, commas included).
/// Empty pieces are dropped.
fn split_top_commas(s: &str) -> alloc::vec::Vec<&str> {
    let mut parts = alloc::vec::Vec::new();
    let b = s.as_bytes();
    let mut depth = 0i32;
    let mut quoted = false;
    let mut start = 0usize;
    for (i, &c) in b.iter().enumerate() {
        match c {
            b'"' => quoted = !quoted,
            _ if quoted => {}
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
/// `.previous` swaps the top two.
pub(crate) fn extract_asm_sections(
    text: &str,
    is_aarch64: bool,
) -> Result<Option<AsmExtract>, alloc::string::String> {
    extract_asm_sections_impl(text, is_aarch64, false)
}

/// What a function-scope template splits into: the code stream the arch
/// backend encodes, the named-section blocks, and the symbol directives the
/// code stream carried, which GNU as scopes to the unit rather than to a
/// section.
#[derive(Debug)]
pub(crate) struct AsmExtract {
    pub code: alloc::string::String,
    pub blocks: alloc::vec::Vec<AsmSectionBlock>,
    pub sym_items: alloc::vec::Vec<AsmSectionItem>,
}

impl AsmExtract {
    /// The linkage-only form of a file-scope template: outside its sections
    /// it declares external names and defines nothing, so there is no
    /// trampoline body to assemble as `.text`. `.globl` is the only such
    /// declaration a C symbol of the unit takes; the others bind a symbol the
    /// file-scope parse records on its own channels.
    pub(crate) fn is_linkage_only(&self) -> bool {
        self.code.trim().is_empty()
            && self
                .sym_items
                .iter()
                .all(|i| matches!(i, AsmSectionItem::Global(_)))
    }

    /// The names its `.globl` / `.global` statements declare.
    pub(crate) fn globl_names(&self) -> impl Iterator<Item = &str> {
        self.sym_items.iter().filter_map(|i| match i {
            AsmSectionItem::Global(n) => Some(n.as_str()),
            _ => None,
        })
    }
}

/// File-scope variant: the whole template is section-scoped, starting in
/// `.text`, so a trampoline body (labels + instructions in the default
/// section) is assembled into a `.text` block rather than left in the code
/// stream. `.text`/`.data`/`.rodata`/`.bss` switch the base section.
pub(crate) fn extract_file_scope_asm_sections(
    text: &str,
    is_aarch64: bool,
) -> Result<alloc::vec::Vec<AsmSectionBlock>, alloc::string::String> {
    Ok(extract_asm_sections_impl(text, is_aarch64, true)?
        .expect("file-scope extraction always yields sections")
        .blocks)
}

/// ELF relocation type number for a `.reloc` type name. The names are
/// architecture-qualified, so one table serves every target.
fn elf_reloc_type_by_name(name: &str) -> Option<u32> {
    Some(match name {
        "R_X86_64_NONE" | "R_386_NONE" | "R_AARCH64_NONE" => 0,
        "R_X86_64_64" | "R_386_32" => 1,
        "R_X86_64_PC32" | "R_386_PC32" => 2,
        "R_X86_64_GOT32" | "R_386_GOT32" => 3,
        "R_X86_64_PLT32" | "R_386_PLT32" => 4,
        "R_X86_64_GOTPCREL" => 9,
        "R_X86_64_32" | "R_386_GOTPC" => 10,
        "R_X86_64_32S" => 11,
        "R_X86_64_16" => 12,
        "R_X86_64_PC16" => 13,
        "R_X86_64_8" => 14,
        "R_X86_64_PC8" => 15,
        "R_386_16" => 20,
        "R_386_PC16" => 21,
        "R_386_8" => 22,
        "R_386_PC8" => 23,
        "R_X86_64_PC64" => 24,
        "R_AARCH64_ABS64" => 257,
        "R_AARCH64_ABS32" => 258,
        "R_AARCH64_ABS16" => 259,
        "R_AARCH64_PREL64" => 260,
        "R_AARCH64_PREL32" => 261,
        "R_AARCH64_PREL16" => 262,
        _ => return None,
    })
}

/// Parse `.reloc offset, TYPE[, expression]`. The offset is measured from the
/// start of the section the directive sits in, not from the location counter;
/// the expression is a symbol with an optional constant addend, a bare
/// constant (the section itself), or absent. The directive deposits no bytes.
fn parse_reloc_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let bad = || alloc::format!("inline asm: `.reloc {rest}` is not `offset, TYPE[, expr]`");
    let mut args = split_top_commas(rest).into_iter();
    let (Some(off), Some(ty)) = (args.next(), args.next()) else {
        return Err(bad());
    };
    let offset = eval_const_expr(off).filter(|&v| (0..=u32::MAX as i64).contains(&v));
    let (Some(offset), Some(rtype)) = (offset, elf_reloc_type_by_name(ty)) else {
        return Err(bad());
    };
    let expr = args.next().unwrap_or("").trim();
    if args.next().is_some() {
        return Err(bad());
    }
    // `sym`, `sym +/- <const expr>`, or a bare constant.
    let split = expr
        .char_indices()
        .skip(1)
        .find(|&(_, c)| c == '+' || c == '-');
    let (name, addend) = match split {
        Some((i, sign)) => {
            let a = eval_const_expr(&expr[i + 1..]).ok_or_else(bad)?;
            (expr[..i].trim(), if sign == '-' { -a } else { a })
        }
        None => (expr, 0),
    };
    let (target, addend) = match eval_const_expr(name) {
        Some(v) => (alloc::string::String::new(), v + addend),
        None if is_asm_symbol_name(name) => (alloc::string::String::from(name), addend),
        None if name.is_empty() => (alloc::string::String::new(), addend),
        None => return Err(bad()),
    };
    Ok(AsmSectionItem::Reloc {
        offset: offset as u32,
        rtype,
        target,
        addend,
    })
}

/// Directives GNU as resolves against the unit's symbol table rather than
/// against the section they sit in. An assignment is one: it defines a
/// symbol of the unit, not a location in the stream it sits in.
fn is_asm_sym_directive(tok: &str) -> bool {
    matches!(
        tok,
        ".globl"
            | ".global"
            | ".weak"
            | ".local"
            | ".hidden"
            | ".internal"
            | ".protected"
            | ".type"
            | ".size"
            | ".set"
            | ".equ"
            | ".equiv"
    )
}

/// Whether a template's statements hold one. A spelling test gates the
/// statement scan: a template with none keeps its text verbatim, since
/// extraction reconstructs the code stream it returns.
fn asm_text_has_sym_directive(text: &str) -> bool {
    if !(text.contains(".glob")
        || text.contains(".weak")
        || text.contains(".local")
        || text.contains(".hidden")
        || text.contains(".internal")
        || text.contains(".protected")
        || text.contains(".type")
        || text.contains(".size")
        || text.contains(".set")
        || text.contains(".equ"))
    {
        return false;
    }
    split_asm_statements(text).into_iter().any(|stmt| {
        let mut s = stmt.trim();
        while let Some((_, rest)) = peel_leading_label(s) {
            s = rest;
        }
        is_asm_sym_directive(split_first_token(s).0)
    })
}

/// Parse one symbol directive into items. `.globl a, b` declares each name;
/// the rest take a name plus their own arguments.
fn push_sym_directive_items(
    tok: &str,
    rest: &str,
    is_aarch64: bool,
    out: &mut alloc::vec::Vec<AsmSectionItem>,
) -> Result<(), alloc::string::String> {
    if matches!(
        tok,
        ".globl" | ".global" | ".weak" | ".local" | ".hidden" | ".internal" | ".protected"
    ) && rest.contains(',')
    {
        for name in rest.split(',') {
            out.push(parse_section_item(tok, name.trim(), is_aarch64)?);
        }
        return Ok(());
    }
    out.push(parse_section_item(tok, rest, is_aarch64)?);
    Ok(())
}

/// A bare section directive naming a well-known section (`.text` == `.section
/// .text`). GNU as accepts these shorthands; file-scope asm uses them to place
/// a trampoline body. The dotted-suffix form is not a shorthand.
fn base_section_shorthand(tok: &str) -> bool {
    matches!(
        tok,
        ".text" | ".data" | ".data1" | ".sdata" | ".rodata" | ".bss" | ".sbss"
    )
}

/// Peel the labels leading a statement from the rest of it. GNU as lets any
/// number of labels share a statement with the directive or instruction that
/// follows (`1: .irp num,...`), so the first token is not always the
/// directive. Returns the label text, empty when there is none, and the
/// remainder, empty when the statement is labels only.
fn split_leading_labels(s: &str) -> (alloc::vec::Vec<&str>, &str) {
    let mut labels = alloc::vec::Vec::new();
    let mut end = 0usize;
    loop {
        let rest = s[end..].trim_start();
        let off = s.len() - rest.len();
        let name = rest
            .find(|c: char| !(c.is_ascii_alphanumeric() || c == '_' || c == '.' || c == '$'))
            .unwrap_or(rest.len());
        if name == 0 || !rest[name..].starts_with(':') {
            break;
        }
        // `name::` is the global-label spelling; both colons belong to it.
        let colons = if rest[name + 1..].starts_with(':') {
            2
        } else {
            1
        };
        labels.push(&rest[..name + colons]);
        end = off + name + colons;
    }
    (labels, s[end..].trim_start())
}

/// Label numbers at and above this mark are interned named labels
/// (`name:` definitions); below it, GNU-as numeric locals (`1:`).
pub(crate) const NAMED_LABEL_BASE: u32 = 1 << 31;

/// Peel one leading label definition off a statement, returning the label
/// name and the remainder. A name is a GNU as identifier; an all-digit name
/// is a numeric local.
pub(crate) fn split_label_def(piece: &str) -> Option<(&str, &str)> {
    let colon = piece.find(':')?;
    if colon == 0 {
        return None;
    }
    let name = &piece.as_bytes()[..colon];
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let named = !name[0].is_ascii_digit() && ident(name[0]) && name.iter().all(|&c| ident(c));
    if named || name.iter().all(u8::is_ascii_digit) {
        Some((&piece[..colon], &piece[colon + 1..]))
    } else {
        None
    }
}

/// Named labels defined in a template's code text, in definition order --
/// the intern order the `NAMED_LABEL_BASE + index` label numbers use. Both
/// arch parsers and the emitters' section materialization read this, so a
/// reference resolves a name to the same number everywhere.
pub(crate) fn scan_label_names(text: &str) -> alloc::vec::Vec<&str> {
    let mut names: alloc::vec::Vec<&str> = alloc::vec::Vec::new();
    for piece in split_asm_statements(text) {
        let mut p = piece.trim();
        while let Some((name, rest)) = split_label_def(p) {
            if !name.as_bytes()[0].is_ascii_digit() && !names.contains(&name) {
                names.push(name);
            }
            p = rest.trim();
        }
    }
    names
}

/// The first named label a template's code text defines twice. A name has
/// one definition in GNU as, which rejects a second; a numeric local may
/// repeat, and each reference binds by direction.
pub(crate) fn duplicate_label_name(text: &str) -> Option<&str> {
    let mut seen: alloc::vec::Vec<&str> = alloc::vec::Vec::new();
    for piece in split_asm_statements(text) {
        let mut p = piece.trim();
        while let Some((name, rest)) = split_label_def(p) {
            if !name.as_bytes()[0].is_ascii_digit() {
                if seen.contains(&name) {
                    return Some(name);
                }
                seen.push(name);
            }
            p = rest.trim();
        }
    }
    None
}

/// Split a template into statements at `;` and newlines, with `;` inside a
/// double-quoted run kept (a quoted macro argument carries whole
/// instruction sequences: `ALTERNATIVE "a; b", ...`). A newline always
/// separates, as a string literal cannot span one.
pub(crate) fn split_asm_statements(text: &str) -> alloc::vec::Vec<&str> {
    if !text.contains('"') {
        return text.split([';', '\n']).collect();
    }
    let b = text.as_bytes();
    let mut out = alloc::vec::Vec::new();
    let (mut start, mut quoted) = (0usize, false);
    for (i, &c) in b.iter().enumerate() {
        match c {
            b'"' => quoted = !quoted,
            b'\n' => {
                out.push(&text[start..i]);
                start = i + 1;
                quoted = false;
            }
            b';' if !quoted => {
                out.push(&text[start..i]);
                start = i + 1;
            }
            _ => {}
        }
    }
    out.push(&text[start..]);
    out
}

/// Split off the first whitespace-delimited token and the trimmed remainder.
fn split_first_token(s: &str) -> (&str, &str) {
    match s.find(char::is_whitespace) {
        Some(p) => (&s[..p], s[p..].trim()),
        None => (s, ""),
    }
}

/// Peel a leading `name:` label from a statement. GNU as terminates a label at
/// the colon and requires no whitespace before the statement that follows, so
/// `name:insn` is a label plus an instruction. Returns the label name and the
/// remainder (leading whitespace trimmed), or `None` when the statement does
/// not begin with a label. A colon reached only after other tokens (an
/// operand's `seg:` or a far branch's `$sel:$off`) leaves whitespace or a
/// sigil in the preceding text, which is not a valid label name.
fn peel_leading_label(stmt: &str) -> Option<(&str, &str)> {
    let colon = stmt.find(':')?;
    // GNU as allows whitespace between the label and its colon (`0 :`).
    let name = stmt[..colon].trim_end();
    if !is_asm_symbol_name(name) && !is_numeric_label(name) {
        return None;
    }
    Some((name, stmt[colon + 1..].trim_start()))
}

fn extract_asm_sections_impl(
    text: &str,
    is_aarch64: bool,
    file_scope: bool,
) -> Result<Option<AsmExtract>, alloc::string::String> {
    if !file_scope
        && !text.contains(".pushsection")
        && !text.contains(".section")
        && !text.contains(".subsection")
        && !asm_text_has_sym_directive(text)
    {
        return Ok(None);
    }
    let mut code = alloc::string::String::with_capacity(text.len());
    let mut sym_items: alloc::vec::Vec<AsmSectionItem> = alloc::vec::Vec::new();
    let mut blocks: alloc::vec::Vec<AsmSectionBlock> = alloc::vec::Vec::new();
    // Stack of indices into `blocks`; `None` is the code stream. File-scope asm
    // has no code stream: the base is a `.text` section from the start.
    let mut stack: alloc::vec::Vec<Option<usize>> = if file_scope {
        blocks.push(parse_section_args(".text")?);
        alloc::vec![Some(0)]
    } else {
        alloc::vec![None]
    };
    // The section left by the most recent change of any kind. GNU as keeps
    // this slot beside the `.pushsection` stack and `.previous` swaps the two,
    // so a `.section` / `.previous` pair nested inside a pushed region returns
    // to the pushed section rather than unwinding the stack.
    let mut prev_top: Option<Option<usize>> = None;
    // Encoding mode over the linear input, and the mode each block was
    // last told about.
    let mut code_mode: Option<&str> = None;
    let mut block_code_mode: alloc::collections::BTreeMap<usize, &str> =
        alloc::collections::BTreeMap::new();
    // Open `.rept` bodies of the current section; items nest into the top
    // until `.endr` closes it into a `Rept` item.
    let mut rept_stack: alloc::vec::Vec<(alloc::string::String, alloc::vec::Vec<AsmSectionItem>)> =
        alloc::vec::Vec::new();
    // Arms of an open deferred conditional; `None` outside one.
    let mut cond_arms: Option<alloc::vec::Vec<AsmCondArm>> = None;
    for piece in split_asm_statements(text) {
        let piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // Peel any leading `name:` labels: GNU as treats them as statements
        // preceding the rest of the line, so a section directive or an
        // instruction may follow a label on the same line, with or without
        // whitespace after the colon (`1:\t.pushsection ...`, `name:push %rcx`).
        // A label goes to the current stream; a leading token that is not a
        // valid label is left in place as the statement.
        let mut stmt = piece;
        while let Some((name, rest)) = peel_leading_label(stmt) {
            if !rept_stack.is_empty() {
                return Err(alloc::format!(
                    "inline asm: label `{name}` inside `.rept` would be defined repeatedly"
                ));
            }
            match *stack.last().unwrap() {
                None => {
                    code.push_str(name);
                    code.push_str(":\n");
                }
                Some(idx) => blocks[idx]
                    .items
                    .push(AsmSectionItem::Label(alloc::string::String::from(name))),
            }
            stmt = rest;
        }
        if stmt.is_empty() {
            continue;
        }
        let (tok, rest) = split_first_token(stmt);
        // A `.rept` body collects items until its `.endr`; section switches
        // inside it have no GNU as meaning worth carrying.
        if !rept_stack.is_empty() {
            match tok {
                ".endr" => {
                    let (count, items) = rept_stack.pop().expect("nonempty checked");
                    let item = AsmSectionItem::Rept { count, items };
                    match rept_stack.last_mut() {
                        Some((_, outer)) => outer.push(item),
                        None => match *stack.last().unwrap() {
                            Some(idx) => blocks[idx].items.push(item),
                            None => {
                                return Err(alloc::string::String::from(
                                    "inline asm: `.rept` outside a section",
                                ));
                            }
                        },
                    }
                }
                ".rept" | ".rep" => {
                    rept_stack.push((alloc::string::String::from(rest), alloc::vec::Vec::new()))
                }
                ".pushsection" | ".section" | ".popsection" | ".previous" | ".subsection" => {
                    return Err(alloc::format!(
                        "inline asm: `{tok}` inside `.rept` is not supported"
                    ));
                }
                _ => {
                    let item = parse_section_item(tok, rest, is_aarch64)?;
                    rept_stack
                        .last_mut()
                        .expect("nonempty checked")
                        .1
                        .push(item);
                }
            }
            continue;
        }
        // A conditional the expansion deferred: its condition reads section
        // labels and its branches emit no bytes, so the arms accumulate into
        // one item the layout values.
        if let Some(arms) = &mut cond_arms {
            match tok {
                ".endif" => {
                    let item = AsmSectionItem::CondDiag(core::mem::take(arms));
                    cond_arms = None;
                    match *stack.last().unwrap() {
                        Some(idx) => blocks[idx].items.push(item),
                        None => {
                            return Err(alloc::string::String::from(
                                "inline asm: `.if` outside a section",
                            ));
                        }
                    }
                }
                ".else" | ".elseif" => arms.push(AsmCondArm {
                    tok: alloc::string::String::from(if tok == ".else" { "" } else { ".if" }),
                    cond: alloc::string::String::from(rest.trim()),
                    error: None,
                }),
                ".error" => {
                    let arm = arms.last_mut().expect("an arm is open");
                    if arm.error.is_none() {
                        arm.error =
                            Some(alloc::string::String::from(rest.trim().trim_matches('"')));
                    }
                }
                _ => {
                    return Err(alloc::format!(
                        "inline asm: `{tok}` inside a conditional over section labels would emit bytes"
                    ));
                }
            }
            continue;
        }
        if matches!(
            tok,
            ".if" | ".ifeq" | ".ifne" | ".ifgt" | ".iflt" | ".ifge" | ".ifle"
        ) {
            cond_arms = Some(alloc::vec![AsmCondArm {
                tok: alloc::string::String::from(tok),
                cond: alloc::string::String::from(rest.trim()),
                error: None,
            }]);
            continue;
        }
        if matches!(tok, ".rept" | ".rep") && (*stack.last().unwrap()).is_some() {
            rept_stack.push((alloc::string::String::from(rest), alloc::vec::Vec::new()));
            continue;
        }
        match tok {
            ".pushsection" | ".section" => {
                let block = parse_section_args(rest)?;
                let idx = blocks.len();
                blocks.push(block);
                prev_top = Some(*stack.last().unwrap());
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
                prev_top = Some(*stack.last().unwrap());
                stack.pop();
                continue;
            }
            ".previous" => {
                match prev_top {
                    Some(p) => {
                        prev_top = Some(*stack.last().unwrap());
                        *stack.last_mut().unwrap() = p;
                    }
                    // Nothing was left yet. A function-body template starts in
                    // the code stream, which is where `.previous` returns to;
                    // file-scope asm has no code stream, so the current
                    // section stands.
                    None if !file_scope => stack[0] = None,
                    None => {}
                }
                continue;
            }
            // File-scope base-section shorthands (`.text`, `.data`, ...): switch
            // the current base to that section, reusing an existing block of the
            // same name so repeated switches accumulate into one section.
            _ if file_scope && base_section_shorthand(tok) => {
                let idx = match blocks
                    .iter()
                    .position(|b| b.name == tok && b.subsection == 0)
                {
                    Some(i) => i,
                    None => {
                        blocks.push(parse_section_args(tok)?);
                        blocks.len() - 1
                    }
                };
                prev_top = Some(*stack.last().unwrap());
                *stack.last_mut().unwrap() = Some(idx);
                continue;
            }
            // `.subsection N` switches to the numbered subsection of the
            // current section: same identity and address space, laid out
            // after every lower-numbered block. The function-body path
            // handles its ALTERNATIVE `.subsection` in the deferred-region
            // splitter before extraction; one reaching here is rejected
            // rather than emitted inline (both sequences would execute).
            ".subsection" => {
                if !file_scope {
                    return Err(alloc::string::String::from(
                        "inline asm: `.subsection` is not supported (deferred replacement code)",
                    ));
                }
                let n: u32 = rest
                    .trim()
                    .parse()
                    .map_err(|_| alloc::format!("inline asm: bad `.subsection` number `{rest}`"))?;
                let cur = stack
                    .last()
                    .unwrap()
                    .expect("file scope always in a section");
                let (name, flags, sh_type) = (
                    blocks[cur].name.clone(),
                    blocks[cur].flags.clone(),
                    blocks[cur].sh_type.clone(),
                );
                blocks.push(AsmSectionBlock {
                    name,
                    flags,
                    sh_type,
                    subsection: n,
                    items: alloc::vec::Vec::new(),
                });
                let idx = blocks.len() - 1;
                prev_top = Some(Some(cur));
                *stack.last_mut().unwrap() = Some(idx);
                continue;
            }
            _ => {}
        }
        match *stack.last().unwrap() {
            // A symbol directive names a symbol of the unit, not a location in
            // the stream it sits in, so it leaves the code stream here as it
            // leaves the instruction stream of a section.
            None if is_asm_sym_directive(tok) => {
                push_sym_directive_items(tok, rest, is_aarch64, &mut sym_items)?;
            }
            // The remaining statement is an instruction, kept verbatim for the
            // arch backend to encode.
            None => {
                code.push_str(stmt);
                code.push('\n');
            }
            // GNU as assembles instructions in any section (the x86 ALTERNATIVE
            // replacement in an `"ax"` section, a trampoline body in
            // `.rodata`); the section flags set the object section's
            // attributes, not whether code is admitted.
            Some(idx) => {
                // `.code16` / `.code32` / `.code64` is assembler state over the
                // linear input, not a property of a section: GNU as keeps it
                // across section switches. Blocks accumulate per section name,
                // so re-entering one re-asserts the mode in effect.
                if is_code_mode_directive(tok) {
                    code_mode = Some(tok);
                    block_code_mode.insert(idx, tok);
                } else if let Some(m) = code_mode
                    && block_code_mode.get(&idx) != Some(&m)
                {
                    blocks[idx]
                        .items
                        .push(AsmSectionItem::Code(alloc::string::String::from(m)));
                    block_code_mode.insert(idx, m);
                }
                push_sym_directive_items(tok, rest, is_aarch64, &mut blocks[idx].items)?;
            }
        }
    }
    if !rept_stack.is_empty() {
        return Err(alloc::string::String::from(
            "inline asm: `.rept` without `.endr`",
        ));
    }
    Ok(Some(AsmExtract {
        code,
        blocks,
        sym_items,
    }))
}

/// Whether a directive selects the x86 encoding mode.
fn is_code_mode_directive(tok: &str) -> bool {
    matches!(tok, ".code16" | ".code32" | ".code64")
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
    if flags.is_empty() {
        flags = alloc::string::String::from(default_section_flags(name));
    }
    Ok(AsmSectionBlock {
        name: alloc::string::String::from(name),
        flags,
        sh_type,
        subsection: 0,
        items: alloc::vec::Vec::new(),
    })
}

/// GNU as default attributes for a well-known section name, used when the
/// directive gives no explicit `"flags"`. GNU as knows these names carry
/// allocation, write, and execute attributes; a `.pushsection .rodata`
/// without flags is allocatable, an unknown name defaults to none. The
/// match is exact or on the dotted-suffix form (`.rodata.str1.1`).
fn default_section_flags(name: &str) -> &'static str {
    // The leading `.` and first dotted component: `.rodata.str1.1` -> `.rodata`.
    let base = match name.get(1..).and_then(|r| r.find('.')) {
        Some(i) => &name[..1 + i],
        None => name,
    };
    match base {
        ".text" => "ax",
        ".rodata" => "a",
        ".data" | ".data1" | ".sdata" => "aw",
        ".bss" | ".sbss" => "aw",
        ".init_array" | ".fini_array" | ".preinit_array" => "aw",
        _ => "",
    }
}

/// An assembler symbol name: identifier characters, not starting with a
/// digit (which would be a local numeric label, not a symbol definition).
pub(crate) fn is_asm_symbol_name(name: &str) -> bool {
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
        // GNU as allows horizontal whitespace between a label and its colon.
        let mut c = i;
        while c < n && (b[c] == b' ' || b[c] == b'\t') {
            c += 1;
        }
        if c < n && b[c] == b':' {
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
    let uniq = next_asm_instance();
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

/// How a target reads an alignment directive's first operand.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AlignKind {
    /// `.balign`: a byte count.
    Bytes,
    /// `.p2align`: a power-of-two exponent.
    Pow2,
    /// `.align`: a byte count on x86 ELF, an exponent on AArch64.
    Arch,
}

/// The alignment directive family and the width of the fill unit its
/// spelling selects. GNU as gives `.balign` and `.p2align` a `w` and an `l`
/// spelling padding with a 2- or 4-byte value; `.align` has neither.
pub(crate) fn align_directive(tok: &str) -> Option<(AlignKind, u8)> {
    let (base, width) = match tok.as_bytes().last() {
        Some(b'w') => (&tok[..tok.len() - 1], 2u8),
        Some(b'l') => (&tok[..tok.len() - 1], 4),
        _ => (tok, 1),
    };
    match (base, width) {
        (".align", 1) => Some((AlignKind::Arch, 1)),
        (".balign", _) => Some((AlignKind::Bytes, width)),
        (".p2align", _) => Some((AlignKind::Pow2, width)),
        _ => None,
    }
}

/// An alignment directive's explicit fill: the value and the width in bytes
/// of the unit repeated over the gap. The value is truncated to the width and
/// laid down little-endian.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct AlignFill {
    pub(crate) value: u32,
    pub(crate) width: u8,
}

impl AlignFill {
    /// Whether this is the one-byte x86 NOP, which GNU as pads with its
    /// NOP sequence rather than by repeating the byte.
    fn is_x86_nop(&self) -> bool {
        self.width == 1 && self.value as u8 == X86_NOP_OPCODE
    }
}

/// An alignment directive's first operand: a byte count, or an expression
/// over labels. GNU as requires the operand to reduce to a constant where
/// the directive stands, so only definitions the layout has already placed
/// resolve and a forward reference has no value.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AlignSpec {
    /// Already read under the directive's convention.
    Bytes(u32),
    /// Read under `pow2` -- the `.p2align` exponent convention -- once the
    /// expression resolves.
    Expr {
        text: alloc::string::String,
        pow2: bool,
    },
}

/// The byte alignment a resolved operand denotes: a power-of-two byte count,
/// or two raised to an exponent up to 12. A zero count is an alignment of
/// one, as GNU as reads it. `None` when the operand is out of range.
fn align_spec_value(v: i64, pow2: bool) -> Option<u32> {
    if pow2 {
        return (0..=12).contains(&v).then(|| 1u32 << v);
    }
    u32::try_from(v)
        .ok()
        .filter(|&n| n == 0 || n.is_power_of_two())
        .map(|n| n.max(1))
}

impl AlignSpec {
    /// The byte alignment requested. `resolve` values a label reference, and
    /// only for a definition already placed.
    pub(crate) fn bytes(
        &self,
        resolve: &dyn Fn(&str) -> Option<i64>,
    ) -> Result<u32, alloc::string::String> {
        let (text, pow2) = match self {
            AlignSpec::Bytes(n) => return Ok(*n),
            AlignSpec::Expr { text, pow2 } => (text, *pow2),
        };
        // A numeric forward reference names a definition the layout has not
        // placed yet, which GNU as has no value for here.
        let placed = |t: &str| {
            let fwd = t.ends_with('f') && numeric_label_digits(t).is_some();
            (!fwd).then(|| resolve(t)).flatten()
        };
        let v = eval_asm_expr_with_labels(text, &placed).ok_or_else(|| {
            alloc::format!("inline asm: alignment `{text}` is not constant where it stands")
        })?;
        align_spec_value(v, pow2)
            .ok_or_else(|| alloc::format!("inline asm: bad alignment `{text}` ({v})"))
    }
}

/// An alignment item with its operand resolved to a byte count, so the
/// padding, the section alignment and the mapping state all read one value.
/// `None` when the item needs no resolution.
pub(crate) fn resolve_align_item(
    item: &AsmSectionItem,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> Result<Option<AsmSectionItem>, alloc::string::String> {
    let AsmSectionItem::Align {
        spec: spec @ AlignSpec::Expr { .. },
        fill,
        max,
    } = item
    else {
        return Ok(None);
    };
    Ok(Some(AsmSectionItem::Align {
        spec: AlignSpec::Bytes(spec.bytes(resolve)?),
        fill: *fill,
        max: *max,
    }))
}

/// Parse the operands of an alignment directive: `spec[, fill[, max]]`.
/// GNU as allows an empty fill field (`.p2align e,,max`) to keep the default
/// fill while giving a max skip. `fill_width` is the directive spelling's
/// fill unit width. Returns the alignment operand's text, the optional fill,
/// and the optional maximum bytes to skip.
pub(crate) fn parse_align_operands(
    rest: &str,
    fill_width: u8,
) -> Option<(&str, Option<AlignFill>, Option<u32>)> {
    let mut fields = rest.split(',').map(str::trim);
    let spec = fields.next().filter(|s| !s.is_empty())?;
    let field = |f: Option<&str>| -> Option<Option<i64>> {
        match f {
            Some(s) if !s.is_empty() => Some(Some(parse_raw_int(s)?)),
            _ => Some(None),
        }
    };
    let fill = field(fields.next())?.map(|v| AlignFill {
        value: v as u32,
        width: fill_width,
    });
    let max = match field(fields.next())? {
        Some(v) => Some(u32::try_from(v).ok()?),
        None => None,
    };
    if fields.next().is_some() {
        return None;
    }
    Some((spec, fill, max))
}

/// Parse an alignment directive to its section item. `kind` selects the
/// operand's convention -- `.align`'s is the target's -- and `width` the
/// fill unit. A non-literal operand is kept as an expression the layout
/// resolves where the directive stands, as GNU as resolves one.
fn parse_align_item(
    kind: AlignKind,
    width: u8,
    rest: &str,
    is_aarch64: bool,
) -> Result<AsmSectionItem, alloc::string::String> {
    let bad = || alloc::format!("inline asm: bad alignment `{rest}`");
    let pow2 = match kind {
        AlignKind::Bytes => false,
        AlignKind::Pow2 => true,
        AlignKind::Arch => is_aarch64,
    };
    let (text, fill, max) = parse_align_operands(rest, width).ok_or_else(bad)?;
    let spec = match parse_raw_int(text) {
        Some(v) => AlignSpec::Bytes(align_spec_value(v, pow2).ok_or_else(bad)?),
        None if is_asm_layout_expr(text) => AlignSpec::Expr {
            text: alloc::string::String::from(text),
            pow2,
        },
        None => return Err(bad()),
    };
    Ok(AsmSectionItem::Align { spec, fill, max })
}

/// Parse one directive inside a named section. A non-directive token is an
/// instruction kept as text for the arch backend to encode.
fn parse_section_item(
    tok: &str,
    rest: &str,
    is_aarch64: bool,
) -> Result<AsmSectionItem, alloc::string::String> {
    // `.inst`'s bytes are an instruction, not a data directive.
    if tok == INST_BYTES_DIRECTIVE {
        let mut bytes = alloc::vec::Vec::new();
        for arg in split_top_commas(rest) {
            bytes.push(
                eval_const_expr(arg).ok_or_else(|| {
                    alloc::format!("inline asm: `.inst` byte `{arg}` is not constant")
                })? as u8,
            );
        }
        return Ok(AsmSectionItem::CodeBytes {
            bytes,
            relocs: alloc::vec::Vec::new(),
            short: None,
        });
    }
    if let Some(w) = data_directive_width(tok) {
        // `.word` is target-dependent: 2 bytes on x86 ELF, 4 on AArch64.
        let w = if tok == ".word" && is_aarch64 { 4 } else { w };
        let mut values = alloc::vec::Vec::new();
        // Split the value list on commas outside double quotes (a quoted
        // symbol name may contain any character).
        let (mut start, mut quoted) = (0usize, false);
        for (i, c) in rest.bytes().enumerate() {
            match c {
                b'"' => quoted = !quoted,
                b',' if !quoted => {
                    values.push(parse_section_value(rest[start..i].trim())?);
                    start = i + 1;
                }
                _ => {}
            }
        }
        values.push(parse_section_value(rest[start..].trim())?);
        return Ok(AsmSectionItem::Data {
            width: w as u8,
            values,
        });
    }
    if let Some((kind, width)) = align_directive(tok) {
        return parse_align_item(kind, width, rest, is_aarch64);
    }
    match tok {
        ".org" => {
            // `.org new-lc[, fill]`. The fill byte is the last top-level
            // comma-separated argument; the origin keeps the rest, which is
            // itself an expression and may contain commas in no other form.
            let parts = split_top_commas(rest);
            let (rest, fill) = match parts.as_slice() {
                [_] => (rest, 0u8),
                [org, f] => {
                    let v = eval_const_expr(f)
                        .ok_or_else(|| alloc::format!("inline asm: bad `.org` fill `{f}`"))?;
                    (*org, v as u8)
                }
                _ => return Err(alloc::format!("inline asm: bad `.org` operands `{rest}`")),
            };
            let rest = rest.trim();
            if let Some(n) = parse_raw_int(rest).filter(|&n| n >= 0) {
                return Ok(AsmSectionItem::Org(n as u32, fill));
            }
            // `.org label + expr`: the target is a section-local label's offset
            // plus a constant. Split on the first `+`; the label must be a
            // backward numeric reference or a symbol name. `.` is the location
            // counter, not a symbol, so it takes the expression form below.
            let (label, addend) = rest
                .split_once('+')
                .map(|(l, r)| (l.trim(), r.trim()))
                .unwrap_or((rest, "0"));
            if label != "." && (numeric_label_digits(label).is_some() || is_asm_symbol_name(label))
            {
                return Ok(AsmSectionItem::OrgLabel {
                    label: alloc::string::String::from(label),
                    addend: alloc::string::String::from(addend),
                    fill,
                });
            }
            // A general location expression, deferred to layout.
            let probe = AsmExprCtx {
                resolve: &|_| Some(AsmExprLeaf::Abs(1)),
                const_of: &|_| Some(1),
                lax_div: true,
            };
            if eval_asm_value(rest, &probe).is_ok() {
                return Ok(AsmSectionItem::OrgExpr(
                    alloc::string::String::from(rest),
                    fill,
                ));
            }
            Err(alloc::format!("inline asm: bad `.org` offset `{rest}`"))
        }
        // The space-and-fill family. `.skip` and `.space` are the same
        // directive on ELF targets; `.zero` fixes the fill at zero; `.fill`
        // repeats a multi-byte unit.
        ".skip" | ".space" | ".zero" | ".fill" => parse_fill_directive(tok, rest),
        ".ascii" | ".asciz" | ".string" => parse_string_directive(tok, rest),
        ".globl" | ".global" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            Ok(AsmSectionItem::Global(alloc::string::String::from(name)))
        }
        // `.ltorg` flushes the AArch64 literal pool accumulated since the
        // previous flush. The arch backend fills the entries in before
        // layout; on a target without a pool the directive deposits nothing.
        ".ltorg" if is_aarch64 => Ok(AsmSectionItem::LiteralPool(alloc::vec::Vec::new())),
        // Assembler-state directives with no effect on the emitted object:
        // `.extern` declares what an unresolved name already is; the arch
        // selectors admit no more than the encoder's table does. `.file` and
        // `.loc` name a source location for the debug line table, which badc
        // does not emit for asm bodies.
        ".extern" | ".arch" | ".arch_extension" | ".cpu" | ".ltorg" | ".file" | ".loc" => {
            Ok(AsmSectionItem::Bytes(alloc::vec::Vec::new()))
        }
        // `.cfi_*` describes unwind state to a DWARF consumer and deposits no
        // bytes in this section; it is carried to the frame-table builder,
        // which pairs it with the offset the materializer reaches it at.
        _ if tok.starts_with(".cfi_") => {
            // A frame operand is absolute: no leaf resolves, so an
            // expression naming a label folds to nothing and is rejected.
            let ctx = AsmExprCtx {
                resolve: &|_| None,
                const_of: &|_| None,
                lax_div: false,
            };
            let eval = |s: &str| eval_asm_value(s, &ctx).ok().and_then(|v| v.to_abs());
            match super::cfi::parse_cfi_directive(tok, rest, &eval) {
                Ok(Some(op)) => Ok(AsmSectionItem::Cfi(op)),
                Ok(None) => Ok(AsmSectionItem::Bytes(alloc::vec::Vec::new())),
                Err(m) => Err(alloc::format!("inline asm: {m}")),
            }
        }
        // `.code16` / `.code32` / `.code64` select the x86 encoding mode for
        // the instructions that follow. The directive deposits no bytes; it
        // reaches the arch backend as a code item, which reads it as the
        // encoder state the rest of the stream assembles under.
        ".code16" | ".code32" | ".code64" if !is_aarch64 => {
            Ok(AsmSectionItem::Code(alloc::string::String::from(tok)))
        }
        ".weak" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            Ok(AsmSectionItem::Weak(alloc::string::String::from(name)))
        }
        ".local" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            Ok(AsmSectionItem::Local(alloc::string::String::from(name)))
        }
        ".hidden" | ".internal" | ".protected" => {
            let name = rest.trim();
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`"));
            }
            use crate::c5::program::SymVisibility;
            let vis = match tok {
                ".internal" => SymVisibility::Internal,
                ".protected" => SymVisibility::Protected,
                _ => SymVisibility::Hidden,
            };
            Ok(AsmSectionItem::Visibility {
                name: alloc::string::String::from(name),
                vis,
            })
        }
        ".reloc" => parse_reloc_directive(rest),
        // A `.set` / `.equ` names a symbol (`.set alias, target`, a unit-level
        // alias), an absolute value (a constant the expander re-emitted for a
        // name with external linkage), or an expression over section-local
        // locations (`.set .Lsz, . - f`). `.equiv` assigns the same way and
        // adds a redefinition error. TODO diagnose a redefinition.
        ".set" | ".equ" | ".equiv" => {
            // `.set ., expr` moves the location counter, as `.org` does; the
            // kernel's exception-vector table places its entries that way.
            if let Some(v) = rest.trim_start().strip_prefix('.')
                && let Some(v) = v.trim_start().strip_prefix(',')
            {
                return parse_section_item(".org", v.trim(), is_aarch64);
            }
            let (name, value) = rest
                .split_once(',')
                .map(|(n, t)| (n.trim(), t.trim()))
                .filter(|(n, t)| is_asm_symbol_name(n) && !t.is_empty())
                .ok_or_else(|| alloc::format!("inline asm: `{tok} {rest}` is not `name, value`"))?;
            let name = alloc::string::String::from(name);
            // `.set name, .` values the location counter, not an alias.
            if is_asm_symbol_name(value) && value != "." {
                return Ok(AsmSectionItem::SymSet {
                    name,
                    target: alloc::string::String::from(value),
                });
            }
            if let Some(v) = parse_raw_int(value) {
                return Ok(AsmSectionItem::AbsSet { name, value: v });
            }
            Ok(AsmSectionItem::SetExpr {
                name,
                expr: alloc::string::String::from(value),
            })
        }
        ".incbin" => parse_incbin_directive(rest),
        ".type" => parse_type_directive(rest),
        ".size" => parse_size_directive(rest),
        // `name = expr` in a section is the assignment spelling of `.set`
        // (the piggyback length constants). The expander folds the constant
        // form it sees; one reaching here carries an expression or a symbol.
        _ if !tok.starts_with('.')
            && (rest.starts_with('=') && !rest.starts_with("==")
                || tok
                    .split_once('=')
                    .is_some_and(|(n, e)| is_asm_symbol_name(n) && !e.starts_with('='))) =>
        {
            let (name, expr) = match rest.strip_prefix('=') {
                Some(e) => (tok, alloc::string::String::from(e.trim())),
                None => {
                    let (n, e) = tok.split_once('=').expect("guard admits an assignment");
                    (n, alloc::format!("{} {rest}", e.trim()))
                }
            };
            if !is_asm_symbol_name(name) {
                return Err(alloc::format!("inline asm: bad assignment `{tok} {rest}`"));
            }
            let expr = alloc::string::String::from(expr.trim());
            if is_asm_symbol_name(&expr) && expr != "." {
                return Ok(AsmSectionItem::SymSet {
                    name: alloc::string::String::from(name),
                    target: expr,
                });
            }
            Ok(AsmSectionItem::SetExpr {
                name: alloc::string::String::from(name),
                expr,
            })
        }
        // A non-directive token is an instruction: the ALTERNATIVE replacement
        // in `.altinstr_replacement,"ax"`, or a trampoline body assembled into
        // `.rodata`. Keep it as text; the arch backend encodes it to bytes and
        // relocations. A token spelled as a directive (`.`-prefixed) that is
        // not recognized is rejected below.
        _ if !tok.starts_with('.') => {
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

/// Parse the space-and-fill family into a single repetition item.
///
/// `.skip count[, fill]` and `.space count[, fill]` repeat one fill byte
/// (zero by default). `.zero count` fixes the fill at zero. `.fill
/// repeat[, size[, value]]` repeats the low `size` bytes of `value`, with
/// `size` defaulting to one and clamped to eight as GNU as does. The count is
/// kept as an expression: it may reference an operand constant, and is
/// resolved once the operand values are known.
pub(crate) fn parse_fill_operands<'a>(
    tok: &str,
    rest: &'a str,
) -> Result<(&'a str, u8, u32), alloc::string::String> {
    let mut fields = rest.split(',').map(str::trim);
    let count = fields.next().unwrap_or("").trim();
    if count.is_empty() {
        return Err(alloc::format!("inline asm: `{tok}` needs a count"));
    }
    let num = |f: Option<&str>| -> Result<Option<i64>, alloc::string::String> {
        match f {
            Some(s) if !s.is_empty() => Ok(Some(parse_raw_int(s).ok_or_else(|| {
                alloc::format!("inline asm: `{tok}` operand `{s}` is not a constant")
            })?)),
            _ => Ok(None),
        }
    };
    let (unit, value) = match tok {
        ".fill" => {
            let size = num(fields.next())?.unwrap_or(1);
            if size < 0 {
                return Err(alloc::format!("inline asm: bad `.fill` size `{size}`"));
            }
            // GNU as clamps a unit above eight rather than rejecting it.
            (size.min(8) as u8, num(fields.next())?.unwrap_or(0) as u32)
        }
        ".zero" => (1u8, 0u32),
        _ => (1u8, num(fields.next())?.unwrap_or(0) as u32 & 0xff),
    };
    if fields.next().is_some() {
        return Err(alloc::format!("inline asm: too many `{tok}` operands"));
    }
    Ok((count, unit, value))
}

/// True for a directive of the space-and-fill family.
pub(crate) fn is_fill_directive(tok: &str) -> bool {
    matches!(tok, ".skip" | ".space" | ".zero" | ".fill")
}

/// `.ascii` / `.asciz` / `.string`: a comma-separated list of string
/// operands. Adjacent literals within one operand concatenate; `.asciz` and
/// `.string` append one NUL per operand, `.ascii` appends none (GNU as).
/// Escapes are the assembler's: the C parse already consumed one level, so
/// `\\n` in source arrives here as `\n`.
fn parse_string_directive(tok: &str, rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let b = rest.as_bytes();
    let mut bytes: alloc::vec::Vec<u8> = alloc::vec::Vec::new();
    let mut i = 0usize;
    let skip_ws = |i: &mut usize| {
        while *i < b.len() && b[*i].is_ascii_whitespace() {
            *i += 1;
        }
    };
    loop {
        // One operand: one or more adjacent string literals.
        let mut any = false;
        loop {
            skip_ws(&mut i);
            if b.get(i) != Some(&b'"') {
                break;
            }
            i += 1;
            loop {
                let c = *b.get(i).ok_or_else(|| {
                    alloc::format!("inline asm: unterminated string in `{tok} {rest}`")
                })?;
                i += 1;
                match c {
                    b'"' => break,
                    b'\\' => {
                        let e = *b.get(i).ok_or_else(|| {
                            alloc::format!("inline asm: unterminated escape in `{tok} {rest}`")
                        })?;
                        i += 1;
                        match e {
                            b'n' => bytes.push(b'\n'),
                            b't' => bytes.push(b'\t'),
                            b'r' => bytes.push(b'\r'),
                            b'b' => bytes.push(8),
                            b'f' => bytes.push(12),
                            // Up to three octal digits.
                            b'0'..=b'7' => {
                                let mut v = (e - b'0') as u32;
                                for _ in 0..2 {
                                    match b.get(i) {
                                        Some(&d @ b'0'..=b'7') => {
                                            v = v * 8 + (d - b'0') as u32;
                                            i += 1;
                                        }
                                        _ => break,
                                    }
                                }
                                bytes.push(v as u8);
                            }
                            b'x' => {
                                // GNU as folds any run of hex digits mod 256.
                                let mut v = 0u32;
                                let mut n = 0;
                                while let Some(d) = b.get(i).and_then(|c| (*c as char).to_digit(16))
                                {
                                    v = (v * 16 + d) & 0xff;
                                    i += 1;
                                    n += 1;
                                }
                                if n == 0 {
                                    return Err(alloc::format!(
                                        "inline asm: `\\x` without hex digits in `{tok} {rest}`"
                                    ));
                                }
                                bytes.push(v as u8);
                            }
                            // `\"`, `\\`, and any other escape: the character.
                            _ => bytes.push(e),
                        }
                    }
                    _ => bytes.push(c),
                }
            }
            any = true;
        }
        if !any {
            return Err(alloc::format!(
                "inline asm: string literal expected in `{tok} {rest}`"
            ));
        }
        if tok != ".ascii" {
            bytes.push(0);
        }
        skip_ws(&mut i);
        match b.get(i) {
            None => break,
            Some(b',') => i += 1,
            Some(_) => {
                return Err(alloc::format!(
                    "inline asm: junk after string in `{tok} {rest}`"
                ));
            }
        }
    }
    Ok(AsmSectionItem::Bytes(bytes))
}

fn parse_fill_directive(tok: &str, rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let (count, unit, value) = parse_fill_operands(tok, rest)?;
    Ok(AsmSectionItem::Fill {
        count: alloc::string::String::from(count),
        unit,
        value,
    })
}

/// Resolve a `.skip` / `.fill` repetition count. A negative count emits
/// nothing, as GNU as does for `.skip` of a negative expression.
fn eval_fill_count(
    expr: &str,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<i64, alloc::string::String> {
    let n = eval_asm_count(expr, const_of).ok_or_else(|| {
        alloc::format!("inline asm: fill count `{expr}` is not a constant expression")
    })?;
    Ok(n.max(0))
}

/// Fill-count evaluation with label leaves resolved through `resolve`
/// (section-relative offsets, so same-section differences fold) and the
/// location counter `.` at section offset `here` (`.fill sym - ., 1, 0xcc`
/// pads to a label).
fn eval_fill_count_with(
    expr: &str,
    here: i64,
    const_of: &dyn Fn(u8) -> Option<i64>,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> Option<i64> {
    let leaf = |t: &str| {
        if t == "." {
            return Some(AsmExprLeaf::Abs(here));
        }
        resolve(t).map(AsmExprLeaf::Abs)
    };
    let ctx = AsmExprCtx {
        resolve: &leaf,
        const_of,
        lax_div: false,
    };
    eval_asm_value(expr, &ctx).ok().and_then(|v| v.to_abs())
}

/// Append `count` repetitions of one fill unit: the low `unit` bytes of the
/// value zero-extended to eight, little-endian, as GNU as renders it.
pub(crate) fn push_fill(out: &mut alloc::vec::Vec<u8>, count: i64, unit: u8, value: u32) {
    let bytes = (value as u64).to_le_bytes();
    for _ in 0..count {
        out.extend_from_slice(&bytes[..unit as usize]);
    }
}

/// Split a directive's leading symbol name from the rest of its operands.
/// GNU as ends the name at the first non-symbol character and then skips one
/// optional comma, so `name, rest` and `name rest` are the same input.
fn split_symbol_operand(rest: &str) -> (&str, &str) {
    let rest = rest.trim();
    let end = rest
        .find(|c: char| !(c.is_ascii_alphanumeric() || matches!(c, '_' | '.' | '$')))
        .unwrap_or(rest.len());
    let (name, tail) = rest.split_at(end);
    let tail = tail.trim_start();
    (name, tail.strip_prefix(',').unwrap_or(tail).trim())
}

/// `.type name[,] type`. GNU as makes the comma optional and reads the type
/// word bare or behind one `@` / `%` / `#` / `"` sigil, so `.type f STT_FUNC`
/// and `.type f, @function` name the same type. Each ELF type has a bare and
/// an `STT_` spelling; badc's symbol model covers function, object, and
/// untyped, and any other type is rejected.
fn parse_type_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let (name, ty) = split_symbol_operand(rest);
    if !is_asm_symbol_name(name) {
        return Err(alloc::format!("inline asm: bad `.type` symbol `{name}`"));
    }
    if ty.is_empty() {
        return Err(alloc::format!(
            "inline asm: `.type` expects `name, @type`, got `{rest}`"
        ));
    }
    let word = ty
        .strip_prefix(['@', '%', '#', '"'])
        .unwrap_or(ty)
        .trim_end_matches('"');
    let sym_type = match word {
        "function" | "STT_FUNC" => AsmSymType::Func,
        "object" | "STT_OBJECT" => AsmSymType::Object,
        "notype" | "STT_NOTYPE" => AsmSymType::NoType,
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

/// `.incbin "path"[, skip[, count]]`: splice the named file's raw bytes at
/// this point in the section image. The path resolves as GNU as resolves it,
/// against the assembler's working directory; badc compiles from the same
/// directory, so a relative path reads relative to the compile cwd.
fn parse_incbin_directive(rest: &str) -> Result<AsmSectionItem, alloc::string::String> {
    let rest = rest.trim();
    let (path, args) = rest
        .strip_prefix('"')
        .and_then(|r| r.split_once('"'))
        .ok_or_else(|| {
            alloc::format!("inline asm: `.incbin` expects a quoted path, got `{rest}`")
        })?;
    let args = args.trim().trim_start_matches(',').trim();
    if !args.is_empty() {
        // TODO `.incbin` skip / count arguments.
        return Err(alloc::format!(
            "inline asm: `.incbin` skip/count arguments are not supported (`{rest}`)"
        ));
    }
    #[cfg(feature = "std")]
    {
        let bytes = std::fs::read(path).map_err(|e| {
            let resolved = std::env::current_dir()
                .map(|d| d.join(path).display().to_string())
                .unwrap_or_else(|_| alloc::string::String::from(path));
            alloc::format!("inline asm: `.incbin \"{path}\"`: cannot read `{resolved}`: {e}")
        })?;
        Ok(AsmSectionItem::Bytes(bytes))
    }
    #[cfg(not(feature = "std"))]
    {
        Err(alloc::format!(
            "inline asm: `.incbin \"{path}\"` needs host filesystem access"
        ))
    }
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
    // The operand reference may be wrapped in one paren and subtract the
    // field's own position (`.long (%l[label]) - .`, canonicalized to
    // `(%l0) - .`); the closing paren must follow the operand index.
    let (a, paren) = match a.trim().strip_prefix('(') {
        Some(r) => (r.trim_start(), true),
        None => (a, false),
    };
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
    let after = rest[end..].trim_start();
    let after = if paren {
        after.strip_prefix(')')?.trim_start()
    } else {
        after
    };
    let (tail, pcrel) = match strip_trailing_pcrel(after.trim()) {
        Some(base) => (base, true),
        None => (after.trim(), false),
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
    if let Some(v) = eval_const_expr_wide(a) {
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
    match parse_reloc_expr(a) {
        Ok(v) => Ok(v),
        // Anything richer defers to the location-value evaluator at
        // materialize time, when label offsets and the location counter are
        // known. Placeholder leaves check the syntax only.
        Err(e) => {
            let probe = AsmExprCtx {
                resolve: &|_| Some(AsmExprLeaf::Abs(1)),
                const_of: &|_| Some(1),
                lax_div: true,
            };
            match eval_asm_value(a, &probe) {
                Ok(_) => Ok(AsmSectionValue::LocExpr(alloc::string::String::from(a))),
                Err(_) => Err(e),
            }
        }
    }
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
/// enclosing `- ( ... )`. A double-quoted run is opaque (a quoted symbol name
/// may contain any character). Returns false on unbalanced parentheses or an
/// unterminated quote.
pub(crate) fn flatten_addsub_terms<'a>(
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
    let (mut depth, mut start, mut quoted) = (0i32, i, false);
    while i < b.len() {
        match b[i] {
            b'"' => quoted = !quoted,
            _ if quoted => {}
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
    depth == 0 && !quoted && push_reloc_term(&s[start..], neg, out)
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
    // GNU as accepts a double-quoted symbol name wherever a bare one is
    // valid; the quotes are not part of the name.
    fn unquote(s: &str) -> Option<&str> {
        s.strip_prefix('"')
            .and_then(|r| r.strip_suffix('"'))
            .filter(|n| !n.is_empty() && !n.contains('"'))
    }
    // A term is a constant when it evaluates with the operand resolver treated
    // as present; a label or symbol reference does not.
    let is_const = |t: &str| eval_const_expr_ops(t, &|_| Some(0)).is_some();
    let (mut base, mut neg_name) = (None, None);
    let (mut names, mut dots) = (0usize, 0usize);
    let mut addend = alloc::string::String::new();
    for &(neg, t) in &terms {
        let (t, quoted) = match unquote(t) {
            Some(n) => (n, true),
            None => (t, false),
        };
        if quoted {
            names += 1;
            if neg {
                neg_name = Some(t);
            } else {
                base = Some(t);
            }
        } else if t == "." {
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
///
/// A member / element subscript nests one constant `Add` per level
/// (`&global.field[const]` is `&global +i field_off +i elem_off`), so the base
/// and its total offset are folded through the whole constant-add chain.
pub(crate) fn asm_operand_data_target(
    insts: &[crate::c5::ir::Inst],
    arg: u32,
    extern_name: &dyn Fn(u32) -> Option<alloc::string::String>,
) -> Option<(AsmSectionTarget, i64)> {
    let (base, off) = asm_operand_data_base(insts, arg)?;
    Some(match extern_name(base) {
        Some(name) => (AsmSectionTarget::Symbol(name), off),
        None => (AsmSectionTarget::Data(off as u64), 0),
    })
}

/// Load width / signedness of an integer [`LoadKind`]; `None` for the FP kinds.
fn load_int_kind(kind: crate::c5::ir::LoadKind) -> Option<(u8, bool)> {
    use crate::c5::ir::LoadKind as K;
    Some(match kind {
        K::I8 => (1, true),
        K::U8 => (1, false),
        K::I16 => (2, true),
        K::U16 => (2, false),
        K::I32 => (4, true),
        K::U32 => (4, false),
        K::I64 => (8, true),
        K::F32 | K::F64 => return None,
    })
}

/// `c` truncated to `width` bytes, then sign- or zero-extended to 64 bits.
fn extend_to(c: i64, width: u8, signed: bool) -> i64 {
    if width >= 8 {
        return c;
    }
    let bits = width as u32 * 8;
    let m = (c as u64) & ((1u64 << bits) - 1);
    if signed && (m >> (bits - 1)) & 1 == 1 {
        (m | !((1u64 << bits) - 1)) as i64
    } else {
        m as i64
    }
}

/// Recover the constant of an `i`-class inline-asm operand that survived as a
/// load of a constant local. C99 6.5p6 requires an `"i"` operand to be an
/// integer constant expression; a function opted out of slot promotion (a
/// computed goto leaves `mem2reg` unable to number the CFG, so it promotes
/// nothing) keeps that constant as a `StoreLocal`(constant) + `LoadLocal` pair,
/// which GNU as still folds. Recover it through the load and any width
/// extension. Returns `None` for a genuinely non-constant operand (rejected as
/// GNU as does).
pub(crate) fn asm_operand_local_const(func: &crate::c5::ir::FunctionSsa, arg: u32) -> Option<i64> {
    asm_operand_const_rec(func, arg, 0)
}

fn asm_operand_const_rec(func: &crate::c5::ir::FunctionSsa, arg: u32, depth: u32) -> Option<i64> {
    use crate::c5::ir::{Inst, StoreKind};
    if depth > 8 {
        return None;
    }
    match func.insts.get(arg as usize)? {
        Inst::Imm(v) => Some(*v),
        Inst::Extend { value, kind } => {
            let (w, signed) = load_int_kind(*kind)?;
            Some(extend_to(
                asm_operand_const_rec(func, *value, depth + 1)?,
                w,
                signed,
            ))
        }
        &Inst::LoadLocal {
            off,
            kind,
            volatile: false,
        } => {
            // Reaching-definition search backward over the CFG. Every path from
            // the load must reach a store of the same constant of the load's
            // width before any invalidator, so the value read is that constant.
            // A frame-packed slot (reused for a disjoint-lifetime, address-taken
            // variable) is handled correctly because the reaching store, not the
            // whole slot, decides the value; a dead `do {} while (0)` back edge
            // is followed through and finds no further store. Invalidators are a
            // write that may alias the slot once its address has escaped (a
            // call, a memory-clobbering asm, an atomic, a pointer store), a
            // re-address, or a volatile access. Each block is scanned once (the
            // load's own block first over its prefix, then in full if a back
            // edge re-enters it).
            let (lw, signed) = load_int_kind(kind)?;
            let preds = super::mem2reg::predecessors(func);
            // Blocks reachable from the entry: a dead predecessor (an
            // eliminated `do {} while (0)` latch is one) never executes, so its
            // edge carries no runtime value and must not be searched.
            let reachable = {
                let mut seen = alloc::vec![false; func.blocks.len()];
                let mut stack = alloc::vec![0usize];
                if let Some(s) = seen.get_mut(0) {
                    *s = true;
                }
                while let Some(b) = stack.pop() {
                    for s in super::mem2reg::successors(
                        &func.blocks[b].terminator,
                        &func.computed_goto_targets,
                        &func.jump_tables,
                    ) {
                        if !core::mem::replace(&mut seen[s as usize], true) {
                            stack.push(s as usize);
                        }
                    }
                }
                seen
            };
            let lb = func
                .blocks
                .iter()
                .position(|b| b.inst_range.contains(&arg))?;
            let mut result: Option<i64> = None;
            let mut visited = alloc::vec![false; func.blocks.len()];
            let mut work: alloc::vec::Vec<(usize, u32)> = alloc::vec![(lb, arg)];
            let mut first = true;
            while let Some((b, upper)) = work.pop() {
                if !first {
                    if visited[b] {
                        continue;
                    }
                    visited[b] = true;
                }
                first = false;
                let start = func.blocks[b].inst_range.start;
                let mut i = upper;
                let mut found = false;
                while i > start {
                    i -= 1;
                    match &func.insts[i as usize] {
                        Inst::StoreLocal {
                            off: o,
                            value,
                            kind: sk,
                            volatile,
                        } if *o == off => {
                            if *volatile {
                                return None;
                            }
                            let sw = match sk {
                                StoreKind::I8 => 1u8,
                                StoreKind::I16 => 2,
                                StoreKind::I32 => 4,
                                StoreKind::I64 => 8,
                                StoreKind::F32 | StoreKind::F64 => return None,
                            };
                            if sw != lw {
                                return None;
                            }
                            let c = extend_to(
                                asm_operand_const_rec(func, *value, depth + 1)?,
                                lw,
                                signed,
                            );
                            match result {
                                None => result = Some(c),
                                Some(p) if p == c => {}
                                _ => return None,
                            }
                            found = true;
                            break;
                        }
                        Inst::LocalAddr(o) if *o == off => return None,
                        Inst::LoadLocal {
                            off: o,
                            volatile: true,
                            ..
                        } if *o == off => return None,
                        bar @ (Inst::InlineAsm { .. }
                        | Inst::Call { .. }
                        | Inst::CallExt { .. }
                        | Inst::CallIndirect { .. }
                        | Inst::Intrinsic { .. }
                        | Inst::AtomicRmw { .. }
                        | Inst::AtomicCas { .. }
                        | Inst::Store { .. }
                        | Inst::StoreIndexed { .. }
                        | Inst::SegStore { .. }
                        | Inst::Mcpy { .. }) => {
                            // An asm that neither clobbers memory nor writes an
                            // output operand cannot reach the escaped slot.
                            if let Inst::InlineAsm { asm, .. } = bar
                                && !asm.clobber_memory
                                && !asm.operands.iter().any(|o| o.is_output)
                            {
                                continue;
                            }
                            return None;
                        }
                        _ => {}
                    }
                }
                if found {
                    continue;
                }
                let live: alloc::vec::Vec<crate::c5::ir::BlockId> = preds[b]
                    .iter()
                    .copied()
                    .filter(|&p| reachable[p as usize])
                    .collect();
                if live.is_empty() {
                    return None;
                }
                for p in live {
                    work.push((p as usize, func.blocks[p as usize].inst_range.end));
                }
            }
            result
        }
        _ => None,
    }
}

/// Fold a C99 6.6p9 address constant to the value-id naming its object or
/// function and the constant byte offset added to it, walking a chain of
/// constant `Add`s (`&global`, `&global.field`, `&global.field[const]`).
/// Returns `None` for a non-constant or non-address shape.
///
/// A cast between object-pointer and integer types of the same width leaves
/// no instruction of its own, so a cast chain reaches this walk as its base
/// alone. A cast that narrows lowers to a mask or an `Extend`, neither of
/// which the walk crosses -- the truncated value is not the address.
///
/// SSA operands precede their defs, so the walk strictly decreases the
/// value-id and terminates. The base's own payload stays with the caller:
/// `ImmData` carries a data-byte offset, `ImmCode` an entry PC.
fn asm_operand_addr_base(insts: &[crate::c5::ir::Inst], arg: u32) -> Option<(u32, i64)> {
    use crate::c5::ir::{BinOp, Inst};
    let (mut vid, mut off) = (arg, 0i64);
    loop {
        let (next, add) = match insts.get(vid as usize)? {
            Inst::ImmData(_) | Inst::ImmCode(_) => return Some((vid, off)),
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm,
            } => (*lhs, *rhs_imm),
            Inst::Binop {
                op: BinOp::Add,
                lhs,
                rhs,
            } => match (insts.get(*lhs as usize), insts.get(*rhs as usize)) {
                (_, Some(Inst::Imm(c))) => (*lhs, *c),
                (Some(Inst::Imm(c)), _) => (*rhs, *c),
                _ => return None,
            },
            _ => return None,
        };
        if next >= vid {
            return None;
        }
        off += add;
        vid = next;
    }
}

/// [`asm_operand_addr_base`] restricted to a data object: the base `ImmData`
/// value-id and the total byte offset, the object's own offset included.
fn asm_operand_data_base(insts: &[crate::c5::ir::Inst], arg: u32) -> Option<(u32, i64)> {
    let (vid, off) = asm_operand_addr_base(insts, arg)?;
    match insts.get(vid as usize)? {
        crate::c5::ir::Inst::ImmData(o) => Some((vid, off + *o)),
        _ => None,
    }
}

/// [`asm_operand_addr_base`] restricted to a function: the base `ImmCode`
/// value-id, the function's entry PC, and the byte offset added to it.
pub(crate) fn asm_operand_code_base(
    insts: &[crate::c5::ir::Inst],
    arg: u32,
) -> Option<(u32, usize, i64)> {
    let (vid, off) = asm_operand_addr_base(insts, arg)?;
    match insts.get(vid as usize)? {
        crate::c5::ir::Inst::ImmCode(pc) => Some((vid, *pc, off)),
        _ => None,
    }
}

/// Section-relative offsets of the labels one materialize call defines.
/// A same-section label difference (`775f - 774f`, an alternatives
/// replacement length) folds to a constant from these even when the field
/// referencing it sits in another section, and the main stream's `.skip`
/// padding sizes itself from them. Offsets continue from the sink lengths
/// the call starts with, so they agree with the materialized layout.
#[derive(Default)]
pub(crate) struct SectionLabelOffsets {
    map: alloc::collections::BTreeMap<alloc::string::String, (alloc::string::String, i64)>,
    /// `.set` / `.equ` symbols assigned an expression over section-local
    /// locations, each holding the expression's value at its assignment.
    syms: alloc::collections::BTreeMap<alloc::string::String, i64>,
    /// Branches the layout keeps in their long form, by block and item index.
    /// Everything the arch encoder marked relaxable and that is absent here
    /// takes its short form; these offsets were measured under that choice,
    /// so the materializer has to encode from the same set.
    long: AsmRelaxSet,
    /// Section name -> its identity key. GNU as gives every section a
    /// symbol of the section's own name whose value is the section start,
    /// so a bare section name is usable in an expression.
    sections: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    /// Section-relative offset of each top-level item, by block and item
    /// index. A `.rept` body item is absent: its statements occupy one
    /// offset per repetition, so the location counter has no value there.
    places: alloc::collections::BTreeMap<(usize, usize), i64>,
    /// `.set name, symbol` assignments. A reference to one reads the
    /// location the chain ends at, as GNU as resolves it.
    aliases: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    /// Byte alignment of each alignment directive whose operand is an
    /// expression, by block and item index. Measured where the directive
    /// stands, against the labels placed before it, and read back by the
    /// materializer so both walks lay the same gap.
    aligns: alloc::collections::BTreeMap<(usize, usize), u32>,
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
    /// The value of a `.set` symbol assigned a section-local expression.
    pub(crate) fn symbol(&self, name: &str) -> Option<i64> {
        self.syms.get(name).copied()
    }
    /// Whether a relaxable branch keeps its long form under these offsets.
    fn long_form(&self, site: (usize, usize)) -> bool {
        self.long.contains(&site)
    }
    /// The identity key of the section a bare section name refers to.
    pub(crate) fn section_named(&self, name: &str) -> Option<&str> {
        self.sections.get(name).map(|k| k.as_str())
    }
    /// The section-relative offset an item starts at, or `None` where the
    /// item has no single place.
    pub(crate) fn place(&self, site: (usize, usize)) -> Option<i64> {
        self.places.get(&site).copied()
    }
    /// The byte alignment measured for an expression-valued alignment
    /// directive.
    fn align_of(&self, site: (usize, usize)) -> Option<u32> {
        self.aligns.get(&site).copied()
    }
    /// The `.set name, symbol` target of a name, or `None` when the section
    /// defines the name itself -- a label or an assigned value wins over an
    /// assignment of the same name, as it does when valuing a `.set`.
    fn alias(&self, name: &str) -> Option<&str> {
        if self
            .map
            .contains_key(numeric_label_digits(name).unwrap_or(name))
            || self.syms.contains_key(name)
        {
            return None;
        }
        self.aliases.get(name).map(|t| t.as_str())
    }
    /// Follow a `.set` chain to the name it ends at; the depth limit ends a
    /// cycle. A name with no assignment is its own target.
    pub(crate) fn alias_target<'a>(&'a self, name: &'a str) -> &'a str {
        let mut t = name;
        for _ in 0..ASM_ALIAS_DEPTH_LIMIT {
            match self.alias(t) {
                Some(next) => t = next,
                None => break,
            }
        }
        t
    }
}

/// Relaxable branches identified by `(block index, item index)`.
type AsmRelaxSet = alloc::collections::BTreeSet<(usize, usize)>;

/// A relaxable branch as one measurement round placed it, by block and
/// item index, with the section offset the instruction starts at.
struct AsmRelaxSite {
    site: (usize, usize),
    at: i64,
}

/// Section name -> identity key over the blocks being laid out and the
/// sections the sink already holds. A name defined by both agrees, the key
/// being a function of the section's own attributes.
fn section_name_keys(
    blocks: &[AsmSectionBlock],
    sink: &AsmSectionSink,
) -> alloc::collections::BTreeMap<alloc::string::String, alloc::string::String> {
    blocks
        .iter()
        .map(|b| (b.name.clone(), section_key(b)))
        .chain(sink.iter().map(|s| (s.name.clone(), section_key_of(s))))
        .collect()
}

/// Evaluate a `.set` value over section-local locations: `.` is the offset at
/// the assignment, an identifier is a label, a symbol an earlier `.set`
/// assigned, or an operand constant. Only an absolute result is admitted --
/// same-space terms fold, anything symbolic is rejected. GNU as also gives a
/// location-valued assignment a section-relative symbol, which a referencing
/// field takes a relocation against. TODO location-valued section symbols.
/// Longest `.set name, symbol` chain followed when valuing an expression.
const ASM_ALIAS_DEPTH_LIMIT: usize = 16;

#[allow(clippy::too_many_arguments)]
fn eval_section_set_expr(
    name: &str,
    expr: &str,
    key: &str,
    at: i64,
    labels: &alloc::collections::BTreeMap<alloc::string::String, (alloc::string::String, i64)>,
    syms: &alloc::collections::BTreeMap<alloc::string::String, i64>,
    aliases: &alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    sections: &alloc::collections::BTreeMap<alloc::string::String, alloc::string::String>,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<SectionSetValue, alloc::string::String> {
    let resolve = |t: &str| -> Option<AsmExprLeaf> {
        if t == "." {
            return Some(AsmExprLeaf::Loc(AsmExprTerm {
                space: Some((AsmSpace::Section(alloc::string::String::from(key)), at)),
                target: AsmSectionTarget::OwnSection(at as u32),
            }));
        }
        if let Some(v) = syms.get(t) {
            return Some(AsmExprLeaf::Abs(*v));
        }
        // Follow a `.set name, symbol` chain to the label it names.
        let mut t = t;
        for _ in 0..ASM_ALIAS_DEPTH_LIMIT {
            match labels.get(numeric_label_digits(t).unwrap_or(t)) {
                Some((sk, off)) => {
                    return Some(AsmExprLeaf::Loc(AsmExprTerm {
                        space: Some((AsmSpace::Section(sk.clone()), *off)),
                        target: AsmSectionTarget::Symbol(alloc::string::String::from(t)),
                    }));
                }
                None => match aliases.get(t) {
                    Some(next) => t = next.as_str(),
                    // Last, so a label of the same name wins.
                    None => return sections.get(t).map(|sk| section_start_leaf(sk)),
                },
            }
        }
        None
    };
    let ctx = AsmExprCtx {
        resolve: &resolve,
        const_of,
        lax_div: false,
    };
    let v = eval_asm_value(expr, &ctx)
        .map_err(|e| alloc::format!("inline asm: `.set {name}, {expr}`: {e}"))?;
    if let Some(c) = v.to_abs() {
        return Ok(SectionSetValue::Abs(c));
    }
    // `.set x, .` and `.set x, label + k`: the name takes the location, and
    // reads of it resolve like a label's.
    match (&v.pos, &v.neg) {
        (
            Some(AsmExprTerm {
                space: Some((AsmSpace::Section(sk), off)),
                ..
            }),
            None,
        ) => Ok(SectionSetValue::Loc(sk.clone(), off + v.add)),
        _ => Err(alloc::format!(
            "inline asm: `.set {name}, {expr}` is not an absolute value or a location"
        )),
    }
}

/// A `.set` assignment's value: an absolute constant, or a location of a
/// section of this unit.
enum SectionSetValue {
    Abs(i64),
    Loc(alloc::string::String, i64),
}

/// The `(name, flags, sh_type)` identity key of a section block, as the
/// measurement map and the expression spaces use it. Subsections share the
/// key: they are ordered blocks of one section.
pub(crate) fn section_key(b: &AsmSectionBlock) -> alloc::string::String {
    alloc::format!("{}\u{0}{}\u{0}{:?}", b.name, b.flags, b.sh_type)
}

/// The same identity key for a section already in the sink.
pub(crate) fn section_key_of(s: &AsmSection) -> alloc::string::String {
    alloc::format!("{}\u{0}{}\u{0}{:?}", s.name, s.flags, s.sh_type)
}

/// Fold an instruction operand expression, assembled into section `key`, to
/// the absolute value GNU as requires there: an instruction field carries no
/// relocation, so the expression has to reduce to a literal, an assigned
/// symbol, or a difference of two labels of one section. `here` is the
/// section offset the instruction is placed at, the value of the location
/// counter; `None` where the statement has no single place.
pub(crate) fn fold_asm_operand_expr(
    expr: &str,
    key: &str,
    here: Option<i64>,
    measured: &SectionLabelOffsets,
) -> Result<i64, alloc::string::String> {
    let sink_labels = AsmSinkLabels::new();
    let num_unique = alloc::collections::BTreeMap::new();
    let resolve = |t: &str| {
        let at = if t == "." { here? } else { 0 };
        section_expr_leaf(t, key, at, measured, &sink_labels, &num_unique, &|_| None)
    };
    let ctx = AsmExprCtx {
        resolve: &resolve,
        const_of: &|_| None,
        lax_div: false,
    };
    let v = eval_asm_value(expr, &ctx).map_err(|e| alloc::format!("inline asm: `{expr}`: {e}"))?;
    match resolve_asm_value(v, None) {
        Ok(AsmResolved::Abs(c)) => Ok(c),
        _ => Err(alloc::format!(
            "inline asm: `{expr}` is not an absolute value in an instruction operand"
        )),
    }
}

/// Block processing order: stable by subsection number, so a section's
/// subsection-1 blocks lay out after every subsection-0 block while blocks
/// of one subsection keep their source order. Measurement and
/// materialization must walk the same order.
pub(crate) fn subsection_order(blocks: &[AsmSectionBlock]) -> alloc::vec::Vec<usize> {
    let mut order: alloc::vec::Vec<usize> = (0..blocks.len()).collect();
    order.sort_by_key(|&i| blocks[i].subsection);
    order
}

/// Resolve one leaf of a location expression evaluated inside section `key`
/// with the location counter at `here`: the counter itself, a `.set` value,
/// a template label of the enclosing statement, a section label of this
/// call, or a label an earlier statement left in the sink. A name none of
/// those define takes the value of the name its `.set name, symbol` chain
/// ends at; its relocation still names what the source wrote, as GNU as
/// resolves the chain for the value alone. `None` is an undefined symbol. A
/// numeric reference binds only within this call, per GNU as label locality.
fn section_expr_leaf(
    t: &str,
    key: &str,
    here: i64,
    measured: &SectionLabelOffsets,
    sink_labels: &AsmSinkLabels,
    num_unique: &alloc::collections::BTreeMap<&str, alloc::string::String>,
    label_off: &dyn Fn(&str) -> Option<LabelLoc>,
) -> Option<AsmExprLeaf> {
    if t == "." {
        return Some(AsmExprLeaf::Loc(AsmExprTerm {
            space: Some((AsmSpace::Section(alloc::string::String::from(key)), here)),
            target: AsmSectionTarget::OwnSection(here as u32),
        }));
    }
    if let Some(leaf) = section_expr_defined_leaf(t, measured, sink_labels, num_unique, label_off) {
        return Some(leaf);
    }
    let mut cur = t;
    for _ in 0..ASM_ALIAS_DEPTH_LIMIT {
        let Some(next) = measured.alias(cur) else {
            break;
        };
        cur = next;
        if let Some(leaf) =
            section_expr_defined_leaf(cur, measured, sink_labels, num_unique, label_off)
        {
            return Some(leaf_named(leaf, t));
        }
    }
    // Last, so a label of the same name wins: a bare section name is that
    // section's start.
    measured.section_named(cur).map(section_start_leaf)
}

/// A leaf reached through a `.set` chain, renamed to the symbol the source
/// wrote. An absolute value and a region reference name no symbol.
fn leaf_named(leaf: AsmExprLeaf, name: &str) -> AsmExprLeaf {
    match leaf {
        AsmExprLeaf::Loc(AsmExprTerm {
            space,
            target: AsmSectionTarget::Symbol(_),
        }) => AsmExprLeaf::Loc(AsmExprTerm {
            space,
            target: AsmSectionTarget::Symbol(alloc::string::String::from(name)),
        }),
        other => other,
    }
}

/// The leaf for a name the layout defines; `None` leaves the name to the
/// alias chain and the section names.
fn section_expr_defined_leaf(
    t: &str,
    measured: &SectionLabelOffsets,
    sink_labels: &AsmSinkLabels,
    num_unique: &alloc::collections::BTreeMap<&str, alloc::string::String>,
    label_off: &dyn Fn(&str) -> Option<LabelLoc>,
) -> Option<AsmExprLeaf> {
    if let Some(v) = measured.symbol(t) {
        return Some(AsmExprLeaf::Abs(v));
    }
    if let Some(loc) = label_off(t) {
        return Some(AsmExprLeaf::Loc(match loc {
            LabelLoc::Text(off) => AsmExprTerm {
                space: Some((AsmSpace::Text, off as i64)),
                target: AsmSectionTarget::Text(off),
            },
            LabelLoc::Deferred { region, off } => AsmExprTerm {
                space: Some((AsmSpace::Deferred(region), off as i64)),
                target: AsmSectionTarget::DeferredText {
                    region,
                    off: off as u32,
                },
            },
        }));
    }
    if let (Some(sk), Some(off)) = (measured.section(t), measured.offset(t)) {
        let name = numeric_label_digits(t)
            .and_then(|d| num_unique.get(d).cloned())
            .unwrap_or_else(|| alloc::string::String::from(t));
        return Some(AsmExprLeaf::Loc(AsmExprTerm {
            space: Some((AsmSpace::Section(alloc::string::String::from(sk)), off)),
            target: AsmSectionTarget::Symbol(name),
        }));
    }
    if numeric_label_digits(t).is_none()
        && let Some((sk, off)) = sink_labels.get(t)
    {
        return Some(AsmExprLeaf::Loc(AsmExprTerm {
            space: Some((AsmSpace::Section(sk.clone()), *off)),
            target: AsmSectionTarget::Symbol(alloc::string::String::from(t)),
        }));
    }
    None
}

/// The start of the section with identity key `sk`, as an expression leaf.
fn section_start_leaf(sk: &str) -> AsmExprLeaf {
    AsmExprLeaf::Loc(AsmExprTerm {
        space: Some((AsmSpace::Section(alloc::string::String::from(sk)), 0)),
        target: AsmSectionTarget::SectionStart(alloc::string::String::from(sk)),
    })
}

/// Evaluate an `.org` target expression at offset `at` of section `key`:
/// an absolute value is a section offset, a location of this section is its
/// offset. `resolve` answers labels; `.` is supplied here.
///
/// A location of this section resolves to its offset, as GNU as does by
/// deferring an `.org` target to final symbol resolution: operator order
/// then does not decide whether the target reduces.
fn eval_org_target(
    expr: &str,
    key: &str,
    at: i64,
    resolve: &dyn Fn(&str) -> Option<AsmExprLeaf>,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<i64, alloc::string::String> {
    let leaf = |t: &str| -> Option<AsmExprLeaf> {
        if t == "." {
            return Some(AsmExprLeaf::Abs(at));
        }
        Some(match resolve(t)? {
            AsmExprLeaf::Loc(AsmExprTerm {
                space: Some((AsmSpace::Section(k), off)),
                target,
            }) => match k == key {
                true => AsmExprLeaf::Abs(off),
                false => AsmExprLeaf::Loc(AsmExprTerm {
                    space: Some((AsmSpace::Section(k), off)),
                    target,
                }),
            },
            other => other,
        })
    };
    let ctx = AsmExprCtx {
        resolve: &leaf,
        const_of,
        lax_div: false,
    };
    let v = eval_asm_value(expr, &ctx).map_err(|e| alloc::format!("inline asm: `.org`: {e}"))?;
    if let Some(n) = v.to_abs() {
        return Ok(n);
    }
    if let AsmExprValue {
        add,
        pos: Some(p),
        neg: None,
    } = &v
        && let Some((AsmSpace::Section(k), off)) = &p.space
        && k == key
    {
        return Ok(off + add);
    }
    Err(alloc::format!(
        "inline asm: `.org {expr}` is not a location of this section"
    ))
}

/// Byte length of one item inside a `.rept` body. Only fixed-length,
/// label-free items repeat; anything else is rejected.
fn rept_item_len(
    item: &AsmSectionItem,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<i64, alloc::string::String> {
    Ok(match item {
        AsmSectionItem::Data { width, values } => *width as i64 * values.len() as i64,
        AsmSectionItem::Bytes(bs) => bs.len() as i64,
        AsmSectionItem::CodeBytes { bytes, relocs, .. } if relocs.is_empty() => bytes.len() as i64,
        AsmSectionItem::Fill { count, unit, .. } => {
            eval_fill_count(count, const_of)? * *unit as i64
        }
        _ => {
            return Err(alloc::string::String::from(
                "inline asm: unsupported item inside `.rept`",
            ));
        }
    })
}

/// Bytes needed to advance `at` to the next multiple of `align`, or zero when
/// GNU as would drop the alignment because the gap exceeds the `max` skip.
pub(crate) fn align_gap(at: i64, align: i64, max: Option<u32>) -> i64 {
    let gap = (align - at.rem_euclid(align)).rem_euclid(align);
    match max {
        Some(m) if gap > m as i64 => 0,
        _ => gap,
    }
}

/// The byte pattern that fills an alignment gap. An explicit fill unit is
/// repeated little-endian. With no explicit fill GNU as pads an executable
/// section with the target NOP encoding (single-byte on x86, the 4-byte
/// instruction on AArch64) and a data section with zero. The pattern cycles
/// by absolute section offset: an accepted gap starts on a multiple of the
/// fill width, so that is also the gap-relative order, and the AArch64 NOP
/// lands instruction-aligned.
pub(crate) fn align_fill_pattern(
    fill: Option<AlignFill>,
    exec: bool,
    aarch64: bool,
) -> ([u8; 4], usize) {
    match (fill, exec, aarch64) {
        (Some(f), _, _) => (f.value.to_le_bytes(), f.width as usize),
        (None, false, _) => ([0, 0, 0, 0], 1),
        (None, true, false) => ([0x90, 0, 0, 0], 1),
        (None, true, true) => (A64_NOP, A64_NOP.len()),
    }
}

/// Lay an alignment gap's padding at the end of `out`, whose length is a
/// section offset, and report how it splits for the mapping symbols: the
/// leading run's length, which is data, then the rest in the returned class.
/// `after_insn` reports whether the byte before the gap came from an
/// instruction, which the x86 NOP sequence depends on.
///
/// GNU as requires the gap to be a whole number of fill units, so a `.balignl`
/// or `.p2alignw` whose padding does not divide by its width is an error
/// rather than a truncated unit.
pub(crate) fn push_align_fill(
    out: &mut alloc::vec::Vec<u8>,
    gap: usize,
    fill: Option<AlignFill>,
    exec: bool,
    aarch64: bool,
    after_insn: bool,
) -> Result<(usize, MapClass), alloc::string::String> {
    if let Some(f) = fill
        && !gap.is_multiple_of(f.width as usize)
    {
        return Err(alloc::format!(
            "inline asm: alignment padding ({gap} bytes) not a multiple of {}",
            f.width
        ));
    }
    // The sub-word remainder of an AArch64 code gap is data and the whole
    // words are NOPs.
    if fill.is_none() && exec && aarch64 {
        return Ok((push_a64_exec_align_fill(out, gap), MapClass::Code));
    }
    let nop_fill = fill.is_none_or(|f| f.is_x86_nop());
    if nop_fill && exec && !aarch64 {
        push_x86_exec_align_fill(out, gap, after_insn);
        return Ok((0, MapClass::Code));
    }
    let (pat, plen) = align_fill_pattern(fill, exec, aarch64);
    for _ in 0..gap {
        out.push(pat[out.len() % plen]);
    }
    // The padding holds instructions where the fill is the target NOP, and on
    // AArch64 also where it is explicit, which GNU as leaves in the
    // instruction state.
    Ok((
        0,
        if exec && (aarch64 || nop_fill) {
            MapClass::Code
        } else {
            MapClass::Data
        },
    ))
}

/// The AArch64 NOP, `d503201f`. Its length is the instruction size, the
/// boundary code and alignment padding split on.
pub(crate) const A64_NOP: [u8; 4] = [0x1f, 0x20, 0x03, 0xd5];

/// Fill an AArch64 executable alignment gap as GNU as does: the gap's
/// sub-word remainder as zeros, then whole NOPs. Returns the zero run's
/// length, which is data where the NOPs are code.
pub(crate) fn push_a64_exec_align_fill(out: &mut alloc::vec::Vec<u8>, gap: usize) -> usize {
    let zeros = gap % A64_NOP.len();
    out.resize(out.len() + zeros, 0);
    for _ in 0..(gap - zeros) / A64_NOP.len() {
        out.extend_from_slice(&A64_NOP);
    }
    zeros
}

/// Bytes before an instruction: GNU as brings an AArch64 executable
/// section's counter to the instruction size only out of the data mapping
/// state, so an instruction after an alignment directive or an odd `.org`
/// stays where the counter is. The padding belongs to the data run, and
/// the labels already placed keep their unaligned values. x86-64 never
/// pads.
pub(crate) fn insn_align_gap(
    at: i64,
    state: Option<MapClass>,
    exec: bool,
    align_is_p2: bool,
) -> i64 {
    if align_is_p2 && exec && state == Some(MapClass::Data) {
        align_gap(at, A64_NOP.len() as i64, None)
    } else {
        0
    }
}

/// The mapping state an item leaves behind. Attribute-only items, `.org`
/// and an alignment of one leave it unchanged; a wider alignment directive
/// in an executable section leaves instructions even where it padded
/// nothing, so a following instruction is not realigned. An unresolved
/// alignment operand cannot be read here; the walks resolve it first.
pub(crate) fn step_map_state(
    item: &AsmSectionItem,
    cur: Option<MapClass>,
    exec: bool,
) -> Option<MapClass> {
    match item {
        AsmSectionItem::CodeBytes { .. } => Some(MapClass::Code),
        AsmSectionItem::Align {
            spec: AlignSpec::Bytes(n),
            ..
        } => (*n > 1)
            .then_some(if exec { MapClass::Code } else { MapClass::Data })
            .or(cur),
        AsmSectionItem::Data { .. } | AsmSectionItem::Fill { .. } | AsmSectionItem::Bytes(_) => {
            Some(MapClass::Data)
        }
        AsmSectionItem::Rept { items, .. } => items
            .iter()
            .fold(cur, |st, it| step_map_state(it, st, exec)),
        _ => cur,
    }
}

/// Whether `tok` names a layout directive: the alignment, space-and-fill and
/// `.org` families move the location counter instead of depositing an
/// encoding, so an instruction stream lays them down rather than assembling
/// them.
pub(crate) fn is_stream_layout_directive(tok: &str) -> bool {
    align_directive(tok).is_some() || tok == ".org" || is_fill_directive(tok)
}

/// Parse a layout directive to the section item describing it, so an
/// instruction stream and the section engine read one grammar. `None` when
/// `tok` is not a layout directive.
pub(crate) fn parse_stream_layout_item(
    tok: &str,
    rest: &str,
    is_aarch64: bool,
) -> Option<Result<AsmSectionItem, alloc::string::String>> {
    is_stream_layout_directive(tok).then(|| parse_section_item(tok, rest, is_aarch64))
}

/// Lay a layout directive into an AArch64 instruction stream at the end of
/// `out`, whose length is a section offset. `data` collects the runs that are
/// not instructions, for the mapping symbols; a `.org` records none, as in
/// GNU as, so the surrounding run covers its gap. `resolve` values a label
/// reference in a count or an `.org` target and `const_of` an `i`-class
/// operand. Returns the alignment the directive requests, which the caller
/// raises the section's by.
pub(crate) fn push_a64_stream_layout(
    item: &AsmSectionItem,
    out: &mut alloc::vec::Vec<u8>,
    data: &mut alloc::vec::Vec<(usize, usize)>,
    resolve: &dyn Fn(&str) -> Option<i64>,
    const_of: &dyn Fn(u8) -> Option<i64>,
) -> Result<u32, alloc::string::String> {
    let at = out.len();
    fn align(
        out: &mut alloc::vec::Vec<u8>,
        data: &mut alloc::vec::Vec<(usize, usize)>,
        n: u32,
        fill: Option<AlignFill>,
        max: Option<u32>,
    ) -> Result<u32, alloc::string::String> {
        let at = out.len();
        let gap = align_gap(at as i64, n as i64, max) as usize;
        let (lead, _) = push_align_fill(out, gap, fill, true, true, false)?;
        if lead > 0 {
            data.push((at, lead));
        }
        Ok(n)
    }
    // A `.org` target below the counter is an error in GNU as, not a rewind.
    fn org(
        out: &mut alloc::vec::Vec<u8>,
        target: i64,
        fill: u8,
    ) -> Result<u32, alloc::string::String> {
        if target < out.len() as i64 {
            return Err(alloc::string::String::from(
                "inline asm: `.org` moves backwards",
            ));
        }
        out.resize(target as usize, fill);
        Ok(1)
    }
    match item {
        AsmSectionItem::Align { spec, fill, max } => {
            align(out, data, spec.bytes(resolve)?, *fill, *max)
        }
        AsmSectionItem::Fill { count, unit, value } => {
            let n = eval_fill_count_with(count, at as i64, const_of, resolve).ok_or_else(|| {
                alloc::format!("inline asm: fill count `{count}` is not a constant expression")
            })?;
            push_fill(out, n.max(0), *unit, *value);
            if out.len() > at {
                data.push((at, out.len() - at));
            }
            Ok(1)
        }
        AsmSectionItem::Org(n, fill) => org(out, *n as i64, *fill),
        AsmSectionItem::OrgLabel {
            label,
            addend,
            fill,
        } => {
            let base = resolve(label).ok_or_else(|| {
                alloc::format!("inline asm: `.org` label `{label}` is not defined above")
            })?;
            let add = eval_const_expr_ops(addend, const_of).ok_or_else(|| {
                alloc::string::String::from("inline asm: non-constant `.org` addend")
            })?;
            org(out, base + add, *fill)
        }
        AsmSectionItem::OrgExpr(expr, fill) => {
            let target = eval_fill_count_with(expr, at as i64, const_of, resolve)
                .ok_or_else(|| alloc::format!("inline asm: bad `.org` offset `{expr}`"))?;
            org(out, target, *fill)
        }
        _ => Err(alloc::string::String::from(
            "inline asm: unsupported layout directive",
        )),
    }
}

/// The x86-64 multi-byte NOP of each length GNU as pads executable
/// alignment gaps with, lengths 1..=11.
const X86_NOPS: [&[u8]; 11] = [
    &[0x90],
    &[0x66, 0x90],
    &[0x0f, 0x1f, 0x00],
    &[0x0f, 0x1f, 0x40, 0x00],
    &[0x0f, 0x1f, 0x44, 0x00, 0x00],
    &[0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00],
    &[0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00],
    &[0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    &[0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    &[0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
    &[
        0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
    ],
];

/// Fill an x86-64 executable alignment gap with multi-byte NOPs, as GNU as
/// does: the sub-maximal remainder first, then maximal-length NOPs.
///
/// `after_insn` reports whether the byte before the gap came from an
/// instruction. When it did not -- the gap opens after a data directive,
/// which the assembler cannot assume ends on an instruction boundary --
/// GNU as leads with the one-byte NOP and fills the rest by the same
/// scheme. An alignment directive's own fill does not establish a
/// boundary, so consecutive alignments after data each take the leading
/// byte.
pub(crate) fn push_x86_exec_align_fill(
    out: &mut alloc::vec::Vec<u8>,
    gap: usize,
    after_insn: bool,
) {
    let mut gap = gap;
    if !after_insn && gap > 0 {
        out.extend_from_slice(X86_NOPS[0]);
        gap -= 1;
    }
    let rem = gap % X86_NOPS.len();
    if rem > 0 {
        out.extend_from_slice(X86_NOPS[rem - 1]);
    }
    for _ in 0..gap / X86_NOPS.len() {
        out.extend_from_slice(X86_NOPS[X86_NOPS.len() - 1]);
    }
}

/// GNU as routes a code-section alignment whose explicit fill byte is the
/// one-byte NOP through the NOP-sequence path rather than repeating the
/// byte, so `.balign n, 0x90` pads like a fill-less `.balign n`.
pub(crate) const X86_NOP_OPCODE: u8 = 0x90;

/// Measure the section-relative offset of every label the blocks define,
/// before the field values (or the main stream) are laid out. Each item's
/// byte length is structural -- data width times count, string length,
/// alignment / `.org` padding -- so a forward label difference and the
/// `.skip` replacement padding resolve without the values. A fill count
/// over label differences (the alternatives `.skip` padding sized by
/// labels of another section) resolves in a second round against the
/// first round's offsets.
///
/// A branch the arch encoder gave a short form starts short and is
/// lengthened, permanently, when the round's layout leaves its displacement
/// outside the short field. Each round either lengthens a branch or stops,
/// so the walk ends after at most one round per candidate, and the round it
/// stops on is a layout in which every short branch reaches -- the layout
/// the materializer lays down, since it encodes from this result.
/// Lengthening is what makes that sound: it never puts a displacement out
/// of reach that was in reach, while shortening can, through an alignment
/// or `.org` that absorbs the bytes saved ahead of it.
pub(crate) fn measure_asm_section_offsets(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
    sink: &AsmSectionSink,
) -> Result<SectionLabelOffsets, alloc::string::String> {
    let mut long = AsmRelaxSet::new();
    let mut sites = alloc::vec::Vec::new();
    let mut m = measure_fill_rounds(blocks, const_of, align_is_p2, sink, &long, &mut sites)?;
    if sites.is_empty() {
        return Ok(m);
    }
    // A relaxable branch resolves in place against any same-section name the
    // link cannot rebind, so only weakness holds the long form here.
    let weak_only = asm_weak_only_names(blocks, sink);
    loop {
        let grown: AsmRelaxSet = sites
            .iter()
            .filter(|s| {
                !long.contains(&s.site)
                    && !short_form_fits(blocks, &m, &weak_only, s, const_of, sink)
            })
            .map(|s| s.site)
            .collect();
        if grown.is_empty() {
            m.long = long;
            return Ok(m);
        }
        long.extend(grown);
        sites.clear();
        m = measure_fill_rounds(blocks, const_of, align_is_p2, sink, &long, &mut sites)?;
    }
}

/// Whether the short form of the site fits under `m`: a branch whose target
/// is in reach, or a narrow immediate whose expression folds to a value the
/// field holds. Only a target the materializer resolves in place qualifies;
/// any other keeps a relocation, which the link fills at the long form's
/// width, and an absolute field cannot carry one at all.
fn short_form_fits(
    blocks: &[AsmSectionBlock],
    m: &SectionLabelOffsets,
    rebindable: &alloc::collections::BTreeSet<alloc::string::String>,
    s: &AsmRelaxSite,
    const_of: &dyn Fn(u8) -> Option<i64>,
    sink: &AsmSectionSink,
) -> bool {
    let Some(AsmSectionItem::CodeBytes {
        short: Some(short), ..
    }) = blocks[s.site.0].items.get(s.site.1)
    else {
        return false;
    };
    let key = section_key(&blocks[s.site.0]);
    let place = s.at + short.reloc.offset as i64;
    let value = match &short.reloc.target {
        // An absolute field holds a value, not a link-time address, so a
        // name that survives as a symbol rules the narrow form out.
        AsmSectionTarget::Symbol(_) if !short.reloc.pcrel => return false,
        AsmSectionTarget::Symbol(name) => {
            // The reference takes the location of the name its `.set` chain
            // ends at and the binding of the name written, as the
            // materializer does. A `.set` expression name is an absolute
            // value, not a location in this section, and a rebindable name
            // may bind to another definition at link time, so either keeps a
            // relocation at the long form's width.
            if rebindable.contains(name.as_str()) {
                return false;
            }
            let name = m.alias_target(name.as_str());
            if m.symbol(name).is_some() {
                return false;
            }
            let (Some(sec), Some(off)) = (m.section(name), m.offset(name)) else {
                return false;
            };
            if sec != key {
                return false;
            }
            off + short.reloc.addend - place
        }
        // An expression target reaches where the materializer folds it to a
        // constant; a symbol left in the value keeps its relocation. The
        // main stream's labels are not laid out yet, so a target naming one
        // takes the long form.
        AsmSectionTarget::Expr(text) => {
            let num_unique = alloc::collections::BTreeMap::new();
            // A label at or after this site moves with the site's own width,
            // so an absolute field naming one has two self-consistent
            // layouts with different values. GNU as picks the wide one by
            // settling the field before the layout; take the same value by
            // narrowing only what cannot move.
            let ahead = core::cell::Cell::new(false);
            let resolve = |t: &str| {
                let leaf =
                    section_expr_leaf(t, &key, s.at, m, &sink.labels, &num_unique, &|_| None);
                if let Some(AsmExprLeaf::Loc(term)) = &leaf
                    && let Some((AsmSpace::Section(k), off)) = &term.space
                    && *k == key
                    && *off > s.at
                {
                    ahead.set(true);
                }
                leaf
            };
            let ctx = AsmExprCtx {
                resolve: &resolve,
                const_of,
                lax_div: false,
            };
            let space = AsmSpace::Section(key.clone());
            let folded = resolve_asm_field_expr(
                text,
                &ctx,
                &space,
                place,
                short.reloc.addend,
                short.reloc.pcrel || short.reloc.kind.self_relative(),
                rebindable,
            );
            if ahead.get() && !short.reloc.pcrel {
                return false;
            }
            match folded {
                Ok(AsmFieldTarget::Abs(c)) => c,
                _ => return false,
            }
        }
        _ => return false,
    };
    let lim = 1i64 << (8 * short.reloc.width as u32 - 1);
    (-lim..lim).contains(&value)
}

/// Names the unit binds weak, from the blocks and from what earlier
/// statements recorded. A weak definition never resolves in place: the link
/// may bind a different one, so every reference keeps its relocation,
/// relaxable branch included.
fn asm_weak_only_names(
    blocks: &[AsmSectionBlock],
    sink: &AsmSectionSink,
) -> alloc::collections::BTreeSet<alloc::string::String> {
    blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::Weak(n) => Some(n.clone()),
            _ => None,
        })
        .chain(
            sink.sym_decls
                .iter()
                .filter(|d| d.bind == AsmSymBind::Weak)
                .map(|d| d.name.clone()),
        )
        .chain(
            sink.sections
                .iter()
                .flat_map(|s| &s.labels)
                .filter(|l| l.weak)
                .map(|l| l.name.clone()),
        )
        .collect()
}

/// Names the unit binds global or weak, from the blocks and from what
/// earlier statements recorded (a `.globl` / `.weak` may follow the
/// reference). A reference to one keeps its relocation so the link binds
/// the winning definition; only a local name resolves in place, as GNU
/// as resolves it.
fn asm_non_local_names(
    blocks: &[AsmSectionBlock],
    sink: &AsmSectionSink,
) -> alloc::collections::BTreeSet<alloc::string::String> {
    blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::Global(n) | AsmSectionItem::Weak(n) => Some(n.clone()),
            _ => None,
        })
        .chain(
            sink.sym_decls
                .iter()
                .filter(|d| matches!(d.bind, AsmSymBind::Global | AsmSymBind::Weak))
                .map(|d| d.name.clone()),
        )
        .chain(
            sink.sections
                .iter()
                .flat_map(|s| &s.labels)
                .filter(|l| l.global || l.weak)
                .map(|l| l.name.clone()),
        )
        .collect()
}

/// Measure with the branch forms `long` fixes, running the second round a
/// label-valued fill count needs. `sites` collects the relaxable branches
/// the settled round placed.
fn measure_fill_rounds(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
    sink: &AsmSectionSink,
    long: &AsmRelaxSet,
    sites: &mut alloc::vec::Vec<AsmRelaxSite>,
) -> Result<SectionLabelOffsets, alloc::string::String> {
    match measure_round(blocks, const_of, align_is_p2, sink, None, long, sites) {
        (Ok(m), false) => Ok(m),
        // A fill count referenced a label: re-measure with the offsets the
        // first round produced. The referenced labels must not sit after an
        // unresolved fill of their own section, so one extra round settles
        // the layout or nothing does.
        (first, true) => {
            let prev = first.unwrap_or_default();
            sites.clear();
            match measure_round(
                blocks,
                const_of,
                align_is_p2,
                sink,
                Some(&prev),
                long,
                sites,
            ) {
                (Ok(m), false) => Ok(m),
                (Err(e), _) => Err(e),
                _ => Err(alloc::string::String::from(
                    "inline asm: fill count does not settle against the section layout",
                )),
            }
        }
        (Err(e), _) => Err(e),
    }
}

/// One measurement round. `prev` supplies label offsets for fill counts;
/// the second return reports whether a fill count needed a label the round
/// could not resolve (round one measures it as zero length).
#[allow(clippy::too_many_arguments)]
fn measure_round(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
    sink: &AsmSectionSink,
    prev: Option<&SectionLabelOffsets>,
    long: &AsmRelaxSet,
    sites: &mut alloc::vec::Vec<AsmRelaxSite>,
) -> (Result<SectionLabelOffsets, alloc::string::String>, bool) {
    let mut unresolved_fill = false;
    let r = measure_round_inner(
        blocks,
        const_of,
        align_is_p2,
        sink,
        prev,
        &mut unresolved_fill,
        long,
        sites,
    );
    (r, unresolved_fill)
}

#[allow(clippy::too_many_arguments)]
fn measure_round_inner(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    align_is_p2: bool,
    sink: &AsmSectionSink,
    prev: Option<&SectionLabelOffsets>,
    unresolved_fill: &mut bool,
    long: &AsmRelaxSet,
    sites: &mut alloc::vec::Vec<AsmRelaxSite>,
) -> Result<SectionLabelOffsets, alloc::string::String> {
    let mut map: alloc::collections::BTreeMap<alloc::string::String, (alloc::string::String, i64)> =
        alloc::collections::BTreeMap::new();
    let mut lens: alloc::collections::BTreeMap<alloc::string::String, i64> =
        alloc::collections::BTreeMap::new();
    // `.set` assignments in source order with the offset each was written at;
    // evaluated below, once every label offset is known, so a value may name a
    // label defined later in the section.
    let mut sets: alloc::vec::Vec<(
        alloc::string::String,
        alloc::string::String,
        alloc::string::String,
        i64,
    )> = alloc::vec::Vec::new();
    // `.set name, symbol` aliases: an expression over one reads the target's
    // location, as GNU as resolves the chain.
    let mut aliases: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String> =
        alloc::collections::BTreeMap::new();
    let mut places: alloc::collections::BTreeMap<(usize, usize), i64> =
        alloc::collections::BTreeMap::new();
    let mut aligns: alloc::collections::BTreeMap<(usize, usize), u32> =
        alloc::collections::BTreeMap::new();
    // The mapping state each section was left in, so the instruction padding
    // measured here matches what the materializer lays down.
    let mut states: alloc::collections::BTreeMap<alloc::string::String, Option<MapClass>> =
        alloc::collections::BTreeMap::new();
    for &bi in &subsection_order(blocks) {
        let b = &blocks[bi];
        let key = section_key(b);
        let exec = b.flags.contains('x');
        // A section already holding bytes in the sink continues at its
        // current length, so measured offsets, alignment gaps, and the
        // location counter agree with the materialized layout.
        let mut at = *lens
            .entry(key.clone())
            .or_insert_with(|| sink.index_of(b).map_or(0, |i| sink[i].bytes.len() as i64));
        let mut state = *states
            .entry(key.clone())
            .or_insert_with(|| sink.index_of(b).and_then(|i| sink[i].map_state));
        for (ii, item) in b.items.iter().enumerate() {
            if matches!(item, AsmSectionItem::CodeBytes { .. }) {
                at += insn_align_gap(at, state, exec, align_is_p2);
            }
            places.insert((bi, ii), at);
            // An alignment operand over labels reads the offsets this round
            // has already recorded, so every later reader of the item sees
            // one byte count. A first round measures an unresolved fill count
            // as zero length, which moves the offsets an operand reads, so it
            // defers a failure to the round that has them; the second round
            // reports it.
            let resolved = match resolve_align_item(item, &|t| {
                if t.bytes().all(|c| c.is_ascii_digit()) {
                    return None;
                }
                map.get(numeric_label_digits(t).unwrap_or(t))
                    .map(|(_, off)| *off)
            }) {
                Ok(r) => r,
                Err(e) if prev.is_some() => return Err(e),
                Err(_) => {
                    *unresolved_fill = true;
                    Some(AsmSectionItem::Align {
                        spec: AlignSpec::Bytes(1),
                        fill: None,
                        max: None,
                    })
                }
            };
            if let Some(AsmSectionItem::Align {
                spec: AlignSpec::Bytes(n),
                ..
            }) = resolved
            {
                aligns.insert((bi, ii), n);
            }
            let item = resolved.as_ref().unwrap_or(item);
            match item {
                AsmSectionItem::Label(name) => {
                    let digits = numeric_label_digits(name).unwrap_or(name);
                    map.insert(alloc::string::String::from(digits), (key.clone(), at));
                }
                // Symbol attributes, not layout: no bytes.
                AsmSectionItem::Global(_)
                | AsmSectionItem::Type { .. }
                | AsmSectionItem::Size { .. }
                | AsmSectionItem::Weak(_)
                | AsmSectionItem::Local(_)
                | AsmSectionItem::Visibility { .. }
                | AsmSectionItem::CondDiag(_)
                | AsmSectionItem::Cfi(_)
                | AsmSectionItem::Reloc { .. } => {}
                AsmSectionItem::SymSet { name, target } => {
                    aliases.insert(name.clone(), target.clone());
                }
                AsmSectionItem::SetExpr { name, expr } => {
                    sets.push((name.clone(), expr.clone(), key.clone(), at));
                }
                // An absolute value, so its reads resolve like any other
                // assignment without depending on the layout.
                AsmSectionItem::AbsSet { name, value } => {
                    sets.push((name.clone(), alloc::format!("{value}"), key.clone(), at));
                }
                AsmSectionItem::LiteralPool(entries) => {
                    let (offs, end) = literal_pool_layout(entries, at);
                    for (e, off) in entries.iter().zip(&offs) {
                        map.insert(e.label.clone(), (key.clone(), *off));
                    }
                    at = end;
                }
                AsmSectionItem::Data { width, values } => {
                    at += *width as i64 * values.len() as i64;
                }
                AsmSectionItem::Fill { count, unit, .. } => {
                    // The count may reference labels (`744f - 743f`); resolve
                    // them from this round's map, the prior round's, or fail
                    // the round so a second one runs with full offsets.
                    let resolve = |t: &str| -> Option<i64> {
                        if t.bytes().all(|c| c.is_ascii_digit()) {
                            return None;
                        }
                        map.get(numeric_label_digits(t).unwrap_or(t))
                            .map(|(_, off)| *off)
                            .or_else(|| prev.and_then(|p| p.offset(t)))
                            .or_else(|| prev.and_then(|p| p.symbol(t)))
                    };
                    let n = match eval_fill_count_with(count, at, const_of, &resolve) {
                        Some(n) => n,
                        None => {
                            *unresolved_fill = true;
                            if prev.is_some() {
                                return Err(alloc::format!(
                                    "inline asm: fill count `{count}` is not a constant expression"
                                ));
                            }
                            0
                        }
                    };
                    at += n.max(0) * *unit as i64;
                }
                AsmSectionItem::Bytes(bs) => at += bs.len() as i64,
                AsmSectionItem::CodeBytes { bytes, short, .. } => {
                    at += match short {
                        None => bytes.len() as i64,
                        Some(s) => {
                            sites.push(AsmRelaxSite { site: (bi, ii), at });
                            if long.contains(&(bi, ii)) {
                                bytes.len() as i64
                            } else {
                                s.bytes.len() as i64
                            }
                        }
                    };
                }
                AsmSectionItem::Code(text) => {
                    return Err(alloc::format!(
                        "inline asm: replacement instruction `{text}` in a named section is not \
                         assembled for this target"
                    ));
                }
                AsmSectionItem::Align { spec, max, .. } => {
                    at += align_gap(at, spec.bytes(&|_| None)? as i64, *max);
                }
                AsmSectionItem::Org(n, _) => at = at.max(*n as i64),
                AsmSectionItem::OrgLabel { label, addend, .. } => {
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
                AsmSectionItem::OrgExpr(expr, _) => {
                    // A target referencing labels of a later subsection (the
                    // alternatives length equalizer) resolves in round two,
                    // like a fill count.
                    let resolve = |t: &str| -> Option<AsmExprLeaf> {
                        let loc = |k: &str, off: i64| {
                            AsmExprLeaf::Loc(AsmExprTerm {
                                space: Some((
                                    AsmSpace::Section(alloc::string::String::from(k)),
                                    off,
                                )),
                                target: AsmSectionTarget::Symbol(alloc::string::String::from(t)),
                            })
                        };
                        map.get(numeric_label_digits(t).unwrap_or(t))
                            .map(|(k, off)| loc(k, *off))
                            .or_else(|| {
                                let p = prev?;
                                Some(loc(p.section(t)?, p.offset(t)?))
                            })
                            .or_else(|| prev.and_then(|p| p.symbol(t).map(AsmExprLeaf::Abs)))
                    };
                    match eval_org_target(expr, &key, at, &resolve, const_of) {
                        Ok(target) => at = target.max(at),
                        Err(e) => {
                            *unresolved_fill = true;
                            if prev.is_some() {
                                return Err(e);
                            }
                        }
                    }
                }
                AsmSectionItem::Rept { count, items } => {
                    let resolve = |t: &str| -> Option<i64> {
                        if t.bytes().all(|c| c.is_ascii_digit()) {
                            return None;
                        }
                        map.get(numeric_label_digits(t).unwrap_or(t))
                            .map(|(_, off)| *off)
                            .or_else(|| prev.and_then(|p| p.offset(t)))
                            .or_else(|| prev.and_then(|p| p.symbol(t)))
                    };
                    let n = match eval_fill_count_with(count, at, const_of, &resolve) {
                        Some(n) => n,
                        None => {
                            *unresolved_fill = true;
                            if prev.is_some() {
                                return Err(alloc::format!(
                                    "inline asm: `.rept` count `{count}` is not constant"
                                ));
                            }
                            0
                        }
                    };
                    // Padding before an instruction depends on the offset the
                    // iteration starts at, so the body is measured per
                    // repetition where it can pad at all.
                    if items
                        .iter()
                        .any(|it| matches!(it, AsmSectionItem::CodeBytes { .. }))
                        && align_is_p2
                        && exec
                    {
                        for _ in 0..n.max(0) {
                            for it in items {
                                if matches!(it, AsmSectionItem::CodeBytes { .. }) {
                                    at += insn_align_gap(at, state, exec, align_is_p2);
                                }
                                at += rept_item_len(it, const_of)?;
                                state = step_map_state(it, state, exec);
                            }
                        }
                    } else {
                        let mut unit_len = 0i64;
                        for it in items {
                            unit_len += rept_item_len(it, const_of)?;
                        }
                        at += n.max(0) * unit_len;
                        if n > 0 {
                            state = step_map_state(item, state, exec);
                        }
                    }
                }
            }
            if !matches!(item, AsmSectionItem::Rept { .. }) {
                state = step_map_state(item, state, exec);
            }
        }
        lens.insert(key.clone(), at);
        states.insert(key, state);
    }
    let sections = section_name_keys(blocks, sink);
    let mut syms: alloc::collections::BTreeMap<alloc::string::String, i64> =
        alloc::collections::BTreeMap::new();
    // An assignment this round cannot value is deferred while a fill count
    // still needs a second round: aborting here would discard the label
    // offsets that round measures from. It is reported once the layout has
    // settled, or straight away when nothing is pending.
    let mut set_err = None;
    for (name, expr, key, at) in &sets {
        match eval_section_set_expr(
            name, expr, key, *at, &map, &syms, &aliases, &sections, const_of,
        ) {
            Ok(SectionSetValue::Abs(v)) => {
                syms.insert(name.clone(), v);
            }
            Ok(SectionSetValue::Loc(sk, off)) => {
                map.insert(name.clone(), (sk, off));
            }
            Err(e) => set_err = set_err.or(Some(e)),
        }
    }
    if let Some(e) = set_err
        && (prev.is_some() || !*unresolved_fill)
    {
        return Err(e);
    }
    Ok(SectionLabelOffsets {
        map,
        syms,
        long: AsmRelaxSet::new(),
        sections,
        places,
        aligns,
        aliases,
    })
}

/// A label defined by one `materialize_asm_sections` call, reported so a
/// main-stream reference to it (`jmp 6f` where `6:` sits in a pushed section)
/// binds across the section boundary. `name` is the source label name before
/// the per-instance rename; `section_index` and `offset` locate the definition
/// in the sink.
#[derive(Debug, Clone)]
pub(crate) struct MaterializedLabel {
    pub name: alloc::string::String,
    pub section_index: usize,
    pub offset: u32,
}

/// Materialize the parsed section blocks: resolve operand constants and
/// label references, lay out the bytes, and merge into the sink by
/// `(name, flags, sh_type)`. `const_of` yields an `i`-class operand's
/// constant; `label_off` resolves a template-label name to its location --
/// an emitted-stream text offset or a deferred replacement region
/// ([`LabelLoc`]); `None` means the name is a symbol. `operand_sym` yields
/// the relocation target of an `i`-class operand that names a link-time
/// address (`.long %c0 - .`) rather than a constant; `goto_block` yields
/// the block index of an `asm goto` label (`.long %l0 - .`). Returns the
/// labels defined this call so a main-stream reference resolves against a
/// definition placed in a section.
pub(crate) fn materialize_asm_sections(
    blocks: &[AsmSectionBlock],
    const_of: &dyn Fn(u8) -> Option<i64>,
    label_off: &dyn Fn(&str) -> Option<LabelLoc>,
    operand_sym: &dyn Fn(u8) -> Option<(AsmSectionTarget, i64)>,
    goto_block: &dyn Fn(u8) -> Option<u32>,
    align_is_p2: bool,
    sink: &mut AsmSectionSink,
) -> Result<alloc::vec::Vec<MaterializedLabel>, alloc::string::String> {
    // GNU as numeric labels (`2:`, `14470:`) are local to one asm instance;
    // the same digits recur across every expansion of a macro like the bug
    // table, so the accumulating sink would collide them. Rename each
    // definition to a per-instance-unique symbol. Built once for the whole
    // call so a reference in one block resolves a definition in another (the
    // bug table's `.long 14472b - .` reaches a label defined in `.rodata.str`).
    let uniq = next_asm_instance();
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
    // the earlier `.altinstructions`) folds to a constant. Seeded with the
    // sink lengths so the offsets are the materialized ones.
    let measured = measure_asm_section_offsets(blocks, const_of, align_is_p2, sink)?;
    let mut defined: alloc::vec::Vec<MaterializedLabel> = alloc::vec::Vec::new();
    // A same-section reference to a global or weak name keeps its
    // relocation, except on a relaxable branch, which resolves against any
    // name the link cannot rebind. The relaxation above uses the same two
    // sets, so a long form is in place wherever a relocation survives.
    let non_local = asm_non_local_names(blocks, sink);
    let weak_only = asm_weak_only_names(blocks, sink);
    let mut weak_names: alloc::vec::Vec<alloc::string::String> = alloc::vec::Vec::new();
    // `.globl` is a unit-level declaration in GNU as: the name it binds
    // external may be defined in any section of the unit, before or after.
    let mut global_names: alloc::vec::Vec<alloc::string::String> = alloc::vec::Vec::new();
    // Sections this call merges into, with the label count each had on
    // first touch. Pending entries never outlive a call, so this is also
    // the exact set the settle pass below has to inspect.
    let mut touched: alloc::vec::Vec<(usize, usize)> = alloc::vec::Vec::new();
    for &bi in &subsection_order(blocks) {
        let b = &blocks[bi];
        let sec_idx = sink.get_or_insert(b);
        // Labels earlier statements defined, resolvable by this call's
        // location expressions (`.size f, . - f` with `f:` in a prior
        // template). Borrowed apart from the section being laid out.
        let AsmSectionSink {
            sections,
            labels: sink_labels,
            cfi: sink_cfi,
            ..
        } = &mut *sink;
        if !touched.iter().any(|&(i, _)| i == sec_idx) {
            touched.push((sec_idx, sections[sec_idx].labels.len()));
        }
        let sec = &mut sections[sec_idx];
        for (ii, item) in b.items.iter().enumerate() {
            // An expression-valued alignment takes the byte count the measure
            // pass settled where the directive stands, so the gap laid down
            // here is the gap the offsets were measured under.
            let resolved;
            let item = match item {
                AsmSectionItem::Align {
                    spec: AlignSpec::Expr { text, .. },
                    fill,
                    max,
                } => {
                    let n = measured.align_of((bi, ii)).ok_or_else(|| {
                        alloc::format!("inline asm: alignment `{text}` was not measured")
                    })?;
                    resolved = AsmSectionItem::Align {
                        spec: AlignSpec::Bytes(n),
                        fill: *fill,
                        max: *max,
                    };
                    &resolved
                }
                other => other,
            };
            if matches!(item, AsmSectionItem::CodeBytes { .. }) {
                let pad = insn_align_gap(
                    sec.bytes.len() as i64,
                    sec.map_state,
                    b.flags.contains('x'),
                    align_is_p2,
                ) as usize;
                if pad > 0 {
                    sec.map.content(sec.bytes.len(), pad, MapClass::Data);
                    sec.bytes.resize(sec.bytes.len() + pad, 0);
                }
            }
            let map_at = sec.bytes.len();
            match item {
                // An alignment of one moves nothing, and GNU as builds no
                // frag for it: no padding, no section alignment, no run.
                AsmSectionItem::Align {
                    spec: AlignSpec::Bytes(n),
                    ..
                } if *n <= 1 => {}
                AsmSectionItem::Align { spec, fill, max } => {
                    let n = spec.bytes(&|_| None)?;
                    let gap = align_gap(sec.bytes.len() as i64, n as i64, None) as usize;
                    // GNU as records the requested alignment on the section
                    // even where a max skip drops the padding.
                    sec.align = sec.align.max(n);
                    let exec = b.flags.contains('x');
                    if max.is_none_or(|m| gap <= m as usize) {
                        let (lead, class) = push_align_fill(
                            &mut sec.bytes,
                            gap,
                            *fill,
                            exec,
                            align_is_p2,
                            sec.after_insn,
                        )?;
                        if lead > 0 {
                            sec.map.align(map_at, MapClass::Data);
                        }
                        sec.map.align(map_at + lead, class);
                    }
                }
                AsmSectionItem::OrgLabel {
                    label,
                    addend,
                    fill,
                } => {
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
                    sec.bytes.resize(target as usize, *fill);
                }
                AsmSectionItem::Org(n, fill) => {
                    if (*n as usize) < sec.bytes.len() {
                        return Err(alloc::string::String::from(
                            "inline asm: `.org` moves backwards",
                        ));
                    }
                    sec.bytes.resize(*n as usize, *fill);
                }
                AsmSectionItem::OrgExpr(expr, fill) => {
                    let key = section_key(b);
                    let here = sec.bytes.len() as i64;
                    let resolve = |t: &str| {
                        section_expr_leaf(
                            t,
                            &key,
                            here,
                            &measured,
                            sink_labels,
                            &num_unique,
                            label_off,
                        )
                    };
                    let target = eval_org_target(expr, &key, here, &resolve, const_of)?;
                    if target < here {
                        return Err(alloc::string::String::from(
                            "inline asm: `.org` moves backwards",
                        ));
                    }
                    sec.bytes.resize(target as usize, *fill);
                }
                AsmSectionItem::Rept { count, items } => {
                    let n = eval_fill_count_with(count, sec.bytes.len() as i64, const_of, &|t| {
                        if t.bytes().all(|c| c.is_ascii_digit()) {
                            return None;
                        }
                        measured.offset(t).or_else(|| measured.symbol(t))
                    })
                    .ok_or_else(|| {
                        alloc::format!("inline asm: `.rept` count `{count}` is not constant")
                    })?;
                    for _ in 0..n.max(0) {
                        for it in items {
                            if matches!(it, AsmSectionItem::CodeBytes { .. }) {
                                let pad = insn_align_gap(
                                    sec.bytes.len() as i64,
                                    sec.map_state,
                                    b.flags.contains('x'),
                                    align_is_p2,
                                ) as usize;
                                if pad > 0 {
                                    sec.map.content(sec.bytes.len(), pad, MapClass::Data);
                                    sec.bytes.resize(sec.bytes.len() + pad, 0);
                                }
                            }
                            let rept_at = sec.bytes.len();
                            match it {
                                AsmSectionItem::Bytes(bs) => sec.bytes.extend_from_slice(bs),
                                AsmSectionItem::CodeBytes { bytes, relocs, .. }
                                    if relocs.is_empty() =>
                                {
                                    sec.bytes.extend_from_slice(bytes);
                                }
                                AsmSectionItem::Data { width, values } => {
                                    for v in values {
                                        let AsmSectionValue::Const(c) = v else {
                                            return Err(alloc::string::String::from(
                                                "inline asm: unsupported item inside `.rept`",
                                            ));
                                        };
                                        push_le(&mut sec.bytes, *c, *width as usize);
                                    }
                                }
                                AsmSectionItem::Fill { count, unit, value } => {
                                    let n = eval_fill_count(count, const_of)?;
                                    push_fill(&mut sec.bytes, n, *unit, *value);
                                }
                                _ => {
                                    return Err(alloc::string::String::from(
                                        "inline asm: unsupported item inside `.rept`",
                                    ));
                                }
                            }
                            let laid = sec.bytes.len() - rept_at;
                            sec.map.content(
                                rept_at,
                                laid,
                                match it {
                                    AsmSectionItem::CodeBytes { .. } => MapClass::Code,
                                    _ => MapClass::Data,
                                },
                            );
                            sec.map_state =
                                step_map_state(it, sec.map_state, b.flags.contains('x'));
                        }
                    }
                }
                AsmSectionItem::Bytes(bs) => sec.bytes.extend_from_slice(bs),
                AsmSectionItem::Fill { count, unit, value } => {
                    // The count may reference section labels; the measured
                    // offsets are final here.
                    let n = eval_fill_count_with(count, sec.bytes.len() as i64, const_of, &|t| {
                        if t.bytes().all(|c| c.is_ascii_digit()) {
                            return None;
                        }
                        measured.offset(t).or_else(|| measured.symbol(t))
                    })
                    .ok_or_else(|| {
                        alloc::format!(
                            "inline asm: fill count `{count}` is not a constant expression"
                        )
                    })?;
                    push_fill(&mut sec.bytes, n.max(0), *unit, *value);
                }
                AsmSectionItem::Label(name) => {
                    // A numeric label carries its per-instance-unique symbol.
                    let orig = name.clone();
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
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                            absolute: None,
                        }),
                    }
                    defined.push(MaterializedLabel {
                        name: orig,
                        section_index: sec_idx,
                        offset: at,
                    });
                }
                AsmSectionItem::CondDiag(arms) => {
                    let key = section_key(b);
                    let here = sec.bytes.len() as i64;
                    let resolve = |t: &str| {
                        section_expr_leaf(
                            t,
                            &key,
                            here,
                            &measured,
                            sink_labels,
                            &num_unique,
                            label_off,
                        )
                    };
                    for arm in arms {
                        let taken = if arm.tok.is_empty() {
                            true
                        } else {
                            let ctx = AsmExprCtx {
                                resolve: &resolve,
                                const_of,
                                lax_div: false,
                            };
                            let v = eval_asm_value(&arm.cond, &ctx)
                                .ok()
                                .and_then(|v| v.to_abs())
                                .ok_or_else(|| {
                                    alloc::format!(
                                        "inline asm: non-constant `{}` condition `{}`",
                                        arm.tok,
                                        arm.cond
                                    )
                                })?;
                            gas_if_relation(&arm.tok, v)?
                        };
                        if taken {
                            if let Some(msg) = &arm.error {
                                return Err(alloc::format!("inline asm: `.error` {msg}"));
                            }
                            break;
                        }
                    }
                }
                AsmSectionItem::LiteralPool(entries) => {
                    let (offs, end) = literal_pool_layout(entries, sec.bytes.len() as i64);
                    sec.bytes.resize(end as usize, 0);
                    for (e, &off) in entries.iter().zip(&offs) {
                        sec.align = sec.align.max(e.size as u32);
                        sec.labels.push(AsmSectionLabel {
                            name: e.label.clone(),
                            offset: off as u32,
                            global: false,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                            absolute: None,
                        });
                        match &e.value {
                            AsmPoolValue::Const(v) => {
                                let at = off as usize;
                                let n = e.size as usize;
                                sec.bytes[at..at + n].copy_from_slice(&v.to_le_bytes()[..n]);
                            }
                            AsmPoolValue::Sym { name, addend } => {
                                sec.relocs.push(AsmSectionReloc {
                                    offset: off as u32,
                                    width: e.size,
                                    kind: AsmRelocKind::Data,
                                    pcrel: false,
                                    branch: false,
                                    signed: false,
                                    target: AsmSectionTarget::Symbol(name.clone()),
                                    addend: *addend,
                                })
                            }
                        }
                    }
                    sec.after_insn = false;
                }
                // `.weak` binding applies to whatever definition the name has
                // (a section label here, or a symbol defined elsewhere in the
                // unit); resolved against the sink once all blocks are laid
                // out. `.set name, sym` is a unit-level alias; the file-scope
                // parse records both, the operand emit paths reject them.
                AsmSectionItem::Weak(name) => weak_names.push(name.clone()),
                // Visibility is carried by name to the object writer, which
                // sets `st_other` wherever the symbol is emitted.
                AsmSectionItem::Visibility { .. } => {}
                // The rule takes effect at the location counter the directive
                // was written at, which is this section's current length.
                AsmSectionItem::Cfi(op) => sink_cfi.push(super::cfi::CfiRecord {
                    key: section_key(b),
                    offset: sec.bytes.len() as u32,
                    op: op.clone(),
                }),
                // `.reloc`: the offset is section-relative and independent of
                // the location counter, and no field is deposited.
                AsmSectionItem::Reloc {
                    offset,
                    rtype,
                    target,
                    addend,
                } => sec.relocs.push(AsmSectionReloc {
                    offset: *offset,
                    width: 0,
                    kind: AsmRelocKind::Explicit(*rtype),
                    pcrel: false,
                    branch: false,
                    signed: false,
                    target: if target.is_empty() {
                        AsmSectionTarget::OwnSection(0)
                    } else {
                        AsmSectionTarget::Symbol(target.clone())
                    },
                    addend: *addend,
                }),
                // `.set name, sym` is a unit-level alias; a `.set` over
                // section-local locations was valued during measurement.
                AsmSectionItem::SymSet { .. } => {}
                AsmSectionItem::SetExpr { .. } => {}
                // `.set name, <constant>` defines an absolute symbol, as in
                // GNU as. A later assignment to the same name wins.
                AsmSectionItem::AbsSet { name, value } => {
                    match sec.labels.iter_mut().find(|l| l.name == *name) {
                        Some(l) => {
                            l.offset = 0;
                            l.absolute = Some(*value);
                        }
                        None => sec.labels.push(AsmSectionLabel {
                            name: name.clone(),
                            absolute: Some(*value),
                            ..Default::default()
                        }),
                    }
                }
                // A section label is local unless `.globl` marked it; record a
                // pending entry so the definition below keeps that binding.
                AsmSectionItem::Local(name) => {
                    match sec.labels.iter_mut().find(|l| l.name == *name) {
                        Some(l) => l.global = false,
                        None => sec.labels.push(AsmSectionLabel {
                            name: name.clone(),
                            offset: PENDING_LABEL,
                            global: false,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                            absolute: None,
                        }),
                    }
                }
                AsmSectionItem::Global(name) => {
                    global_names.push(name.clone());
                    match sec.labels.iter_mut().find(|l| l.name == *name) {
                        // `.globl` may precede its label; record the pending name
                        // as a zero-length forward entry the definition fills in.
                        Some(l) => l.global = true,
                        None => sec.labels.push(AsmSectionLabel {
                            name: name.clone(),
                            offset: PENDING_LABEL,
                            global: true,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: None,
                            absolute: None,
                        }),
                    }
                }
                AsmSectionItem::Type { name, sym_type } => {
                    let lname = numeric_label_digits(name)
                        .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                        .unwrap_or(name);
                    match sec.labels.iter_mut().find(|l| l.name == *lname) {
                        // `.type` may precede its label (as `.globl` may): record
                        // it on a pending forward entry the definition fills in.
                        Some(l) => l.sym_type = *sym_type,
                        None => sec.labels.push(AsmSectionLabel {
                            name: alloc::string::String::from(lname),
                            offset: PENDING_LABEL,
                            global: false,
                            weak: false,
                            sym_type: *sym_type,
                            size: None,
                            absolute: None,
                        }),
                    }
                }
                AsmSectionItem::Size { name, expr } => {
                    // `.` is the offset at the directive; an identifier is a
                    // section label, a `.set` symbol, or an operand constant.
                    // The expression must fold to an absolute byte count.
                    let key = section_key(b);
                    let cur = sec.bytes.len() as i64;
                    let resolve = |t: &str| {
                        section_expr_leaf(
                            t,
                            &key,
                            cur,
                            &measured,
                            sink_labels,
                            &num_unique,
                            label_off,
                        )
                    };
                    let ctx = AsmExprCtx {
                        resolve: &resolve,
                        const_of,
                        lax_div: false,
                    };
                    let val = eval_asm_value(expr, &ctx)
                        .ok()
                        .and_then(|v| v.to_abs())
                        .ok_or_else(|| {
                            alloc::format!("inline asm: bad `.size` expression `{expr}`")
                        })?;
                    if val < 0 {
                        return Err(alloc::format!(
                            "inline asm: `.size` expression `{expr}` is negative"
                        ));
                    }
                    let tname = numeric_label_digits(name)
                        .and_then(|d| num_unique.get(d).map(alloc::string::String::as_str))
                        .unwrap_or(name);
                    // `.size` may precede its label, as `.globl` and `.type`
                    // may; carry the size on a pending entry until then.
                    match sec.labels.iter_mut().find(|l| l.name == *tname) {
                        Some(l) => l.size = Some(val as u64),
                        None => sec.labels.push(AsmSectionLabel {
                            name: alloc::string::String::from(tname),
                            offset: PENDING_LABEL,
                            global: false,
                            weak: false,
                            sym_type: AsmSymType::NoType,
                            size: Some(val as u64),
                            absolute: None,
                        }),
                    }
                }
                AsmSectionItem::Data { width, values } => {
                    for v in values {
                        match v {
                            AsmSectionValue::Const(c) => {
                                push_le(&mut sec.bytes, *c, *width as usize)
                            }
                            AsmSectionValue::OperandConst(idx) => match const_of(*idx) {
                                Some(c) => sec.bytes.extend_from_slice(
                                    &(c as u64).to_le_bytes()[..*width as usize],
                                ),
                                // An `i`-class operand that is not an integer
                                // constant names a link-time address, as it
                                // does in the `%cN - .` form: the field takes
                                // an absolute relocation against it.
                                None => {
                                    let (target, add) = operand_sym(*idx).ok_or_else(|| {
                                        alloc::format!(
                                            "inline asm: section data value `%c{idx}` is neither \
                                             a constant nor a link-time address"
                                        )
                                    })?;
                                    if !matches!(width, 1 | 2 | 4 | 8) {
                                        return Err(alloc::string::String::from(
                                            "inline asm: section reference needs a 1-, 2-, 4-, or 8-byte field",
                                        ));
                                    }
                                    sec.relocs.push(AsmSectionReloc {
                                        offset: sec.bytes.len() as u32,
                                        width: *width,
                                        kind: AsmRelocKind::Data,
                                        pcrel: false,
                                        branch: false,
                                        signed: false,
                                        target,
                                        addend: add,
                                    });
                                    sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                                }
                            },
                            AsmSectionValue::Expr(text) => {
                                let text = subst_asm_idents(text, &|t| measured.symbol(t));
                                let c = eval_const_expr_ops(&text, &|idx| const_of(idx))
                                    .ok_or_else(|| {
                                        alloc::string::String::from(
                                            "inline asm: non-constant section data value",
                                        )
                                    })?;
                                push_le(&mut sec.bytes, c as i128, *width as usize);
                            }
                            AsmSectionValue::LocExpr(text) => {
                                let key = section_key(b);
                                let here = sec.bytes.len() as i64;
                                let resolve = |t: &str| {
                                    section_expr_leaf(
                                        t,
                                        &key,
                                        here,
                                        &measured,
                                        sink_labels,
                                        &num_unique,
                                        label_off,
                                    )
                                };
                                let ctx = AsmExprCtx {
                                    resolve: &resolve,
                                    const_of,
                                    lax_div: false,
                                };
                                let space = AsmSpace::Section(key.clone());
                                let v = eval_asm_value(text, &ctx)
                                    .and_then(|v| resolve_asm_value(v, Some((&space, here))))
                                    .map_err(|e| alloc::format!("inline asm: `{text}`: {e}"))?;
                                match v {
                                    AsmResolved::Abs(c) => {
                                        if !value_fits_width(c, *width) {
                                            return Err(alloc::format!(
                                                "inline asm: `{text}` = {c} does not fit a {width}-byte field"
                                            ));
                                        }
                                        push_le(&mut sec.bytes, c as i128, *width as usize);
                                    }
                                    AsmResolved::Reloc {
                                        target,
                                        addend,
                                        pcrel,
                                    } => {
                                        if !matches!(width, 1 | 2 | 4 | 8) {
                                            return Err(alloc::string::String::from(
                                                "inline asm: section reference needs a 1-, 2-, 4-, or 8-byte field",
                                            ));
                                        }
                                        sec.relocs.push(AsmSectionReloc {
                                            offset: sec.bytes.len() as u32,
                                            width: *width,
                                            kind: AsmRelocKind::Data,
                                            pcrel,
                                            branch: false,
                                            signed: false,
                                            target,
                                            addend,
                                        });
                                        sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                                    }
                                }
                            }
                            // A reference (`sym + 8`, `1b - .`) or a label
                            // difference (`775f - 774f`) evaluates under the
                            // location-value rules: a same-space result folds
                            // (gas folds `a - .` with `a` in this section), a
                            // symbolic one relocates.
                            AsmSectionValue::Ref { .. } | AsmSectionValue::LabelDiff { .. } => {
                                let key = section_key(b);
                                let here = sec.bytes.len() as i64;
                                let leaf = |n: &str| -> AsmExprValue {
                                    match section_expr_leaf(
                                        n,
                                        &key,
                                        here,
                                        &measured,
                                        sink_labels,
                                        &num_unique,
                                        label_off,
                                    ) {
                                        Some(AsmExprLeaf::Abs(c)) => AsmExprValue::abs(c),
                                        Some(AsmExprLeaf::Loc(t)) => AsmExprValue::from_term(t),
                                        None => AsmExprValue::from_term(AsmExprTerm {
                                            space: None,
                                            target: AsmSectionTarget::Symbol(
                                                alloc::string::String::from(n),
                                            ),
                                        }),
                                    }
                                };
                                let val = match v {
                                    AsmSectionValue::Ref {
                                        name,
                                        pcrel,
                                        addend,
                                    } => {
                                        let add = if addend.is_empty() {
                                            0
                                        } else {
                                            eval_const_expr_ops(addend, &|i| const_of(i))
                                                .ok_or_else(|| {
                                                    alloc::string::String::from(
                                                        "inline asm: non-constant section reloc addend",
                                                    )
                                                })?
                                        };
                                        let mut val = leaf(name)
                                            .combine(AsmExprValue::abs(add), false)
                                            .map_err(|e| alloc::format!("inline asm: {e}"))?;
                                        if *pcrel {
                                            val = val
                                                .combine(leaf("."), true)
                                                .map_err(|e| alloc::format!("inline asm: {e}"))?;
                                        }
                                        val
                                    }
                                    AsmSectionValue::LabelDiff {
                                        minuend,
                                        subtrahend,
                                    } => leaf(minuend)
                                        .combine(leaf(subtrahend), true)
                                        .map_err(|e| alloc::format!("inline asm: {e}"))?,
                                    _ => unreachable!("outer arm admits Ref and LabelDiff"),
                                };
                                let space = AsmSpace::Section(key.clone());
                                match resolve_asm_value(val, Some((&space, here)))
                                    .map_err(|e| alloc::format!("inline asm: {e}"))?
                                {
                                    AsmResolved::Abs(c) => {
                                        if !value_fits_width(c, *width) {
                                            return Err(alloc::format!(
                                                "inline asm: value {c} does not fit a {width}-byte field"
                                            ));
                                        }
                                        push_le(&mut sec.bytes, c as i128, *width as usize);
                                    }
                                    AsmResolved::Reloc {
                                        target,
                                        addend,
                                        pcrel,
                                    } => {
                                        if !matches!(width, 1 | 2 | 4 | 8) {
                                            return Err(alloc::string::String::from(
                                                "inline asm: section reference needs a 1-, 2-, 4-, or 8-byte field",
                                            ));
                                        }
                                        sec.relocs.push(AsmSectionReloc {
                                            offset: sec.bytes.len() as u32,
                                            width: *width,
                                            kind: AsmRelocKind::Data,
                                            pcrel,
                                            branch: false,
                                            signed: false,
                                            target,
                                            addend,
                                        });
                                        sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                                    }
                                }
                            }
                            AsmSectionValue::OperandReloc {
                                idx,
                                goto,
                                addend,
                                pcrel,
                            } => {
                                if !matches!(width, 1 | 2 | 4 | 8) {
                                    return Err(alloc::string::String::from(
                                        "inline asm: section reference needs a 1-, 2-, 4-, or 8-byte field",
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
                                    kind: AsmRelocKind::Data,
                                    pcrel: *pcrel,
                                    branch: false,
                                    signed: false,
                                    target,
                                    addend: add,
                                });
                                sec.bytes.extend_from_slice(&[0u8; 8][..*width as usize]);
                            }
                        }
                    }
                }
                AsmSectionItem::CodeBytes {
                    bytes,
                    relocs,
                    short,
                } => {
                    // A replacement instruction's relocs are at offsets within
                    // its own bytes; rebase each to the section offset the
                    // instruction lands at, then append the machine bytes. A
                    // PC-relative reference to a label of this section
                    // resolves here -- GNU as emits no relocation for it --
                    // by patching the instruction field; other targets keep
                    // their relocation (a numeric label's name rewritten to
                    // its per-instance symbol).
                    let base = sec.bytes.len() as u32;
                    let key = section_key(b);
                    // A relaxable branch takes the form the measurement
                    // settled on; anything else has one encoding.
                    let short = short.as_ref().filter(|_| !measured.long_form((bi, ii)));
                    let (bytes, relocs) = match short {
                        Some(s) => (&s.bytes, core::slice::from_ref(&s.reloc)),
                        None => (bytes, relocs.as_slice()),
                    };
                    let mut buf = bytes.clone();
                    for r in relocs {
                        let mut r = r.clone();
                        // An operand expression resolves against the layout
                        // here: what folds lands in the field, what keeps a
                        // symbol relocates against it.
                        // A relaxable branch binds any same-section name the
                        // link cannot rebind; every other field binds only a
                        // local one.
                        let rebindable = match r.kind {
                            AsmRelocKind::JumpRel => &weak_only,
                            _ => &non_local,
                        };
                        if let AsmSectionTarget::Expr(text) = &r.target {
                            let place = base as i64 + r.offset as i64;
                            // `.` in an operand is the instruction's own
                            // address, which is where this item starts.
                            let resolve = |t: &str| {
                                section_expr_leaf(
                                    t,
                                    &key,
                                    base as i64,
                                    &measured,
                                    sink_labels,
                                    &num_unique,
                                    label_off,
                                )
                            };
                            let ctx = AsmExprCtx {
                                resolve: &resolve,
                                const_of,
                                lax_div: false,
                            };
                            let space = AsmSpace::Section(key.clone());
                            match resolve_asm_field_expr(
                                text,
                                &ctx,
                                &space,
                                place,
                                r.addend,
                                r.pcrel || r.kind.self_relative(),
                                rebindable,
                            )? {
                                AsmFieldTarget::Abs(c) => {
                                    store_asm_insn_const(&mut buf, r.offset as usize, &r, c)
                                        .map_err(|e| alloc::format!("inline asm: `{text}`: {e}"))?;
                                    continue;
                                }
                                AsmFieldTarget::Reloc {
                                    target,
                                    addend,
                                    pcrel,
                                } => {
                                    r.target = target;
                                    r.addend = addend;
                                    // A data field's PC-relativity rides the
                                    // relocation; an instruction field's is
                                    // its kind's and stays as encoded.
                                    if let Some(p) = pcrel
                                        && matches!(
                                            r.kind,
                                            AsmRelocKind::Data | AsmRelocKind::JumpRel
                                        )
                                    {
                                        r.pcrel = p;
                                    }
                                }
                            }
                        }
                        let (leaf, local) = match &r.target {
                            // An instruction field resolves at the location
                            // its `.set` chain ends at, and binds as the name
                            // written does: an assignment gives the alias its
                            // own binding, and that is what decides whether
                            // the link may rebind the reference. A data
                            // directive's field keeps the name written.
                            AsmSectionTarget::Symbol(n) => (
                                section_expr_leaf(
                                    measured.alias_target(n.as_str()),
                                    &key,
                                    0,
                                    &measured,
                                    sink_labels,
                                    &num_unique,
                                    label_off,
                                ),
                                !rebindable.contains(n.as_str()),
                            ),
                            _ => (None, true),
                        };
                        match leaf {
                            Some(AsmExprLeaf::Loc(t)) => {
                                let same = matches!(
                                    &t.space,
                                    Some((AsmSpace::Section(k), _)) if *k == key
                                );
                                let off = match t.space {
                                    Some((_, off)) => off,
                                    None => 0,
                                };
                                let place = base as i64 + r.offset as i64;
                                if same
                                    && local
                                    && patch_asm_insn_field(
                                        &mut buf,
                                        r.offset as usize,
                                        r.kind,
                                        r.pcrel,
                                        r.width,
                                        off + r.addend - place,
                                    )?
                                {
                                    continue;
                                }
                                // The chain end replaces the name written
                                // where the link cannot rebind the reference,
                                // or where the end is a name the link binds
                                // too. Reducing a rebindable reference to a
                                // location pins it to this unit's definition.
                                let end_binds = matches!(
                                    &t.target,
                                    AsmSectionTarget::Symbol(e) if non_local.contains(e.as_str())
                                );
                                if local || end_binds {
                                    r.target = t.target;
                                }
                            }
                            Some(AsmExprLeaf::Abs(_)) => {
                                return Err(alloc::string::String::from(
                                    "inline asm: instruction relocates against an absolute symbol",
                                ));
                            }
                            None => {}
                        }
                        // The short form was chosen because the target is a
                        // label of this section the field reaches. A
                        // reference that instead needs a relocation would
                        // hand the link a field too narrow to fill.
                        if short.is_some() {
                            return Err(alloc::format!(
                                "inline asm: short branch to `{:?}` needs a relocation",
                                r.target
                            ));
                        }
                        r.offset += base;
                        sec.relocs.push(r);
                    }
                    sec.bytes.extend_from_slice(&buf);
                }
                AsmSectionItem::Code(text) => {
                    return Err(alloc::format!(
                        "inline asm: replacement instruction `{text}` in a named section is not \
                         assembled for this target"
                    ));
                }
            }
            // Alignment padding follows the instruction boundary the last
            // byte-emitting item left; the padding itself sets none.
            match item {
                AsmSectionItem::CodeBytes { .. } => {
                    sec.after_insn = true;
                    // gas gives a section holding instructions at least the
                    // architecture's instruction alignment (4 on AArch64,
                    // where `align_is_p2` holds; 1 on x86).
                    if align_is_p2 {
                        sec.align = sec.align.max(4);
                    }
                }
                AsmSectionItem::Data { .. }
                | AsmSectionItem::Fill { .. }
                | AsmSectionItem::Bytes(_)
                | AsmSectionItem::Org(..)
                | AsmSectionItem::OrgLabel { .. } => sec.after_insn = false,
                _ => {}
            }
            if !matches!(item, AsmSectionItem::Rept { .. }) {
                sec.map_state = step_map_state(item, sec.map_state, b.flags.contains('x'));
            }
            // Everything an item lays down other than an instruction is
            // data. `.align` recorded its own class above and `.rept` each
            // repetition's. A `.org` moves the location counter without
            // recording a run, as in GNU as, so the surrounding run covers
            // the gap.
            let laid = sec.bytes.len().saturating_sub(map_at);
            match item {
                AsmSectionItem::CodeBytes { .. } => sec.map.content(map_at, laid, MapClass::Code),
                AsmSectionItem::Align { .. }
                | AsmSectionItem::Rept { .. }
                | AsmSectionItem::Org(..)
                | AsmSectionItem::OrgLabel { .. }
                | AsmSectionItem::OrgExpr(..) => {}
                _ => sec.map.content(map_at, laid, MapClass::Data),
            }
        }
    }
    // `.weak` binds a matching section label weak; a name defined in no
    // section is a unit-level weak symbol the file-scope parse records.
    // TODO: this stays a whole-sink scan. The label index cannot serve it as
    // written: a `.weak` naming a label of its own statement has to see a
    // definition this call has not published yet. Templates carrying `.weak`
    // skip the loop entirely, so it is not on the export-table path.
    for name in &weak_names {
        for s in sink.sections.iter_mut() {
            for l in s.labels.iter_mut().filter(|l| l.name == *name) {
                l.weak = true;
            }
        }
    }
    // The same for `.globl`, whose declaration and definition need not share
    // a section: the kernel's `vdso-wrap.S` declares in the default section
    // and defines in `.rodata`. The per-section pass above already bound the
    // same-section case; this reaches the rest.
    for name in &global_names {
        for s in sink.sections.iter_mut() {
            for l in s
                .labels
                .iter_mut()
                .filter(|l| l.name == *name && l.offset != PENDING_LABEL)
            {
                l.global = true;
            }
        }
    }
    // A `.globl` naming no label in the section declares an external symbol,
    // not a definition here; it defines no section symbol. A `.type` / `.size`
    // that stays pending named a label the section never defines -- rejected
    // (a forward `.type` before its label was filled in by the definition).
    // Only this call's sections can hold a pending entry: every call drops
    // its own below, so none survives into the next.
    // A `.set name, symbol` alias is a symbol of the unit with no label of
    // its own, so a `.type` / `.size` over one stays pending here; the alias
    // takes its target's attributes.
    let aliased: alloc::collections::BTreeSet<&str> = blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::SymSet { name, .. } => Some(name.as_str()),
            _ => None,
        })
        .collect();
    for &(sec_idx, _) in &touched {
        let s = &mut sink.sections[sec_idx];
        if let Some(l) = s.labels.iter().find(|l| {
            l.offset == PENDING_LABEL
                && (l.sym_type != AsmSymType::NoType || l.size.is_some())
                && !aliased.contains(l.name.as_str())
        }) {
            return Err(alloc::format!(
                "inline asm: `.type`/`.size` names undefined label `{}`",
                l.name
            ));
        }
        s.labels.retain(|l| l.offset != PENDING_LABEL);
    }
    for &(sec_idx, from) in &touched {
        sink.publish_labels(sec_idx, from);
    }
    Ok(defined)
}

/// Apply `f` to every item of the blocks, including items nested in
/// `.rept` bodies, so the arch encoders reach a repeated instruction.
pub(crate) fn for_each_section_item_mut(
    blocks: &mut [AsmSectionBlock],
    f: &mut dyn FnMut(&mut AsmSectionItem) -> Result<(), alloc::string::String>,
) -> Result<(), alloc::string::String> {
    fn walk(
        items: &mut [AsmSectionItem],
        f: &mut dyn FnMut(&mut AsmSectionItem) -> Result<(), alloc::string::String>,
    ) -> Result<(), alloc::string::String> {
        for it in items {
            if let AsmSectionItem::Rept { items, .. } = it {
                walk(items, f)?;
            } else {
                f(it)?;
            }
        }
        Ok(())
    }
    for b in blocks {
        walk(&mut b.items, f)?;
    }
    Ok(())
}

/// Reject the unit-level symbol directives an operand statement's sections
/// carry that no channel of the emit path takes. `.set name, sym` is an
/// object-level alias the file-scope parse records; `.weak` inside a section
/// binds a label the section defines but has no carrier for a name it does
/// not, which the code stream's declarations provide.
/// TODO accept both in a function-scope statement's sections.
pub(crate) fn reject_unit_symbol_items(
    blocks: &[AsmSectionBlock],
) -> Result<(), alloc::string::String> {
    for item in blocks.iter().flat_map(|b| &b.items) {
        match item {
            AsmSectionItem::Weak(n) => {
                return Err(alloc::format!(
                    "inline asm: `.weak {n}` outside file-scope asm"
                ));
            }
            AsmSectionItem::SymSet { name, .. } => {
                return Err(alloc::format!(
                    "inline asm: `.set {name}, ...` outside file-scope asm"
                ));
            }
            _ => {}
        }
    }
    Ok(())
}

/// Prepare a file-scope template for section extraction: strip comments,
/// expand GNU as macro directives (file scope has no operands to
/// substitute), and rename numeric labels defined more than once to
/// per-definition unique names, each `Nb` / `Nf` reference binding to the
/// nearest definition in its direction (GNU as redefinable local labels).
/// The parse stores the prepared text, so the codegen materialization and
/// the parse-time validation see identical statements.
pub(crate) fn prepare_file_asm_text(
    text: &str,
    comments: AsmComments,
) -> Result<alloc::string::String, alloc::string::String> {
    let stripped = strip_asm_comments(text, comments);
    let text = stripped.as_deref().unwrap_or(text);
    let expanded = expand_asm_gas_macros(text, 4, &|_| None)?;
    let text = expanded.as_deref().unwrap_or(text);
    let renamed = rewrite_multidef_local_labels(text);
    Ok(renamed.unwrap_or_else(|| alloc::string::String::from(text)))
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
    sink: &mut AsmSectionSink,
) -> Result<(), alloc::string::String> {
    for text in templates {
        let stripped = strip_asm_comments(text, comments);
        let text = stripped.as_deref().unwrap_or(text);
        // The stream outside pushed sections is either linkage-only (`.globl`,
        // no bytes to emit here) or a trampoline body assembled as `.text`.
        // The probe runs the function-scope extractor, which rejects forms
        // only the file-scope one accepts; its error falls through.
        let mut blocks = match extract_asm_sections(text, align_is_p2) {
            Ok(Some(ex)) if ex.is_linkage_only() => {
                let mut blocks = ex.blocks;
                // `.globl` is unit-level, so it binds a label this template
                // defines in one of its sections as well as the C symbol the
                // parse already applied it to.
                if let Some(first) = blocks.first_mut() {
                    for name in ex.sym_items {
                        first.items.push(name);
                    }
                }
                blocks
            }
            _ => extract_file_scope_asm_sections(text, align_is_p2)?,
        };
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
    // GNU as symbol names take letters, digits, `_` and `.`; the first
    // character must not be a digit. A name of dots alone is the
    // location counter (`.`), not a symbol.
    let sym_char = |c: u8| c.is_ascii_alphanumeric() || c == b'_' || c == b'.';
    if !s
        .bytes()
        .next()
        .is_some_and(|c| c.is_ascii_alphabetic() || c == b'_' || c == b'.')
        || s.bytes().all(|c| c == b'.')
    {
        return false;
    }
    let mut rest = s;
    while let Some(p) = rest.find('%') {
        if !rest[..p].bytes().all(sym_char) {
            return false;
        }
        match split_operand_ref(&rest[p + 1..]) {
            Some((_, _, tail)) => rest = tail,
            None => return false,
        }
    }
    rest.bytes().all(sym_char)
}

/// True when `s` can spell a branch-target expression: a location
/// expression whose first character starts a symbol name, which keeps the
/// operand forms (`*%rax`, `$1`, `(%rax)`, a numeric label) out. An operand
/// reference is not part of the expression grammar, so a target embedding
/// one is a name and takes [`is_asm_symbol_template`]. Every leaf resolves
/// here: this tests the grammar, not the layout.
pub(crate) fn is_asm_branch_expr(s: &str) -> bool {
    let s = s.trim();
    if !s
        .bytes()
        .next()
        .is_some_and(|c| c.is_ascii_alphabetic() || c == b'_' || c == b'.')
    {
        return false;
    }
    let ctx = AsmExprCtx {
        resolve: &|_| Some(AsmExprLeaf::Abs(1)),
        const_of: &|_| Some(1),
        lax_div: true,
    };
    eval_asm_value(s, &ctx).is_ok()
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

// Numbering behind the `%=` template escape and the two asm-label
// uniquifiers. `reset_asm_instance` restarts it at the head of every
// lowering, so the names an object carries are a function of the program
// rather than of how much the process emitted before it; GNU likewise
// documents `%=` as unique per asm instance in one compilation. The labels
// are `STB_LOCAL` and separately compiled objects already number from
// zero, so restarting adds no collision the link does not handle.
// Thread-local under `std`: lowerings run concurrently under the test
// harness and must not share a sequence a peer can reset.
#[cfg(feature = "std")]
std::thread_local! {
    static ASM_INSTANCE: core::cell::Cell<u32> = const { core::cell::Cell::new(0) };
}

/// Next value of the per-lowering asm-instance sequence.
#[cfg(feature = "std")]
pub(crate) fn next_asm_instance() -> u32 {
    ASM_INSTANCE.with(|c| {
        let v = c.get();
        c.set(v.wrapping_add(1));
        v
    })
}

/// Restart the asm-instance sequence. Called once per lowering.
#[cfg(feature = "std")]
pub(crate) fn reset_asm_instance() {
    ASM_INSTANCE.with(|c| c.set(0));
}

/// no_std has no thread-local storage; the sequence is a plain atomic.
#[cfg(not(feature = "std"))]
static ASM_INSTANCE: core::sync::atomic::AtomicU32 = core::sync::atomic::AtomicU32::new(0);

#[cfg(not(feature = "std"))]
pub(crate) fn next_asm_instance() -> u32 {
    ASM_INSTANCE.fetch_add(1, core::sync::atomic::Ordering::Relaxed)
}

#[cfg(not(feature = "std"))]
pub(crate) fn reset_asm_instance() {
    ASM_INSTANCE.store(0, core::sync::atomic::Ordering::Relaxed);
}

/// Expand the `%=` template escape: every occurrence in one template gets the
/// same number, unique per expansion (GCC gives each asm instance its own).
/// `%%` is the literal-percent escape, so its trailing `%` never starts a
/// `%=`. Returns `None` when the template has no `%=` (the common case).
pub(crate) fn expand_template_uniq(text: &str) -> Option<alloc::string::String> {
    if !text.contains("%=") {
        return None;
    }
    let uniq = next_asm_instance();
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
    for piece in split_asm_statements(text) {
        let piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        any = true;
        out.extend_from_slice(&parse_raw_piece(piece)?);
    }
    any.then_some(out)
}

/// Byte list `.inst` expands to. GNU as assembles `.inst` into
/// instructions, so the bytes carry the code class a `.byte` list does not;
/// the name is internal and cannot collide with a source directive.
pub(crate) const INST_BYTES_DIRECTIVE: &str = ".c5_inst_bytes";

/// Element width of a `.byte`-family data directive keyword, or `None`.
pub(crate) fn data_directive_width(tok: &str) -> Option<usize> {
    Some(match tok {
        ".byte" | INST_BYTES_DIRECTIVE => 1,
        ".word" | ".2byte" | ".short" | ".hword" => 2,
        ".long" | ".4byte" | ".int" => 4,
        ".quad" | ".8byte" => 8,
        ".octa" => 16,
        _ => return None,
    })
}

/// The mapping class a `.byte`-family directive keyword lays down, or
/// `None` when the keyword is not one. This is the keyword-level form of
/// the rule [`step_map_state`] applies to a parsed section item: `.inst`
/// assembles to instructions, every other data directive to data.
pub(crate) fn data_directive_class(tok: &str) -> Option<MapClass> {
    data_directive_width(tok).map(|_| {
        if tok == INST_BYTES_DIRECTIVE {
            MapClass::Code
        } else {
            MapClass::Data
        }
    })
}

fn parse_raw_piece(piece: &str) -> Option<alloc::vec::Vec<u8>> {
    let width = data_directive_width(piece.split_whitespace().next()?);
    if let Some(w) = width {
        let args = piece[piece.find(char::is_whitespace)?..].trim();
        let mut out = alloc::vec::Vec::new();
        for a in args.split(',') {
            push_le(&mut out, eval_const_expr_wide(a.trim())?, w);
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
    let ctx = AsmExprCtx {
        resolve: &|_| None,
        const_of: op,
        lax_div: false,
    };
    eval_asm_value(s, &ctx).ok().and_then(|v| v.to_abs())
}

/// Evaluate an assembler `.if` condition: a constant expression whose result
/// may come from the comparison (-1/0) and logical (1/0) operators. A
/// non-zero result is true. `None` when the condition is not a constant.
pub(crate) fn eval_asm_if_condition(s: &str) -> Option<i64> {
    eval_asm_count(s, &|_| None)
}

/// Evaluate a constant expression whose leaves may include `%N` / `%cN`
/// operand references, resolved through `op`. This is the form a
/// `.skip` / `.fill` count takes.
pub(crate) fn eval_asm_count(s: &str, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    eval_const_expr_ops(s, op)
}

/// Evaluate a GNU as constant expression whose leaves may be label
/// references, resolved through `resolve` (a label name to its value). The
/// alternatives `.skip` count mixes template-label and section-label
/// differences (`-(((775f-774f)-(772b-771b)) > 0) * (...)`). `None` when a
/// leaf is unresolved or the result is not a constant.
pub(crate) fn eval_asm_expr_with_labels(
    expr: &str,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> Option<i64> {
    let ctx = AsmExprCtx {
        resolve: &|t| resolve(t).map(AsmExprLeaf::Abs),
        const_of: &|_| None,
        lax_div: false,
    };
    eval_asm_value(expr, &ctx).ok().and_then(|v| v.to_abs())
}

/// Whether `tok` is a well-formed GNU as expression whose value only the
/// layout knows. Every leaf stands in as zero, so this checks grammar alone.
pub(crate) fn is_asm_layout_expr(tok: &str) -> bool {
    let ctx = AsmExprCtx {
        resolve: &|_| Some(AsmExprLeaf::Abs(0)),
        const_of: &|_| None,
        lax_div: true,
    };
    !tok.is_empty() && eval_asm_value(tok, &ctx).is_ok()
}

/// Whether `name` spells a template label reference: a numeric `Nb` / `Nf`
/// or a name in the template's intern table.
pub(crate) fn is_template_label(name: &str, names: &[&str]) -> bool {
    names.contains(&name) || numeric_label_digits(name).is_some_and(|d| d.len() < name.len())
}

/// Whether every leaf of `expr` is a template label or a literal, so the
/// emitted stream settles its value with no relocation.
pub(crate) fn is_template_label_expr(expr: &str, names: &[&str]) -> bool {
    let all = core::cell::Cell::new(true);
    let resolve = |t: &str| {
        all.set(all.get() && is_template_label(t, names));
        Some(AsmExprLeaf::Abs(0))
    };
    let ctx = AsmExprCtx {
        resolve: &resolve,
        const_of: &|_| None,
        lax_div: true,
    };
    eval_asm_value(expr, &ctx).is_ok() && all.get()
}

/// The stream offset a template label reference stands for, under the GNU as
/// local-label rule: `Nb` binds to the nearest definition at or before `at`,
/// `Nf` to the nearest after it, a name to its single definition. `names` is
/// the template's intern table.
pub(crate) fn template_label_offset(
    name: &str,
    at: usize,
    label_defs: &[(u32, usize)],
    names: &[&str],
) -> Option<i64> {
    let nearest = |num: u32, forward: bool| -> Option<i64> {
        let defs = label_defs.iter().filter(|&&(n, _)| n == num);
        if forward {
            defs.filter(|&&(_, off)| off > at).map(|&(_, o)| o).min()
        } else {
            defs.filter(|&&(_, off)| off <= at).map(|&(_, o)| o).max()
        }
        .map(|o| o as i64)
    };
    if let Some(idx) = names.iter().position(|&n| n == name) {
        let num = NAMED_LABEL_BASE + idx as u32;
        return label_defs
            .iter()
            .find(|&&(n, _)| n == num)
            .map(|&(_, o)| o as i64);
    }
    let digits = numeric_label_digits(name)?;
    if digits.len() == name.len() {
        return None;
    }
    nearest(digits.parse().ok()?, name.ends_with('f'))
}

/// Substitute each identifier `resolve` knows with its value, leaving other
/// tokens -- numeric literals, unknown symbols, the location counter `.` --
/// as written. Identifier characters are the assembler's: alphanumeric plus
/// `_` / `.` / `$`; `$` continues a name but does not start one, so the AT&T
/// immediate sigil in `$sym` separates from the name it prefixes while a
/// symbol spelled `x$y` stays one token.
pub(crate) fn subst_asm_idents(
    text: &str,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> alloc::string::String {
    subst_asm_idents_text(text, &|t| resolve(t).map(|v| alloc::format!("{v}")))
}

/// Text-valued form of [`subst_asm_idents`]: the resolver yields the
/// replacement text (a register alias, a folded number).
pub(crate) fn subst_asm_idents_text(
    text: &str,
    resolve: &dyn Fn(&str) -> Option<alloc::string::String>,
) -> alloc::string::String {
    let b = text.as_bytes();
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let ident_start = |c: u8| ident(c) && c != b'$';
    let mut out = alloc::string::String::with_capacity(text.len());
    let mut i = 0;
    while i < b.len() {
        if ident_start(b[i]) {
            let start = i;
            while i < b.len() && ident(b[i]) {
                i += 1;
            }
            let tok = &text[start..i];
            match resolve(tok) {
                Some(v) => out.push_str(&v),
                None => out.push_str(tok),
            }
        } else {
            out.push(b[i] as char);
            i += 1;
        }
    }
    out
}

fn skip_ws(b: &[u8], i: &mut usize) {
    while *i < b.len() && b[*i].is_ascii_whitespace() {
        *i += 1;
    }
}

/// Evaluate an assembler expression over the location-value domain. The
/// operator grouping is GNU as's: `* / % << >>` bind tightest, then
/// `| & ^`, then `+ -`, then the comparisons (yielding -1/0), then `&&`
/// and `||` (yielding 1/0). Only `+` and `-` operate on symbolic terms;
/// every other operator requires absolute operands.
pub(crate) fn eval_asm_value(
    s: &str,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let b = s.as_bytes();
    let mut i = 0usize;
    let v = val_logor(b, s, &mut i, ctx)?;
    skip_ws(b, &mut i);
    if i != b.len() {
        return Err(alloc::format!("junk `{}` after expression", &s[i..]));
    }
    Ok(v)
}

/// Require an absolute operand for a non-additive operator.
fn val_abs(v: AsmExprValue, opname: &str) -> Result<i64, alloc::string::String> {
    v.to_abs()
        .ok_or_else(|| alloc::format!("operand of `{opname}` is not absolute"))
}

fn val_logor(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_logand(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        if b.get(*i) == Some(&b'|') && b.get(*i + 1) == Some(&b'|') {
            *i += 2;
            let rhs = val_logand(b, s, i, ctx)?;
            v = AsmExprValue::abs(((val_abs(v, "||")? != 0) || (val_abs(rhs, "||")? != 0)) as i64);
        } else {
            return Ok(v);
        }
    }
}

fn val_logand(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_relational(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        if b.get(*i) == Some(&b'&') && b.get(*i + 1) == Some(&b'&') {
            *i += 2;
            let rhs = val_relational(b, s, i, ctx)?;
            v = AsmExprValue::abs(((val_abs(v, "&&")? != 0) && (val_abs(rhs, "&&")? != 0)) as i64);
        } else {
            return Ok(v);
        }
    }
}

fn val_relational(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_add(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        let (rel, len): (fn(i64, i64) -> bool, usize) = match (b.get(*i), b.get(*i + 1)) {
            (Some(b'='), Some(b'=')) => (|a, c| a == c, 2),
            (Some(b'!'), Some(b'=')) => (|a, c| a != c, 2),
            (Some(b'<'), Some(b'>')) => (|a, c| a != c, 2),
            (Some(b'<'), Some(b'=')) => (|a, c| a <= c, 2),
            (Some(b'>'), Some(b'=')) => (|a, c| a >= c, 2),
            (Some(b'<'), n) if n != Some(&b'<') => (|a, c| a < c, 1),
            (Some(b'>'), n) if n != Some(&b'>') => (|a, c| a > c, 1),
            _ => return Ok(v),
        };
        let equality = matches!(
            (b[*i], b.get(*i + 1)),
            (b'=', _) | (b'!', _) | (b'<', Some(b'>'))
        );
        *i += len;
        let rhs = val_add(b, s, i, ctx)?;
        // GNU as yields -1 (all bits set) for a true comparison, 0 for false;
        // the alternatives `.skip` padding `-((rlen-slen) > 0) * (rlen-slen)`
        // relies on the -1 to recover a positive count. The comparison is of
        // the difference against zero, so same-space terms cancel first. An
        // equality between two undefined symbols compares the symbols, which
        // GNU as reads as unequal (`.if \base == %rsp` with two register
        // names); a residual term that is a location in this unit is a
        // distance the comparison cannot take before the layout gives it one.
        let d = v.combine(rhs, true)?;
        let undefined = |t: &Option<AsmExprTerm>| t.as_ref().is_none_or(|t| t.space.is_none());
        let truth = match d.to_abs() {
            Some(d) => rel(d, 0),
            None if equality && undefined(&d.pos) && undefined(&d.neg) => rel(1, 0),
            None => {
                return Err(alloc::string::String::from(
                    "operand of `comparison` is not absolute",
                ));
            }
        };
        v = AsmExprValue::abs(if truth { -1 } else { 0 });
    }
}

fn val_add(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_bitgroup(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        let sub = match b.get(*i) {
            Some(b'+') => false,
            Some(b'-') => true,
            _ => return Ok(v),
        };
        *i += 1;
        let rhs = val_bitgroup(b, s, i, ctx)?;
        v = v.combine(rhs, sub)?;
    }
}

/// `| & ^` share one precedence level in GNU as, associating left.
fn val_bitgroup(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_mul(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        let op = match b.get(*i) {
            Some(&c @ b'|') if b.get(*i + 1) != Some(&b'|') => c,
            Some(&c @ b'&') if b.get(*i + 1) != Some(&b'&') => c,
            Some(&c @ b'^') => c,
            _ => return Ok(v),
        };
        *i += 1;
        let rhs = val_mul(b, s, i, ctx)?;
        let (a, c) = (val_abs(v, "bitwise op")?, val_abs(rhs, "bitwise op")?);
        v = AsmExprValue::abs(match op {
            b'|' => a | c,
            b'&' => a & c,
            _ => a ^ c,
        });
    }
}

/// `* / % << >>` share the tightest binary level in GNU as.
fn val_mul(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_unary(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        let op = match (b.get(*i), b.get(*i + 1)) {
            (Some(&c @ (b'*' | b'/' | b'%')), _) => {
                *i += 1;
                c
            }
            (Some(b'<'), Some(b'<')) => {
                *i += 2;
                b'l'
            }
            (Some(b'>'), Some(b'>')) => {
                *i += 2;
                b'r'
            }
            _ => return Ok(v),
        };
        let rhs = val_unary(b, s, i, ctx)?;
        let (a, c) = (val_abs(v, "arithmetic op")?, val_abs(rhs, "arithmetic op")?);
        let r = match op {
            b'*' => a.checked_mul(c).ok_or("overflow in expression")?,
            b'/' | b'%' if c == 0 => {
                if !ctx.lax_div {
                    return Err(alloc::string::String::from("division by zero"));
                }
                0
            }
            b'/' => a.wrapping_div(c),
            b'%' => a.wrapping_rem(c),
            _ => {
                if !(0..64).contains(&c) {
                    return Err(alloc::format!("shift count {c} out of range"));
                }
                // GNU as shifts the 64-bit value, so `>>` does not replicate
                // the sign bit: `~0 >> 63` is 1, not -1.
                if op == b'l' {
                    a << c
                } else {
                    ((a as u64) >> c) as i64
                }
            }
        };
        v = AsmExprValue::abs(r);
    }
}

fn val_unary(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    skip_ws(b, i);
    match b.get(*i) {
        Some(b'-') => {
            *i += 1;
            AsmExprValue::abs(0).combine(val_unary(b, s, i, ctx)?, true)
        }
        Some(b'+') => {
            *i += 1;
            val_unary(b, s, i, ctx)
        }
        Some(b'~') => {
            *i += 1;
            Ok(AsmExprValue::abs(!val_abs(val_unary(b, s, i, ctx)?, "~")?))
        }
        // Prefix logical negation, yielding 1/0; `!=` in operand position is
        // the relational operator.
        Some(b'!') if b.get(*i + 1) != Some(&b'=') => {
            *i += 1;
            Ok(AsmExprValue::abs(
                (val_abs(val_unary(b, s, i, ctx)?, "!")? == 0) as i64,
            ))
        }
        Some(b'(') => {
            *i += 1;
            let v = val_logor(b, s, i, ctx)?;
            skip_ws(b, i);
            if b.get(*i) != Some(&b')') {
                return Err(alloc::string::String::from("missing `)` in expression"));
            }
            *i += 1;
            Ok(v)
        }
        // `%N` / `%cN` / `%PN`: an operand's compile-time constant. Any
        // other `%name` is a symbol, as GNU as reads it in an expression
        // (`.if \base == %rsp` compares two references to one symbol).
        Some(b'%') => {
            let pct = *i;
            *i += 1;
            let modifier = matches!(b.get(*i), Some(b'c' | b'P'));
            if modifier {
                *i += 1;
            }
            let start = *i;
            while *i < b.len() && b[*i].is_ascii_digit() {
                *i += 1;
            }
            if *i == start {
                let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
                *i = pct + 1;
                while *i < b.len() && ident(b[*i]) {
                    *i += 1;
                }
                if *i == pct + 1 {
                    return Err(alloc::string::String::from(
                        "bad operand reference in expression",
                    ));
                }
                return Ok(AsmExprValue::from_term(AsmExprTerm {
                    space: None,
                    target: AsmSectionTarget::Symbol(alloc::string::String::from(&s[pct..*i])),
                }));
            }
            let idx: u8 = s
                .get(start..*i)
                .and_then(|t| t.parse().ok())
                .ok_or("bad operand reference in expression")?;
            (ctx.const_of)(idx)
                .map(AsmExprValue::abs)
                .ok_or_else(|| alloc::format!("operand %{idx} is not a constant"))
        }
        _ => val_leaf(b, s, i, ctx),
    }
}

/// A leaf: a literal, the location counter `.`, a numeric-label reference
/// (`14472b`), or an identifier -- a `.set` symbol, a label, or an
/// undefined symbol.
fn val_leaf(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    skip_ws(b, i);
    if let Some((v, next)) = parse_asm_char_const(b, *i) {
        *i = next;
        return Ok(AsmExprValue::abs(v));
    }
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let start = *i;
    while *i < b.len() && ident(b[*i]) {
        *i += 1;
    }
    if *i == start {
        return Err(alloc::format!(
            "expression expected at `{}`",
            &s[start..s.len().min(start + 12)]
        ));
    }
    let tok = &s[start..*i];
    let leaf_of = |tok: &str| -> Result<AsmExprValue, alloc::string::String> {
        match (ctx.resolve)(tok) {
            Some(AsmExprLeaf::Abs(v)) => Ok(AsmExprValue::abs(v)),
            Some(AsmExprLeaf::Loc(t)) => Ok(AsmExprValue::from_term(t)),
            // An unresolved name is an undefined symbol: a bare term the
            // deposit turns into a relocation (or rejects where an absolute
            // value is required).
            None => Ok(AsmExprValue::from_term(AsmExprTerm {
                space: None,
                target: AsmSectionTarget::Symbol(alloc::string::String::from(tok)),
            })),
        }
    };
    if tok == "." {
        return match (ctx.resolve)(".") {
            Some(AsmExprLeaf::Abs(v)) => Ok(AsmExprValue::abs(v)),
            Some(AsmExprLeaf::Loc(t)) => Ok(AsmExprValue::from_term(t)),
            None => Err(alloc::string::String::from(
                "the location counter `.` is not available here",
            )),
        };
    }
    if tok.as_bytes()[0].is_ascii_digit() {
        // A digit run ending in `b` / `f` is a numeric-label reference,
        // except a binary literal (`0b101`).
        if let Some(digits) = numeric_label_digits(tok)
            && digits.len() < tok.len()
            && !(tok.len() > 2 && (tok.starts_with("0b") || tok.starts_with("0B")))
        {
            return leaf_of(tok);
        }
        return parse_asm_number(tok)
            .map(AsmExprValue::abs)
            .ok_or_else(|| alloc::format!("bad numeric literal `{tok}`"));
    }
    leaf_of(tok)
}

/// Parse a GNU as character constant `'c'` at `at`, returning its value and
/// the index past it. The escapes are C's plus GNU as's octal and hex forms.
/// GNU as also accepts the unterminated `'c` spelling.
fn parse_asm_char_const(b: &[u8], at: usize) -> Option<(i64, usize)> {
    if b.get(at) != Some(&b'\'') {
        return None;
    }
    let mut i = at + 1;
    let c = *b.get(i)?;
    i += 1;
    let v = if c != b'\\' {
        c as i64
    } else {
        let e = *b.get(i)?;
        i += 1;
        match e {
            b'n' => 10,
            b't' => 9,
            b'r' => 13,
            b'b' => 8,
            b'f' => 12,
            b'v' => 11,
            b'a' => 7,
            b'e' => 27,
            b'x' | b'X' => {
                let start = i;
                let mut v: i64 = 0;
                while let Some(d) = b.get(i).and_then(|c| (*c as char).to_digit(16)) {
                    v = (v << 4) | d as i64;
                    i += 1;
                }
                if i == start {
                    return None;
                }
                v & 0xff
            }
            b'0'..=b'7' => {
                let mut v = (e - b'0') as i64;
                for _ in 0..2 {
                    match b.get(i) {
                        Some(d @ b'0'..=b'7') => {
                            v = (v << 3) | (d - b'0') as i64;
                            i += 1;
                        }
                        _ => break,
                    }
                }
                v & 0xff
            }
            other => other as i64,
        }
    };
    if b.get(i) == Some(&b'\'') {
        i += 1;
    }
    Some((v, i))
}

/// Parse an assembler integer literal: decimal, `0x` hex, `0b` binary, or
/// `0`-prefixed octal, with the C suffixes accepted and ignored. The value
/// wraps at 64 bits, as GNU as computes.
fn parse_asm_number(t: &str) -> Option<i64> {
    let t = t.trim_end_matches(['u', 'U', 'l', 'L']);
    let (radix, digits) = if let Some(h) = t.strip_prefix("0x").or_else(|| t.strip_prefix("0X")) {
        (16, h)
    } else if let Some(bin) = t.strip_prefix("0b").or_else(|| t.strip_prefix("0B")) {
        (2, bin)
    } else if t.len() > 1 && t.starts_with('0') {
        (8, &t[1..])
    } else {
        (10, t)
    };
    if digits.is_empty() {
        return None;
    }
    u64::from_str_radix(digits, radix).ok().map(|v| v as i64)
}

/// Evaluate a data-directive value as a 128-bit constant. A literal too wide
/// for 64 bits parses directly (GNU as accepts a bignum wherever the
/// directive's field can hold it); anything else falls back to the 64-bit
/// expression evaluator and sign-extends, as GNU as does for `.octa -1`.
pub(crate) fn eval_const_expr_wide(s: &str) -> Option<i128> {
    let t = s.trim();
    let digits = t.trim_end_matches(['u', 'U', 'l', 'L']);
    if let Some(h) = digits
        .strip_prefix("0x")
        .or_else(|| digits.strip_prefix("0X"))
        && !h.is_empty()
        && let Ok(v) = u128::from_str_radix(h, 16)
    {
        return Some(v as i128);
    }
    eval_const_expr(t).map(i128::from)
}

/// Append the low `width` bytes of a value, little-endian. A field wider than
/// the evaluated expression takes its sign extension.
fn push_le(out: &mut alloc::vec::Vec<u8>, value: i128, width: usize) {
    out.extend_from_slice(&value.to_le_bytes()[..width]);
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
    if !inst.is_pure() {
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

    /// The name of the block each statement's items landed in, for the
    /// section-stack tests below.
    fn block_of(blocks: &[AsmSectionBlock], label: &str) -> alloc::string::String {
        blocks
            .iter()
            .find(|b| {
                b.items
                    .iter()
                    .any(|i| matches!(i, AsmSectionItem::Label(n) if n == label))
            })
            .map(|b| b.name.clone())
            .unwrap_or_else(|| alloc::string::String::from("<none>"))
    }

    /// GNU as keeps the previous section beside the `.pushsection` stack, so
    /// a `.section` / `.previous` pair nested in a pushed region returns to
    /// the pushed section and leaves the stack depth alone. This is the shape
    /// the kernel's `EXPORT_SYMBOL` assembly macro has inside a
    /// `.pushsection`-bracketed function.
    #[test]
    fn previous_returns_to_the_section_a_section_directive_left() {
        let text = ".pushsection .noinstr.text,\"ax\"\ninner:\n.section \"a\",\"a\"\nexported:\n\
                    .previous\nback:\n.popsection\nouter:\n";
        let blocks = extract_file_scope_asm_sections(text, false).unwrap();
        assert_eq!(block_of(&blocks, "inner"), ".noinstr.text");
        assert_eq!(block_of(&blocks, "exported"), "a");
        assert_eq!(block_of(&blocks, "back"), ".noinstr.text");
        assert_eq!(block_of(&blocks, "outer"), ".text");
    }

    /// `.previous` toggles: a second one returns to where the first came
    /// from, as GNU as does with its single previous-section slot.
    #[test]
    fn previous_toggles_between_two_sections() {
        let text = ".section \"a\",\"a\"\nin_a:\n.section \"b\",\"a\"\nin_b:\n\
                    .previous\nback_a:\n.previous\nback_b:\n";
        let blocks = extract_file_scope_asm_sections(text, false).unwrap();
        assert_eq!(block_of(&blocks, "back_a"), "a");
        assert_eq!(block_of(&blocks, "back_b"), "b");
    }

    /// `.globl` is a unit-level declaration: the definition may be in another
    /// section, which is how the kernel's `vdso-wrap.S` names its payload
    /// bounds.
    #[test]
    fn globl_binds_a_label_defined_in_another_section() {
        let text = ".globl start, end\n.section .rodata,\"a\"\nstart:\n.byte 1\nend:\n";
        let blocks = extract_file_scope_asm_sections(text, false).unwrap();
        let mut sink = AsmSectionSink::default();
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
        let labels: alloc::vec::Vec<_> = sink
            .iter()
            .flat_map(|s| s.labels.iter())
            .map(|l| (l.name.as_str(), l.global))
            .collect();
        assert!(labels.contains(&("start", true)), "{labels:?}");
        assert!(labels.contains(&("end", true)), "{labels:?}");
    }

    /// A `.set` to a constant folds into the expressions that read it, and
    /// additionally defines an absolute symbol when the unit gave the name
    /// external linkage -- what GNU as puts in `.symtab` as `SHN_ABS`.
    #[test]
    fn an_exported_constant_assignment_defines_an_absolute_symbol() {
        let text = ".globl len\n.section .rodata,\"a\"\nlen = 12345\nblob:\n.long len\n";
        let prepared = prepare_file_asm_text(text, AsmComments::X86).unwrap();
        let blocks = extract_file_scope_asm_sections(&prepared, false).unwrap();
        let mut sink = AsmSectionSink::default();
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
        let s = sink
            .iter()
            .find(|s| s.name == ".rodata")
            .expect("section built");
        assert_eq!(&s.bytes[..], &12345u32.to_le_bytes(), "the read folds");
        let len = s
            .labels
            .iter()
            .find(|l| l.name == "len")
            .expect("symbol defined");
        assert_eq!(len.absolute, Some(12345));
        assert!(len.global);
    }

    #[test]
    fn extract_and_materialize() {
        let text = "1: nop\n.pushsection .discard.t,\"aw\",@progbits\n.balign 8\n.quad 1b\n.long 1b - .\n.long %c0, 7\n.asciz \"hi\"\n.popsection\nnop\n";
        let AsmExtract { code, blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        // The `1:` label is peeled onto its own line ahead of the `nop`.
        assert_eq!(code, "1:\nnop\nnop\n");
        assert_eq!(blocks.len(), 1);
        assert_eq!(blocks[0].name, ".discard.t");
        assert_eq!(blocks[0].flags, "aw");
        assert_eq!(blocks[0].sh_type.as_deref(), Some("progbits"));
        let mut sink = AsmSectionSink::default();
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
                kind: AsmRelocKind::Data,
                pcrel: false,
                branch: false,
                signed: false,
                target: AsmSectionTarget::Text(0x40),
                addend: 0
            }
        );
        assert_eq!(
            s.relocs[1],
            AsmSectionReloc {
                offset: 8,
                width: 4,
                kind: AsmRelocKind::Data,
                pcrel: true,
                branch: false,
                signed: false,
                target: AsmSectionTarget::Text(0x40),
                addend: 0
            }
        );
    }

    #[test]
    fn align_fill_and_max_skip() {
        // `.balign`/`.p2align`/`.align` fill: an executable section defaults to
        // the target NOP, a data section to zero, and an explicit fill byte
        // other than the one-byte NOP wins for either. A max skip drops the
        // alignment when the gap is larger. Matches GNU as byte-for-byte.
        let mat = |text: &str, aarch64: bool| -> alloc::vec::Vec<u8> {
            let AsmExtract { blocks, .. } = extract_asm_sections(text, aarch64).unwrap().unwrap();
            let mut sink = AsmSectionSink::default();
            materialize_asm_sections(
                &blocks,
                &|_| None,
                &|_| None,
                &|_| None,
                &|_| None,
                aarch64,
                &mut sink,
            )
            .unwrap();
            sink[0].bytes.clone()
        };
        let exec = mat(
            ".pushsection .t,\"ax\"\n.byte 1\n.balign 8\n.byte 2\n.popsection\n",
            false,
        );
        assert_eq!(exec.len(), 9);
        // x86 executable default fill is the GNU as multi-byte NOP run. The
        // gap opens after a data directive, so it leads with the one-byte NOP
        // and the remaining six take the 6-byte NOP.
        assert_eq!(exec[1..8], [0x90, 0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00]);
        let data = mat(
            ".pushsection .t,\"aw\"\n.byte 1\n.balign 8\n.byte 2\n.popsection\n",
            false,
        );
        assert!(data[1..8].iter().all(|&b| b == 0x00));
        let zero = mat(
            ".pushsection .t,\"ax\"\n.byte 1\n.balign 8, 0\n.byte 2\n.popsection\n",
            false,
        );
        assert!(zero[1..8].iter().all(|&b| b == 0x00));
        // AArch64 executable default fill is the 4-byte NOP (0xd503201f).
        let a64 = mat(
            ".pushsection .t,\"ax\"\n.long 0\n.balign 16\n.long 0\n.popsection\n",
            true,
        );
        let nop = [0x1f, 0x20, 0x03, 0xd5];
        assert!((4..16).all(|i| a64[i] == nop[i % 4]));
        // A max skip larger than the alignment gap drops the padding.
        let skip = mat(
            ".pushsection .t,\"ax\"\n.byte 1\n.balign 16, 0x90, 3\n.byte 2\n.popsection\n",
            false,
        );
        assert_eq!(skip.len(), 2);
    }

    #[test]
    fn a64_exec_align_fill_matches_gnu_as() {
        // GNU as splits an AArch64 code-section alignment gap: the gap's
        // sub-word remainder as zeros, then whole NOPs. The split is by the
        // gap, not by the offset, so a `.balign 2` over one byte writes one
        // zero. Each row is `(gap, zeros, nops)` read off `as` 2.46.
        for &(gap, zeros, nops) in &[
            (0usize, 0usize, 0usize),
            (1, 1, 0),
            (2, 2, 0),
            (3, 3, 0),
            (4, 0, 1),
            (7, 3, 1),
            (8, 0, 2),
            (12, 0, 3),
            (15, 3, 3),
            (30, 2, 7),
        ] {
            let mut out = alloc::vec::Vec::new();
            assert_eq!(push_a64_exec_align_fill(&mut out, gap), zeros, "gap {gap}");
            assert_eq!(out.len(), gap, "gap {gap} length");
            assert!(out[..zeros].iter().all(|&b| b == 0), "gap {gap} zeros");
            assert!(
                out[zeros..]
                    .chunks_exact(A64_NOP.len())
                    .all(|c| c == A64_NOP),
                "gap {gap} nops"
            );
            assert_eq!((out.len() - zeros) / A64_NOP.len(), nops, "gap {gap} count");
        }
    }

    #[test]
    fn insn_align_gap_follows_the_mapping_state() {
        // The padding before an instruction is a data-to-instruction
        // transition in an AArch64 code section. No other state pads, and
        // neither does a non-executable section or x86-64.
        for at in 0..8i64 {
            let want = (4 - at % 4) % 4;
            assert_eq!(insn_align_gap(at, Some(MapClass::Data), true, true), want);
            assert_eq!(insn_align_gap(at, Some(MapClass::Code), true, true), 0);
            assert_eq!(insn_align_gap(at, None, true, true), 0);
            assert_eq!(insn_align_gap(at, Some(MapClass::Data), false, true), 0);
            assert_eq!(insn_align_gap(at, Some(MapClass::Data), true, false), 0);
        }
    }

    #[test]
    fn an_alignment_of_one_leaves_the_mapping_state_alone() {
        // GNU as builds no frag for an alignment of one, so it neither
        // opens a run nor suppresses the padding before a later
        // instruction. A wider one leaves the section in the instruction
        // state where the section is executable.
        let item = |n: u32| AsmSectionItem::Align {
            spec: AlignSpec::Bytes(n),
            fill: None,
            max: None,
        };
        let (one, two) = (item(1), item(2));
        for exec in [false, true] {
            assert_eq!(
                step_map_state(&one, Some(MapClass::Data), exec),
                Some(MapClass::Data)
            );
            assert_eq!(step_map_state(&one, None, exec), None);
        }
        assert_eq!(
            step_map_state(&two, Some(MapClass::Data), true),
            Some(MapClass::Code)
        );
        assert_eq!(
            step_map_state(&two, Some(MapClass::Code), false),
            Some(MapClass::Data)
        );
    }

    /// GNU as 2.46 output for an x86-64 executable-section alignment gap
    /// of 1..=24 bytes: the fill after a data directive and the fill after
    /// an instruction, as `(gap, data_fill, insn_fill)`. Measured by
    /// assembling `.fill n, 1, 0xcc` / `n` one-byte NOPs followed by
    /// `.balign 64` and reading back the padding.
    const GAS_ALIGN_FILL: &[(usize, &[u8], &[u8])] = &[
        (1, &[0x90], &[0x90]),
        (2, &[0x90, 0x90], &[0x66, 0x90]),
        (3, &[0x90, 0x66, 0x90], &[0x0f, 0x1f, 0x00]),
        (4, &[0x90, 0x0f, 0x1f, 0x00], &[0x0f, 0x1f, 0x40, 0x00]),
        (
            5,
            &[0x90, 0x0f, 0x1f, 0x40, 0x00],
            &[0x0f, 0x1f, 0x44, 0x00, 0x00],
        ),
        (
            6,
            &[0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00],
            &[0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00],
        ),
        (
            7,
            &[0x90, 0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00],
            &[0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00],
        ),
        (
            8,
            &[0x90, 0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00],
            &[0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
        ),
        (
            9,
            &[0x90, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
            &[0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
        ),
        (
            10,
            &[0x90, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
            &[0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00],
        ),
        (
            11,
            &[
                0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
            &[
                0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
        ),
        (
            12,
            &[
                0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
            &[
                0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
        ),
        (
            13,
            &[
                0x90, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
            &[
                0x66, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
        ),
        (
            14,
            &[
                0x90, 0x66, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
            &[
                0x0f, 0x1f, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
        ),
        (
            15,
            &[
                0x90, 0x0f, 0x1f, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00,
                0x00,
            ],
            &[
                0x0f, 0x1f, 0x40, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00,
                0x00,
            ],
        ),
        (
            16,
            &[
                0x90, 0x0f, 0x1f, 0x40, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00,
                0x00, 0x00,
            ],
            &[
                0x0f, 0x1f, 0x44, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00,
                0x00, 0x00,
            ],
        ),
        (
            17,
            &[
                0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00,
                0x00, 0x00, 0x00,
            ],
            &[
                0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00,
                0x00, 0x00, 0x00,
            ],
        ),
        (
            18,
            &[
                0x90, 0x66, 0x0f, 0x1f, 0x44, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00,
                0x00, 0x00, 0x00, 0x00,
            ],
            &[
                0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00,
                0x00, 0x00, 0x00, 0x00,
            ],
        ),
        (
            22,
            &[
                0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e,
                0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
            &[
                0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x2e,
                0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
        ),
        (
            23,
            &[
                0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66,
                0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
            &[
                0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66,
                0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
        ),
        (
            24,
            &[
                0x90, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66,
                0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
            &[
                0x66, 0x90, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00, 0x66,
                0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
            ],
        ),
    ];

    #[test]
    fn x86_exec_align_fill_matches_gnu_as() {
        for &(gap, data_fill, insn_fill) in GAS_ALIGN_FILL {
            for (after_insn, want) in [(false, data_fill), (true, insn_fill)] {
                let mut got = alloc::vec::Vec::new();
                push_x86_exec_align_fill(&mut got, gap, after_insn);
                assert_eq!(
                    got, want,
                    "gap {gap}, after_insn {after_insn}: fill differs from GNU as"
                );
            }
        }
        // Past the table the tail is maximal NOPs, so a gap and the gap
        // eleven bytes larger differ by exactly one more of them.
        for gap in 1..=63usize {
            for after_insn in [false, true] {
                let mut small = alloc::vec::Vec::new();
                push_x86_exec_align_fill(&mut small, gap, after_insn);
                let mut large = alloc::vec::Vec::new();
                push_x86_exec_align_fill(&mut large, gap + X86_NOPS.len(), after_insn);
                assert_eq!(small.len(), gap);
                assert_eq!(large.len(), gap + X86_NOPS.len());
                assert_eq!(
                    &large[..gap],
                    &small[..],
                    "gap {gap}: prefix must be stable"
                );
                assert_eq!(&large[gap..], X86_NOPS[X86_NOPS.len() - 1]);
            }
        }
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
        // Three bare labels do not fit a single relocation; the form defers
        // to the location-value evaluator, which folds or rejects it once
        // the labels' spaces are known.
        assert_eq!(
            parse_section_value("a - b - c").unwrap(),
            AsmSectionValue::LocExpr(alloc::string::String::from("a - b - c"))
        );
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
        // Two relocation bases with an addend, and a positive location
        // counter, defer to the location-value evaluator.
        assert_eq!(
            parse_section_value("a - b + 4").unwrap(),
            AsmSectionValue::LocExpr(alloc::string::String::from("a - b + 4"))
        );
        assert_eq!(
            parse_section_value("sym + .").unwrap(),
            AsmSectionValue::LocExpr(alloc::string::String::from("sym + ."))
        );
    }

    #[test]
    fn shift_right_is_logical_like_gnu_as() {
        // GNU as shifts the 64-bit value, so `>>` never replicates the sign
        // bit. Verified against `as` (`.quad` of each expression): the kernel's
        // GENMASK reduces to 1, not -1, which is what makes it a valid AArch64
        // logical immediate.
        assert_eq!(eval_const_expr("~0 >> 63"), Some(1));
        assert_eq!(eval_const_expr("-8 >> 1"), Some(0x7fff_ffff_ffff_fffc));
        assert_eq!(eval_const_expr("1 << 63 >> 60"), Some(8));
        assert_eq!(
            eval_const_expr("(((~(0)) << (0)) & (~(0) >> (64 - 1 - (0))))"),
            Some(1)
        );
    }

    #[test]
    fn octa_and_cfi_match_gnu_as() {
        // GNU as reference (x86-64 `as`, section `.probe,"a"`). `.octa` takes a
        // 16-byte little-endian field: a literal too wide for 64 bits keeps its
        // full value, a narrower expression sign-extends. `.cfi_*` deposits no
        // bytes.
        let text = ".pushsection .probe,\"a\"\n\
                    .cfi_sections .debug_frame\n\
                    .octa 0x000102030405060708090a0b0c0d0e0f\n\
                    .cfi_startproc\n\
                    .octa 1+2\n\
                    .octa -1\n\
                    .octa 0x5BE0CD191F83D9AB9B05688C510E527F, 0xA54FF53A3C6EF372BB67AE856A09E667\n\
                    .cfi_endproc\n\
                    .popsection\n";
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        let mut want = alloc::vec::Vec::new();
        want.extend_from_slice(&(0x000102030405060708090a0b0c0d0e0fu128).to_le_bytes());
        want.extend_from_slice(&3u128.to_le_bytes());
        want.extend_from_slice(&(-1i128).to_le_bytes());
        want.extend_from_slice(&(0x5BE0CD191F83D9AB9B05688C510E527Fu128).to_le_bytes());
        want.extend_from_slice(&(0xA54FF53A3C6EF372BB67AE856A09E667u128).to_le_bytes());
        assert_eq!(sink[0].bytes, want);
    }

    #[test]
    fn location_valued_expressions_match_gnu_as() {
        // GNU as reference (x86-64 `as`, one section `.probe,"a"`):
        //   a: .long 8
        //   b: .long b - a          -> 4 (constant)
        //   .long a - b             -> -4
        //   .quad a                 -> ABS64 reloc
        //   .long a - .             -> constant (both in .probe): 0 - 0x14
        //   .long ext - .           -> PC32 ext + 0
        //   .quad ext + 8           -> ABS64 ext + 8
        //   .long (b - a) / 4       -> 1
        //   .quad .                 -> ABS64 .probe + 0x28
        let text = ".pushsection .probe,\"a\"\n\
                    a:\n.long 8\n\
                    b:\n.long b - a\n\
                    .long a - b\n\
                    .quad a\n\
                    .long a - .\n\
                    .long ext - .\n\
                    .quad ext + 8\n\
                    .long (b - a) / 4\n\
                    .quad .\n\
                    .popsection\n";
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        let mut want = alloc::vec::Vec::new();
        want.extend_from_slice(&8i32.to_le_bytes());
        want.extend_from_slice(&4i32.to_le_bytes());
        want.extend_from_slice(&(-4i32).to_le_bytes());
        want.extend_from_slice(&[0u8; 8]); // .quad a (reloc)
        want.extend_from_slice(&(-0x14i32).to_le_bytes());
        want.extend_from_slice(&[0u8; 4]); // .long ext - . (reloc)
        want.extend_from_slice(&[0u8; 8]); // .quad ext + 8 (reloc)
        want.extend_from_slice(&1i32.to_le_bytes());
        want.extend_from_slice(&[0u8; 8]); // .quad . (reloc)
        assert_eq!(sink[0].bytes, want);
        assert_eq!(
            sink[0].relocs,
            alloc::vec![
                AsmSectionReloc {
                    offset: 0x0c,
                    width: 8,
                    kind: AsmRelocKind::Data,
                    pcrel: false,
                    branch: false,
                    signed: false,
                    target: AsmSectionTarget::Symbol(alloc::string::String::from("a")),
                    addend: 0,
                },
                AsmSectionReloc {
                    offset: 0x18,
                    width: 4,
                    kind: AsmRelocKind::Data,
                    pcrel: true,
                    branch: false,
                    signed: false,
                    target: AsmSectionTarget::Symbol(alloc::string::String::from("ext")),
                    addend: 0,
                },
                AsmSectionReloc {
                    offset: 0x1c,
                    width: 8,
                    kind: AsmRelocKind::Data,
                    pcrel: false,
                    branch: false,
                    signed: false,
                    target: AsmSectionTarget::Symbol(alloc::string::String::from("ext")),
                    addend: 8,
                },
                AsmSectionReloc {
                    offset: 0x28,
                    width: 8,
                    kind: AsmRelocKind::Data,
                    pcrel: false,
                    branch: false,
                    signed: false,
                    target: AsmSectionTarget::OwnSection(0x28),
                    addend: 0,
                },
            ],
        );
    }

    #[test]
    fn location_expression_cross_statement_size() {
        // `.size f, . - f` in a later template resolves against a label an
        // earlier statement placed in the same sink section, at merged
        // offsets. The second call's `.balign` also pads from the merged
        // length, keeping measurement and materialization in agreement.
        let t1 = ".pushsection .t,\"ax\"\nf:\n.byte 1, 2, 3\n.popsection\n";
        let t2 = ".pushsection .t,\"ax\"\n.balign 4\ng:\n.byte 9\n.size f, g - f\n.popsection\n";
        let mut sink = AsmSectionSink::default();
        for t in [t1, t2] {
            let AsmExtract { blocks, .. } = extract_asm_sections(t, false).unwrap().unwrap();
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
        }
        assert_eq!(sink[0].bytes.len(), 5); // 3 bytes, 1 pad, 1 byte
        let f = sink[0].labels.iter().find(|l| l.name == "f").unwrap();
        assert_eq!(f.size, Some(4));
    }

    #[test]
    fn string_directive_operand_lists() {
        // `.ascii` / `.asciz` / `.string` take a comma-separated operand
        // list; adjacent literals in one operand concatenate; `.asciz` /
        // `.string` terminate each operand, `.ascii` terminates none.
        let bytes = |tok: &str, rest: &str| match parse_string_directive(tok, rest).unwrap() {
            AsmSectionItem::Bytes(b) => b,
            other => panic!("expected Bytes, got {other:?}"),
        };
        assert_eq!(bytes(".ascii", "\"A\""), b"A");
        assert_eq!(bytes(".asciz", "\"B\""), b"B\0");
        assert_eq!(bytes(".ascii", "\"C\", \"D\""), b"CD");
        assert_eq!(bytes(".asciz", "\"E\", \"F\""), b"E\0F\0");
        assert_eq!(bytes(".ascii", "\"G\" \"H\""), b"GH");
        assert_eq!(bytes(".string", "\"I\", \"J\""), b"I\0J\0");
        // The metadata-section shape: an empty literal adjacent to an
        // escaped NUL is one empty operand plus the NUL byte.
        assert_eq!(bytes(".ascii", "\"\" \"\\0\""), b"\0");
        // Assembler escapes: octal and hex runs, and pass-through for the
        // quoted quote and backslash.
        assert_eq!(bytes(".ascii", "\"\\101\\x42\\n\\\\\""), b"AB\n\\");
        assert!(parse_string_directive(".ascii", "\"a\" junk").is_err());
        assert!(parse_string_directive(".ascii", "\"a\", ").is_err());
        assert!(parse_string_directive(".ascii", "\"open").is_err());
    }

    #[test]
    fn section_value_quoted_symbol_name() {
        // A double-quoted symbol name is the symbol, quotes stripped, and
        // composes with an addend and the `- .` PC-relative marker.
        assert_eq!(
            parse_section_value("\"__SCK__call\"").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("__SCK__call"),
                pcrel: false,
                addend: alloc::string::String::new(),
            }
        );
        assert_eq!(
            parse_section_value("\"sym\" + 8").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("sym"),
                pcrel: false,
                addend: alloc::string::String::from("0 + 8"),
            }
        );
        // The quoted run is opaque: the name may carry expression characters.
        assert_eq!(
            parse_section_value("\"a-b\" - .").unwrap(),
            AsmSectionValue::Ref {
                name: alloc::string::String::from("a-b"),
                pcrel: true,
                addend: alloc::string::String::new(),
            }
        );
        // An unterminated quote is not a value.
        assert!(parse_section_value("\"sym").is_err());
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        let mut sink2 = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
                kind: AsmRelocKind::Data,
                pcrel: true,
                branch: false,
                signed: false,
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
            let AsmExtract { blocks, .. } =
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
        let AsmExtract { blocks, .. } =
            extract_asm_sections(".pushsection .x,\"a\"\n.word 1b - .\n.popsection\n", true)
                .unwrap()
                .unwrap();
        let mut sink = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let m = measure_asm_section_offsets(&blocks, &|_| None, false, &AsmSectionSink::default())
            .unwrap();
        assert_eq!(m.offset("774f"), Some(0));
        assert_eq!(m.offset("775f"), Some(3));
        assert_eq!(m.section("774f"), m.section("775f"), "same section");
    }

    #[test]
    fn section_label_difference_overflow_rejected() {
        // A distance outside the field width is rejected, not truncated.
        let text = "1: nop\n2: nop\n.pushsection .x,\"a\"\n.byte 2b - 1b\n.popsection\n";
        let AsmExtract {
            code: _c, blocks, ..
        } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(exec, false).unwrap().unwrap();
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
        // GNU as assembles instructions into any section; the flags set the
        // object section's attributes, not whether code is admitted. An
        // instruction in a section flagged `"a"` (not executable) is likewise
        // kept as a `Code` item for the backend to encode.
        let data = "771: nop\n.pushsection .data.tramp,\"a\"\n\
                    774: wrmsr\n775:\n.popsection\n";
        let AsmExtract { blocks, .. } = extract_asm_sections(data, false).unwrap().unwrap();
        let sec = blocks.iter().find(|b| b.name == ".data.tramp").unwrap();
        assert!(
            sec.items
                .iter()
                .any(|it| matches!(it, AsmSectionItem::Code(t) if t == "wrmsr")),
            "instruction in a non-executable section is kept as Code: {:?}",
            sec.items
        );
    }

    #[test]
    fn label_without_whitespace_peels_from_following_instruction() {
        // GNU as terminates a label at the colon and requires no whitespace
        // before the statement that follows, so `name:insn` in a named section
        // is a label plus an instruction. Both must reach the block as separate
        // items -- a `Label` and a single-instruction `Code` -- not one glued
        // `Code("name:insn")` the arch encoder then rejects.
        let src = ".pushsection .spinlock.text,\"ax\"\n\
                   wrapper:push %rcx\n\
                   pop %rcx\n\
                   .popsection\n";
        let AsmExtract { blocks, .. } = extract_asm_sections(src, false).unwrap().unwrap();
        let sec = blocks.iter().find(|b| b.name == ".spinlock.text").unwrap();
        assert!(
            sec.items
                .iter()
                .any(|it| matches!(it, AsmSectionItem::Label(n) if n == "wrapper")),
            "label peeled as its own item: {:?}",
            sec.items
        );
        assert!(
            sec.items
                .iter()
                .any(|it| matches!(it, AsmSectionItem::Code(t) if t == "push %rcx")),
            "the instruction after the label is a single-instruction Code item: {:?}",
            sec.items
        );
        assert!(
            !sec.items
                .iter()
                .any(|it| matches!(it, AsmSectionItem::Code(t) if t.contains(':'))),
            "no Code item retains the label colon: {:?}",
            sec.items
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
        let AsmExtract { code, blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        assert_eq!(code, "nop\nnop\n");
        let mut sink = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        // `.align`'s operand is an exponent on AArch64 and a byte count on
        // x86, so `.align 3` is 8 bytes on the one and rejected as a
        // non-power-of-two count on the other, and `.align 8` the reverse.
        let sec_align = |spec: &str, aarch64: bool| -> Result<u32, alloc::string::String> {
            let text = alloc::format!(".pushsection .t,\"a\"\n.align {spec}\n.byte 1\n.popsection");
            let AsmExtract { blocks, .. } =
                extract_asm_sections(&text, aarch64)?.expect("section directives");
            let mut sink = AsmSectionSink::default();
            materialize_asm_sections(
                &blocks,
                &|_| None,
                &|_| None,
                &|_| None,
                &|_| None,
                aarch64,
                &mut sink,
            )?;
            Ok(sink[0].align)
        };
        assert_eq!(sec_align("3", true).unwrap(), 8);
        assert!(sec_align("3", false).is_err());
        assert_eq!(sec_align("8", false).unwrap(), 8);
        assert_eq!(sec_align("8", true).unwrap(), 256);
    }

    #[test]
    fn section_labels_become_offsets() {
        // A label records its offset in the section; `.globl` sets external
        // binding whether it precedes or follows the definition, and a
        // quoted section name is unquoted.
        let text = ".section \".export\",\"a\"\n                    first:\n                    .asciz \"GPL\"\n                    .balign 8\n                    .globl second\n                    second: .quad 0\n                    .globl nowhere\n                    .previous\n";
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        assert_eq!(blocks[0].name, ".export");
        let mut sink = AsmSectionSink::default();
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
                    weak: false,
                    sym_type: AsmSymType::NoType,
                    size: None,
                    absolute: None,
                },
                AsmSectionLabel {
                    name: alloc::string::String::from("second"),
                    offset: 8,
                    global: true,
                    weak: false,
                    sym_type: AsmSymType::NoType,
                    size: None,
                    absolute: None,
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
            let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
            let mut sink = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        let mut sink = AsmSectionSink::default();
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
        let AsmExtract { blocks, .. } = extract_asm_sections(text, false).unwrap().unwrap();
        assert_eq!(blocks[0].name, ".initcall7.init");
        assert_eq!(blocks[0].flags, "a");
        let mut sink = AsmSectionSink::default();
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
        assert_eq!(
            out.trim(),
            alloc::format!("{INST_BYTES_DIRECTIVE} 0x01, 0x00, 0x38, 0xd5"),
            "{out}"
        );
    }

    /// A comma with no argument before it supplies an empty one, so the
    /// arguments after it keep their positions; a parameter supplied empty
    /// still takes its `=default`. Both are what GNU as binds -- the kernel's
    /// SIMD macro layers pass empty arguments through several levels
    /// (`__pmull_p8_tail \rq, ..., 8b,, sh1, ...`).
    #[test]
    fn gas_macro_empty_arguments_bind_like_gnu_as() {
        let expand = |invocation: &str, params: &str| {
            let text = alloc::format!(
                ".macro m {params}\n.ascii \"[\\a][\\b][\\c]\"\n.endm\n{invocation}\n"
            );
            expand_asm_gas_macros(&text, 4, &|_| None)
                .unwrap()
                .unwrap()
                .trim()
                .to_string()
        };
        for (invocation, want) in [
            ("m 1,,3", "[1][][3]"),
            ("m 1, , 3", "[1][][3]"),
            ("m 1 2 3", "[1][2][3]"),
            ("m 1,2,", "[1][2][]"),
            ("m ,2,3", "[][2][3]"),
        ] {
            assert_eq!(
                expand(invocation, "a, b, c"),
                alloc::format!(".ascii \"{want}\""),
                "{invocation}"
            );
        }
        for (invocation, want) in [
            ("m 1,,3", "[1][5][3]"),
            ("m 1", "[1][5][]"),
            ("m 1,,", "[1][5][]"),
        ] {
            assert_eq!(
                expand(invocation, "a, b=5, c"),
                alloc::format!(".ascii \"{want}\""),
                "{invocation}"
            );
        }
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
        assert_eq!(
            block("(3 << 19)", "x1"),
            alloc::format!("{INST_BYTES_DIRECTIVE} 0x01, 0x00, 0x38, 0xd5")
        );
        assert_eq!(
            block("((3 << 19) | (4 << 8))", "x0"),
            alloc::format!("{INST_BYTES_DIRECTIVE} 0x00, 0x04, 0x38, 0xd5")
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

    /// Every `_ASM_EXTABLE_*` carries its own copy of the `.L__gpr_num_*`
    /// table, so two of them in one template assign each name twice with a
    /// read in between. Both reads fold against the assignment in effect, so
    /// neither assignment may survive as a directive: what is left of a
    /// function-body template is an instruction stream, and no backend
    /// encodes `.set` as an instruction.
    #[test]
    fn gas_macro_repeated_extable_leaves_no_assignment_in_the_stream() {
        let block = concat!(
            "\t.irp\tnum,0,1,2\n",
            "\t.equ\t.L__gpr_num_w\\num, \\num\n",
            "\t.endr\n",
            "\t.equ\t.L__gpr_num_wzr, 31\n",
            "\t.pushsection __ex_table, \"a\"\n",
            "\t.short (((.L__gpr_num_%w0) << 0) | ((.L__gpr_num_wzr) << 5))\n",
            "\t.popsection\n",
        );
        let subst = |t: &str| (t == "%w0").then(|| alloc::string::String::from("w2"));
        let out = expand_asm_gas_macros(&alloc::format!("{block}{block}"), 4, &subst)
            .unwrap()
            .unwrap();
        assert_eq!(
            out.matches(".short (((2) << 0) | ((31) << 5))").count(),
            2,
            "{out}"
        );
        assert!(!out.contains(".set"), "{out}");
        assert!(!out.contains(".equ"), "{out}");
    }

    /// A read with no assignment before it has nothing to fold against, so
    /// the assignment stays for the section parse to define the name:
    /// `arch/x86/boot/header.S` reads `textsize` in its PE header and
    /// assigns it further down.
    #[test]
    fn gas_macro_keeps_an_assignment_an_earlier_statement_read() {
        let text = concat!(
            "\t.pushsection .pehdr, \"a\"\n",
            "\t.long textsize\n",
            "\t.popsection\n",
            "\t.set textsize, 0x1234\n",
        );
        let out = expand_asm_gas_macros(text, 4, &|_| None).unwrap().unwrap();
        assert!(out.contains(".long textsize"), "{out}");
        assert!(out.contains(".set textsize, 4660"), "{out}");
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
    fn gas_macro_spaced_qualifiers_bind_like_gnu_as() {
        // GNU as scans a formal's `=` / `:` separator as its own token, so
        // whitespace may border either. Verified against `as`: `m1 x5` binds
        // `a`, `m2` takes the default x7 and `m2 x9` overrides it.
        let none = |_: &str| None;
        let text = ".macro m1, a : req\nadd x0, x0, \\a\n.endm\n\
                    .macro m2, b = x7\nadd x1, x1, \\b\n.endm\n\
                    m1 x5\nm2\nm2 x9\n";
        let out = expand_asm_gas_macros(text, 4, &none).unwrap().unwrap();
        let body: alloc::vec::Vec<&str> = out
            .lines()
            .map(str::trim)
            .filter(|l| !l.is_empty())
            .collect();
        assert_eq!(body, ["add x0, x0, x5", "add x1, x1, x7", "add x1, x1, x9"]);
        // A default is only bound when the invocation omits the argument, so a
        // spaced default never leaks into a supplied one.
        let text = ".macro m3, p = 64\n.if \\p == 32\nnop\n.else\nret\n.endif\n.endm\nm3\nm3 32\n";
        let out = expand_asm_gas_macros(text, 4, &none).unwrap().unwrap();
        assert!(out.contains("ret") && out.contains("nop"), "{out}");
    }

    /// `.ifdef` answers against the names defined so far, so the guard that
    /// keeps one datum per variable across macro expansions sees the label
    /// the first expansion placed. Measured against `as`: only the first
    /// expansion emits the body, a definition further down the stream does
    /// not count, and a declaration or a dead branch defines nothing.
    #[test]
    fn gas_ifdef_sees_definitions_like_gnu_as() {
        let none = |_: &str| None;
        let body = |text: &str| -> alloc::vec::Vec<alloc::string::String> {
            expand_asm_gas_macros(text, 4, &none)
                .unwrap()
                .unwrap()
                .lines()
                .map(|l| alloc::string::String::from(l.trim()))
                .filter(|l| !l.is_empty())
                .collect()
        };
        let text = ".macro rv var\n\
                    .ifndef .L__d_\\var\n\
                    .L__d_\\var:\n\
                    .quad 0\n\
                    .endif\n\
                    .endm\n\
                    rv a\nrv a\nrv b\n";
        assert_eq!(
            body(text),
            [".L__d_a:", ".quad 0", ".L__d_b:", ".quad 0"],
            "the guarded body assembles once per variable"
        );
        // A label, an assignment and a common block define; a `.globl`
        // declaration, a reference, a later definition and one in a dead
        // branch do not.
        for (t, want) in [
            ("foo:\n.ifdef foo\nnop\n.endif\n", true),
            (".set foo, 7\n.ifdef foo\nnop\n.endif\n", true),
            (".comm foo,4,4\n.ifdef foo\nnop\n.endif\n", true),
            (".globl foo\n.ifdef foo\nnop\n.endif\n", false),
            (".quad foo\n.ifdef foo\nnop\n.endif\n", false),
            (".ifdef foo\nnop\n.endif\nfoo:\n", false),
            (".if 0\nfoo:\n.endif\n.ifdef foo\nnop\n.endif\n", false),
        ] {
            assert_eq!(
                body(t).contains(&alloc::string::String::from("nop")),
                want,
                "{t}"
            );
        }
    }

    #[test]
    fn altmacro_percent_arguments_evaluate_like_gnu_as() {
        // Under `.altmacro` a `%`-led argument is evaluated at the invocation
        // and bound as its decimal value. The kernel's SVE register loop drives
        // a recursive macro this way; assembled with `as`, the body below emits
        // `add x0, x0, #0` through `#7` in order.
        let none = |_: &str| None;
        let text = ".macro __for from:req, to:req\n\
                    .if (\\from) == (\\to)\n\
                    _for__body %\\from\n\
                    .else\n\
                    __for %\\from, %((\\from) + ((\\to) - (\\from)) / 2)\n\
                    __for %((\\from) + ((\\to) - (\\from)) / 2 + 1), %\\to\n\
                    .endif\n\
                    .endm\n\
                    .macro _for var:req, from:req, to:req, insn:vararg\n\
                    .macro _for__body \\var:req\n\
                    .noaltmacro\n\
                    \\insn\n\
                    .altmacro\n\
                    .endm\n\
                    .altmacro\n\
                    __for \\from, \\to\n\
                    .noaltmacro\n\
                    .purgem _for__body\n\
                    .endm\n\
                    _for n, 0, 7, add x0, x0, #\\n\n";
        let out = expand_asm_gas_macros(text, 4, &none).unwrap().unwrap();
        let body: alloc::vec::Vec<&str> = out
            .lines()
            .map(str::trim)
            .filter(|l| !l.is_empty())
            .collect();
        assert_eq!(
            body,
            (0..8)
                .map(|n| alloc::format!("add x0, x0, #{n}"))
                .collect::<alloc::vec::Vec<_>>()
        );
        // Without `.altmacro` the `%` is not an evaluation marker.
        let text = ".macro m a\n.byte \\a\n.endm\nm %1+2\n";
        let out = expand_asm_gas_macros(text, 4, &none).unwrap().unwrap();
        assert!(out.contains("%1+2"), "{out}");
    }

    /// `name = expr` is the GNU as spelling of `.set`, so a unit that uses no
    /// other directive still resolves its symbols. A value naming a register
    /// is a register equate -- the binding `.req` makes -- and defines no
    /// symbol; every later use of the name substitutes the register. `$name`
    /// splits at the AT&T immediate sigil, while a `$` inside a name does not.
    #[test]
    fn gas_assignments_bind_constants_and_registers() {
        let expand = |text: &str| {
            expand_asm_gas_macros(text, 4, &|_| None)
                .unwrap()
                .expect("an assignment triggers the pass")
                .trim()
                .to_string()
        };
        assert_eq!(
            expand("_A = 8\n_B = _A + 8\nK = _B + 16\nsubq $K, %rsp\n"),
            "subq $32, %rsp"
        );
        assert_eq!(
            expand("IN_KEY = %rdx\nmovdqu 16(IN_KEY), %xmm1\n"),
            "movdqu 16(%rdx), %xmm1"
        );
        assert_eq!(expand("A = %rdx\nB = A\nmov (%r9), B\n"), "mov (%r9), %rdx");
        assert_eq!(
            expand(".set copy0, %xmm5\nmovdqa copy0, %xmm1\n"),
            "movdqa %xmm5, %xmm1"
        );
        // A `$` inside a name belongs to it; `x$y` is one token.
        assert_eq!(expand("x$y = 5\nmovl $x$y, %eax\n"), "movl $5, %eax");
        // An assignment naming a symbol is not an equate: it reaches the
        // section parser, which emits the object-level alias.
        assert_eq!(expand("alias = target\nnop\n"), ".set alias, target\nnop");
        // A comparison is not an assignment, so it triggers nothing.
        assert!(
            expand_asm_gas_macros("cmpl $1, %eax\nsete %al\n", 4, &|_| None)
                .unwrap()
                .is_none()
        );
    }

    fn rept(text: &str) -> Result<alloc::string::String, alloc::string::String> {
        Ok(expand_asm_gas_macros(text, 4, &|_| None)?.expect("`.rept` triggers the pass"))
    }

    /// GNU as spells the repeat directive `.rept` or `.rep`, and iterates the
    /// characters of an operand with `.irpc`. Bytes measured with GNU as
    /// 2.46.1: `.rep 3 / .byte 0xaa / .endr` deposits `aa aa aa`;
    /// `.irpc l, 0123 / .byte \l / .endr` deposits `00 01 02 03`; an empty
    /// `.irpc` operand still expands the body once.
    #[test]
    fn rep_and_irpc_match_gnu_as() {
        assert_eq!(
            rept(".rep 3\n.byte 0xaa\n.endr\n")
                .unwrap()
                .matches(".byte 0xaa")
                .count(),
            3
        );
        let out = rept(".irpc l, 0123\n.byte \\l\n.endr\n").unwrap();
        assert_eq!(out, ".byte 0\n.byte 1\n.byte 2\n.byte 3\n", "{out}");
        let out = rept(".irpc c, ab\n.ascii \"[\\c]\"\n.endr\n").unwrap();
        assert_eq!(out, ".ascii \"[a]\"\n.ascii \"[b]\"\n", "{out}");
        assert_eq!(
            rept(".irpc n,\n.byte 0xff\n.endr\n").unwrap(),
            ".byte 0xff\n"
        );
        // The dead branch of a conditional consumes both spellings' bodies,
        // so neither `.endr` leaks.
        assert_eq!(
            rept(".if 0\n.rep 2\nnop\n.endr\n.endif\nret\n").unwrap(),
            "ret\n"
        );
        assert_eq!(
            rept(".if 0\n.irpc l,ab\nnop\n.endr\n.endif\nret\n").unwrap(),
            "ret\n"
        );
    }

    /// GNU as separates a macro invocation's arguments by commas or by
    /// whitespace, and `%` is not one of the operators that keeps whitespace
    /// from separating: measured, `m 1 % 2` binds three arguments and
    /// `m %r8 %r9` binds two, while `m sym + 24` stays one.
    #[test]
    fn macro_arguments_split_on_whitespace_like_gnu_as() {
        let show = ".macro SHOW a b c\n.ascii \"[\\a][\\b][\\c]\"\n.endm\n";
        let go = |call: &str| rept(&alloc::format!("{show}{call}\n")).unwrap();
        assert_eq!(go("SHOW %r8 %r9"), ".ascii \"[%r8][%r9][]\"\n");
        assert_eq!(go("SHOW 1 % 2"), ".ascii \"[1][%][2]\"\n");
        assert_eq!(go("SHOW p q, r"), ".ascii \"[p][q][r]\"\n");
        assert_eq!(go("SHOW sym + 24"), ".ascii \"[sym + 24][][]\"\n");
        // A character constant is one argument, separators included, and
        // binds as its value: `SHOW 'r', ' ', ':'` measures `[114][32][58]`.
        assert_eq!(go("SHOW 'r', ' ', ':'"), ".ascii \"[114][32][58]\"\n");
    }

    /// A `.set` folds into the expander's symbol table, which substitutes it
    /// into what follows. A statement that referenced the name earlier is
    /// already past, so the assignment stays in the stream for the section
    /// layer to define -- `arch/x86/boot/header.S` reads `textsize` in its PE
    /// header and assigns it further down.
    #[test]
    fn a_set_referenced_before_its_assignment_stays_in_the_stream() {
        let out = rept(".long textsize\n.set textsize, 0x1234\n.long textsize\n").unwrap();
        assert_eq!(
            out, ".long textsize\n.set textsize, 4660\n.long 4660\n",
            "{out}"
        );
        // One referenced only after its assignment still folds away.
        assert_eq!(
            rept(".set only_after, 7\n.long only_after\n").unwrap(),
            ".long 7\n"
        );
    }

    /// A macro body is re-scanned after substitution, so a `;` that arrives
    /// through an argument separates statements -- the x86 ALTERNATIVE macros
    /// pass a whole instruction sequence as one argument, and the macros it
    /// names have to be recognized inside it. GNU as also ends a macro name
    /// at the first character that cannot be part of one, so the C-macro
    /// invocation spelling works.
    #[test]
    fn macro_expansion_rescans_substituted_statements() {
        let defs = ".macro INNER t\n.byte \\t\n.endm\n.macro OUTER body\n\\body\n.endm\n";
        assert_eq!(
            rept(&alloc::format!("{defs}OUTER \"nop; INNER t=2; ret\"\n")).unwrap(),
            "nop\n.byte 2\nret\n"
        );
        assert_eq!(
            rept(&alloc::format!("{defs}INNER(7)\n")).unwrap(),
            ".byte (7)\n"
        );
    }

    #[test]
    fn rept_expands_repeats_and_rejects_malformed() {
        // No `.rept` and no other macro directive: not this pass's business.
        assert!(
            expand_asm_gas_macros("nop\nret\n", 4, &|_| None)
                .unwrap()
                .is_none()
        );
        // `.rept 3` repeats the body three times (the ALTERNATIVE nop
        // padding); `.rept 0` drops it; nested counts multiply.
        let out = rept("swpb w0, w1, [x2]\n.rept 3\nnop\n.endr\n").unwrap();
        assert_eq!(out.matches("nop").count(), 3, "{out}");
        assert!(out.contains("swpb"));
        assert_eq!(
            rept(".rept 0\nnop\n.endr\n")
                .unwrap()
                .matches("nop")
                .count(),
            0
        );
        assert_eq!(
            rept(".rept 2\n.rept 3\nnop\n.endr\n.endr\n")
                .unwrap()
                .matches("nop")
                .count(),
            6
        );
        // A count over labels defers to the section layer, which knows the
        // offsets; the body expands once inside the kept `.rept`.
        assert_eq!(
            rept(".rept 2b-1b\nnop\n.endr\n").unwrap(),
            ".rept 2b-1b\nnop\n.endr\n"
        );
        // A stray `.endr` and an unclosed `.rept` are errors rather than a
        // mis-counted expansion.
        assert!(
            rept("nop\n.rept 2\nnop\n.endr\n.endr\n")
                .unwrap_err()
                .contains(".endr")
        );
        assert!(rept(".rept 2\nnop\n").unwrap_err().contains(".endr"));
    }

    #[test]
    fn rept_nests_with_macros_and_irp() {
        // A `.rept` in a macro body expands on invocation, with the count
        // bound from the macro argument.
        let out = rept(".macro nops, num\n.rept \\num\nnop\n.endr\n.endm\nnops 3\n").unwrap();
        assert_eq!(out.matches("nop").count(), 3, "{out}");
        // `.endr` closes the whole repeat family, so the two spellings nest
        // through each other.
        let out = rept(".irp r,1,2\n.rept 2\nnop\n.endr\n.endr\n").unwrap();
        assert_eq!(out.matches("nop").count(), 4, "{out}");
        let out = rept(".rept 2\n.irp r,1,2,3\nnop\n.endr\n.endr\n").unwrap();
        assert_eq!(out.matches("nop").count(), 6, "{out}");
        // The count is an expression over the `.set` table, as in GNU as.
        let out = rept(".set n, 2\n.rept n + 1\nnop\n.endr\n").unwrap();
        assert_eq!(out.matches("nop").count(), 3, "{out}");
        // A `.rept` in a dead conditional branch consumes its body.
        let out = rept(".if 0\n.rept 2\nnop\n.endr\n.endif\nret\n").unwrap();
        assert_eq!(out.matches("nop").count(), 0, "{out}");
        assert!(out.contains("ret"));
    }

    #[test]
    fn type_directive_accepts_the_gas_spellings() {
        let ty = |rest: &str| parse_type_directive(rest);
        for rest in [
            "f,STT_FUNC",
            "f, STT_FUNC",
            "f STT_FUNC",
            "f @function",
            "f %function",
            "f #function",
            "f function",
            "f \"function\"",
        ] {
            assert_eq!(
                ty(rest).unwrap(),
                AsmSectionItem::Type {
                    name: alloc::string::String::from("f"),
                    sym_type: AsmSymType::Func,
                },
                "{rest}"
            );
        }
        assert!(matches!(
            ty("f STT_OBJECT").unwrap(),
            AsmSectionItem::Type {
                sym_type: AsmSymType::Object,
                ..
            }
        ));
        assert!(matches!(
            ty("f, @notype").unwrap(),
            AsmSectionItem::Type {
                sym_type: AsmSymType::NoType,
                ..
            }
        ));
        assert!(ty("f STT_TLS").unwrap_err().contains("unsupported"));
        assert!(ty("f").unwrap_err().contains("expects"));
    }

    /// The export-table shape modpost generates: two file-scope templates
    /// per exported symbol, one pushing a section every symbol shares and
    /// one pushing a section named after the symbol. A unit carries tens of
    /// thousands of these, so the per-call lookups against the accumulated
    /// sink -- the section identity and the labels earlier templates
    /// defined -- have to be indexed; scanning it made the unit quadratic
    /// in its own asm statements. At this count a scan does not finish in
    /// the time the whole suite takes.
    #[test]
    fn file_scope_asm_sink_lookups_are_indexed() {
        const N: usize = 4000;
        let templates: alloc::vec::Vec<alloc::string::String> = (0..N)
            .map(|i| {
                alloc::format!(
                    "\t.section \"__ksymtab_strings\",\"aMS\",%progbits,1\n\
                     __kstrtab_s{i}:\n\t.asciz \"s{i}\"\n\t.previous\n\
                     \t.section \"___ksymtab+s{i}\", \"a\"\n\t.balign 4\n\
                     __ksymtab_s{i}:\n\t.long s{i}- .\n\t.long __kstrtab_s{i}- .\n\
                     \t.previous\n"
                )
            })
            .collect();
        let mut sink = AsmSectionSink::default();
        materialize_file_asm(&templates, true, AsmComments::A64, &|_| Ok(()), &mut sink).unwrap();
        // One shared strings section plus one per symbol.
        assert_eq!(sink.len(), N + 1);
        let strs = sink
            .iter()
            .find(|s| s.name == "__ksymtab_strings")
            .expect("the shared strings section");
        assert_eq!(strs.labels.len(), N);
        // Each name is `s`, the index digits, and the `.asciz` terminator.
        assert_eq!(
            strs.bytes.len(),
            (0..N).map(|i| i.to_string().len() + 2).sum::<usize>()
        );
        // Each per-symbol section holds the two relative references, both
        // as relocations against the named symbol.
        let sec = sink
            .iter()
            .find(|s| s.name == "___ksymtab+s3999")
            .expect("the last symbol's section");
        assert_eq!(sec.bytes.len(), 8);
        assert_eq!(sec.labels.len(), 1);
        assert_eq!(sec.relocs.len(), 2);
    }

    /// A location expression resolves a label an earlier template defined,
    /// and a snapshot restore drops the sections and the labels it created
    /// so a later template does not resolve against undone work.
    #[test]
    fn sink_labels_span_templates_and_unwind() {
        let mat = |text: &str, sink: &mut AsmSectionSink| {
            materialize_file_asm(
                &[alloc::string::String::from(text)],
                true,
                AsmComments::A64,
                &|_| Ok(()),
                sink,
            )
        };
        let mut sink = AsmSectionSink::default();
        mat(
            "\t.section \"t\",\"a\"\nfirst:\n\t.long 0\n\t.long 0\n\t.previous\n",
            &mut sink,
        )
        .unwrap();
        // A difference to `first`, defined by the template above, folds:
        // the sink supplies its section and offset.
        mat(
            "\t.section \"t\",\"a\"\nsecond:\n\t.long 0\n\t.size second, second - first\n\t.previous\n",
            &mut sink,
        )
        .unwrap();
        let sized = |s: &AsmSectionSink, n: &str| {
            s.iter()
                .flat_map(|x| &x.labels)
                .find(|l| l.name == n)
                .and_then(|l| l.size)
        };
        assert_eq!(sized(&sink, "second"), Some(8));
        let snap = sink.snapshot();
        mat(
            "\t.section \"v\",\"a\"\nlater:\n\t.long 0\n\t.previous\n",
            &mut sink,
        )
        .unwrap();
        assert_eq!(sink.len(), 2);
        sink.restore(&snap);
        assert_eq!(sink.len(), 1);
        // `later` went with the section the restore dropped, so a difference
        // to it no longer folds. A rejected template leaves its bytes behind
        // for the caller to unwind, so take a snapshot over it.
        let before_err = sink.snapshot();
        assert!(
            mat(
                "\t.section \"t\",\"a\"\nthird:\n\t.long 0\n\t.size third, third - later\n\t.previous\n",
                &mut sink,
            )
            .is_err()
        );
        sink.restore(&before_err);
        // `first` survived the restore and still resolves.
        mat(
            "\t.section \"t\",\"a\"\nfourth:\n\t.long 0\n\t.size fourth, fourth - first\n\t.previous\n",
            &mut sink,
        )
        .unwrap();
        assert_eq!(sized(&sink, "fourth"), Some(12));
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
        // C-style integer suffixes, as GNU as accepts (`mov $(1U << 8)`);
        // a numeric label reference (`1b` / `2f`) stays a non-constant.
        assert_eq!(eval_const_expr("(1U << 8)"), Some(256));
        assert_eq!(eval_const_expr("2UL"), Some(2));
        assert_eq!(eval_const_expr("3ull + 1"), Some(4));
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
