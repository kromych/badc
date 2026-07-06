//! Graph-coloring register allocator over the [`FunctionSsa`] output
//! of [`super::ssa`]. Produces a per-`Inst` [`Place`] (a host
//! register or a spill slot) that the per-arch SSA emit
//! (`ssa_emit_aarch64.rs` / `ssa_emit_x86_64.rs`) consumes when
//! emitting native instructions.
//!
//! ## Algorithm
//!
//! 1. Compute last-use PC per SSA value via a single backward pass.
//! 2. Union each phi result with its incoming values into congruence
//!    classes; every member of a class shares one `Place`. With no
//!    phis each class is a singleton and the step is identity.
//! 3. Compute CFG liveness and build an interference graph over the
//!    class roots: two values ever simultaneously live get an edge.
//! 4. Derive per-value constraints -- register bank (int vs FP), a
//!    must-be-callee-saved flag when the live range crosses a call,
//!    and a coalescing hint from the return / parameter / phi /
//!    call-argument / call-result hint passes.
//! 5. Color the graph greedily (`color_graph`): for each node forbid
//!    the registers held by its live neighbours, then take the hinted
//!    register if free, else a free register of the right bank
//!    (caller-saved first unless the value must survive a call), else
//!    a fresh spill slot. Pre-coloring of call arguments into the host
//!    argument registers is left to the per-arch emit pass.
//!
//! The output is intentionally minimal: each `Place` is either
//! one of the host's GPRs / FP regs or a stack slot's byte offset
//! relative to the function's locals area. The per-arch emit pass
//! is responsible for the actual code emission (load / store /
//! reg-to-reg move / call-site marshalling).

#![allow(dead_code)]

use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{
    BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator, ValueId,
};
use super::Target;

/// Where the allocator placed an SSA value.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Place {
    /// Integer / pointer GPR. Index is into the per-arch GPR
    /// table (see [`Allocation::int_pool`]).
    IntReg(u8),
    /// Floating-point register (d-reg on aarch64, xmm on x86_64).
    FpReg(u8),
    /// Frame slot at byte offset `n * 8` from the start of the
    /// SSA spill region. The emit pass adds the per-function
    /// base offset to land on a real `[fp - X]`.
    Spill(u32),
    /// No defined value (Store, AllocaInit, ...).
    None,
}

impl Place {
    /// Integer-register index when the place is `IntReg`, else
    /// `None`. The per-arch backends wrap the returned `u8` in
    /// their own `Reg` newtype before encoding.
    pub(crate) fn int_reg_u8(self) -> Option<u8> {
        if let Place::IntReg(r) = self {
            Some(r)
        } else {
            None
        }
    }

    /// FP-register index when the place is `FpReg`, else `None`.
    pub(crate) fn fp_reg_u8(self) -> Option<u8> {
        if let Place::FpReg(r) = self {
            Some(r)
        } else {
            None
        }
    }

    /// Spill-slot index when the place is `Spill`, else `None`.
    pub(crate) fn spill_slot(self) -> Option<u32> {
        if let Place::Spill(s) = self {
            Some(s)
        } else {
            None
        }
    }
}

/// Per-function allocation result. Indexed by `ValueId`.
#[derive(Debug, Clone)]
pub(crate) struct Allocation {
    /// Where each SSA value lives.
    pub places: Vec<Place>,
    /// Total spill slots reserved (in 8-byte units). The emit
    /// pass adds `vstack_slots * 8 + 8 * spill_count` bytes to
    /// the function's `locals_bytes` reservation.
    pub spill_count: u32,
    /// GPRs the allocator actually used. The emit pass saves
    /// only this subset's callee-saved entries in the prologue.
    pub gpr_used: Vec<u8>,
    /// FP regs the allocator actually used.
    pub fp_used: Vec<u8>,
    /// Number of consumers of each value. Used by the emit pass to
    /// skip pure-with-no-uses insts (dead-code elimination). A value
    /// with zero uses and no side effects produces no machine code.
    pub use_counts: Vec<u32>,
    /// Highest PC index that names each value as an operand, raised
    /// across back edges by `extend_last_use_across_blocks`. A value
    /// defined at PC `i` is live throughout `[i, last_use[i]]`. The
    /// coalescing hints read it to avoid sending a value that outlives
    /// a call into a caller-saved register the call would clobber.
    pub last_use: Vec<u32>,
    /// For `BinopI(Shr, X, K)` insts the allocator recognised as
    /// the upper half of a sign-narrow `Shl K; Shr K` pair (K in
    /// {32, 48, 56}), the original pre-narrow value (the Shl's
    /// lhs). NO_VALUE for any other inst. The emit pass collapses
    /// the pair into a single sxtw / sxth / sxtb (aarch64) or
    /// movsxd / movsx (x86_64); the upstream Shl loses its only
    /// consumer through the matching use_count decrement, so DCE
    /// kills it.
    pub sxtw_source: Vec<ValueId>,
    /// Parallel to `sxtw_source`. When `sxtw_source[i] != NO_VALUE`
    /// this holds the matching K (32 / 48 / 56) so the emit pass
    /// can pick the right sign-extend width without re-walking the
    /// inst's operands.
    pub sxtw_k: Vec<i64>,
    /// True for `Binop` / `BinopI` comparison insts that the
    /// allocator recognised as the source of a `Bz` / `Bnz`
    /// terminator's cond, with cond consumed only by that
    /// terminator and the inst sitting in the last slot of its
    /// block. The emit pass skips the `cset` materialisation and
    /// the terminator emits `b.cond` (aarch64) or `j.cond`
    /// (x86_64) directly off the flags set by `cmp`.
    pub branch_fused: Vec<bool>,
    /// Per-value coalescing hint: the physical register the
    /// allocator should prefer when one is set and free at the
    /// pick site. The pick-reg path honours the hint only when it
    /// satisfies the live-across-call constraint; unsatisfied
    /// hints are ignored, so a hint never compromises correctness.
    /// `None` for any value with no preference. Populated by the
    /// coalescing pre-passes (copy / phi congruence / call-arg /
    /// return) layered on in subsequent iterations.
    pub hints: Vec<Option<u8>>,
    /// Per-value single-precision marker copied from
    /// [`FunctionSsa::f32_values`]. `true` when the value's FP register
    /// holds an `f32` pattern (C99 6.3.1.8). The per-arch emit consults
    /// this to pick the single- vs double-precision FP encoder and to
    /// reinterpret an f32-typed `Imm` through a 32-bit `fmov` / `movd`.
    /// Empty (all-false) for SSA built outside the walker.
    pub f32_values: Vec<bool>,
    /// Per-value upper-bit observation (see
    /// `drop_redundant_extend::compute_high_observed`). The emit
    /// consults this to skip a `ParamRef` entry sign-extension when no
    /// consumer reads the parameter's bits above bit 31. Empty or
    /// out-of-range entries default to observed, keeping the extension.
    pub high_observed: Vec<bool>,
}

impl Allocation {
    /// True when value `v` holds a single-precision `f32` pattern.
    /// Out-of-range / unmarked values are double-precision.
    pub(crate) fn is_f32(&self, v: ValueId) -> bool {
        self.f32_values.get(v as usize).copied().unwrap_or(false)
    }
}

/// Set of available registers for the host target. The emit pass
/// keys off this to map allocator indices to encoding bits.
#[derive(Debug, Clone)]
pub(crate) struct RegBanks {
    /// Callee-saved GPRs available for general use (excluding
    /// fp, lr, sp, scratch).
    pub callee_gprs: &'static [u8],
    /// Caller-saved GPRs available. Live ranges that cross a
    /// call instruction must NOT be assigned here -- the
    /// allocator spills them to memory instead.
    pub caller_gprs: &'static [u8],
    /// Callee-saved FP regs the allocator may use. AAPCS64 marks
    /// d8..d15 callee-saved. SysV AMD64 marks no xmm callee-saved.
    /// Win64 marks xmm6..xmm15 non-volatile, but the x86_64
    /// prologue/epilogue emit no FP save/restore, so this bank is
    /// left empty there as well; both x86_64 ABIs force every
    /// live-across-call FP value to memory.
    pub callee_fprs: &'static [u8],
    /// Caller-saved FP regs (d0..d7 on aarch64; xmm0..xmm15 on
    /// x86_64).
    pub caller_fprs: &'static [u8],
}

impl RegBanks {
    /// Pick the register set for the target. Concrete register
    /// numbers match the per-arch encoders' Reg(N) constants;
    /// the allocator only needs the IDs to record placement
    /// decisions.
    pub fn for_target(target: Target) -> Self {
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => Self {
                // AAPCS64 caller-saved (volatile) registers: x0..x7
                // are the arg / return regs, x8 is the indirect-return
                // slot, x9..x15 are general scratch. A single flat
                // caller-saved pool lets the coalescing-hint pass
                // place a call-argument value directly in its target
                // arg register so the `mov x0..x7, xN` setup
                // disappears. x16 / x17 are the encoder scratch
                // (large-immediate and adrp / add fixups), x18 is the
                // Windows platform register, x19 is the writer's
                // address-materialisation scratch (see
                // `function_clobbers_scratch`); all stay reserved.
                // AAPCS64 callee-saved (non-volatile) GPRs are
                // x19..x28; x19 is the writer's scratch so the bank
                // starts at x20 and runs through x28.
                callee_gprs: &[20, 21, 22, 23, 24, 25, 26, 27, 28],
                caller_gprs: &[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
                callee_fprs: &[8, 9, 10, 11, 12, 13, 14, 15],
                caller_fprs: &[0, 1, 2, 3, 4, 5, 6, 7],
            },
            Target::LinuxX64 => Self {
                // System V x86_64. Callee-saved: rbx, r12, r13, r14,
                // r15. r10 and r11 stay reserved as the writer's fixed
                // scratch (`SCRATCH_R10` / `SCRATCH_R11` in
                // ssa_emit_x86_64) -- many handlers (int_or_spill_dst,
                // materialize_int for spilled sources, the Va* /
                // call-arg marshallers) write them unconditionally to
                // land a value in a known register, so the allocator
                // must not park another SSA value there. Both are
                // caller-saved, so reserving them forces no prologue
                // save and a scratch-only body stays leaf-elidable. r13
                // is an ordinary callee-saved allocation target, saved
                // only when colored. Caller-saved opens up to the SysV
                // arg regs (rdi, rsi, rdx, rcx, r8, r9) plus rax.
                callee_gprs: &[3, 12, 13, 14, 15],
                caller_gprs: &[0, 1, 2, 6, 7, 8, 9],
                callee_fprs: &[],
                caller_fprs: &[0, 1, 2, 3, 4, 5, 6, 7],
            },
            Target::WindowsX64 => Self {
                // Win64 callee-saved GPRs: rbx, rsi, rdi, r12, r13, r14,
                // r15. r10 / r11 stay reserved as the writer's fixed
                // scratch (see the LinuxX64 comment for the SCRATCH_R10
                // / SCRATCH_R11 contract); both are caller-saved. r13 is
                // an ordinary callee-saved allocation target. Caller-
                // saved opens up to the Win64 arg regs (rcx, rdx, r8,
                // r9) plus rax.
                callee_gprs: &[3, 6, 7, 12, 13, 14, 15],
                caller_gprs: &[0, 1, 2, 8, 9],
                // Win64 marks xmm6..xmm15 non-volatile (callee-saved),
                // but the x86_64 prologue/epilogue and `Frame` layout
                // reserve no space for and emit no save/restore of FP
                // registers (`emit_prologue` only spills `gpr_used`).
                // Assigning a live-across-call FP value to xmm6..xmm15
                // would therefore corrupt the caller's non-volatile
                // state on return. Keep the FP pool empty like SysV so
                // the allocator forces every live-across-call FP value
                // to memory and only ever uses the caller-saved
                // (volatile) xmm0..xmm5. xmm0..xmm5 are the Win64
                // volatile set per the x64 calling convention.
                callee_fprs: &[],
                caller_fprs: &[0, 1, 2, 3, 4, 5],
            },
        }
    }
}

/// Allocate physical placements for every value in `func`. See
/// the module docs for the algorithm.
/// Callee-saved registers the emit pass reserves as fixed scratch and
/// must preserve when the body clobbers them. The allocator's
/// `gpr_used` callee-saved filter cannot see a reserved scratch -- it
/// is never an allocator value -- so the save decision lives here.
///
/// x86_64 reserves r10/r11 (`SCRATCH_R10` / `SCRATCH_R11`), both
/// caller-saved, so it has nothing to preserve: a body that only
/// touches scratch stays leaf-elidable. aarch64 reserves x19
/// (callee-saved) as the address scratch the TLS / indirect-call /
/// intrinsic lowerings route through, and as a third modulo operand
/// when a dividend, divisor and result all spill.
///
/// The returned slice is the set of such registers actually clobbered.
/// Each target consumes it through its own prologue/epilogue path
/// (x86_64 folds it into `gpr_used_callee`; aarch64 reserves a
/// dedicated slot via `Frame::uses_x19`).
pub(crate) fn function_clobbers_scratch(
    func: &FunctionSsa,
    target: Target,
    spill_count: u32,
) -> &'static [u8] {
    match target {
        Target::LinuxX64 | Target::WindowsX64 => &[],
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            let routes_through_x19 = func.insts.iter().any(|inst| {
                matches!(
                    inst,
                    Inst::TlsAddr(_)
                        | Inst::CallIndirect { .. }
                        | Inst::CallExt { .. }
                        | Inst::Intrinsic { .. }
                )
            });
            let mod_under_spill = spill_count > 0
                && func.insts.iter().any(|inst| {
                    matches!(
                        inst,
                        Inst::Binop {
                            op: BinOp::Mod | BinOp::Modu,
                            ..
                        }
                    )
                });
            if routes_through_x19 || mod_under_spill {
                &[19]
            } else {
                &[]
            }
        }
    }
}

