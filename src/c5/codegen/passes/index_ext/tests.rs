use super::run;
use crate::c5::ir::{BinOp, Block, FunctionSsa, IndexExt, Inst, LoadKind, StoreKind, Terminator};
use alloc::vec;
use alloc::vec::Vec;

/// One block over `insts` returning its last value, after the pass.
fn ran(insts: Vec<Inst>) -> Vec<Inst> {
    let n = insts.len() as u32;
    let mut funcs = vec![FunctionSsa {
        inst_src: vec![(0, 0); insts.len()],
        f32_values: vec![false; insts.len()],
        insts,
        blocks: vec![Block {
            start_pc: 0,
            inst_range: 0..n,
            terminator: Terminator::Return(n - 1),
            exit_acc: crate::c5::ir::NO_VALUE,
        }],
        ..Default::default()
    }];
    run(&mut funcs);
    funcs.pop().unwrap().insts
}

fn param(idx: u8, kind: LoadKind) -> Inst {
    Inst::ParamRef {
        idx: idx.into(),
        kind,
    }
}

fn sext(value: u32) -> Inst {
    Inst::Extend {
        value,
        kind: LoadKind::I32,
        nsw: false,
    }
}

fn mask(lhs: u32) -> Inst {
    Inst::BinopI {
        op: BinOp::And,
        lhs,
        rhs_imm: 0xffff_ffff,
    }
}

fn load(base: u32, index: u32, scale: u8, kind: LoadKind) -> Inst {
    Inst::LoadIndexed {
        base,
        index,
        index_ext: IndexExt::None,
        scale,
        kind,
        abs_base: false,
    }
}

fn store(base: u32, index: u32, scale: u8, value: u32, kind: StoreKind) -> Inst {
    Inst::StoreIndexed {
        base,
        index,
        index_ext: IndexExt::None,
        scale,
        value,
        kind,
        abs_base: false,
    }
}

/// `(index, index_ext)` of the access at `at`.
fn index_at(insts: &[Inst], at: usize) -> (u32, IndexExt) {
    match &insts[at] {
        Inst::LoadIndexed {
            index, index_ext, ..
        }
        | Inst::StoreIndexed {
            index, index_ext, ..
        } => (*index, *index_ext),
        other => panic!("{other:?}"),
    }
}

/// v0 = pointer, v1 = a 64-bit value.
fn operands() -> Vec<Inst> {
    vec![param(0, LoadKind::I64), param(1, LoadKind::I64)]
}

#[test]
fn a_sign_extension_read_only_as_an_index_moves_into_the_access() {
    for (scale, kind) in [
        (1, LoadKind::I8),
        (1, LoadKind::U8),
        (2, LoadKind::I16),
        (2, LoadKind::U16),
        (4, LoadKind::I32),
        (4, LoadKind::U32),
        (8, LoadKind::I64),
    ] {
        let mut insts = operands();
        insts.extend([sext(1), load(0, 2, scale, kind)]);
        assert_eq!(index_at(&ran(insts), 3), (1, IndexExt::Sxtw), "{kind:?}");
    }
}

#[test]
fn a_word_mask_read_only_as_an_index_moves_into_the_access() {
    for (scale, kind) in [
        (1, StoreKind::I8),
        (2, StoreKind::I16),
        (4, StoreKind::I32),
        (8, StoreKind::I64),
    ] {
        let mut insts = operands();
        insts.extend([mask(1), store(0, 2, scale, 0, kind), Inst::Imm(0)]);
        assert_eq!(index_at(&ran(insts), 3), (1, IndexExt::Uxtw), "{kind:?}");
    }
}

/// The load and the store of one element share the extension.
#[test]
fn every_access_of_a_shared_extension_takes_it() {
    let mut insts = operands();
    insts.extend([
        sext(1),
        load(0, 2, 4, LoadKind::I32),
        store(0, 2, 4, 3, StoreKind::I32),
        Inst::Imm(0),
    ]);
    let out = ran(insts);
    assert_eq!(index_at(&out, 3), (1, IndexExt::Sxtw));
    assert_eq!(index_at(&out, 4), (1, IndexExt::Sxtw));
}

