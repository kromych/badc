//! An aggregate passed or returned in registers as its register parts.
//!
//! System V AMD64 3.2.3, AAPCS64 6.4.2 and Win64 pass a small aggregate in
//! registers and return one the same way. The walker gives such a
//! parameter a frame object the prologue scatters the registers into, and
//! returns an object's address for the epilogue to gather from. Neither
//! transfer is in the tape, so the object's storage is pinned: `sroa`
//! cannot split it and its fields stay in memory through the body. This
//! pass puts both transfers in the tape. A parameter's registers arrive as
//! one `Inst::ParamPart` each, stored into the object field by field, the
//! padding between fields included, so the bytes the caller's object holds
//! there reach the callee's object as the prologue's whole-register store
//! delivered them; a return gathers the fields into the parts of an
//! `Inst::AggParts`, which the `Return` names instead of the address. The
//! object is then an ordinary local, `sroa` splits it, `mem2reg` promotes
//! the fields and drops the padding stores nothing reads, and a function
//! whose parameter and result stay in registers keeps no frame.
//!
//! A field moves as a load or store of its own width, so the pass takes an
//! aggregate only when its fields tile its registers that way: integer
//! fields of 1, 2, 4 or 8 bytes in an integer register, shifted into
//! place, and one `float` or `double` filling a floating-point register.
//! A union, a `float` beside an integer in one register, two `float`s in
//! one SSE eightbyte and a vector keep the prologue and epilogue
//! transfers. A parameter object whose address escapes, or that a member
//! access reaches at a variable offset, stays in memory whatever the
//! stores look like, so its registers are stored whole, as the prologue
//! stored them.
//!
//! A variadic callee's named aggregates stay in the register save area
//! its prologue fills, which the body reads through their homes and
//! `va_start` steps past; its return takes the parts like any other.
//!
//! Runs after the inliner, whose splices bind a callee's parameter object
//! to the caller's argument and copy a returned object field by field, and
//! before `sroa`.

use alloc::vec::Vec;

use crate::c5::codegen::abi_classify::{RegClass, RegPart, ScalarKind, register_parts};
use crate::c5::codegen::ssa::tape::{self, At, Insertion};
use crate::c5::codegen::{ArgPlacement, Target, offset_align};
use crate::c5::ir::{
    AggDesc, BinOp, BlockId, FpMask, FunctionSsa, Inst, LoadKind, NO_VALUE, StoreKind, Terminator,
    ValueId,
};

pub(crate) fn run(funcs: &mut [FunctionSsa], target: Target) {
    for f in funcs {
        if !f.is_naked && !f.blocks.is_empty() {
            run_one(f, target);
        }
    }
}

/// Whether every part moves as loads and stores of its fields' own widths.
fn tape_carries(parts: &[RegPart], n_fields: usize) -> bool {
    let covered: usize = parts.iter().map(|p| p.fields.len()).sum();
    if covered != n_fields {
        return false;
    }
    parts.iter().all(|p| match p.class {
        RegClass::Integer => {
            let fields = sorted_fields(p);
            fields
                .iter()
                .all(|f| f.kind == ScalarKind::Int && matches!(f.size, 1 | 2 | 4 | 8))
                && fields
                    .windows(2)
                    .all(|w| w[0].offset + w[0].size <= w[1].offset)
        }
        RegClass::Sse => matches!(
            p.fields.as_slice(),
            [f] if f.offset == p.offset
                && f.size == p.width
                && matches!((f.kind, f.size), (ScalarKind::F64, 8) | (ScalarKind::F32, 4))
        ),
        RegClass::Vector => false,
    })
}

fn sorted_fields(p: &RegPart) -> Vec<crate::c5::codegen::abi_classify::FlatField> {
    let mut fields = p.fields.clone();
    fields.sort_by_key(|f| f.offset);
    fields
}

/// The bank and precision a part's value takes.
fn part_kind(p: &RegPart) -> LoadKind {
    match (p.class, p.width) {
        (RegClass::Integer, _) => LoadKind::I64,
        (_, 4) => LoadKind::F32,
        _ => LoadKind::F64,
    }
}

