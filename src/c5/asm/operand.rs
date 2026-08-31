//! What an extended inline-asm operand reference resolves to when the
//! SSA feeding it is known: a constant for an `i` or `n` operand, the
//! data or code symbol an address operand names, and the offset from it.

use super::*;
use crate::c5::codegen::ssa::mem2reg;
use crate::c5::ir::{AsmConstraint, BinOp, FunctionSsa, Inst, LoadKind, StoreKind};

/// Bound on the value chain one fold descends through.
const FOLD_DEPTH: usize = 16;
/// Bound on the values one fold visits in total.
const FOLD_BUDGET: u32 = 1024;

/// What one asm statement's operands resolve to, for the section layout:
/// `const_of` yields an `i`-class operand's integer constant, `symbol_of`
/// the link-time address one names and the addend on it, and `form`
/// describes an operand that is neither, for the diagnostic.
pub(crate) struct AsmOperandResolver<'a> {
    pub(crate) const_of: &'a dyn Fn(u8) -> Option<i64>,
    pub(crate) symbol_of: &'a dyn Fn(u8) -> Option<(AsmSectionTarget, i64)>,
    pub(crate) form: &'a dyn Fn(u8) -> alloc::string::String,
}

impl AsmOperandResolver<'static> {
    /// No operand context: file-scope asm and the validation passes.
    pub(crate) const NONE: Self = Self {
        const_of: &|_| None,
        symbol_of: &|_| None,
        form: &|_| alloc::string::String::from("not an operand of this statement"),
    };
}

/// Resolve an `i`-class operand's SSA value to a section field's relocation
/// target (`.long %c0 - .`) plus a base addend folded from a constant pointer
/// offset (`&key + branch`, the arm64 static branch). Returns `(target,
/// addend)`.
///
/// A local `.data` / `.bss` address (`Inst::ImmData` whose value-id names no
/// external symbol) relocates against the section symbol with the offset in
/// the target and a zero base addend. A cross-TU address (the same `ImmData`
/// whose value-id appears in `extern_imm_data_refs`, so `extern_name` yields
/// its symbol) relocates against that symbol, with any constant offset folded
/// into the addend the writer applies to the symbol -- a `.data + off`
/// relocation would name this unit's data image, not the referenced symbol.
///
/// A member / element subscript nests one constant `Add` per level
/// (`&global.field[const]` is `&global +i field_off +i elem_off`), so the base
/// and its total offset are folded through the whole constant-add chain.
pub(crate) fn asm_operand_data_target(
    func: &FunctionSsa,
    arg: u32,
    extern_name: &dyn Fn(u32) -> Option<alloc::string::String>,
) -> Option<(AsmSectionTarget, i64)> {
    let (base, off) = asm_operand_data_base(func, arg)?;
    Some(match extern_name(base) {
        Some(name) => (AsmSectionTarget::Symbol(name), off),
        None => (AsmSectionTarget::Data(off as u64), 0),
    })
}

/// Load width / signedness of an integer [`LoadKind`]; `None` for the FP kinds.
fn load_int_kind(kind: LoadKind) -> Option<(u8, bool)> {
    use LoadKind as K;
    Some(match kind {
        K::I8 => (1, true),
        K::U8 => (1, false),
        K::I16 => (2, true),
        K::U16 => (2, false),
        K::I32 => (4, true),
        K::U32 => (4, false),
        K::I64 => (8, true),
        K::F32 | K::F64 | K::F80 | K::F128 => return None,
    })
}

/// Width of an integer [`StoreKind`]; `None` for the FP kinds.
fn store_int_width(kind: StoreKind) -> Option<u8> {
    Some(match kind {
        StoreKind::I8 => 1,
        StoreKind::I16 => 2,
        StoreKind::I32 => 4,
        StoreKind::I64 => 8,
        StoreKind::F32 | StoreKind::F64 | StoreKind::F80 | StoreKind::F128 => return None,
    })
}

/// `c` truncated to `width` bytes, then sign- or zero-extended to 64 bits.
fn extend_to(c: i64, width: u8, signed: bool) -> i64 {
    if width >= 8 {
        return c;
    }
    let bits = width as u32 * 8;
    let m = (c as u64) & ((1u64 << bits) - 1);
    if signed && (m >> (bits - 1)) & 1 == 1 {
        (m | !((1u64 << bits) - 1)) as i64
    } else {
        m as i64
    }
}

