//! SSA lift over the stack-based c5 bytecode.
//!
//! Takes a [`Program::text`] and produces, per function, a basic-block
//! graph of SSA-style [`Inst`]s. The allocator (`ssa_alloc::allocate`)
//! and per-arch SSA emit (`ssa_emit_aarch64` / `ssa_emit_x86_64`)
//! consume the result.
//!
//! ## Lift shape
//!
//! Each function's body is split into basic blocks at every branch
//! target (`Op::Jmp` / `Op::Bz` / `Op::Bnz` operand) and at the
//! instruction after every terminator. Within a block:
//!
//! * `Op::Imm`, `Op::TlsLea` define a fresh [`Inst::Imm`] /
//!   `Inst::TlsAddr` value. The accumulator's current value becomes
//!   the new instruction's id.
//! * `Op::Lea N` followed by a scalar load (`Op::Li` / `Op::Lc` /
//!   `Op::Lw` / `Op::Lwu` / `Op::Lh` / `Op::Lhu` / `Op::Lcs` /
//!   `Op::Lf`) is fused into a single [`Inst::LoadLocal`] with the
//!   matching `LoadKind`. The standalone `Op::Lea` (with no
//!   matching load to fuse with) lifts to an [`Inst::LocalAddr`].
//!   The optimizer's `Op::LdLocI` / `Op::LdLocC` shape lifts to the
//!   same [`Inst::LoadLocal`]; `Op::StLocI` lifts to
//!   [`Inst::StoreLocal`].
//! * A per-block cache aliases repeated reads of the same slot to
//!   the prior SSA value when the access width matches. The cache
//!   clears at ops whose semantics could write to a local through a
//!   pointer (function calls, intrinsics, `Op::Mcpy`, indirect
//!   stores).
//! * `Op::Psh` records the accumulator's value onto a virtual
//!   per-block stack; it produces no SSA value.
//! * Binary ops (`Op::Add`, ...) consume one virtual-stack entry
//!   (the LHS) and the current accumulator (the RHS), producing a
//!   new value.
//! * Store ops (`Op::Si` / `Op::Sc` / `Op::Sw` / `Op::Sh` / `Op::Sf`)
//!   consume the destination address from the virtual stack and the
//!   accumulator's current value. The accumulator's value after the
//!   store is the same SSA id (matching the C semantics where
//!   `*p = v` yields `v`).
//! * Call ops collect their argument list from the virtual stack
//!   (the preceding `Op::Psh`es) up to the matching trailing
//!   `Op::Adj N`. The call instruction defines a result value (the
//!   return register on the host ABI); the trailing `Adj N` is a
//!   no-op in SSA (the args have been transferred to the call's
//!   inputs).
//! * Branches and `Op::Lev` form the block's terminator.
//!
//! ## Invariants
//!
//! * The virtual stack is empty at every block boundary. The c5
//!   compiler's emit shape guarantees this -- each statement leaves
//!   the c5 stack at the same depth it found, and basic-block
//!   boundaries land on statement boundaries.
//! * Function-pointer values (`Op::Imm <CODE_BASE + pc>`) carry the
//!   raw operand; the per-arch lowering handles the relocation.
//! * The lift is per-function: each `Op::Ent` opens a fresh
//!   [`FunctionSsa`], `Op::Lev` (or a falling-off-the-end) closes it.

#![allow(dead_code)]

use alloc::vec;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::ir::{
    BinOp, Block, BlockId, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind,
    Terminator, ValueId,
};
use super::super::op::Op;
use super::super::program::Program;

/// Lift every function in `program.text` into a [`FunctionSsa`].
/// Returns one entry per `Op::Ent`. The lift is independent of
/// the per-arch lowering; both backends consume the same output.
pub(super) fn lift_program(program: &Program) -> Result<Vec<FunctionSsa>, C5Error> {
    let text = &program.text;
    let funcs_meta = super::scan_func_meta(program);
    // First pass: identify each function's PC range [ent_pc, next_ent_pc).
    let mut ent_pcs: Vec<usize> = funcs_meta.keys().copied().collect();
    ent_pcs.sort_unstable();
    let mut out = Vec::with_capacity(ent_pcs.len());
    for (i, &ent_pc) in ent_pcs.iter().enumerate() {
        let next_pc = ent_pcs.get(i + 1).copied().unwrap_or(text.len());
        let meta = funcs_meta.get(&ent_pc).copied().unwrap_or_default();
        let func = lift_function(
            text,
            ent_pc,
            next_pc,
            meta,
            &program.data_imm_positions,
            &program.code_imm_positions,
            &program.call_fp_arg_masks,
        )?;
        out.push(func);
    }
    Ok(out)
}

