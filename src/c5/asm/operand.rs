//! What an extended inline-asm operand reference resolves to when the
//! SSA feeding it is known: a constant for an `i` or `n` operand, the
//! data or code symbol an address operand names, and the offset from it.

use super::*;
use crate::c5::codegen::ssa::mem2reg;

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
    insts: &[crate::c5::ir::Inst],
    arg: u32,
    extern_name: &dyn Fn(u32) -> Option<alloc::string::String>,
) -> Option<(AsmSectionTarget, i64)> {
    let (base, off) = asm_operand_data_base(insts, arg)?;
    Some(match extern_name(base) {
        Some(name) => (AsmSectionTarget::Symbol(name), off),
        None => (AsmSectionTarget::Data(off as u64), 0),
    })
}

/// Load width / signedness of an integer [`LoadKind`]; `None` for the FP kinds.
fn load_int_kind(kind: crate::c5::ir::LoadKind) -> Option<(u8, bool)> {
    use crate::c5::ir::LoadKind as K;
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

/// Recover the constant of an `i`-class inline-asm operand that survived as a
/// load of a constant local. C99 6.5p6 requires an `"i"` operand to be an
/// integer constant expression; a function opted out of slot promotion (a
/// computed goto leaves `mem2reg` unable to number the CFG, so it promotes
/// nothing) keeps that constant as a `StoreLocal`(constant) + `LoadLocal` pair,
/// which GNU as still folds. Recover it through the load and any width
/// extension. Returns `None` for a genuinely non-constant operand (rejected as
/// GNU as does).
pub(crate) fn asm_operand_local_const(func: &crate::c5::ir::FunctionSsa, arg: u32) -> Option<i64> {
    asm_operand_const_rec(func, arg, 0)
}

fn asm_operand_const_rec(func: &crate::c5::ir::FunctionSsa, arg: u32, depth: u32) -> Option<i64> {
    use crate::c5::ir::{Inst, StoreKind};
    if depth > 8 {
        return None;
    }
    match func.insts.get(arg as usize)? {
        Inst::Imm(v) => Some(*v),
        Inst::Extend { value, kind } => {
            let (w, signed) = load_int_kind(*kind)?;
            Some(extend_to(
                asm_operand_const_rec(func, *value, depth + 1)?,
                w,
                signed,
            ))
        }
        &Inst::LoadLocal {
            off,
            kind,
            volatile: false,
        } => {
            // Reaching-definition search backward over the CFG. Every path from
            // the load must reach a store of the same constant of the load's
            // width before any invalidator, so the value read is that constant.
            // A frame-packed slot (reused for a disjoint-lifetime, address-taken
            // variable) is handled correctly because the reaching store, not the
            // whole slot, decides the value; a dead `do {} while (0)` back edge
            // is followed through and finds no further store. Invalidators are a
            // write that may alias the slot once its address has escaped (a
            // call, a memory-clobbering asm, an atomic, a pointer store), a
            // re-address, or a volatile access. Each block is scanned once (the
            // load's own block first over its prefix, then in full if a back
            // edge re-enters it).
            let (lw, signed) = load_int_kind(kind)?;
            let preds = mem2reg::predecessors(func);
            // Blocks reachable from the entry: a dead predecessor (an
            // eliminated `do {} while (0)` latch is one) never executes, so its
            // edge carries no runtime value and must not be searched.
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
                .position(|b| b.inst_range.contains(&arg))?;
            let mut result: Option<i64> = None;
            let mut visited = alloc::vec![false; func.blocks.len()];
            let mut work: alloc::vec::Vec<(usize, u32)> = alloc::vec![(lb, arg)];
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
                            kind: sk,
                            volatile,
                        } if *o == off => {
                            if *volatile {
                                return None;
                            }
                            let sw = match sk {
                                StoreKind::I8 => 1u8,
                                StoreKind::I16 => 2,
                                StoreKind::I32 => 4,
                                StoreKind::I64 => 8,
                                StoreKind::F32
                                | StoreKind::F64
                                | StoreKind::F80
                                | StoreKind::F128 => return None,
                            };
                            if sw != lw {
                                return None;
                            }
                            let c = extend_to(
                                asm_operand_const_rec(func, *value, depth + 1)?,
                                lw,
                                signed,
                            );
                            match result {
                                None => result = Some(c),
                                Some(p) if p == c => {}
                                _ => return None,
                            }
                            found = true;
                            break;
                        }
                        Inst::LocalAddr(o) if *o == off => return None,
                        Inst::LoadLocal {
                            off: o,
                            volatile: true,
                            ..
                        } if *o == off => return None,
                        bar @ (Inst::InlineAsm { .. }
                        | Inst::Call { .. }
                        | Inst::CallExt { .. }
                        | Inst::CallIndirect { .. }
                        | Inst::Intrinsic { .. }
                        | Inst::AtomicRmw { .. }
                        | Inst::AtomicCas { .. }
                        | Inst::Store { .. }
                        | Inst::StoreIndexed { .. }
                        | Inst::SegStore { .. }
                        | Inst::Mcpy { .. }) => {
                            // An asm that neither clobbers memory nor writes an
                            // output operand cannot reach the escaped slot.
                            if let Inst::InlineAsm { asm, .. } = bar
                                && !asm.clobber_memory
                                && !asm.operands.iter().any(|o| o.is_output)
                            {
                                continue;
                            }
                            return None;
                        }
                        _ => {}
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
            result
        }
        _ => None,
    }
}