/// Win64 non-volatile xmm registers the x86_64 emit pass uses as fixed
/// FP scratch and must preserve. The handlers stage spilled FP
/// destinations and materialised operands through xmm14, break FP move
/// cycles / build fneg-fabs sign masks / narrow f64->f32 through xmm15,
/// and the FMA lowering uses xmm13 as a third operand slot. All three
/// sit in the Win64 callee-saved range (xmm6..xmm15), so a function that
/// performs any FP work must save and restore the caller's value -- a
/// foreign (clang/cl) caller holding a live value there across a call
/// into c5 code would otherwise see it corrupted. The check keys on the
/// presence of any FP-classed value: every xmm14/15 use materialises or
/// produces an FP value, so an FP scratch use implies such an
/// instruction. SysV marks every xmm volatile, so this applies to Win64
/// only.
fn function_clobbers_xmm_scratch(func: &FunctionSsa) -> Vec<u8> {
    // Tail-call forwarders jmp out with no epilogue, so a saved xmm could
    // never be restored; they touch no FP scratch either.
    if func
        .blocks
        .iter()
        .any(|b| matches!(b.terminator, Terminator::TailExt(_)))
    {
        return Vec::new();
    }
    if !func.insts.iter().any(produces_fp_result) {
        return Vec::new();
    }
    let mut regs = alloc::vec![14u8, 15u8];
    if func.insts.iter().any(|i| matches!(i, Inst::Fma { .. })) {
        regs.push(13);
    }
    regs
}

pub(crate) fn allocate(func: &FunctionSsa, target: Target) -> Allocation {
    let n_insts = func.insts.len();
    let mut places: Vec<Place> = vec![Place::None; n_insts];
    let mut hints: Vec<Option<u8>> = vec![None; n_insts];
    populate_return_hints(func, target, &mut hints);
    populate_param_ref_hints(func, target, &mut hints);
    populate_phi_hints(func, &mut hints);
    if n_insts == 0 {
        return Allocation {
            places,
            spill_count: 0,
            gpr_used: Vec::new(),
            fp_used: Vec::new(),
            use_counts: Vec::new(),
            last_use: Vec::new(),
            sxtw_source: Vec::new(),
            sxtw_k: Vec::new(),
            branch_fused: Vec::new(),
            hints,
            f32_values: Vec::new(),
            high_observed: Vec::new(),
        };
    }

    let banks = RegBanks::for_target(target);
    let last_use = compute_last_use(func);
    // Phi class union-find: every phi result and its incoming sources
    // join one equivalence class. The allocator places the first-
    // allocated member of a class, then routes every other member to
    // the same `Place`. For a function with no phis every class is a
    // singleton and the lookup degenerates to identity, so the path
    // collapses to today's per-value behaviour. Class-level
    // last-use is the max over all members so a value stays live
    // until every member of its class is dead.
    let liveness = super::liveness::Liveness::compute(func);
    let mut classes = super::phi_class::PhiClasses::build(func, &liveness);
    let mut calls_after_def = compute_calls_after_def(func, &liveness, target);
    // Promote per-value `calls_after_def` to the class: members share
    // one register, so a member whose own range does not cross a call
    // still needs a callee-saved home when another member's does.
    promote_calls_after_def_to_classes(&mut classes, &mut calls_after_def);
    // Call-argument coalescing hints. Run after `last_use` and
    // `calls_after_def` so the per-value safety guards can read them.
    // The prior unconditional ABI-hint pass was reverted in commit
    // 1609bbc after it sent a value to a caller-saved arg register
    // even when the value's interval extended past the call --
    // a later use then read the call-clobbered register. Restrict
    // the hint to values whose last use is exactly this call so the
    // call consumes them and there is no surviving live range to
    // protect.
    populate_call_arg_hints(func, target, &last_use, &calls_after_def, &mut hints);
    populate_call_result_hints(func, target, &calls_after_def, &mut hints);

    // Build the interference graph over phi-congruence-class roots and
    // colour it. Two values ever simultaneously live (per CFG
    // liveness) get distinct registers; a value with no free register
    // in its bank spills. Unlike a pc-interval linear scan this models
    // a value live across a back-edge passthrough block, whose live
    // range wraps the pc axis.
    let node_of: Vec<ValueId> = (0..func.insts.len() as ValueId)
        .map(|v| classes.find(v))
        .collect();
    let interference = liveness.interference(func, &node_of);
    let param_incoming_forbid = compute_param_incoming_forbid(func, target);
    let mut node_cons: Vec<Option<NodeConstraints>> = vec![None; func.insts.len()];
    for (v, inst) in func.insts.iter().enumerate() {
        if !produces_value(inst) {
            continue;
        }
        let root = node_of[v] as usize;
        let entry = node_cons[root].get_or_insert(NodeConstraints {
            is_fp: false,
            must_callee: false,
            hint: None,
            forbid: 0,
        });
        entry.is_fp = produces_fp_result(inst);
        entry.must_callee |= calls_after_def[v];
        if entry.hint.is_none() {
            entry.hint = hints[v];
        }
        entry.forbid |= param_incoming_forbid[v];
    }
    let (max_gpr, max_fpr) = pool_size_limits();
    let coloring = color_graph(
        &interference,
        &node_of,
        &node_cons,
        &banks,
        max_gpr,
        max_fpr,
        func.has_returns_twice_call,
    );
    places = coloring.places;
    let spill_count = coloring.spill_count;
    let gpr_used = coloring.gpr_used;
    let fp_used = coloring.fp_used;

    // Only callee-saved registers need prologue / epilogue
    // save and restore. Caller-saved registers are preserved
    // by the caller across the function's call sites (via the
    // `must_be_callee` filter above the allocator only places
    // live-across-call values into callee-saved registers, so a
    // caller-saved register's value never needs to survive past
    // the function's own emit). Filtering here keeps the
    // prologue's `str xN, [sp, ...]` sequence to exactly the
    // registers AAPCS64 / SysV / Win64 require the callee to
    // preserve.
    let gpr_used_callee: Vec<u8> = gpr_used
        .into_iter()
        .filter(|r| banks.callee_gprs.contains(r))
        .collect();
    // The x86_64 writer's fixed scratch (r10 / r11) is caller-saved, so
    // it needs no save: `function_clobbers_scratch` returns empty for
    // x86_64 and r13 -- now an ordinary callee-saved allocation target --
    // is already captured by the `callee_gprs` filter above when colored.
    // The aarch64 writer reserves the callee-saved x19; it consumes
    // `function_clobbers_scratch` through its own `Frame::uses_x19` path,
    // not this list, so adding it here would double-count the save.
    let mut fp_used_callee: Vec<u8> = fp_used
        .into_iter()
        .filter(|r| banks.callee_fprs.contains(r))
        .collect();
    // The x86_64 writer borrows xmm13/14/15 as fixed FP scratch. They are
    // volatile under System V but callee-saved under Win64, so a Win64
    // function that performs FP work must preserve the caller's value.
    // They sit outside `callee_fprs` (never allocator values), so the
    // filter above drops them; list the ones the body touches here so the
    // prologue / epilogue's FP-save loop preserves them, mirroring the
    // r13 GPR handling above.
    if matches!(target, Target::WindowsX64) {
        for r in function_clobbers_xmm_scratch(func) {
            if !fp_used_callee.contains(&r) {
                fp_used_callee.push(r);
            }
        }
    }
    let mut use_counts = compute_use_counts(func);
    // Recognise the c5 sign-narrow shape:
    //   Shl(X, K) ; Shr(_, K)   with K in {32, 48, 56}
    // The shift's rhs may arrive either as a `BinopI` (with the
    // immediate folded into the inst) or as a `Binop` whose `rhs`
    // names an `Imm(K)` value -- the walker produces the latter
    // because the parser emits the narrow as wrapping `Expr::Binary`
    // nodes carrying an `IntLit(K)` rhs. Decrement the producer
    // counts so DCE removes the Shl, the Shr, and the Imm(s);
    // the emit pass picks sxtw / sxth / sxtb via `sxtw_source`.
    let mut sxtw_source: Vec<ValueId> = vec![NO_VALUE; func.insts.len()];
    let mut sxtw_k: Vec<i64> = vec![0; func.insts.len()];
    let shift_shape = |inst: &Inst| -> Option<(BinOp, ValueId, i64, Option<ValueId>)> {
        match inst {
            Inst::BinopI { op, lhs, rhs_imm } => Some((*op, *lhs, *rhs_imm, None)),
            Inst::Binop { op, lhs, rhs } => {
                if let Some(Inst::Imm(k)) = func.insts.get(*rhs as usize) {
                    Some((*op, *lhs, *k, Some(*rhs)))
                } else {
                    None
                }
            }
            _ => None,
        }
    };
    // The fold reads `places[shl_src]` when the Shr is emitted, past the
    // source's coloring-visible live range (its last use is the Shl). It
    // is sound only when nothing between the pair can change that place:
    // both insts in one block, every intervening inst free of fixed
    // emit-level clobbers (calls, div/mod, register-count shifts,
    // atomics, mcpy), and no intervening definition colored onto the
    // same place.
    let mut block_of: Vec<u32> = vec![0; func.insts.len()];
    for (b, blk) in func.blocks.iter().enumerate() {
        for v in blk.inst_range.clone() {
            block_of[v as usize] = b as u32;
        }
    }
    let clobber_free = |inst: &Inst| -> bool {
        match inst {
            Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::BlockAddr(_)
            | Inst::LocalAddr(_)
            | Inst::Extend { .. }
            | Inst::FpCast { .. }
            | Inst::Fneg(_)
            | Inst::Fma { .. }
            | Inst::Load { .. }
            | Inst::LoadLocal { .. }
            | Inst::LoadIndexed { .. }
            | Inst::Store { .. }
            | Inst::StoreLocal { .. }
            | Inst::StoreIndexed { .. } => true,
            Inst::BinopI { op, .. } => {
                !matches!(op, BinOp::Div | BinOp::Divu | BinOp::Mod | BinOp::Modu)
            }
            Inst::Binop { op, .. } => !matches!(
                op,
                BinOp::Div
                    | BinOp::Divu
                    | BinOp::Mod
                    | BinOp::Modu
                    | BinOp::Shl
                    | BinOp::Shr
                    | BinOp::Shru
            ),
            _ => false,
        }
    };
    let fold_preserves_source = |shl_pc: ValueId, shr_pc: ValueId| -> bool {
        if block_of[shl_pc as usize] != block_of[shr_pc as usize] {
            return false;
        }
        let src_place = match func.insts.get(shl_pc as usize) {
            Some(inst) => match shift_shape(inst) {
                Some((_, src, _, _)) => places.get(src as usize).copied().unwrap_or(Place::None),
                None => return false,
            },
            None => return false,
        };
        for p in (shl_pc + 1)..shr_pc {
            let inst_p = &func.insts[p as usize];
            if !clobber_free(inst_p) {
                return false;
            }
            if produces_value(inst_p)
                && places.get(p as usize).copied().unwrap_or(Place::None) == src_place
            {
                return false;
            }
        }
        true
    };
    for (i, inst) in func.insts.iter().enumerate() {
        let Some((shr_op, shr_lhs, shr_k, shr_imm_v)) = shift_shape(inst) else {
            continue;
        };
        if shr_op != BinOp::Shr || !matches!(shr_k, 32 | 48 | 56) {
            continue;
        }
        let Some(shl_inst) = func.insts.get(shr_lhs as usize) else {
            continue;
        };
        let Some((shl_op, shl_src, shl_k, shl_imm_v)) = shift_shape(shl_inst) else {
            continue;
        };
        if shl_op != BinOp::Shl || shl_k != shr_k {
            continue;
        }
        if use_counts.get(shr_lhs as usize).copied().unwrap_or(0) != 1 {
            continue;
        }
        if !fold_preserves_source(shr_lhs, i as ValueId) {
            continue;
        }
        sxtw_source[i] = shl_src;
        sxtw_k[i] = shr_k;
        use_counts[shr_lhs as usize] = 0;
        if let Some(v) = shl_imm_v {
            let slot = &mut use_counts[v as usize];
            *slot = slot.saturating_sub(1);
        }
        if let Some(v) = shr_imm_v {
            let slot = &mut use_counts[v as usize];
            *slot = slot.saturating_sub(1);
        }
    }
    // Recognise comparison-feeding-branch sites. The terminator's
    // cond must be the immediately-preceding inst in its block,
    // be a Binop / BinopI with a comparison op, and have a single
    // consumer (the terminator). Mark it; the emit pass drops the
    // `cset` and the terminator picks `b.cond` instead of `cbz`.
    let mut branch_fused: Vec<bool> = vec![false; func.insts.len()];
    for block in &func.blocks {
        let cond = match block.terminator {
            super::super::ir::Terminator::Bz { cond, .. }
            | super::super::ir::Terminator::Bnz { cond, .. } => cond,
            _ => continue,
        };
        if cond == NO_VALUE {
            continue;
        }
        if cond + 1 != block.inst_range.end {
            continue;
        }
        if use_counts.get(cond as usize).copied().unwrap_or(0) != 1 {
            continue;
        }
        let is_compare = matches!(
            func.insts.get(cond as usize),
            Some(Inst::Binop { op, .. }) | Some(Inst::BinopI { op, .. })
                if matches!(
                    op,
                    BinOp::Eq | BinOp::Ne
                        | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge
                        | BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge
                )
        );
        if is_compare {
            branch_fused[cond as usize] = true;
        }
    }
    // Drop the "value-also-in-acc" propagate slot for stores whose
    // defined value is unread. c5 store ops leave the stored value
    // in the accumulator; if nothing downstream reads it, the emit
    // path's mov-to-dst is dead work. Setting the Place to None
    // makes int_or_spill_dst short-circuit and skip the propagate.
    for (v, inst) in func.insts.iter().enumerate() {
        if use_counts[v] == 0
            && matches!(
                inst,
                Inst::Store { .. } | Inst::StoreLocal { .. } | Inst::StoreIndexed { .. }
            )
        {
            places[v] = Place::None;
        }
    }
    #[cfg(feature = "codegen_test")]
    verify_allocation(func, &places, target, &liveness);

    Allocation {
        places,
        spill_count,
        gpr_used: gpr_used_callee,
        fp_used: fp_used_callee,
        use_counts,
        last_use,
        sxtw_source,
        sxtw_k,
        branch_fused,
        hints,
        f32_values: func.f32_values.clone(),
        high_observed: crate::c5::codegen::passes::drop_redundant_extend::compute_high_observed(
            func,
        ),
    }
}

