//! Placing instructions into a function's instruction tape.
//!
//! An insertion shifts the value id of every instruction after it, and
//! [`FunctionSsa`] keys several tables by value id: the tables parallel
//! to `insts`, and the cross-TU relocation lists. One left behind names
//! the wrong instructions, and nothing downstream can tell -- the ids
//! are still in range. The rewrite therefore lives here once, and the
//! destructure in [`insert`] names every field of the struct, so a table
//! added later does not compile until it is classified.

use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{Block, FunctionSsa, Inst, NO_VALUE, ValueId};

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
        over_aligned: _,
        frame_align: _,
        realign_region_bytes: _,
        has_returns_twice_call: _,
        did_unroll: _,
        did_inline: _,
    } = func;
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
    let map = |op: &mut ValueId| {
        if *op != NO_VALUE && (*op as usize) < n_old {
            *op = remap[*op as usize];
        }
    };
    for inst in new_insts.iter_mut() {
        inst.for_each_operand_mut(map);
    }
    for block in blocks.iter_mut() {
        if block.exit_acc != NO_VALUE && (block.exit_acc as usize) < n_old {
            block.exit_acc = remap[block.exit_acc as usize];
        }
        block.terminator.for_each_operand_mut(map);
    }
    for table in [
        extern_call_refs,
        extern_imm_code_refs,
        extern_imm_data_refs,
        extern_tls_refs,
    ] {
        for (v, _) in table.iter_mut() {
            map(v);
        }
    }
    let undo = Undo {
        insts: core::mem::replace(insts, new_insts),
        inst_src: core::mem::replace(inst_src, new_src),
        f32_values: core::mem::replace(f32_values, new_f32),
        cmp32: core::mem::replace(cmp32, new_cmp),
        ..undo
    };
    (Rewrite { remap, ids }, undo)
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
}