fn store_kind(size: u32) -> StoreKind {
    match size {
        8 => StoreKind::I64,
        4 => StoreKind::I32,
        2 => StoreKind::I16,
        _ => StoreKind::I8,
    }
}

/// A field's zero-extending load, so the parts compose by `or`.
fn load_kind(size: u32) -> LoadKind {
    match size {
        8 => LoadKind::I64,
        4 => LoadKind::U32,
        2 => LoadKind::U16,
        _ => LoadKind::U8,
    }
}

/// The alignment a field access records: the object's at that offset,
/// where it does not cover the access.
fn access_align(desc: &AggDesc, off: u32, size: u32) -> u8 {
    let at = offset_align(desc.align, i64::from(off));
    if at >= size {
        0
    } else {
        at.min(u32::from(u8::MAX)) as u8
    }
}

/// The insertions in order; an inserted value's id counts past the tape.
struct Plan {
    ins: Vec<Insertion>,
    base: ValueId,
}

impl Plan {
    fn push(&mut self, at: At, inst: Inst, is_f32: bool) -> ValueId {
        self.ins.push(Insertion { at, inst, is_f32 });
        self.base + (self.ins.len() - 1) as ValueId
    }
}

/// The naturally aligned stores that cover the bytes `[lo, hi)`.
fn gap_stores(out: &mut Vec<(u32, u32, StoreKind)>, mut lo: u32, hi: u32) {
    while lo < hi {
        let mut w = 8;
        while w > hi - lo || !lo.is_multiple_of(w) {
            w /= 2;
        }
        out.push((lo, w, store_kind(w)));
        lo += w;
    }
}

/// Whether every use of the object at `slot` is a load or store at a
/// constant offset or a copy, the uses `sroa` splits an object over; a
/// `Return` of its address counts as one when the pass rewrites it.
fn splits_by_fields(func: &FunctionSsa, slot: i64, returns_parts: bool) -> bool {
    let n = func.insts.len();
    let mut addrs = alloc::vec![false; n];
    for (v, inst) in func.insts.iter().enumerate() {
        addrs[v] = match inst {
            Inst::LocalAddr(s) => *s == slot,
            Inst::BinopI {
                op: BinOp::Add | BinOp::Sub,
                lhs,
                ..
            } => addrs[*lhs as usize],
            _ => false,
        };
    }
    let names = |v: ValueId| (v as usize) < n && addrs[v as usize];
    let escapes = |inst: &Inst| match inst {
        Inst::Load { .. } | Inst::BinopI { .. } => false,
        Inst::Store { value, .. } => names(*value),
        Inst::Mcpy { dst, src, .. } => !names(*dst) && !names(*src),
        _ => {
            let mut any = false;
            inst.for_each_operand(|o| any |= names(o));
            any
        }
    };
    if func.insts.iter().any(escapes) {
        return false;
    }
    func.blocks.iter().all(|b| match b.terminator {
        Terminator::Return(_) if returns_parts => true,
        ref t => {
            let mut any = false;
            t.for_each_operand(|o| any |= names(o));
            !any
        }
    })
}

