//! Placing and moving instructions in a function's instruction tape.
//!
//! An insertion or a move shifts the value id of other instructions, and
//! [`FunctionSsa`] keys several tables by value id: the tables parallel
//! to `insts`, and the cross-TU relocation lists. One left behind names
//! the wrong instructions, and nothing downstream can tell -- the ids
//! are still in range. The rewrite therefore lives here once, and the
//! destructure in [`keyed`] names every field of the struct, so a table
//! added later does not compile until it is classified.

use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{Block, BlockId, FunctionSsa, Inst, NO_VALUE, ValueId};

/// The parts of a [`FunctionSsa`] keyed by value id.
struct Keyed<'a> {
    insts: &'a mut Vec<Inst>,
    inst_src: &'a mut Vec<(u32, u32)>,
    f32_values: &'a mut Vec<bool>,
    cmp32: &'a mut Vec<bool>,
    blocks: &'a mut Vec<Block>,
    extern_call_refs: &'a mut Vec<(u32, u32)>,
    extern_imm_code_refs: &'a mut Vec<(u32, u32)>,
    extern_imm_data_refs: &'a mut Vec<(u32, u32)>,
    extern_tls_refs: &'a mut Vec<(u32, u32)>,
}

fn keyed(func: &mut FunctionSsa) -> Keyed<'_> {
    let FunctionSsa {
        name: _,
        ent_pc: _,
        end_pc: _,
        locals: _,
        ssp: _,
        n_params: _,
        is_variadic: _,
        is_inline: _,
        is_always_inline: _,
        is_noinline: _,
        is_naked: _,
        conv: _,
        is_weak: _,
        is_internal: _,
        section: _,
        patchable_entry: _,
        no_instrument: _,
        const_params: _,
        insts,
        inst_src,
        blocks,
        extern_call_refs,
        extern_imm_code_refs,
        extern_imm_data_refs,
        extern_tls_refs,
        f32_values,
        cmp32,
        param_fp_mask: _,
        agg_descs: _,
        param_aggs: _,
        param_local_slots: _,
        ret_agg: _,
        ret_is_fp: _,
        ret_type_tag: _,
        indirect_result_slot: _,
        computed_goto_targets: _,
        label_data_relocs: _,
        jump_tables: _,
        synthetic_base: _,
        multi_cell_slots: _,
        array_slots: _,
        over_aligned: _,
        frame_align: _,
        realign_region_bytes: _,
        has_returns_twice_call: _,
        did_unroll: _,
        did_inline: _,
    } = func;
    Keyed {
        insts,
        inst_src,
        f32_values,
        cmp32,
        blocks,
        extern_call_refs,
        extern_imm_code_refs,
        extern_imm_data_refs,
        extern_tls_refs,
    }
}

/// Rewrite every recorded value id through `remap`, indexed by the old
/// id. The tape and its parallel tables are already in the new order.
fn renumber(k: &mut Keyed<'_>, remap: &[ValueId]) {
    let map = |op: &mut ValueId| {
        if *op != NO_VALUE && (*op as usize) < remap.len() {
            *op = remap[*op as usize];
        }
    };
    for inst in k.insts.iter_mut() {
        inst.for_each_operand_mut(map);
    }
    for block in k.blocks.iter_mut() {
        map(&mut block.exit_acc);
        block.terminator.for_each_operand_mut(map);
    }
    rekey(k, remap);
}

/// Carry the relocation tables across a tape rebuild done elsewhere. An
/// instruction the rebuild dropped maps to `NO_VALUE` and loses its entries.
pub(crate) fn rekey_refs(func: &mut FunctionSsa, remap: &[ValueId]) {
    rekey(&mut keyed(func), remap);
}

fn rekey(k: &mut Keyed<'_>, remap: &[ValueId]) {
    for table in [
        &mut *k.extern_call_refs,
        &mut *k.extern_imm_code_refs,
        &mut *k.extern_imm_data_refs,
        &mut *k.extern_tls_refs,
    ] {
        table.retain_mut(|(v, _)| {
            *v = remap.get(*v as usize).copied().unwrap_or(NO_VALUE);
            *v != NO_VALUE
        });
    }
}

/// One instruction to place ahead of tape index `at`, which must name an
/// instruction inside a block. Operands are old value ids: [`insert`]
/// maps them with the rest.
pub(crate) struct Insertion {
    pub at: ValueId,
    pub inst: Inst,
    /// `FunctionSsa::f32_values` entry for the inserted value.
    pub is_f32: bool,
}