/// What an operand's value folds to: an integer constant, or a C99 6.6p9
/// address constant as the value id of its `ImmData` / `ImmCode` base and
/// the constant byte offset added to it.
#[derive(Clone, Copy, PartialEq, Debug)]
enum Folded {
    Int(i64),
    Addr { base: u32, off: i64 },
}

/// The outcome of folding one value. `Cyclic` is a value whose own fold is
/// in progress further up the chain (a loop phi reached over its back edge,
/// a slot stored back to itself); every value such a cycle carries entered
/// it through some other input, so it contributes no candidate to a join.
enum Fold {
    Value(Folded),
    NotConstant,
    Cyclic,
}

/// Folds an operand's value through the shapes the optimizer leaves a
/// compile-time constant in: the constant itself, a copy or width
/// extension of one, constant address arithmetic, a phi whose inputs
/// agree, and a load of a slot mem2reg could not promote whose reaching
/// stores agree.
struct Folder<'a> {
    func: &'a FunctionSsa,
    /// Values whose fold is in progress, innermost last.
    active: alloc::vec::Vec<u32>,
    budget: u32,
}

impl<'a> Folder<'a> {
    fn new(func: &'a FunctionSsa) -> Self {
        Self {
            func,
            active: alloc::vec::Vec::new(),
            budget: FOLD_BUDGET,
        }
    }

    fn fold(&mut self, v: u32) -> Fold {
        if self.active.contains(&v) {
            return Fold::Cyclic;
        }
        if self.active.len() >= FOLD_DEPTH || self.budget == 0 {
            return Fold::NotConstant;
        }
        self.budget -= 1;
        self.active.push(v);
        let r = self.fold_value(v);
        self.active.pop();
        r
    }

    fn fold_value(&mut self, v: u32) -> Fold {
        match self.func.insts.get(v as usize) {
            Some(Inst::Imm(c)) => Fold::Value(Folded::Int(*c)),
            Some(Inst::ImmData(_) | Inst::ImmCode(_)) => {
                Fold::Value(Folded::Addr { base: v, off: 0 })
            }
            Some(Inst::Copy { value, .. }) => self.fold(*value),
            Some(Inst::Extend { value, kind }) => {
                let Some((w, signed)) = load_int_kind(*kind) else {
                    return Fold::NotConstant;
                };
                match self.fold(*value) {
                    Fold::Value(Folded::Int(c)) => {
                        Fold::Value(Folded::Int(extend_to(c, w, signed)))
                    }
                    // A full-width extension is the identity; a narrower
                    // one truncates an address to something else.
                    r @ (Fold::Value(Folded::Addr { .. }) | Fold::Cyclic) if w >= 8 => r,
                    _ => Fold::NotConstant,
                }
            }
            Some(Inst::BinopI { op, lhs, rhs_imm }) => match self.fold(*lhs) {
                Fold::Value(l) => Self::binop(*op, l, Folded::Int(*rhs_imm)),
                _ => Fold::NotConstant,
            },
            Some(Inst::Binop { op, lhs, rhs }) => match (self.fold(*lhs), self.fold(*rhs)) {
                (Fold::Value(l), Fold::Value(r)) => Self::binop(*op, l, r),
                _ => Fold::NotConstant,
            },
            Some(Inst::Phi { incoming, .. }) => {
                let inputs: alloc::vec::Vec<u32> = incoming.iter().map(|&(_, v)| v).collect();
                self.join(&inputs, Some)
            }
            Some(&Inst::LoadLocal {
                off,
                kind,
                volatile: false,
            }) => {
                let Some((lw, signed)) = load_int_kind(kind) else {
                    return Fold::NotConstant;
                };
                let Some(stores) = reaching_local_stores(self.func, v, off, lw) else {
                    return Fold::NotConstant;
                };
                // The load reads what the store's width kept; an address
                // survives only a full-width store.
                self.join(&stores, |f| match f {
                    Folded::Int(c) => Some(Folded::Int(extend_to(c, lw, signed))),
                    Folded::Addr { .. } if lw >= 8 => Some(f),
                    Folded::Addr { .. } => None,
                })
            }
            _ => Fold::NotConstant,
        }
    }

