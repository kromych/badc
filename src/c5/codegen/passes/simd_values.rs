//! x86 SIMD instructions on values.
//!
//! The walker lowers each `__builtin_ia32_*` call to an
//! [`Inst::Simd`] that reads its 128-bit operands through their
//! addresses and writes its result through the destination's, so every
//! vector the intrinsics pass along lives in memory. This pass, run under
//! `-O` ahead of `vector_slots`, reads each 128-bit operand with a `V128`
//! load, makes the instruction an [`Inst::SimdVal`] defining the result,
//! and stores the result through the destination address: the objects are
//! then accessed whole, `vector_slots` and `mem2reg` promote them, and the
//! values stay in xmm registers. A load or store form becomes the `V128`
//! load or store it is; `rdrand` and `rdseed`, which write through their
//! pointer, stay as they are.

use alloc::vec::Vec;

use crate::c5::codegen::ssa::tape::{self, At, Insertion};
use crate::c5::ir::{FunctionSsa, Inst, LoadKind, StoreKind, ValueId};
use crate::c5::simd;
use crate::c5::simd::Form;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for f in funcs {
        run_one(f);
    }
}

/// A source operand of the value form: an old value id, or the index of
/// the inserted load reading it.
#[derive(Clone, Copy)]
enum Src {
    Old(ValueId),
    Loaded(usize),
}

fn load(addr: ValueId, kind: LoadKind, align: u8) -> Inst {
    Inst::Load {
        addr,
        disp: 0,
        kind,
        volatile: false,
        align,
        pc_rel: false,
    }
}

fn store(addr: ValueId, value: ValueId, kind: StoreKind, align: u8) -> Inst {
    Inst::Store {
        addr,
        disp: 0,
        value,
        kind,
        volatile: false,
        align,
        pc_rel: false,
    }
}

fn run_one(func: &mut FunctionSsa) {
    let base = func.insts.len();
    let mut ins: Vec<Insertion> = Vec::new();
    let push = |ins: &mut Vec<Insertion>, at: At, inst: Inst| -> usize {
        ins.push(Insertion {
            at,
            inst,
            is_f32: false,
            copy_of: None,
        });
        ins.len() - 1
    };
    // Per rewritten instruction: its id and its new form, whose operands
    // are resolved once the insertions are placed.
    let mut rewrites: Vec<(ValueId, u32, Option<u8>, Vec<Src>)> = Vec::new();
    let mut memory: Vec<(ValueId, Inst)> = Vec::new();
    for block in &func.blocks {
        for v in block.inst_range.clone() {
            let Inst::Simd { op, imm, ref args } = func.insts[v as usize] else {
                continue;
            };
            let row = simd::get(op);
            let args = args.clone();
            // An MMX form's vectors are the 64 bits of their registers.
            let kinds = |bytes: u8| match bytes {
                8 => (LoadKind::F64, StoreKind::F64),
                32 => (LoadKind::V256, StoreKind::V256),
                64 => (LoadKind::V512, StoreKind::V512),
                _ => (LoadKind::V128, StoreKind::V128),
            };
            let (vload, vstore) = kinds(row.bytes);
            match row.form {
                // The masked transfers stay in memory: a store and a load
                // through a pointer are no values.
                Form::RdRand | Form::MaskLoad | Form::MaskStore => continue,
                // A `loadu` is a 128-bit load from its pointer stored to the
                // destination; a `storeu` the converse. The pointer bears
                // no alignment.
                Form::Load => {
                    memory.push((v, load(args[1], vload, 1)));
                    push(&mut ins, At::After(v), store(args[0], v, vstore, 0));
                }
                Form::Store => {
                    let l = push(&mut ins, At::Before(v), load(args[1], vload, 0));
                    memory.push((v, store(args[0], (base + l) as ValueId, vstore, 1)));
                }
                _ => {
                    // The address form's operands past the destination:
                    // the 128-bit one first, then an integer one if any.
                    let mut srcs = Vec::new();
                    for (k, &a) in args.iter().enumerate().skip(1) {
                        let vector = match row.form {
                            Form::Vv
                            | Form::VvI
                            | Form::Vvv
                            | Form::VvvI
                            | Form::CmpMask
                            | Form::Widen => true,
                            Form::MaskBlend => k != 2,
                            _ => k == 1,
                        };
                        srcs.push(if vector {
                            let kind = kinds(row.arg_bytes(k - 1)).0;
                            Src::Loaded(push(&mut ins, At::Before(v), load(a, kind, 0)))
                        } else {
                            Src::Old(a)
                        });
                    }
                    let kind = match row.form {
                        f if f.returns_vector() => kinds(row.ret_bytes()).1,
                        Form::ToInt if row.int_width == 8 => StoreKind::I64,
                        Form::Extract | Form::MoveMask | Form::CmpMask if row.int_width == 8 => {
                            StoreKind::I64
                        }
                        _ => StoreKind::I32,
                    };
                    push(&mut ins, At::After(v), store(args[0], v, kind, 0));
                    rewrites.push((v, op, imm, srcs));
                }
            }
        }
    }
    if ins.is_empty() && memory.is_empty() {
        return;
    }
    let pos = tape::sort(&mut ins, &func.blocks, base);
    let rewrite = tape::insert(func, &ins);
    let new_id = |s: Src| match s {
        Src::Old(v) => rewrite.remap[v as usize],
        Src::Loaded(k) => rewrite.ids[pos[k]],
    };
    for (v, op, imm, srcs) in rewrites {
        let args = srcs.into_iter().map(new_id).collect();
        func.insts[rewrite.remap[v as usize] as usize] = Inst::SimdVal { op, imm, args };
    }
    for (v, mut inst) in memory {
        inst.for_each_operand_mut(|o| {
            *o = if (*o as usize) < base {
                rewrite.remap[*o as usize]
            } else {
                rewrite.ids[pos[*o as usize - base]]
            };
        });
        func.insts[rewrite.remap[v as usize] as usize] = inst;
    }
}