/// Old-to-new value ids, and the id each insertion received.
pub(crate) struct Rewrite {
    pub remap: Vec<ValueId>,
    pub ids: Vec<ValueId>,
}

/// The parts of a [`FunctionSsa`] an insertion replaces, kept so a plan
/// that does not pay for itself can be undone exactly.
pub(crate) struct Undo {
    insts: Vec<Inst>,
    inst_src: Vec<(u32, u32)>,
    f32_values: Vec<bool>,
    cmp32: Vec<bool>,
    blocks: Vec<Block>,
    extern_call_refs: Vec<(u32, u32)>,
    extern_imm_code_refs: Vec<(u32, u32)>,
    extern_imm_data_refs: Vec<(u32, u32)>,
    extern_tls_refs: Vec<(u32, u32)>,
}

impl Undo {
    pub(crate) fn restore(self, func: &mut FunctionSsa) {
        func.insts = self.insts;
        func.inst_src = self.inst_src;
        func.f32_values = self.f32_values;
        func.cmp32 = self.cmp32;
        func.blocks = self.blocks;
        func.extern_call_refs = self.extern_call_refs;
        func.extern_imm_code_refs = self.extern_imm_code_refs;
        func.extern_imm_data_refs = self.extern_imm_data_refs;
        func.extern_tls_refs = self.extern_tls_refs;
    }
}

/// Place `ins` -- ascending by `at` -- into the tape and move everything
/// keyed by value id with it: the parallel tables, every block range,
/// every operand, terminator and `exit_acc`, and the relocation tables.
/// An inserted value takes the source position of the instruction it
/// goes ahead of.
pub(crate) fn insert(func: &mut FunctionSsa, ins: &[Insertion]) -> (Rewrite, Undo) {
    let mut k = keyed(func);
    let Keyed {
        insts,
        inst_src,
        f32_values,
        cmp32,
        blocks,
        extern_call_refs,
        extern_imm_code_refs,
        extern_imm_data_refs,
        extern_tls_refs,
    } = &mut k;
    let n_old = insts.len();
    debug_assert!(ins.windows(2).all(|w| w[0].at <= w[1].at));
    debug_assert!(ins.iter().all(|i| (i.at as usize) < n_old));
    let undo = Undo {
        insts: Vec::new(),
        inst_src: Vec::new(),
        f32_values: Vec::new(),
        cmp32: Vec::new(),
        blocks: blocks.clone(),
        extern_call_refs: extern_call_refs.clone(),
        extern_imm_code_refs: extern_imm_code_refs.clone(),
        extern_imm_data_refs: extern_imm_data_refs.clone(),
        extern_tls_refs: extern_tls_refs.clone(),
    };
    // Insertions land strictly before their index, so a block's new
    // bounds follow from its old ones. Index `n_old` closes the last
    // block's range. The tape order is otherwise preserved: instructions
    // covered by no block keep their slots, and blocks stay laid out as
    // the pipeline left them.
    let mut before: Vec<u32> = vec![0; n_old + 1];
    for i in ins {
        before[i.at as usize + 1] += 1;
    }
    for old in 0..n_old {
        before[old + 1] += before[old];
    }
    let mut new_insts: Vec<Inst> = Vec::with_capacity(n_old + ins.len());
    let mut new_src: Vec<(u32, u32)> = Vec::with_capacity(n_old + ins.len());
    let mut new_f32: Vec<bool> = Vec::with_capacity(n_old + ins.len());
    // An inserted value is a copy or a materialization, never a
    // comparison, so it carries no narrow-compare mark.
    let mut new_cmp: Vec<bool> = Vec::with_capacity(n_old + ins.len());
    let mut remap: Vec<ValueId> = vec![NO_VALUE; n_old];
    let mut ids: Vec<ValueId> = vec![NO_VALUE; ins.len()];
    let mut cur = 0usize;
    for (old, slot) in remap.iter_mut().enumerate() {
        let src = inst_src.get(old).copied().unwrap_or((0, 0));
        while cur < ins.len() && ins[cur].at as usize == old {
            ids[cur] = new_insts.len() as ValueId;
            new_insts.push(ins[cur].inst.clone());
            new_src.push(src);
            new_f32.push(ins[cur].is_f32);
            new_cmp.push(false);
            cur += 1;
        }
        *slot = new_insts.len() as ValueId;
        new_insts.push(insts[old].clone());
        new_src.push(src);
        new_f32.push(f32_values.get(old).copied().unwrap_or(false));
        new_cmp.push(cmp32.get(old).copied().unwrap_or(false));
    }
    for block in blocks.iter_mut() {
        let (s, e) = (block.inst_range.start, block.inst_range.end);
        block.inst_range = (s + before[s as usize])..(e + before[e as usize]);
    }
    let undo = Undo {
        insts: core::mem::replace(*insts, new_insts),
        inst_src: core::mem::replace(*inst_src, new_src),
        f32_values: core::mem::replace(*f32_values, new_f32),
        cmp32: core::mem::replace(*cmp32, new_cmp),
        ..undo
    };
    renumber(&mut k, &remap);
    (Rewrite { remap, ids }, undo)
}

