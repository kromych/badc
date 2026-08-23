//! Cross-target helpers for the SSA emit backends. Holds the
//! pieces of the per-arch lowering that are pure math or pure
//! formatting -- the shape that doesn't depend on a particular
//! ABI or instruction encoding -- so the per-arch modules
//! (`ssa_emit_x86_64.rs`, `ssa_emit_aarch64.rs`) don't carry
//! parallel copies.

use crate::c5::asm::*;
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

/// The accumulated inline-asm sections and the indexes that make a lookup
/// against them independent of how much the sink already holds. A unit's
/// file-scope asm can push a uniquely named section and a label per
/// exported symbol -- modpost's `.vmlinux.export.c` pushes tens of
/// thousands of both -- and every [`materialize_asm_sections`] call has to
/// resolve a section identity and the labels earlier calls defined, so
/// scanning the sink for either makes a unit quadratic in its own asm.
#[derive(Debug, Default)]
pub(crate) struct AsmSectionSink {
    sections: asm_sections::AsmSections,
    /// `(name, flags, sh_type)` identity -> index into `sections`.
    by_key: hashbrown::HashMap<alloc::string::String, usize>,
    /// Section name -> the identity keys carrying it, in push order. A
    /// name pushed under different attributes is several sections; the
    /// last one answers a lookup, as a walk of the sink would.
    by_name: AsmSinkSectionNames,
    /// Label name -> its section's identity key and its offset there.
    /// Carries only labels of completed calls: that is what a call's
    /// location expressions resolve against, its own coming from the
    /// measurement. Keyed by identity rather than index so a lookup stays
    /// disjoint from a mutable borrow of the section being laid out.
    labels: AsmSinkLabels,
    /// Per section, how many of its labels the binding counts below hold.
    /// A call's labels join them where it publishes them, so a rebinding
    /// under the mark adjusts the counts and one over it does not.
    published: alloc::vec::Vec<usize>,
    /// How many published labels and unit-level declarations bind each
    /// name global or weak, and how many bind it weak.
    non_local: AsmBindCounts,
    weak: AsmBindCounts,
    /// Unit-level symbol declarations the unit's templates made outside any
    /// section, merged by name. Applied by the object writer, which is where
    /// every definition the unit holds is known.
    sym_decls: alloc::vec::Vec<AsmSymDecl>,
    /// `.cfi_*` directives in the order the unit wrote them, each carrying
    /// the section and offset it reached. Turned into frame tables by
    /// [`Self::emit_cfi_sections`] once every section is laid out.
    cfi: alloc::vec::Vec<super::cfi::CfiRecord>,
}

/// Section name -> the identity keys the sink holds under it.
pub(crate) type AsmSinkSectionNames =
    hashbrown::HashMap<alloc::string::String, alloc::vec::Vec<alloc::string::String>>;

/// The key a bare section name stands for: the last section pushed under
/// it, as a walk of the sink would find.
pub(crate) fn sink_section_key<'a>(names: &'a AsmSinkSectionNames, name: &str) -> Option<&'a str> {
    names.get(name)?.last().map(alloc::string::String::as_str)
}

/// Label name -> (owning section's identity key, offset within it).
pub(crate) type AsmSinkLabels =
    hashbrown::HashMap<alloc::string::String, (alloc::string::String, i64)>;

/// The sink state an expression resolves a name against: the labels
/// earlier statements published and the sections the unit holds.
pub(crate) struct AsmSinkNames<'a> {
    labels: &'a AsmSinkLabels,
    sections: &'a AsmSinkSectionNames,
}

impl AsmSinkNames<'_> {
    fn label(&self, name: &str) -> Option<&(alloc::string::String, i64)> {
        self.labels.get(name)
    }

    fn section(&self, name: &str) -> Option<&str> {
        sink_section_key(self.sections, name)
    }
}

/// Name -> how many labels and declarations give it one binding. Shared:
/// a statement's binding tests read the counts as its materialization
/// found them, while the same materialization keeps adding to the sink's.
type AsmBindCounts = alloc::rc::Rc<hashbrown::HashMap<alloc::string::String, u32>>;

/// The sink's sections, behind an interface that records every walk of
/// them. Materialization resolves what it needs through the sink's
/// indexes, so the total stays linear in a unit's asm; the asymptotic test
/// reads it.
mod asm_sections {
    use super::AsmSection;

    #[derive(Debug, Default)]
    pub(crate) struct AsmSections {
        v: alloc::vec::Vec<AsmSection>,
        walked: core::cell::Cell<u64>,
    }

    impl AsmSections {
        pub(crate) fn len(&self) -> usize {
            self.v.len()
        }

        pub(crate) fn at(&self, i: usize) -> &AsmSection {
            &self.v[i]
        }

        pub(crate) fn at_mut(&mut self, i: usize) -> &mut AsmSection {
            &mut self.v[i]
        }

        pub(crate) fn push(&mut self, s: AsmSection) {
            self.v.push(s);
        }

