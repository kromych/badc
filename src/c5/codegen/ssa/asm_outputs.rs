//! Register outputs of inline asm as values.
//!
//! An output operand reaches the statement as its object's address, and
//! the lowering stores the operand register through it; mem2reg promotes
//! no slot an instruction takes the address of, so a scalar automatic
//! written this way stays in the frame. A register-class output written
//! through the only read of a slot's address becomes the statement's own
//! value instead (`AsmOperand::value`), stored to the slot by a
//! `StoreLocal` behind the statement, and a `+` output reads the slot
//! ahead of it. One output per statement takes the form, and none of an
//! `asm goto`, which leaves through its labels past the store.

use alloc::collections::BTreeSet;
use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{
    AsmConstraint, AsmOperand, AsmSeg, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind,
    Terminator, ValueId,
};
use super::tape::{At, Insertion, insert};

/// Operand `op` of the statement at `at`, written through `addr`, the address of slot `off`.
struct Edit {
    at: ValueId,
    op: usize,
    addr: ValueId,
    off: i64,
    rw: bool,
    width: u8,
}

/// Whether `op` is a register-class output of a slot access width into an
/// object whose write is no access of its own: not a volatile one (C99
/// 6.7.3p6), not one reached through a segment override.
fn register_output(op: &AsmOperand) -> bool {
    op.is_output
        && !op.value
        && !op.volatile_object
        && op.seg == AsmSeg::None
        && matches!(
            op.constraint,
            AsmConstraint::Reg
                | AsmConstraint::Fixed(_)
                | AsmConstraint::RegOrImm { reg: Some(_), .. }
        )
        && matches!(op.width, 1 | 2 | 4 | 8)
}

/// The zero-extending read of a slot at the operand's width.
fn load_kind(width: u8) -> LoadKind {
    match width {
        1 => LoadKind::U8,
        2 => LoadKind::U16,
        4 => LoadKind::U32,
        _ => LoadKind::I64,
    }
}

fn store_kind(width: u8) -> StoreKind {
    match width {
        1 => StoreKind::I8,
        2 => StoreKind::I16,
        4 => StoreKind::I32,
        _ => StoreKind::I64,
    }
}