/// Give the first block of each chain the instructions of the whole
/// chain, in chain order, and leave the other members empty. The chains
/// share no block. A chain's first non-empty member keeps its place and
/// the later ones move behind it; the rest of the tape keeps its order.
pub(crate) fn concat(func: &mut FunctionSsa, chains: &[Vec<BlockId>]) {
    let mut k = keyed(func);
    let n = k.insts.len();
    let old: Vec<core::ops::Range<u32>> = k.blocks.iter().map(|b| b.inst_range.clone()).collect();
    debug_assert!(ranges_are_disjoint(&old));
    const NONE: u32 = u32::MAX;
    let mut moved = vec![false; n];
    // The chain whose later members go behind this tape index.
    let mut tail_of = vec![NONE; n];
    for (c, chain) in chains.iter().enumerate() {
        let mut full = chain
            .iter()
            .map(|&b| &old[b as usize])
            .filter(|r| !r.is_empty());
        let Some(base) = full.next() else {
            continue;
        };
        tail_of[base.end as usize - 1] = c as u32;
        for r in full {
            moved[r.start as usize..r.end as usize].fill(true);
        }
    }
    let mut order: Vec<ValueId> = Vec::with_capacity(n);
    for at in 0..n {
        if moved[at] {
            continue;
        }
        order.push(at as ValueId);
        if tail_of[at] == NONE {
            continue;
        }
        for &b in &chains[tail_of[at] as usize] {
            let r = &old[b as usize];
            if !r.is_empty() && moved[r.start as usize] {
                order.extend(r.clone());
            }
        }
    }
    debug_assert_eq!(order.len(), n);
    let mut remap: Vec<ValueId> = vec![NO_VALUE; n];
    for (new, &at) in order.iter().enumerate() {
        remap[at as usize] = new as ValueId;
    }
    // A range moves with its first instruction.
    let moved_to = |r: &core::ops::Range<u32>| {
        let start = remap.get(r.start as usize).copied().unwrap_or(n as u32);
        start..start + (r.end - r.start)
    };
    for (block, r) in k.blocks.iter_mut().zip(&old) {
        block.inst_range = moved_to(r);
    }
    for chain in chains {
        let len: u32 = chain
            .iter()
            .map(|&b| old[b as usize].end - old[b as usize].start)
            .sum();
        let start = chain
            .iter()
            .map(|&b| &old[b as usize])
            .find(|r| !r.is_empty())
            .map_or(k.blocks[chain[0] as usize].inst_range.start, |r| {
                moved_to(r).start
            });
        for &b in &chain[1..] {
            k.blocks[b as usize].inst_range = start + len..start + len;
        }
        k.blocks[chain[0] as usize].inst_range = start..start + len;
    }
    if order
        .iter()
        .enumerate()
        .all(|(new, &at)| new == at as usize)
    {
        return;
    }
    let mut from = core::mem::take(k.insts);
    *k.insts = order
        .iter()
        .map(|&at| core::mem::replace(&mut from[at as usize], Inst::Imm(0)))
        .collect();
    permute(k.inst_src, &order);
    permute(k.f32_values, &order);
    permute(k.cmp32, &order);
    renumber(&mut k, &remap);
}

/// Reorder a table parallel to the tape; an empty one stays empty.
fn permute<T: Copy + Default>(table: &mut Vec<T>, order: &[ValueId]) {
    if !table.is_empty() {
        *table = order
            .iter()
            .map(|&at| table.get(at as usize).copied().unwrap_or_default())
            .collect();
    }
}