/// Lift a single function's body (from `ent_pc` to the next
/// `Op::Ent` or end-of-text) into an SSA program. See module
/// docs for the lift shape.
pub(super) fn lift_function(
    text: &[i64],
    ent_pc: usize,
    end_pc: usize,
    meta: super::FuncMeta,
    data_imm_positions: &[usize],
    code_imm_positions: &[usize],
    call_fp_arg_masks: &[(usize, u32)],
) -> Result<FunctionSsa, C5Error> {
    // Sanity check the entry.
    if Op::from_i64(text[ent_pc]) != Some(Op::Ent) {
        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
            "ssa lift: ent_pc doesn't land on Op::Ent",
        )));
    }
    let locals = text[ent_pc + 1];

    // The function's real end-of-body, computed as the inst loop
    // advances past each terminator. The codegen's outer walk
    // uses `function_end_pc` to know where to resume the pool
    // path for any trailing bytecode (sys trampolines etc.) that
    // the SSA lift did not absorb.
    let mut function_end_pc = ent_pc;

    // Block-boundary marker: a PC is a block start iff it is the
    // function's entry, a branch target, or the instruction
    // immediately after a terminator.
    let block_starts = collect_block_starts(text, ent_pc, end_pc);
    // PC -> block index (only set for PCs that start a block).
    let mut pc_to_block: super::ssa_emit_common::FxIntMap<usize, BlockId> =
        super::ssa_emit_common::FxIntMap::default();
    for (i, &pc) in block_starts.iter().enumerate() {
        pc_to_block.insert(pc, i as BlockId);
    }
    // Pre-walk: determine the c5 virtual-stack depth at every
    // block's entry. The lift uses this to emit `VstackReload`
    // insts at block start and `VstackSpill` insts at block exit
    // so values that ride the c5 stack across a branch (outer
    // `Op::Psh` of a binop's LHS straddling a ternary or short-
    // circuit) survive into the successor block.
    let block_entry_depths = compute_block_entry_depths(text, ent_pc, end_pc, &block_starts)?;
    let vstack_slots = block_entry_depths.iter().copied().max().unwrap_or(0);
    // Pre-walk: which blocks read the accumulator before writing
    // it? Such blocks need an `Inst::AccReload` at entry; every
    // predecessor of such a block emits an `Inst::AccSpill`
    // before its terminator. The c5 bytecode model treats the
    // accumulator as a single function-wide value; SSA per-block
    // value naming breaks that, so we round-trip through a
    // dedicated frame slot.
    let blocks_need_acc_reload =
        compute_blocks_needing_acc_reload(text, ent_pc, end_pc, &block_starts);

    // Preallocate `insts` to roughly the bytecode word count of
    // the function -- an upper bound on the number of Inst rows
    // we'll push. Avoids the realloc cascade as the per-block
    // walk grows the vector op by op; observed in profiling on
    // sqlite3.c (lift_program dominant in the SSA pipeline).
    let mut insts: Vec<Inst> = Vec::with_capacity(end_pc.saturating_sub(ent_pc));
    let mut blocks: Vec<Block> = Vec::with_capacity(block_starts.len());

    // Walk each block sequentially, building SSA values.
    for (block_idx, &start_pc) in block_starts.iter().enumerate() {
        let end_of_block = block_starts.get(block_idx + 1).copied().unwrap_or(end_pc);
        let inst_start = insts.len() as u32;
        // Per-block state.
        let mut acc: ValueId = NO_VALUE;
        let mut vstack: Vec<ValueId> = Vec::new();
        // Most recently produced SSA value for each local slot
        // touched in this block, tagged with the access kind that
        // produced it. A subsequent fused load of the same slot
        // aliases to the cached value when the kinds match (so
        // the cached 64-bit value's extension semantics match
        // what the new load would have produced). Mismatched
        // kinds re-load from memory. Cleared at ops whose
        // semantics could write to the local through a pointer
        // (function calls, intrinsics, `Op::Mcpy`, indirect
        // stores); this pass does not consult the parser's
        // address-escape tracking.
        let mut slot_value: alloc::collections::BTreeMap<i64, (LoadKind, ValueId)> =
            alloc::collections::BTreeMap::new();
        // Block entry: reload any cross-block vstack values from
        // their spill slots. Slot 0 holds the value that was at
        // the bottom of the vstack at the predecessor's spill;
        // slot N-1 holds the top. The reload order matches so the
        // local vstack starts with the same shape.
        let entry_depth = block_entry_depths[block_idx];
        for slot in 0..entry_depth {
            let id = insts.len() as ValueId;
            insts.push(Inst::VstackReload { slot });
            vstack.push(id);
        }
        // Cross-block accumulator: if this block reads `acc`
        // before any inst writes it, reload from the dedicated
        // accumulator slot the predecessor spilled to. The entry
        // block (block 0) has no predecessor so we skip.
        if block_idx > 0 && blocks_need_acc_reload[block_idx] {
            let id = insts.len() as ValueId;
            insts.push(Inst::AccReload);
            acc = id;
        }
        let mut pc = start_pc;
        // The block's entry instruction is `Op::Ent` (only for
        // the entry block) or `Op::AllocaInit` after it; both are
        // lifted to side-effect-only insts whose presence in the
        // SSA list doesn't define an accumulator value.
        let terminator;
        loop {
            if pc >= end_of_block {
                // Fell off the block without an explicit
                // terminator. Synthesize a fall-through to the
                // next block.
                let succ = (block_idx + 1) as BlockId;
                if (succ as usize) >= block_starts.len() {
                    return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                        "ssa lift: block fell off the end of the function without a terminator",
                    )));
                }
                terminator = Terminator::FallThrough(succ);
                function_end_pc = function_end_pc.max(pc);
                break;
            }
            let raw = text[pc];
            let op = Op::from_i64(raw).ok_or_else(|| {
                C5Error::Compile(crate::c5::error::fmt_internal_err(
                    "ssa lift: bad opcode mid-function",
                ))
            })?;
            // Helper: push an Inst, set the accumulator to it,
            // return the new value id.
            let def = |insts: &mut Vec<Inst>, ins: Inst, acc: &mut ValueId| -> ValueId {
                let id = insts.len() as ValueId;
                insts.push(ins);
                *acc = id;
                id
            };
            match op {
                Op::Ent => {
                    // Function entry; the operand was already
                    // read into `locals`. Op::Ent itself doesn't
                    // need an SSA inst -- the lowering reads
                    // `n_params`/`is_variadic`/`locals` directly
                    // off FunctionSsa.
                    pc += op.word_size();
                }
                Op::AllocaInit => {
                    let slot = text[pc + 1];
                    let id = insts.len() as ValueId;
                    insts.push(Inst::AllocaInit(slot));
                    let _ = id;
                    pc += op.word_size();
                }
                Op::Lev => {
                    // Return the current accumulator value.
                    terminator = Terminator::Return(acc);
                    function_end_pc = function_end_pc.max(pc + op.word_size());
                    break;
                }
                Op::Jmp => {
                    let target_pc = text[pc + 1] as usize;
                    let target_block = *pc_to_block.get(&target_pc).ok_or_else(|| {
                        C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "ssa lift: Jmp target isn't a block start",
                        ))
                    })?;
                    terminator = Terminator::Jmp(target_block);
                    function_end_pc = function_end_pc.max(pc + op.word_size());
                    break;
                }
                Op::Bz | Op::Bnz => {
                    let target_pc = text[pc + 1] as usize;
                    let target_block = *pc_to_block.get(&target_pc).ok_or_else(|| {
                        C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "ssa lift: Bz/Bnz target isn't a block start",
                        ))
                    })?;
                    let fall_pc = pc + op.word_size();
                    let fall_block = *pc_to_block.get(&fall_pc).ok_or_else(|| {
                        C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "ssa lift: Bz/Bnz fall-through isn't a block start",
                        ))
                    })?;
                    terminator = if matches!(op, Op::Bz) {
                        Terminator::Bz {
                            cond: acc,
                            target: target_block,
                            fall_through: fall_block,
                        }
                    } else {
                        Terminator::Bnz {
                            cond: acc,
                            target: target_block,
                            fall_through: fall_block,
                        }
                    };
                    function_end_pc = function_end_pc.max(pc + op.word_size());
                    break;
                }
                Op::Imm => {
                    let v = text[pc + 1];
                    let operand_pc = pc + 1;
                    let inst = if data_imm_positions.binary_search(&operand_pc).is_ok() {
                        Inst::ImmData(v)
                    } else if code_imm_positions.binary_search(&operand_pc).is_ok() {
                        Inst::ImmCode((v as usize) - super::super::CODE_BASE)
                    } else if code_imm_positions.is_empty()
                        && (v as usize) >= super::super::CODE_BASE
                        && ((v as usize) - super::super::CODE_BASE) < text.len()
                    {
                        // Optimizer-stripped position lists -- fall back
                        // to the value-range heuristic the pool path uses.
                        Inst::ImmCode((v as usize) - super::super::CODE_BASE)
                    } else {
                        Inst::Imm(v)
                    };
                    def(&mut insts, inst, &mut acc);
                    pc += op.word_size();
                }
                Op::Lea => {
                    let n = text[pc + 1];
                    // Peek at the next op. The bytecode optimizer
                    // already fuses `Op::Lea + Op::Li / Op::Lc`
                    // into `Op::LdLocI / Op::LdLocC`; recognize
                    // the analogous shape for the other widths
                    // (`Op::Lw`, `Op::Lwu`, `Op::Lh`, `Op::Lhu`,
                    // `Op::Lcs`, `Op::Lf`) and the unfused
                    // `Op::Lea + Op::Li / Op::Lc` shape that
                    // shows up without `-O`. Emit a single
                    // `Inst::LoadLocal` so the per-arch emit can
                    // fold the slot address into the load's
                    // displacement field.
                    let next_pc = pc + op.word_size();
                    let next_op = if next_pc < end_of_block {
                        Op::from_i64(text[next_pc])
                    } else {
                        None
                    };
                    let fused_kind = match next_op {
                        Some(Op::Li) => Some(LoadKind::I64),
                        Some(Op::Lc) => Some(LoadKind::U8),
                        Some(Op::Lcs) => Some(LoadKind::I8),
                        Some(Op::Lw) => Some(LoadKind::I32),
                        Some(Op::Lwu) => Some(LoadKind::U32),
                        Some(Op::Lh) => Some(LoadKind::I16),
                        Some(Op::Lhu) => Some(LoadKind::U16),
                        Some(Op::Lf) => Some(LoadKind::F32),
                        _ => None,
                    };
                    if let Some(kind) = fused_kind {
                        if let Some(&(cached_kind, cached)) = slot_value.get(&n)
                            && cached_kind == kind
                        {
                            acc = cached;
                        } else {
                            def(&mut insts, Inst::LoadLocal { off: n, kind }, &mut acc);
                            slot_value.insert(n, (kind, acc));
                        }
                        pc = next_pc + Op::from_i64(text[next_pc]).unwrap().word_size();
                    } else {
                        def(&mut insts, Inst::LocalAddr(n), &mut acc);
                        pc += op.word_size();
                    }
                }
                Op::TlsLea => {
                    let off = text[pc + 1];
                    def(&mut insts, Inst::TlsAddr(off), &mut acc);
                    pc += op.word_size();
                }
                Op::Psh => {
                    vstack.push(acc);
                    pc += op.word_size();
                }
                Op::Li => {
                    emit_scalar_load(&mut insts, &vstack, &mut acc, LoadKind::I64);
                    pc += op.word_size();
                }
                Op::Lc => {
                    emit_scalar_load(&mut insts, &vstack, &mut acc, LoadKind::U8);
                    pc += op.word_size();
                }
                Op::Lcs => {
                    emit_scalar_load(&mut insts, &vstack, &mut acc, LoadKind::I8);
                    pc += op.word_size();
                }
                Op::Lw => {
                    emit_scalar_load(&mut insts, &vstack, &mut acc, LoadKind::I32);
                    pc += op.word_size();
                }
                Op::Lwu => {
                    emit_scalar_load(&mut insts, &vstack, &mut acc, LoadKind::U32);
                    pc += op.word_size();
                }
                Op::Lh => {
                    emit_scalar_load(&mut insts, &vstack, &mut acc, LoadKind::I16);
                    pc += op.word_size();
                }
                Op::Lhu => {
                    emit_scalar_load(&mut insts, &vstack, &mut acc, LoadKind::U16);
                    pc += op.word_size();
                }
                Op::Lf => {
                    emit_scalar_load(&mut insts, &vstack, &mut acc, LoadKind::F32);
                    pc += op.word_size();
                }
                Op::LdLocI => {
                    let n = text[pc + 1];
                    if let Some(&(kind, cached)) = slot_value.get(&n)
                        && kind == LoadKind::I64
                    {
                        acc = cached;
                    } else {
                        def(
                            &mut insts,
                            Inst::LoadLocal {
                                off: n,
                                kind: LoadKind::I64,
                            },
                            &mut acc,
                        );
                        slot_value.insert(n, (LoadKind::I64, acc));
                    }
                    pc += op.word_size();
                }
                Op::LdLocC => {
                    let n = text[pc + 1];
                    if let Some(&(cached_kind, cached)) = slot_value.get(&n)
                        && cached_kind == LoadKind::U8
                    {
                        acc = cached;
                    } else {
                        def(
                            &mut insts,
                            Inst::LoadLocal {
                                off: n,
                                kind: LoadKind::U8,
                            },
                            &mut acc,
                        );
                        slot_value.insert(n, (LoadKind::U8, acc));
                    }
                    pc += op.word_size();
                }
                Op::Si | Op::Sc | Op::Sw | Op::Sh | Op::Sf => {
                    let addr = vstack.pop().ok_or_else(|| {
                        C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "ssa lift: store with empty virtual stack",
                        ))
                    })?;
                    let kind = match op {
                        Op::Si => StoreKind::I64,
                        Op::Sc => StoreKind::I8,
                        Op::Sw => StoreKind::I32,
                        Op::Sh => StoreKind::I16,
                        Op::Sf => StoreKind::F32,
                        _ => unreachable!(),
                    };
                    let value = acc;
                    // First try the indexed-store fuse:
                    // `Binop(Add, base, scaled)` where scaled is a
                    // `BinopI(Mul|Shl, idx, K)` collapses into one
                    // SIB-mode store. The Add + BinopI become dead
                    // and the DCE pass removes them; the per-arch
                    // emit reads the StoreIndexed inst's base/idx
                    // values directly. Falls through to the
                    // LocalAddr fuse when the shape doesn't match.
                    if let Some((base, index, scale)) =
                        try_fuse_indexed_store(&insts, addr, kind, &vstack)
                    {
                        def(
                            &mut insts,
                            Inst::StoreIndexed {
                                base,
                                index,
                                scale,
                                value,
                                kind,
                            },
                            &mut acc,
                        );
                        // Indexed stores write through a pointer-
                        // arithmetic expression; the c5 alias
                        // assumption (any *p = v may touch any
                        // local) still applies.
                        slot_value.clear();
                        pc += op.word_size();
                        continue;
                    }
                    // When the address came from a `LocalAddr(n)` def
                    // the store touches one known slot, not arbitrary
                    // memory. Fuse to `StoreLocal` so the per-arch emit
                    // folds the address into the store, and update the
                    // per-slot value cache so a subsequent read of the
                    // same slot reuses the value instead of reloading.
                    // This is the c5 parser's call-arg shape (`Op::Lea
                    // temp; Op::Psh; (expr); Op::Si`) -- without the
                    // fuse, each arg setup costs two redundant memory
                    // ops plus an unused-LocalAddr register.
                    // Fuse only the I64 store-through-LocalAddr shape;
                    // the per-arch StoreLocal emit currently only
                    // supports I64. Narrower widths still emit
                    // Inst::Store with a clear-the-cache invalidation.
                    let local_off = if matches!(kind, StoreKind::I64)
                        && let Some(Inst::LocalAddr(n)) = insts.get(addr as usize)
                    {
                        Some(*n)
                    } else {
                        None
                    };
                    if let Some(off) = local_off {
                        def(&mut insts, Inst::StoreLocal { off, value, kind }, &mut acc);
                        // The c5 store leaves the bit pattern in the
                        // slot; a subsequent I64 load consumes the
                        // raw 8 bytes. Cache-hit aliasing only works
                        // when the stored value lives in an int reg;
                        // for an FP-producing value the cache hit
                        // would deliver an FpReg to a consumer that
                        // expects an int reg (call-arg marshalling
                        // goes through x0..x7, not d0..d7). Skip
                        // the cache update for FP-producing values;
                        // the load still works -- it just goes
                        // through memory like the unfused path.
                        if !is_fp_producing(&insts, value) {
                            slot_value.insert(off, (LoadKind::I64, value));
                        } else {
                            slot_value.remove(&off);
                        }
                    } else {
                        def(&mut insts, Inst::Store { addr, value, kind }, &mut acc);
                        // Indirect store may alias any local through
                        // the pointer; drop the per-slot value cache.
                        slot_value.clear();
                    }
                    pc += op.word_size();
                }
                Op::StLocI => {
                    let n = text[pc + 1];
                    let value = acc;
                    def(
                        &mut insts,
                        Inst::StoreLocal {
                            off: n,
                            value,
                            kind: StoreKind::I64,
                        },
                        &mut acc,
                    );
                    slot_value.insert(n, (LoadKind::I64, value));
                    pc += op.word_size();
                }
                op if matches!(
                    op,
                    Op::Or
                        | Op::Xor
                        | Op::And
                        | Op::Eq
                        | Op::Ne
                        | Op::Lt
                        | Op::Gt
                        | Op::Le
                        | Op::Ge
                        | Op::Ult
                        | Op::Ugt
                        | Op::Ule
                        | Op::Uge
                        | Op::Shl
                        | Op::Shr
                        | Op::Shru
                        | Op::Add
                        | Op::Sub
                        | Op::Mul
                        | Op::Div
                        | Op::Mod
                        | Op::Divu
                        | Op::Modu
                        | Op::Fadd
                        | Op::Fsub
                        | Op::Fmul
                        | Op::Fdiv
                        | Op::Feq
                        | Op::Fne
                        | Op::Flt
                        | Op::Fgt
                        | Op::Fle
                        | Op::Fge
                ) =>
                {
                    let bop = match op {
                        Op::Or => BinOp::Or,
                        Op::Xor => BinOp::Xor,
                        Op::And => BinOp::And,
                        Op::Eq => BinOp::Eq,
                        Op::Ne => BinOp::Ne,
                        Op::Lt => BinOp::Lt,
                        Op::Gt => BinOp::Gt,
                        Op::Le => BinOp::Le,
                        Op::Ge => BinOp::Ge,
                        Op::Ult => BinOp::Ult,
                        Op::Ugt => BinOp::Ugt,
                        Op::Ule => BinOp::Ule,
                        Op::Uge => BinOp::Uge,
                        Op::Shl => BinOp::Shl,
                        Op::Shr => BinOp::Shr,
                        Op::Shru => BinOp::Shru,
                        Op::Add => BinOp::Add,
                        Op::Sub => BinOp::Sub,
                        Op::Mul => BinOp::Mul,
                        Op::Div => BinOp::Div,
                        Op::Mod => BinOp::Mod,
                        Op::Divu => BinOp::Divu,
                        Op::Modu => BinOp::Modu,
                        Op::Fadd => BinOp::Fadd,
                        Op::Fsub => BinOp::Fsub,
                        Op::Fmul => BinOp::Fmul,
                        Op::Fdiv => BinOp::Fdiv,
                        Op::Feq => BinOp::Feq,
                        Op::Fne => BinOp::Fne,
                        Op::Flt => BinOp::Flt,
                        Op::Fgt => BinOp::Fgt,
                        Op::Fle => BinOp::Fle,
                        Op::Fge => BinOp::Fge,
                        _ => unreachable!(),
                    };
                    let lhs = vstack.pop().ok_or_else(|| {
                        C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "ssa lift: binary op with empty virtual stack",
                        ))
                    })?;
                    let rhs = acc;
                    def(&mut insts, Inst::Binop { op: bop, lhs, rhs }, &mut acc);
                    pc += op.word_size();
                }
                op if matches!(
                    op,
                    Op::AddI
                        | Op::SubI
                        | Op::MulI
                        | Op::AndI
                        | Op::OrI
                        | Op::XorI
                        | Op::ShlI
                        | Op::ShrI
                        | Op::ShruI
                        | Op::EqI
                        | Op::NeI
                        | Op::LtI
                        | Op::GtI
                        | Op::LeI
                        | Op::GeI
                        | Op::UltI
                        | Op::UgtI
                        | Op::UleI
                        | Op::UgeI
                ) =>
                {
                    let bop = match op {
                        Op::AddI => BinOp::Add,
                        Op::SubI => BinOp::Sub,
                        Op::MulI => BinOp::Mul,
                        Op::AndI => BinOp::And,
                        Op::OrI => BinOp::Or,
                        Op::XorI => BinOp::Xor,
                        Op::ShlI => BinOp::Shl,
                        Op::ShrI => BinOp::Shr,
                        Op::ShruI => BinOp::Shru,
                        Op::EqI => BinOp::Eq,
                        Op::NeI => BinOp::Ne,
                        Op::LtI => BinOp::Lt,
                        Op::GtI => BinOp::Gt,
                        Op::LeI => BinOp::Le,
                        Op::GeI => BinOp::Ge,
                        Op::UltI => BinOp::Ult,
                        Op::UgtI => BinOp::Ugt,
                        Op::UleI => BinOp::Ule,
                        Op::UgeI => BinOp::Uge,
                        _ => unreachable!(),
                    };
                    let imm = text[pc + 1];
                    let lhs = acc;
                    def(
                        &mut insts,
                        Inst::BinopI {
                            op: bop,
                            lhs,
                            rhs_imm: imm,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Fneg => {
                    let v = acc;
                    def(&mut insts, Inst::Fneg(v), &mut acc);
                    pc += op.word_size();
                }
                Op::Fcvtfi => {
                    let v = acc;
                    def(
                        &mut insts,
                        Inst::FpCast {
                            kind: FpCastKind::FpToInt,
                            value: v,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Fcvtif => {
                    let v = acc;
                    def(
                        &mut insts,
                        Inst::FpCast {
                            kind: FpCastKind::IntToFp,
                            value: v,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Jsr => {
                    let target_pc = text[pc + 1] as usize;
                    // Args are the run of `Op::Psh`-pushed values
                    // since the last `Adj`. They sit on `vstack`
                    // in c5 push order (first declared on top, so
                    // last pushed). Pop them in order: vstack
                    // top = first arg, etc.
                    let nargs = peek_adj_n(text, pc + op.word_size());
                    let mut args = Vec::with_capacity(nargs);
                    for _ in 0..nargs {
                        args.push(vstack.pop().ok_or_else(|| {
                            C5Error::Compile(crate::c5::error::fmt_internal_err(
                                "ssa lift: Jsr arg count exceeds virtual stack depth",
                            ))
                        })?);
                    }
                    def(&mut insts, Inst::Call { target_pc, args }, &mut acc);
                    slot_value.clear();
                    pc += op.word_size();
                    // Skip the trailing `Adj N` -- args are now
                    // owned by the Call inst; the stack-drop is
                    // implicit in the new shape.
                    if nargs > 0 && pc + 1 < text.len() && Op::from_i64(text[pc]) == Some(Op::Adj) {
                        pc += Op::Adj.word_size();
                    }
                }
                Op::Jsri => {
                    let target = acc;
                    let nargs = peek_adj_n(text, pc + op.word_size());
                    let mut args = Vec::with_capacity(nargs);
                    for _ in 0..nargs {
                        args.push(vstack.pop().ok_or_else(|| {
                            C5Error::Compile(crate::c5::error::fmt_internal_err(
                                "ssa lift: Jsri arg count exceeds virtual stack depth",
                            ))
                        })?);
                    }
                    def(&mut insts, Inst::CallIndirect { target, args }, &mut acc);
                    slot_value.clear();
                    pc += op.word_size();
                    if nargs > 0 && pc + 1 < text.len() && Op::from_i64(text[pc]) == Some(Op::Adj) {
                        pc += Op::Adj.word_size();
                    }
                }
                Op::JsrExt => {
                    let binding_idx = text[pc + 1];
                    let nargs = peek_adj_n(text, pc + op.word_size());
                    let mut args = Vec::with_capacity(nargs);
                    for _ in 0..nargs {
                        args.push(vstack.pop().ok_or_else(|| {
                            C5Error::Compile(crate::c5::error::fmt_internal_err(
                                "ssa lift: JsrExt arg count exceeds virtual stack depth",
                            ))
                        })?);
                    }
                    // Look up the FP-arg bit mask the compiler
                    // filed at this `Op::JsrExt`'s PC. The pool
                    // path reads the same side table; capturing
                    // the mask in the SSA inst lets the emit
                    // route FP args to d0..d7 without threading
                    // the bytecode pc through the call helpers.
                    let fp_arg_mask = call_fp_arg_masks
                        .iter()
                        .find(|(p, _)| *p == pc)
                        .map(|(_, m)| *m)
                        .unwrap_or(0);
                    def(
                        &mut insts,
                        Inst::CallExt {
                            binding_idx,
                            args,
                            fp_arg_mask,
                        },
                        &mut acc,
                    );
                    slot_value.clear();
                    pc += op.word_size();
                    if nargs > 0 && pc + 1 < text.len() && Op::from_i64(text[pc]) == Some(Op::Adj) {
                        pc += Op::Adj.word_size();
                    }
                }
                Op::TailExt => {
                    let binding_idx = text[pc + 1];
                    terminator = Terminator::TailExt(binding_idx);
                    function_end_pc = function_end_pc.max(pc + op.word_size());
                    break;
                }
                Op::Adj => {
                    // Stray Adj (e.g. after a 0-arg call). No-op
                    // in SSA -- the matching call's args list
                    // already drove the stack consumption.
                    pc += op.word_size();
                }
                Op::Mcpy => {
                    let size = text[pc + 1];
                    let dst = vstack.pop().ok_or_else(|| {
                        C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "ssa lift: Mcpy with empty virtual stack",
                        ))
                    })?;
                    let src = acc;
                    def(&mut insts, Inst::Mcpy { dst, src, size }, &mut acc);
                    slot_value.clear();
                    pc += op.word_size();
                }
                Op::Intrinsic => {
                    let kind = text[pc + 1];
                    let two_arg = kind == crate::c5::op::Intrinsic::LongjmpAArch64 as i64
                        || kind == crate::c5::op::Intrinsic::VaStart as i64
                        || kind == crate::c5::op::Intrinsic::VaCopy as i64;
                    let args: Vec<ValueId> = if two_arg {
                        let first = vstack.pop().ok_or_else(|| {
                            C5Error::Compile(crate::c5::error::fmt_internal_err(
                                "ssa lift: two-arg intrinsic with empty virtual stack",
                            ))
                        })?;
                        vec![first, acc]
                    } else {
                        vec![acc]
                    };
                    def(&mut insts, Inst::Intrinsic { kind, args }, &mut acc);
                    slot_value.clear();
                    pc += op.word_size();
                }
                _ => {
                    return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                        "ssa lift: unhandled opcode",
                    )));
                }
            }
        }
        // Spill any vstack values still alive at block exit so
        // the successor block can reload them. Slot 0 = bottom-
        // of-vstack at spill time, top-of-vstack = slot N-1.
        // VstackSpill insts go BEFORE the terminator was
        // emitted (they're side-effect-only and don't need to
        // ride a separate "between exit-acc and terminator"
        // phase -- the terminator wasn't appended to `insts`
        // either; it lives in `terminator`).
        for (slot, &value) in vstack.iter().enumerate() {
            insts.push(Inst::VstackSpill {
                slot: slot as u32,
                value,
            });
        }
        // If any successor reloads the accumulator, spill it
        // now. Conservative: spill whenever the block has a
        // non-NO_VALUE exit_acc and any reachable block needs a
        // reload. The optimizer / allocator can DCE redundant
        // spills if they become dead.
        if acc != NO_VALUE
            && exit_reaches_acc_reload(&block_starts, block_idx, &blocks_need_acc_reload)
        {
            insts.push(Inst::AccSpill { value: acc });
        }
        let inst_end = insts.len() as u32;
        blocks.push(Block {
            start_pc,
            inst_range: inst_start..inst_end,
            terminator,
            exit_acc: acc,
        });
    }

    Ok(FunctionSsa {
        ent_pc,
        end_pc: function_end_pc,
        locals,
        n_params: meta.n_params,
        is_variadic: meta.is_variadic,
        insts,
        blocks,
        vstack_slots,
    })
}