pub(crate) fn run(func: &mut FunctionSsa) {
    if !super::vector_slots::applies(func) {
        return;
    }
    let n = func.insts.len();
    let mut uses = vec![0u32; n];
    let mut count = |a: ValueId| {
        if let Some(u) = uses.get_mut(a as usize) {
            *u += 1;
        }
    };
    for inst in &func.insts {
        inst.for_each_operand(&mut count);
    }
    for b in &func.blocks {
        b.terminator.for_each_operand(&mut count);
    }
    let goto_asm: BTreeSet<ValueId> = func
        .blocks
        .iter()
        .filter(|b| matches!(b.terminator, Terminator::AsmGoto { .. }) && !b.inst_range.is_empty())
        .map(|b| b.inst_range.end - 1)
        .collect();
    let mut edits: Vec<Edit> = Vec::new();
    for (v, inst) in func.insts.iter().enumerate() {
        let Inst::InlineAsm { asm, args } = inst else {
            continue;
        };
        let at = v as ValueId;
        if goto_asm.contains(&at) || asm.operands.iter().any(|o| o.value && o.is_output) {
            continue;
        }
        // An address read elsewhere keeps its slot in memory anyway.
        let edit = asm
            .operands
            .iter()
            .zip(args)
            .enumerate()
            .find_map(|(i, (op, &a))| {
                let off = match func.insts.get(a as usize) {
                    Some(Inst::LocalAddr(off)) if register_output(op) && uses[a as usize] == 1 => {
                        *off
                    }
                    _ => return None,
                };
                Some(Edit {
                    at,
                    op: i,
                    addr: a,
                    off,
                    rw: op.is_rw,
                    width: op.width,
                })
            });
        edits.extend(edit);
    }
    if edits.is_empty() {
        return;
    }
    let mut ins: Vec<Insertion> = Vec::new();
    for e in &edits {
        if e.rw {
            ins.push(Insertion {
                at: At::Before(e.at),
                inst: Inst::LoadLocal {
                    off: e.off,
                    kind: load_kind(e.width),
                    volatile: false,
                },
                is_f32: false,
            });
        }
        let Inst::InlineAsm { asm, args } = &func.insts[e.at as usize] else {
            unreachable!("an edit names an inline asm statement");
        };
        let (mut asm, mut args) = (asm.clone(), args.clone());
        asm.operands[e.op].value = true;
        args[e.op] = NO_VALUE;
        ins.push(Insertion {
            at: At::Before(e.at),
            inst: Inst::InlineAsm { asm, args },
            is_f32: false,
        });
    }
    let (rw, _) = insert(func, &ins);
    let mut next = 0usize;
    let mut take = || {
        next += 1;
        rw.ids[next - 1]
    };
    let mut gone: BTreeSet<ValueId> = BTreeSet::new();
    for e in &edits {
        let load = e.rw.then(&mut take);
        let site = take();
        if let (Some(load), Inst::InlineAsm { args, .. }) = (load, &mut func.insts[site as usize]) {
            args[e.op] = load;
        }
        let addr = rw.remap[e.addr as usize];
        func.insts[addr as usize] = Inst::Imm(0);
        gone.insert(addr);
        let at = rw.remap[e.at as usize];
        func.insts[at as usize] = Inst::StoreLocal {
            off: e.off,
            value: site,
            kind: store_kind(e.width),
            volatile: false,
            nsw: false,
        };
        gone.insert(at);
    }
    for b in &mut func.blocks {
        if gone.contains(&b.exit_acc) {
            b.exit_acc = NO_VALUE;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{AsmBlock, AsmSeg, Block};
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

    fn operand(constraint: AsmConstraint, is_output: bool, is_rw: bool, width: u8) -> AsmOperand {
        AsmOperand {
            constraint,
            is_output,
            is_rw,
            width,
            seg: AsmSeg::None,
            static_arg: false,
            value: false,
            volatile_object: false,
        }
    }

    fn asm_of(template: &str, operands: Vec<AsmOperand>, args: Vec<ValueId>) -> Inst {
        Inst::InlineAsm {
            asm: alloc::boxed::Box::new(AsmBlock {
                template: template.as_bytes().to_vec(),
                operands,
                clobber_regs: 0,
                clobber_fp_regs: 0,
                clobber_memory: false,
                volatile: true,
            }),
            args,
        }
    }

    fn load(off: i64) -> Inst {
        Inst::LoadLocal {
            off,
            kind: LoadKind::I64,
            volatile: false,
        }
    }

    fn asm_at(func: &FunctionSsa, at: ValueId) -> (&AsmBlock, &[ValueId]) {
        match &func.insts[at as usize] {
            Inst::InlineAsm { asm, args } => (asm, args),
            other => panic!("{other:?}"),
        }
    }

    /// `asm("rdgsbase %0" : "=r"(x)); return x;`: the statement takes the
    /// value form, a store of it replaces the statement's position, the
    /// address is gone and the load of the slot follows the store.
    #[test]
    fn a_register_output_into_a_slot_becomes_the_statement_s_value() {
        let mut f = func_with(
            vec![
                Inst::LocalAddr(-1),
                asm_of(
                    "rdgsbase %0",
                    vec![operand(AsmConstraint::Reg, true, false, 8)],
                    vec![0],
                ),
                load(-1),
            ],
            vec![block(0..3, Terminator::Return(2))],
        );
        f.blocks[0].exit_acc = 1;
        run(&mut f);
        assert!(matches!(f.insts[0], Inst::Imm(0)), "{:?}", f.insts);
        let (asm, args) = asm_at(&f, 1);
        assert!(asm.operands[0].value);
        assert_eq!(args, &[NO_VALUE]);
        assert!(matches!(
            f.insts[2],
            Inst::StoreLocal {
                off: -1,
                value: 1,
                kind: StoreKind::I64,
                ..
            }
        ));
        assert!(matches!(f.insts[3], Inst::LoadLocal { off: -1, .. }));
        assert_eq!(f.blocks[0].inst_range, 0..4);
        assert_eq!(f.blocks[0].exit_acc, NO_VALUE);
    }

    /// A `+r` output reads the slot ahead of the statement, at the
    /// operand's width, and stores at it.
    #[test]
    fn a_read_write_output_reads_the_slot_ahead() {
        let mut f = func_with(
            vec![
                Inst::LocalAddr(-1),
                asm_of(
                    "incl %0",
                    vec![operand(AsmConstraint::Reg, true, true, 4)],
                    vec![0],
                ),
            ],
            vec![block(0..2, Terminator::Return(NO_VALUE))],
        );
        run(&mut f);
        assert!(matches!(
            f.insts[1],
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::U32,
                ..
            }
        ));
        let (asm, args) = asm_at(&f, 2);
        assert!(asm.operands[0].value && asm.operands[0].is_rw);
        assert_eq!(args, &[1]);
        assert!(matches!(
            f.insts[3],
            Inst::StoreLocal {
                off: -1,
                value: 2,
                kind: StoreKind::I32,
                ..
            }
        ));
    }

    /// A memory output, a volatile object, an address read twice, a second
    /// register output and an `asm goto` keep the address form.
    #[test]
    fn what_keeps_the_address_form() {
        let mem = |f: &mut FunctionSsa| {
            f.insts[1] = asm_of(
                "",
                vec![operand(AsmConstraint::Mem, true, false, 8)],
                vec![0],
            );
        };
        let volatile = |f: &mut FunctionSsa| {
            let mut op = operand(AsmConstraint::Reg, true, false, 8);
            op.volatile_object = true;
            f.insts[1] = asm_of("", vec![op], vec![0]);
        };
        let twice = |f: &mut FunctionSsa| {
            f.insts[1] = asm_of(
                "",
                vec![
                    operand(AsmConstraint::Reg, true, false, 8),
                    operand(AsmConstraint::Reg, false, false, 8),
                ],
                vec![0, 0],
            );
        };
        let goto = |f: &mut FunctionSsa| {
            f.blocks[0].terminator = Terminator::AsmGoto { table: 0 };
            f.blocks[0].inst_range = 0..2;
            f.blocks.push(block(2..3, Terminator::Return(2)));
        };
        for shape in [mem, volatile, twice, goto] {
            let mut f = func_with(
                vec![
                    Inst::LocalAddr(-1),
                    asm_of(
                        "",
                        vec![operand(AsmConstraint::Reg, true, false, 8)],
                        vec![0],
                    ),
                    load(-1),
                ],
                vec![block(0..3, Terminator::Return(2))],
            );
            shape(&mut f);
            run(&mut f);
            assert_eq!(f.insts.len(), 3, "{:?}", f.insts);
            assert!(matches!(f.insts[0], Inst::LocalAddr(-1)));
        }
        // Two register outputs: the first takes the value form alone.
        let mut f = func_with(
            vec![
                Inst::LocalAddr(-1),
                Inst::LocalAddr(-2),
                asm_of(
                    "",
                    vec![
                        operand(AsmConstraint::Fixed(0), true, false, 4),
                        operand(AsmConstraint::Fixed(2), true, false, 4),
                    ],
                    vec![0, 1],
                ),
            ],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        run(&mut f);
        let (asm, args) = asm_at(&f, 2);
        assert!(asm.operands[0].value && !asm.operands[1].value);
        assert_eq!(args, &[NO_VALUE, 1]);
        assert!(matches!(f.insts[1], Inst::LocalAddr(-2)));
        assert!(matches!(
            f.insts[3],
            Inst::StoreLocal {
                off: -1,
                value: 2,
                ..
            }
        ));
    }
}