    /// The one value every input folds to, each seen through `narrow`.
    fn join(&mut self, inputs: &[u32], narrow: impl Fn(Folded) -> Option<Folded>) -> Fold {
        let mut out: Option<Folded> = None;
        for &v in inputs {
            let f = match self.fold(v) {
                Fold::Cyclic => continue,
                Fold::NotConstant => return Fold::NotConstant,
                Fold::Value(f) => f,
            };
            let Some(f) = narrow(f) else {
                return Fold::NotConstant;
            };
            match out {
                None => out = Some(f),
                Some(p) if p == f => {}
                Some(_) => return Fold::NotConstant,
            }
        }
        out.map_or(Fold::NotConstant, Fold::Value)
    }

    /// Integer arithmetic on two constants, or a constant offset added to
    /// an address (`&global.field[const]` nests one add per level).
    fn binop(op: BinOp, l: Folded, r: Folded) -> Fold {
        let v = match (op, l, r) {
            (_, Folded::Int(a), Folded::Int(b)) => {
                crate::c5::vm::eval::fold_binop(op, a, b).map(Folded::Int)
            }
            (BinOp::Add, Folded::Addr { base, off }, Folded::Int(c))
            | (BinOp::Add, Folded::Int(c), Folded::Addr { base, off }) => {
                off.checked_add(c).map(|off| Folded::Addr { base, off })
            }
            (BinOp::Sub, Folded::Addr { base, off }, Folded::Int(c)) => {
                off.checked_sub(c).map(|off| Folded::Addr { base, off })
            }
            _ => None,
        };
        v.map_or(Fold::NotConstant, Fold::Value)
    }
}

/// The constant of an `i`-class inline-asm operand, reached through the
/// shapes [`Folder`] folds; `None` for a non-constant operand, which is
/// refused as GNU as refuses it.
pub(crate) fn asm_operand_const(func: &FunctionSsa, arg: u32) -> Option<i64> {
    match Folder::new(func).fold(arg) {
        Fold::Value(Folded::Int(c)) => Some(c),
        _ => None,
    }
}

/// The value ids of the `StoreLocal`s a `LoadLocal` of slot `off` (`lw`
/// bytes wide, at value id `load`) reads: on every path from the load, a
/// store of that width to the slot precedes any write that may reach the
/// slot ([`may_write_slot`]). `None` when a path reaches the entry without
/// one (C99 6.2.4: an indeterminate value) or such a write intervenes. Each
/// block is scanned once: the load's own over its prefix first, then in
/// full if a back edge re-enters it.
fn reaching_local_stores(
    func: &FunctionSsa,
    load: u32,
    off: i64,
    lw: u8,
) -> Option<alloc::vec::Vec<u32>> {
    let exposed = slot_exposed(func, off);
    let preds = mem2reg::predecessors(func);
    // Blocks reachable from the entry: a dead predecessor (an eliminated
    // `do {} while (0)` latch is one) never executes, so its edge carries no
    // runtime value and must not be searched.
    let reachable = {
        let mut seen = alloc::vec![false; func.blocks.len()];
        let mut stack = alloc::vec![0usize];
        if let Some(s) = seen.get_mut(0) {
            *s = true;
        }
        while let Some(b) = stack.pop() {
            for s in mem2reg::successors(
                &func.blocks[b].terminator,
                &func.computed_goto_targets,
                &func.jump_tables,
            ) {
                if !core::mem::replace(&mut seen[s as usize], true) {
                    stack.push(s as usize);
                }
            }
        }
        seen
    };
    let lb = func
        .blocks
        .iter()
        .position(|b| b.inst_range.contains(&load))?;
    let mut out = alloc::vec::Vec::new();
    let mut visited = alloc::vec![false; func.blocks.len()];
    let mut work: alloc::vec::Vec<(usize, u32)> = alloc::vec![(lb, load)];
    let mut first = true;
    while let Some((b, upper)) = work.pop() {
        if !first {
            if visited[b] {
                continue;
            }
            visited[b] = true;
        }
        first = false;
        let start = func.blocks[b].inst_range.start;
        let mut i = upper;
        let mut found = false;
        while i > start {
            i -= 1;
            match &func.insts[i as usize] {
                Inst::StoreLocal {
                    off: o,
                    value,
                    kind,
                    volatile,
                } if *o == off => {
                    if *volatile || store_int_width(*kind) != Some(lw) {
                        return None;
                    }
                    out.push(*value);
                    found = true;
                    break;
                }
                Inst::LoadLocal {
                    off: o,
                    volatile: true,
                    ..
                } if *o == off => return None,
                inst => {
                    if may_write_slot(func, inst, off, exposed) {
                        return None;
                    }
                }
            }
        }
        if found {
            continue;
        }
        let live: alloc::vec::Vec<crate::c5::ir::BlockId> = preds[b]
            .iter()
            .copied()
            .filter(|&p| reachable[p as usize])
            .collect();
        if live.is_empty() {
            return None;
        }
        for p in live {
            work.push((p as usize, func.blocks[p as usize].inst_range.end));
        }
    }
    Some(out)
}