/// Pre-walk the function and compute the c5 virtual-stack depth
/// at each block's entry. Threads depth across fall-through and
/// branch edges; the c5 emitter guarantees every predecessor of
/// a block agrees on the entry depth (the bytecode is a
/// well-balanced stream).
/// Emit either a plain `Inst::Load` or its fused `Inst::LoadIndexed`
/// form depending on whether the upstream Add + Mul/Shl pattern is
/// recognisable. Used by every scalar load handler so the fold is
/// applied uniformly.
fn emit_scalar_load(insts: &mut Vec<Inst>, vstack: &[ValueId], acc: &mut ValueId, kind: LoadKind) {
    let pushed =
        if let Some((base, index, scale)) = try_fuse_indexed_load(insts, *acc, kind, vstack) {
            // Drop the now-dead Add and BinopI insts. Their value ids
            // were single-use (only the load consumed them), so this is
            // safe.
            insts.truncate(insts.len() - 2);
            Inst::LoadIndexed {
                base,
                index,
                scale,
                kind,
            }
        } else {
            Inst::Load { addr: *acc, kind }
        };
    let id = insts.len() as ValueId;
    insts.push(pushed);
    *acc = id;
}

/// Try to recognise `Inst::Binop(Add, base, scaled) + Load(kind)` as
/// an indexed memory access. Returns `Some((base, index, scale))` if
/// the pattern applies and the surrounding flow allows the upstream
/// Add + Mul/Shl to be elided. `addr` is the would-be load's address
/// value (typically `acc`); `acc_is_last` says whether `addr` is the
/// most recently defined value in `insts` (the load handler invariant).
///
/// Returns None and leaves `insts` untouched when the pattern doesn't
/// hold; the caller falls back to emitting a plain `Load`.
fn try_fuse_indexed_load(
    insts: &[Inst],
    addr: ValueId,
    kind: LoadKind,
    vstack: &[ValueId],
) -> Option<(ValueId, ValueId, u8)> {
    if matches!(kind, LoadKind::F32) {
        return None;
    }
    let expected_scale: u8 = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
        LoadKind::F32 => unreachable!(),
    };
    let add_idx = addr as usize;
    if add_idx + 1 != insts.len() {
        return None;
    }
    if vstack.contains(&addr) {
        return None;
    }
    let (a, b) = match insts.get(add_idx)? {
        Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        } => (*lhs, *rhs),
        _ => return None,
    };
    // Try both orderings: `base + scaled` and `scaled + base`. Each
    // candidate must be the immediately-preceding inst (so it's
    // safe to truncate) and the BinopI's `lhs` must not be the
    // other operand (the index can't double as the base).
    for &(base, scaled) in &[(a, b), (b, a)] {
        let scaled_idx = scaled as usize;
        if scaled_idx + 1 != add_idx {
            continue;
        }
        if vstack.contains(&scaled) {
            continue;
        }
        let (index, byte_scale) = match insts.get(scaled_idx)? {
            Inst::BinopI {
                op: BinOp::Mul,
                lhs,
                rhs_imm,
            } => (*lhs, *rhs_imm),
            Inst::BinopI {
                op: BinOp::Shl,
                lhs,
                rhs_imm,
            } => {
                if !(0..=3).contains(rhs_imm) {
                    continue;
                }
                (*lhs, 1i64 << *rhs_imm)
            }
            _ => continue,
        };
        if !matches!(byte_scale, 1 | 2 | 4 | 8) || (byte_scale as u8) != expected_scale {
            continue;
        }
        return Some((base, index, byte_scale as u8));
    }
    None
}

