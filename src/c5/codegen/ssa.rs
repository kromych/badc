//! SSA lift over the stack-based c5 bytecode.
//!
//! Takes a [`Program::text`] and produces, per function, a basic-block
//! graph of SSA-style [`Inst`]s. The allocator
//! (`linear_scan_allocate`, task #8) and per-arch lowering
//! (`aarch64::lower_ssa` / `x86_64::lower_ssa`, tasks #9-#10) consume
//! the result. Selected by `NativeOptions::regalloc = RegallocMode::Ssa`.
//!
//! ## Lift shape
//!
//! Each function's body is split into basic blocks at every branch
//! target (`Op::Jmp` / `Op::Bz` / `Op::Bnz` operand) and at the
//! instruction after every terminator. Within a block:
//!
//! * `Op::Imm`, `Op::Lea`, `Op::LdLocI`, `Op::LdLocC`, `Op::TlsLea`
//!   define a fresh [`Inst::Imm`] / `Inst::LocalAddr` / `Inst::Load` /
//!   `Inst::TlsAddr` value. The accumulator's current value becomes
//!   the new instruction's id.
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
use super::super::op::Op;
use super::super::program::Program;

/// Index into a function's instruction list.
pub(super) type ValueId = u32;
pub(super) const NO_VALUE: ValueId = u32::MAX;

/// Index into a function's block list.
pub(super) type BlockId = u32;