/// A reader of all 64 bits keeps the extension in its register, and the
/// access keeps reading that register whole.
#[test]
fn an_extension_with_a_full_width_reader_stays() {
    let readers: [fn(u32) -> Inst; 4] = [
        // Returned.
        |e| Inst::BinopI {
            op: BinOp::Add,
            lhs: e,
            rhs_imm: 1,
        },
        // Stored at 64 bits.
        |e| store(0, 0, 8, e, StoreKind::I64),
        // The base of another access.
        |e| load(e, 0, 1, LoadKind::U8),
        // The address of a plain load.
        |e| Inst::Load {
            addr: e,
            disp: 0,
            kind: LoadKind::I64,
            volatile: false,
            align: 0,
        },
    ];
    for reader in readers {
        let mut insts = operands();
        insts.extend([sext(1), load(0, 2, 4, LoadKind::I32), reader(2)]);
        let out = ran(insts);
        assert_eq!(index_at(&out, 3), (2, IndexExt::None), "{:?}", out[4]);
    }
}

/// A dead reader does not hold the extension.
#[test]
fn a_dead_reader_is_no_reader() {
    let mut insts = operands();
    insts.extend([
        sext(1),
        Inst::BinopI {
            op: BinOp::Add,
            lhs: 2,
            rhs_imm: 1,
        },
        load(0, 2, 4, LoadKind::I32),
    ]);
    assert_eq!(index_at(&ran(insts), 4), (1, IndexExt::Sxtw));
}

/// A 64-bit index has no extension to take.
#[test]
fn a_full_width_index_keeps_lsl() {
    let mut insts = operands();
    insts.push(load(0, 1, 4, LoadKind::I32));
    assert_eq!(index_at(&ran(insts), 2), (1, IndexExt::None));
    // Narrower extensions are not word extensions.
    let mut insts = operands();
    insts.extend([
        Inst::Extend {
            value: 1,
            kind: LoadKind::I16,
            nsw: false,
        },
        load(0, 2, 4, LoadKind::I32),
    ]);
    assert_eq!(index_at(&ran(insts), 3), (2, IndexExt::None));
    // Nor is another mask.
    let mut insts = operands();
    insts.extend([
        Inst::BinopI {
            op: BinOp::And,
            lhs: 1,
            rhs_imm: 0xffff,
        },
        load(0, 2, 4, LoadKind::I32),
    ]);
    assert_eq!(index_at(&ran(insts), 3), (2, IndexExt::None));
}

/// Only the low word of the new index is read, so the chain under it
/// goes too, and the first extension met decides the form.
#[test]
fn a_chain_of_word_extensions_collapses() {
    let mut insts = operands();
    insts.extend([mask(1), sext(2), load(0, 3, 1, LoadKind::U8)]);
    assert_eq!(index_at(&ran(insts), 4), (1, IndexExt::Sxtw));
    let mut insts = operands();
    insts.extend([sext(1), mask(2), load(0, 3, 1, LoadKind::U8)]);
    assert_eq!(index_at(&ran(insts), 4), (1, IndexExt::Uxtw));
    // The inner extension has a full-width reader: the chain stops there.
    let mut insts = operands();
    insts.extend([
        sext(1),
        mask(2),
        store(0, 0, 8, 2, StoreKind::I64),
        load(0, 3, 1, LoadKind::U8),
    ]);
    assert_eq!(index_at(&ran(insts), 5), (2, IndexExt::Uxtw));
}

/// An `int` parameter is marked where it stands; a 64-bit one is not.
#[test]
fn an_int_parameter_index_is_marked_in_place() {
    let insts = vec![
        param(0, LoadKind::I64),
        param(1, LoadKind::I32),
        load(0, 1, 4, LoadKind::I32),
    ];
    assert_eq!(index_at(&ran(insts), 2), (1, IndexExt::Sxtw));
    let insts = vec![
        param(0, LoadKind::I64),
        param(1, LoadKind::I16),
        load(0, 1, 4, LoadKind::I32),
    ];
    assert_eq!(index_at(&ran(insts), 2), (1, IndexExt::None));
}
