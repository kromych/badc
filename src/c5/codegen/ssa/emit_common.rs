//! Cross-target helpers for the SSA emit backends. Holds the
//! pieces of the per-arch lowering that are pure math or pure
//! formatting -- the shape that doesn't depend on a particular
//! ABI or instruction encoding -- so the per-arch modules
//! (`x86_64/emit.rs`, `aarch64/emit.rs`) don't carry parallel
//! copies. The assembler this file used to hold is `c5::asm`.

use crate::c5::diag::Code;

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
    pub(crate) asm_sections: &'a mut crate::c5::asm::AsmSectionSink,
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
    /// Bytes the stack-protector region added to each protected function's
    /// frame, by `ent_pc`. Every local slot sits that much lower, so the
    /// debug-info emitter subtracts it from the slot's frame offset.
    /// Absent for a function with no canary.
    pub(crate) canary_frame_bytes: &'a mut alloc::collections::BTreeMap<usize, u32>,
    /// Offsets of the `-pg` call sites `-mrecord-mcount` records.
    pub(crate) mcount_sites: &'a mut alloc::vec::Vec<usize>,
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
            return Err(crate::c5::error::C5Error::hard(
                Code::LIMIT,
                alloc::format!(
                    "function `{name}`: {body}",
                    name = f.name,
                    body = frame_too_large_msg(bytes),
                ),
            ));
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

    /// Target tag in traces.
    const ARCH: &'static str;

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