/// Whether `inst` may write slot `off`. An exposed slot ([`slot_exposed`])
/// may be written by anything that can hold a pointer -- a call, an
/// intrinsic, a memory-clobbering or output-writing asm, an atomic, a
/// store through a pointer, a block copy, a segment store -- and a re-take
/// of its address is a further such flow. An unexposed one is written only
/// through its own address, so only an access naming that address counts;
/// the parser hands one slot to lexically disjoint variables, and a pointer
/// to the other variable is dead once its scope closes (C99 6.2.4p2).
fn may_write_slot(func: &FunctionSsa, inst: &Inst, off: i64, exposed: bool) -> bool {
    let names_slot =
        |v: u32| matches!(func.insts.get(v as usize), Some(Inst::LocalAddr(o)) if *o == off);
    match inst {
        Inst::LocalAddr(o) => exposed && *o == off,
        Inst::Store { addr, .. } => exposed || names_slot(*addr),
        Inst::StoreIndexed { base, .. } => exposed || names_slot(*base),
        Inst::Mcpy { dst, .. } => exposed || names_slot(*dst),
        Inst::AtomicRmw { addr, .. } => exposed || names_slot(*addr),
        Inst::AtomicCas {
            addr,
            expected_addr,
            ..
        } => exposed || names_slot(*addr) || names_slot(*expected_addr),
        Inst::InlineAsm { asm, args } => {
            // An asm that neither clobbers memory nor writes an output
            // operand writes nothing.
            (asm.clobber_memory || asm.operands.iter().any(|o| o.is_output))
                && (exposed || args.iter().any(|&a| names_slot(a)))
        }
        Inst::Call { .. }
        | Inst::CallExt { .. }
        | Inst::CallIndirect { .. }
        | Inst::Intrinsic { .. }
        | Inst::SegStore { .. } => exposed,
        _ => false,
    }
}

/// Whether slot `off`'s address flows anywhere other than an access of the
/// slot itself: a load, store, block copy or atomic through it, or an asm
/// operand the statement writes (an output) or accesses in place (`m`).
/// Any other flow -- a call argument, a stored pointer, arithmetic, a phi,
/// an asm input register, a terminator -- may retain the address, and a
/// later write through it is not visible as an access of the slot.
fn slot_exposed(func: &FunctionSsa, off: i64) -> bool {
    let names_slot =
        |v: u32| matches!(func.insts.get(v as usize), Some(Inst::LocalAddr(o)) if *o == off);
    let accesses = |inst: &Inst, v: u32| -> bool {
        match inst {
            Inst::Load { addr, .. } => *addr == v,
            Inst::Store { addr, value, .. } => *addr == v && *value != v,
            Inst::LoadIndexed { base, index, .. } => *base == v && *index != v,
            Inst::StoreIndexed {
                base, index, value, ..
            } => *base == v && *index != v && *value != v,
            Inst::Mcpy { .. } => true,
            Inst::AtomicRmw { addr, value, .. } => *addr == v && *value != v,
            Inst::AtomicCas {
                addr,
                expected_addr,
                desired,
                ..
            } => (*addr == v || *expected_addr == v) && *desired != v,
            Inst::InlineAsm { asm, args } => {
                args.len() == asm.operands.len()
                    && args.iter().zip(&asm.operands).all(|(&a, o)| {
                        a != v || o.is_output || matches!(o.constraint, AsmConstraint::Mem)
                    })
            }
            _ => false,
        }
    };
    for blk in &func.blocks {
        let mut flows = false;
        for i in blk.inst_range.clone() {
            let inst = &func.insts[i as usize];
            inst.for_each_operand(|v| flows |= names_slot(v) && !accesses(inst, v));
        }
        blk.terminator.for_each_operand(|v| flows |= names_slot(v));
        if flows {
            return true;
        }
    }
    false
}