/// Check the register-allocation correctness invariants against the
/// CFG liveness and report any violation. Enabled only under the
/// `codegen_test` feature and only when `BADC_VERIFY_ALLOC` is set, so
/// it never runs in a production or normal test build. The check is a
/// diagnostic: it prints each violating value, the invariant it broke,
/// and the function's entry pc, then returns. It is intentionally
/// O(n^2) within a physical location -- correctness, not speed, is the
/// goal here.
///
/// Invariants checked:
///
/// * Distinct location: two values that interfere (overlapping live
///   ranges) must not share a physical location (register or spill slot).
/// * Cross-call discipline: a value whose live range spans a call must
///   be callee-saved or spilled, never caller-saved (the call clobbers
///   the caller bank).
/// * Register class: a value's place must match its register class (FP
///   value in an FP register, integer value in an integer register or
///   slot).
/// * FP phi class: a phi's register class must match every operand's.
#[cfg(feature = "codegen_test")]
fn verify_allocation(
    func: &FunctionSsa,
    places: &[Place],
    target: Target,
    liveness: &super::liveness::Liveness,
) {
    if std::env::var("BADC_VERIFY_ALLOC").is_err() {
        return;
    }
    let banks = RegBanks::for_target(target);
    let report = |msg: alloc::string::String| {
        eprintln!(
            "VERIFY-VIOLATION fn={} ent_pc={}: {msg}",
            func.name, func.ent_pc
        );
    };

    // Cross-call discipline: caller-saved registers do not survive a call.
    for (c, inst) in func.insts.iter().enumerate() {
        if !matches!(
            inst,
            Inst::Call { .. } | Inst::CallExt { .. } | Inst::CallIndirect { .. }
        ) {
            continue;
        }
        let cid = c as ValueId;
        for v in 0..func.insts.len() {
            let vid = v as ValueId;
            if vid == cid || !liveness.live_after(func, vid, cid) {
                continue;
            }
            match places.get(v).copied().unwrap_or(Place::None) {
                Place::IntReg(r) if banks.caller_gprs.contains(&r) => report(alloc::format!(
                    "cross-call: v{v} in caller-saved int reg {r} is live across the call at v{c}"
                )),
                Place::FpReg(r) if banks.caller_fprs.contains(&r) => report(alloc::format!(
                    "cross-call: v{v} in caller-saved fp reg {r} is live across the call at v{c}"
                )),
                _ => {}
            }
        }
    }

    // Register class: a value's place must match its register file.
    for (v, inst) in func.insts.iter().enumerate() {
        if !produces_value(inst) {
            continue;
        }
        let is_fp = produces_fp_result(inst);
        match places.get(v).copied().unwrap_or(Place::None) {
            Place::FpReg(_) if !is_fp => report(alloc::format!(
                "class: integer v{v} placed in an fp register"
            )),
            Place::IntReg(_) if is_fp => report(alloc::format!(
                "class: fp v{v} placed in an integer register"
            )),
            _ => {}
        }
    }

    // FP phi class: a phi's register class must match every operand's.
    // An FP phi is permitted (its root and operands all live in the FP
    // file), but a phi must never merge an FP value with an integer one
    // -- the predecessor-exit move that lowers the phi copies within one
    // register file, so a class-crossing operand would emit a bit-
    // reinterpreting move into the wrong file.
    for (v, inst) in func.insts.iter().enumerate() {
        let Inst::Phi { incoming, .. } = inst else {
            continue;
        };
        let phi_fp = produces_fp_result(inst);
        for &(_, src) in incoming {
            if (src as usize) >= func.insts.len() {
                continue;
            }
            let op_fp = produces_fp_result(&func.insts[src as usize]);
            if op_fp != phi_fp {
                report(alloc::format!(
                    "phi class: phi v{v} (fp={phi_fp}) merges operand v{src} (fp={op_fp}) of a different register class"
                ));
            }
        }
    }

    // Distinct location: interfering values must hold distinct physical
    // locations. Group by place and check interference only within a group.
    let key = |p: Place| -> Option<(u8, u32)> {
        match p {
            Place::IntReg(r) => Some((0, r as u32)),
            Place::FpReg(r) => Some((1, r as u32)),
            Place::Spill(s) => Some((2, s)),
            Place::None => None,
        }
    };
    let mut by_place: alloc::collections::BTreeMap<(u8, u32), Vec<usize>> =
        alloc::collections::BTreeMap::new();
    for (v, p) in places.iter().enumerate() {
        if let Some(k) = key(*p) {
            by_place.entry(k).or_default().push(v);
        }
    }
    for (k, vs) in &by_place {
        for i in 0..vs.len() {
            for j in (i + 1)..vs.len() {
                if liveness.interfere(func, vs[i] as ValueId, vs[j] as ValueId) {
                    report(alloc::format!(
                        "interference: v{} and v{} share place {k:?} yet interfere",
                        vs[i],
                        vs[j]
                    ));
                }
            }
        }
    }

    // Parameter shuffle clobber: the entry placement moves each
    // parameter from its distinct incoming argument register to its home.
    // When all homes are distinct the emit runs it as a parallel copy
    // that reads every source before any write, so a home equal to
    // another parameter's incoming register is harmless. When two
    // parameters share a home the emit falls back to placing each
    // ParamRef in program order, and then an earlier parameter whose
    // home is a later parameter's incoming register overwrites that
    // register before the later ParamRef reads it. This models that
    // exact condition (the witness is the four-parameter
    // `param_incoming_reg_clobber.c` shape).
    if !func.is_variadic {
        let mut used = alloc::vec![false; func.insts.len()];
        for inst in &func.insts {
            for_each_operand(inst, |op| {
                if (op as usize) < used.len() {
                    used[op as usize] = true;
                }
            });
        }
        for block in &func.blocks {
            match &block.terminator {
                Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                    if (*cond as usize) < used.len() {
                        used[*cond as usize] = true;
                    }
                }
                Terminator::Return(v) if (*v as usize) < used.len() => {
                    used[*v as usize] = true;
                }
                Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. }
                    if (*target as usize) < used.len() =>
                {
                    used[*target as usize] = true;
                }
                _ => {}
            }
        }
        let int_args: &[u8] = match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                &[0, 1, 2, 3, 4, 5, 6, 7]
            }
            Target::LinuxX64 => &[7, 6, 2, 1, 8, 9],
            Target::WindowsX64 => &[1, 2, 8, 9],
        };
        // (value index, home, incoming register) for each used integer
        // ParamRef placed in a register or spill slot.
        let mut params: Vec<(usize, Place, u8)> = Vec::new();
        for (vid, inst) in func.insts.iter().enumerate() {
            let Inst::ParamRef { idx, .. } = inst else {
                continue;
            };
            let pi = *idx as usize;
            if (func.param_fp_mask & (1u32 << pi)) != 0 || !used[vid] {
                continue;
            }
            let int_rank = (0..pi)
                .filter(|&j| (func.param_fp_mask & (1u32 << j)) == 0)
                .count();
            let Some(&incoming) = int_args.get(int_rank) else {
                continue;
            };
            let home = places.get(vid).copied().unwrap_or(Place::None);
            if matches!(home, Place::IntReg(_) | Place::Spill(_)) {
                params.push((vid, home, incoming));
            }
        }
        let homes_distinct = (0..params.len())
            .all(|a| ((a + 1)..params.len()).all(|b| key(params[a].1) != key(params[b].1)));
        if !homes_distinct {
            for a in 0..params.len() {
                for b in 0..params.len() {
                    if params[a].0 < params[b].0
                        && matches!(params[a].1, Place::IntReg(r) if r == params[b].2)
                    {
                        report(alloc::format!(
                            "param-shuffle-clobber: ParamRef v{} home {:?} is the incoming \
                             register of later ParamRef v{}; per-inst placement clobbers it",
                            params[a].0,
                            params[a].1,
                            params[b].0
                        ));
                    }
                }
            }
        }
    }
}

/// Coloring constraints for one allocation node (a phi-congruence
/// root). Absent for values that are not the root of their class or
/// that define no placed value.
#[derive(Clone, Copy)]
pub(crate) struct NodeConstraints {
    /// The node's value lives in the FP register file.
    pub is_fp: bool,
    /// The node's live range crosses a call, so a caller-saved
    /// register would be clobbered; it must take a callee-saved
    /// register or spill.
    pub must_callee: bool,
    /// Preferred register, honoured when free and bank-legal.
    pub hint: Option<u8>,
    /// Physical registers (in this node's bank) the colorer must not
    /// assign, beyond interference. Bit `r` set forbids register `r`.
    /// Used to keep a `ParamRef` off the incoming argument register of a
    /// later same-bank `ParamRef`, whose incoming value is still live.
    pub forbid: u64,
}

/// Result of coloring the interference graph.
pub(crate) struct Coloring {
    /// Placement per value. Non-root values inherit their root's
    /// placement; nodes with no constraint stay `Place::None`.
    pub places: Vec<Place>,
    pub spill_count: u32,
    pub gpr_used: Vec<u8>,
    pub fp_used: Vec<u8>,
}

#[cfg(feature = "std")]
thread_local! {
    /// Per-thread override for the register-pressure caps. `Some((g, f))`
    /// forces the integer / FP bank caps; `None` (the default) consults
    /// the environment. Tests that need a specific pressure level set this
    /// via [`with_pool_size_override`] so a parallel test on another thread
    /// does not see the change.
    static POOL_SIZE_OVERRIDE: core::cell::Cell<Option<(usize, usize)>> =
        const { core::cell::Cell::new(None) };
}

/// Run `f` with the per-thread register-pressure caps set to
/// `(max_gpr, max_fpr)`, restoring the prior value on return or unwind.
#[cfg(feature = "std")]
#[allow(dead_code)]
pub(crate) fn with_pool_size_override<R>(
    max_gpr: usize,
    max_fpr: usize,
    f: impl FnOnce() -> R,
) -> R {
    let prior = POOL_SIZE_OVERRIDE.with(|cell| cell.replace(Some((max_gpr, max_fpr))));
    struct Restore(Option<(usize, usize)>);
    impl Drop for Restore {
        fn drop(&mut self) {
            POOL_SIZE_OVERRIDE.with(|cell| cell.set(self.0));
        }
    }
    let _restore = Restore(prior);
    f()
}

/// Per-bank register count caps. Both default to `usize::MAX` (no cap),
/// so a production build allocates over the full register file. The
/// per-thread override (set by [`with_pool_size_override`]) always
/// takes precedence. Under the `codegen_test` feature the
/// `BADC_MAX_GPR` / `BADC_MAX_FPR` environment variables truncate the
/// integer / FP banks; without the feature they are ignored.
fn pool_size_limits() -> (usize, usize) {
    #[cfg(feature = "std")]
    if let Some(caps) = POOL_SIZE_OVERRIDE.with(|cell| cell.get()) {
        return caps;
    }
    #[cfg(feature = "codegen_test")]
    {
        let read = |name: &str| -> usize {
            std::env::var(name)
                .ok()
                .and_then(|v| v.parse::<usize>().ok())
                .map(|n| n.max(1))
                .unwrap_or(usize::MAX)
        };
        (read("BADC_MAX_GPR"), read("BADC_MAX_FPR"))
    }
    #[cfg(not(feature = "codegen_test"))]
    {
        (usize::MAX, usize::MAX)
    }
}