        /// Every section, for a pass that has to walk them all.
        pub(crate) fn all(&self) -> &[AsmSection] {
            self.note();
            &self.v
        }

        pub(crate) fn all_mut(&mut self) -> &mut [AsmSection] {
            self.note();
            &mut self.v
        }

        pub(crate) fn drain_from(&mut self, n: usize) -> alloc::vec::Drain<'_, AsmSection> {
            self.note();
            self.v.drain(n..)
        }

        pub(crate) fn into_vec(self) -> alloc::vec::Vec<AsmSection> {
            self.v
        }

        #[cfg(test)]
        pub(crate) fn walked(&self) -> u64 {
            self.walked.get()
        }

        fn note(&self) {
            self.walked.set(self.walked.get() + self.v.len() as u64);
        }
    }
}

impl AsmSectionSink {
    /// Mutable access for the relocation-retarget passes. Section identity
    /// and the label lists are indexed, so a caller must not add, remove,
    /// or rename either through this.
    pub(crate) fn relocs_mut(&mut self) -> &mut [AsmSection] {
        self.sections.all_mut()
    }

    /// The accumulated sections and unit-level symbol declarations, for the
    /// object writers. The indexes serve materialization only and are
    /// dropped with the sink.
    pub(crate) fn into_parts(self) -> (alloc::vec::Vec<AsmSection>, alloc::vec::Vec<AsmSymDecl>) {
        (self.sections.into_vec(), self.sym_decls)
    }

    #[cfg(test)]
    pub(crate) fn len(&self) -> usize {
        self.sections.len()
    }

    pub(crate) fn section(&self, i: usize) -> &AsmSection {
        self.sections.at(i)
    }

    #[cfg(test)]
    pub(crate) fn sections(&self) -> &[AsmSection] {
        self.sections.all()
    }

    /// Sections walked, read by the test that locks the per-statement cost
    /// of materialization to a constant.
    #[cfg(test)]
    pub(crate) fn walked(&self) -> u64 {
        self.sections.walked()
    }

    pub(crate) fn section_names(&self) -> &AsmSinkSectionNames {
        &self.by_name
    }

    /// The counts as they stand, for a statement to test its names against.
    fn bind_counts(&self, weak_only: bool) -> AsmBindCounts {
        if weak_only {
            self.weak.clone()
        } else {
            self.non_local.clone()
        }
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
            self.push_section(s);
        }
        Ok(())
    }

    fn push_section(&mut self, s: AsmSection) -> usize {
        let i = self.sections.len();
        let key = section_key_of(&s);
        self.by_name
            .entry_ref(s.name.as_str())
            .or_default()
            .push(key.clone());
        self.by_key.insert(key, i);
        self.published.push(0);
        self.sections.push(s);
        i
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
                    Some(AsmSymValue::Sym(target.clone(), 0)),
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
            let di = match self.sym_decls.iter().position(|d| d.name == *name) {
                Some(i) => i,
                None => {
                    self.sym_decls.push(AsmSymDecl {
                        name: name.clone(),
                        ..Default::default()
                    });
                    self.sym_decls.len() - 1
                }
            };
            if bind != AsmSymBind::Default {
                let was = core::mem::replace(&mut self.sym_decls[di].bind, bind);
                count_bind(&mut self.non_local, &mut self.weak, name, was, false);
                count_bind(&mut self.non_local, &mut self.weak, name, bind, true);
            }
            let d = &mut self.sym_decls[di];
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
        if let Some(&i) = self.by_key.get(&section_key(b)) {
            return i;
        }
        self.push_section(AsmSection {
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
        })
    }

    /// Publish the labels section `sec_idx` gained past `from`, so the next
    /// call resolves them and their bindings answer a binding test. Runs
    /// once a call's pending entries are settled.
    fn publish_labels(&mut self, sec_idx: usize, from: usize) {
        let sec = self.sections.at(sec_idx);
        let key = section_key_of(sec);
        // The counts cover every label under the mark, the label index
        // what this call added; the two agree except where a `.set` wrote
        // into a section the call did not otherwise touch.
        let counted = self.published[sec_idx];
        for i in counted.min(from)..sec.labels.len() {
            let l = &sec.labels[i];
            if i >= counted {
                count_label_bind(&mut self.non_local, &mut self.weak, l, true);
            }
            if i >= from {
                self.labels
                    .insert(l.name.clone(), (key.clone(), l.offset as i64));
            }
        }
        self.published[sec_idx] = sec.labels.len();
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
                .all()
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
            for d in &self.sym_decls {
                count_bind(&mut self.non_local, &mut self.weak, &d.name, d.bind, false);
            }
            self.sym_decls.clone_from(&snap.decls);
            for d in &self.sym_decls {
                count_bind(&mut self.non_local, &mut self.weak, &d.name, d.bind, true);
            }
        }
        self.cfi.truncate(snap.cfi.min(self.cfi.len()));
        let keep = snap.len.min(self.sections.len());
        for (i, s) in self.sections.drain_from(keep).enumerate() {
            let key = section_key_of(&s);
            if let Some(v) = self.by_name.get_mut(&s.name)
                && let Some(at) = v.iter().rposition(|k| *k == key)
            {
                v.remove(at);
            }
            self.by_key.remove(&key);
            for (li, l) in s.labels.iter().enumerate() {
                if li < self.published[keep + i] {
                    count_label_bind(&mut self.non_local, &mut self.weak, l, false);
                }
                self.labels.remove(&l.name);
            }
        }
        self.published.truncate(keep);
        for (i, (s, &(bytes, relocs, labels, align, after_insn, map_state))) in self
            .sections
            .all_mut()
            .iter_mut()
            .zip(&snap.per_section)
            .enumerate()
        {
            s.bytes.truncate(bytes);
            s.map.truncate(bytes);
            s.relocs.truncate(relocs);
            for (li, l) in s.labels.drain(labels.min(s.labels.len())..).enumerate() {
                if labels + li < self.published[i] {
                    count_label_bind(&mut self.non_local, &mut self.weak, &l, false);
                }
                self.labels.remove(&l.name);
            }
            self.published[i] = self.published[i].min(s.labels.len());
            s.align = align;
            s.after_insn = after_insn;
            s.map_state = map_state;
        }
    }
}

