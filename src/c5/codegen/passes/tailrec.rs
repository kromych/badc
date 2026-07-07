//! Self-tail-recursion elimination.
//!
//! Turns a function's tail-position calls to itself into a loop back
//! edge, so the recursion runs in constant stack space and pays one
//! branch per level instead of a call / return pair. Runs under `-O`
//! after the inliner, on the promoted SSA (parameters read through
//! `ParamRef`, scalar locals as phis).
//!
//! Two tail shapes are recognised in a block that ends in `Return`,
//! where the last effectful instruction is a direct self-call `C`
//! (`Inst::Call { target_pc == ent_pc }`) whose dependent cone reaches
//! only the terminator:
//!
//!   * constant tail: `Return(Imm K)` with `C`'s result unused. Every
//!     other `Return` in the function must yield the same `Imm K`, so
//!     the loop returns `K` on exit (covers a void helper's recursion).
//!   * integer accumulator: `Return([Extend](op(acc, C)))` with
//!     `op` an integer `Add` / `Mul` (associative and commutative on
//!     two's-complement, so the reassociation the loop performs is
//!     exact) and the non-call operand defined independently of `C`.
//!     A narrow return type re-narrows the sum with the leading
//!     `Extend`; that width is carried onto the loop's accumulator.
//!
//! The rewrite rebuilds the function (value ids are positional, so the
//! whole body is remapped): the entry block keeps its prologue
//! (`AllocaInit`, `ParamRef`s, dead cell loads) and jumps to a
//! synthesized header `H` appended after the existing blocks. `H`
//! carries one phi per parameter, `(entry -> ParamRef, tail -> back
//! edge)`, plus an accumulator phi in the accumulator mode; the entry's
//! former body and terminator move into `H`. Each tail block drops the
//! call cone and jumps to `H`; its per-parameter back-edge operand is
//! the call argument re-narrowed to the parameter's declared width
//! (the signed-narrow `Extend` a real call's `ParamRef` would apply --
//! the entry `ParamRef` no longer runs on iterations past the first),
//! and its accumulator operand is `op(acc, other)`. In accumulator mode
//! every non-tail `Return(x)` becomes `Return([Extend](op(acc, x)))`.
//!
//! The synthesized shape is a single conditional back edge into `H`,
//! not a `for(;;)` / early-return chain. Pure tail calls whose return
//! is the call value are left to the emit-time `jmp` conversion
//! (`detect_tail_call`), which this pass never overlaps: it matches
//! only `Return(Imm)` and `Return(op(acc, call))`, never `Return(call)`.

use alloc::collections::BTreeSet;
use alloc::vec;
use alloc::vec::Vec;