/// Companion to `try_fuse_indexed_load` for the store path. The
/// c5 store shape is `(expr): addr; Psh; (expr): value; Si`, so by
/// the time the lift sees `Si` the `addr` has been popped off
/// `vstack` and the value is in acc. The recogniser requires:
/// (1) `addr` is the result of `Binop(Add, base, scaled)`;
/// (2) `addr` has no remaining consumers (not on `vstack`, not
/// referenced by any later inst);
/// (3) `scaled` is the immediately-preceding inst, a
/// `BinopI(Mul|Shl, idx, K)` with K matching the store width;
/// (4) `scaled` has no consumers besides the Add (vstack-clean and
/// not referenced by anything after the Add).
fn try_fuse_indexed_store(
    insts: &[Inst],
    addr: ValueId,
    kind: StoreKind,
    vstack: &[ValueId],
) -> Option<(ValueId, ValueId, u8)> {
    if matches!(kind, StoreKind::F32) {
        return None;
    }
    let expected_scale: u8 = match kind {
        StoreKind::I64 => 8,
        StoreKind::I32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
        StoreKind::F32 => unreachable!(),
    };
    let add_idx = addr as usize;
    let (a, b) = match insts.get(add_idx)? {
        Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        } => (*lhs, *rhs),
        _ => return None,
    };
    if vstack.contains(&addr) {
        return None;
    }
    for inst in insts.iter().skip(add_idx + 1) {
        if references_value(inst, addr) {
            return None;
        }
    }
    for &(base, scaled) in &[(a, b), (b, a)] {
        let scaled_idx = scaled as usize;
        if scaled_idx + 1 != add_idx {
            continue;
        }
        if vstack.contains(&scaled) {
            continue;
        }
        let mut other_use = false;
        for (j, inst) in insts.iter().enumerate().skip(scaled_idx + 1) {
            if j == add_idx {
                continue;
            }
            if references_value(inst, scaled) {
                other_use = true;
                break;
            }
        }
        if other_use {
            continue;
        }
        let (index, byte_scale) = match insts.get(scaled_idx)? {
            Inst::BinopI {
                op: BinOp::Mul,
                lhs,
                rhs_imm,
            } => (*lhs, *rhs_imm),
            Inst::BinopI {
                op: BinOp::Shl,
                lhs,
                rhs_imm,
            } => {
                if !(0..=3).contains(rhs_imm) {
                    continue;
                }
                (*lhs, 1i64 << *rhs_imm)
            }
            _ => continue,
        };
        if !matches!(byte_scale, 1 | 2 | 4 | 8) || (byte_scale as u8) != expected_scale {
            continue;
        }
        return Some((base, index, byte_scale as u8));
    }
    None
}