/// Assign a register or spill slot to every constrained node so that
/// no two interfering nodes share a register, then propagate each
/// node's placement to its class members. Greedy coloring: nodes are
/// processed in ascending id (roughly definition order); a node takes
/// its hint when bank-legal and free, otherwise a caller-saved
/// register (to avoid a prologue save) unless it must be callee-saved,
/// otherwise a callee-saved register, and spills when its bank offers
/// no free register. The interference graph (built from CFG liveness)
/// is the sole source of conflicts, so a value live across a back-edge
/// passthrough block is never given a register that block reuses.
pub(crate) fn color_graph(
    interference: &super::liveness::Interference,
    node_of: &[ValueId],
    constraints: &[Option<NodeConstraints>],
    banks: &RegBanks,
    max_gpr: usize,
    max_fpr: usize,
    no_slot_share: bool,
) -> Coloring {
    let n = node_of.len();
    let mut color: Vec<Place> = vec![Place::None; n];
    let mut spill_count: u32 = 0;
    // Per-slot "stamp" marking which slots interfering neighbours hold,
    // refreshed per node by bumping `stamp` instead of clearing. Slot
    // indices are bounded by `spill_count <= n`, so `n` entries suffice.
    // This keeps the free-slot search O(spill_count) per node rather than
    // O(spill_count * neighbours): the membership test is an array read,
    // not a linear scan of the neighbour list.
    let mut slot_used: Vec<u32> = vec![0u32; n];
    let mut stamp: u32 = 0;
    for node in 0..n {
        let Some(c) = constraints[node] else {
            continue;
        };
        stamp += 1;
        let mut forbidden: [bool; 64] = [false; 64];
        // A spill slot is 8 bytes of stack shared bank-agnostically (FP
        // and integer spills both store/reload 8 bytes), so a slot held
        // by any interfering neighbour is off-limits regardless of bank.
        for &nb in interference.neighbors(node as ValueId) {
            match color[nb as usize] {
                Place::IntReg(r) if !c.is_fp => forbidden[r as usize] = true,
                Place::FpReg(r) if c.is_fp => forbidden[r as usize] = true,
                Place::Spill(s) => slot_used[s as usize] = stamp,
                _ => {}
            }
        }
        // Registers excluded beyond interference: the incoming argument
        // registers of later same-bank `ParamRef`s whose values are still
        // live at this node's definition. The forbid mask is in this
        // node's bank (set only for matching `is_fp`).
        for r in 0..64u8 {
            if (c.forbid >> r) & 1 != 0 {
                forbidden[r as usize] = true;
            }
        }
        // Bank size cap: BADC_MAX_GPR / BADC_MAX_FPR truncate each bank
        // to raise register pressure across the suite. Off (usize::MAX)
        // by default. The first `max` entries of each bank are kept so a
        // single value still has a non-empty palette to spill out of.
        let cap = if c.is_fp { max_fpr } else { max_gpr };
        let (callee_full, caller_full) = if c.is_fp {
            (banks.callee_fprs, banks.caller_fprs)
        } else {
            (banks.callee_gprs, banks.caller_gprs)
        };
        let callee = &callee_full[..callee_full.len().min(cap)];
        let caller = &caller_full[..caller_full.len().min(cap)];
        let free = |r: u8| !forbidden[r as usize];
        let pick = c
            .hint
            .filter(|&h| {
                free(h) && (callee.contains(&h) || (!c.must_callee && caller.contains(&h)))
            })
            .or_else(|| {
                if c.must_callee {
                    callee.iter().copied().find(|&r| free(r))
                } else {
                    caller
                        .iter()
                        .copied()
                        .find(|&r| free(r))
                        .or_else(|| callee.iter().copied().find(|&r| free(r)))
                }
            });
        color[node] = match pick {
            Some(r) if c.is_fp => Place::FpReg(r),
            Some(r) => Place::IntReg(r),
            None => {
                // Reuse the lowest existing slot held by no interfering
                // neighbour; allocate a fresh slot only when every one
                // collides. Two values share a slot only when no
                // interference edge joins them -- i.e. they are never
                // simultaneously live -- so the slot holds at most one
                // live value at any point. Edges are bidirectional, so a
                // later-coloured value that interferes excludes this
                // slot, preserving distinct storage for live ranges that
                // overlap.
                //
                // `no_slot_share` (the caller invokes a returns-twice
                // function): liveness no longer bounds slot lifetime. A
                // value dead on the first-return path is still read
                // after the second return -- C99 7.13.2.1p3 for setjmp,
                // and under vfork the child's writes land on the
                // parent's shared stack -- so every value gets a
                // dedicated slot.
                let slot = if no_slot_share {
                    None
                } else {
                    (0..spill_count).find(|&s| slot_used[s as usize] != stamp)
                }
                .unwrap_or_else(|| {
                    let s = spill_count;
                    spill_count += 1;
                    s
                });
                Place::Spill(slot)
            }
        };
    }

    let mut places: Vec<Place> = vec![Place::None; n];
    for v in 0..n {
        let root = node_of[v] as usize;
        if constraints[root].is_some() {
            places[v] = color[root];
        }
    }
    let mut gpr_used: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();
    let mut fp_used: alloc::collections::BTreeSet<u8> = alloc::collections::BTreeSet::new();
    for c in &color {
        match c {
            Place::IntReg(r) => {
                gpr_used.insert(*r);
            }
            Place::FpReg(r) => {
                fp_used.insert(*r);
            }
            _ => {}
        }
    }
    Coloring {
        places,
        spill_count,
        gpr_used: gpr_used.into_iter().collect(),
        fp_used: fp_used.into_iter().collect(),
    }
}

/// Count consumers for every SSA value, then iterate to fixed point
/// so transitively-dead pure insts also drop to use_count == 0.
/// Drives the emit pass's dead-code skip.
fn compute_use_counts(func: &FunctionSsa) -> Vec<u32> {
    let n = func.insts.len();
    let mut counts: Vec<u32> = vec![0; n];
    let bump_into = |counts: &mut Vec<u32>, v: ValueId| {
        if v != NO_VALUE && (v as usize) < n {
            counts[v as usize] += 1;
        }
    };
    let decrement = |counts: &mut Vec<u32>, v: ValueId| {
        if v != NO_VALUE && (v as usize) < n && counts[v as usize] > 0 {
            counts[v as usize] -= 1;
        }
    };
    for inst in &func.insts {
        for_each_operand(inst, |op| bump_into(&mut counts, op));
    }
    for inst in &func.insts {
        if let Inst::CallIndirect { target, .. } = inst {
            bump_into(&mut counts, *target);
        }
    }
    for block in &func.blocks {
        match block.terminator {
            super::super::ir::Terminator::Bz { cond, .. } => bump_into(&mut counts, cond),
            super::super::ir::Terminator::Bnz { cond, .. } => bump_into(&mut counts, cond),
            super::super::ir::Terminator::Return(v) => bump_into(&mut counts, v),
            super::super::ir::Terminator::GotoIndirect { target }
            | super::super::ir::Terminator::JumpTable { idx: target, .. } => {
                bump_into(&mut counts, target)
            }
            _ => {}
        }
    }
    // Iterate to fixed point: a pure inst with zero uses is dead;
    // its operand references stop counting. Worst case O(n^2)
    // but n is typically small (per-function inst count) and the
    // fixed point converges in few passes (chain length).
    let mut killed: Vec<bool> = vec![false; n];
    loop {
        let mut changed = false;
        for (i, inst) in func.insts.iter().enumerate() {
            if killed[i] || !is_pure_inst(inst) {
                continue;
            }
            if counts[i] == 0 {
                killed[i] = true;
                changed = true;
                for_each_operand(inst, |op| decrement(&mut counts, op));
            }
        }
        if !changed {
            break;
        }
    }
    counts
}

/// True when the inst has no side effects and can be DCE'd if its
/// result is unread. Mirrors `is_dead_pure` in ssa_emit_common but
/// kept here to drive the allocator's use-count fixed-point pass.
/// A volatile load is an access the abstract machine performs even
/// when the value is unused (C99 5.1.2.3p2 / 6.7.3p6), so it is
/// never pure.
fn is_pure_inst(inst: &Inst) -> bool {
    matches!(
        inst,
        Inst::Imm(_)
            | Inst::ImmData(_)
            | Inst::ImmCode(_)
            | Inst::ImmExtCode(_)
            | Inst::LocalAddr(_)
            | Inst::TlsAddr(_)
            | Inst::Load {
                volatile: false,
                ..
            }
            | Inst::LoadLocal {
                volatile: false,
                ..
            }
            | Inst::LoadIndexed { .. }
            | Inst::Binop { .. }
            | Inst::BinopI { .. }
            | Inst::Fneg(_)
            | Inst::Fma { .. }
            | Inst::FpCast { .. }
            | Inst::Extend { .. }
    )
}

/// Whether `inst` is the inline setjmp intrinsic. A longjmp back to
/// the setjmp site restores only the jmp_buf register set (x19-x28,
/// x29, sp, d8-d15), so for allocation the site clobbers the
/// caller-saved banks exactly like a call (C99 7.13.2.1p3 requires
/// values unmodified since setjmp to survive the second return).
pub(crate) fn is_setjmp_barrier(inst: &Inst) -> bool {
    matches!(
        inst,
        Inst::Intrinsic { kind, .. }
            if *kind == crate::c5::op::Intrinsic::SetjmpAArch64 as i64
    )
}

/// Invoke `f` for each operand `ValueId` referenced by `inst`.
pub(crate) fn for_each_operand(inst: &Inst, mut f: impl FnMut(ValueId)) {
    match inst {
        Inst::Imm(_)
        | Inst::ImmData(_)
        | Inst::ImmCode(_)
        | Inst::ImmExtCode(_)
        | Inst::BlockAddr(_)
        | Inst::LocalAddr(_)
        | Inst::TlsAddr(_)
        | Inst::AllocaInit(_)
        | Inst::ParamRef { .. }
        | Inst::TailExt(_)
        | Inst::LoadLocal { .. } => {}
        Inst::Load { addr, .. } => f(*addr),
        Inst::Store { addr, value, .. } => {
            f(*addr);
            f(*value);
        }
        Inst::StoreLocal { value, .. } => f(*value),
        Inst::LoadIndexed { base, index, .. } => {
            f(*base);
            f(*index);
        }
        Inst::StoreIndexed {
            base, index, value, ..
        } => {
            f(*base);
            f(*index);
            f(*value);
        }
        Inst::Binop { lhs, rhs, .. } => {
            f(*lhs);
            f(*rhs);
        }
        Inst::BinopI { lhs, .. } => f(*lhs),
        Inst::Fneg(v) => f(*v),
        Inst::Fma { a, b, c, .. } => {
            f(*a);
            f(*b);
            f(*c);
        }
        Inst::Extend { value, .. } => f(*value),
        Inst::FpCast { value, .. } => f(*value),
        Inst::Intrinsic { kind, args } => {
            // The VaArg intrinsic's second operand is a compile-time
            // packed type descriptor (`(kind << 16) | size`); the
            // per-target emit reads it from the constant `Inst::Imm`
            // directly (System V routes the gp / fp save area by it; the
            // cursor / stack targets ignore it). It is never a runtime
            // value, so it must not contribute a use that would force the
            // descriptor `Inst::Imm` to be materialised into a register.
            // Skipping it keeps the descriptor dead (DCE'd at emit time)
            // and the stack-based targets byte-identical.
            let is_va_arg = *kind == crate::c5::op::Intrinsic::VaArg as i64;
            for (i, &a) in args.iter().enumerate() {
                if is_va_arg && i == 1 {
                    continue;
                }
                f(a);
            }
        }
        Inst::Call { args, .. } | Inst::CallExt { args, .. } => {
            for &a in args {
                f(a);
            }
        }
        Inst::CallIndirect { target, args, .. } => {
            f(*target);
            for &a in args {
                f(a);
            }
        }
        Inst::Mcpy { dst, src, .. } => {
            f(*dst);
            f(*src);
        }
        Inst::AtomicRmw { addr, value, .. } => {
            f(*addr);
            f(*value);
        }
        Inst::AtomicCas {
            addr,
            expected_addr,
            desired,
            ..
        } => {
            f(*addr);
            f(*expected_addr);
            f(*desired);
        }
        Inst::Phi { incoming, .. } => {
            for (_, v) in incoming {
                f(*v);
            }
        }
    }
}

/// Whether an instruction defines an int / FP value or none at all.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum ResultKind {
    Int,
    Fp,
    None,
}

/// Whether an instruction's result lives in the FP register file.
/// Used by `ssa_mem2reg` to keep a register-file-consistent rewrite:
/// an `I64` slot load is integer-classed, so a slot may be promoted
/// only when its stored values are integer-classed too.
pub(crate) fn produces_fp_result(inst: &Inst) -> bool {
    matches!(result_kind(inst), ResultKind::Fp)
}

/// Whether an instruction defines a value that needs a register or
/// spill slot. `Store` / `AllocaInit` and other side-effect-only insts
/// produce no placed value.
pub(crate) fn produces_value(inst: &Inst) -> bool {
    !matches!(result_kind(inst), ResultKind::None)
}

fn result_kind(inst: &Inst) -> ResultKind {
    use Inst::*;
    match inst {
        Imm(_) | ImmData(_) | ImmCode(_) | ImmExtCode(_) | BlockAddr(_) | LocalAddr(_)
        | TlsAddr(_) => ResultKind::Int,
        // A parameter seeded with an FP load kind arrives in an FP
        // argument register; classify it accordingly so the seed and
        // its consumers share the FP register file.
        ParamRef { kind, .. } => match kind {
            LoadKind::F32 | LoadKind::F64 => ResultKind::Fp,
            _ => ResultKind::Int,
        },
        Phi { kind, .. } => match kind {
            LoadKind::F32 | LoadKind::F64 => ResultKind::Fp,
            _ => ResultKind::Int,
        },
        Load { kind, .. } | LoadLocal { kind, .. } => match kind {
            LoadKind::F32 | LoadKind::F64 => ResultKind::Fp,
            _ => ResultKind::Int,
        },
        Store {
            kind: StoreKind::F32 | StoreKind::F64,
            ..
        }
        | StoreLocal {
            kind: StoreKind::F32 | StoreKind::F64,
            ..
        } => ResultKind::Fp,
        Store { .. } | StoreLocal { .. } | StoreIndexed { .. } => ResultKind::Int,
        LoadIndexed { kind, .. } => match kind {
            LoadKind::F32 | LoadKind::F64 => ResultKind::Fp,
            _ => ResultKind::Int,
        },
        Binop { op, .. } | BinopI { op, .. } => match op {
            BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv => ResultKind::Fp,
            // FP comparisons return an integer 0/1.
            _ => ResultKind::Int,
        },
        Fneg(_) => ResultKind::Fp,
        Fma { .. } => ResultKind::Fp,
        Extend { .. } => ResultKind::Int,
        FpCast { kind, .. } => match kind {
            FpCastKind::FpToInt | FpCastKind::UFpToInt => ResultKind::Int,
            FpCastKind::IntToFp
            | FpCastKind::UIntToFp
            | FpCastKind::F32ToF64
            | FpCastKind::F64ToF32 => ResultKind::Fp,
        },
        // C99 6.2.5p10: a call returning a floating-point scalar
        // delivers its value in the FP return register (xmm0 / d0),
        // so the call's result is FP-classed. `fp_return` is set by
        // the walker from the callee's return type.
        Call { fp_return, .. } | CallIndirect { fp_return, .. } => {
            if *fp_return {
                ResultKind::Fp
            } else {
                ResultKind::Int
            }
        }
        CallExt { fp_return, .. } => {
            if *fp_return {
                ResultKind::Fp
            } else {
                ResultKind::Int
            }
        }
        TailExt(_) => ResultKind::None,
        Mcpy { .. } => ResultKind::Int,
        // C11 7.17.7: the prior value (RMW) / boolean success (CAS) is
        // an integer scalar.
        AtomicRmw { .. } | AtomicCas { .. } => ResultKind::Int,
        Intrinsic { kind, .. } => {
            use super::super::op::Intrinsic as I;
            // The unary FP math intrinsics (sqrt / fabs / floor / ceil /
            // trunc, C99 7.12.7 / 7.12.9) produce an FP value; the rest
            // yield an integer / pointer.
            if I::from_i64(*kind).is_some_and(|i| i.is_fp_unary()) {
                ResultKind::Fp
            } else {
                ResultKind::Int
            }
        }
        AllocaInit(_) => ResultKind::None,
    }
}