/// Move a declaration's binding into or out of the sink's counts.
fn count_bind(
    non_local: &mut AsmBindCounts,
    weak: &mut AsmBindCounts,
    name: &str,
    bind: AsmSymBind,
    add: bool,
) {
    match bind {
        AsmSymBind::Global => count_name(alloc::rc::Rc::make_mut(non_local), name, add),
        AsmSymBind::Weak => {
            count_name(alloc::rc::Rc::make_mut(non_local), name, add);
            count_name(alloc::rc::Rc::make_mut(weak), name, add);
        }
        _ => {}
    }
}

/// The same for a section label's binding.
fn count_label_bind(
    non_local: &mut AsmBindCounts,
    weak: &mut AsmBindCounts,
    l: &AsmSectionLabel,
    add: bool,
) {
    if l.global || l.weak {
        count_name(alloc::rc::Rc::make_mut(non_local), &l.name, add);
    }
    if l.weak {
        count_name(alloc::rc::Rc::make_mut(weak), &l.name, add);
    }
}

fn count_name(counts: &mut hashbrown::HashMap<alloc::string::String, u32>, name: &str, add: bool) {
    if add {
        *counts.entry_ref(name).or_insert(0) += 1;
    } else if let Some(c) = counts.get_mut(name) {
        *c -= 1;
        if *c == 0 {
            counts.remove(name);
        }
    }
}

/// Rewrite a label's binding and keep the sink's counts in step. A label
/// the call has not published carries no count yet; publishing takes its
/// final binding.
fn rebind_label(
    l: &mut AsmSectionLabel,
    counted: bool,
    non_local: &mut AsmBindCounts,
    weak: &mut AsmBindCounts,
    f: impl FnOnce(&mut AsmSectionLabel),
) {
    if counted {
        count_label_bind(non_local, weak, l, false);
    }
    f(l);
    if counted {
        count_label_bind(non_local, weak, l, true);
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
        // selectors admit no more than the encoder's table does. `.loc`
        // names a source location for the debug line table, which badc
        // does not emit for asm bodies.
        ".extern" | ".arch" | ".arch_extension" | ".cpu" | ".ltorg" | ".loc" => {
            Ok(AsmSectionItem::Bytes(alloc::vec::Vec::new()))
        }
        // `.file "name"` names the unit's STT_FILE symbol; the numbered
        // DWARF form is line-table input like `.loc` and deposits nothing.
        ".file" => {
            if rest.trim_start().starts_with('"') {
                Ok(AsmSectionItem::File(parse_quoted_text(tok, rest)?))
            } else {
                Ok(AsmSectionItem::Bytes(alloc::vec::Vec::new()))
            }
        }
        ".ident" => Ok(AsmSectionItem::Ident(parse_quoted_text(tok, rest)?)),
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
/// The text of a directive taking one quoted string (`.file`, `.ident`),
/// with GNU as escape processing.
fn parse_quoted_text(
    tok: &str,
    rest: &str,
) -> Result<alloc::string::String, alloc::string::String> {
    match parse_string_directive(".ascii", rest) {
        Ok(AsmSectionItem::Bytes(b)) => Ok(alloc::string::String::from_utf8_lossy(&b).into_owned()),
        Ok(_) => unreachable!(),
        Err(_) => Err(alloc::format!("inline asm: bad `{tok}` operand `{rest}`")),
    }
}

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
pub(crate) fn value_fits_width(v: i64, width: u8) -> bool {
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
        K::F32 | K::F64 | K::F80 | K::F128 => return None,
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
                                StoreKind::F32
                                | StoreKind::F64
                                | StoreKind::F80
                                | StoreKind::F128 => return None,
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
/// sections the sink already holds, answered through the sink's name index
/// rather than by deriving a map per call.
struct SectionNames<'a> {
    blocks: &'a [AsmSectionBlock],
    sink: &'a AsmSectionSink,
}

impl SectionNames<'_> {
    /// The key of the section `name` stands for, the sink's answer winning
    /// over a block of the same name.
    fn get(&self, name: &str) -> Option<alloc::string::String> {
        sink_section_key(self.sink.section_names(), name)
            .map(alloc::string::String::from)
            .or_else(|| {
                self.blocks
                    .iter()
                    .rev()
                    .find(|b| b.name == name)
                    .map(section_key)
            })
    }
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
    sections: &SectionNames<'_>,
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
                    None => return sections.get(t).map(|sk| section_start_leaf(&sk)),
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
        // `.set x, sym + k` over a name this unit's layout does not define:
        // the name is an alias of `sym` at that offset, which the object
        // writer places against the definition wherever it lands.
        (
            Some(AsmExprTerm {
                space: None,
                target: AsmSectionTarget::Symbol(_),
            }),
            None,
        ) => Ok(SectionSetValue::Alias),
        _ => Err(alloc::format!(
            "inline asm: `.set {name}, {expr}` is not an absolute value or a location"
        )),
    }
}