/// Sequentialize parallel integer location-to-location moves. An endpoint
/// that is an FP register or None is an `Err` (the caller falls back to
/// per-instruction placement). Each move is emitted via [`emit_place_move`]; a
/// residual cycle is broken by the backend's [`EmitBackend::break_place_cycle`].
/// `hold`/`stage` are scratch registers outside the allocator's bank.
pub(crate) fn schedule_place_moves<B: EmitBackend>(
    b: &B,
    code: &mut alloc::vec::Vec<u8>,
    moves: &mut alloc::vec::Vec<(super::reg_alloc::Place, super::reg_alloc::Place)>,
    frame: B::Frame,
    hold: u8,
    stage: u8,
) -> Emit {
    use super::reg_alloc::Place;
    moves.retain(|(s, t)| !place_same_loc(*s, *t));
    if moves.iter().any(|(s, t)| {
        matches!(s, Place::FpReg(_) | Place::None) || matches!(t, Place::FpReg(_) | Place::None)
    }) {
        return fail::<B, _>("parallel move: endpoint not int reg / spill");
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
    Ok(())
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
/// (the register files do not alias) and schedule each. An integer copy that
/// cannot be scheduled is an `Err`, so the caller bails. `int_*` / `fp_*` are
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
) -> Emit {
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
            Terminator::GotoIndirect { .. } => {
                // The branch reads an address-taken label's own block
                // address, so `split_crit_edges` cannot route its edges
                // through synthetic blocks. With more than one target the
                // moves emitted here would run on every edge; refuse the
                // function rather than clobber the alternate paths.
                let targets = &func.computed_goto_targets;
                if targets.len() > 1 {
                    for &t in targets {
                        for id in func.blocks[t as usize].inst_range.clone() {
                            let Inst::Phi { incoming, .. } = &func.insts[id as usize] else {
                                break;
                            };
                            if incoming.iter().any(|(p, _)| *p == self_block) {
                                return fail::<B, _>("GotoIndirect: phi on a multi-target edge");
                            }
                        }
                    }
                }
                targets.clone()
            }
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
                            return fail::<B, _>("AsmGoto: phi across an unsplit label edge");
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
            let phi_is_fp = matches!(
                kind,
                LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128
            );
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
        schedule_place_moves(b, code, &mut moves, frame, int_hold, int_stage)?;
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
    Ok(())
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

/// [`time_pass`] with the target tag every backend appends to its pass
/// labels. The label is formatted only when the instrumentation is on.
#[cfg(feature = "codegen_test")]
pub(crate) fn time_pass_arch<R>(label: &str, arch: &str, f: impl FnOnce() -> R) -> R {
    if !time_passes_enabled() {
        return f();
    }
    time_pass(&alloc::format!("{label} ({arch})"), f)
}

#[cfg(not(feature = "codegen_test"))]
pub(crate) fn time_pass_arch<R>(_label: &str, _arch: &str, f: impl FnOnce() -> R) -> R {
    f()
}

/// A form outside the implemented subset and the reason the emit named
/// for it; the reason reaches the diagnostic verbatim.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct Unsupported(alloc::borrow::Cow<'static, str>);

impl Unsupported {
    pub(crate) fn new(reason: impl Into<alloc::borrow::Cow<'static, str>>) -> Self {
        Self(reason.into())
    }

    pub(crate) fn reason(&self) -> &str {
        &self.0
    }
}

/// Result of an emit step: `Err` names a form outside the implemented subset.
pub(crate) type Emit<T = ()> = Result<T, Unsupported>;

/// [`Unsupported`] as an emit result, traced under the backend's tag.
fn fail<B: EmitBackend, T>(reason: &'static str) -> Emit<T> {
    trace_bail(B::ARCH, reason);
    Err(Unsupported::new(reason))
}

/// Diagnostic for a function the emit could not lower. No `std` gate: a
/// `no_std` build reports the same text.
pub(crate) fn unsupported_error(
    e: &Unsupported,
    arch: &str,
    name: &str,
) -> crate::c5::error::C5Error {
    crate::c5::error::C5Error::hard(
        Code::UNSUPPORTED,
        alloc::format!("{} ({arch}, function `{name}`)", e.reason()),
    )
}

/// Stderr trace for an emit bail, under the `codegen_test` feature with
/// `BADC_DUMP_SSA` set; a production build never reads the environment.
/// The backend tag disambiguates a run that emits for both targets.
pub(crate) fn trace_bail(backend: &str, reason: &str) {
    #[cfg(feature = "codegen_test")]
    if std::env::var("BADC_DUMP_SSA").is_ok() {
        eprintln!("ssa emit {backend}: bailed -- {reason}");
    }
    let _ = (backend, reason);
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
/// `canary_bytes` is the size of the stack-protector region the frame
/// reserves directly below the frame base; every local slot sits below it,
/// so the canary is between the locals and the saved return address.
/// Parameter cells live above the frame base and are unaffected.
pub(crate) fn c5_slot_to_fp_offset(off: i64, param_stride: i64, canary_bytes: u32) -> i64 {
    if off >= 2 {
        16 + (off - 2) * param_stride
    } else {
        off * 8 - canary_bytes as i64
    }
}

/// Bytes the stack-protector region adds to the frame. `locals_bytes` is
/// the declared-locals region size `compute_frame_base` returned, which is
/// zero when no local access survives -- there is then nothing in the frame
/// for a canary to guard, and only `-fstack-protector-all` still asks for
/// one. A naked function emits no prologue and can carry no canary.
pub(crate) fn canary_bytes(
    func: &super::super::ir::FunctionSsa,
    locals_bytes: u32,
    ssp: super::super::StackProtect,
) -> u32 {
    let has_frame = locals_bytes > 0 || uses_dynamic_alloca(func);
    if func.is_naked || !ssp.protects(func.ssp, has_frame) {
        return 0;
    }
    super::super::CANARY_REGION_BYTES
}

/// Frame-base-relative byte offset of the canary slot: the topmost 8 bytes
/// of the reserved region, directly below the saved frame pointer.
pub(crate) const CANARY_SLOT_OFF: i32 = -8;

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

/// Parser-symbol index -> ent_pc for every function this program
/// defines. The inliner's devirtualization reads it to tell a defined
/// function at ent_pc 0 apart from an unresolved reference, both of
/// which carry an `extern_imm_code_refs` entry.
pub(crate) fn defined_fn_syms(
    program: &crate::c5::program::Program,
) -> alloc::collections::BTreeMap<u32, usize> {
    program
        .symbols
        .iter()
        .enumerate()
        .filter(|(_, s)| s.is_fun_entity() && s.defined_here)
        .map(|(i, s)| (i as u32, s.val as usize))
        .collect()
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
    is_dead_pure_counts(inst, v, &alloc.use_counts)
}

/// [`is_dead_pure`] over a bare use-count slice. The allocator applies
/// it before the `Allocation` exists, when it collects the used-register
/// sets; the two callers must agree on which values produce no code.
pub(crate) fn is_dead_pure_counts(
    inst: &super::super::ir::Inst,
    v: super::super::ir::ValueId,
    use_counts: &[u32],
) -> bool {
    inst.is_pure() && use_counts.get(v as usize).copied().unwrap_or(0) == 0
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

// ------------------------------------------------------------------
// Per-function lowering shell
// ------------------------------------------------------------------

/// Target-neutral state one translation unit's lowering accumulates: the
/// code buffer, the fixup and relocation vectors both backends fill, and
/// the per-function bookkeeping the object writers read back off `Build`.
pub(crate) struct LowerState {
    pub(crate) code: alloc::vec::Vec<u8>,
    pub(crate) func_ent_pcs: alloc::vec::Vec<usize>,
    pub(crate) func_ends: alloc::vec::Vec<usize>,
    pub(crate) patchable_entries: alloc::vec::Vec<super::EntryArea>,
    pub(crate) mcount_sites: alloc::vec::Vec<usize>,
    pub(crate) func_names: alloc::vec::Vec<alloc::string::String>,
    pub(crate) func_prologue_native: alloc::collections::BTreeMap<usize, usize>,
    pub(crate) ssa_line_rows: alloc::vec::Vec<(usize, u32, u32)>,
    pub(crate) asm_sections: crate::c5::asm::AsmSectionSink,
    pub(crate) got_fixups: alloc::vec::Vec<super::GotFixup>,
    pub(crate) plt_call_fixups: alloc::vec::Vec<super::PltCallFixup>,
    pub(crate) data_fixups: alloc::vec::Vec<super::DataFixup>,
    pub(crate) user_extern_data_refs: alloc::vec::Vec<super::UserExternDataRef>,
    pub(crate) pending_func_fixups: alloc::vec::Vec<(usize, usize)>,
    pub(crate) tls_index_fixups: alloc::vec::Vec<super::TlsIndexFixup>,
    pub(crate) elf_tpoff_fixups: alloc::vec::Vec<super::ElfTpoffFixup>,
    pub(crate) asm_extern_call_sites: alloc::vec::Vec<super::UserExternCallSite>,
    pub(crate) asm_sym_fixups: alloc::vec::Vec<super::AsmSymFixup>,
    pub(crate) asm_text_labels: alloc::vec::Vec<super::AsmTextLabel>,
    pub(crate) asm_section_text_refs: alloc::vec::Vec<super::AsmSectionTextRef>,
    pub(crate) text_align: usize,
    pub(crate) label_relocs: alloc::vec::Vec<super::LabelReloc>,
    pub(crate) text_data_ranges: alloc::vec::Vec<(usize, usize)>,
    pub(crate) canary_frame_bytes: alloc::collections::BTreeMap<usize, u32>,
    /// Entry PC to code offset, `usize::MAX` for a PC with no instruction.
    pub(crate) pc_to_native: alloc::vec::Vec<usize>,
    pub(crate) rodata: super::RodataBuild,
}

impl LowerState {
    fn new() -> Self {
        Self {
            code: alloc::vec::Vec::new(),
            func_ent_pcs: alloc::vec::Vec::new(),
            func_ends: alloc::vec::Vec::new(),
            patchable_entries: alloc::vec::Vec::new(),
            mcount_sites: alloc::vec::Vec::new(),
            func_names: alloc::vec::Vec::new(),
            func_prologue_native: alloc::collections::BTreeMap::new(),
            ssa_line_rows: alloc::vec::Vec::new(),
            asm_sections: crate::c5::asm::AsmSectionSink::default(),
            got_fixups: alloc::vec::Vec::new(),
            plt_call_fixups: alloc::vec::Vec::new(),
            data_fixups: alloc::vec::Vec::new(),
            user_extern_data_refs: alloc::vec::Vec::new(),
            pending_func_fixups: alloc::vec::Vec::new(),
            tls_index_fixups: alloc::vec::Vec::new(),
            elf_tpoff_fixups: alloc::vec::Vec::new(),
            asm_extern_call_sites: alloc::vec::Vec::new(),
            asm_sym_fixups: alloc::vec::Vec::new(),
            asm_text_labels: alloc::vec::Vec::new(),
            asm_section_text_refs: alloc::vec::Vec::new(),
            text_align: 16,
            label_relocs: alloc::vec::Vec::new(),
            text_data_ranges: alloc::vec::Vec::new(),
            canary_frame_bytes: alloc::collections::BTreeMap::new(),
            pc_to_native: alloc::vec::Vec::new(),
            rodata: super::RodataBuild::default(),
        }
    }

    /// The emit outputs one function's lowering writes to, as disjoint
    /// borrows of the shared state.
    pub(crate) fn function_emit(&mut self) -> FunctionEmit<'_> {
        FunctionEmit {
            cx: EmitCtx {
                code: &mut self.code,
                plt_call_fixups: &mut self.plt_call_fixups,
                data_fixups: &mut self.data_fixups,
                user_extern_data_refs: &mut self.user_extern_data_refs,
                pending_func_fixups: &mut self.pending_func_fixups,
                tls_index_fixups: &mut self.tls_index_fixups,
                elf_tpoff_fixups: &mut self.elf_tpoff_fixups,
                ssa_line_rows: &mut self.ssa_line_rows,
                pc_to_native: &mut self.pc_to_native,
                prologue_native: &mut self.func_prologue_native,
                asm_sections: &mut self.asm_sections,
                asm_extern_call_sites: &mut self.asm_extern_call_sites,
                asm_sym_fixups: &mut self.asm_sym_fixups,
                text_align: &mut self.text_align,
                label_relocs: &mut self.label_relocs,
                text_data_ranges: &mut self.text_data_ranges,
                canary_frame_bytes: &mut self.canary_frame_bytes,
                mcount_sites: &mut self.mcount_sites,
            },
            rodata: &mut self.rodata,
            asm_text_labels: &mut self.asm_text_labels,
            asm_section_text_refs: &mut self.asm_section_text_refs,
            got_fixups: &mut self.got_fixups,
        }
    }
}

/// [`EmitCtx`] plus the outputs a backend's function emit takes beside it,
/// all borrowed from one [`LowerState`].
pub(crate) struct FunctionEmit<'a> {
    pub(crate) cx: EmitCtx<'a>,
    pub(crate) rodata: &'a mut super::RodataBuild,
    pub(crate) asm_text_labels: &'a mut alloc::vec::Vec<super::AsmTextLabel>,
    pub(crate) asm_section_text_refs: &'a mut alloc::vec::Vec<super::AsmSectionTextRef>,
    pub(crate) got_fixups: &'a mut alloc::vec::Vec<super::GotFixup>,
}

/// Read-only inputs one function's lowering resolves names against.
pub(crate) struct FunctionInputs<'a> {
    pub(crate) program: &'a super::super::program::Program,
    /// `imm_data_extern` value id to cross-TU symbol name.
    pub(crate) extern_data_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    /// `tls_addr_extern` value id to cross-TU symbol name.
    pub(crate) extern_tls_names: &'a alloc::collections::BTreeMap<u32, alloc::string::String>,
    pub(crate) variadic_targets: &'a alloc::collections::BTreeSet<usize>,
    pub(crate) name2entpc: &'a alloc::collections::BTreeMap<alloc::string::String, usize>,
}

/// The per-target half of the lowering shell: encodings, stub bytes,
/// relocation kinds, and the callee tables one target derives and the
/// other does not. [`lower_unit`] owns the phase order and the
/// bookkeeping and reaches everything else through here.
pub(crate) trait LowerTarget {
    /// Branch placeholder the target's emit records for the post-walk
    /// fixup pass.
    type Fixup;

    /// Target tag in pass labels.
    const ARCH: &'static str;
    /// Target tag the shell's own diagnostics carry.
    const ERR_TAG: &'static str;
    /// Pass label for the block-walk timing line.
    const WALK_PASS: &'static str;
    /// `.align` in a file-scope asm block takes a power-of-two exponent.
    const FILE_ASM_ALIGN_POW2: bool;
    /// Comment syntax the file-scope asm blocks are parsed with.
    const FILE_ASM_COMMENTS: crate::c5::asm::AsmComments;

    /// Optimizer passes this target runs at the end of the -O pipeline.
    fn late_opt_passes(&mut self, funcs: &mut alloc::vec::Vec<super::super::ir::FunctionSsa>);

    /// Per-callee tables the target derives from the finished bodies.
    fn note_callees(&mut self, funcs: &[super::super::ir::FunctionSsa]);

    /// Per-callee facts from a cross-TU function declaration in this unit.
    fn note_extern_callee(&mut self, sym: &crate::c5::symbol::Symbol);

    /// Dump the allocated unit before the walk.
    #[cfg(feature = "std")]
    fn dump_unit(
        &self,
        _program: &super::super::program::Program,
        _funcs: &[super::super::ir::FunctionSsa],
        _allocs: &[super::reg_alloc::Allocation],
        _out: &mut alloc::string::String,
    ) {
    }

    /// Dump one function after its walk.
    #[cfg(feature = "std")]
    fn dump_function(
        &self,
        _func: &super::super::ir::FunctionSsa,
        _alloc_for: &super::reg_alloc::Allocation,
        _ok: bool,
        _out: &mut alloc::string::String,
    ) {
    }

    /// Bring the code stream to the next function's entry alignment.
    fn align_entry(&mut self, st: &mut LowerState, fn_align: usize);

    /// Emit `n` no-ops ahead of the function symbol.
    fn entry_nops(&mut self, code: &mut alloc::vec::Vec<u8>, n: u32);

    /// Lower one function's body.
    #[allow(clippy::too_many_arguments)]
    fn emit_function(
        &mut self,
        fe: FunctionEmit<'_>,
        inputs: &FunctionInputs<'_>,
        func: &super::super::ir::FunctionSsa,
        alloc_for: &super::reg_alloc::Allocation,
        target: super::Target,
        native: &super::NativeOptions,
        imports: &super::ResolvedImports,
        entry: super::FunctionEntry,
    ) -> Emit;

    /// Settle target-specific per-function output once the walk is done.
    fn after_functions(&mut self, st: &mut LowerState, native: &super::NativeOptions);

    /// The branch fixups the walk recorded, taken out of the target.
    fn take_fixups(&mut self) -> alloc::vec::Vec<Self::Fixup>;

    /// Code offset of the placeholder branch.
    fn fixup_native_offset(f: &Self::Fixup) -> usize;
    /// Entry PC the placeholder branch lands on.
    fn fixup_target_ent_pc(f: &Self::Fixup) -> usize;
    /// The placeholder is a tail branch rather than a call.
    fn fixup_is_tail(f: &Self::Fixup) -> bool;

    /// Patch every placeholder branch with its resolved displacement.
    fn apply_fixups(
        code: &mut [u8],
        fixups: &[Self::Fixup],
        pc_to_native: &[usize],
        pc_extent: usize,
    ) -> Result<(), crate::c5::error::C5Error>;

    /// Append one PLT trampoline per import; returns their code offsets.
    fn emit_plt_trampolines(
        code: &mut alloc::vec::Vec<u8>,
        got_fixups: &mut alloc::vec::Vec<super::GotFixup>,
        n_imports: usize,
    ) -> alloc::vec::Vec<usize>;

    /// Patch every import call placeholder to reach its trampoline.
    fn apply_plt_call_fixups(
        code: &mut [u8],
        fixups: &[super::PltCallFixup],
        trampoline_offsets: &[usize],
    ) -> Result<(), crate::c5::error::C5Error>;

    /// Code offset of the program entry, `usize::MAX` when the entry PC
    /// has no instruction.
    fn entry_native_offset(
        pc_to_native: &[usize],
        entry_pc: usize,
    ) -> Result<usize, crate::c5::error::C5Error>;

    /// CFI encoding parameters for the file-scope asm sections.
    fn cfi_target(native: &super::NativeOptions) -> super::cfi::CfiTarget;

    /// Move the target's own output into the finished `Build`.
    fn install(&mut self, build: &mut super::Build);
}

/// Lower one translation unit: SSA production, the optimizer pipeline,
/// register allocation, the per-function walk, and the post-walk fixup and
/// trampoline passes.
pub(crate) fn lower_unit<B: LowerTarget>(
    b: &mut B,
    program: &super::super::program::Program,
    target: super::Target,
    native: super::NativeOptions,
    imports: &super::ResolvedImports,
    prebuilt: Option<super::shadow::PrebuiltSsa>,
    mode: super::LowerMode,
) -> Result<super::Build, crate::c5::error::C5Error> {
    use crate::c5::error::C5Error;

    // Asm label numbering restarts per lowering; see
    // `crate::c5::asm::reset_asm_instance`.
    crate::c5::asm::reset_asm_instance();
    let mut st = LowerState::new();
    crate::c5::asm::materialize_file_asm(
        &program.file_asm,
        B::FILE_ASM_ALIGN_POW2,
        B::FILE_ASM_COMMENTS,
        &|blocks| super::super::encode_file_asm_section_code(blocks, target, native.elf_class),
        &mut st.asm_sections,
    )
    .map_err(|m| C5Error::hard(Code::ASSEMBLER, alloc::format!("<file-scope asm>: {m}")))?;

    // Lift the program into SSA once and run the linear-scan allocator per
    // function. A per-function emit bail is a hard error so any IR + emit
    // coverage gap surfaces immediately. A recompaction retry supplies the
    // post-inline bodies directly; the walk and the -O passes that produced
    // them are skipped, the rest of the pipeline runs unchanged.
    let walked = prebuilt.is_none();
    let (mut ssa_funcs, prebuilt_promoted) = match prebuilt {
        Some(p) => (p.funcs, p.promoted_local_slots),
        None => (
            time_pass_arch("ssa::produce_ssa_funcs", B::ARCH, || {
                super::shadow::produce_ssa_funcs(
                    program,
                    target,
                    native.optimize,
                    native.jump_tables,
                )
            })?,
            alloc::collections::BTreeMap::new(),
        ),
    };
    // A final image is its own link step: bind import placeholders a
    // function alias of this unit resolves. A relocatable object keeps
    // them symbolic for the linker.
    if native.output_kind != super::OutputKind::Relocatable {
        super::shadow::bind_alias_imports(program, &mut ssa_funcs);
    }
    check_frame_limits(&ssa_funcs)?;
    // Frame slots mem2reg promoted to registers (-O) or that slot
    // coalescing moved onto shared storage: the debug-info emitter drops
    // their stale frame location. Slots coalescing moved to a new exclusive
    // offset are recorded separately so the emitter rewrites the location.
    let mut promoted_local_slots: alloc::collections::BTreeMap<usize, alloc::vec::Vec<i64>> =
        prebuilt_promoted;
    let mut coalesced_slot_remap: alloc::collections::BTreeMap<
        usize,
        alloc::collections::BTreeMap<i64, i64>,
    > = alloc::collections::BTreeMap::new();
    // Reuse non-overlapping synthetic stack slots. At -O, mem2reg promotes
    // these address-free slots to SSA values; this is the default-level
    // analog, shrinking frames built from many control-flow merges whose
    // phi-substitute slots never overlap. The pass runs regardless of debug
    // info so the emitted code is identical with and without -g.
    if !native.optimize && walked {
        let coalesce_dwarf = time_pass_arch("ssa::slot_coalesce::run", B::ARCH, || {
            super::slot_coalesce::run(&mut ssa_funcs, false)
        });
        record_coalesced_slots(
            coalesce_dwarf,
            &mut coalesced_slot_remap,
            &mut promoted_local_slots,
        );
    }
    // Data the -O pipeline orphans after the pre-inline compaction
    // packed `.data`; the caller recompacts and lowers again.
    let mut orphaned_data: Option<super::shadow::OrphanedData> = None;
    // Written only under the `std` dump path; the Build field is
    // unconditional.
    #[cfg_attr(not(feature = "std"), allow(unused_mut))]
    let mut ssa_dump = alloc::string::String::new();
    // -O: promote address-free local slots to SSA values before
    // register allocation, dropping their frame load / store traffic.
    // Record the promoted slots per function so the debug-info emitter
    // can drop their now-stale frame location.
    if native.optimize && walked {
        time_pass_arch("ssa::mem2reg::run", B::ARCH, || {
            for f in &mut ssa_funcs {
                let promoted = super::mem2reg::run(f);
                if !promoted.is_empty() {
                    promoted_local_slots.insert(f.ent_pc, promoted);
                }
            }
        });
        // Simplify each body before the inliner reads it. A helper whose
        // guard is constant -- a configuration predicate compiled to 0 --
        // is a multi-block body with live parameter-cell reads until the
        // dead arm is pruned, a shape the candidate filter rejects; folded
        // first, it inlines and lets the caller's own guard fold in turn.
        // `resolve_constant_p` stays false: a deferred
        // `__builtin_constant_p` must survive for the inliner's argument
        // substitution.
        time_pass_arch("passes::simplify_branches::pre_inline", B::ARCH, || {
            super::super::passes::simplify_branches::run(&mut ssa_funcs);
        });
        // Unroll constant-trip loops after mem2reg (the loop-carried
        // values are phis by then) and before the inliner, so a helper
        // whose body was a short loop becomes a single-block inline
        // candidate and the cloned call sites join the inliner's
        // worklist. The post-inline constant folder then collapses the
        // per-copy `Extend(Imm)` / `BinopI(Imm, k)` index chains.
        time_pass_arch("passes::unroll::run", B::ARCH, || {
            super::super::passes::unroll::run(&mut ssa_funcs);
        });
        // Merge byte-at-a-time memory idioms after the unroll, which
        // straight-lines the per-byte loops they are often written as,
        // and before the inliner: a helper that collapses to one wide
        // access becomes a single-block candidate the inliner takes,
        // and its call sites see the merged body.
        time_pass_arch("passes::byteload::run", B::ARCH, || {
            super::super::passes::byteload::run(
                &mut ssa_funcs,
                target.is_little_endian(),
                native.strict_align,
            );
        });
        // Seed a parameter every call site of an internal function
        // agrees a constant for, and record the range each parameter's
        // argument stays inside for the range analysis below. After
        // unrolling and before inlining: a callee the inliner absorbs
        // gets the same constant by argument substitution, so this is
        // what reaches the bodies that stay out of line.
        // Interprocedural parameter ranges, by entry PC; read by the
        // range analysis inside the branch-fold fixed point below.
        let param_ranges = time_pass_arch("passes::ipa_const_param::run", B::ARCH, || {
            let escaping =
                super::super::passes::ipa_const_param::escaping_functions(&ssa_funcs, program);
            super::super::passes::ipa_const_param::run(&mut ssa_funcs, &escaping)
        });
        // Inline after mem2reg so the candidate filter sees the
        // promoted form: dead cell loads / stores are gone and the
        // callee's body reads its parameters via `ParamRef`. The symbol
        // map feeds the pass's indirect-call devirtualization.
        let code_syms = defined_fn_syms(program);
        time_pass_arch("passes::inline::run", B::ARCH, || {
            super::super::passes::inline::run(
                &mut ssa_funcs,
                native.inline_cap,
                target.abi(),
                &code_syms,
            );
        });
        // Turn self-tail-recursion into a loop back edge on the
        // post-inline bodies, before the phi-sensitive passes below.
        time_pass_arch("passes::tailrec::run", B::ARCH, || {
            super::super::passes::tailrec::run(&mut ssa_funcs);
        });
        // Forward an inlined one-word struct return out of its frame slot:
        // a single full-width store + slot reads collapse to the stored
        // register value. Runs after the inliner produces the slot and
        // before store-forwarding cleans up any second-hop reload.
        time_pass_arch("passes::struct_return_reg::run", B::ARCH, || {
            super::super::passes::struct_return_reg::run(&mut ssa_funcs, native.strict_align);
        });
        // Constant folding over the post-inline tape: `Extend(Imm)` /
        // `Binop(Imm, Imm)` chains left by parameter substitution fold
        // to plain `Imm`, and immediate-operand binops take `BinopI`
        // form, so the rotate matcher and the branch folder see
        // constants.
        time_pass_arch("passes::constfold::run", B::ARCH, || {
            super::super::passes::constfold::run(&mut ssa_funcs);
        });
        // Re-run mem2reg on callers the inliner spliced into. A relocated
        // callee local can land on an address-free, single-width slot that
        // pre-inline mem2reg never saw (it did not exist then), so its store
        // and load stay in the frame -- and a constant stored there is not
        // folded into the `"i"`-constrained inline-asm operand that reads it.
        // Confined to inlined callers by the did_inline gate; promoted slots
        // feed the same debug-info location drop as the initial mem2reg.
        time_pass_arch("ssa::mem2reg::run post-inline", B::ARCH, || {
            for f in &mut ssa_funcs {
                if f.did_inline {
                    let promoted = super::mem2reg::run(f);
                    if !promoted.is_empty() {
                        promoted_local_slots
                            .entry(f.ent_pc)
                            .or_default()
                            .extend(promoted);
                    }
                }
            }
        });
        // Split address-taken local aggregates into per-field slots and
        // re-run mem2reg to promote them to SSA values. Gated to the
        // functions unrolling expanded (constant-index array subscripts)
        // or the inliner spliced into (a helper's field accesses through
        // a caller local's address), so the mem2reg rebuild is confined;
        // the promoted field slots feed the same debug-info location
        // drop as the initial mem2reg.
        time_pass_arch("passes::sroa::run", B::ARCH, || {
            let usable_gpr = super::reg_alloc::usable_gpr_count(target, native.fixed_regs);
            // What each function does with its pointer parameters, so a
            // call taking an object's address gives up only the fields
            // it can reach. Derived once over the whole unit, and only
            // where the gate below admits some function.
            let footprints = if ssa_funcs.iter().any(|f| f.did_unroll || f.did_inline) {
                super::super::passes::sroa::param_footprints(&ssa_funcs)
            } else {
                Default::default()
            };
            for f in &mut ssa_funcs {
                if f.did_unroll || f.did_inline {
                    let promoted = super::super::passes::sroa::run(f, usable_gpr, &footprints);
                    if !promoted.is_empty() {
                        promoted_local_slots
                            .entry(f.ent_pc)
                            .or_default()
                            .extend(promoted);
                    }
                }
            }
        });
        // Rotate idiom recognition: collapses `(x >> c) | (x << (W -
        // c))` chains to `BinopI(Ror, x, c)`. Runs after the inliner
        // so post-inline parameter substitutions expose the constant
        // rotate counts.
        time_pass_arch("passes::rotate::run", B::ARCH, || {
            super::super::passes::rotate::run(&mut ssa_funcs);
        });
        // Fused multiply-add contraction (C99 6.5p8 / FP_CONTRACT ON at
        // -O). Runs after the inliner so products exposed by parameter
        // substitution into an add/sub become contractible.
        time_pass_arch("passes::fma::run", B::ARCH, || {
            super::super::passes::fma::run(&mut ssa_funcs);
        });
        // Prove a null comparison of a const array's relocated pointer
        // member false. Runs after constfold has folded the constant
        // member offset (`ARRAY_SIZE(a) - 1` -> a fixed index), so the
        // branch fold below deletes the unreachable arm (e.g. an inlined
        // build-time-unreachable guard).
        time_pass_arch("passes::const_global_fold::run", B::ARCH, || {
            super::super::passes::const_global_fold::run(&mut ssa_funcs, program);
        });
        // Fold constant-condition branches and delete the blocks that
        // leaves unreachable (so their calls and extern references are
        // neither lowered nor relocated), to a fixed point: pruning a
        // folded branch's dead predecessor can collapse a merge phi and
        // expose a fresh constant condition one level down. The
        // const-data-aware form also folds loads from const initialized
        // data inside the same fixed point, so an inlined table lookup
        // whose index just became constant decides the next branch (a
        // build-time-assert guard reading a const table).
        time_pass_arch("passes::simplify_branches::run", B::ARCH, || {
            super::super::passes::simplify_branches::run_with_const_data(
                &mut ssa_funcs,
                program,
                &param_ranges,
            );
        });
    }
    // Re-run static DCE: inlining a static callee into its last caller,
    // and the branch fold dropping calls in unreachable arms, can leave
    // a static function with no remaining references. Dropping it now
    // keeps its body -- and any undefined symbol it alone referenced
    // (e.g. an unreachable build-time-assert canary the fold removed
    // from the caller) -- out of the object. It also reports the data the
    // pipeline orphaned; the passes below run on prebuilt bodies too, so a
    // recompaction retry re-runs them and re-checks the report is empty.
    if native.optimize {
        orphaned_data = time_pass_arch("ssa::shadow::drop_unreachable_statics", B::ARCH, || {
            super::shadow::drop_unreachable_statics(&mut ssa_funcs, program)
        });
        if let Some(o) = &mut orphaned_data {
            o.ssa.promoted_local_slots = promoted_local_slots.clone();
        }
        // A probe caller relowers the reported bodies against a `.data`
        // this run cannot know, so everything below would be discarded.
        if orphaned_data.is_some() && mode == super::LowerMode::DataLivenessProbe {
            return Ok(super::Build {
                orphaned_data,
                stopped_at_data_liveness: true,
                ..Default::default()
            });
        }
        // Frame compaction after inlining, promotion, and the branch
        // folds: slots with no remaining reference are dropped and the
        // survivors repacked, so a spliced-then-promoted callee region
        // stops occupying the frame. Before `index_fold`, whose derived
        // address forms the compactor does not model.
        let coalesce_dwarf = time_pass_arch("ssa::slot_coalesce::run -O", B::ARCH, || {
            super::slot_coalesce::run(&mut ssa_funcs, true)
        });
        record_coalesced_slots(
            coalesce_dwarf,
            &mut coalesced_slot_remap,
            &mut promoted_local_slots,
        );
        time_pass_arch("passes::split_crit_edges::run", B::ARCH, || {
            super::super::passes::split_crit_edges::run(&mut ssa_funcs);
        });
        time_pass_arch("passes::dedup_imm::run", B::ARCH, || {
            super::super::passes::dedup_imm::run(&mut ssa_funcs);
        });
        time_pass_arch("passes::drop_redundant_extend::run", B::ARCH, || {
            super::super::passes::drop_redundant_extend::run(&mut ssa_funcs);
        });
        // Scaled-index addressing: fold `base + index*scale` into the
        // load / store. Runs last so it sees the final address shape;
        // the optimizer passes never traverse `LoadIndexed` /
        // `StoreIndexed`, so the per-arch emit is the only later consumer.
        time_pass_arch("passes::index_fold::run", B::ARCH, || {
            super::super::passes::index_fold::run(&mut ssa_funcs);
        });
        // Dominator-scoped CSE of pure arithmetic and address values.
        // After the index fold, so merging cannot weld two `base + K`
        // addresses the fold would have turned into displacements; the
        // canonical bases then feed store forwarding.
        time_pass_arch("passes::cse::run", B::ARCH, || {
            let caps = super::reg_alloc::bank_capacity(target, native.fixed_regs);
            super::super::passes::cse::run(&mut ssa_funcs, caps);
        });
        // Rebuild the single modulo where the builder's split quotient
        // found no division to share with. After the value numbering,
        // which is what can still supply that second consumer.
        time_pass_arch("passes::divmod_pair::run", B::ARCH, || {
            super::super::passes::divmod_pair::run(&mut ssa_funcs);
        });
        // Store-to-load and load-to-load forwarding within a block. Runs
        // after the index fold so a struct field's store and load address
        // are both normalised to the same `(base, disp)`. Bounded by
        // live-range extension so it does not pin scattered re-reads in a
        // register-starved unrolled loop.
        time_pass_arch("passes::store_forward::run", B::ARCH, || {
            super::super::passes::store_forward::run(&mut ssa_funcs);
        });
        b.late_opt_passes(&mut ssa_funcs);
        // Rewrite `CallIndirect`-of-`ImmCode` pairs the passes since the
        // inline run exposed -- the post-inline promotions and the
        // forwarding above turn function-pointer cell reads into
        // `ImmCode` values -- so the emit issues direct calls. Last of
        // the passes that change call targets.
        time_pass_arch("passes::inline::devirtualize", B::ARCH, || {
            let code_syms = defined_fn_syms(program);
            super::super::passes::inline::devirtualize(&mut ssa_funcs, &code_syms);
        });
        // Block layout: fallthrough chains, loop rotation to
        // bottom-test, branch inversion. Reorders blocks and remaps
        // block ids only, so it runs last; the emit elides jumps to
        // the next block in the new order.
        time_pass_arch("passes::layout::run", B::ARCH, || {
            super::super::passes::layout::run(&mut ssa_funcs);
        });
    }
    // Upper bound on ent_pcs the lowering will reference. The walker stamps
    // `ent_pc` / `end_pc` against the ent_pc space, and the dense
    // `pc_to_native` table holds every reachable PC.
    let pc_extent = super::pc_extent_for_lowering(program, &ssa_funcs);
    st.pc_to_native = alloc::vec![usize::MAX; pc_extent + 1];
    // Per-callee variadic flag, derived from `FunctionSsa::is_variadic` for
    // locally-defined callees and from `Symbol::is_variadic` for cross-TU
    // extern-declared callees. Each call site reads it to pick the host-ABI
    // vs c5-stack arg passing shape for the callee. Without the extern
    // entries here, a cross-TU call to a variadic function emits a
    // non-variadic register sequence and the callee reads junk from the c5
    // stack.
    let mut variadic_targets: alloc::collections::BTreeSet<usize> = ssa_funcs
        .iter()
        .filter(|f| f.is_variadic)
        .map(|f| f.ent_pc)
        .collect();
    b.note_callees(&ssa_funcs);
    {
        use crate::c5::symbol::Linkage;
        let extern_pcs: alloc::collections::BTreeSet<usize> = program
            .extern_function_imports
            .iter()
            .map(|(pc, _)| *pc)
            .collect();
        for sym in &program.symbols {
            if !sym.is_fun_entity() || sym.defined_here || !extern_pcs.contains(&(sym.val as usize))
            {
                continue;
            }
            if sym.linkage == Linkage::External && sym.is_variadic {
                variadic_targets.insert(sym.val as usize);
            }
            b.note_extern_callee(sym);
        }
    }
    // Branch on a zero test's operand directly. Immediately before
    // allocation so every mid-end fold keyed on the compare shape has
    // run.
    for f in ssa_funcs.iter_mut() {
        super::super::passes::constfold_branch::strip_zero_test_conds(f);
    }
    // At -O each function is allocated, then reallocated with the
    // spilled values' call-free reuse runs split out; the split is kept
    // only when it lowers the function's loop-weighted spill traffic.
    let ssa_allocs: alloc::vec::Vec<super::reg_alloc::Allocation> =
        time_pass_arch("ssa::reg_alloc::allocate", B::ARCH, || {
            ssa_funcs
                .iter_mut()
                .map(|f| {
                    if native.optimize {
                        super::licm::allocate_hoisted(f, target, native.fixed_regs)
                    } else {
                        super::reg_alloc::allocate(f, target, native.fixed_regs)
                    }
                })
                .collect()
        });
    #[cfg(feature = "std")]
    if super::dump::enabled(native) {
        b.dump_unit(program, &ssa_funcs, &ssa_allocs, &mut ssa_dump);
    }
    #[cfg(feature = "std")]
    let _ssa_emit_pass_start = std::time::Instant::now();
    let name2entpc: alloc::collections::BTreeMap<alloc::string::String, usize> = ssa_funcs
        .iter()
        .map(|f| (f.name.clone(), f.ent_pc))
        .collect();
    let fn_align = native.min_function_alignment.max(1) as usize;
    st.text_align = st.text_align.max(fn_align);
    for (func_ssa, alloc_for) in ssa_funcs.iter().zip(ssa_allocs.iter()) {
        let ent_pc = func_ssa.ent_pc;
        let entry = super::FunctionEntry::of(func_ssa, &native);
        // `-fmin-function-alignment=N`: the function's first byte starts at a
        // multiple of N, the gap filled with no-ops. Under
        // `-fpatchable-function-entry` that byte opens the no-op area, of
        // which `nops_before` precede the symbol.
        b.align_entry(&mut st, fn_align);
        if entry.nops_before + entry.nops_after > 0 {
            st.patchable_entries.push(super::EntryArea {
                func: st.func_ent_pcs.len(),
                start: st.code.len(),
            });
        }
        b.entry_nops(&mut st.code, entry.nops_before);
        st.pc_to_native[ent_pc] = st.code.len();
        st.func_ent_pcs.push(ent_pc);
        st.func_names.push(func_ssa.name.clone());
        // Pre-resolve every `imm_data_extern` and `tls_addr_extern` value id
        // to its symbol name once per function so the emit can tag the
        // matching fixup with the cross-TU name.
        let extern_data_names: alloc::collections::BTreeMap<u32, alloc::string::String> = func_ssa
            .extern_imm_data_refs
            .iter()
            .map(|(v, sym_idx)| (*v, program.symbols[*sym_idx as usize].link_name().into()))
            .collect();
        let extern_tls_names: alloc::collections::BTreeMap<u32, alloc::string::String> = func_ssa
            .extern_tls_refs
            .iter()
            .map(|(v, sym_idx)| (*v, program.symbols[*sym_idx as usize].link_name().into()))
            .collect();
        let inputs = FunctionInputs {
            program,
            extern_data_names: &extern_data_names,
            extern_tls_names: &extern_tls_names,
            variadic_targets: &variadic_targets,
            name2entpc: &name2entpc,
        };
        let lowered = b.emit_function(
            st.function_emit(),
            &inputs,
            func_ssa,
            alloc_for,
            target,
            &native,
            imports,
            entry,
        );
        #[cfg(feature = "std")]
        if super::dump::enabled(native) {
            b.dump_function(func_ssa, alloc_for, lowered.is_ok(), &mut ssa_dump);
        }
        if let Err(e) = lowered {
            return Err(unsupported_error(&e, B::ARCH, &func_ssa.name));
        }
        st.func_ends.push(st.code.len());
    }
    b.after_functions(&mut st, &native);
    #[cfg(feature = "std")]
    if time_passes_enabled() {
        let us = _ssa_emit_pass_start.elapsed().as_micros();
        eprintln!("pass: {} -- {us}us", B::WALK_PASS);
    }
    st.pc_to_native[pc_extent] = st.code.len();

    // Cross-TU user-function imports surfaced by the parser as placeholder
    // ent_pcs past `text.len()`. Each call emits a placeholder branch whose
    // `target_ent_pc` is the placeholder; we partition those out before the
    // fixup pass and re-emit them as `Build::user_extern_call_sites` entries
    // the writer surfaces as by-name call relocations.
    let extern_pc_lookup: alloc::collections::BTreeMap<usize, &str> = program
        .extern_function_imports
        .iter()
        .map(|(pc, name)| (*pc, name.as_str()))
        .collect();
    // Seeded with the inline-asm branch sites whose target this unit does
    // not define; they take the same by-name relocation.
    let mut user_extern_call_sites = core::mem::take(&mut st.asm_extern_call_sites);
    // A direct branch whose callee the linker resolves -- across a
    // named-section boundary, or to a weak definition a sibling unit
    // may override -- likewise becomes a by-name call relocation.
    let reloc_ctx =
        super::reloc_callee_ctx(program, &ssa_funcs, &st.pc_to_native, native.output_kind);
    let resolved_fixups: alloc::vec::Vec<B::Fixup> = {
        let fixups = b.take_fixups();
        let mut out = alloc::vec::Vec::with_capacity(fixups.len());
        for f in fixups {
            let instr_offset = B::fixup_native_offset(&f);
            let target_ent_pc = B::fixup_target_ent_pc(&f);
            let is_tail = B::fixup_is_tail(&f);
            if let Some(name) = extern_pc_lookup.get(&target_ent_pc) {
                user_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset,
                    symbol_name: (*name).into(),
                    is_tail,
                });
            } else if let Some(name) = reloc_ctx.reloc_callee(instr_offset, target_ent_pc) {
                user_extern_call_sites.push(super::UserExternCallSite {
                    instr_offset,
                    symbol_name: name.into(),
                    is_tail,
                });
            } else {
                out.push(f);
            }
        }
        out
    };
    B::apply_fixups(&mut st.code, &resolved_fixups, &st.pc_to_native, pc_extent)?;

    // Capture the import call sites before the PLT pass rewrites their
    // displacement fields. The `OutputKind::Relocatable` writer reads these
    // to emit a by-name call relocation against each import's external
    // symbol; final-image writers ignore the list and rely on the
    // trampolines below.
    let reloc_call_sites: alloc::vec::Vec<super::RelocCallSite> = st
        .plt_call_fixups
        .iter()
        .map(|f| super::RelocCallSite {
            instr_offset: f.instr_offset,
            import_index: f.import_index,
            is_tail: f.is_tail,
            is_addr: f.is_addr,
        })
        .collect();
    // Final-image output emits one PLT trampoline per import at the tail of
    // `.text` and rewrites every call placeholder to reach the matching
    // trampoline. Relocatable output leaves the placeholders raw so the
    // linker materialises the PLT pool when it produces the final image --
    // the matching reloc in `.rela.text` carries the site's import symbol.
    let plt_trampoline_offsets: alloc::vec::Vec<usize> =
        if native.output_kind != super::OutputKind::Relocatable {
            let offsets =
                B::emit_plt_trampolines(&mut st.code, &mut st.got_fixups, imports.imports.len());
            B::apply_plt_call_fixups(&mut st.code, &st.plt_call_fixups, &offsets)?;
            offsets
        } else {
            alloc::vec::Vec::new()
        };

    // Function-pointer fixups resolve to each callee's body offset directly:
    // every function's prologue already spills the host arg registers into
    // the c5 cdecl slots that the body reads through the address-of-local
    // path, so a host caller (`pthread_create`, `qsort`, a static dispatch
    // table, ...) can land on the body itself. Variadic c5 functions keep
    // the c5-stack-based ABI and reach only via indirect c5 callers that lay
    // args onto the c5 stack first; their fn-pointer fixups also land on the
    // body, which keeps that contract intact.
    let mut func_fixups: alloc::vec::Vec<super::FuncFixup> =
        alloc::vec::Vec::with_capacity(st.pending_func_fixups.len());
    for (instr_offset, target_ent_pc) in core::mem::take(&mut st.pending_func_fixups) {
        // Cross-TU target: the placeholder ent_pc has no entry in
        // `pc_to_native`. Route to the same named-symbol channel that data
        // extern refs use; the linker resolves the address pair to
        // `text_vaddr + target` via the data_abs_relocs Text-section path.
        if let Some(&name) = extern_pc_lookup.get(&target_ent_pc) {
            st.user_extern_data_refs.push(super::UserExternDataRef {
                instr_offset,
                symbol_name: (*name).into(),
                direct_pcrel: None,
            });
            continue;
        }
        if target_ent_pc > pc_extent {
            return Err(C5Error::internal(alloc::format!(
                "native codegen{tag}: function pointer target {target_ent_pc} past end of PC space",
                tag = B::ERR_TAG,
            )));
        }
        let target = st.pc_to_native[target_ent_pc];
        if target == usize::MAX {
            return Err(C5Error::internal(alloc::format!(
                "native codegen{tag}: function pointer target {target_ent_pc} did not land on an instruction",
                tag = B::ERR_TAG,
            )));
        }
        func_fixups.push(super::FuncFixup {
            instr_offset,
            target_native_offset: target,
            part: super::AddrPart::Whole,
        });
    }

    // Address-of-import sites (`&strcmp`, `Inst::ImmExtCode`) in the
    // local-image path resolve to the import's PLT trampoline, the same stub
    // a call to the import reaches. A `FuncFixup` routes the address pair
    // through the writer's func-fixup pass exactly like a function-pointer
    // literal. Relocatable output (empty `plt_trampoline_offsets`) emits the
    // reloc via `reloc_call_sites` instead.
    if native.output_kind != super::OutputKind::Relocatable {
        for fx in &st.plt_call_fixups {
            if fx.is_addr {
                func_fixups.push(super::FuncFixup {
                    instr_offset: fx.instr_offset,
                    target_native_offset: plt_trampoline_offsets[fx.import_index],
                    part: super::AddrPart::Whole,
                });
            }
        }
    }

    let entry_offset = if native.output_kind == super::OutputKind::Relocatable {
        // Relocatable objects carry no entry point; the linker picks it once
        // every TU is merged. `entry_pc` may legitimately be 0 here
        // (`--no-entry-point` / `-c` on a TU without `main`) and need not
        // land on a real instruction.
        st.pc_to_native
            .get(program.entry_pc)
            .copied()
            .filter(|&n| n != usize::MAX)
            .unwrap_or(0)
    } else {
        let off = B::entry_native_offset(&st.pc_to_native, program.entry_pc)?;
        if off == usize::MAX {
            return Err(C5Error::internal(alloc::format!(
                "native codegen{tag}: entry_pc {pc} did not align with any instruction start",
                tag = B::ERR_TAG,
                pc = program.entry_pc,
            )));
        }
        off
    };

    st.asm_sections
        .emit_cfi_sections(B::cfi_target(&native))
        .map_err(|m| C5Error::hard(Code::ASSEMBLER, alloc::format!("<file-scope asm>: {m}")))?;
    let (asm_section_list, asm_sym_decls) = st.asm_sections.into_parts();
    let mut build = super::Build {
        emitted_relocs: alloc::vec::Vec::new(),
        named_sections: alloc::vec::Vec::new(),
        // The GOT base is a cross-unit link fact; the single-TU emit
        // has no table to name.
        got_base_fixups: alloc::vec::Vec::new(),
        asm_sections: asm_section_list,
        asm_sym_decls,
        text_data_ranges: st.text_data_ranges,
        asm_section_text_refs: st.asm_section_text_refs,
        asm_text_abs_refs: alloc::vec::Vec::new(),
        asm_sym_fixups: st.asm_sym_fixups,
        asm_text_labels: st.asm_text_labels,
        copy_relocs: alloc::vec::Vec::new(),
        text: st.code,
        text_align: st.text_align,
        data: program.data.clone(),
        // Region boundaries the data compaction produced; zero when
        // the pass did not run (JIT, empty data).
        data_ro_len: program.data_ro_len.min(program.data.len()),
        data_relro_len: program
            .data_relro_len
            .clamp(program.data_ro_len, program.data.len()),
        data_align: program.data_align,
        bss_size: 0,
        init_fini_arrays: Default::default(),
        entry_offset,
        got_fixups: st.got_fixups,
        data_fixups: st.data_fixups,
        rodata: st.rodata,
        data_pcrel_relocs: alloc::vec::Vec::new(),
        text_pcrel_relocs: alloc::vec::Vec::new(),
        text_abs_relocs: alloc::vec::Vec::new(),
        func_fixups,
        pc_to_native: st.pc_to_native,
        func_ent_pcs: st.func_ent_pcs,
        func_ends: st.func_ends,
        patchable_entries: st.patchable_entries,
        mcount_sites: st.mcount_sites,
        func_names: st.func_names,
        func_prologue_native: st.func_prologue_native,
        promoted_local_slots,
        coalesced_slot_remap,
        canary_frame_bytes: st.canary_frame_bytes,
        fn_unwind: alloc::vec::Vec::new(),
        reloc_call_sites,
        user_extern_call_sites,
        user_extern_data_refs: st.user_extern_data_refs,
        ssa_line_rows: st.ssa_line_rows,
        // `imports` is set by `lower_for` after this returns; the
        // resolver runs once up there and the value is shared with
        // both the lowering and the writer. Default-empty here keeps
        // the per-arch lowering oblivious to the resolver.
        imports: super::ResolvedImports::default(),
        abi: super::Abi::default(),
        tls_data: program.tls_data.clone(),
        tls_init_size: program.tls_init_size,
        tls_index_fixups: st.tls_index_fixups,
        data_relocs: alloc::vec::Vec::new(),
        extern_data_relocs: alloc::vec::Vec::new(),
        code_relocs: alloc::vec::Vec::new(),
        tls_data_relocs: alloc::vec::Vec::new(),
        tls_extern_data_relocs: alloc::vec::Vec::new(),
        tls_code_relocs: alloc::vec::Vec::new(),
        label_relocs: st.label_relocs,
        exports: alloc::vec::Vec::new(),
        dynamic_exports: alloc::vec::Vec::new(),
        output_kind: super::OutputKind::Executable,
        pic_link: native.pic || native.pic_link,
        freestanding: false,

        code_model: native.code_model,
        elf_class: native.elf_class,
        keep_local_labels: native.keep_local_labels,
        shared_lib_name: None,
        dllmain_pc: None,
        macho_tlv_fixups: alloc::vec::Vec::new(),
        macho_tlv_descriptors: alloc::vec::Vec::new(),
        elf_tpoff_fixups: st.elf_tpoff_fixups,
        // Overwritten by `lower_for` from `NativeOptions::debug_info`.
        debug_info: true,
        merged_dwarf: None,
        // Every import on this single-TU path gets a trampoline (data
        // imports ride `ResolvedImports::data_bindings`, not `imports`).
        plt_trampoline_offsets: plt_trampoline_offsets.into_iter().map(Some).collect(),
        orphaned_data,
        stopped_at_data_liveness: false,
        ssa_dump,
    };
    b.install(&mut build);
    Ok(build)
}