/// Fold a C99 6.6p9 address constant to the value-id naming its object or
/// function and the constant byte offset added to it, walking a chain of
/// constant `Add`s (`&global`, `&global.field`, `&global.field[const]`).
/// Returns `None` for a non-constant or non-address shape.
///
/// A cast between object-pointer and integer types of the same width leaves
/// no instruction of its own, so a cast chain reaches this walk as its base
/// alone. A cast that narrows lowers to a mask or an `Extend`, neither of
/// which the walk crosses -- the truncated value is not the address.
///
/// A value id is not a program-order index -- a block's instruction range is
/// not ordered by block id -- so a definition can carry a higher id than its
/// use. The walk steps at most once per instruction, which bounds any acyclic
/// chain and stops a malformed cyclic one. The base's own payload stays with
/// the caller: `ImmData` carries a data-byte offset, `ImmCode` an entry PC.
fn asm_operand_addr_base(insts: &[crate::c5::ir::Inst], arg: u32) -> Option<(u32, i64)> {
    use crate::c5::ir::{BinOp, Inst};
    let (mut vid, mut off) = (arg, 0i64);
    for _ in 0..insts.len() {
        let (next, add) = match insts.get(vid as usize)? {
            Inst::ImmData(_) | Inst::ImmCode(_) => return Some((vid, off)),
            Inst::BinopI {
                op: BinOp::Add,
                lhs,
                rhs_imm,
            } => (*lhs, *rhs_imm),
            Inst::Binop {
                op: BinOp::Add,
                lhs,
                rhs,
            } => match (insts.get(*lhs as usize), insts.get(*rhs as usize)) {
                (_, Some(Inst::Imm(c))) => (*lhs, *c),
                (Some(Inst::Imm(c)), _) => (*rhs, *c),
                _ => return None,
            },
            _ => return None,
        };
        off = off.checked_add(add)?;
        vid = next;
    }
    None
}

/// [`asm_operand_addr_base`] restricted to a data object: the base `ImmData`
/// value-id and the total byte offset, the object's own offset included.
fn asm_operand_data_base(insts: &[crate::c5::ir::Inst], arg: u32) -> Option<(u32, i64)> {
    let (vid, off) = asm_operand_addr_base(insts, arg)?;
    match insts.get(vid as usize)? {
        crate::c5::ir::Inst::ImmData(o) => Some((vid, off + *o)),
        _ => None,
    }
}

/// [`asm_operand_addr_base`] restricted to a function: the base `ImmCode`
/// value-id, the function's entry PC, and the byte offset added to it.
pub(crate) fn asm_operand_code_base(
    insts: &[crate::c5::ir::Inst],
    arg: u32,
) -> Option<(u32, usize, i64)> {
    let (vid, off) = asm_operand_addr_base(insts, arg)?;
    match insts.get(vid as usize)? {
        crate::c5::ir::Inst::ImmCode(pc) => Some((vid, *pc, off)),
        _ => None,
    }
}

#[cfg(test)]
mod tests {
    use super::{asm_operand_code_base, asm_operand_data_target};
    use crate::c5::asm::AsmSectionTarget;
    use crate::c5::ir::{BinOp, Inst};

    fn add(lhs: u32, rhs_imm: i64) -> Inst {
        Inst::BinopI {
            op: BinOp::Add,
            lhs,
            rhs_imm,
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
        let fwd = alloc::vec![add(1, 8), Inst::ImmData(64)];
        let back = alloc::vec![Inst::ImmData(64), add(0, 8)];
        for (insts, arg) in [(&fwd, 0u32), (&back, 1)] {
            assert_eq!(
                asm_operand_data_target(insts, arg, &|_| None),
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
        let code = alloc::vec![add(1, 4), Inst::ImmCode(900)];
        assert_eq!(asm_operand_code_base(&code, 0), Some((1, 900, 4)));
    }

    /// A chain that closes on itself is malformed IR; the walk must end
    /// rather than run on it.
    #[test]
    fn cyclic_address_chain_terminates() {
        let insts = alloc::vec![add(1, 8), add(0, 8)];
        assert_eq!(asm_operand_data_target(&insts, 0, &|_| None), None);
    }
}