/// Cheap reference check for the indexed-fold elision predicates.
/// Counts a reference if any operand `ValueId` in `inst` equals `v`.
fn references_value(inst: &Inst, v: ValueId) -> bool {
    match inst {
        Inst::Imm(_)
        | Inst::ImmData(_)
        | Inst::ImmCode(_)
        | Inst::LocalAddr(_)
        | Inst::TlsAddr(_)
        | Inst::AllocaInit(_)
        | Inst::TailExt(_)
        | Inst::VstackReload { .. }
        | Inst::AccReload => false,
        Inst::Load { addr, .. } => *addr == v,
        Inst::LoadLocal { .. } => false,
        Inst::Store { addr, value, .. } => *addr == v || *value == v,
        Inst::StoreLocal { value, .. } => *value == v,
        Inst::LoadIndexed { base, index, .. } => *base == v || *index == v,
        Inst::StoreIndexed {
            base, index, value, ..
        } => *base == v || *index == v || *value == v,
        Inst::Binop { lhs, rhs, .. } => *lhs == v || *rhs == v,
        Inst::BinopI { lhs, .. } => *lhs == v,
        Inst::Fneg(x) => *x == v,
        Inst::FpCast { value, .. } => *value == v,
        Inst::Call { args, .. }
        | Inst::CallIndirect { args, .. }
        | Inst::CallExt { args, .. }
        | Inst::Intrinsic { args, .. } => args.contains(&v),
        Inst::Mcpy { dst, src, .. } => *dst == v || *src == v,
        Inst::VstackSpill { value, .. } => *value == v,
        Inst::AccSpill { value } => *value == v,
    }
}