/// The stores that carry part `p`, arriving as `value`, into the object
/// at `slot`: each field at its own width and the bytes between them as
/// they lie in the register when the object splits by field, else the
/// whole register. The base cell's store names the cell, which the
/// object's address names too; an interior cell is named by no
/// instruction, so a store there goes through the address, taken once.
#[allow(clippy::too_many_arguments)]
fn scatter(
    plan: &mut Plan,
    at: At,
    slot: i64,
    addr: &mut Option<ValueId>,
    value: ValueId,
    p: &RegPart,
    desc: &AggDesc,
    split: bool,
) {
    let mut pieces: Vec<(u32, u32, StoreKind)> = Vec::new();
    if p.class == RegClass::Integer && !split {
        gap_stores(&mut pieces, p.offset, p.offset + p.width);
    } else {
        let mut pos = p.offset;
        for f in sorted_fields(p) {
            gap_stores(&mut pieces, pos, f.offset);
            let kind = match (p.class, f.size) {
                (RegClass::Integer, size) => store_kind(size),
                (_, 4) => StoreKind::F32,
                _ => StoreKind::F64,
            };
            pieces.push((f.offset, f.size, kind));
            pos = f.offset + f.size;
        }
        gap_stores(&mut pieces, pos, p.offset + p.width);
    }
    for (off, size, kind) in pieces {
        let bits = 8 * (off - p.offset);
        let v = if bits == 0 || p.class != RegClass::Integer {
            value
        } else {
            plan.push(
                at,
                Inst::BinopI {
                    op: BinOp::Shru,
                    lhs: value,
                    rhs_imm: i64::from(bits),
                },
                false,
            )
        };
        if !split && off == 0 {
            plan.push(
                at,
                Inst::StoreLocal {
                    off: slot,
                    value: v,
                    kind,
                    volatile: false,
                },
                false,
            );
            continue;
        }
        let base = *addr.get_or_insert_with(|| plan.push(at, Inst::LocalAddr(slot), false));
        plan.push(
            at,
            Inst::Store {
                addr: base,
                disp: off as i32,
                value: v,
                kind,
                volatile: false,
                align: access_align(desc, off, size),
            },
            false,
        );
    }
}

/// Load the fields of part `p` from the object at `addr` and compose
/// them into the part's value.
fn gather(plan: &mut Plan, at: At, addr: ValueId, p: &RegPart, desc: &AggDesc) -> ValueId {
    let load = |plan: &mut Plan, off: u32, size: u32, kind: LoadKind, is_f32: bool| {
        plan.push(
            at,
            Inst::Load {
                addr,
                disp: off as i32,
                kind,
                volatile: false,
                align: access_align(desc, off, size),
            },
            is_f32,
        )
    };
    if p.class != RegClass::Integer {
        let f = p.fields[0];
        let single = f.size == 4;
        let kind = if single { LoadKind::F32 } else { LoadKind::F64 };
        return load(plan, f.offset, f.size, kind, single);
    }
    let mut acc = None;
    for f in sorted_fields(p) {
        let l = load(plan, f.offset, f.size, load_kind(f.size), false);
        let bits = 8 * (f.offset - p.offset);
        let v = if bits == 0 {
            l
        } else {
            plan.push(
                at,
                Inst::BinopI {
                    op: BinOp::Shl,
                    lhs: l,
                    rhs_imm: i64::from(bits),
                },
                false,
            )
        };
        acc = Some(match acc {
            None => v,
            Some(a) => plan.push(
                at,
                Inst::Binop {
                    op: BinOp::Or,
                    lhs: a,
                    rhs: v,
                },
                false,
            ),
        });
    }
    acc.unwrap_or_else(|| plan.push(at, Inst::Imm(0), false))
}

