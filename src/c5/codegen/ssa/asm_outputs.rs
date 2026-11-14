//! Register outputs of inline asm as values.
//!
//! An output operand reaches the statement as its object's address, and
//! the lowering stores the operand register through it; mem2reg promotes
//! no slot an instruction takes the address of, so a scalar automatic
//! written this way stays in the frame. A register-class output written
//! through the only read of a slot's address becomes a value instead
//! (`AsmOperand::value`), stored to the slot by a `StoreLocal` behind the
//! statement, and a `+` output reads the slot ahead of it. The first such
//! output is the statement's own value, each later one an `Inst::AsmOut`
//! following it. No output of an `asm goto` takes the form: it leaves
//! through its labels past the stores.

use alloc::collections::BTreeSet;
use alloc::vec;
use alloc::vec::Vec;

use super::super::ir::{
    AsmConstraint, AsmOperand, AsmSeg, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind,
    Terminator, ValueId,
};
use super::tape::{At, Insertion, insert};

/// Output `op`, written through `addr` = slot `off`; `kind` as an `AsmOut`
/// and as the read of a `+` output, `store` the write-back.
struct Out {
    op: usize,
    addr: ValueId,
    off: i64,
    rw: bool,
    kind: LoadKind,
    read: LoadKind,
    store: StoreKind,
}

impl Out {
    /// A SIMD output's value is its register's own bits: a `float` stays
    /// single precision.
    fn is_f32(&self) -> bool {
        self.kind == LoadKind::F32
    }
}

/// The outputs of the statement at `at` that become values, in operand order.
struct Edit {
    at: ValueId,
    outs: Vec<Out>,
}

/// Whether `op` is a register-class output of a slot access width into an
/// object whose write is no access of its own: not a volatile one (C99
/// 6.7.3p6), not one reached through a segment override. A SIMD output
/// takes the width of a floating or vector kind; no kind holds 1 or 2
/// bytes in that file.
fn register_output(op: &AsmOperand) -> bool {
    let width_ok = match op.constraint {
        AsmConstraint::Reg
        | AsmConstraint::Fixed(_)
        | AsmConstraint::RegOrImm { reg: Some(_), .. }
        | AsmConstraint::Flags(_) => matches!(op.width, 1 | 2 | 4 | 8),
        AsmConstraint::Fp => matches!(op.width, 4 | 8 | 16),
        _ => false,
    };
    op.is_output && !op.value && !op.volatile_object && op.seg == AsmSeg::None && width_ok
}