/// Populate per-call-argument coalescing hints. The i-th integer or
/// FP argument value at each `Inst::Call*` is hinted to the matching
/// host argument register so the allocator parks the value there from
/// its definition and the c5 emit's pre-call mov drops out.
///
/// Safety guards (mirrors `populate_return_hints`'s leaf gate):
///
/// * `last_use[v] == call_pc` -- v must die at this call. If v survives,
///   it would need either a callee-saved register or a spill, and the
///   caller-saved arg-register hint would clobber it.
/// * `!calls_after_def[v]` -- no intervening call between v's def and
///   the call site. compute_calls_after_def reports those that would
///   force callee-saved placement; the hint's caller-saved choice is
///   incompatible.
/// * v must not already carry a different hint (the existing
///   ParamRef / Return / Phi passes take precedence).
///
/// Variadic call sites still benefit (the c5 internal cdecl ABI passes
/// every arg through the integer register window) so the function
/// hints both direct and indirect calls.
fn populate_call_arg_hints(
    func: &FunctionSsa,
    target: Target,
    last_use: &[u32],
    calls_after_def: &[bool],
    hints: &mut [Option<u8>],
) {
    let int_args = target.abi().int_arg_regs;
    // Win64 advances the slot index on every argument regardless of
    // type, so an int at position 2 lands in `int_args[2]` even when
    // earlier args were FP. SysV and AAPCS64 advance the int counter
    // only on int args.
    let combined_slot = matches!(target, Target::WindowsX64);
    for (pc, inst) in func.insts.iter().enumerate() {
        let args: &[ValueId] = match inst {
            Inst::Call { args, .. } => args,
            Inst::CallIndirect { args, .. } => args,
            Inst::CallExt { args, .. } => args,
            _ => continue,
        };
        let pc = pc as u32;
        let mut next_int = 0usize;
        for (slot_idx, &v) in args.iter().enumerate() {
            let vu = v as usize;
            if vu >= hints.len() {
                continue;
            }
            let kind = result_kind(&func.insts[vu]);
            let arg_pos = match kind {
                ResultKind::Int => {
                    let pos = if combined_slot { slot_idx } else { next_int };
                    next_int += 1;
                    pos
                }
                // FP argument hinting is left to the existing emit-time
                // marshal: it threads the per-target FP arg-register
                // window plus the variadic-only flags (variadic_on_stack,
                // variadic_int_only) that the allocator does not model.
                ResultKind::Fp | ResultKind::None => continue,
            };
            // Each argument value's last use must be exactly this call,
            // and no other call may sit between its definition and this
            // call. Otherwise the caller-saved arg-register hint races
            // the intervening clobber.
            if last_use[vu] != pc {
                continue;
            }
            if calls_after_def[vu] {
                continue;
            }
            if hints[vu].is_some() {
                continue;
            }
            if let Some(&r) = int_args.get(arg_pos) {
                // ParamRefs materialise in inst order. Hinting
                // ParamRef(pi)'s value into int_args[k] for any k
                // beyond pi writes through a register that a later
                // ParamRef(k) still needs to read, scrambling the
                // incoming arguments. Refuse the hint in that shape;
                // the value goes through the regular pick path
                // instead of the coalesced arg-reg.
                if let Inst::ParamRef { idx: pi, .. } = func.insts[vu]
                    && (pi as usize) < int_args.len()
                    && int_args[(pi as usize)..]
                        .iter()
                        .skip(1)
                        .any(|&later| later == r)
                {
                    continue;
                }
                hints[vu] = Some(r);
            }
        }
    }
}

/// Hint each `Inst::Call*`'s defined value to the ABI return register
/// so the post-call capture mov drops out when the result's interval
/// is call-clobber-free. Guarded by `!calls_after_def[idx]` -- a
/// caller-saved return register would be clobbered by any later call's
/// prologue or arg setup.
fn populate_call_result_hints(
    func: &FunctionSsa,
    target: Target,
    calls_after_def: &[bool],
    hints: &mut [Option<u8>],
) {
    let (ret_int, ret_fp) = match target {
        Target::MacOSAarch64
        | Target::LinuxAarch64
        | Target::WindowsAarch64
        | Target::LinuxX64
        | Target::WindowsX64 => (0u8, 0u8),
    };
    for (idx, inst) in func.insts.iter().enumerate() {
        if !matches!(
            inst,
            Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
        ) {
            continue;
        }
        if idx >= hints.len() || hints[idx].is_some() {
            continue;
        }
        if calls_after_def.get(idx).copied().unwrap_or(false) {
            continue;
        }
        match result_kind(inst) {
            ResultKind::Int => hints[idx] = Some(ret_int),
            ResultKind::Fp => hints[idx] = Some(ret_fp),
            ResultKind::None => {}
        }
    }
}

/// Populate coalescing hints for ABI-fixed registers so the linear
/// scan lands call arguments directly in their ABI register, captures
/// a call result in the return register, and keeps a Return-value in
/// the return register. The pick-reg path honours each hint only when
/// the register is free and live-across-call-compatible, so a missed
/// hint falls back to the default policy.
fn populate_return_hints(func: &FunctionSsa, target: Target, hints: &mut [Option<u8>]) {
    // Hint the value feeding `Terminator::Return` to the ABI return
    // register so the exit move drops out. Two cases are honoured:
    //
    //   * Leaf functions (no `Inst::Call*` anywhere). Empirically
    //     safe -- no call can clobber the caller-saved return register.
    //   * Single-block functions where the Return value's def has
    //     no call between it and the terminator. Straight-line
    //     control flow means there is no back-edge / phi-merge gap
    //     that the broader per-value relaxation otherwise surfaces
    //     (see task #197 -- the lua regression on broader relaxations
    //     does not appear in straight-line shapes).
    let has_call = func.insts.iter().any(|inst| {
        matches!(
            inst,
            Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
        )
    });
    let single_block = func.blocks.len() == 1;
    if has_call && !single_block {
        return;
    }
    let (ret_int, ret_fp) = match target {
        Target::MacOSAarch64
        | Target::LinuxAarch64
        | Target::WindowsAarch64
        | Target::LinuxX64
        | Target::WindowsX64 => (0u8, 0u8),
    };

    fn try_set(hints: &mut [Option<u8>], id: ValueId, reg: u8) {
        let slot = id as usize;
        if slot < hints.len() && hints[slot].is_none() {
            hints[slot] = Some(reg);
        }
    }

    for block in &func.blocks {
        if let Terminator::Return(v) = block.terminator
            && v != NO_VALUE
            && (v as usize) < func.insts.len()
        {
            if has_call {
                // Single-block branch: require v's def to live in
                // this block AND no call after the def. Without
                // these guards the hint clobbers v across the call.
                let (start, end) = (block.inst_range.start, block.inst_range.end);
                if v < start || v >= end {
                    continue;
                }
                let intervening_call = (v + 1..end).any(|pc| {
                    matches!(
                        func.insts[pc as usize],
                        Inst::Call { .. } | Inst::CallIndirect { .. } | Inst::CallExt { .. }
                    )
                });
                if intervening_call {
                    continue;
                }
            }
            match result_kind(&func.insts[v as usize]) {
                ResultKind::Int => try_set(hints, v, ret_int),
                ResultKind::Fp => try_set(hints, v, ret_fp),
                ResultKind::None => {}
            }
        }
    }
}

/// Per-value mask of physical registers the colorer must not assign,
/// to keep each `Inst::ParamRef` off the incoming argument register of a
/// later same-bank `ParamRef`. A `ParamRef` reads its incoming argument
/// register, which stays live from function entry until that `ParamRef`
/// materializes. `ParamRef`s materialize in value-id order; an earlier
/// one placed in a later one's incoming register overwrites that
/// register before the later `ParamRef` reads it. The own-incoming-
/// register hint ([`populate_param_ref_hints`]) avoids this at full
/// register pressure, but is rejected once the incoming register falls
/// beyond a truncated bank, so the colorer parks the early `ParamRef` on
/// a low register that is another parameter's incoming register. Forbid
/// that placement: the colorer then picks a free register or spills, and
/// a spilled `ParamRef` stores its incoming register straight to the
/// slot, which never clobbers.
fn compute_param_incoming_forbid(func: &FunctionSsa, target: Target) -> Vec<u64> {
    let mut forbid = alloc::vec![0u64; func.insts.len()];
    if func.is_variadic {
        return forbid;
    }
    let int_args: &[u8] = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            &[0, 1, 2, 3, 4, 5, 6, 7]
        }
        Target::LinuxX64 => &[7, 6, 2, 1, 8, 9],
        Target::WindowsX64 => &[1, 2, 8, 9],
    };
    let fp_args: &[u8] = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 | Target::LinuxX64 => {
            &[0, 1, 2, 3, 4, 5, 6, 7]
        }
        Target::WindowsX64 => &[0, 1, 2, 3],
    };
    // Only protect parameters that are read: an unused `ParamRef` is not
    // materialized, so its incoming register need not survive.
    let mut used = alloc::vec![false; func.insts.len()];
    for inst in &func.insts {
        for_each_operand(inst, |op| {
            if (op as usize) < used.len() {
                used[op as usize] = true;
            }
        });
    }
    for block in &func.blocks {
        match &block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                if (*cond as usize) < used.len() {
                    used[*cond as usize] = true;
                }
            }
            Terminator::Return(v) if (*v as usize) < used.len() => used[*v as usize] = true,
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. }
                if (*target as usize) < used.len() =>
            {
                used[*target as usize] = true;
            }
            _ => {}
        }
    }
    // (value id, is_fp, incoming register) for each used ParamRef, in
    // value-id (materialization) order.
    let mut params: Vec<(usize, bool, u8)> = Vec::new();
    for (vid, inst) in func.insts.iter().enumerate() {
        let Inst::ParamRef { idx, .. } = inst else {
            continue;
        };
        if !used[vid] {
            continue;
        }
        let pi = *idx as usize;
        let is_fp = (func.param_fp_mask & (1u32 << pi)) != 0;
        let (rank, bank): (usize, &[u8]) = if is_fp {
            (
                (0..pi)
                    .filter(|&j| (func.param_fp_mask & (1u32 << j)) != 0)
                    .count(),
                fp_args,
            )
        } else {
            (
                (0..pi)
                    .filter(|&j| (func.param_fp_mask & (1u32 << j)) == 0)
                    .count(),
                int_args,
            )
        };
        if let Some(&r) = bank.get(rank) {
            params.push((vid, is_fp, r));
        }
    }
    for a in 0..params.len() {
        let (vid_a, fp_a, _) = params[a];
        for &(_, fp_b, reg_b) in &params[a + 1..] {
            if fp_a == fp_b {
                forbid[vid_a] |= 1u64 << reg_b;
            }
        }
    }
    forbid
}

fn populate_param_ref_hints(func: &FunctionSsa, target: Target, hints: &mut [Option<u8>]) {
    // Hint each `Inst::ParamRef(i)` to its incoming integer-argument
    // register. The per-arch emit reads the argument register
    // directly (`movsxd dst, int_arg_regs[i]`); when the allocator
    // parks a later ParamRef's destination on an earlier ParamRef's
    // arg-register, the in-place sign-extend clobbers the source the
    // later ParamRef still needs to read. Hinting each ParamRef's
    // destination to its matching arg register collapses the read +
    // write into a single self-update and removes the hazard.
    //
    // Variadic callees skip this pass: the va_start / va_arg
    // intrinsics read `&last` (a `LocalAddr` of the named final
    // parameter) and walk forward by 16-byte c5 cdecl strides; the
    // parameter slot the hint would move the ParamRef toward isn't
    // the slot va_start expects to read from.
    if func.is_variadic {
        return;
    }
    // The cross-clobber hazard is register-pressure driven, not a
    // function of the parameter count: whenever the allocator runs out
    // of non-arg-register candidates it can park an earlier ParamRef's
    // destination on a later ParamRef's incoming arg register, and the
    // later ParamRef's in-place read then sources a clobbered register.
    // Hinting every integer ParamRef to its own incoming register homes
    // each parameter in place, so the materialization is a self-update
    // and no ParamRef can land on another's source. The incoming arg
    // registers are caller-saved and free at entry, so the hint is
    // honoured whenever the parameter is not forced elsewhere (live
    // across a call, or competing for the same register).
    let int_args: &[u8] = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
            &[0, 1, 2, 3, 4, 5, 6, 7]
        }
        Target::LinuxX64 => &[7, 6, 2, 1, 8, 9],
        Target::WindowsX64 => &[1, 2, 8, 9],
    };
    // The hint must target each integer parameter's own incoming
    // register, which is its rank within the integer argument bank, not
    // its declared position: a floating-point parameter consumes an FP
    // argument register and does not advance the integer bank (System V
    // AMD64 3.2.3 / AAPCS64 6.4.1). Hinting by declared position would
    // point a later integer ParamRef at the wrong arg register -- one an
    // earlier integer parameter actually arrives in -- reintroducing the
    // very cross-clobber this pass exists to remove.
    // Floating-point parameters arrive in the FP argument bank and the
    // same cross-clobber hazard applies there; hint each FP parameter to
    // its own incoming FP argument register (by its rank within the FP
    // bank, which on every supported target is the d/xmm index). The FP
    // banks: AAPCS64 d0-d7, System V xmm0-7, Win64 xmm0-3.
    let fp_args: &[u8] = match target {
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 | Target::LinuxX64 => {
            &[0, 1, 2, 3, 4, 5, 6, 7]
        }
        Target::WindowsX64 => &[0, 1, 2, 3],
    };
    for (idx, inst) in func.insts.iter().enumerate() {
        if let Inst::ParamRef { idx: i, .. } = inst {
            let pi = *i as usize;
            let is_fp = (func.param_fp_mask & (1u32 << pi)) != 0;
            let (rank, bank): (usize, &[u8]) = if is_fp {
                (
                    (0..pi)
                        .filter(|&j| (func.param_fp_mask & (1u32 << j)) != 0)
                        .count(),
                    fp_args,
                )
            } else {
                (
                    (0..pi)
                        .filter(|&j| (func.param_fp_mask & (1u32 << j)) == 0)
                        .count(),
                    int_args,
                )
            };
            if let Some(&r) = bank.get(rank)
                && idx < hints.len()
                && hints[idx].is_none()
            {
                hints[idx] = Some(r);
            }
        }
    }
}