/// A `.set` assignment's value: an absolute constant, a location of a
/// section of this unit, or a symbol the unit's layout does not place.
enum SectionSetValue {
    Abs(i64),
    Loc(alloc::string::String, i64),
    Alias,
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
    let (labels, sections) = (AsmSinkLabels::new(), AsmSinkSectionNames::new());
    let sink_labels = AsmSinkNames {
        labels: &labels,
        sections: &sections,
    };
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
    sink_labels: &AsmSinkNames<'_>,
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
    sink_labels
        .section(cur)
        .or_else(|| measured.section_named(cur))
        .map(section_start_leaf)
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
    sink_labels: &AsmSinkNames<'_>,
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
        && let Some((sk, off)) = sink_labels.label(t)
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

/// GNU as fixes a non-branch operand field's width when it parses the
/// instruction: the expression narrows only when it is a constant at that
/// point, which a difference of already-defined labels is exactly when the
/// items between them have parse-time fixed sizes. This context follows a
/// statement's blocks in source order, numbering each run of fixed-size
/// items and recording where every name is defined, so the arch encoder can
/// fold such an expression to its value before it chooses the encoding. A
/// branch carrying a short alternative, an alignment, an `.org`, and a fill
/// whose count does not fold end the run: a difference across one has a
/// layout-dependent value, and GNU as keeps the wide field there even when
/// the final layout would fit the narrow one.
///
/// The walk goes block by block, which within one chain is source order.
/// Across chains the blocks do not record how the source interleaved them,
/// so a reference to a label of another chain folds only when that chain
/// was walked already; where GNU as saw the definition earlier in the
/// source, the field stays wide. The value of every fold is exact -- a run
/// has one size in every layout -- so the boundary costs width only.
#[derive(Default)]
pub(crate) struct AsmParseFold {
    /// `(section key, subsection)` -> the chain's current run and offset.
    /// A chain re-entered after other sections continues where it left off.
    chains: alloc::collections::BTreeMap<(alloc::string::String, u32), (u32, i64)>,
    cur: (alloc::string::String, u32),
    runs: u32,
    names: alloc::collections::BTreeMap<alloc::string::String, AsmFoldDef>,
    /// Numeric label digits -> latest definition, for `Nb` references.
    numeric: alloc::collections::BTreeMap<alloc::string::String, (u32, i64)>,
}

/// What a name means to the fold: a location in a run, an absolute value,
/// or a definition it cannot value (which shadows an earlier one).
enum AsmFoldDef {
    Loc(u32, i64),
    Abs(i64),
    Opaque,
}

impl AsmParseFold {
    /// Continue (or open) the chain of `block`'s section and subsection.
    pub(crate) fn enter_block(&mut self, block: &AsmSectionBlock) {
        let key = (section_key(block), block.subsection);
        if !self.chains.contains_key(&key) {
            let id = self.next_run();
            self.chains.insert(key.clone(), (id, 0));
        }
        self.cur = key;
    }

    fn next_run(&mut self) -> u32 {
        self.runs += 1;
        self.runs
    }

    fn here(&self) -> Option<(u32, i64)> {
        self.chains.get(&self.cur).copied()
    }

    /// End the current run: what follows sits a layout-dependent distance
    /// from everything before this point.
    fn break_run(&mut self) {
        let id = self.next_run();
        if let Some(c) = self.chains.get_mut(&self.cur) {
            *c = (id, 0);
        }
    }

    fn advance(&mut self, n: i64) {
        if let Some(c) = self.chains.get_mut(&self.cur) {
            c.1 += n;
        }
    }

