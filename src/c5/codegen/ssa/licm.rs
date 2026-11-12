//! Hoisting loop-invariant materializations out of loop bodies.
//!
//! An operand-free instruction -- a file-scope object's address, a
//! function address, a TLS base, a wide integer constant -- yields a
//! link-time or compile-time constant, so a copy of it inside a loop
//! recomputes the same value every iteration. This pass places one copy
//! in a block outside the loop that dominates the body and points the
//! body's uses at it. No memory analysis is involved: the instructions
//! have no operands and read no memory, so invariance is a property of
//! the opcode rather than of the loop.
//!
//! A `BinopI` whose immediate the target builds into a register at the
//! site (an AArch64 reciprocal-multiply constant, an x86-64 immediate
//! wider than imm32) is the same materialization with the operand
//! folded in. Such a site is rewritten to the register form of the
//! binop over a hoisted `Inst::Imm`, which puts it on the path above --
//! one mechanism covers both shapes.
//!
//! Destination: the immediate dominator of the header of the outermost
//! loop containing the site, taken repeatedly until the destination
//! itself is in no loop. That block dominates the header, the header
//! dominates every block of a natural loop, and dominance is
//! transitive, so it dominates every site and every predecessor an
//! edge use of a site sits on. After `passes::split_crit_edges` a
//! single-entry loop's header has a dedicated predecessor, which is
//! what the immediate dominator resolves to.
//!
//! Placement is measured, not assumed: a hoist lengthens a live range
//! across the whole loop, so the function is allocated a second time
//! and the plan is kept only when the loop-weighted spill traffic plus
//! the prologue's save / restore pairs does not grow. A hoist that
//! takes a register the loop needed shows up there as extra traffic,
//! and one that buys its register out of the callee-saved bank as an
//! extra save; either restores the tape, so the pass cannot leave a
//! function worse than the un-hoisted baseline. The number of values
//! hoisted into one destination is also capped against the register
//! file, so one loop cannot force the whole plan out.
//!
//! A second phase moves loads. In a loop whose body writes no memory --
//! no store, call, atomic, inline asm or intrinsic -- a load of an
//! invariant address reads the same value every iteration. The copy
//! executes even when the loop runs no iteration, so only a load that
//! cannot fault moves: one of a frame slot, or one of the unit's data
//! image within its bounds. It goes before the outermost such loop, and
//! is kept when the spill traffic it adds does not exceed the loads it
//! removes.
//!
//! A third phase moves integer arithmetic whose operands are all defined
//! outside a loop, or moved out of it, before the outermost such loop,
//! under the same measure. Only an instruction that cannot trap moves, as
//! the copy executes even when the loop runs no iteration; a comparison
//! stays with the branch or select that fuses it.

use alloc::vec;
use alloc::vec::Vec;
use hashbrown::HashMap;

use super::super::ir::{BinOp, BlockId, FunctionSsa, Inst, LoadKind, NO_VALUE, ValueId};
use super::mem2reg::{dominators, predecessors};
use super::reg_alloc::Allocation;
use super::tape::{At, Insertion, Undo};
use super::{FixedRegs, Target};
use crate::c5::codegen::passes::drop_redundant_extend::{
    compute_high_clear, compute_high_observed,
};
use crate::c5::codegen::passes::layout::{natural_loops, rpo_numbers};

const NO_BLOCK: BlockId = BlockId::MAX;
/// `extern_*_refs` sentinel for an instruction with no bound symbol.
const NO_SYM: u32 = u32::MAX;

/// Identity of a materialization: two sites with the same key produce
/// the same value, so one hoisted copy serves both. The extern-symbol
/// binding is part of the key -- an `ImmData` bound to a cross-TU
/// symbol names that symbol's address, not a writer-layout offset --
/// and so is the `f32_values` flag of an `Imm`, which decides the width
/// an FP reader transfers the constant at.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, PartialOrd, Ord)]
enum Key {
    Imm(i64, bool),
    Data(i64, u32),
    Code(usize, u32),
    ExtCode(i64),
    Tls(i64, u32),
}

impl Key {
    fn inst(self) -> Inst {
        match self {
            Key::Imm(k, _) => Inst::Imm(k),
            Key::Data(k, _) => Inst::ImmData(k),
            Key::Code(t, _) => Inst::ImmCode(t),
            Key::ExtCode(b) => Inst::ImmExtCode(b),
            Key::Tls(o, _) => Inst::TlsAddr(o),
        }
    }

    /// `f32_values` entry the copy inherits from the site.
    fn is_f32(self) -> bool {
        matches!(self, Key::Imm(_, true))
    }