/// Propagate a single register hint across each `Inst::Phi`'s
/// result and every incoming source so the allocator prefers the
/// same physical register for the whole group. When the placement
/// succeeds, the per-arch predecessor-exit move from incoming to
/// phi result drops to a self-move that `schedule_int_reg_moves`
/// drops outright, eliminating the move.
///
/// The pass is a fixpoint loop: a phi whose incoming is itself a
/// phi inherits through the chain. Each iteration picks the first
/// existing hint within the group and assigns it to every still-
/// unhinted member; iteration stops when no member changes.
/// The allocator's hint policy is advisory; an unsuitable hint
/// (register live elsewhere at the pick site) falls through to the
/// default policy without compromising correctness.
fn populate_phi_hints(func: &FunctionSsa, hints: &mut [Option<u8>]) {
    loop {
        let mut changed = false;
        for (v, inst) in func.insts.iter().enumerate() {
            let Inst::Phi { incoming, .. } = inst else {
                continue;
            };
            let mut group_hint = hints[v];
            if group_hint.is_none() {
                for (_, src) in incoming {
                    if *src == NO_VALUE || (*src as usize) >= hints.len() {
                        continue;
                    }
                    if let Some(r) = hints[*src as usize] {
                        group_hint = Some(r);
                        break;
                    }
                }
            }
            let Some(r) = group_hint else { continue };
            if hints[v].is_none() {
                hints[v] = Some(r);
                changed = true;
            }
            for (_, src) in incoming {
                if *src == NO_VALUE || (*src as usize) >= hints.len() {
                    continue;
                }
                if hints[*src as usize].is_none() {
                    hints[*src as usize] = Some(r);
                    changed = true;
                }
            }
        }
        if !changed {
            break;
        }
    }
}

/// For each value, the PC index of its last use across the
/// function. Defaults to the value's own PC (so a value with no
/// uses still has a single-PC interval).
fn compute_last_use(func: &FunctionSsa) -> Vec<u32> {
    let n = func.insts.len();
    let mut last_use: Vec<u32> = (0..n as u32).collect();
    for (idx, inst) in func.insts.iter().enumerate() {
        let pc = idx as u32;
        for_each_operand(inst, |target| {
            if target != NO_VALUE
                && (target as usize) < last_use.len()
                && last_use[target as usize] < pc
            {
                last_use[target as usize] = pc;
            }
        });
    }
    // Each block's exit_acc keeps that value live to the end of the
    // block, and the terminator may consume operands too. Bump every
    // such carrier to `end_pc` so a value defined inside the block
    // but read only by the terminator (the common Return-value case)
    // has its interval cover any intervening call. Without this the
    // forward scan leaves `last_use[v]` at v's own def PC and a
    // downstream coalescing hint, which guards on `last_use`, can
    // place `v` in a caller-saved register that the call clobbers.
    for b in &func.blocks {
        let end_pc = b.inst_range.end;
        let mut bump = |v: ValueId| {
            if v != NO_VALUE && (v as usize) < last_use.len() && last_use[v as usize] < end_pc {
                last_use[v as usize] = end_pc;
            }
        };
        bump(b.exit_acc);
        // A `GotoIndirect` sets `exit_acc` to its target, so the bump
        // above already covers it; the explicit arm keeps this walk
        // uniform with the liveness and use-count terminator walks.
        match &b.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => bump(*cond),
            Terminator::Return(v) => bump(*v),
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                bump(*target)
            }
            _ => {}
        }
    }
    extend_last_use_across_blocks(func, &mut last_use);
    last_use
}

/// Extend each value's last-use index to cover every block where it
/// stays live. The forward scan's `last_use` is the highest index
/// that names the value as an operand, which is a lower bound: a value
/// defined before a loop and read inside it is live across the back
/// edge, so its register must be held through the loop body even
/// though no later instruction index references it. Block-level
/// liveness over the control-flow graph captures that. The pass only
/// raises `last_use`, so a value that is not live across a back edge
/// or an out-of-order block keeps the range the scan computed.
fn extend_last_use_across_blocks(func: &FunctionSsa, last_use: &mut [u32]) {
    let nblocks = func.blocks.len();
    let n = func.insts.len();
    let words = n.div_ceil(64);
    if nblocks == 0 || words == 0 {
        return;
    }
    let bit = |bits: &mut [u64], base: usize, v: u32| {
        bits[base + (v as usize) / 64] |= 1u64 << ((v as usize) % 64);
    };
    // used_set: values referenced in a block but defined outside it
    // (upward exposed). kill: values defined in the block's range.
    // phi_live_out: per-predecessor set of phi-incoming values --
    // these must be live at the end of the predecessor regardless
    // of where they are defined (a loop body whose phi reads a value
    // defined in that same body needs the value to survive the back
    // edge, but `~kill[B]` would otherwise drop it).
    let mut used_set = vec![0u64; nblocks * words];
    let mut kill = vec![0u64; nblocks * words];
    let mut phi_live_out = vec![0u64; nblocks * words];
    for (b, blk) in func.blocks.iter().enumerate() {
        let base = b * words;
        let (start, end) = (blk.inst_range.start, blk.inst_range.end);
        for v in start..end {
            bit(&mut kill, base, v);
        }
        let mut mark = |v: ValueId| {
            if v != NO_VALUE && (v < start || v >= end) {
                bit(&mut used_set, base, v);
            }
        };
        for idx in start..end {
            if let Inst::Phi { incoming, .. } = &func.insts[idx as usize] {
                for (pred, v) in incoming {
                    if *v != NO_VALUE {
                        bit(&mut phi_live_out, (*pred as usize) * words, *v);
                    }
                }
                continue;
            }
            for_each_operand(&func.insts[idx as usize], &mut mark);
        }
        if blk.exit_acc != NO_VALUE {
            mark(blk.exit_acc);
        }
        match &blk.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => mark(*cond),
            Terminator::Return(v) if *v != NO_VALUE => mark(*v),
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. }
                if *target != NO_VALUE =>
            {
                mark(*target)
            }
            _ => {}
        }
    }
    // Backward dataflow to a fixed point:
    //   live_out[b] = phi_live_out[b] | U live_in[succ];
    //   live_in[b]  = gen[b] | (live_out[b] & ~kill[b]).
    let mut live_in = vec![0u64; nblocks * words];
    let mut live_out = vec![0u64; nblocks * words];
    let mut scratch = vec![0u64; words];
    let mut changed = true;
    while changed {
        changed = false;
        for b in (0..nblocks).rev() {
            let base = b * words;
            scratch.iter_mut().for_each(|w| *w = 0);
            for s in super::mem2reg::successors(
                &func.blocks[b].terminator,
                &func.computed_goto_targets,
                &func.jump_tables,
            ) {
                let sb = s as usize * words;
                for w in 0..words {
                    scratch[w] |= live_in[sb + w];
                }
            }
            for w in 0..words {
                scratch[w] |= phi_live_out[base + w];
                live_out[base + w] = scratch[w];
                let ni = used_set[base + w] | (scratch[w] & !kill[base + w]);
                if ni != live_in[base + w] {
                    live_in[base + w] = ni;
                    changed = true;
                }
            }
        }
    }
    // A value live-out of a block must survive to the end of that
    // block's instruction range.
    for (b, blk) in func.blocks.iter().enumerate() {
        let base = b * words;
        let end = blk.inst_range.end;
        for w in 0..words {
            let mut bits = live_out[base + w];
            while bits != 0 {
                let v = (w * 64) as u32 + bits.trailing_zeros();
                if last_use[v as usize] < end {
                    last_use[v as usize] = end;
                }
                bits &= bits - 1;
            }
        }
    }
}

/// For each value, mark whether its live range spans a call. Such a
/// value must be in a callee-saved register (or spilled), since a
/// caller-saved register would be clobbered by the call. The answer
/// comes from the CFG live range (`Liveness::values_live_across_calls`),
/// the same view the interference graph is built from, so the two
/// agree on which values cross a call.
///
/// `Inst::TlsAddr` is treated as a call on targets whose TLS
/// lowering issues an indirect call: Mach-O/AArch64 reads a TLV
/// descriptor and invokes its bootstrap routine through `blr x16`,
/// which clobbers the AAPCS64 caller-saved registers. Linux's
/// variant-1 (TPIDR_EL0 + add) and Windows' (gs/x18 + 0x58 table
/// walk) reach the per-thread storage without leaving the
/// instruction stream, so they stay outside the call set.
fn compute_calls_after_def(
    func: &FunctionSsa,
    liveness: &super::liveness::Liveness,
    target: Target,
) -> Vec<bool> {
    // A value crosses a call when its live range spans the call, a
    // property of the control-flow graph rather than the linear pc
    // order: a value live across a call only on a branch or back-edge
    // path has that call outside its `[def, last_use]` pc interval, so
    // a pc-interval test misses it.
    let tls_addr_is_call = matches!(target, Target::MacOSAarch64);
    liveness.values_live_across_calls(func, tls_addr_is_call)
}