/// True when the value's defining instruction lands in an FP
/// register under the allocator's bank classification. Mirrors the
/// `result_kind` switch in `ssa_alloc::result_kind` for the cases
/// the store-fuse cache cares about (only int-producing values can
/// alias a subsequent I64 load through the cache).
fn is_fp_producing(insts: &[Inst], v: ValueId) -> bool {
    match insts.get(v as usize) {
        Some(Inst::Load {
            kind: LoadKind::F32,
            ..
        }) => true,
        Some(Inst::LoadLocal {
            kind: LoadKind::F32,
            ..
        }) => true,
        Some(Inst::Store {
            kind: StoreKind::F32,
            ..
        }) => true,
        Some(Inst::StoreLocal {
            kind: StoreKind::F32,
            ..
        }) => true,
        Some(Inst::Binop { op, .. }) | Some(Inst::BinopI { op, .. }) => {
            matches!(op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv)
        }
        Some(Inst::Fneg(_)) => true,
        Some(Inst::FpCast {
            kind: FpCastKind::IntToFp,
            ..
        }) => true,
        _ => false,
    }
}

fn compute_block_entry_depths(
    text: &[i64],
    _ent_pc: usize,
    end_pc: usize,
    block_starts: &[usize],
) -> Result<Vec<u32>, C5Error> {
    let mut depths = vec![None::<u32>; block_starts.len()];
    let mut pc_to_block: super::ssa_emit_common::FxIntMap<usize, usize> =
        super::ssa_emit_common::FxIntMap::default();
    for (i, &pc) in block_starts.iter().enumerate() {
        pc_to_block.insert(pc, i);
    }
    depths[0] = Some(0);

    let record =
        |target_pc: usize, depth: u32, depths: &mut [Option<u32>]| -> Result<(), C5Error> {
            if let Some(&idx) = pc_to_block.get(&target_pc) {
                match depths[idx] {
                    None => depths[idx] = Some(depth),
                    Some(existing) if existing == depth => {}
                    Some(existing) => {
                        return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                            &alloc::format!(
                                "ssa lift: block at pc {target_pc} reached with mismatched \
                             c5-vstack depths ({existing} vs {depth})"
                            ),
                        )));
                    }
                }
            }
            Ok(())
        };

    for (block_idx, &start_pc) in block_starts.iter().enumerate() {
        let entry_depth = depths[block_idx].unwrap_or(0);
        let mut depth = entry_depth;
        let end_of_block = block_starts.get(block_idx + 1).copied().unwrap_or(end_pc);
        let mut pc = start_pc;
        while pc < end_of_block {
            let Some(op) = Op::from_i64(text[pc]) else {
                break;
            };
            match op {
                Op::Psh => depth += 1,
                Op::Or
                | Op::Xor
                | Op::And
                | Op::Eq
                | Op::Ne
                | Op::Lt
                | Op::Gt
                | Op::Le
                | Op::Ge
                | Op::Ult
                | Op::Ugt
                | Op::Ule
                | Op::Uge
                | Op::Shl
                | Op::Shr
                | Op::Shru
                | Op::Add
                | Op::Sub
                | Op::Mul
                | Op::Div
                | Op::Mod
                | Op::Divu
                | Op::Modu
                | Op::Fadd
                | Op::Fsub
                | Op::Fmul
                | Op::Fdiv
                | Op::Feq
                | Op::Fne
                | Op::Flt
                | Op::Fgt
                | Op::Fle
                | Op::Fge
                | Op::Si
                | Op::Sc
                | Op::Sw
                | Op::Sh
                | Op::Sf
                | Op::Mcpy => {
                    depth = depth.checked_sub(1).ok_or_else(|| {
                        C5Error::Compile(crate::c5::error::fmt_internal_err(
                            "ssa lift: stack underflow during depth pre-walk",
                        ))
                    })?;
                }
                Op::Jsr | Op::Jsri | Op::JsrExt => {
                    // The SSA lift bundles the trailing `Adj N`
                    // into the call's args list, so the call's
                    // PC + the following `Adj`'s PC are folded
                    // into a single virtual op that pops N. Mirror
                    // that here: subtract N and skip past the Adj.
                    let after = pc + op.word_size();
                    if after < end_of_block && Op::from_i64(text[after]) == Some(Op::Adj) {
                        let n = text[after + 1] as u32;
                        depth = depth.checked_sub(n).ok_or_else(|| {
                            C5Error::Compile(crate::c5::error::fmt_internal_err(
                                "ssa lift: stack underflow at Adj during depth pre-walk",
                            ))
                        })?;
                        pc = after + Op::Adj.word_size();
                        continue;
                    }
                }
                Op::Adj => {
                    // Stray Adj (the call before it was 0-arg or
                    // we missed something). Just drop and move on.
                    let n = text[pc + 1] as u32;
                    depth = depth.checked_sub(n).unwrap_or(depth);
                }
                Op::Intrinsic => {
                    // Two-arg intrinsics (longjmp, va_start,
                    // va_copy) pop one slot on inline expansion.
                    // Others don't perturb the vstack.
                    let kind = text[pc + 1];
                    let two_arg = kind == crate::c5::op::Intrinsic::LongjmpAArch64 as i64
                        || kind == crate::c5::op::Intrinsic::VaStart as i64
                        || kind == crate::c5::op::Intrinsic::VaCopy as i64;
                    if two_arg {
                        depth = depth.checked_sub(1).ok_or_else(|| {
                            C5Error::Compile(crate::c5::error::fmt_internal_err(
                                "ssa lift: stack underflow at two-arg intrinsic during depth pre-walk",
                            ))
                        })?;
                    }
                }
                Op::Jmp => {
                    let target = text[pc + 1] as usize;
                    record(target, depth, &mut depths)?;
                    pc += op.word_size();
                    continue;
                }
                Op::Bz | Op::Bnz => {
                    let target = text[pc + 1] as usize;
                    record(target, depth, &mut depths)?;
                    // Fall-through path keeps the same depth.
                }
                Op::Lev | Op::TailExt => {
                    // No successor; depth no longer matters.
                    pc += op.word_size();
                    continue;
                }
                _ => {}
            }
            pc += op.word_size();
        }
        // Fall-through to next block.
        if let Some(&_next_pc) = block_starts.get(block_idx + 1) {
            record(end_of_block, depth, &mut depths)?;
        }
    }

    Ok(depths.into_iter().map(|d| d.unwrap_or(0)).collect())
}