    /// Bound symbol and the `FunctionSsa` table it rides, so the copy
    /// inherits the site's binding.
    fn binding(self) -> (u32, SymTable) {
        match self {
            Key::Data(_, s) => (s, SymTable::Data),
            Key::Code(_, s) => (s, SymTable::Code),
            Key::Tls(_, s) => (s, SymTable::Tls),
            _ => (NO_SYM, SymTable::None),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SymTable {
    None,
    Data,
    Code,
    Tls,
}

/// One materialization placed outside a loop, with the sites it serves.
#[derive(Clone)]
struct Hoist {
    key: Key,
    /// Tape index the copy goes ahead of; inside the destination block.
    at: ValueId,
    /// Loop-weighted instruction count the sites stop paying.
    profit: u64,
    /// Materializations whose uses move to the copy. Each is left in
    /// place with no reader, where the emit's dead-pure skip drops it.
    redirect: Vec<ValueId>,
    /// `BinopI` sites rewritten to the register form over the copy.
    unfold: Vec<ValueId>,
    /// No call in the loops the copy is live across, so it never takes a
    /// callee-saved register.
    call_free: bool,
}

/// Native instructions the target spends materializing `k`.
fn imm_cost(target: Target, k: i64) -> u32 {
    if target.is_aarch64() {
        crate::c5::codegen::aarch64::encode::imm64_insts(k as u64)
    } else {
        1
    }
}

/// Native instructions the target spends materializing an address that
/// a relocation supplies: an `adrp` + `add` pair on AArch64, one
/// RIP-relative `lea` on x86-64.
fn addr_cost(target: Target) -> u32 {
    if target.is_aarch64() { 2 } else { 1 }
}

/// Whether the target builds a `BinopI` immediate into a register at
/// the site rather than into the instruction's own immediate field;
/// `high_dead` when no consumer reads the result above bit 31.
/// The copy a hoist places is an integer `Inst::Imm`, so a float op --
/// which has no immediate form to unfold on either target -- is not one.
pub(super) fn binop_imm_materializes(target: Target, op: BinOp, imm: i64, high_dead: bool) -> bool {
    if crate::c5::ir::is_fp_op(op) {
        return false;
    }
    if target.is_aarch64() {
        crate::c5::codegen::aarch64::emit::binop_imm_materializes(op, imm, high_dead)
    } else {
        crate::c5::codegen::x86_64::emit::binop_imm_materializes(op, imm)
    }
}

/// Where a copy goes inside `b`: as late as the block allows, so the
/// hoisted value's range covers no more of the destination than it has
/// to. That is ahead of the last instruction, or ahead of the compare a
/// conditional terminator reads -- the emit may fuse that compare into
/// the branch, which no unrelated instruction may come between. `None`
/// when the position that leaves is a phi or a register read, neither
/// of which a copy may precede: a phi belongs to the block's leading run,
/// a `ParamRef`, a `ParamPart` or a `RetPart` reads an argument or result
/// register live until it, and an `AsmOut` its statement's output register.
fn insert_point(func: &FunctionSsa, b: BlockId) -> Option<ValueId> {
    let range = func.blocks[b as usize].inst_range.clone();
    if range.is_empty() {
        return None;
    }
    let mut at = range.end - 1;
    let mut cond = NO_VALUE;
    func.blocks[b as usize]
        .terminator
        .for_each_operand(|v| cond = v);
    if range.contains(&cond) {
        at = at.min(cond);
    }
    let blocked = (at..range.end).any(|i| {
        matches!(
            func.insts[i as usize],
            Inst::Phi { .. }
                | Inst::ParamRef { .. }
                | Inst::ParamPart { .. }
                | Inst::RetPart { .. }
                | Inst::AsmOut { .. }
        )
    });
    if blocked { None } else { Some(at) }
}

/// Destination block per block: where a materialization in it hoists
/// to, or [`NO_BLOCK`] when it is in no loop or no destination exists.
fn destinations(func: &FunctionSsa) -> Vec<BlockId> {
    let n = func.blocks.len();
    let mut dest = vec![NO_BLOCK; n];
    if n < 2 {
        return dest;
    }
    let idom = dominators(func);
    let preds = predecessors(func);
    let rpo = rpo_numbers(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    if loops.is_empty() {
        return dest;
    }
    // Outermost loop containing each block. Two natural loops are
    // disjoint or nested once loops sharing a header are merged, so the
    // largest body containing a block is the outermost one.
    let mut outer = vec![usize::MAX; n];
    for (li, l) in loops.iter().enumerate() {
        for &b in &l.body {
            let cur = outer[b as usize];
            if cur == usize::MAX || loops[cur].body.len() < l.body.len() {
                outer[b as usize] = li;
            }
        }
    }
    for (b, slot) in dest.iter_mut().enumerate() {
        let mut t = b as BlockId;
        for _ in 0..=n {
            let li = outer[t as usize];
            if li == usize::MAX {
                break;
            }
            let up = idom[loops[li].header as usize];
            if up == NO_BLOCK || up == loops[li].header {
                break;
            }
            t = up;
        }
        *slot = if t == b as BlockId { NO_BLOCK } else { t };
    }
    debug_assert!(
        dest.iter()
            .enumerate()
            .all(|(b, &d)| d == NO_BLOCK || dominates(&idom, d, b as BlockId)),
        "hoist destination does not dominate the site"
    );
    dest
}

/// Whether `a` dominates `b`, by walking `b` up the dominator tree.
/// The placement rests on this and nothing downstream would catch a
/// destination that misses it, so the plan checks it in debug builds.
fn dominates(idom: &[BlockId], a: BlockId, b: BlockId) -> bool {
    let mut t = b;
    for _ in 0..=idom.len() {
        if t == a {
            return true;
        }
        let up = idom[t as usize];
        if up == NO_BLOCK || up == t {
            return false;
        }
        t = up;
    }
    false
}

/// Symbol bound to each instruction in one of the extern-ref tables.
pub(super) fn sym_of(refs: &[(u32, u32)]) -> HashMap<u32, u32> {
    refs.iter().copied().collect()
}

/// Materializations worth hoisting, one entry per destination and key.
fn plan(func: &FunctionSsa, target: Target, fixed: FixedRegs) -> Vec<Hoist> {
    // A longjmp restores the callee-saved registers and the stack
    // pointer only, so a value the allocator leaves in a caller-saved
    // register does not survive the second return from a setjmp
    // (C99 7.13.2.1p3 requires an unchanged automatic object to). The
    // allocator does not model that edge, so a range this pass would
    // lengthen across one stays where the walker put it.
    if func.has_returns_twice_call {
        return Vec::new();
    }
    let dest = destinations(func);
    if dest.iter().all(|&d| d == NO_BLOCK) {
        return Vec::new();
    }
    let weights = super::reg_alloc::block_weights(func);
    let uses = super::reg_alloc::compute_use_counts(func);
    let data_sym = sym_of(&func.extern_imm_data_refs);
    let code_sym = sym_of(&func.extern_imm_code_refs);
    let tls_sym = sym_of(&func.extern_tls_refs);
    let mut high: Option<Vec<bool>> = None;
    let mut clear: Option<Vec<bool>> = None;
    let mut materializes = |v: ValueId, op: BinOp, imm: i64| {
        if !binop_imm_materializes(target, op, imm, false) {
            return false;
        }
        if binop_imm_materializes(target, op, imm, true) {
            return true;
        }
        let observed = high.get_or_insert_with(|| compute_high_observed(func))[v as usize];
        let operand_clear = (imm as u64) >> 32 == 0
            && match func.insts[v as usize] {
                Inst::BinopI { lhs, .. } => clear
                    .get_or_insert_with(|| compute_high_clear(func))
                    .get(lhs as usize)
                    .copied()
                    .unwrap_or(false),
                _ => false,
            };
        observed && !operand_clear
    };
    let mut at_of: Vec<Option<ValueId>> = vec![None; func.blocks.len()];
    let tls_call = super::reg_alloc::tls_addr_is_call(target, func);
    let mut calls = vec![false; func.blocks.len()];
    for (b, block) in func.blocks.iter().enumerate() {
        if dest[b] != NO_BLOCK
            && (block.inst_range.clone())
                .any(|v| super::reg_alloc::is_call_site(&func.insts[v as usize], tls_call))
        {
            calls[dest[b] as usize] = true;
        }
    }
    let mut out: Vec<Hoist> = Vec::new();
    let mut slot_of: HashMap<(BlockId, Key), usize> = HashMap::new();
    for (b, block) in func.blocks.iter().enumerate() {
        let to = dest[b];
        if to == NO_BLOCK {
            continue;
        }
        let at = match at_of[to as usize] {
            Some(at) => Some(at),
            None => {
                let p = insert_point(func, to);
                at_of[to as usize] = p;
                p
            }
        };
        let Some(at) = at else { continue };
        let wb = weights[b];
        for v in block.inst_range.clone() {
            if uses.get(v as usize).copied().unwrap_or(0) == 0 {
                continue;
            }
            let sym = |m: &HashMap<u32, u32>| m.get(&v).copied().unwrap_or(NO_SYM);
            let (key, cost, unfold) = match func.insts[v as usize] {
                Inst::ImmData(k) => (Key::Data(k, sym(&data_sym)), addr_cost(target), false),
                Inst::ImmCode(t) => (Key::Code(t, sym(&code_sym)), addr_cost(target), false),
                Inst::ImmExtCode(import) => (Key::ExtCode(import), addr_cost(target), false),
                Inst::TlsAddr(o) => (Key::Tls(o, sym(&tls_sym)), addr_cost(target), false),
                // A one-instruction constant costs no more at the site
                // than the register it would occupy across the loop.
                Inst::Imm(k) if imm_cost(target, k) > 1 => {
                    let f32 = func.f32_values.get(v as usize).copied().unwrap_or(false);
                    (Key::Imm(k, f32), imm_cost(target, k), false)
                }
                Inst::BinopI { op, rhs_imm, .. } if materializes(v, op, rhs_imm) => {
                    (Key::Imm(rhs_imm, false), imm_cost(target, rhs_imm), true)
                }
                _ => continue,
            };
            let slot = *slot_of.entry((to, key)).or_insert_with(|| {
                out.push(Hoist {
                    key,
                    at,
                    profit: 0,
                    redirect: Vec::new(),
                    unfold: Vec::new(),
                    call_free: !calls[to as usize],
                });
                out.len() - 1
            });
            out[slot].profit = out[slot]
                .profit
                .saturating_add(wb.saturating_mul(cost as u64));
            if unfold {
                out[slot].unfold.push(v);
            } else {
                out[slot].redirect.push(v);
            }
        }
    }
    cap_per_destination(func, target, fixed, out)
}

/// Keep the most profitable hoists per destination, bounded by a share
/// of the register file. Every hoist adds a value live across the whole
/// loop; past that bound the allocation retry would reject the plan
/// wholesale and the profitable entries would go with it.
fn cap_per_destination(
    func: &FunctionSsa,
    target: Target,
    fixed: FixedRegs,
    mut hoists: Vec<Hoist>,
) -> Vec<Hoist> {
    let cap = (super::reg_alloc::usable_gpr_count(target, fixed) / 2).max(1);
    // Destination block per hoist, read back off the insertion point.
    let mut block_of = vec![NO_BLOCK; func.insts.len()];
    for (b, block) in func.blocks.iter().enumerate() {
        for v in block.inst_range.clone() {
            block_of[v as usize] = b as BlockId;
        }
    }
    hoists.sort_by(|a, b| {
        b.profit
            .cmp(&a.profit)
            .then((a.at, a.key).cmp(&(b.at, b.key)))
    });
    let mut taken: HashMap<BlockId, usize> = HashMap::new();
    hoists.retain(|h| {
        let slot = taken.entry(block_of[h.at as usize]).or_insert(0);
        if *slot >= cap {
            return false;
        }
        *slot += 1;
        true
    });
    hoists.sort_by_key(|h| (h.at, h.key));
    hoists
}

/// A load placed before the loops that re-read it, with its sites.
struct LoadHoist {
    /// Tape index the copy goes ahead of; inside the destination block.
    at: ValueId,
    inst: Inst,
    /// The data offset of an address defined inside the loop, which a
    /// copy of its own `ImmData` gives the moved load.
    remat: Option<i64>,
    is_f32: bool,
    /// Loop-weighted loads the sites stop issuing.
    profit: u64,
    redirect: Vec<ValueId>,
}

/// Loads worth placing before the loops that hold them: a non-volatile
/// `LoadLocal`, or a `Load` of an address an unbound `ImmData` gives
/// within `data_len`, the unit's data image. The destination precedes
/// the outermost loop of the site's nest whose body writes no memory and
/// defines no part of the address.
fn plan_loads(func: &FunctionSsa, data_len: usize) -> Vec<LoadHoist> {
    if func.has_returns_twice_call || func.blocks.len() < 2 {
        return Vec::new();
    }
    let idom = dominators(func);
    let preds = predecessors(func);
    let rpo = rpo_numbers(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    if loops.is_empty() {
        return Vec::new();
    }
    let mut block_of = vec![NO_BLOCK; func.insts.len()];
    for (b, block) in func.blocks.iter().enumerate() {
        for v in block.inst_range.clone() {
            block_of[v as usize] = b as BlockId;
        }
    }
    let writes: Vec<bool> = (loops.iter())
        .map(|l| {
            (l.body.iter()).any(|&b| {
                (func.blocks[b as usize].inst_range.clone())
                    .any(|v| func.insts[v as usize].may_write_memory())
            })
        })
        .collect();
    let bound = sym_of(&func.extern_imm_data_refs);
    let weights = super::reg_alloc::block_weights(func);
    let uses = super::reg_alloc::compute_use_counts(func);
    let mut out: Vec<LoadHoist> = Vec::new();
    for (b, block) in func.blocks.iter().enumerate() {
        let b = b as BlockId;
        // The loops holding `b`, outermost first.
        let mut nest: Vec<usize> = (0..loops.len()).filter(|&l| loops[l].contains(b)).collect();
        nest.sort_by_key(|&l| core::cmp::Reverse(loops[l].body.len()));
        if nest.is_empty() {
            continue;
        }
        for v in block.inst_range.clone() {
            if uses.get(v as usize).copied().unwrap_or(0) == 0 {
                continue;
            }
            // The data offset a `Load`'s address names; a constant, so
            // the address is invariant wherever it is defined.
            let data = match func.insts[v as usize] {
                Inst::LoadLocal {
                    volatile: false, ..
                } => None,
                Inst::Load {
                    addr,
                    disp,
                    kind,
                    volatile: false,
                    ..
                } => match func.insts[addr as usize] {
                    Inst::ImmData(k)
                        if !bound.contains_key(&addr)
                            && k.checked_add(disp as i64).is_some_and(|a| {
                                a >= 0 && a as u64 + kind.bytes() as u64 <= data_len as u64
                            }) =>
                    {
                        Some((addr, k))
                    }
                    _ => continue,
                },
                _ => continue,
            };
            let Some(&l) = nest.iter().find(|&&l| !writes[l]) else {
                continue;
            };
            let dest = idom[loops[l].header as usize];
            if dest == NO_BLOCK || dest == loops[l].header {
                continue;
            }
            let Some(at) = insert_point(func, dest) else {
                continue;
            };
            // The address is reused where it precedes the copy outside the
            // loop, and rematerialized beside the copy otherwise.
            let remat = data.and_then(|(a, k)| {
                let b = block_of[a as usize];
                (loops[l].contains(b) || (b == dest && a >= at)).then_some(k)
            });
            let inst = func.insts[v as usize].clone();
            let key = (load_key(&inst), remat);
            let profit = weights[b as usize];
            match (out.iter_mut()).find(|h| h.at == at && (load_key(&h.inst), h.remat) == key) {
                Some(h) => {
                    h.profit = h.profit.saturating_add(profit);
                    h.redirect.push(v);
                }
                None => out.push(LoadHoist {
                    at,
                    remat,
                    is_f32: func.f32_values.get(v as usize).copied().unwrap_or(false),
                    inst,
                    profit,
                    redirect: alloc::vec![v],
                }),
            }
        }
    }
    out.sort_by_key(|h| h.at);
    out
}

/// Identity of a load: two with the same key read the same bytes the
/// same way, so one copy serves both.
fn load_key(inst: &Inst) -> Option<(i64, ValueId, i32, LoadKind, u8, bool)> {
    match *inst {
        Inst::LoadLocal {
            off, disp, kind, ..
        } => Some((off, NO_VALUE, disp, kind, 0, false)),
        Inst::Load {
            addr,
            disp,
            kind,
            align,
            pc_rel,
            ..
        } => Some((0, addr, disp, kind, align, pc_rel)),
        _ => None,
    }
}

/// A pure integer instruction moved before the loops that hold it.
struct PureHoist {
    /// Tape index the copy goes ahead of; inside the destination block.
    at: ValueId,
    /// The sites computing the same value there; the first is copied.
    sites: Vec<ValueId>,
    /// Loop-weighted instructions the site stops issuing, less the copy's.
    profit: u64,
}

/// Integer arithmetic whose value depends on its operands alone and which
/// cannot trap: division by a register can, by a constant only `MIN / -1`,
/// which a divisor other than 0 and -1 rules out.
fn invariant_op(inst: &Inst) -> bool {
    let plain = |op: BinOp| {
        matches!(
            op,
            BinOp::Or
                | BinOp::Xor
                | BinOp::And
                | BinOp::Shl
                | BinOp::Shr
                | BinOp::Shru
                | BinOp::Ror
                | BinOp::Add
                | BinOp::Sub
                | BinOp::Mul
                | BinOp::Mulh
                | BinOp::Mulhu
        )
    };
    match *inst {
        Inst::Binop { op, .. } => plain(op),
        Inst::BinopI { op, rhs_imm, .. } => {
            plain(op)
                || (matches!(op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu)
                    && rhs_imm != 0
                    && rhs_imm != -1)
        }
        Inst::Extend { .. } | Inst::Neg(_) => true,
        _ => false,
    }
}

/// The instructions of [`invariant_op`] whose operands are defined outside
/// a loop holding them, each with the destination before the outermost
/// such loop, in an order where a moved operand precedes its readers.
fn plan_pure(func: &FunctionSsa) -> Vec<PureHoist> {
    if func.has_returns_twice_call || func.blocks.len() < 2 {
        return Vec::new();
    }
    let idom = dominators(func);
    let preds = predecessors(func);
    let rpo = rpo_numbers(func);
    let loops = natural_loops(func, &idom, &preds, &rpo);
    if loops.is_empty() {
        return Vec::new();
    }
    let mut block_of = vec![NO_BLOCK; func.insts.len()];
    for (b, block) in func.blocks.iter().enumerate() {
        for v in block.inst_range.clone() {
            block_of[v as usize] = b as BlockId;
        }
    }
    let weights = super::reg_alloc::block_weights(func);
    let uses = super::reg_alloc::compute_use_counts(func);
    // Where each value is available once the plan stands: its block, or
    // the destination it moves to, with its position there; and whether
    // it moves, its copy then preceding any later one at that position.
    let mut home: Vec<(BlockId, ValueId)> = (0..func.insts.len())
        .map(|v| (block_of[v], v as ValueId))
        .collect();
    let mut moved = vec![false; func.insts.len()];
    // The site whose copy a moved value reads as, for the identity of a
    // later site's operands.
    let mut canon: Vec<ValueId> = (0..func.insts.len() as ValueId).collect();
    let mut keys: Vec<(ValueId, alloc::string::String)> = Vec::new();
    let mut out: Vec<PureHoist> = Vec::new();
    loop {
        let mut grew = false;
        for (b, block) in func.blocks.iter().enumerate() {
            let b = b as BlockId;
            let mut nest: Vec<usize> = (0..loops.len()).filter(|&l| loops[l].contains(b)).collect();
            nest.sort_by_key(|&l| core::cmp::Reverse(loops[l].body.len()));
            if nest.is_empty() {
                continue;
            }
            for v in block.inst_range.clone() {
                let inst = &func.insts[v as usize];
                if moved[v as usize]
                    || uses.get(v as usize).copied().unwrap_or(0) == 0
                    || !invariant_op(inst)
                {
                    continue;
                }
                let mut ops: Vec<ValueId> = Vec::new();
                inst.for_each_operand(|o| ops.push(o));
                let placed = nest.iter().find_map(|&l| {
                    let dest = idom[loops[l].header as usize];
                    if dest == NO_BLOCK || dest == loops[l].header {
                        return None;
                    }
                    let at = insert_point(func, dest)?;
                    // An operand is available ahead of the copy: in a block
                    // dominating the destination, or in the destination
                    // before the insertion point.
                    let ready = ops.iter().all(|&o| {
                        let (ob, oat) = home[o as usize];
                        ob != NO_BLOCK
                            && !loops[l].contains(ob)
                            && dominates(&idom, ob, dest)
                            && (ob != dest || oat < at || (oat == at && moved[o as usize]))
                            && (!moved[o as usize] || oat <= at)
                    });
                    ready.then_some((dest, at))
                });
                if let Some((dest, at)) = placed {
                    home[v as usize] = (dest, at);
                    moved[v as usize] = true;
                    grew = true;
                    let profit = weights[b as usize].saturating_sub(weights[dest as usize]);
                    let mut same = inst.clone();
                    same.for_each_operand_mut(|o| *o = canon[*o as usize]);
                    let key = alloc::format!("{same:?}");
                    match keys.iter().position(|(k_at, k)| *k_at == at && *k == key) {
                        Some(k) => {
                            out[k].sites.push(v);
                            out[k].profit = out[k].profit.saturating_add(profit);
                            canon[v as usize] = out[k].sites[0];
                        }
                        None => {
                            keys.push((at, key));
                            out.push(PureHoist {
                                at,
                                sites: alloc::vec![v],
                                profit,
                            });
                        }
                    }
                }
            }
        }
        if !grew {
            break;
        }
    }
    // The tape takes insertions in position order; one position keeps the
    // order found, where a moved operand precedes its readers.
    out.sort_by_key(|h| h.at);
    out
}

/// Place each pure instruction's copy, reading the copies of moved
/// operands, and point its readers at it.
fn apply_pure(func: &mut FunctionSsa, hoists: &[PureHoist]) -> Undo {
    let n_old = func.insts.len() as ValueId;
    let mut copy_of = vec![NO_VALUE; func.insts.len()];
    let mut ins: Vec<Insertion> = Vec::with_capacity(hoists.len());
    // Every copy's id is known before any is built, as one may read
    // another sorted after it at the same position.
    for (k, h) in hoists.iter().enumerate() {
        for &s in &h.sites {
            copy_of[s as usize] = n_old + k as ValueId;
        }
    }
    for h in hoists {
        let site = h.sites[0];
        let mut inst = func.insts[site as usize].clone();
        inst.for_each_operand_mut(|o| {
            if copy_of[*o as usize] != NO_VALUE {
                *o = copy_of[*o as usize];
            }
        });
        ins.push(Insertion {
            at: At::Before(h.at),
            inst,
            is_f32: func.f32_values.get(site as usize).copied().unwrap_or(false),
            copy_of: Some(site),
        });
    }
    let (rewrite, undo) = super::tape::insert_undoable(func, &ins);
    let mut redirect: Vec<ValueId> = vec![NO_VALUE; func.insts.len()];
    for (k, h) in hoists.iter().enumerate() {
        for &s in &h.sites {
            redirect[rewrite.remap[s as usize] as usize] = rewrite.ids[k];
        }
    }
    // The copies read each other by their new ids already; only the sites'
    // readers move.
    redirect_uses(func, &redirect);
    undo
}

/// Move the pure instructions of [`plan_pure`] when the spill traffic the
/// longer ranges add stays below the instructions removed, as a reload
/// costs no less than the instruction it replaces; `alloc` is `func`'s
/// allocation as it stands.
fn hoist_pure(
    func: &mut FunctionSsa,
    target: Target,
    fixed: FixedRegs,
    alloc: Allocation,
) -> Allocation {
    let hoists = plan_pure(func);
    if hoists.is_empty() {
        return alloc;
    }
    let cost = placement_cost(func, &alloc, target);
    let removed: u64 = hoists.iter().map(|h| h.profit).sum();
    let undo = apply_pure(func, &hoists);
    let alt = super::reg_alloc::allocate(func, target, fixed);
    if placement_cost(func, &alt, target) < cost.saturating_add(removed) {
        return alt;
    }
    undo.restore(func);
    alloc
}

/// Place each load's copy and point its sites at it.
fn apply_loads(func: &mut FunctionSsa, hoists: &[LoadHoist]) -> Undo {
    // A rematerialized address goes just ahead of its load; an operand
    // past the old tape names an insertion.
    let n_old = func.insts.len() as ValueId;
    let mut ins: Vec<Insertion> = Vec::new();
    let mut copy_at: Vec<usize> = Vec::with_capacity(hoists.len());
    for h in hoists {
        let mut inst = h.inst.clone();
        if let (Some(k), Inst::Load { addr, .. }) = (h.remat, &mut inst) {
            ins.push(Insertion {
                at: At::Before(h.at),
                inst: Inst::ImmData(k),
                is_f32: false,
                copy_of: None,
            });
            *addr = n_old + ins.len() as ValueId - 1;
        }
        copy_at.push(ins.len());
        ins.push(Insertion {
            at: At::Before(h.at),
            inst,
            is_f32: h.is_f32,
            copy_of: None,
        });
    }
    let (rewrite, undo) = super::tape::insert_undoable(func, &ins);
    let mut redirect: Vec<ValueId> = vec![NO_VALUE; func.insts.len()];
    for (k, h) in hoists.iter().enumerate() {
        for &site in &h.redirect {
            redirect[rewrite.remap[site as usize] as usize] = rewrite.ids[copy_at[k]];
        }
    }
    redirect_uses(func, &redirect);
    undo
}

/// Point every operand, terminator and `exit_acc` that names a value
/// with a `redirect` entry at that entry.
fn redirect_uses(func: &mut FunctionSsa, redirect: &[ValueId]) {
    let redirect_of = |op: &mut ValueId| {
        if *op != NO_VALUE && (*op as usize) < redirect.len() && redirect[*op as usize] != NO_VALUE
        {
            *op = redirect[*op as usize];
        }
    };
    for inst in func.insts.iter_mut() {
        inst.for_each_operand_mut(redirect_of);
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            redirect_of(&mut block.exit_acc);
        }
        block.terminator.for_each_operand_mut(redirect_of);
    }
}

/// Place each hoist's copy and point its sites at it.
/// [`super::tape::insert`] carries the renumbering the copies force.
fn apply(func: &mut FunctionSsa, hoists: &[Hoist]) -> Undo {
    let ins: Vec<Insertion> = hoists
        .iter()
        .map(|h| Insertion {
            at: At::Before(h.at),
            inst: h.key.inst(),
            is_f32: h.key.is_f32(),
            copy_of: None,
        })
        .collect();
    let (rewrite, undo) = super::tape::insert_undoable(func, &ins);
    let copy_id = &rewrite.ids;
    // The copy inherits the site's binding: a bound `ImmData` /
    // `ImmCode` / `TlsAddr` names a cross-TU symbol's address, which
    // only the table records.
    for (k, h) in hoists.iter().enumerate() {
        let (sym, table) = h.key.binding();
        if sym == NO_SYM {
            continue;
        }
        match table {
            SymTable::Data => func.extern_imm_data_refs.push((copy_id[k], sym)),
            SymTable::Code => func.extern_imm_code_refs.push((copy_id[k], sym)),
            SymTable::Tls => func.extern_tls_refs.push((copy_id[k], sym)),
            SymTable::None => {}
        }
    }
    for table in [
        &mut func.extern_imm_code_refs,
        &mut func.extern_imm_data_refs,
        &mut func.extern_tls_refs,
    ] {
        table.sort_unstable();
    }
    // Rewrite each folded-immediate site to the register form over the
    // copy, reading the already-remapped lhs back off the tape.
    for (k, h) in hoists.iter().enumerate() {
        for &site in &h.unfold {
            let at = rewrite.remap[site as usize] as usize;
            if let Inst::BinopI { op, lhs, .. } = func.insts[at] {
                func.insts[at] = Inst::Binop {
                    op,
                    lhs,
                    rhs: copy_id[k],
                };
            }
        }
    }
    // Point every reader of a hoisted site at the copy. A site's uses
    // are dominated by its definition, which the destination dominates,
    // so each rewritten use -- including a phi operand, which is a use
    // on the predecessor edge -- stays dominated by the copy.
    let mut redirect: Vec<ValueId> = vec![NO_VALUE; func.insts.len()];
    for (k, h) in hoists.iter().enumerate() {
        for &site in &h.redirect {
            redirect[rewrite.remap[site as usize] as usize] = copy_id[k];
        }
    }
    redirect_uses(func, &redirect);
    undo
}

/// Loop-weighted spill traffic plus the prologue's saves and the
/// restores. The traffic metric charges only what a block executes, so
/// it cannot see a hoist that buys its register out of the callee-saved
/// bank -- paid once per call of the function, and invisible to a loop
/// whose body the hoist did shorten. `Allocation::gpr_used` / `fp_used`
/// are exactly what the prologue saves. An x86-64 save is a push and a
/// pop at every exit; an AArch64 one rides a pair the frame stores.
fn placement_cost(func: &FunctionSsa, alloc: &Allocation, target: Target) -> u64 {
    let saved = (alloc.gpr_used.len() + alloc.fp_used.len()) as u64;
    let each = if target.is_x86_64() {
        let exits = (func.blocks.iter())
            .filter(|b| {
                matches!(
                    b.terminator,
                    crate::c5::ir::Terminator::Return(_) | crate::c5::ir::Terminator::TailExt(_)
                )
            })
            .count() as u64;
        1 + exits
    } else {
        2
    };
    super::split_ranges::spill_traffic(func, alloc).saturating_add(each * saved)
}

/// Allocate `func`, then retry with its loop-invariant materializations
/// hoisted out of the loops that hold them. Returns whichever
/// allocation carries the lower [`placement_cost`], leaving `func`
/// matching the returned allocation, and finishes through the
/// live-range split so both retries share one baseline allocation.
pub(crate) fn allocate_hoisted(
    func: &mut FunctionSsa,
    target: Target,
    fixed: FixedRegs,
    data_len: usize,
) -> Allocation {
    let hoists = plan(func, target, fixed);
    // The loads are planned past the materializations, whose copies are
    // what makes an address invariant.
    let early = if hoists.is_empty() {
        plan_loads(func, data_len)
    } else {
        Vec::new()
    };
    if hoists.is_empty() && early.is_empty() {
        if plan_pure(func).is_empty() {
            return super::split_ranges::allocate_split(func, target, fixed);
        }
        let base = super::reg_alloc::allocate(func, target, fixed);
        let picked = hoist_pure(func, target, fixed, base);
        return super::split_ranges::allocate_split_with(func, target, fixed, picked);
    }
    let base = super::reg_alloc::allocate(func, target, fixed);
    let base_cost = placement_cost(func, &base, target);
    // A hoisted materialization removes work from the loop
    // unconditionally; the only way it can lose is by taking a register
    // the function had another use for, which shows up as extra traffic
    // or an extra save. The loads it makes invariant are judged with it:
    // a moved load stops one load per iteration, and a reload the longer
    // ranges add costs one.
    let mat = (!hoists.is_empty()).then(|| {
        let undo = apply(func, &hoists);
        let alt = super::reg_alloc::allocate(func, target, fixed);
        let cost = placement_cost(func, &alt, target);
        (undo, alt, cost)
    });
    let loads = if hoists.is_empty() {
        early
    } else {
        plan_loads(func, data_len)
    };
    let both = (!loads.is_empty()).then(|| {
        let removed: u64 = loads.iter().map(|h| h.profit).sum();
        let undo = apply_loads(func, &loads);
        let alt = super::reg_alloc::allocate(func, target, fixed);
        let cost = placement_cost(func, &alt, target);
        (undo, alt, cost <= base_cost.saturating_add(removed))
    });
    let picked = match (mat, both) {
        (_, Some((_, alt, true))) => alt,
        (mat, both) => {
            if let Some((undo, _, _)) = both {
                undo.restore(func);
            }
            match mat {
                Some((_, alt, cost)) if cost <= base_cost => alt,
                Some((undo, _, _)) => {
                    undo.restore(func);
                    call_free_only(func, target, fixed, &hoists, base_cost).unwrap_or(base)
                }
                None => base,
            }
        }
    };
    let picked = hoist_pure(func, target, fixed, picked);
    super::split_ranges::allocate_split_with(func, target, fixed, picked)
}

/// With the whole plan rejected, the copies for loops without a call: a
/// copy live across a call takes a callee-saved register, whose save can
/// outweigh the plan, while these take none. The allocation when they do
/// not cost more than `base_cost`.
fn call_free_only(
    func: &mut FunctionSsa,
    target: Target,
    fixed: FixedRegs,
    hoists: &[Hoist],
    base_cost: u64,
) -> Option<Allocation> {
    let free: Vec<Hoist> = hoists.iter().filter(|h| h.call_free).cloned().collect();
    if free.is_empty() || free.len() == hoists.len() {
        return None;
    }
    let undo = apply(func, &free);
    let alt = super::reg_alloc::allocate(func, target, fixed);
    if placement_cost(func, &alt, target) <= base_cost {
        return Some(alt);
    }
    undo.restore(func);
    None
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{Block, LoadKind, StoreKind, Terminator};
    use super::*;

    fn plan(func: &FunctionSsa, target: Target) -> Vec<Hoist> {
        super::plan(func, target, FixedRegs::NONE)
    }

    fn allocate_hoisted(func: &mut FunctionSsa, target: Target) -> Allocation {
        super::allocate_hoisted(func, target, FixedRegs::NONE, 0)
    }

    /// Tape index of the first body instruction in [`loop_func`].
    const BODY: u32 = 4;
    /// Insertion point [`insert_point`] picks in the default preheader.
    const PRE_AT: ValueId = 2;

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            inst_src: vec![crate::c5::ir::InstSrc::default(); n],
            f32_values: vec![false; n],
            insts,
            blocks,
            ..Default::default()
        }
    }

    fn block(range: core::ops::Range<u32>, terminator: Terminator) -> Block {
        Block {
            start_pc: 0,
            inst_range: range,
            terminator,
            exit_acc: NO_VALUE,
        }
    }

    fn local(off: i64) -> Inst {
        Inst::LoadLocal {
            disp: 0,
            off,
            kind: LoadKind::I64,
            volatile: false,
        }
    }

    fn load(addr: ValueId) -> Inst {
        Inst::Load {
            addr,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
            pc_rel: false,
        }
    }

    /// A store keeps a body value read, so nothing under test is dead.
    fn sink(value: ValueId) -> Inst {
        Inst::StoreLocal {
            disp: 0,
            off: -1,
            value,
            kind: StoreKind::I64,
            volatile: false,
            nsw: false,
        }
    }

    /// `pre -> header -> body -> header`. Block 0 is the preheader and
    /// the only block outside the loop; the body starts at [`BODY`].
    fn loop_func_pre(pre: Vec<Inst>, body: Vec<Inst>) -> FunctionSsa {
        let head = pre.len() as u32;
        let mut insts = pre;
        insts.push(Inst::BinopI {
            op: BinOp::Lt,
            lhs: 0,
            rhs_imm: 7,
        });
        let body_start = insts.len() as u32;
        insts.extend(body);
        let body_end = insts.len() as u32;
        func_with(
            insts,
            vec![
                block(0..head, Terminator::Jmp(1)),
                block(
                    head..body_start,
                    Terminator::Bz {
                        cond: head,
                        target: 2,
                        fall_through: 2,
                    },
                ),
                block(body_start..body_end, Terminator::Jmp(1)),
            ],
        )
    }

    fn loop_func(body: Vec<Inst>) -> FunctionSsa {
        loop_func_pre(vec![local(2), local(3), local(4)], body)
    }

    #[test]
    fn invariant_global_address_hoists_to_the_preheader() {
        let mut f = loop_func(vec![Inst::ImmData(0x38), load(BODY), sink(BODY + 1)]);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        assert_eq!(hoists[0].key, Key::Data(0x38, NO_SYM));
        assert_eq!(hoists[0].redirect, vec![BODY]);
        assert_eq!(hoists[0].at, PRE_AT);
        apply(&mut f, &hoists);
        let copy = f.blocks[0]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::ImmData(0x38)))
            .expect("copy in the preheader");
        let loaded = f.blocks[2]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::Load { .. }))
            .expect("load in the body");
        assert!(matches!(f.insts[loaded as usize], Inst::Load { addr, .. } if addr == copy));
    }

    #[test]
    fn a_loop_varying_address_is_not_hoisted() {
        // `base + i` rebuilt from a loop-carried value: an operand makes
        // the address vary, so no part of it is invariant by opcode.
        let mut f = loop_func(vec![
            Inst::Binop {
                op: BinOp::Add,
                lhs: 0,
                rhs: 1,
            },
            load(BODY),
            sink(BODY + 1),
        ]);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert!(hoists.is_empty());
        let before = f.insts.len();
        apply(&mut f, &hoists);
        assert_eq!(f.insts.len(), before);
    }

    #[test]
    fn a_volatile_access_is_left_alone() {
        // The address feeding a volatile access is invariant and hoists;
        // the access itself is neither moved nor duplicated, so it is
        // still performed exactly once per iteration (C99 6.7.3p6).
        let mut f = loop_func(vec![
            Inst::ImmData(0x40),
            Inst::Load {
                addr: BODY,
                disp: 0,
                kind: LoadKind::I64,
                volatile: true,
                align: 0,
                pc_rel: false,
            },
            sink(BODY + 1),
        ]);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        apply(&mut f, &hoists);
        let volatile_loads = f
            .blocks
            .iter()
            .flat_map(|b| b.inst_range.clone())
            .filter(|&v| matches!(f.insts[v as usize], Inst::Load { volatile: true, .. }))
            .count();
        assert_eq!(volatile_loads, 1);
        let pre = f.blocks[0].inst_range.clone();
        assert!(f.blocks[2].inst_range.clone().any(|v| matches!(
            f.insts[v as usize],
            Inst::Load { volatile: true, addr, .. } if pre.contains(&addr)
        )));
    }

    #[test]
    fn two_sites_of_one_address_share_a_copy() {
        let mut f = loop_func(vec![
            Inst::ImmData(0x10),
            load(BODY),
            Inst::ImmData(0x10),
            load(BODY + 2),
            Inst::Binop {
                op: BinOp::Add,
                lhs: BODY + 1,
                rhs: BODY + 3,
            },
            sink(BODY + 4),
        ]);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        assert_eq!(hoists[0].redirect, vec![BODY, BODY + 2]);
        apply(&mut f, &hoists);
        let body = f.blocks[2].inst_range.clone();
        let from_preheader = body
            .clone()
            .filter(
                |&v| matches!(f.insts[v as usize], Inst::Load { addr, .. } if addr < body.start),
            )
            .count();
        assert_eq!(from_preheader, 2);
    }

    #[test]
    fn a_wide_constant_hoists_and_a_narrow_one_does_not() {
        let wide = loop_func(vec![Inst::Imm(0x6666_6667), sink(BODY)]);
        assert_eq!(plan(&wide, Target::LinuxAarch64).len(), 1);
        // One movz builds it, so a register held across the loop buys
        // nothing.
        let narrow = loop_func(vec![Inst::Imm(10), sink(BODY)]);
        assert!(plan(&narrow, Target::LinuxAarch64).is_empty());
        // Nor does a `movn` or an `orr` from the zero register.
        for k in [-2, 0x0f0f_0f0f_0f0f_0f0f] {
            let one = loop_func(vec![Inst::Imm(k), sink(BODY)]);
            assert!(plan(&one, Target::LinuxAarch64).is_empty(), "{k:#x}");
        }
        // x86-64 builds either in one instruction.
        assert!(plan(&wide, Target::LinuxX64).is_empty());
    }

    /// An f32 constant and an integer one with the same bits are
    /// different values: the flag decides the width an FP reader
    /// transfers the constant at, so it keys the copy and rides it.
    #[test]
    fn an_f32_constant_keeps_its_flag_on_the_copy() {
        let mut f = loop_func(vec![
            Inst::Imm(0x4048_f5c3),
            sink(BODY),
            Inst::Imm(0x4048_f5c3),
            sink(BODY + 2),
        ]);
        f.f32_values[BODY as usize] = true;
        let hoists = plan(&f, Target::LinuxAarch64);
        // One destination takes at most its register share, so the count
        // this observes distinctness through is bounded by that share.
        let cap =
            (super::super::reg_alloc::usable_gpr_count(Target::LinuxAarch64, FixedRegs::NONE) / 2)
                .max(1);
        assert_eq!(hoists.len(), 2.min(cap));
        assert_eq!(hoists[0].key, Key::Imm(0x4048_f5c3, false));
        if cap >= 2 {
            assert_eq!(hoists[1].key, Key::Imm(0x4048_f5c3, true));
        }
        apply(&mut f, &hoists);
        assert!(!f.f32_values[PRE_AT as usize]);
        if cap >= 2 {
            assert!(f.f32_values[PRE_AT as usize + 1]);
        }
    }

    #[test]
    fn a_folded_immediate_the_target_materializes_unfolds_over_a_copy() {
        let body = vec![
            Inst::BinopI {
                op: BinOp::Mul,
                lhs: 0,
                rhs_imm: 0x6666_6667,
            },
            sink(BODY),
        ];
        let mut f = loop_func(body.clone());
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        assert_eq!(hoists[0].key, Key::Imm(0x6666_6667, false));
        assert_eq!(hoists[0].unfold, vec![BODY]);
        apply(&mut f, &hoists);
        let copy = f.blocks[0]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::Imm(0x6666_6667)))
            .expect("copy in the preheader");
        assert!(f.blocks[2].inst_range.clone().any(|v| matches!(
            f.insts[v as usize],
            Inst::Binop { op: BinOp::Mul, rhs, .. } if rhs == copy
        )));
        // x86-64 encodes the same multiply as `imul r, r, imm32`.
        assert!(plan(&loop_func(body), Target::LinuxX64).is_empty());
    }

    #[test]
    fn a_multiply_by_a_small_constant_unfolds_only_where_it_costs() {
        // AArch64 `mul` has no immediate form, so any non-power-of-two
        // multiplier is built into a register at the site.
        let f = loop_func(vec![
            Inst::BinopI {
                op: BinOp::Mul,
                lhs: 0,
                rhs_imm: 10,
            },
            sink(BODY),
        ]);
        assert_eq!(plan(&f, Target::LinuxAarch64).len(), 1);
        assert!(plan(&f, Target::LinuxX64).is_empty());
        // A power of two is a shift on both.
        let shifted = loop_func(vec![
            Inst::BinopI {
                op: BinOp::Mul,
                lhs: 0,
                rhs_imm: 8,
            },
            sink(BODY),
        ]);
        assert!(plan(&shifted, Target::LinuxAarch64).is_empty());
        assert!(plan(&shifted, Target::LinuxX64).is_empty());
    }

    #[test]
    fn a_shift_count_stays_folded() {
        // `x >> 34` rides the instruction's own immediate field on both
        // targets, so the site builds nothing.
        let f = loop_func(vec![
            Inst::BinopI {
                op: BinOp::Shr,
                lhs: 0,
                rhs_imm: 34,
            },
            sink(BODY),
        ]);
        assert!(plan(&f, Target::LinuxAarch64).is_empty());
        assert!(plan(&f, Target::LinuxX64).is_empty());
    }

    #[test]
    fn a_bitmask_immediate_stays_folded() {
        // A bitmask immediate stays in the instruction; the 32-bit form of a
        // low-word mask clears the high word, so a reader of that word keeps the copy.
        let f = loop_func(vec![
            Inst::BinopI {
                op: BinOp::And,
                lhs: 0,
                rhs_imm: 0xff,
            },
            sink(BODY),
        ]);
        assert!(plan(&f, Target::LinuxAarch64).is_empty());
        let xor = |kind| {
            loop_func(vec![
                Inst::BinopI {
                    op: BinOp::Xor,
                    lhs: 0,
                    rhs_imm: 0x5555_5555,
                },
                Inst::StoreLocal {
                    disp: 0,
                    off: -1,
                    value: BODY,
                    kind,
                    volatile: false,
                    nsw: false,
                },
            ])
        };
        assert_eq!(plan(&xor(StoreKind::I64), Target::LinuxAarch64).len(), 1);
        assert!(plan(&xor(StoreKind::I32), Target::LinuxAarch64).is_empty());
    }

    #[test]
    fn a_materialization_outside_every_loop_stays_put() {
        let f = loop_func_pre(
            vec![local(2), local(3), Inst::ImmData(0x8)],
            vec![load(2), sink(BODY)],
        );
        assert!(plan(&f, Target::LinuxAarch64).is_empty());
    }

    #[test]
    fn the_dead_original_keeps_no_reader() {
        let mut f = loop_func(vec![Inst::ImmData(0x20), load(BODY), sink(BODY + 1)]);
        let hoists = plan(&f, Target::LinuxAarch64);
        apply(&mut f, &hoists);
        let uses = super::super::reg_alloc::compute_use_counts(&f);
        let site = f.blocks[2]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::ImmData(0x20)))
            .expect("the original stays on the tape");
        assert_eq!(uses[site as usize], 0);
    }

    #[test]
    fn a_rejected_plan_restores_the_tape() {
        let mut f = loop_func(vec![Inst::ImmData(0x20), load(BODY), sink(BODY + 1)]);
        let before = f.clone();
        let hoists = plan(&f, Target::LinuxAarch64);
        let undo = apply(&mut f, &hoists);
        assert_ne!(f.insts.len(), before.insts.len());
        undo.restore(&mut f);
        assert_eq!(f.insts.len(), before.insts.len());
        assert_eq!(f.blocks[2].inst_range, before.blocks[2].inst_range);
        assert!(matches!(f.blocks[0].terminator, Terminator::Jmp(1)));
    }

    #[test]
    fn a_bound_symbol_rides_the_copy() {
        let mut f = loop_func(vec![Inst::ImmData(0), load(BODY), sink(BODY + 1)]);
        f.extern_imm_data_refs.push((BODY, 9));
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 1);
        assert_eq!(hoists[0].key, Key::Data(0, 9));
        apply(&mut f, &hoists);
        let copy = f.blocks[0]
            .inst_range
            .clone()
            .find(|&v| matches!(f.insts[v as usize], Inst::ImmData(0)))
            .expect("copy in the preheader");
        assert!(f.extern_imm_data_refs.contains(&(copy, 9)));
    }

    #[test]
    fn two_symbols_at_one_offset_stay_apart() {
        let mut f = loop_func(vec![
            Inst::ImmData(0),
            load(BODY),
            Inst::ImmData(0),
            load(BODY + 2),
            Inst::Binop {
                op: BinOp::Add,
                lhs: BODY + 1,
                rhs: BODY + 3,
            },
            sink(BODY + 4),
        ]);
        f.extern_imm_data_refs.push((BODY, 9));
        f.extern_imm_data_refs.push((BODY + 2, 11));
        let cap =
            (super::super::reg_alloc::usable_gpr_count(Target::LinuxAarch64, FixedRegs::NONE) / 2)
                .max(1);
        let hoists = plan(&f, Target::LinuxAarch64);
        assert_eq!(hoists.len(), 2.min(cap));
        if cap >= 2 {
            assert_ne!(hoists[0].key, hoists[1].key);
        }
    }

    #[test]
    fn the_copy_clears_the_incoming_argument_reads() {
        let body = vec![Inst::ImmData(0x20), load(BODY), sink(BODY + 1)];
        let param = Inst::ParamRef {
            idx: 0,
            kind: LoadKind::I64,
        };
        let f = loop_func_pre(vec![param.clone(), local(3), local(4)], body.clone());
        assert_eq!(plan(&f, Target::LinuxAarch64)[0].at, PRE_AT);
        // Nothing may precede a parameter read, so a destination that
        // ends in one offers no position and the sites stay where they are.
        let part = Inst::ParamPart {
            idx: 0,
            part: 0,
            kind: LoadKind::I64,
        };
        for read in [param, part] {
            let trailing = loop_func_pre(vec![local(2), local(3), read], body.clone());
            assert!(plan(&trailing, Target::LinuxAarch64).is_empty());
        }
    }

    #[test]
    fn the_copy_stays_ahead_of_a_fusable_compare() {
        // The destination's compare feeds its conditional terminator;
        // nothing may land between the two.
        let mut f = loop_func(vec![Inst::ImmData(0x20), load(BODY), sink(BODY + 1)]);
        f.insts[1] = Inst::BinopI {
            op: BinOp::Lt,
            lhs: 0,
            rhs_imm: 1,
        };
        f.blocks[0].terminator = Terminator::Bz {
            cond: 1,
            target: 1,
            fall_through: 1,
        };
        assert_eq!(plan(&f, Target::LinuxAarch64)[0].at, 1);
    }

    #[test]
    fn one_destination_takes_no_more_than_the_register_share() {
        let cap =
            (super::super::reg_alloc::usable_gpr_count(Target::LinuxAarch64, FixedRegs::NONE) / 2)
                .max(1);
        // Each load feeds a running sum, so no materialization is dead.
        let mut body: Vec<Inst> = Vec::new();
        let (mut idx, mut acc) = (BODY, NO_VALUE);
        for i in 0..(cap + 4) {
            body.push(Inst::ImmData(0x100 + i as i64 * 8));
            body.push(load(idx));
            let loaded = idx + 1;
            idx += 2;
            acc = if acc == NO_VALUE {
                loaded
            } else {
                body.push(Inst::Binop {
                    op: BinOp::Add,
                    lhs: acc,
                    rhs: loaded,
                });
                idx += 1;
                idx - 1
            };
        }
        body.push(sink(acc));
        assert_eq!(plan(&loop_func(body), Target::LinuxAarch64).len(), cap);
    }

    #[test]
    fn a_function_that_can_return_twice_is_left_alone() {
        let mut f = loop_func(vec![Inst::ImmData(0x38), load(BODY), sink(BODY + 1)]);
        assert_eq!(plan(&f, Target::LinuxAarch64).len(), 1);
        f.has_returns_twice_call = true;
        assert!(plan(&f, Target::LinuxAarch64).is_empty());
    }

    #[test]
    fn a_hoist_that_would_buy_a_callee_saved_register_is_dropped() {
        // The body calls, so a value held across it lands in the
        // callee-saved bank and the prologue grows by a save / restore
        // pair the loop never repays.
        let mut f = loop_func(vec![
            Inst::ImmData(0x38),
            load(BODY),
            Inst::CallExt {
                binding_idx: 0,
                args: vec![BODY + 1],
                fp_arg_mask: crate::c5::ir::FpMask::EMPTY,
                low_word_args: 0,
                arg_widths: crate::c5::ir::ArgWidths::default(),
                fp_return: false,
                arg_aggs: Vec::new(),
                ret_agg: None,
                ret_slot_local: 0,
            },
            sink(BODY + 2),
        ]);
        assert_eq!(plan(&f, Target::LinuxAarch64).len(), 1);
        allocate_hoisted(&mut f, Target::LinuxAarch64);
        let pre = f.blocks[0].inst_range.clone();
        assert!(
            !pre.clone()
                .any(|v| matches!(f.insts[v as usize], Inst::ImmData(0x38)))
        );
    }

    #[test]
    fn the_placement_gate_leaves_a_consistent_function() {
        let mut f = loop_func(vec![Inst::ImmData(0x38), load(BODY), sink(BODY + 1)]);
        let alloc = allocate_hoisted(&mut f, Target::LinuxAarch64);
        assert_eq!(alloc.places.len(), f.insts.len());
        for b in &f.blocks {
            assert!(b.inst_range.end as usize <= f.insts.len());
        }
    }

    /// `pre -> header -> body -> header`, `header -> exit`: the body reads
    /// `read` and adds it to a sum the header carries, so the read is
    /// live and the body writes nothing unless `extra` does.
    /// `pre` holds `ImmData(0x38)` at 0 and `Imm(0)` at 1.
    fn sum_loop(read: Inst, extra: Vec<Inst>) -> FunctionSsa {
        let mut insts = vec![Inst::ImmData(0x38), Inst::Imm(0)];
        // Header: the sum's phi and the trip test.
        let body = 4 + extra.len() as u32;
        insts.push(Inst::Phi {
            incoming: vec![(0, 1), (2, body + 1)],
            kind: LoadKind::I64,
        });
        insts.push(Inst::BinopI {
            op: BinOp::Lt,
            lhs: 2,
            rhs_imm: 7,
        });
        insts.extend(extra);
        insts.push(read);
        insts.push(Inst::Binop {
            op: BinOp::Add,
            lhs: 2,
            rhs: body,
        });
        let n = insts.len() as u32;
        func_with(
            insts,
            vec![
                block(0..2, Terminator::Jmp(1)),
                block(
                    2..4,
                    Terminator::Bz {
                        cond: 3,
                        target: 3,
                        fall_through: 2,
                    },
                ),
                block(4..n, Terminator::Jmp(1)),
                block(n..n, Terminator::Return(2)),
            ],
        )
    }

    fn load_at(disp: i32) -> Inst {
        Inst::Load {
            addr: 0,
            disp,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
            pc_rel: false,
        }
    }

    /// A load of the data image in a loop that writes nothing moves to the
    /// preheader, and the sum reads the copy.
    #[test]
    fn a_data_load_in_a_loop_that_writes_nothing_moves_out() {
        let mut f = sum_loop(load_at(8), vec![]);
        let loads = plan_loads(&f, 0x48);
        assert_eq!(loads.len(), 1);
        assert_eq!(loads[0].redirect, vec![4]);
        apply_loads(&mut f, &loads);
        let copy = (f.blocks[0].inst_range.clone())
            .find(|&v| matches!(f.insts[v as usize], Inst::Load { .. }))
            .expect("copy in the preheader");
        let add = f.blocks[2].inst_range.end - 1;
        assert!(matches!(f.insts[add as usize], Inst::Binop { rhs, .. } if rhs == copy));
    }

    /// A frame slot's load moves the same way.
    #[test]
    fn a_frame_slot_load_moves_out() {
        let f = sum_loop(local(-2), vec![]);
        assert_eq!(plan_loads(&f, 0).len(), 1);
    }

    /// The copy runs even when the loop runs no iteration, so a load that
    /// could fault stays: one past the data image, of an address another
    /// unit's symbol gives, or a volatile one; and one the loop's own
    /// store may change stays too.
    #[test]
    fn a_load_that_could_fault_or_change_stays() {
        assert!(plan_loads(&sum_loop(load_at(8), vec![]), 0x40 + 8 - 1).is_empty());
        let mut bound = sum_loop(load_at(8), vec![]);
        bound.extern_imm_data_refs.push((0, 3));
        assert!(plan_loads(&bound, 0x48).is_empty());
        let volatile = Inst::Load {
            addr: 0,
            disp: 8,
            kind: LoadKind::I64,
            volatile: true,
            align: 0,
            pc_rel: false,
        };
        assert!(plan_loads(&sum_loop(volatile, vec![]), 0x48).is_empty());
        let store = Inst::Store {
            addr: 0,
            disp: 16,
            value: 1,
            kind: StoreKind::I64,
            volatile: false,
            align: 0,
            pc_rel: false,
        };
        assert!(plan_loads(&sum_loop(load_at(8), vec![store]), 0x48).is_empty());
    }

    fn mul(lhs: ValueId, rhs: ValueId) -> Inst {
        Inst::Binop {
            op: BinOp::Mul,
            lhs,
            rhs,
        }
    }

    /// Integer arithmetic over values defined before a loop moves out of
    /// it, a chain over a moved value with it, and equal sites share one
    /// copy.
    #[test]
    fn invariant_arithmetic_moves_before_the_loop() {
        let add = |lhs, rhs| Inst::Binop {
            op: BinOp::Add,
            lhs,
            rhs,
        };
        let plus3 = Inst::BinopI {
            op: BinOp::Add,
            lhs: BODY,
            rhs_imm: 3,
        };
        let mut f = loop_func(vec![
            mul(0, 1),
            plus3,
            mul(0, 1),
            add(BODY + 1, BODY + 2),
            sink(BODY + 3),
        ]);
        let hoists = plan_pure(&f);
        let sites: Vec<Vec<ValueId>> = hoists.iter().map(|h| h.sites.clone()).collect();
        assert_eq!(
            sites,
            vec![vec![BODY, BODY + 2], vec![BODY + 1], vec![BODY + 3]]
        );
        apply_pure(&mut f, &hoists);
        let at = f.blocks[2].inst_range.end - 1;
        let Inst::StoreLocal { value, .. } = f.insts[at as usize] else {
            panic!("{:?}", f.insts[at as usize]);
        };
        assert!(
            f.blocks[0].inst_range.contains(&value),
            "the sink reads a copy"
        );
    }

    /// The copy runs even when the loop runs no iteration, so what can trap
    /// stays -- a division by a register, by zero or by -1 -- while one by
    /// another constant moves; a comparison stays with the branch it fuses
    /// into, and arithmetic over a value the loop defines stays.
    #[test]
    fn trapping_varying_and_compare_arithmetic_stays() {
        let div_by = |rhs_imm| Inst::BinopI {
            op: BinOp::Div,
            lhs: 0,
            rhs_imm,
        };
        for body in [
            vec![
                Inst::Binop {
                    op: BinOp::Div,
                    lhs: 0,
                    rhs: 1,
                },
                sink(BODY),
            ],
            vec![div_by(-1), sink(BODY)],
            vec![div_by(0), sink(BODY)],
            vec![
                Inst::Binop {
                    op: BinOp::Lt,
                    lhs: 0,
                    rhs: 1,
                },
                sink(BODY),
            ],
            vec![local(5), mul(BODY, 1), sink(BODY + 1)],
        ] {
            assert!(plan_pure(&loop_func(body.clone())).is_empty(), "{body:?}");
        }
        assert_eq!(plan_pure(&loop_func(vec![div_by(3), sink(BODY)])).len(), 1);
    }
}