/// Whether no two non-empty block ranges share an instruction.
fn ranges_are_disjoint(ranges: &[core::ops::Range<u32>]) -> bool {
    let mut full: Vec<&core::ops::Range<u32>> = ranges.iter().filter(|r| !r.is_empty()).collect();
    full.sort_by_key(|r| r.start);
    full.windows(2).all(|w| w[0].end <= w[1].start)
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{LoadKind, Terminator};
    use super::*;

    fn func_with(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        let n = insts.len();
        FunctionSsa {
            inst_src: vec![(0, 0); n],
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

    /// One insertion renumbers the tape, the block ranges, the operands
    /// and the relocation table that names the moved instruction.
    #[test]
    fn an_insertion_moves_every_table_keyed_by_value_id() {
        let mut f = func_with(
            alloc::vec![
                Inst::ImmData(0x10),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                    align: 8,
                },
            ],
            alloc::vec![block(0..2, Terminator::Return(1))],
        );
        f.f32_values = alloc::vec![false, false];
        f.extern_imm_data_refs = alloc::vec![(0, 7)];
        let (rw, _undo) = insert(
            &mut f,
            &[Insertion {
                at: 0,
                inst: Inst::Imm(5),
                is_f32: true,
            }],
        );
        assert_eq!(rw.ids, alloc::vec![0]);
        assert_eq!(rw.remap, alloc::vec![1, 2]);
        assert_eq!(f.blocks[0].inst_range, 0..3);
        assert!(matches!(f.insts[0], Inst::Imm(5)));
        assert_eq!(f.f32_values, alloc::vec![true, false, false]);
        assert!(matches!(f.insts[2], Inst::Load { addr: 1, .. }));
        assert!(matches!(f.blocks[0].terminator, Terminator::Return(2)));
        assert_eq!(f.extern_imm_data_refs, alloc::vec![(1, 7)]);
    }

    /// The undo restores the tape and every table the rewrite replaced.
    #[test]
    fn the_undo_restores_the_function() {
        let mut f = func_with(
            alloc::vec![Inst::Imm(1), Inst::Imm(2)],
            alloc::vec![block(0..2, Terminator::Return(1))],
        );
        f.extern_imm_data_refs = alloc::vec![(1, 3)];
        let n_before = f.insts.len();
        let (_rw, undo) = insert(
            &mut f,
            &[Insertion {
                at: 1,
                inst: Inst::Imm(9),
                is_f32: false,
            }],
        );
        assert_eq!(f.insts.len(), 3);
        undo.restore(&mut f);
        assert_eq!(f.insts.len(), n_before);
        assert!(matches!(f.insts[1], Inst::Imm(2)));
        assert_eq!(f.blocks[0].inst_range, 0..2);
        assert_eq!(f.extern_imm_data_refs, alloc::vec![(1, 3)]);
    }

    fn add(lhs: ValueId, rhs: ValueId) -> Inst {
        Inst::Binop {
            op: super::super::super::ir::BinOp::Add,
            lhs,
            rhs,
        }
    }

    /// Adjacent ranges join with no instruction renumbered.
    #[test]
    fn concat_of_adjacent_ranges_moves_nothing() {
        let mut f = func_with(
            alloc::vec![Inst::Imm(1), Inst::Imm(2), add(0, 1)],
            alloc::vec![
                block(0..1, Terminator::Jmp(1)),
                block(1..3, Terminator::Return(2)),
            ],
        );
        concat(&mut f, &[alloc::vec![0, 1]]);
        assert_eq!(f.blocks[0].inst_range, 0..3);
        assert!(f.blocks[1].inst_range.is_empty());
        assert!(matches!(f.insts[2], Inst::Binop { lhs: 0, rhs: 1, .. }));
        assert!(matches!(f.blocks[1].terminator, Terminator::Return(2)));
    }

    /// A member that sits elsewhere on the tape moves behind the head,
    /// and everything keyed by value id follows: operands, terminators,
    /// `exit_acc`, the parallel tables, the relocation table and the
    /// range of the block in between.
    #[test]
    fn concat_moves_a_distant_range_behind_the_head() {
        let mut f = func_with(
            alloc::vec![
                Inst::Imm(1),      // v0  b0
                Inst::Imm(7),      // v1  b1
                add(1, 1),         // v2  b1
                Inst::ImmData(16), // v3  b2
                add(0, 3),         // v4  b2
            ],
            alloc::vec![
                block(0..1, Terminator::Jmp(2)),
                block(1..3, Terminator::Return(2)),
                block(
                    3..5,
                    Terminator::Bz {
                        cond: 4,
                        target: 1,
                        fall_through: 1,
                    },
                ),
            ],
        );
        f.blocks[2].exit_acc = 4;
        f.inst_src = alloc::vec![(10, 0), (11, 0), (12, 0), (13, 0), (14, 0)];
        f.f32_values = alloc::vec![false, true, false, false, false];
        f.cmp32 = alloc::vec![false, false, false, false, true];
        f.extern_imm_data_refs = alloc::vec![(3, 9)];
        concat(&mut f, &[alloc::vec![0, 2]]);
        // New order: v0, v3, v4, v1, v2.
        assert_eq!(f.blocks[0].inst_range, 0..3);
        assert_eq!(f.blocks[1].inst_range, 3..5);
        assert!(f.blocks[2].inst_range.is_empty());
        assert!(matches!(f.insts[1], Inst::ImmData(16)));
        assert!(matches!(f.insts[2], Inst::Binop { lhs: 0, rhs: 1, .. }));
        assert!(matches!(f.insts[4], Inst::Binop { lhs: 3, rhs: 3, .. }));
        assert!(matches!(f.blocks[1].terminator, Terminator::Return(4)));
        assert!(matches!(
            f.blocks[2].terminator,
            Terminator::Bz { cond: 2, .. }
        ));
        assert_eq!(f.blocks[2].exit_acc, 2);
        assert_eq!(
            f.inst_src,
            alloc::vec![(10, 0), (13, 0), (14, 0), (11, 0), (12, 0)]
        );
        assert_eq!(f.f32_values, alloc::vec![false, false, false, true, false]);
        assert_eq!(f.cmp32, alloc::vec![false, false, true, false, false]);
        assert_eq!(f.extern_imm_data_refs, alloc::vec![(1, 9)]);
    }

    /// An empty head takes over the first non-empty member where it
    /// stands; a member ahead of it on the tape moves back behind it, and
    /// an instruction no block covers keeps its relative place.
    #[test]
    fn concat_anchors_at_the_first_non_empty_member() {
        let mut f = func_with(
            alloc::vec![
                Inst::Imm(3), // v0  b3, the last of the chain
                Inst::Imm(0), // v1  covered by no block
                Inst::Imm(2), // v2  b2
            ],
            alloc::vec![
                block(0..0, Terminator::Jmp(1)),
                block(3..3, Terminator::Jmp(2)),
                block(2..3, Terminator::Jmp(3)),
                block(0..1, Terminator::Return(0)),
            ],
        );
        concat(&mut f, &[alloc::vec![0, 1, 2, 3]]);
        // New order: v1, v2, v0.
        assert_eq!(f.blocks[0].inst_range, 1..3);
        assert!(f.blocks[1..].iter().all(|b| b.inst_range.is_empty()));
        assert!(matches!(f.insts[1], Inst::Imm(2)));
        assert!(matches!(f.insts[2], Inst::Imm(3)));
        assert!(matches!(f.blocks[3].terminator, Terminator::Return(2)));
    }

    /// Two chains in one call, the second anchored inside the span the
    /// first one vacates.
    #[test]
    fn concat_handles_several_chains_at_once() {
        let mut f = func_with(
            alloc::vec![
                Inst::Imm(10), // v0  b0
                Inst::Imm(11), // v1  b1
                Inst::Imm(12), // v2  b2
                Inst::Imm(13), // v3  b3
            ],
            alloc::vec![
                block(0..1, Terminator::Jmp(2)),
                block(1..2, Terminator::Jmp(3)),
                block(2..3, Terminator::Return(2)),
                block(3..4, Terminator::Return(3)),
            ],
        );
        concat(&mut f, &[alloc::vec![0, 2], alloc::vec![1, 3]]);
        // New order: v0, v2, v1, v3.
        assert_eq!(f.blocks[0].inst_range, 0..2);
        assert_eq!(f.blocks[1].inst_range, 2..4);
        assert!(matches!(f.insts[1], Inst::Imm(12)));
        assert!(matches!(f.insts[2], Inst::Imm(11)));
        assert!(matches!(f.blocks[2].terminator, Terminator::Return(1)));
        assert!(matches!(f.blocks[3].terminator, Terminator::Return(3)));
    }
}