/// Fold a C99 6.6p9 address constant to the value-id naming its object or
/// function and the constant byte offset added to it (`&global`,
/// `&global.field`, `&global.field[const]`, and the same held in a local the
/// optimizer left in its slot). Returns `None` for a non-constant or
/// non-address shape.
///
/// A cast between object-pointer and integer types of the same width leaves
/// no instruction of its own, so a cast chain reaches this walk as its base
/// alone. A cast that narrows lowers to a mask or an `Extend`, neither of
/// which the walk crosses -- the truncated value is not the address. The
/// base's own payload stays with the caller: `ImmData` carries a data-byte
/// offset, `ImmCode` an entry PC.
fn asm_operand_addr_base(func: &FunctionSsa, arg: u32) -> Option<(u32, i64)> {
    match Folder::new(func).fold(arg) {
        Fold::Value(Folded::Addr { base, off }) => Some((base, off)),
        _ => None,
    }
}

/// [`asm_operand_addr_base`] restricted to a data object: the base `ImmData`
/// value-id and the total byte offset, the object's own offset included.
fn asm_operand_data_base(func: &FunctionSsa, arg: u32) -> Option<(u32, i64)> {
    let (vid, off) = asm_operand_addr_base(func, arg)?;
    match func.insts.get(vid as usize)? {
        Inst::ImmData(o) => Some((vid, off + *o)),
        _ => None,
    }
}

/// [`asm_operand_addr_base`] restricted to a function: the base `ImmCode`
/// value-id, the function's entry PC, and the byte offset added to it.
pub(crate) fn asm_operand_code_base(func: &FunctionSsa, arg: u32) -> Option<(u32, usize, i64)> {
    let (vid, off) = asm_operand_addr_base(func, arg)?;
    match func.insts.get(vid as usize)? {
        Inst::ImmCode(pc) => Some((vid, *pc, off)),
        _ => None,
    }
}

/// The form of an operand's value, for the diagnostic on one that resolves
/// to neither a constant nor a link-time address: what it is, so the
/// message does not only say what it is not.
pub(crate) fn asm_operand_form(func: &FunctionSsa, arg: u32) -> alloc::string::String {
    let mut v = arg;
    for _ in 0..FOLD_DEPTH {
        let form = match func.insts.get(v as usize) {
            None => "an undefined value",
            Some(Inst::Copy { value, .. } | Inst::Extend { value, .. }) => {
                v = *value;
                continue;
            }
            Some(Inst::Imm(_)) => "an integer constant",
            Some(Inst::ImmData(_) | Inst::ImmCode(_) | Inst::ImmExtCode(_) | Inst::TlsAddr(_)) => {
                "an address constant"
            }
            Some(Inst::BlockAddr(_)) => "a label address",
            Some(Inst::LocalAddr(_)) => "the address of a local variable",
            Some(Inst::LoadLocal { .. }) => "a local variable no single constant store defines",
            Some(Inst::Load { .. } | Inst::LoadIndexed { .. } | Inst::SegLoad { .. }) => {
                "a memory load"
            }
            Some(
                Inst::Store { .. }
                | Inst::StoreLocal { .. }
                | Inst::StoreIndexed { .. }
                | Inst::SegStore { .. },
            ) => "a stored value",
            Some(Inst::Binop { .. } | Inst::BinopI { .. } | Inst::Bswap { .. }) => {
                "an arithmetic result"
            }
            Some(Inst::Fneg(_) | Inst::Fma { .. } | Inst::MulAdd { .. } | Inst::FpCast { .. }) => {
                "a floating-point result"
            }
            Some(
                Inst::Call { .. }
                | Inst::CallExt { .. }
                | Inst::CallIndirect { .. }
                | Inst::TailExt(_),
            ) => "a call result",
            Some(Inst::Intrinsic { .. }) => "an intrinsic result",
            Some(Inst::X86Simd { .. }) => "a vector result",
            Some(Inst::AtomicRmw { .. } | Inst::AtomicCas { .. }) => "an atomic result",
            Some(Inst::Mcpy { .. }) => "a block copy",
            Some(Inst::InlineAsm { .. }) => "an asm statement",
            Some(Inst::AllocaInit(_)) => "an alloca marker",
            Some(Inst::ParamRef { .. }) => "a function parameter",
            Some(Inst::Phi { incoming, .. }) => {
                return alloc::format!("a join of {} control-flow paths", incoming.len());
            }
        };
        return alloc::string::String::from(form);
    }
    alloc::string::String::from("a value past the fold depth")
}