use super::inline::{map_v, remap_caller_inst, remap_terminator};
use crate::c5::codegen::ssa::reg_alloc::for_each_operand;
use crate::c5::ir::{
    BinOp, Block, BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator, ValueId,
};

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for f in funcs.iter_mut() {
        if let Some(plan) = analyze(f) {
            rewrite(f, &plan);
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum AccOp {
    Add,
    Mul,
}

impl AccOp {
    fn binop(self) -> BinOp {
        match self {
            AccOp::Add => BinOp::Add,
            AccOp::Mul => BinOp::Mul,
        }
    }
    /// Additive / multiplicative identity for the accumulator seed.
    fn identity(self) -> i64 {
        match self {
            AccOp::Add => 0,
            AccOp::Mul => 1,
        }
    }
    fn from_binop(op: BinOp) -> Option<AccOp> {
        match op {
            BinOp::Add => Some(AccOp::Add),
            BinOp::Mul => Some(AccOp::Mul),
            _ => None,
        }
    }
}

enum Mode {
    /// Every self-tail-call return and every other return yields `K`.
    Const,
    /// `Return([Extend](op(acc, other)))`; `narrow` is the return-type
    /// width the sum is re-narrowed to (`None` for a full-width return).
    Accum { op: AccOp, narrow: Option<LoadKind> },
}

/// A self-tail-call block turned into a loop back edge.
struct TailBlock {
    block: BlockId,
    /// Old-space ids to drop: the self-call and its dependent cone.
    drop: BTreeSet<u32>,
    /// The self-call's arguments (old space), one per declared parameter.
    args: Vec<ValueId>,
    /// Accumulator mode: the non-call operand of the combining binop
    /// (old space). `NO_VALUE` in `Const` mode.
    other: ValueId,
}

struct Plan {
    mode: Mode,
    tail: Vec<TailBlock>,
    /// Non-tail return blocks (rewritten in accumulator mode).
    base: Vec<BlockId>,
    /// Per parameter present as an entry `ParamRef`: `(idx, entry pc, kind)`.
    params: Vec<(u32, u32, LoadKind)>,
    /// Entry instructions kept in place (prologue).
    entry_keep: Vec<u32>,
    /// Entry instructions relocated into the header.
    entry_move: Vec<u32>,
}

/// Instructions with an observable effect or that must not be reordered
/// past the recursive call when it becomes a loop back edge.
fn is_effectful(inst: &Inst) -> bool {
    matches!(
        inst,
        Inst::Call { .. }
            | Inst::CallIndirect { .. }
            | Inst::CallExt { .. }
            | Inst::Store { .. }
            | Inst::StoreIndexed { .. }
            | Inst::StoreLocal { .. }
            | Inst::Mcpy { .. }
            | Inst::AtomicRmw { .. }
            | Inst::AtomicCas { .. }
            | Inst::Intrinsic { .. }
            | Inst::TailExt(_)
            | Inst::Load { volatile: true, .. }
            | Inst::LoadLocal { volatile: true, .. }
    )
}

/// Mark every value referenced as an instruction operand, a terminator
/// operand, or a block's exit accumulator.
fn use_mask(func: &FunctionSsa) -> Vec<bool> {
    let n = func.insts.len();
    let mut used = vec![false; n];
    let mut mark = |v: ValueId| {
        if v != NO_VALUE && (v as usize) < n {
            used[v as usize] = true;
        }
    };
    for inst in &func.insts {
        for_each_operand(inst, &mut mark);
    }
    for blk in &func.blocks {
        match blk.terminator {
            Terminator::Return(v) => mark(v),
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => mark(cond),
            Terminator::GotoIndirect { target } | Terminator::JumpTable { idx: target, .. } => {
                mark(target)
            }
            _ => {}
        }
        mark(blk.exit_acc);
    }
    used
}

/// Whether any control-flow reference names the entry block.
fn targets_entry(func: &FunctionSsa) -> bool {
    for blk in &func.blocks {
        let hit = match blk.terminator {
            Terminator::Jmp(t) | Terminator::FallThrough(t) => t == 0,
            Terminator::Bz {
                target,
                fall_through,
                ..
            }
            | Terminator::Bnz {
                target,
                fall_through,
                ..
            } => target == 0 || fall_through == 0,
            _ => false,
        };
        if hit {
            return true;
        }
    }
    for inst in &func.insts {
        if let Inst::Phi { incoming, .. } = inst
            && incoming.iter().any(|&(p, _)| p == 0)
        {
            return true;
        }
    }
    func.jump_tables.iter().any(|t| t.contains(&0))
}

/// The self-call's dependent cone within `block_range`: the call itself
/// and every instruction transitively reading a cone value.
fn call_cone(
    func: &FunctionSsa,
    block_range: core::ops::Range<u32>,
    call_pc: u32,
) -> BTreeSet<u32> {
    let mut cone = BTreeSet::new();
    cone.insert(call_pc);
    let mut changed = true;
    while changed {
        changed = false;
        for pc in block_range.clone() {
            if cone.contains(&pc) {
                continue;
            }
            let mut hit = false;
            for_each_operand(&func.insts[pc as usize], |v| {
                if cone.contains(&v) {
                    hit = true;
                }
            });
            if hit {
                cone.insert(pc);
                changed = true;
            }
        }
    }
    cone
}

/// Per-block classification of a `Return` block.
enum Class {
    /// Not a return block.
    Interior,
    /// A return with no self-tail-call (a loop exit / base case).
    Base,
    /// `Return(Imm K)` after a dead-result self-call.
    TailConst(TailBlock, i64),
    /// `Return([Extend](op(acc, call)))`.
    TailAccum(TailBlock, AccOp, Option<LoadKind>),
    /// A shape the pass cannot express; bail on the whole function.
    Bail,
}

fn classify(func: &FunctionSsa, b: BlockId) -> Class {
    let blk = &func.blocks[b as usize];
    let Terminator::Return(r) = blk.terminator else {
        return Class::Interior;
    };
    let mut last_eff = None;
    for pc in blk.inst_range.clone() {
        if is_effectful(&func.insts[pc as usize]) {
            last_eff = Some(pc);
        }
    }
    let Some(call_pc) = last_eff else {
        return Class::Base;
    };
    let args = match &func.insts[call_pc as usize] {
        Inst::Call {
            target_pc,
            args,
            arg_aggs,
            ret_agg,
            ..
        } if *target_pc == func.ent_pc
            && ret_agg.is_none()
            && arg_aggs.iter().all(Option::is_none)
            && args.len() == func.n_params =>
        {
            args.clone()
        }
        // The last effectful op is not a plain self-call (a foreign call
        // or an aggregate-passing self-call): a base return.
        _ => return Class::Base,
    };
    // A pure tail call whose value is returned is left to the emit-time
    // `jmp` conversion; mixing it with the loop forms would need the
    // accumulator to carry the recursion result.
    if r == call_pc {
        return Class::Bail;
    }
    let cone = call_cone(func, blk.inst_range.clone(), call_pc);
    // Constant tail: the return is a literal and the call result is dead
    // (its cone reaches nothing that the return reads).
    if let Some(Inst::Imm(k)) = func.insts.get(r as usize)
        && !cone.contains(&r)
    {
        return Class::TailConst(
            TailBlock {
                block: b,
                drop: cone,
                args,
                other: NO_VALUE,
            },
            *k,
        );
    }
    // Accumulator tail: `Return([Extend](op(acc, call)))`.
    let (combine, narrow) = match func.insts.get(r as usize) {
        Some(Inst::Extend { value, kind }) => (*value, Some(*kind)),
        _ => (r, None),
    };
    let Some(Inst::Binop { op, lhs, rhs }) = func.insts.get(combine as usize) else {
        return Class::Bail;
    };
    let Some(acc_op) = AccOp::from_binop(*op) else {
        return Class::Bail;
    };
    let other = if *lhs == call_pc && *rhs != call_pc {
        *rhs
    } else if *rhs == call_pc && *lhs != call_pc {
        *lhs
    } else {
        return Class::Bail;
    };
    // The accumulated operand must not depend on the recursive result.
    if cone.contains(&other) {
        return Class::Bail;
    }
    Class::TailAccum(
        TailBlock {
            block: b,
            drop: cone,
            args,
            other,
        },
        acc_op,
        narrow,
    )
}

fn analyze(func: &FunctionSsa) -> Option<Plan> {
    if func.is_variadic
        || func.ret_is_fp
        || func.ret_agg.is_some()
        || func.has_returns_twice_call
        || func.param_fp_mask != 0
        || !func.computed_goto_targets.is_empty()
        || func.blocks.len() < 2
        || func.param_aggs.iter().any(Option::is_some)
    {
        return None;
    }
    // Address-taken slots, allocas, computed-goto addresses, and slot
    // stores keep frame or block state that a loop would reuse across
    // iterations; keep such a body recursive.
    for inst in &func.insts {
        match inst {
            Inst::LocalAddr(_)
            | Inst::BlockAddr(_)
            | Inst::Intrinsic { .. }
            | Inst::StoreLocal { .. } => return None,
            _ => {}
        }
    }
    // The entry block's body and terminator move into the header, and
    // the entry is repointed to it; nothing may branch to the entry.
    if targets_entry(func) {
        return None;
    }
    // The entry must not itself be a return (a single-block function has
    // no cross-block tail recursion to remove).
    if matches!(func.blocks[0].terminator, Terminator::Return(_)) {
        return None;
    }
    let used = use_mask(func);
    // A live parameter- or local-slot load means the value was not
    // promoted; iterations past the first would read the stale frame.
    for (i, inst) in func.insts.iter().enumerate() {
        if matches!(inst, Inst::LoadLocal { .. }) && used[i] {
            return None;
        }
    }
    // Every `ParamRef` must live in the entry block, one per parameter.
    let entry = func.blocks[0].inst_range.clone();
    let mut params: Vec<(u32, u32, LoadKind)> = Vec::new();
    for (i, inst) in func.insts.iter().enumerate() {
        if let Inst::ParamRef { idx, kind } = inst {
            if !entry.contains(&(i as u32)) || params.iter().any(|&(p, _, _)| p == *idx) {
                return None;
            }
            params.push((*idx, i as u32, *kind));
        }
    }

    let mut tail: Vec<TailBlock> = Vec::new();
    let mut base: Vec<BlockId> = Vec::new();
    let mut mode: Option<Mode> = None;
    let mut const_k: Option<i64> = None;
    for b in 1..func.blocks.len() as BlockId {
        match classify(func, b) {
            Class::Interior => {}
            Class::Base => base.push(b),
            Class::Bail => return None,
            Class::TailConst(tb, k) => {
                match &mode {
                    None => mode = Some(Mode::Const),
                    Some(Mode::Const) => {}
                    Some(Mode::Accum { .. }) => return None,
                }
                // Every constant tail must yield the same literal.
                match const_k {
                    None => const_k = Some(k),
                    Some(k0) if k0 == k => {}
                    Some(_) => return None,
                }
                tail.push(tb);
            }
            Class::TailAccum(tb, op, narrow) => {
                match &mode {
                    None => mode = Some(Mode::Accum { op, narrow }),
                    Some(Mode::Accum { op: o0, narrow: n0 }) => {
                        if *o0 != op || *n0 != narrow {
                            return None;
                        }
                    }
                    Some(Mode::Const) => return None,
                }
                tail.push(tb);
            }
        }
    }
    let mode = mode?;
    match &mode {
        Mode::Const => {
            // The shared exit literal is the tail blocks' constant; every
            // non-tail return must produce the same one.
            let k = const_k?;
            for &b in &base {
                let Terminator::Return(r) = func.blocks[b as usize].terminator else {
                    continue;
                };
                match func.insts.get(r as usize) {
                    Some(Inst::Imm(kk)) if *kk == k => {}
                    _ => return None,
                }
            }
        }
        Mode::Accum { .. } => {
            // Each base return needs a value to fold into the accumulator.
            for &b in &base {
                if matches!(
                    func.blocks[b as usize].terminator,
                    Terminator::Return(NO_VALUE)
                ) {
                    return None;
                }
            }
        }
    }

    let mut entry_keep = Vec::new();
    let mut entry_move = Vec::new();
    for pc in entry {
        match &func.insts[pc as usize] {
            // Dead cell loads were rejected above when live, so any load
            // here is a dead prologue cell kept in place.
            Inst::AllocaInit(_) | Inst::ParamRef { .. } | Inst::LoadLocal { .. } => {
                entry_keep.push(pc)
            }
            _ => entry_move.push(pc),
        }
    }

    Some(Plan {
        mode,
        tail,
        base,
        params,
        entry_keep,
        entry_move,
    })
}

/// Whether a parameter of `kind` needs the back-edge argument
/// re-narrowed: the entry `ParamRef` load sign-extends the signed narrow
/// kinds; everything else arrives full width (C99 6.3.1.3).
fn back_edge_needs_extend(kind: LoadKind) -> bool {
    matches!(kind, LoadKind::I8 | LoadKind::I16 | LoadKind::I32)
}

/// Whether `v`'s definition already produces a value canonical to
/// `kind`, so wrapping it in `Extend { kind }` is idempotent. An
/// `Extend` / `ParamRef` / `Phi` of the same kind already holds the
/// sign-extended low bits, so the re-extension is a no-op that would
/// otherwise stack a redundant `movsx` / `sxtw` the same-value dedup
/// cannot fold (it keys on the extend's operand).
fn already_canonical(func: &FunctionSsa, v: ValueId, kind: LoadKind) -> bool {
    matches!(
        func.insts.get(v as usize),
        Some(Inst::Extend { kind: k, .. } | Inst::ParamRef { kind: k, .. } | Inst::Phi { kind: k, .. })
            if *k == kind
    )
}

fn rewrite(func: &mut FunctionSsa, plan: &Plan) {
    let n_old = func.insts.len();
    let n_blocks = func.blocks.len();
    let header: BlockId = n_blocks as BlockId;
    let (acc_op, narrow) = match plan.mode {
        Mode::Accum { op, narrow } => (Some(op), narrow),
        Mode::Const => (None, None),
    };
    let tail_of: Vec<Option<usize>> = {
        let mut v = vec![None; n_blocks];
        for (t, tb) in plan.tail.iter().enumerate() {
            v[tb.block as usize] = Some(t);
        }
        v
    };
    let base_of: Vec<Option<usize>> = {
        let mut v = vec![None; n_blocks];
        for (bi, &b) in plan.base.iter().enumerate() {
            v[b as usize] = Some(bi);
        }
        v
    };

    let mut remap: Vec<ValueId> = vec![NO_VALUE; n_old];
    // New-instruction ids (positions are stable from the first pass; the
    // operand fields converge as `remap` fills in over the passes).
    let mut paramref_new = vec![NO_VALUE; plan.params.len()];
    let mut phi_id = vec![NO_VALUE; plan.params.len()];
    let mut acc_init_id = NO_VALUE;
    let mut acc_phi_id = NO_VALUE;
    let mut back_extend = vec![vec![NO_VALUE; plan.params.len()]; plan.tail.len()];
    let mut acc_back = vec![NO_VALUE; plan.tail.len()];

    let mut new_insts: Vec<Inst> = Vec::with_capacity(n_old + 8);
    let mut new_src: Vec<(u32, u32)> = Vec::new();
    let mut new_f32: Vec<bool> = Vec::new();
    let mut new_blocks: Vec<Block> = Vec::with_capacity(n_blocks + 1);

    let mut guard = n_old + 4;
    loop {
        new_insts.clear();
        new_src.clear();
        new_f32.clear();
        new_blocks.clear();
        let before = remap.clone();

        // Clone an old instruction into the new tape, remapping operands
        // and (for a carried-over phi) repointing the entry predecessor
        // to the header.
        macro_rules! emit_old {
            ($pc:expr) => {{
                let pc = $pc;
                let mut inst = func.insts[pc as usize].clone();
                remap_caller_inst(&mut inst, &remap);
                if let Inst::Phi { incoming, .. } = &mut inst {
                    for (pred, _) in incoming.iter_mut() {
                        if *pred == 0 {
                            *pred = header;
                        }
                    }
                }
                let id = new_insts.len() as u32;
                new_insts.push(inst);
                new_src.push(func.inst_src.get(pc as usize).copied().unwrap_or((0, 0)));
                new_f32.push(func.f32_values.get(pc as usize).copied().unwrap_or(false));
                remap[pc as usize] = id;
                id
            }};
        }
        macro_rules! emit_new {
            ($inst:expr) => {{
                let id = new_insts.len() as u32;
                new_insts.push($inst);
                new_src.push((0, 0));
                new_f32.push(false);
                id
            }};
        }

        // Entry block: keep the prologue, seed the accumulator, jump to H.
        let start = new_insts.len() as u32;
        for &pc in &plan.entry_keep {
            let id = emit_old!(pc);
            if let Inst::ParamRef { idx, .. } = func.insts[pc as usize]
                && let Some(pi) = plan.params.iter().position(|&(p, _, _)| p == idx)
            {
                paramref_new[pi] = id;
                // A ParamRef's own new id is only referenced by the phi's
                // entry incoming; every body use routes to the phi (set
                // at the end of the pass), so leave `remap[pc]` untouched.
                remap[pc as usize] = before[pc as usize];
            }
        }
        if let Some(op) = acc_op {
            acc_init_id = emit_new!(Inst::Imm(op.identity()));
        }
        new_blocks.push(Block {
            start_pc: func.blocks[0].start_pc,
            inst_range: start..new_insts.len() as u32,
            terminator: Terminator::Jmp(header),
            exit_acc: NO_VALUE,
        });

        // Blocks 1..n_old: interior, base, and tail blocks keep their ids.
        for b in 1..n_blocks {
            let start = new_insts.len() as u32;
            let blk = func.blocks[b].clone();
            let (terminator, exit_acc);
            if let Some(t) = tail_of[b] {
                for pc in blk.inst_range.clone() {
                    if plan.tail[t].drop.contains(&pc) {
                        remap[pc as usize] = NO_VALUE;
                        continue;
                    }
                    emit_old!(pc);
                }
                for (pi, &(param_idx, _, kind)) in plan.params.iter().enumerate() {
                    let arg_old = plan.tail[t].args[param_idx as usize];
                    let arg = map_v(arg_old, &remap);
                    back_extend[t][pi] = if back_edge_needs_extend(kind)
                        && !already_canonical(func, arg_old, kind)
                    {
                        emit_new!(Inst::Extend { value: arg, kind })
                    } else {
                        arg
                    };
                }
                if let Some(op) = acc_op {
                    let other = map_v(plan.tail[t].other, &remap);
                    let sum = emit_new!(Inst::Binop {
                        op: op.binop(),
                        lhs: acc_phi_id,
                        rhs: other,
                    });
                    acc_back[t] = match narrow {
                        Some(kind) => emit_new!(Inst::Extend { value: sum, kind }),
                        None => sum,
                    };
                }
                terminator = Terminator::Jmp(header);
                exit_acc = NO_VALUE;
            } else if let (Some(op), Some(_bi)) = (acc_op, base_of[b]) {
                for pc in blk.inst_range.clone() {
                    emit_old!(pc);
                }
                let Terminator::Return(r) = blk.terminator else {
                    unreachable!("base block classified with a Return terminator");
                };
                let x = map_v(r, &remap);
                let sum = emit_new!(Inst::Binop {
                    op: op.binop(),
                    lhs: acc_phi_id,
                    rhs: x,
                });
                let ret = match narrow {
                    Some(kind) => emit_new!(Inst::Extend { value: sum, kind }),
                    None => sum,
                };
                terminator = Terminator::Return(ret);
                exit_acc = ret;
            } else {
                for pc in blk.inst_range.clone() {
                    emit_old!(pc);
                }
                let mut t = blk.terminator;
                remap_terminator(&mut t, &remap);
                terminator = t;
                exit_acc = map_v(blk.exit_acc, &remap);
            }
            new_blocks.push(Block {
                start_pc: blk.start_pc,
                inst_range: start..new_insts.len() as u32,
                terminator,
                exit_acc,
            });
        }

        // Header: parameter phis, accumulator phi, the entry's former
        // body, and the entry's former terminator.
        let start = new_insts.len() as u32;
        for (pi, &(_, _, kind)) in plan.params.iter().enumerate() {
            let mut incoming = vec![(0 as BlockId, paramref_new[pi])];
            for tb in &plan.tail {
                let t = tail_of[tb.block as usize].unwrap();
                incoming.push((tb.block, back_extend[t][pi]));
            }
            phi_id[pi] = emit_new!(Inst::Phi { incoming, kind });
        }
        if acc_op.is_some() {
            let mut incoming = vec![(0 as BlockId, acc_init_id)];
            for tb in &plan.tail {
                let t = tail_of[tb.block as usize].unwrap();
                incoming.push((tb.block, acc_back[t]));
            }
            acc_phi_id = emit_new!(Inst::Phi {
                incoming,
                kind: narrow.unwrap_or(LoadKind::I64),
            });
        }
        for &pc in &plan.entry_move {
            emit_old!(pc);
        }
        let mut term = func.blocks[0].terminator;
        remap_terminator(&mut term, &remap);
        let exit_acc = map_v(func.blocks[0].exit_acc, &remap);
        new_blocks.push(Block {
            start_pc: func.blocks[0].start_pc,
            inst_range: start..new_insts.len() as u32,
            terminator: term,
            exit_acc,
        });

        // Every body use of a parameter resolves to its header phi.
        for (pi, &(_, pc, _)) in plan.params.iter().enumerate() {
            remap[pc as usize] = phi_id[pi];
        }

        if remap == before {
            break;
        }
        guard -= 1;
        if guard == 0 {
            break;
        }
    }

    // Retarget cross-TU reference tables through the value remap; the
    // dropped self-calls are same-TU and never appear in these lists.
    let retarget = |refs: &[(u32, u32)], remap: &[ValueId]| -> Vec<(u32, u32)> {
        refs.iter()
            .filter_map(|&(idx, sym)| {
                let nv = map_v(idx, remap);
                (nv != NO_VALUE).then_some((nv, sym))
            })
            .collect()
    };
    func.extern_call_refs = retarget(&func.extern_call_refs, &remap);
    func.extern_imm_code_refs = retarget(&func.extern_imm_code_refs, &remap);
    func.extern_imm_data_refs = retarget(&func.extern_imm_data_refs, &remap);
    func.extern_tls_refs = retarget(&func.extern_tls_refs, &remap);

    func.insts = new_insts;
    func.inst_src = new_src;
    func.f32_values = new_f32;
    func.blocks = new_blocks;
}

#[cfg(test)]
mod tests;