/// Fold one `slot_coalesce` report into the debug-info location maps: a
/// slot moved to a new exclusive offset is remapped, one folded onto
/// shared storage loses its location.
fn record_coalesced_slots(
    report: super::slot_coalesce::CoalesceDwarf,
    remap: &mut alloc::collections::BTreeMap<usize, alloc::collections::BTreeMap<i64, i64>>,
    promoted: &mut alloc::collections::BTreeMap<usize, alloc::vec::Vec<i64>>,
) {
    for (ent_pc, map) in report {
        for (orig, new) in map {
            match new {
                Some(new) => {
                    remap.entry(ent_pc).or_default().insert(orig, new);
                }
                None => promoted.entry(ent_pc).or_default().push(orig),
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::{Unsupported, unsupported_error};

    /// `unsupported_error` reads only the `Unsupported` it is given, so the
    /// text below is what every feature configuration reports, `no_std`
    /// included.
    #[test]
    fn a_named_reason_reaches_the_diagnostic_verbatim() {
        let e = Unsupported::new("inline asm: unsupported instruction `Add`");
        assert_eq!(
            alloc::format!("{}", unsupported_error(&e, "x86_64", "main")),
            "error: inline asm: unsupported instruction `Add` (x86_64, function `main`) [B4001] [unsupported]"
        );
    }
}