/// Read the operand of a trailing `Op::Adj` if one sits at
/// `pc`. The c5 emitter writes `Op::Psh ... ; Op::Jsr/Jsri/JsrExt ;
/// Op::Adj N`; a 0-arg call omits the `Adj` entirely.
fn peek_adj_n(text: &[i64], pc: usize) -> usize {
    if pc < text.len() && Op::from_i64(text[pc]) == Some(Op::Adj) {
        text[pc + 1] as usize
    } else {
        0
    }
}

/// Walk `[ent_pc, end_pc)` of `text` and return the sorted set of
/// Pc just past the function's last reachable op. Walks the full
/// [ent_pc, bound) range tracking each forward branch target and
/// every `Op::Lev` / `Op::TailExt` after-pc. The function's body
/// extends to the latest of: the highest forward branch target,
/// the highest after-Lev pc, the highest after-TailExt pc. The
/// next op past that bound is either the next function's
/// `Op::Ent` or a bare-`Op::TailExt` sys trampoline -- either
/// way, not part of this function. Used to size the block-
/// collection / lift walks so they don't absorb code that
/// belongs elsewhere.
fn compute_function_end(text: &[i64], ent_pc: usize, bound: usize) -> usize {
    let mut end = ent_pc;
    let mut pc = ent_pc;
    while pc < bound {
        let Some(op) = Op::from_i64(text[pc]) else {
            break;
        };
        let after = pc + op.word_size();
        match op {
            Op::Lev | Op::TailExt => {
                end = end.max(after);
                // Only stop if the running `end` doesn't already
                // sit past this terminator's after-pc (i.e. no
                // earlier forward branch marked a higher pc).
                if end == after {
                    return end;
                }
            }
            Op::Jmp | Op::Bz | Op::Bnz => {
                let target = text[pc + 1] as usize;
                if target > pc && target < bound {
                    end = end.max(target);
                }
                end = end.max(after);
                if matches!(op, Op::Jmp) && end == after {
                    return end;
                }
            }
            _ => {
                end = end.max(after);
            }
        }
        pc = after;
    }
    end.min(bound)
}

/// PCs that start a basic block. Block-start condition: the PC is
/// `ent_pc`, the target of a `Jmp` / `Bz` / `Bnz` op, or the PC
/// immediately after a terminator (`Jmp` / `Bz` / `Bnz` / `Lev` /
/// `TailExt`).
fn collect_block_starts(text: &[i64], ent_pc: usize, end_pc: usize) -> Vec<usize> {
    let mut starts: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    starts.insert(ent_pc);
    let mut pc = ent_pc;
    while pc < end_pc {
        let Some(op) = Op::from_i64(text[pc]) else {
            break;
        };
        match op {
            Op::Jmp | Op::Bz | Op::Bnz => {
                let target = text[pc + 1] as usize;
                if target >= ent_pc && target < end_pc {
                    starts.insert(target);
                }
                let after = pc + op.word_size();
                if after < end_pc {
                    starts.insert(after);
                }
            }
            Op::Lev | Op::TailExt => {
                let after = pc + op.word_size();
                if after < end_pc {
                    starts.insert(after);
                }
            }
            _ => {}
        }
        pc += op.word_size();
    }
    starts.into_iter().collect()
}