/// A single SSA instruction. Each variant carries enough operand
/// metadata for the per-arch lowering to emit native code without
/// re-walking the original bytecode.
#[derive(Debug, Clone)]
pub(super) enum Inst {
    /// Plain integer immediate (`Op::Imm` with no data / code
    /// segment provenance). Lowering uses `load_imm64`.
    Imm(i64),
    /// `Op::Imm` whose operand is a data-segment byte offset.
    /// The per-arch lowering emits an `adrp + add` placeholder
    /// pair and records a `DataFixup` so the writer can patch
    /// the page-relative immediate against `__data + offset`.
    ImmData(i64),
    /// `Op::Imm` whose operand is a function-pointer literal
    /// (`CODE_BASE + target_bc_pc`). The per-arch lowering
    /// emits an `adrp + add` placeholder pair and records a
    /// pending func-fixup so the writer can patch against the
    /// callee's body offset.
    ImmCode(usize),
    /// Address of a local or parameter slot relative to the frame
    /// pointer (`Op::Lea N`). N is the c5-slot index; locals are
    /// negative, params >= 2.
    LocalAddr(i64),
    /// Address of a thread-local variable in the per-target TLS
    /// block (`Op::TlsLea`).
    TlsAddr(i64),
    /// Load from memory. Width / signedness driven by the source
    /// load op.
    Load { addr: ValueId, kind: LoadKind },
    /// Store to memory. The c5 semantics leave the stored value
    /// in the accumulator afterward; downstream uses of this
    /// instruction's id read that value.
    Store {
        addr: ValueId,
        value: ValueId,
        kind: StoreKind,
    },
    /// Binary arithmetic / comparison / shift. `lhs` is the value
    /// that was on top of the c5 stack at the op; `rhs` is the
    /// current accumulator (matches `a = pop() <op> a` semantics).
    Binop {
        op: BinOp,
        lhs: ValueId,
        rhs: ValueId,
    },
    /// Same as `Binop` but `rhs` is a literal immediate (the
    /// optimizer's `<op>I N` fusion).
    BinopI {
        op: BinOp,
        lhs: ValueId,
        rhs_imm: i64,
    },
    /// Unary floating-point negation (`Op::Fneg`).
    Fneg(ValueId),
    /// Floating-point <-> integer cast.
    FpCast { kind: FpCastKind, value: ValueId },
    /// Direct call to a c5 user function at bytecode PC `target_pc`.
    /// The call site marshals `args` per the host ABI (the planner
    /// in `super::plan_call_args` picks per-arg placements). The
    /// instruction's defined value is the call's return slot.
    Call {
        target_pc: usize,
        args: Vec<ValueId>,
    },
    /// Indirect call: the target's address comes from `target`
    /// (typically the loaded value of a function pointer). Args
    /// flow through the same planner.
    CallIndirect { target: ValueId, args: Vec<ValueId> },
    /// External library call (`Op::JsrExt`).
    CallExt {
        binding_idx: i64,
        args: Vec<ValueId>,
        fp_arg_mask: u32,
    },
    /// Tail-jump to an external symbol (`Op::TailExt`). Used only
    /// as the body of an address-take trampoline; never has a
    /// defined value (control transfers out).
    TailExt(i64),
    /// Whole-struct memory copy (`Op::Mcpy`).
    Mcpy {
        dst: ValueId,
        src: ValueId,
        size: i64,
    },
    /// Compiler-builtin intrinsic (`Op::Intrinsic`). The discriminant
    /// is the [`Intrinsic`] enum value. Single-arg intrinsics carry
    /// one element in `args`; two-arg intrinsics (longjmp, va_start,
    /// va_copy) carry two elements with `args[0]` the pushed first
    /// arg and `args[1]` the accumulator-resident second arg. Most
    /// intrinsics return a value (alloca's new pointer, setjmp's
    /// 0-on-initial-call); longjmp does not return at all.
    Intrinsic { kind: i64, args: Vec<ValueId> },
    /// Per-frame alloca arena bookkeeping setup (`Op::AllocaInit`).
    /// Slot index is the alloca-top FP-slot offset. Produces no
    /// SSA value; emitted purely for the side effect.
    AllocaInit(i64),
    /// Spill a c5 vstack value to a function-wide spill slot.
    /// Emitted at block end when the c5 virtual stack is non-
    /// empty -- e.g. an outer expression's `Op::Psh` of the LHS
    /// straddles a branch (ternary / short-circuit) before the
    /// matching binop consumes it.
    VstackSpill { slot: u32, value: ValueId },
    /// Reload a function-wide vstack spill slot. Emitted at
    /// block start, one per still-live vstack entry. The
    /// instruction's id becomes the new SSA name for the
    /// reloaded value; the block uses it on its local vstack
    /// without referencing the predecessor's writer.
    VstackReload { slot: u32 },
    /// Spill the accumulator across a block boundary. The c5
    /// bytecode model treats the accumulator as a single
    /// function-wide value preserved across every control-flow
    /// edge; the SSA lift instead materialises it as a fresh
    /// value per block, so cross-block reads need a memory
    /// round trip. Emitted at block exit before the terminator
    /// whenever the block has a successor that reads the entry
    /// accumulator without having written it first.
    AccSpill { value: ValueId },
    /// Reload the cross-block accumulator at block entry. The
    /// instruction's id becomes the block's initial accumulator
    /// value; subsequent ops that read `acc` (binops, stores,
    /// terminators) reference it.
    AccReload,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum LoadKind {
    /// `Op::Li` -- 8-byte signed integer.
    I64,
    /// `Op::Lc` -- 1-byte unsigned char, zero-extended.
    U8,
    /// `Op::Lcs` -- 1-byte signed char, sign-extended.
    I8,
    /// `Op::Lw` -- 4-byte signed int, sign-extended.
    I32,
    /// `Op::Lwu` -- 4-byte unsigned int, zero-extended.
    U32,
    /// `Op::Lh` -- 2-byte signed short, sign-extended.
    I16,
    /// `Op::Lhu` -- 2-byte unsigned short, zero-extended.
    U16,
    /// `Op::Lf` -- 4-byte float widened to f64.
    F32,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum StoreKind {
    /// `Op::Si` -- 8-byte integer.
    I64,
    /// `Op::Sc` -- 1-byte char.
    I8,
    /// `Op::Sw` -- 4-byte int.
    I32,
    /// `Op::Sh` -- 2-byte short.
    I16,
    /// `Op::Sf` -- 4-byte float (narrowed from f64).
    F32,
}

/// Integer / FP binary opcode. Mirrors the c5 bytecode binop set;
/// the planner's choice between signed / unsigned forms is
/// preserved (Div vs Divu, Shr vs Shru).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum BinOp {
    Or,
    Xor,
    And,
    Eq,
    Ne,
    Lt,
    Gt,
    Le,
    Ge,
    Ult,
    Ugt,
    Ule,
    Uge,
    Shl,
    Shr,
    Shru,
    Add,
    Sub,
    Mul,
    Div,
    Mod,
    Divu,
    Modu,
    Fadd,
    Fsub,
    Fmul,
    Fdiv,
    Feq,
    Fne,
    Flt,
    Fgt,
    Fle,
    Fge,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(super) enum FpCastKind {
    /// `Op::Fcvtfi` -- truncating f64 to i64.
    FpToInt,
    /// `Op::Fcvtif` -- i64 to f64.
    IntToFp,
}

/// A basic block's terminator. Drives the block's control-flow
/// successor edges.
#[derive(Debug, Clone, Copy)]
pub(super) enum Terminator {
    /// Unconditional branch to `target_block`.
    Jmp(BlockId),
    /// Conditional branch: if `cond` (the block's exit
    /// accumulator) is zero, jump to `target`; otherwise fall
    /// through to `fall_through`.
    Bz {
        cond: ValueId,
        target: BlockId,
        fall_through: BlockId,
    },
    /// Conditional branch: if `cond` is non-zero, jump to
    /// `target`; otherwise fall through.
    Bnz {
        cond: ValueId,
        target: BlockId,
        fall_through: BlockId,
    },
    /// Return the accumulator value (`Op::Lev`). The per-arch
    /// lowering moves `value` into the host's int / FP return
    /// register.
    Return(ValueId),
    /// `Op::TailExt`: tail-jump to a libc symbol. The trampoline
    /// shape doesn't return through here.
    TailExt(i64),
    /// Synthetic fall-through when the bytecode walker hits a
    /// block boundary without an explicit terminator. Used at
    /// function boundaries where the next op is the successor
    /// function's `Op::Ent` -- the walker closes the block,
    /// records this terminator, and moves on.
    FallThrough(BlockId),
}

/// A single basic block of SSA instructions plus its terminator.
#[derive(Debug, Clone)]
pub(super) struct Block {
    /// Bytecode PC of the block's first op. Useful for debug
    /// output and for the bytecode-to-native PC map.
    pub start_pc: usize,
    /// Instructions in execution order. Each entry's index within
    /// the function's flat `insts` list is its [`ValueId`]; the
    /// allocator and the per-arch lowering consume them in this
    /// order.
    pub inst_range: core::ops::Range<u32>,
    pub terminator: Terminator,
    /// Accumulator value at the end of the block (before the
    /// terminator's branch). For a `Return` block this is the
    /// returned value. `NO_VALUE` if the accumulator wasn't
    /// written in this block (rare; e.g. a block consisting of
    /// just a `Op::Jmp` to a synthetic target).
    pub exit_acc: ValueId,
}

/// Per-function SSA program. Produced by [`lift_function`],
/// consumed by the allocator and the per-arch lowering.
#[derive(Debug, Clone)]
pub(super) struct FunctionSsa {
    /// Bytecode PC of the function's `Op::Ent`. Mirrors
    /// [`super::FuncMeta::n_params`] / variadic via the codegen's
    /// per-function metadata.
    pub ent_pc: usize,
    /// Local-slot count from `Op::Ent`'s operand.
    pub locals: i64,
    /// Declared parameter count.
    pub n_params: usize,
    /// True if the function's declarator ended in `...`.
    pub is_variadic: bool,
    /// Flat list of all SSA instructions in the function, indexed
    /// by [`ValueId`]. Each [`Block::inst_range`] is a contiguous
    /// slice of this list.
    pub insts: Vec<Inst>,
    /// Basic blocks in source / execution order. Block 0 is the
    /// entry block.
    pub blocks: Vec<Block>,
    /// Function-wide count of vstack spill slots. The per-arch
    /// lowering reserves this many additional 8-byte frame slots
    /// past the regular `locals` reservation; `VstackSpill` /
    /// `VstackReload` insts read and write through them.
    pub vstack_slots: u32,
}

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

    // Block-boundary marker: a PC is a block start iff it is the
    // function's entry, a branch target, or the instruction
    // immediately after a terminator.
    let block_starts = collect_block_starts(text, ent_pc, end_pc);
    // PC -> block index (only set for PCs that start a block).
    let mut pc_to_block: alloc::collections::BTreeMap<usize, BlockId> =
        alloc::collections::BTreeMap::new();
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

    let mut insts: Vec<Inst> = Vec::new();
    let mut blocks: Vec<Block> = Vec::with_capacity(block_starts.len());

    // Walk each block sequentially, building SSA values.
    for (block_idx, &start_pc) in block_starts.iter().enumerate() {
        let end_of_block = block_starts.get(block_idx + 1).copied().unwrap_or(end_pc);
        let inst_start = insts.len() as u32;
        // Per-block state.
        let mut acc: ValueId = NO_VALUE;
        let mut vstack: Vec<ValueId> = Vec::new();
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
                    def(&mut insts, Inst::LocalAddr(n), &mut acc);
                    pc += op.word_size();
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
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: acc,
                            kind: LoadKind::I64,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Lc => {
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: acc,
                            kind: LoadKind::U8,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Lcs => {
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: acc,
                            kind: LoadKind::I8,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Lw => {
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: acc,
                            kind: LoadKind::I32,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Lwu => {
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: acc,
                            kind: LoadKind::U32,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Lh => {
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: acc,
                            kind: LoadKind::I16,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Lhu => {
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: acc,
                            kind: LoadKind::U16,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::Lf => {
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: acc,
                            kind: LoadKind::F32,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::LdLocI => {
                    let n = text[pc + 1];
                    let lea = insts.len() as ValueId;
                    insts.push(Inst::LocalAddr(n));
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: lea,
                            kind: LoadKind::I64,
                        },
                        &mut acc,
                    );
                    pc += op.word_size();
                }
                Op::LdLocC => {
                    let n = text[pc + 1];
                    let lea = insts.len() as ValueId;
                    insts.push(Inst::LocalAddr(n));
                    def(
                        &mut insts,
                        Inst::Load {
                            addr: lea,
                            kind: LoadKind::U8,
                        },
                        &mut acc,
                    );
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
                    def(&mut insts, Inst::Store { addr, value, kind }, &mut acc);
                    pc += op.word_size();
                }
                Op::StLocI => {
                    let n = text[pc + 1];
                    let lea = insts.len() as ValueId;
                    insts.push(Inst::LocalAddr(n));
                    let value = acc;
                    def(
                        &mut insts,
                        Inst::Store {
                            addr: lea,
                            value,
                            kind: StoreKind::I64,
                        },
                        &mut acc,
                    );
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
                    pc += op.word_size();
                    if nargs > 0 && pc + 1 < text.len() && Op::from_i64(text[pc]) == Some(Op::Adj) {
                        pc += Op::Adj.word_size();
                    }
                }
                Op::TailExt => {
                    let binding_idx = text[pc + 1];
                    terminator = Terminator::TailExt(binding_idx);
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
fn compute_block_entry_depths(
    text: &[i64],
    _ent_pc: usize,
    end_pc: usize,
    block_starts: &[usize],
) -> Result<Vec<u32>, C5Error> {
    let mut depths = vec![None::<u32>; block_starts.len()];
    let mut pc_to_block: alloc::collections::BTreeMap<usize, usize> =
        alloc::collections::BTreeMap::new();
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