    /// The leaf a name means at this point of the walk: the location
    /// counter, a numeric `Nb` reference, or a recorded definition. `None`
    /// leaves the name symbolic, which keeps its expression out of the fold;
    /// a name an earlier statement of the unit defined stays symbolic too,
    /// as the distance to it spans items this walk never saw.
    fn leaf(&self, t: &str) -> Option<AsmExprLeaf> {
        let loc = |(run, off): (u32, i64)| {
            AsmExprLeaf::Loc(AsmExprTerm {
                space: Some((AsmSpace::Frag(run), off)),
                target: AsmSectionTarget::Symbol(alloc::string::String::from(t)),
            })
        };
        if t == "." {
            return self.here().map(loc);
        }
        if let Some(d) = numeric_label_digits(t) {
            if d.len() == t.len() || t.ends_with('f') {
                return None;
            }
            return self.numeric.get(d).copied().map(loc);
        }
        match self.names.get(t)? {
            AsmFoldDef::Loc(run, off) => Some(loc((*run, *off))),
            AsmFoldDef::Abs(v) => Some(AsmExprLeaf::Abs(*v)),
            AsmFoldDef::Opaque => None,
        }
    }

    /// The expression's value when it is a constant at this point of the
    /// parse, which is when GNU as folds it into the operand.
    pub(crate) fn fold(&self, expr: &str, const_of: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
        let ctx = AsmExprCtx {
            resolve: &|t| self.leaf(t),
            const_of,
            lax_div: false,
        };
        eval_asm_value(expr, &ctx).ok().and_then(|v| v.to_abs())
    }

    /// Record `item`'s effect on the walk: a definition, a fixed-size
    /// advance, or the end of the current run.
    pub(crate) fn note_item(
        &mut self,
        item: &AsmSectionItem,
        const_of: &dyn Fn(u8) -> Option<i64>,
    ) {
        match item {
            AsmSectionItem::Label(name) => {
                let Some(here) = self.here() else { return };
                match numeric_label_digits(name) {
                    Some(d) if d.len() == name.len() => {
                        self.numeric.insert(alloc::string::String::from(d), here);
                    }
                    _ => {
                        self.names
                            .insert(name.clone(), AsmFoldDef::Loc(here.0, here.1));
                    }
                }
            }
            AsmSectionItem::Data { width, values } => {
                self.advance(*width as i64 * values.len() as i64)
            }
            AsmSectionItem::Bytes(b) => self.advance(b.len() as i64),
            AsmSectionItem::Fill { count, unit, .. } => match self.fold(count, const_of) {
                Some(n) => self.advance(n.max(0) * *unit as i64),
                None => self.break_run(),
            },
            AsmSectionItem::CodeBytes {
                bytes, short: None, ..
            } => self.advance(bytes.len() as i64),
            AsmSectionItem::SymSet { name, target } => {
                let def = match self.leaf(target) {
                    Some(AsmExprLeaf::Loc(AsmExprTerm {
                        space: Some((AsmSpace::Frag(r), off)),
                        ..
                    })) => AsmFoldDef::Loc(r, off),
                    Some(AsmExprLeaf::Abs(v)) => AsmFoldDef::Abs(v),
                    _ => AsmFoldDef::Opaque,
                };
                self.names.insert(name.clone(), def);
            }
            AsmSectionItem::SetExpr { name, expr } => {
                let ctx = AsmExprCtx {
                    resolve: &|t| self.leaf(t),
                    const_of,
                    lax_div: false,
                };
                let def = match eval_asm_value(expr, &ctx) {
                    Ok(v) => fold_def_of(v),
                    Err(_) => AsmFoldDef::Opaque,
                };
                self.names.insert(name.clone(), def);
            }
            AsmSectionItem::AbsSet { name, value } => {
                self.names.insert(name.clone(), AsmFoldDef::Abs(*value));
            }
            // Symbol attributes and deferred diagnostics deposit no bytes.
            AsmSectionItem::Global(_)
            | AsmSectionItem::Local(_)
            | AsmSectionItem::Weak(_)
            | AsmSectionItem::Visibility { .. }
            | AsmSectionItem::Type { .. }
            | AsmSectionItem::Size { .. }
            | AsmSectionItem::CondDiag(_)
            | AsmSectionItem::Cfi(_)
            | AsmSectionItem::File(_)
            | AsmSectionItem::Ident(_)
            | AsmSectionItem::Reloc { .. } => {}
            // A branch both of whose widths ride into the layout, an
            // alignment, an `.org`, a deferred repeat, a literal pool, or
            // unencoded text: the layout owns the size.
            _ => self.break_run(),
        }
    }
}

/// The definition a `.set` expression value records: a constant, a location
/// offset into a run, or neither.
fn fold_def_of(v: AsmExprValue) -> AsmFoldDef {
    if let Some(c) = v.to_abs() {
        return AsmFoldDef::Abs(c);
    }
    match (&v.pos, &v.neg) {
        (
            Some(AsmExprTerm {
                space: Some((AsmSpace::Frag(r), off)),
                ..
            }),
            None,
        ) => AsmFoldDef::Loc(*r, off + v.add),
        _ => AsmFoldDef::Opaque,
    }
}

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

/// Whether the site's short branch reaches its target under `m`. Only a
/// target the materializer resolves in place qualifies; any other keeps a
/// relocation, which the link fills at the long form's width.
fn short_form_fits(
    blocks: &[AsmSectionBlock],
    m: &SectionLabelOffsets,
    rebindable: &AsmBindingNames<'_>,
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
        // A branch to an expression reaches where the materializer folds it
        // to a constant; a symbol left in the value keeps its relocation.
        // The main stream's labels are not laid out yet, so a target naming
        // one takes the long form.
        AsmSectionTarget::Expr(text) => {
            let num_unique = alloc::collections::BTreeMap::new();
            let sink_names = AsmSinkNames {
                labels: &sink.labels,
                sections: sink.section_names(),
            };
            let resolve =
                |t: &str| section_expr_leaf(t, &key, s.at, m, &sink_names, &num_unique, &|_| None);
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
                true,
                rebindable,
            );
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
pub(crate) fn asm_weak_only_names<'a>(
    blocks: &'a [AsmSectionBlock],
    sink: &AsmSectionSink,
) -> AsmBindingNames<'a> {
    AsmBindingNames {
        stmt: stmt_binding_names(blocks, false),
        counts: sink.bind_counts(true),
    }
}