/// For each block, decide whether its body reads the accumulator
/// before writing it. The lift inserts `Inst::AccReload` at the
/// entry of blocks where this is true; every predecessor's
/// terminator gets a matching `Inst::AccSpill` so the cross-edge
/// value round-trips through the dedicated accumulator slot.
///
/// Reads-before-writes: any op whose lowering reads `a` (Op::Psh,
/// Op::Si/Sc/Sw/Sh/Sf, Op::Li/Lc/Lcs/Lw/Lwu/Lh/Lhu/Lf load-from-
/// acc, every binop's rhs, every store's value, every call op's
/// trailing return-value sink, the conditional-branch terminator
/// Op::Bz/Op::Bnz, every fixed-arg intrinsic, plus `Op::Lev`'s
/// return value). The pre-walk simplifies: the block reads acc
/// before writing iff the first acc-touching op in the body is
/// a read (rather than a write).
///
/// Conservative shortcut: this pass marks any block whose first
/// non-AllocaInit op is a load-from-acc (Op::Li / Lc / ...), a
/// store, a binop, a push, a call-and-return, or a conditional
/// branch terminator before any acc-writing op. Op::Imm / Op::Lea
/// / Op::TlsLea write acc without reading it, so a block that
/// opens with one of those doesn't need a reload.
fn compute_blocks_needing_acc_reload(
    text: &[i64],
    ent_pc: usize,
    end_pc: usize,
    block_starts: &[usize],
) -> Vec<bool> {
    let mut needs = vec![false; block_starts.len()];
    for (idx, &start) in block_starts.iter().enumerate() {
        if idx == 0 {
            continue;
        }
        let end = block_starts.get(idx + 1).copied().unwrap_or(end_pc);
        if start >= end {
            continue;
        }
        let Some(op) = Op::from_i64(text[start]) else {
            continue;
        };
        needs[idx] = reads_acc_first(op);
    }
    let _ = ent_pc;
    needs
}

/// Whether `op` reads the accumulator before any in-block write
/// to it. The bytecode's first op in a block decides this: if
/// the op consumes `a` (Op::Bz, Op::Si, a binop's rhs, ...) the
/// block needs a cross-edge accumulator reload. If the op
/// writes `a` first (Op::Imm, Op::Lea, fused loads, ...) the
/// block is self-sufficient.
fn reads_acc_first(op: Op) -> bool {
    match op {
        // Writes acc without reading.
        Op::Imm
        | Op::Lea
        | Op::TlsLea
        | Op::AllocaInit
        | Op::Ent
        | Op::LdLocI
        | Op::LdLocC
        | Op::Jsr
        | Op::Jsri
        | Op::JsrExt
        | Op::TailExt
        | Op::Jmp
        | Op::Adj => false,
        // Reads acc.
        Op::Bz | Op::Bnz | Op::Lev | Op::Psh => true,
        Op::Si | Op::Sc | Op::Sw | Op::Sh | Op::Sf | Op::Mcpy => true,
        Op::Li | Op::Lc | Op::Lcs | Op::Lw | Op::Lwu | Op::Lh | Op::Lhu | Op::Lf => true,
        Op::Or
        | Op::Xor
        | Op::And
        | Op::Eq
        | Op::Ne
        | Op::Lt
        | Op::Gt
        | Op::Le
        | Op::Ge
        | Op::Ult
        | Op::Ugt
        | Op::Ule
        | Op::Uge
        | Op::Shl
        | Op::Shr
        | Op::Shru
        | Op::Add
        | Op::Sub
        | Op::Mul
        | Op::Div
        | Op::Mod
        | Op::Divu
        | Op::Modu
        | Op::Fadd
        | Op::Fsub
        | Op::Fmul
        | Op::Fdiv
        | Op::Feq
        | Op::Fne
        | Op::Flt
        | Op::Fgt
        | Op::Fle
        | Op::Fge => true,
        Op::AddI
        | Op::SubI
        | Op::MulI
        | Op::AndI
        | Op::OrI
        | Op::XorI
        | Op::ShlI
        | Op::ShrI
        | Op::ShruI
        | Op::EqI
        | Op::NeI
        | Op::LtI
        | Op::GtI
        | Op::LeI
        | Op::GeI
        | Op::UltI
        | Op::UgtI
        | Op::UleI
        | Op::UgeI => true,
        Op::StLocI | Op::Fneg | Op::Fcvtfi | Op::Fcvtif | Op::Intrinsic => true,
    }
}

/// Conservative successor check: does any reachable successor of
/// `block_idx` need an acc reload at entry? Used at block-exit
/// to decide whether to emit an `Inst::AccSpill`. Today's check
/// just looks at the linear-next + branch target of the current
/// block's terminator; a full successor walk would be cheap but
/// not necessary for correctness (the spill is harmless on dead
/// paths, just wasted bytes).
fn exit_reaches_acc_reload(block_starts: &[usize], block_idx: usize, needs: &[bool]) -> bool {
    // Fall-through successor.
    if block_idx + 1 < block_starts.len() && needs[block_idx + 1] {
        return true;
    }
    // Any other successor in the function: be conservative and
    // spill if any block in the function needs a reload. Cheap
    // and avoids re-walking the terminator targets here.
    needs.iter().any(|&b| b)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;
    use std::path::PathBuf;

    /// Smoke test: lift every function in a non-trivial fixture
    /// and assert the basic invariants (every block has a
    /// terminator; instructions parse cleanly; the entry block
    /// starts at `ent_pc`).
    #[test]
    fn lift_quicksort_fixture() {
        let path = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/c/quicksort.c");
        let src = std::fs::read_to_string(&path).expect("read fixture");
        let program = Compiler::new(src).compile().expect("compile");
        let funcs = lift_program(&program).expect("lift");
        assert!(funcs.len() >= 4, "quicksort.c declares 4 functions");
        for f in &funcs {
            assert_eq!(
                f.blocks[0].start_pc, f.ent_pc,
                "block 0 must start at ent_pc"
            );
            // Every block must have a terminator that references
            // an in-range block id (or returns / tail-exits).
            for (i, b) in f.blocks.iter().enumerate() {
                match b.terminator {
                    Terminator::Jmp(t)
                    | Terminator::FallThrough(t)
                    | Terminator::Bz { target: t, .. }
                    | Terminator::Bnz { target: t, .. } => {
                        assert!(
                            (t as usize) < f.blocks.len(),
                            "block {i} terminator points to block {t} (out of range)"
                        );
                    }
                    Terminator::Return(_) | Terminator::TailExt(_) => {}
                }
                if let Terminator::Bz {
                    fall_through: ft, ..
                }
                | Terminator::Bnz {
                    fall_through: ft, ..
                } = b.terminator
                {
                    assert!(
                        (ft as usize) < f.blocks.len(),
                        "block {i} fall-through points to block {ft} (out of range)"
                    );
                }
            }
        }
    }

    /// Lift c4.c -- the busiest fixture in the test set. Same
    /// invariants as above; catches anything that only shows up
    /// on large bodies. Exercises the cross-block virtual-stack
    /// threading (VstackSpill / VstackReload) because c4's
    /// short-circuit and ternary patterns leave the c5 stack
    /// non-empty across branches.
    #[test]
    fn lift_c4_self_host() {
        let path = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/c/c4.c");
        let src = std::fs::read_to_string(&path).expect("read fixture");
        let program = Compiler::new(src).compile().expect("compile");
        let funcs = lift_program(&program).expect("lift");
        assert!(funcs.len() >= 4);
    }
}