#[cfg(test)]
mod tests {
    use super::{asm_operand_code_base, asm_operand_const, asm_operand_data_target};
    use crate::c5::asm::AsmSectionTarget;
    use crate::c5::ir::{
        AsmBlock, AsmConstraint, AsmOperand, AsmSeg, BinOp, Block, FunctionSsa, Inst, LoadKind,
        StoreKind, Terminator,
    };

    fn add(lhs: u32, rhs_imm: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
        }
    }

    /// A single-block function over `insts`, returning its last value.
    fn one_block(insts: alloc::vec::Vec<Inst>) -> FunctionSsa {
        let n = insts.len() as u32;
        FunctionSsa {
            inst_src: alloc::vec![(0, 0); n as usize],
            f32_values: alloc::vec![false; n as usize],
            blocks: alloc::vec![Block {
                start_pc: 0,
                inst_range: 0..n,
                terminator: Terminator::Return(n - 1),
                exit_acc: n - 1,
            }],
            insts,
            ..Default::default()
        }
    }

    fn store(off: i64, value: u32) -> Inst {
        Inst::StoreLocal {
            off,
            value,
            kind: StoreKind::I32,
            volatile: false,
        }
    }

    fn load(off: i64) -> Inst {
        Inst::LoadLocal {
            off,
            kind: LoadKind::I32,
            volatile: false,
        }
    }

    fn call() -> Inst {
        Inst::Call {
            target_pc: 7,
            args: alloc::vec::Vec::new(),
            fixed_args: 0,
            fp_return: false,
            fp_arg_mask: 0,
            arg_aggs: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_slot_local: 0,
        }
    }

    /// An asm statement with one operand of the given class over `arg`.
    fn asm_with(arg: u32, is_output: bool, constraint: AsmConstraint) -> Inst {
        Inst::InlineAsm {
            asm: alloc::boxed::Box::new(AsmBlock {
                template: b"".to_vec(),
                operands: alloc::vec![AsmOperand {
                    constraint,
                    is_output,
                    is_rw: false,
                    width: 8,
                    seg: AsmSeg::None,
                }],
                clobber_regs: 0,
                clobber_fp_regs: 0,
                clobber_memory: false,
                volatile: true,
            }),
            args: alloc::vec![arg],
        }
    }

    /// An address operand's constant-add chain reaches a definition whose id
    /// may be above the use's: `ssa::licm` leaves that shape when it hoists a
    /// materialization into a dominating block whose instruction range sits
    /// later in the tape. A walk that stops at a rising id reports a
    /// link-time address as naming none, and the section field referencing it
    /// (`.quad %c0 + %c1 - .`, the static-key jump entry) is rejected.
    #[test]
    fn address_operand_resolves_through_a_forward_reference() {
        let fwd = one_block(alloc::vec![add(1, 8), Inst::ImmData(64)]);
        let back = one_block(alloc::vec![Inst::ImmData(64), add(0, 8)]);
        for (func, arg) in [(&fwd, 0u32), (&back, 1)] {
            assert_eq!(
                asm_operand_data_target(func, arg, &|_| None),
                Some((AsmSectionTarget::Data(72), 0))
            );
        }
        // The same for a cross-TU base, whose offset rides the addend, and
        // for a function address.
        let name = |_| Some(alloc::string::String::from("extkey"));
        assert_eq!(
            asm_operand_data_target(&fwd, 0, &name),
            Some((
                AsmSectionTarget::Symbol(alloc::string::String::from("extkey")),
                72
            ))
        );
        let code = one_block(alloc::vec![add(1, 4), Inst::ImmCode(900)]);
        assert_eq!(asm_operand_code_base(&code, 0), Some((1, 900, 4)));
    }

    /// A chain that closes on itself is malformed IR; the walk must end
    /// rather than run on it.
    #[test]
    fn cyclic_address_chain_terminates() {
        let func = one_block(alloc::vec![add(1, 8), add(0, 8)]);
        assert_eq!(asm_operand_data_target(&func, 0, &|_| None), None);
    }

    /// A slot whose address flows only into an asm output (the statement
    /// stores the result through it) is written by nothing else, so a call
    /// between the constant store and the load does not unsettle the value.
    /// The parser hands a scope-closed variable's slot to the next scope's,
    /// so this is the shape of a constant local following an asm output.
    #[test]
    fn constant_survives_a_call_when_the_slot_is_unexposed() {
        let body = |mid: Inst| {
            one_block(alloc::vec![
                Inst::LocalAddr(-1),
                asm_with(0, true, AsmConstraint::Reg),
                Inst::Imm(2323),
                store(-1, 2),
                mid,
                load(-1),
            ])
        };
        assert_eq!(asm_operand_const(&body(call()), 5), Some(2323));
        // An asm with a memory clobber and no operand naming the slot
        // cannot reach it either.
        let mut clobbering = asm_with(0, false, AsmConstraint::Reg);
        if let Inst::InlineAsm { asm, args } = &mut clobbering {
            asm.clobber_memory = true;
            args.clear();
            asm.operands.clear();
        }
        assert_eq!(asm_operand_const(&body(clobbering), 5), Some(2323));
        // A store through the slot's own address between them does.
        let through = Inst::Store {
            addr: 0,
            disp: 0,
            value: 2,
            kind: StoreKind::I32,
            volatile: false,
            align: 4,
        };
        assert_eq!(asm_operand_const(&body(through), 5), None);
    }

    /// Once the address reaches something that can hold a pointer -- a call
    /// argument, an asm input register -- a later call may write the slot,
    /// and the load is not the constant.
    #[test]
    fn exposed_slot_is_unsettled_by_a_call() {
        let mut passed = call();
        if let Inst::Call { args, .. } = &mut passed {
            args.push(0);
        }
        for escape in [passed, asm_with(0, false, AsmConstraint::Reg)] {
            let func = one_block(alloc::vec![
                Inst::LocalAddr(-1),
                escape,
                Inst::Imm(5),
                store(-1, 2),
                call(),
                load(-1),
            ]);
            assert_eq!(asm_operand_const(&func, 5), None);
        }
    }

    /// An address constant held in an unpromoted slot, and a phi whose
    /// inputs agree, fold like the direct forms; a phi whose inputs differ
    /// does not.
    #[test]
    fn constants_fold_through_slots_and_phis() {
        let held = one_block(alloc::vec![
            Inst::ImmData(64),
            add(0, 8),
            Inst::StoreLocal {
                off: -1,
                value: 1,
                kind: StoreKind::I64,
                volatile: false,
            },
            call(),
            Inst::LoadLocal {
                off: -1,
                kind: LoadKind::I64,
                volatile: false,
            },
        ]);
        assert_eq!(
            asm_operand_data_target(&held, 4, &|_| None),
            Some((AsmSectionTarget::Data(72), 0))
        );
        let phi = |b: i64| {
            one_block(alloc::vec![
                Inst::Imm(9),
                Inst::Imm(b),
                Inst::Phi {
                    incoming: alloc::vec![(0, 0), (1, 1), (2, 2)],
                    kind: LoadKind::I64,
                },
            ])
        };
        assert_eq!(asm_operand_const(&phi(9), 2), Some(9));
        assert_eq!(asm_operand_const(&phi(8), 2), None);
    }
}