/// A binding test over the statement's own directives and the counts the
/// sink keeps for what earlier statements bound.
pub(crate) struct AsmBindingNames<'a> {
    stmt: alloc::collections::BTreeSet<&'a str>,
    counts: AsmBindCounts,
}

impl AsmBindingNames<'_> {
    pub(crate) fn contains(&self, name: &str) -> bool {
        self.stmt.contains(name) || self.counts.contains_key(name)
    }
}

/// The names a statement's own `.weak` -- and, with `global`, `.globl` --
/// directives bind.
fn stmt_binding_names(
    blocks: &[AsmSectionBlock],
    global: bool,
) -> alloc::collections::BTreeSet<&str> {
    blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::Weak(n) => Some(n.as_str()),
            AsmSectionItem::Global(n) if global => Some(n.as_str()),
            _ => None,
        })
        .collect()
}

/// Names the unit binds global or weak, from the blocks and from what
/// earlier statements recorded (a `.globl` / `.weak` may follow the
/// reference). A reference to one keeps its relocation so the link binds
/// the winning definition; only a local name resolves in place, as GNU
/// as resolves it.
fn asm_non_local_names<'a>(
    blocks: &'a [AsmSectionBlock],
    sink: &AsmSectionSink,
) -> AsmBindingNames<'a> {
    AsmBindingNames {
        stmt: stmt_binding_names(blocks, true),
        counts: sink.bind_counts(false),
    }
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
        let mut at = *lens.entry(key.clone()).or_insert_with(|| {
            sink.index_of(b)
                .map_or(0, |i| sink.section(i).bytes.len() as i64)
        });
        let mut state = *states
            .entry(key.clone())
            .or_insert_with(|| sink.index_of(b).and_then(|i| sink.section(i).map_state));
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
                | AsmSectionItem::File(_)
                | AsmSectionItem::Ident(_)
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
    let sections = SectionNames { blocks, sink };
    let block_sections: alloc::collections::BTreeMap<alloc::string::String, alloc::string::String> =
        blocks
            .iter()
            .map(|b| (b.name.clone(), section_key(b)))
            .collect();
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
            // The maps are read by every later expression, so a reassigned
            // name keeps only its last value's kind.
            Ok(SectionSetValue::Abs(v)) => {
                syms.insert(name.clone(), v);
                map.remove(name);
            }
            Ok(SectionSetValue::Loc(sk, off)) => {
                map.insert(name.clone(), (sk, off));
                syms.remove(name);
            }
            // Placed by the object writer against the target's definition,
            // so the layout records no value for it.
            Ok(SectionSetValue::Alias) => {
                map.remove(name);
                syms.remove(name);
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
        sections: block_sections,
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
            labels,
            by_name,
            cfi: sink_cfi,
            published,
            non_local: sink_non_local,
            weak: sink_weak,
            ..
        } = &mut *sink;
        let sink_labels = &AsmSinkNames {
            labels,
            sections: by_name,
        };
        if !touched.iter().any(|&(i, _)| i == sec_idx) {
            touched.push((sec_idx, sections.at(sec_idx).labels.len()));
        }
        // Labels of earlier calls, which a rebinding here has to move in
        // the sink's binding counts; this call's are counted when the call
        // publishes them.
        let counted = published[sec_idx];
        let block_key = section_key(b);
        let sec = sections.at_mut(sec_idx);
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
                    // Only this call's entries can be pending; a definition
                    // an earlier call made in this section is a duplicate,
                    // which the label index answers without a walk.
                    match sec.labels[counted..].iter_mut().find(|l| l.name == *name) {
                        // A pending `.globl` entry is the definition site.
                        Some(l) if l.offset == PENDING_LABEL => l.offset = at,
                        Some(_) => {
                            return Err(alloc::format!(
                                "inline asm: duplicate label `{name}` in a named section"
                            ));
                        }
                        None if sink_labels
                            .label(name)
                            .is_some_and(|(k, _)| *k == block_key) =>
                        {
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
                // Unit-level records: the file-scope parse collects them.
                AsmSectionItem::File(_) | AsmSectionItem::Ident(_) => {}
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
                    match sec
                        .labels
                        .iter_mut()
                        .enumerate()
                        .find(|(_, l)| l.name == *name)
                    {
                        Some((i, l)) => {
                            rebind_label(l, i < counted, sink_non_local, sink_weak, |l| {
                                l.global = false
                            })
                        }
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
                    match sec
                        .labels
                        .iter_mut()
                        .enumerate()
                        .find(|(_, l)| l.name == *name)
                    {
                        // `.globl` may precede its label; record the pending name
                        // as a zero-length forward entry the definition fills in.
                        Some((i, l)) => {
                            rebind_label(l, i < counted, sink_non_local, sink_weak, |l| {
                                l.global = true
                            })
                        }
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
        let AsmSectionSink {
            sections,
            published,
            non_local,
            weak,
            ..
        } = &mut *sink;
        for (si, s) in sections.all_mut().iter_mut().enumerate() {
            for (i, l) in s
                .labels
                .iter_mut()
                .enumerate()
                .filter(|(_, l)| l.name == *name)
            {
                rebind_label(l, i < published[si], non_local, weak, |l| l.weak = true);
            }
        }
    }
    // The same for `.globl`, whose declaration and definition need not share
    // a section: the kernel's `vdso-wrap.S` declares in the default section
    // and defines in `.rodata`. The per-section pass above already bound the
    // same-section case; this reaches the rest.
    for name in &global_names {
        let AsmSectionSink {
            sections,
            published,
            non_local,
            weak,
            ..
        } = &mut *sink;
        for (si, s) in sections.all_mut().iter_mut().enumerate() {
            for (i, l) in s
                .labels
                .iter_mut()
                .enumerate()
                .filter(|(_, l)| l.name == *name && l.offset != PENDING_LABEL)
            {
                rebind_label(l, i < published[si], non_local, weak, |l| l.global = true);
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
    // A `.set` whose value reduced to a location defines the name as a
    // label of the owning section, as GNU as does, so a field referencing
    // it relocates against a definition.
    for name in blocks
        .iter()
        .flat_map(|b| &b.items)
        .filter_map(|it| match it {
            AsmSectionItem::SetExpr { name, .. } => Some(name.as_str()),
            _ => None,
        })
    {
        let (Some(sk), Some(off)) = (measured.section(name), measured.offset(name)) else {
            continue;
        };
        let Some(&si) = sink.by_key.get(sk as &str) else {
            continue;
        };
        let s = sink.sections.at_mut(si);
        if !s.labels.iter().any(|l| l.name == name) {
            s.labels.push(AsmSectionLabel {
                name: alloc::string::String::from(name),
                offset: off as u32,
                global: false,
                weak: false,
                sym_type: AsmSymType::NoType,
                size: None,
                absolute: None,
            });
        }
    }
    for &(sec_idx, from) in &touched {
        let s = sink.sections.at_mut(sec_idx);
        if let Some(l) = s.labels[from..].iter().find(|l| {
            l.offset == PENDING_LABEL
                && (l.sym_type != AsmSymType::NoType || l.size.is_some())
                && !aliased.contains(l.name.as_str())
        }) {
            return Err(alloc::format!(
                "inline asm: `.type`/`.size` names undefined label `{}`",
                l.name
            ));
        }
        let mut keep = from;
        for i in from..s.labels.len() {
            if s.labels[i].offset != PENDING_LABEL {
                s.labels.swap(keep, i);
                keep += 1;
            }
        }
        s.labels.truncate(keep);
    }
    for &(sec_idx, from) in &touched {
        sink.publish_labels(sec_idx, from);
    }
    Ok(defined)
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
            .sections()
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
            .sections()
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
        let s = sink.section(0);
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
            sink.section(0).bytes.clone()
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
                    .as_chunks::<{ A64_NOP.len() }>()
                    .0
                    .iter()
                    .all(|c| c == &A64_NOP),
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
        assert_eq!(sink.section(0).bytes, want);
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
        assert_eq!(sink.section(0).bytes, want);
        assert_eq!(
            sink.section(0).relocs,
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
        assert_eq!(sink.section(0).bytes.len(), 5); // 3 bytes, 1 pad, 1 byte
        let f = sink
            .section(0)
            .labels
            .iter()
            .find(|l| l.name == "f")
            .unwrap();
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
        assert_eq!(sink.section(0).bytes, alloc::vec![0x25, 0x80]);
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
            sink.section(0).relocs,
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
        assert_eq!(sink.section(0).relocs[0].width, 4);
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
        let s = sink.section(0);
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
        let entry = sink
            .sections()
            .iter()
            .find(|s| s.name == ".altinstructions")
            .unwrap();
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
            sink.section(0).relocs[0].target,
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
        assert_eq!(sink.section(0).bytes.len(), 8);
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
            Ok(sink.section(0).align)
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
        let s = sink.section(0);
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
        let l = &sink.section(0).labels[0];
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
        assert_eq!(sink.section(0).labels[0].sym_type, AsmSymType::Object);
        assert_eq!(sink.section(0).labels[0].size, Some(8));
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
        let s = sink.section(0);
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

    /// The export-table shape modpost generates: one file-scope template
    /// per exported symbol, pushing a section every symbol shares and a
    /// section named after the symbol.
    fn export_table_templates(n: usize) -> alloc::vec::Vec<alloc::string::String> {
        (0..n)
            .map(|i| {
                alloc::format!(
                    "\t.section \"__ksymtab_strings\",\"aMS\",%progbits,1\n\
                     __kstrtab_s{i}:\n\t.asciz \"s{i}\"\n\t.previous\n\
                     \t.section \"___ksymtab+s{i}\", \"a\"\n\t.balign 4\n\
                     __ksymtab_s{i}:\n\t.long s{i}- .\n\t.long __kstrtab_s{i}- .\n\
                     \t.previous\n"
                )
            })
            .collect()
    }

    /// A unit carries tens of thousands of export-table templates, so the
    /// per-call lookups against the accumulated sink -- the section
    /// identity, its name, the labels earlier templates defined and the
    /// bindings they carry -- have to be indexed. What each lookup answers
    /// is asserted here; that none of them walks the sink is
    /// [`file_scope_asm_sink_walks_stay_linear`].
    #[test]
    fn file_scope_asm_sink_lookups_are_indexed() {
        const N: usize = 4000;
        let templates = export_table_templates(N);
        let mut sink = AsmSectionSink::default();
        materialize_file_asm(&templates, true, AsmComments::A64, &|_| Ok(()), &mut sink).unwrap();
        // One shared strings section plus one per symbol.
        assert_eq!(sink.len(), N + 1);
        let strs = sink
            .sections()
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
            .sections()
            .iter()
            .find(|s| s.name == "___ksymtab+s3999")
            .expect("the last symbol's section");
        assert_eq!(sec.bytes.len(), 8);
        assert_eq!(sec.labels.len(), 1);
        assert_eq!(sec.relocs.len(), 2);
    }

    /// The same shape at two sizes, measured in sections walked rather than
    /// in time, so the result does not depend on the host. Materialization
    /// resolves through the sink's indexes and walks nothing per statement;
    /// the only walk here is the one an object writer makes of the finished
    /// sink. A lookup that derives state over the whole sink per statement
    /// squares this, which a content assertion cannot see.
    #[test]
    fn file_scope_asm_sink_walks_stay_linear() {
        const N: usize = 1000;
        let walks = |n: usize| -> u64 {
            let mut sink = AsmSectionSink::default();
            materialize_file_asm(
                &export_table_templates(n),
                true,
                AsmComments::A64,
                &|_| Ok(()),
                &mut sink,
            )
            .unwrap();
            let _ = sink.sections();
            sink.walked()
        };
        let (small, large) = (walks(N), walks(2 * N));
        assert!(
            small <= 4 * N as u64 && large <= 8 * N as u64,
            "sink walks: {small} over {N} statements, {large} over {}",
            2 * N
        );
        assert!(
            large <= 3 * small,
            "doubling the statements multiplied the walks by {}",
            large as f64 / small as f64
        );
    }

    /// A second definition of a name in a section an earlier template
    /// pushed is a duplicate, which the sink's label index answers.
    #[test]
    fn duplicate_section_label_across_templates_is_rejected() {
        let text =
            alloc::string::String::from("\t.section \"t\",\"a\"\ndup:\n\t.quad 0\n\t.previous\n");
        let mut sink = AsmSectionSink::default();
        let mat = |sink: &mut AsmSectionSink| {
            materialize_file_asm(
                core::slice::from_ref(&text),
                true,
                AsmComments::A64,
                &|_| Ok(()),
                sink,
            )
        };
        mat(&mut sink).unwrap();
        let err = mat(&mut sink).expect_err("the name is already defined there");
        assert!(err.contains("duplicate label"), "{err}");
    }

    /// A bare section name is that section's start whichever template
    /// pushed the section, so a difference to a label of it folds; the
    /// sink's name index answers where the section came from.
    #[test]
    fn section_name_resolves_across_templates() {
        let templates = alloc::vec![
            alloc::string::String::from("\t.section \"t\",\"a\"\n\t.quad 0\nfirst:\n\t.previous\n"),
            alloc::string::String::from("\t.section \"u\",\"a\"\n\t.quad first - t\n\t.previous\n"),
        ];
        let mut sink = AsmSectionSink::default();
        materialize_file_asm(&templates, true, AsmComments::A64, &|_| Ok(()), &mut sink).unwrap();
        let u = sink
            .sections()
            .iter()
            .find(|s| s.name == "u")
            .expect("the second template's section");
        assert_eq!(u.bytes, 8u64.to_le_bytes(), "`first - t` is the offset");
        assert!(u.relocs.is_empty(), "an absolute value keeps no relocation");
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
            s.sections()
                .iter()
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