/// Promote each phi class's `calls_after_def` flag so every member
/// inherits the class's combined call-crossing status: the class flag
/// is the OR of the members' CFG-precise per-value flags. Class
/// members share one register, so if any member is live across a call
/// the shared register must be callee-saved. Where no member is live
/// the shared register holds nothing a call could clobber, so the
/// class stays eligible for a caller-saved home.
fn promote_calls_after_def_to_classes(
    classes: &mut super::phi_class::PhiClasses,
    calls_after_def: &mut [bool],
) {
    let mut class_must_callee: alloc::collections::BTreeMap<ValueId, bool> =
        alloc::collections::BTreeMap::new();
    for (v, &crosses) in calls_after_def.iter().enumerate() {
        let root = classes.find(v as ValueId);
        *class_must_callee.entry(root).or_insert(false) |= crosses;
    }
    for (v, entry) in calls_after_def.iter_mut().enumerate() {
        if class_must_callee[&classes.find(v as ValueId)] {
            *entry = true;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;
    use std::path::PathBuf;

    fn lift(path: &str) -> Vec<FunctionSsa> {
        let src =
            std::fs::read_to_string(PathBuf::from(env!("CARGO_MANIFEST_DIR")).join(path)).unwrap();
        let program = Compiler::new(src).compile().expect("compile");
        crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, Target::host())
            .expect("produce_ssa_funcs")
    }

    use super::super::liveness::Interference;

    // A tiny register file for coloring tests: two callee-saved and
    // two caller-saved integer registers, no FP.
    fn tiny_banks() -> RegBanks {
        RegBanks {
            callee_gprs: &[20, 21],
            caller_gprs: &[0, 1],
            callee_fprs: &[],
            caller_fprs: &[],
        }
    }

    fn int_node(must_callee: bool, hint: Option<u8>) -> Option<NodeConstraints> {
        Some(NodeConstraints {
            is_fp: false,
            must_callee,
            hint,
            forbid: 0,
        })
    }

    #[test]
    fn x86_64_register_banks_expose_no_callee_saved_fp() {
        // The x86_64 prologue/epilogue (`emit_prologue` / `emit_return`
        // in ssa_emit_x86_64) and the `Frame` layout reserve no space
        // for FP-register saves and emit no save/restore of any xmm.
        // Both x86_64 ABIs must therefore expose an empty callee-saved
        // FP bank: the allocator keeps every live-across-call FP value
        // in memory and only ever uses the volatile xmm regs. Win64
        // marks xmm6..xmm15 non-volatile (x64 calling convention); if
        // they leaked into `callee_fprs` the allocator could park a
        // value there and corrupt the caller's xmm6..xmm15 on return,
        // since nothing saves them.
        for target in [Target::LinuxX64, Target::WindowsX64] {
            let banks = RegBanks::for_target(target);
            assert!(
                banks.callee_fprs.is_empty(),
                "{target:?} exposes callee-saved FP regs {:?} but the x86_64 \
                 prologue/epilogue emit no FP save/restore",
                banks.callee_fprs
            );
        }
        // The Win64 volatile xmm set is xmm0..xmm5; the caller-saved FP
        // bank must not advertise a non-volatile register either.
        let win = RegBanks::for_target(Target::WindowsX64);
        assert!(
            win.caller_fprs.iter().all(|&r| r <= 5),
            "Win64 caller_fprs {:?} includes a non-volatile xmm (>= xmm6)",
            win.caller_fprs
        );
    }

    #[test]
    fn win64_fp_value_live_across_call_does_not_use_callee_saved_xmm() {
        // An FP local live across a call must not be parked in a Win64
        // non-volatile xmm (xmm6..xmm15): the x86_64 prologue/epilogue
        // emit no FP save/restore, so such a placement would corrupt
        // the caller's register on return. Pre-fix the allocator put
        // the sum `s` in xmm6 and read it back after the `g()` calls.
        let src = r#"
double g(double);
double sink;
double f(double a, double b, double c, double d, double e, double h) {
    double s = a + b + c + d + e + h;
    sink = g(a);
    sink = g(b);
    return s + g(c);
}
int main(void) { return 0; }
"#;
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let funcs =
            crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, Target::WindowsX64)
                .expect("produce_ssa_funcs");
        for func in &funcs {
            let alloc = allocate(func, Target::WindowsX64);
            for place in &alloc.places {
                if let Place::FpReg(r) = place {
                    assert!(
                        *r <= 5,
                        "Win64 allocation parked an FP value in non-volatile xmm{r} \
                         ({}); the prologue/epilogue do not save it",
                        func.name
                    );
                }
            }
            // `fp_used` may now list the emit pass's fixed FP scratch
            // (xmm13/14/15), which the prologue/epilogue save and restore
            // on Win64. No other non-volatile xmm may appear: a value
            // parked outside the scratch set would not be saved.
            for &r in &alloc.fp_used {
                assert!(
                    matches!(r, 13..=15),
                    "Win64 fp_used in {} lists xmm{r}, not a saved scratch reg",
                    func.name
                );
            }
        }
    }

    #[test]
    fn win64_fp_function_saves_nonvolatile_xmm_scratch() {
        // The x86_64 emit pass uses xmm14/15 (and xmm13 for FMA) as fixed
        // FP scratch; they are non-volatile under Win64, so a function
        // that performs FP work must report them in `fp_used` for the
        // prologue/epilogue to preserve. System V marks every xmm
        // volatile, so the same body reports none.
        let fp_src = r#"
double f(double a, double b, double c, double d, double e, double h) {
    double s = a * b + c * d;
    s = s * e + h;
    return s + a * c + b * d;
}
int main(void) { return 0; }
"#;
        let program = Compiler::new(fp_src.to_string())
            .compile()
            .expect("compile");
        for (target, want_scratch) in [(Target::WindowsX64, true), (Target::LinuxX64, false)] {
            let funcs =
                crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target).expect("ssa");
            let f = funcs.iter().find(|f| f.name == "f").expect("f");
            let alloc = allocate(f, target);
            let saves_14_15 = alloc.fp_used.contains(&14) && alloc.fp_used.contains(&15);
            assert_eq!(
                saves_14_15, want_scratch,
                "{target:?}: fp_used = {:?}, expected scratch-saved = {want_scratch}",
                alloc.fp_used
            );
        }

        // A non-FP function reports no FP scratch even on Win64.
        let int_src = "int g(int a, int b) { return a * b + a; }\nint main(void){return 0;}";
        let program = Compiler::new(int_src.to_string())
            .compile()
            .expect("compile");
        let funcs =
            crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, Target::WindowsX64)
                .expect("ssa");
        let g = funcs.iter().find(|f| f.name == "g").expect("g");
        assert!(
            allocate(g, Target::WindowsX64).fp_used.is_empty(),
            "a non-FP Win64 function must save no FP scratch"
        );
    }

    #[test]
    fn interfering_nodes_get_distinct_registers() {
        // Triangle: nodes 0,1,2 mutually interfere -> three colors.
        let g = Interference::from_edges(3, &[(0, 1), (1, 2), (0, 2)]);
        let node_of = [0u32, 1, 2];
        let cons = [
            int_node(false, None),
            int_node(false, None),
            int_node(false, None),
        ];
        let r = color_graph(
            &g,
            &node_of,
            &cons,
            &tiny_banks(),
            usize::MAX,
            usize::MAX,
            false,
        );
        assert_eq!(r.spill_count, 0);
        let regs: Vec<Place> = r.places.clone();
        assert_ne!(regs[0], regs[1]);
        assert_ne!(regs[1], regs[2]);
        assert_ne!(regs[0], regs[2]);
    }

    #[test]
    fn over_pressure_spills_one_node() {
        // Five mutually interfering nodes, four registers -> one spill.
        let edges: Vec<(u32, u32)> = (0..5u32)
            .flat_map(|a| (a + 1..5u32).map(move |b| (a, b)))
            .collect();
        let g = Interference::from_edges(5, &edges);
        let node_of = [0u32, 1, 2, 3, 4];
        let cons: Vec<Option<NodeConstraints>> = (0..5).map(|_| int_node(false, None)).collect();
        let r = color_graph(
            &g,
            &node_of,
            &cons,
            &tiny_banks(),
            usize::MAX,
            usize::MAX,
            false,
        );
        assert_eq!(
            r.spill_count, 1,
            "four registers, five live values -> one spill"
        );
        let spilled = r
            .places
            .iter()
            .filter(|p| matches!(p, Place::Spill(_)))
            .count();
        assert_eq!(spilled, 1);
    }

    #[test]
    fn returns_twice_caller_never_shares_spill_slots() {
        // Nodes 0-3 fill the four registers; 4 and 5 both spill and do
        // not interfere with each other, so slot sharing would give
        // them one slot. A returns-twice caller (setjmp / vfork) must
        // keep the slots distinct: the value dead on the first-return
        // path is still read after the second return (C99 7.13.2.1p3).
        let mut edges: Vec<(u32, u32)> = (0..4u32)
            .flat_map(|a| (a + 1..4u32).map(move |b| (a, b)))
            .collect();
        for spilled in [4u32, 5] {
            edges.extend((0..4u32).map(|r| (r, spilled)));
        }
        let g = Interference::from_edges(6, &edges);
        let node_of = [0u32, 1, 2, 3, 4, 5];
        let cons: Vec<Option<NodeConstraints>> = (0..6).map(|_| int_node(false, None)).collect();
        let shared = color_graph(
            &g,
            &node_of,
            &cons,
            &tiny_banks(),
            usize::MAX,
            usize::MAX,
            false,
        );
        assert_eq!(shared.spill_count, 1, "non-interfering spills share");
        assert_eq!(shared.places[4], shared.places[5]);
        let r = color_graph(
            &g,
            &node_of,
            &cons,
            &tiny_banks(),
            usize::MAX,
            usize::MAX,
            true,
        );
        assert_eq!(r.spill_count, 2, "returns-twice: one slot per value");
        assert_eq!(r.places[4], Place::Spill(0));
        assert_eq!(r.places[5], Place::Spill(1));
    }

    #[test]
    fn must_callee_node_avoids_caller_saved() {
        // A single call-crossing node must land in a callee-saved
        // register even though caller-saved are free and preferred.
        let g = Interference::from_edges(1, &[]);
        let node_of = [0u32];
        let cons = [int_node(true, None)];
        let r = color_graph(
            &g,
            &node_of,
            &cons,
            &tiny_banks(),
            usize::MAX,
            usize::MAX,
            false,
        );
        assert!(
            matches!(r.places[0], Place::IntReg(20) | Place::IntReg(21)),
            "call-crossing value must take a callee-saved register, got {:?}",
            r.places[0],
        );
    }

    #[test]
    fn caller_saved_preferred_when_no_call_crossing() {
        // No constraint forces callee-saved, so a caller-saved
        // register is chosen to avoid a prologue save.
        let g = Interference::from_edges(1, &[]);
        let node_of = [0u32];
        let cons = [int_node(false, None)];
        let r = color_graph(
            &g,
            &node_of,
            &cons,
            &tiny_banks(),
            usize::MAX,
            usize::MAX,
            false,
        );
        assert!(
            matches!(r.places[0], Place::IntReg(0) | Place::IntReg(1)),
            "non-crossing value should prefer caller-saved, got {:?}",
            r.places[0],
        );
    }

    #[test]
    fn hint_is_honoured_when_free() {
        let g = Interference::from_edges(2, &[(0, 1)]);
        let node_of = [0u32, 1];
        let cons = [int_node(false, Some(21)), int_node(false, None)];
        let r = color_graph(
            &g,
            &node_of,
            &cons,
            &tiny_banks(),
            usize::MAX,
            usize::MAX,
            false,
        );
        assert_eq!(
            r.places[0],
            Place::IntReg(21),
            "free hinted register must be used"
        );
        assert_ne!(r.places[1], Place::IntReg(21));
    }

    #[test]
    fn coalesced_members_inherit_root_placement() {
        // Values 0 and 1 share one node (root 0); both get the same
        // register, value 2 interferes and gets a different one.
        let g = Interference::from_edges(3, &[(0, 2)]);
        let node_of = [0u32, 0, 2];
        let cons = [int_node(false, None), None, int_node(false, None)];
        let r = color_graph(
            &g,
            &node_of,
            &cons,
            &tiny_banks(),
            usize::MAX,
            usize::MAX,
            false,
        );
        assert_eq!(r.places[0], r.places[1], "class members share a register");
        assert_ne!(r.places[0], r.places[2]);
    }

    /// Allocate every function in quicksort.c on aarch64. The
    /// fixture has straight-line control flow and short
    /// expressions; the allocator should never spill.
    #[test]
    fn unused_volatile_reads_survive_dead_pure_skip() {
        // C99 5.1.2.3p2: a volatile read is a side effect. The emit's
        // dead-code skip must keep the unused loads and their address
        // chains at every optimization level.
        let funcs = lift("tests/fixtures/c/volatile_unused_read.c");
        let main = funcs.iter().find(|f| f.name == "main").expect("main");
        let alloc = allocate(main, Target::host());
        let mut volatile_loads = 0;
        for (v, inst) in main.insts.iter().enumerate() {
            match inst {
                Inst::Load {
                    volatile: true,
                    addr,
                    ..
                } => {
                    volatile_loads += 1;
                    assert!(
                        !super::super::emit_common::is_dead_pure(inst, v as ValueId, &alloc),
                        "volatile Load v{v} must not be skipped as dead"
                    );
                    assert_ne!(
                        alloc.use_counts[*addr as usize], 0,
                        "the volatile load's address chain must stay live"
                    );
                }
                Inst::LoadLocal { volatile: true, .. } => {
                    volatile_loads += 1;
                    assert!(
                        !super::super::emit_common::is_dead_pure(inst, v as ValueId, &alloc),
                        "volatile LoadLocal v{v} must not be skipped as dead"
                    );
                }
                _ => {}
            }
        }
        assert!(
            volatile_loads >= 2,
            "expected the global and the local volatile reads in SSA, saw {volatile_loads}"
        );
    }

    #[test]
    fn allocate_quicksort_no_spill() {
        let funcs = lift("tests/fixtures/c/quicksort.c");
        for f in &funcs {
            let alloc = allocate(f, Target::MacOSAarch64);
            assert_eq!(
                alloc.places.len(),
                f.insts.len(),
                "allocation count mismatch for fn at pc {}",
                f.ent_pc
            );
        }
    }

    /// Allocate every function in c4.c. Exercises the cross-block
    /// vstack threading + spill paths. We don't assert the
    /// spill_count -- only that the allocator terminates and
    /// produces a place for every value.
    #[test]
    fn allocate_c4_self_host() {
        let funcs = lift("tests/fixtures/c/c4.c");
        for f in &funcs {
            let alloc = allocate(f, Target::MacOSAarch64);
            assert_eq!(alloc.places.len(), f.insts.len());
            for (i, p) in alloc.places.iter().enumerate() {
                // Every Inst that produces a value must have a
                // non-None place, except for store-class insts
                // whose "side-output" value (the propagated acc)
                // is unread -- the allocator nulls those out so
                // the emit pass skips the dst-propagate step.
                let kind = result_kind(&f.insts[i]);
                let store_with_dead_dst = matches!(
                    f.insts[i],
                    Inst::Store { .. } | Inst::StoreLocal { .. } | Inst::StoreIndexed { .. }
                ) && alloc.use_counts.get(i).copied().unwrap_or(0) == 0;
                match kind {
                    ResultKind::None => assert_eq!(*p, Place::None),
                    ResultKind::Int | ResultKind::Fp => {
                        if store_with_dead_dst {
                            continue;
                        }
                        assert!(
                            !matches!(p, Place::None),
                            "inst {i} produced a value but got Place::None"
                        );
                    }
                }
            }
        }
    }

    /// Mach-O / AArch64 reaches a thread-local through a TLV
    /// descriptor whose bootstrap routine is invoked via `blr x16`
    /// inside `emit_tls_addr`. The bootstrap clobbers every
    /// AAPCS64 caller-saved register, so any SSA value live across
    /// an `Inst::TlsAddr` must be flagged must-be-callee on that
    /// target. Linux's `mrs TPIDR_EL0` and Windows' `[x18, 0x58]`
    /// lookup don't leave the instruction stream, so the flag
    /// stays off.
    #[test]
    fn compute_calls_after_def_flags_tls_addr_on_macos_aarch64() {
        use crate::c5::codegen::ssa::build::SsaBuilder;
        use crate::c5::ir::StoreKind;

        let mut b = SsaBuilder::new(0, 0, false);
        let v_imm = b.imm(42);
        let v_tls = b.tls_addr(0);
        b.store(v_tls, v_imm, StoreKind::I32);
        b.return_(v_imm);
        let func = b.finish();

        let v_imm_idx = v_imm as usize;
        let v_tls_idx = v_tls as usize;
        assert!(v_imm_idx < v_tls_idx, "v_imm must be defined before v_tls");

        let last_use = compute_last_use(&func);
        assert!(
            last_use[v_imm_idx] > v_tls_idx as u32,
            "v_imm's last use ({}) must cross the TlsAddr at pc {v_tls_idx}",
            last_use[v_imm_idx],
        );

        let liveness = crate::c5::codegen::ssa::liveness::Liveness::compute(&func);

        let on_macos = compute_calls_after_def(&func, &liveness, Target::MacOSAarch64);
        assert!(
            on_macos[v_imm_idx],
            "TlsAddr's hidden blr should flag a value live across it on MacOSAarch64",
        );

        let on_linux = compute_calls_after_def(&func, &liveness, Target::LinuxAarch64);
        assert!(
            !on_linux[v_imm_idx],
            "Linux AArch64 TLS reads mrs TPIDR_EL0 -- no call, no flag",
        );

        let on_win = compute_calls_after_def(&func, &liveness, Target::WindowsAarch64);
        assert!(
            !on_win[v_imm_idx],
            "Windows AArch64 TLS walks the TEB -- no call, no flag",
        );

        let on_linux_x64 = compute_calls_after_def(&func, &liveness, Target::LinuxX64);
        assert!(
            !on_linux_x64[v_imm_idx],
            "Linux x86_64 TLS reads fs:[0] -- no call, no flag",
        );

        let on_win_x64 = compute_calls_after_def(&func, &liveness, Target::WindowsX64);
        assert!(
            !on_win_x64[v_imm_idx],
            "Windows x86_64 TLS walks the TEB -- no call, no flag",
        );
    }

    /// A value whose definition has a higher instruction index than a
    /// call it is live across -- the call is laid out at a lower pc in a
    /// successor block that the value is live into. The earlier
    /// `def < call_pc < last_use` interval could not see such a call: it
    /// only searched for the first call pc above the definition, so a
    /// call below the definition pc (but inside the value's CFG live
    /// range) was missed and the value was left in a caller-saved
    /// register the call clobbered. `compute_calls_after_def` must use
    /// the CFG live range, where the value is live across the call
    /// regardless of pc order. This is the block-layout shape
    /// `luaV_execute` hits: a promoted value defined in a late-laid-out
    /// block, live into an earlier-laid-out block that makes a call.
    #[test]
    fn calls_after_def_flags_value_across_call_at_lower_pc() {
        use crate::c5::codegen::ssa::build::SsaBuilder;

        let mut b = SsaBuilder::new(0, 0, false);
        let mid = b.new_block();
        let body = b.new_block();
        let exit = b.new_block();
        // entry: jmp mid. CFG order is entry -> mid -> body -> exit.
        b.jmp(mid);
        // body is switched to first, so its instructions take the lower
        // pc range: it just makes a call and falls to exit. v is live
        // across that call (defined in mid, used in exit), but the call
        // pc is below v's definition pc.
        b.switch_to(body);
        let _ = b.call(0, alloc::vec::Vec::new(), 0, false, 0);
        b.jmp(exit);
        // mid: v = 7; jmp body. Laid out after body, so def(v) pc is
        // above the call pc.
        b.switch_to(mid);
        let v = b.imm(7);
        b.jmp(body);
        // exit: return v -- keeps v live through body across the call.
        b.switch_to(exit);
        b.return_(v);
        let func = b.finish();

        let v_idx = v as usize;
        let call_pc = func
            .insts
            .iter()
            .position(|i| matches!(i, Inst::Call { .. }))
            .expect("a call") as u32;
        assert!(
            (v_idx as u32) > call_pc,
            "test shape requires v's def pc ({v_idx}) above the call pc ({call_pc})",
        );

        let liveness = crate::c5::codegen::ssa::liveness::Liveness::compute(&func);
        let flags = compute_calls_after_def(&func, &liveness, Target::LinuxX64);
        assert!(
            flags[v_idx],
            "a value live across a call laid out at a lower pc must be flagged must-be-callee",
        );
    }

    /// For commutative Binops (Add, Mul, And, Or, Xor) the in-loop
    /// coalesce hint targets rhs when lhs lives past pc and rhs dies
    /// at pc. The x86_64 emit's `rhs_aliases_rd && commutative` fast
    /// path then folds the staging mov to `OP rd, lhs` directly.
    #[test]
    fn binop_rhs_coalesce_fires_when_lhs_outlives_rhs() {
        use crate::c5::codegen::ssa::build::SsaBuilder;
        use crate::c5::ir::StoreKind;

        // v_lhs lives past the binop (consumed by the Store addr and
        // also returned). v_rhs dies at the binop. The binop is Add
        // (commutative). Return v_lhs (not v_sum) so the return hint
        // does not steal the binop's slot.
        let mut b = SsaBuilder::new(0, 0, false);
        let v_lhs = b.imm(7);
        let v_rhs = b.imm(11);
        let v_sum = b.binop(super::super::super::ir::BinOp::Add, v_lhs, v_rhs);
        b.store(v_lhs, v_sum, StoreKind::I64);
        b.return_(v_lhs);
        let func = b.finish();

        let alloc = allocate(&func, Target::LinuxX64);
        let rhs_place = alloc.places[v_rhs as usize];
        let sum_place = alloc.places[v_sum as usize];
        assert_eq!(
            sum_place, rhs_place,
            "v_sum should reuse v_rhs's freed register",
        );
    }

    /// `Inst::Load { addr }` reads `addr` and writes the result into
    /// the same bank. When `addr` dies at the load, the dst hint
    /// targets its register so the x86_64 `mov rd, [rd]` and aarch64
    /// `ldr rd, [rd]` shapes self-elide the staging mov. Returning a
    /// constant rather than the load lets `populate_return_hints`
    /// skip the load result so the in-loop coalesce gets the slot.
    #[test]
    fn load_addr_coalesce_fires_when_addr_dies_at_load() {
        use crate::c5::codegen::ssa::build::SsaBuilder;
        use crate::c5::ir::LoadKind;
        use crate::c5::ir::StoreKind;

        let mut b = SsaBuilder::new(0, 0, false);
        let v_addr = b.imm(0x1000);
        let v_load = b.load(v_addr, LoadKind::I64);
        let v_zero = b.imm(0);
        b.store(v_zero, v_load, StoreKind::I64);
        b.return_(v_zero);
        let func = b.finish();

        // x86_64 `mov rd, [rd]` and aarch64 `ldr rd, [rd]` both read
        // the addr operand before writing the result, so the coalesce
        // arm fires identically across targets.
        for target in [
            Target::MacOSAarch64,
            Target::LinuxAarch64,
            Target::WindowsAarch64,
            Target::LinuxX64,
            Target::WindowsX64,
        ] {
            let alloc = allocate(&func, target);
            let addr_place = alloc.places[v_addr as usize];
            let load_place = alloc.places[v_load as usize];
            assert_eq!(
                load_place, addr_place,
                "v_load should reuse v_addr's freed register on {target:?}",
            );
        }
    }

    /// `Inst::Mcpy { dst, src, size }` returns its `dst` pointer.
    /// When `dst` dies at the Mcpy, the result re-uses its register
    /// so the final `mov result, dst` self-elides. `b.mcpy()`
    /// discards push's ValueId so the test locates the Mcpy inst by
    /// scanning the finished function. Return a constant so the
    /// return-hint pass does not pre-empt the Mcpy result's slot.
    #[test]
    fn mcpy_dst_coalesce_fires_when_dst_dies_at_mcpy() {
        use crate::c5::codegen::ssa::build::SsaBuilder;

        let mut b = SsaBuilder::new(0, 0, false);
        let v_dst = b.imm(0x2000);
        let v_src = b.imm(0x3000);
        b.mcpy(v_dst, v_src, 8);
        let v_zero = b.imm(0);
        b.return_(v_zero);
        let func = b.finish();

        let mcpy_idx = func
            .insts
            .iter()
            .position(|i| matches!(i, Inst::Mcpy { .. }))
            .expect("Mcpy inst");
        // The coalesce hint is target-independent: the Mcpy emit on
        // every supported target reads the dst-pointer operand once
        // and never overwrites it, so the result-reuse arm fires
        // identically. Exercise every target so an arch-specific
        // emit change that violates the no-overwrite invariant fails
        // here at allocation time rather than later in a fixture.
        for target in [
            Target::MacOSAarch64,
            Target::LinuxAarch64,
            Target::WindowsAarch64,
            Target::LinuxX64,
            Target::WindowsX64,
        ] {
            let alloc = allocate(&func, target);
            let dst_place = alloc.places[v_dst as usize];
            let mcpy_place = alloc.places[mcpy_idx];
            assert_eq!(
                mcpy_place, dst_place,
                "Mcpy result should reuse v_dst's freed register on {target:?}",
            );
        }
    }

    /// A loop header `phi(v_init, v_back)` with `v_back` defined in the
    /// loop body shares a single physical register with the phi result.
    /// Without this coalesce, the passthrough block between v_back's
    /// def and the loop header phi (the for-loop step or any
    /// terminator-only block) is free to clobber `v_back`'s register
    /// for unrelated values, and the predecessor-exit move at the back
    /// edge reads the wrong value.
    #[test]
    fn phi_back_edge_source_coalesces_with_phi_result() {
        use crate::c5::ir::{Block, FunctionSsa};
        // CFG:
        //   b0 -> b1
        //   b1: phi(b0:v_zero, b2:v_step); Bz exit b2
        //   b2: v_step = v_phi + 1; Jmp b1
        //   b3 (exit): Return v_phi
        let insts = alloc::vec![
            // block 0: v0 = Imm(0)
            Inst::Imm(0),
            // block 1: v1 = Phi { incoming=[b0:v0, b2:v3] }
            Inst::Phi {
                incoming: alloc::vec![(0, 0), (2, 3)],
                kind: LoadKind::I64,
            },
            // block 2: v2 = Imm(1); v3 = v1 + v2
            Inst::Imm(1),
            Inst::Binop {
                op: BinOp::Add,
                lhs: 1,
                rhs: 2,
            },
            // block 3 (exit): no inst; Return v1
        ];
        let blocks = alloc::vec![
            Block {
                start_pc: 0,
                inst_range: 0..1,
                terminator: Terminator::Jmp(1),
                exit_acc: 0,
            },
            Block {
                start_pc: 0,
                inst_range: 1..2,
                terminator: Terminator::Bz {
                    cond: 1,
                    target: 3,
                    fall_through: 2,
                },
                exit_acc: 1,
            },
            Block {
                start_pc: 0,
                inst_range: 2..4,
                terminator: Terminator::Jmp(1),
                exit_acc: 3,
            },
            Block {
                start_pc: 0,
                inst_range: 4..4,
                terminator: Terminator::Return(1),
                exit_acc: 1,
            },
        ];
        let func = FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            has_returns_twice_call: false,
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        };
        for target in [
            Target::MacOSAarch64,
            Target::LinuxAarch64,
            Target::WindowsAarch64,
            Target::LinuxX64,
            Target::WindowsX64,
        ] {
            let alloc = allocate(&func, target);
            let phi_place = alloc.places[1];
            let step_place = alloc.places[3];
            assert_eq!(
                phi_place, step_place,
                "phi result (v1) and its back-edge source (v3) must coalesce on {target:?}",
            );
        }
    }

    /// When the spill path picks a victim that belongs to a phi
    /// class with more than one member, it must mark the class root
    /// as `Place::Spill` so the realign post-pass propagates the
    /// spill to every member. Without that propagation, realign
    /// walks the spilled value back to the (unchanged) root and
    /// copies the root's stale `IntReg` over the spill, leaving the
    /// new owner's class and the victim's class both claiming the
    /// same physical register.
    ///
    /// Post-condition: across the whole function, no two distinct
    /// non-singleton class roots share an `IntReg` or `FpReg`.
    /// Singleton classes naturally reuse registers across
    /// non-overlapping live ranges, so the check filters them out.
    /// c4.c is large enough to drive the AArch64 + SysV callee-
    /// saved budget into the spill path with phi classes.
    #[test]
    fn distinct_phi_class_roots_never_share_a_register() {
        let funcs = lift("tests/fixtures/c/c4.c");
        for target in [
            Target::MacOSAarch64,
            Target::LinuxAarch64,
            Target::WindowsAarch64,
            Target::LinuxX64,
            Target::WindowsX64,
        ] {
            for f in &funcs {
                let alloc = allocate(f, target);
                let live = crate::c5::codegen::ssa::liveness::Liveness::compute(f);
                let mut classes = crate::c5::codegen::ssa::phi_class::PhiClasses::build(f, &live);
                let mut non_singleton_root = alloc::vec![false; f.insts.len()];
                for v in 0..f.insts.len() {
                    let root = classes.find(v as ValueId) as usize;
                    if root != v {
                        non_singleton_root[root] = true;
                    }
                }
                let mut int_owner: [Option<ValueId>; 64] = [None; 64];
                let mut fp_owner: [Option<ValueId>; 64] = [None; 64];
                for (v, &is_root) in non_singleton_root.iter().enumerate() {
                    if !is_root {
                        continue;
                    }
                    let (slot_table, reg) = match alloc.places[v] {
                        Place::IntReg(r) => (&mut int_owner, r),
                        Place::FpReg(r) => (&mut fp_owner, r),
                        _ => continue,
                    };
                    let slot = &mut slot_table[reg as usize];
                    if let Some(prev) = *slot {
                        panic!(
                            "fn at pc {} on {target:?}: non-singleton class roots \
                             v{prev} and v{v} both claim register {reg}",
                            f.ent_pc,
                        );
                    }
                    *slot = Some(v as ValueId);
                }
            }
        }
    }
}