/// The value kind of a register output, the read of its slot (zero-extending
/// for an integer) and the write of it.
fn kinds(op: &AsmOperand) -> (LoadKind, LoadKind, StoreKind) {
    let int = match op.width {
        1 => (LoadKind::U8, StoreKind::I8),
        2 => (LoadKind::U16, StoreKind::I16),
        4 => (LoadKind::U32, StoreKind::I32),
        _ => (LoadKind::I64, StoreKind::I64),
    };
    match (op.constraint, op.width) {
        (AsmConstraint::Fp, 4) => (LoadKind::F32, LoadKind::F32, StoreKind::F32),
        (AsmConstraint::Fp, 8) => (LoadKind::F64, LoadKind::F64, StoreKind::F64),
        (AsmConstraint::Fp, _) => (LoadKind::V128, LoadKind::V128, StoreKind::V128),
        // A flag output's `set<cc>` zero-extends its byte.
        (AsmConstraint::Flags(_), _) => (LoadKind::U8, int.0, int.1),
        _ => (LoadKind::I64, int.0, int.1),
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
        let outs: Vec<Out> = asm
            .operands
            .iter()
            .zip(args)
            .enumerate()
            .filter_map(|(i, (op, &a))| match func.insts.get(a as usize) {
                Some(Inst::LocalAddr(off)) if register_output(op) && uses[a as usize] == 1 => {
                    let (kind, read, store) = kinds(op);
                    Some(Out {
                        op: i,
                        addr: a,
                        off: *off,
                        rw: op.is_rw,
                        kind,
                        read,
                        store,
                    })
                }
                _ => None,
            })
            .collect();
        if !outs.is_empty() {
            edits.push(Edit { at, outs });
        }
    }
    if edits.is_empty() {
        return;
    }
    // Ahead of each statement: its `+` reads, the statement, an `AsmOut`
    // per later output, the stores; the last takes the old position.
    let mut ins: Vec<Insertion> = Vec::new();
    for e in &edits {
        let put = |ins: &mut Vec<Insertion>, inst: Inst, is_f32: bool| {
            ins.push(Insertion {
                at: At::Before(e.at),
                inst,
                is_f32,
                copy_of: None,
            })
        };
        for o in e.outs.iter().filter(|o| o.rw) {
            put(
                &mut ins,
                Inst::LoadLocal {
                    off: o.off,
                    disp: 0,
                    kind: o.read,
                    volatile: false,
                },
                o.is_f32(),
            );
        }
        let Inst::InlineAsm { asm, args } = &func.insts[e.at as usize] else {
            unreachable!("an edit names an inline asm statement");
        };
        let (mut asm, mut args) = (asm.clone(), args.clone());
        for o in &e.outs {
            asm.operands[o.op].value = true;
            args[o.op] = NO_VALUE;
        }
        put(&mut ins, Inst::InlineAsm { asm, args }, e.outs[0].is_f32());
        for o in &e.outs[1..] {
            put(
                &mut ins,
                Inst::AsmOut {
                    op: o.op as u8,
                    kind: o.kind,
                },
                o.is_f32(),
            );
        }
        for o in &e.outs[..e.outs.len() - 1] {
            put(&mut ins, store(o, NO_VALUE), false);
        }
    }
    let rw = insert(func, &ins);
    let mut next = 0usize;
    let mut take = || {
        next += 1;
        rw.ids[next - 1]
    };
    let mut gone: BTreeSet<ValueId> = BTreeSet::new();
    for e in &edits {
        let loads: Vec<ValueId> = e.outs.iter().filter(|o| o.rw).map(|_| take()).collect();
        let site = take();
        let values: Vec<ValueId> = core::iter::once(site)
            .chain(e.outs[1..].iter().map(|_| take()))
            .collect();
        let stores: Vec<ValueId> = e.outs[1..].iter().map(|_| take()).collect();
        if let Inst::InlineAsm { args, .. } = &mut func.insts[site as usize] {
            for (o, &load) in e.outs.iter().filter(|o| o.rw).zip(&loads) {
                args[o.op] = load;
            }
        }
        for (&st, &value) in stores.iter().zip(&values) {
            if let Inst::StoreLocal {
                disp: 0, value: v, ..
            } = &mut func.insts[st as usize]
            {
                *v = value;
            }
        }
        for o in &e.outs {
            let addr = rw.remap[o.addr as usize];
            func.insts[addr as usize] = Inst::Imm(0);
            gone.insert(addr);
        }
        let at = rw.remap[e.at as usize];
        let last = e.outs.len() - 1;
        func.insts[at as usize] = store(&e.outs[last], values[last]);
        gone.insert(at);
    }
    for b in &mut func.blocks {
        if gone.contains(&b.exit_acc) {
            b.exit_acc = NO_VALUE;
        }
    }
}