fn run_one(func: &mut FunctionSsa, target: Target) {
    let abi = target.abi_row(func.conv).abi();
    let placements = crate::c5::codegen::ssa::emit_common::param_placements_common(func, abi);
    let mut plan = Plan {
        ins: Vec::new(),
        base: func.insts.len() as ValueId,
    };
    let entry = func.blocks[0].inst_range.clone();
    let entry_at = if entry.is_empty() {
        At::Empty(0)
    } else {
        At::Before(entry.start)
    };
    let ret_parts = func.ret_agg.and_then(|ai| {
        let desc = &func.agg_descs[ai as usize];
        register_parts(desc.size, &desc.fields, abi, true)
            .filter(|parts| tape_carries(parts, desc.fields.len()))
            .map(|parts| (ai, parts))
    });
    // The parts are read at the head of the entry block and stored past
    // the reads opening it, so the entry parallel copy places every read
    // (`emit_common::entry_read_run`).
    let counts = crate::c5::codegen::ssa::reg_alloc::compute_use_counts(func);
    let reads = crate::c5::codegen::ssa::emit_common::entry_read_run(func, &counts);
    let store_at = reads.last().map_or(entry_at, |&v| At::After(v as ValueId));
    let mut stores = Vec::new();
    let mut taken: Vec<usize> = Vec::new();
    for (i, agg) in func.param_aggs.iter().enumerate() {
        let (Some(d), Some(&slot)) = (agg, func.param_local_slots.get(i)) else {
            continue;
        };
        if func.is_variadic
            || slot >= 0
            || !matches!(placements.get(i), Some(ArgPlacement::StructRegs { .. }))
        {
            continue;
        }
        let desc = &func.agg_descs[*d as usize];
        let Some(parts) = register_parts(desc.size, &desc.fields, abi, false) else {
            continue;
        };
        if !tape_carries(&parts, desc.fields.len()) {
            continue;
        }
        let split = splits_by_fields(func, slot, ret_parts.is_some());
        let mut values = Vec::new();
        for (k, p) in parts.into_iter().enumerate() {
            let kind = part_kind(&p);
            let value = plan.push(
                entry_at,
                Inst::ParamPart {
                    idx: i as u32,
                    part: k as u8,
                    kind,
                },
                kind == LoadKind::F32,
            );
            values.push((value, p));
        }
        stores.push((slot, *d as usize, split, values));
        taken.push(i);
    }
    for (slot, d, split, values) in &stores {
        let mut addr = None;
        for (value, p) in values {
            let desc = &func.agg_descs[*d];
            scatter(
                &mut plan, store_at, *slot, &mut addr, *value, p, desc, *split,
            );
        }
    }
    let mut bundles: Vec<(usize, ValueId)> = Vec::new();
    if let Some((ai, parts)) = ret_parts {
        let desc = &func.agg_descs[ai as usize];
        {
            let mut fp_mask = FpMask::EMPTY;
            for (k, p) in parts.iter().enumerate() {
                if p.class != RegClass::Integer {
                    fp_mask.set(k);
                }
            }
            for (b, block) in func.blocks.iter().enumerate() {
                let Terminator::Return(v) = block.terminator else {
                    continue;
                };
                if v == NO_VALUE {
                    continue;
                }
                let at = if block.inst_range.is_empty() {
                    At::Empty(b as BlockId)
                } else {
                    At::After(block.inst_range.end - 1)
                };
                let vals: Vec<ValueId> = parts
                    .iter()
                    .map(|p| gather(&mut plan, at, v, p, desc))
                    .collect();
                let bundle = plan.push(
                    at,
                    Inst::AggParts {
                        desc: ai,
                        parts: vals,
                        fp_mask: fp_mask.clone(),
                    },
                    false,
                );
                bundles.push((b, bundle));
            }
        }
    }
    if plan.ins.is_empty() {
        return;
    }
    let Plan { mut ins, base } = plan;
    let pos = tape::sort(&mut ins, &func.blocks, base as usize);
    let (rewrite, _undo) = tape::insert(func, &ins);
    for (b, bundle) in bundles {
        let id = rewrite.ids[pos[(bundle - base) as usize]];
        func.blocks[b].terminator = Terminator::Return(id);
    }
    for i in taken {
        func.param_local_slots[i] = 0;
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::ssa::shadow::produce_ssa_funcs;
    use crate::{Compiler, Target};

    fn walked(src: &str, name: &str, target: Target) -> FunctionSsa {
        let program = Compiler::with_target(
            alloc::format!("{src} int main(void){{ return 0; }}"),
            target,
        )
        .compile()
        .expect("compile");
        produce_ssa_funcs(&program, target, true, true)
            .expect("ssa")
            .into_iter()
            .find(|f| f.name == name)
            .expect("the function")
    }

    fn text(f: &FunctionSsa) -> alloc::string::String {
        alloc::format!("{:?}\n{:?}", f.insts, f.blocks)
    }

    /// A two-`long` parameter arrives as two parts stored at its fields'
    /// offsets, ahead of the body, and the return names a bundle of the
    /// two fields loaded from the object, last in its block; the slot is
    /// then the body's own.
    #[test]
    fn pair_transfers_move_into_the_tape() {
        const SRC: &str =
            "struct P { long a, b; }; struct P by_value(struct P v) { v.a += 1; return v; }";
        for target in [Target::LinuxAarch64, Target::LinuxX64] {
            let mut f = walked(SRC, "by_value", target);
            let slot = f.param_local_slots[0];
            assert!(slot < 0, "{target:?}: {}", text(&f));
            run(core::slice::from_mut(&mut f), target);
            let t = text(&f);
            let entry = f.blocks[0].inst_range.clone();
            let parts: Vec<u32> = entry
                .clone()
                .filter(|&v| matches!(f.insts[v as usize], Inst::ParamPart { .. }))
                .collect();
            assert_eq!(parts.len(), 2, "{target:?}: {t}");
            for (k, &v) in parts.iter().enumerate() {
                let Inst::ParamPart { idx, part, kind } = f.insts[v as usize] else {
                    unreachable!()
                };
                assert_eq!(
                    (idx, part, kind),
                    (0, k as u8, LoadKind::I64),
                    "{target:?}: {t}"
                );
                let stored = f.insts[entry.start as usize..entry.end as usize]
                    .iter()
                    .any(|i| {
                        matches!(*i, Inst::Store { value, disp, kind: StoreKind::I64, .. }
                            if value == v && disp == 8 * k as i32)
                    });
                assert!(stored, "{target:?}: part {k} not stored: {t}");
            }
            // The stores precede the body's first access of the object.
            let first_body_load = entry
                .clone()
                .find(|&v| matches!(f.insts[v as usize], Inst::Load { .. }))
                .expect("a load");
            assert!(parts.iter().all(|&v| v < first_body_load), "{t}");
            let Terminator::Return(r) = f.blocks[0].terminator else {
                panic!("{t}")
            };
            let Inst::AggParts { parts, fp_mask, .. } = &f.insts[r as usize] else {
                panic!("{target:?}: {t}")
            };
            assert_eq!(r + 1, f.blocks[0].inst_range.end, "{t}");
            assert_eq!(parts.len(), 2, "{t}");
            assert!(fp_mask.is_empty(), "{t}");
            for (k, &p) in parts.iter().enumerate() {
                assert!(
                    matches!(f.insts[p as usize], Inst::Load { disp, kind: LoadKind::I64, .. }
                        if disp == 8 * k as i32),
                    "{target:?}: part {k}: {t}"
                );
            }
            assert_eq!(f.param_local_slots[0], 0, "{t}");
        }
    }

    /// The parts of several parameters, the scalars between them and the
    /// scalars' reads all open the entry block ahead of the first store,
    /// so the entry parallel copy places every read.
    #[test]
    fn every_read_opens_the_entry_block() {
        const SRC: &str = "struct p1 { int a; }; struct p2 { int a, b; }; \
            struct p3 { int a, b, c; }; \
            long long take(struct p2 a, int s0, struct p3 b, struct p1 c, int s1) \
            { return a.a + a.b + s0 + b.a + b.b + b.c + c.a + s1; }";
        for target in [Target::LinuxAarch64, Target::LinuxX64, Target::WindowsX64] {
            let mut f = walked(SRC, "take", target);
            run(core::slice::from_mut(&mut f), target);
            let t = text(&f);
            let reads: Vec<usize> = (0..f.insts.len())
                .filter(|&v| matches!(f.insts[v], Inst::ParamRef { .. } | Inst::ParamPart { .. }))
                .collect();
            let parts = reads
                .iter()
                .filter(|&&v| matches!(f.insts[v], Inst::ParamPart { .. }))
                .count();
            assert!(parts >= 2, "{target:?}: {t}");
            let counts = crate::c5::codegen::ssa::reg_alloc::compute_use_counts(&f);
            let run = crate::c5::codegen::ssa::emit_common::entry_read_run(&f, &counts);
            assert_eq!(run, reads, "{target:?}: {t}");
        }
    }

    /// Two `int`s in one register: the second field is the part shifted
    /// down on entry and shifted up into the returned part.
    #[test]
    fn sub_register_fields_shift() {
        const SRC: &str = "struct Q { int a, b; }; struct Q swap(struct Q v) { struct Q r; r.a = v.b; r.b = v.a; return r; }";
        for target in [Target::LinuxAarch64, Target::LinuxX64, Target::WindowsX64] {
            let mut f = walked(SRC, "swap", target);
            run(core::slice::from_mut(&mut f), target);
            let t = text(&f);
            let shr = f.insts.iter().filter(|i| {
                matches!(
                    i,
                    Inst::BinopI {
                        op: BinOp::Shru,
                        rhs_imm: 32,
                        ..
                    }
                )
            });
            assert_eq!(shr.count(), 1, "{target:?}: {t}");
            let stores: Vec<(i32, StoreKind)> = f.blocks[0]
                .inst_range
                .clone()
                .take_while(|&v| !matches!(f.insts[v as usize], Inst::Load { .. }))
                .filter_map(|v| match f.insts[v as usize] {
                    Inst::Store { disp, kind, .. } => Some((disp, kind)),
                    _ => None,
                })
                .collect();
            assert_eq!(
                stores,
                [(0, StoreKind::I32), (4, StoreKind::I32)],
                "{target:?}: {t}"
            );
            let Terminator::Return(r) = f.blocks[0].terminator else {
                panic!("{t}")
            };
            let Inst::AggParts { parts, .. } = &f.insts[r as usize] else {
                panic!("{t}")
            };
            assert_eq!(parts.len(), 1, "{t}");
            assert!(
                matches!(
                    f.insts[parts[0] as usize],
                    Inst::Binop { op: BinOp::Or, .. }
                ),
                "{target:?}: {t}"
            );
            assert!(
                f.insts.iter().any(|i| matches!(
                    i,
                    Inst::BinopI {
                        op: BinOp::Shl,
                        rhs_imm: 32,
                        ..
                    }
                )),
                "{t}"
            );
        }
    }

    /// The padding between a `char` and an `int` is stored from the register
    /// too, at the widths its alignment allows, so the bytes the caller's
    /// object carries there reach the callee's object.
    #[test]
    fn padding_between_fields_is_stored() {
        const SRC: &str = "struct S { char c; int i; }; int id(struct S s) { return s.i; }";
        for target in [Target::LinuxAarch64, Target::LinuxX64] {
            let mut f = walked(SRC, "id", target);
            run(core::slice::from_mut(&mut f), target);
            let t = text(&f);
            let stores: Vec<(i32, StoreKind)> = f
                .insts
                .iter()
                .filter_map(|i| match i {
                    Inst::Store { disp, kind, .. } => Some((*disp, *kind)),
                    _ => None,
                })
                .collect();
            assert_eq!(
                stores,
                [
                    (0, StoreKind::I8),
                    (1, StoreKind::I8),
                    (2, StoreKind::I16),
                    (4, StoreKind::I32)
                ],
                "{target:?}: {t}"
            );
        }
    }

    /// An object whose address reaches a call, or that an index reaches,
    /// takes one whole store per register; a copy out of it does not
    /// count as an escape.
    #[test]
    fn escaping_object_takes_whole_register_stores() {
        const SRC: &str = "struct S { char c; int i; };\n\
            int g(const struct S *p);\n\
            int esc(struct S s) { return g(&s); }\n\
            int idx(struct S s, int k) { return ((char *)&s)[k]; }\n\
            struct S copy(struct S s) { struct S r = s; return r; }";
        for target in [Target::LinuxAarch64, Target::LinuxX64] {
            for (name, whole) in [("esc", true), ("idx", true), ("copy", false)] {
                let mut f = walked(SRC, name, target);
                let slot = f.param_local_slots[0];
                run(core::slice::from_mut(&mut f), target);
                let t = text(&f);
                // A whole register goes through the cell's own store.
                let stores: Vec<(i32, StoreKind)> = f.blocks[0]
                    .inst_range
                    .clone()
                    .take_while(|&v| !matches!(f.insts[v as usize], Inst::Load { .. }))
                    .filter_map(|v| match f.insts[v as usize] {
                        Inst::Store { disp, kind, .. } => Some((disp, kind)),
                        Inst::StoreLocal { off, kind, .. } if off == slot => Some((0, kind)),
                        _ => None,
                    })
                    .collect();
                let want: &[(i32, StoreKind)] = if whole {
                    &[(0, StoreKind::I64)]
                } else {
                    &[
                        (0, StoreKind::I8),
                        (1, StoreKind::I8),
                        (2, StoreKind::I16),
                        (4, StoreKind::I32),
                    ]
                };
                assert_eq!(stores, want, "{target:?} {name}: {t}");
            }
        }
    }

    /// A variadic callee keeps its named aggregate in the save area; its
    /// return still takes the parts.
    #[test]
    fn variadic_callee_keeps_its_named_aggregate() {
        const SRC: &str = "#include <stdarg.h>\n\
            struct P { long a, b; };\n\
            struct P va(struct P p, int n, ...) { va_list ap; va_start(ap, n);\n\
                p.a += va_arg(ap, long); va_end(ap); return p; }";
        for target in [Target::LinuxAarch64, Target::LinuxX64] {
            let mut f = walked(SRC, "va", target);
            let slot = f.param_local_slots[0];
            run(core::slice::from_mut(&mut f), target);
            let t = text(&f);
            assert!(
                !f.insts.iter().any(|i| matches!(i, Inst::ParamPart { .. })),
                "{target:?}: {t}"
            );
            assert_eq!(f.param_local_slots[0], slot, "{target:?}: {t}");
            let returns = f.blocks.iter().filter(|b| {
                matches!(b.terminator, Terminator::Return(v)
                    if matches!(f.insts.get(v as usize), Some(Inst::AggParts { .. })))
            });
            assert_eq!(returns.count(), 1, "{target:?}: {t}");
        }
    }

    /// A union, and two `float`s in one SSE eightbyte, keep the prologue
    /// and epilogue transfers; an HFA of two `double`s takes two
    /// floating-point parts on AAPCS64 and two SSE parts on System V.
    #[test]
    fn admission_follows_the_field_tiling() {
        const UNION: &str = "union U { long a; double d; }; union U id(union U u) { return u; }";
        for target in [Target::LinuxAarch64, Target::LinuxX64] {
            let mut f = walked(UNION, "id", target);
            let before = text(&f);
            run(core::slice::from_mut(&mut f), target);
            assert_eq!(before, text(&f), "{target:?}");
        }
        const FLOATS: &str = "struct F { float x, y; }; struct F id(struct F u) { return u; }";
        let mut f = walked(FLOATS, "id", Target::LinuxX64);
        let before = text(&f);
        run(core::slice::from_mut(&mut f), Target::LinuxX64);
        assert_eq!(before, text(&f));
        let mut f = walked(FLOATS, "id", Target::LinuxAarch64);
        run(core::slice::from_mut(&mut f), Target::LinuxAarch64);
        let t = text(&f);
        let Terminator::Return(r) = f.blocks[0].terminator else {
            panic!("{t}")
        };
        let Inst::AggParts { parts, fp_mask, .. } = &f.insts[r as usize] else {
            panic!("{t}")
        };
        assert_eq!((parts.len(), fp_mask.count()), (2, 2), "{t}");
        assert!(f.f32_values[parts[1] as usize], "{t}");
        const DOUBLES: &str = "struct D { double x, y; }; struct D id(struct D u) { return u; }";
        for target in [Target::LinuxAarch64, Target::LinuxX64] {
            let mut f = walked(DOUBLES, "id", target);
            run(core::slice::from_mut(&mut f), target);
            let t = text(&f);
            let parts: Vec<LoadKind> = f
                .insts
                .iter()
                .filter_map(|i| match i {
                    Inst::ParamPart { kind, .. } => Some(*kind),
                    _ => None,
                })
                .collect();
            assert_eq!(parts, [LoadKind::F64, LoadKind::F64], "{target:?}: {t}");
            let Terminator::Return(r) = f.blocks[0].terminator else {
                panic!("{t}")
            };
            let Inst::AggParts { fp_mask, .. } = &f.insts[r as usize] else {
                panic!("{t}")
            };
            assert_eq!(fp_mask.count(), 2, "{target:?}: {t}");
        }
    }
}