fn store(o: &Out, value: ValueId) -> Inst {
    Inst::StoreLocal {
        off: o.off,
        disp: 0,
        value,
        kind: o.store,
        volatile: false,
        nsw: false,
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{AsmBlock, AsmSeg, Block};
    use super::*;

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
            early_clobber: false,
            fp_limit: 0,
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
            disp: 0,
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
                disp: 0,
                off: -1,
                value: 1,
                kind: StoreKind::I64,
                ..
            }
        ));
        assert!(matches!(
            f.insts[3],
            Inst::LoadLocal {
                disp: 0,
                off: -1,
                ..
            }
        ));
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
                disp: 0,
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
                disp: 0,
                off: -1,
                value: 2,
                kind: StoreKind::I32,
                ..
            }
        ));
    }

    /// A SIMD output of 4 or 8 bytes is a single- or double-precision value
    /// and its `+` read is one; a 2-byte one has no such kind and keeps its
    /// address.
    #[test]
    fn simd_outputs_take_floating_kinds() {
        for (width, kind, read) in [
            (4, StoreKind::F32, LoadKind::F32),
            (8, StoreKind::F64, LoadKind::F64),
        ] {
            let mut f = func_with(
                vec![
                    Inst::LocalAddr(-1),
                    asm_of(
                        "fneg %d0, %d0",
                        vec![operand(AsmConstraint::Fp, true, true, width)],
                        vec![0],
                    ),
                ],
                vec![block(0..2, Terminator::Return(NO_VALUE))],
            );
            run(&mut f);
            assert!(matches!(f.insts[1], Inst::LoadLocal { kind, .. } if kind == read));
            assert!(matches!(f.insts[3], Inst::StoreLocal { kind: k, value: 2, .. } if k == kind));
            assert_eq!(f.f32_values[1..3], [width == 4; 2]);
        }
        let mut f = func_with(
            vec![
                Inst::LocalAddr(-1),
                asm_of(
                    "",
                    vec![operand(AsmConstraint::Fp, true, false, 2)],
                    vec![0],
                ),
            ],
            vec![block(0..2, Terminator::Return(NO_VALUE))],
        );
        run(&mut f);
        assert!(matches!(f.insts[0], Inst::LocalAddr(-1)));
    }

    /// A memory output, a volatile object, an address read twice and an
    /// `asm goto` keep the address form.
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
    }

    /// `asm("rdtsc" : "=a"(lo), "=d"(hi))`: the statement's value, an
    /// `AsmOut` right behind it, and the stores in operand order.
    #[test]
    fn every_register_output_becomes_a_value() {
        let mut f = func_with(
            vec![
                Inst::LocalAddr(-1),
                Inst::LocalAddr(-2),
                asm_of(
                    "rdtsc",
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
        assert!(matches!(f.insts[..2], [Inst::Imm(0), Inst::Imm(0)]));
        let (asm, args) = asm_at(&f, 2);
        assert!(asm.operands.iter().all(|o| o.value));
        assert_eq!(args, &[NO_VALUE, NO_VALUE]);
        assert!(matches!(f.insts[3], Inst::AsmOut { op: 1, .. }));
        assert!(matches!(
            f.insts[4],
            Inst::StoreLocal {
                disp: 0,
                off: -1,
                value: 2,
                kind: StoreKind::I32,
                ..
            }
        ));
        assert!(matches!(
            f.insts[5],
            Inst::StoreLocal {
                disp: 0,
                off: -2,
                value: 3,
                kind: StoreKind::I32,
                ..
            }
        ));
        assert_eq!(f.asm_output_values(2), [(0, 2), (1, 3)]);
        assert_eq!(f.blocks[0].inst_range, 0..6);
    }

    /// A flag output beside a `+a` output: the flag is the statement's own
    /// value, the read-write output an `AsmOut` whose slot is read ahead.
    #[test]
    fn a_flag_output_and_a_read_write_output_are_values() {
        let mut f = func_with(
            vec![
                Inst::LocalAddr(-1),
                Inst::LocalAddr(-2),
                asm_of(
                    "lock cmpxchgq %%rcx, (%%rdx)",
                    vec![
                        operand(AsmConstraint::Flags(4), true, false, 1),
                        operand(AsmConstraint::Fixed(0), true, true, 8),
                    ],
                    vec![0, 1],
                ),
            ],
            vec![block(0..3, Terminator::Return(NO_VALUE))],
        );
        run(&mut f);
        assert!(matches!(
            f.insts[2],
            Inst::LoadLocal {
                disp: 0,
                off: -2,
                kind: LoadKind::I64,
                ..
            }
        ));
        let (asm, args) = asm_at(&f, 3);
        assert!(asm.operands.iter().all(|o| o.value));
        assert_eq!(args, &[NO_VALUE, 2]);
        assert!(matches!(f.insts[4], Inst::AsmOut { op: 1, .. }));
        assert!(matches!(
            f.insts[5],
            Inst::StoreLocal {
                disp: 0,
                off: -1,
                value: 3,
                kind: StoreKind::I8,
                ..
            }
        ));
        assert!(matches!(
            f.insts[6],
            Inst::StoreLocal {
                disp: 0,
                off: -2,
                value: 4,
                kind: StoreKind::I64,
                ..
            }
        ));
    }
}
