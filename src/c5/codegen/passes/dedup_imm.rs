//! Cross-block dedup for `Inst::ImmData(k)` and `Inst::ImmCode(t)`.
//! Both materialise an address that depends only on the writer's
//! data/code layout, so any two occurrences of the same key are the
//! same value. The walker's per-block CSE cache resets at block
//! boundaries; this pass picks up the cross-block duplicates the
//! cache misses.
//!
//! Dominance: the entry block dominates every other block, so
//! replacing a non-entry-block occurrence's consumers with the
//! entry-block canonical preserves SSA. The pass is conservative:
//! it does not hoist into the entry block. If the entry block has
//! no `ImmData(k)` of its own, later occurrences of that key stay
//! untouched.
//!
//! Dead duplicates are removed by the per-arch emit's `is_dead_pure`
//! skip; the pass does not touch the inst tape.

use crate::c5::ir::{FunctionSsa, Inst, NO_VALUE, Terminator, ValueId};
use alloc::vec::Vec;
use hashbrown::HashMap;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for func in funcs {
        run_one(func);
    }
}

fn run_one(func: &mut FunctionSsa) {
    let n = func.insts.len();
    if func.blocks.is_empty() || n == 0 {
        return;
    }
    let entry_range = func.blocks[0].inst_range.clone();
    // An `ImmData(k)` / `ImmCode(t)` / `TlsAddr(off)` that binds to a
    // cross-TU symbol (recorded in the extern-ref tables) materialises
    // that symbol's address, not a writer-layout address; two such with
    // a matching inst key but different symbols are different values.
    // Fold the bound symbol into the dedup key (u32::MAX = no binding).
    let collect_sym = |refs: &[(u32, u32)]| -> HashMap<u32, u32> { refs.iter().copied().collect() };
    let data_sym = collect_sym(&func.extern_imm_data_refs);
    let code_sym = collect_sym(&func.extern_imm_code_refs);
    let tls_sym = collect_sym(&func.extern_tls_refs);
    let mut canonical_data: HashMap<(i64, u32), ValueId> = HashMap::new();
    let mut canonical_code: HashMap<(usize, u32), ValueId> = HashMap::new();
    let mut canonical_tls: HashMap<(i64, u32), ValueId> = HashMap::new();
    for idx in entry_range.clone() {
        let i = idx as usize;
        if i >= func.insts.len() {
            break;
        }
        let sym = |m: &HashMap<u32, u32>| m.get(&(idx)).copied().unwrap_or(u32::MAX);
        match &func.insts[i] {
            Inst::ImmData(k) => {
                canonical_data.entry((*k, sym(&data_sym))).or_insert(idx);
            }
            Inst::ImmCode(t) => {
                canonical_code.entry((*t, sym(&code_sym))).or_insert(idx);
            }
            Inst::TlsAddr(off) => {
                canonical_tls.entry((*off, sym(&tls_sym))).or_insert(idx);
            }
            _ => {}
        }
    }
    if canonical_data.is_empty() && canonical_code.is_empty() && canonical_tls.is_empty() {
        return;
    }
    let mut redirect: Vec<Option<ValueId>> = alloc::vec![None; n];
    let mut any = false;
    for (idx, inst) in func.insts.iter().enumerate() {
        if idx >= entry_range.end as usize {
            // Non-entry block.
            let sym = |m: &HashMap<u32, u32>| m.get(&(idx as u32)).copied().unwrap_or(u32::MAX);
            match inst {
                Inst::ImmData(k) => {
                    if let Some(&canon) = canonical_data.get(&(*k, sym(&data_sym)))
                        && canon != idx as ValueId
                    {
                        redirect[idx] = Some(canon);
                        any = true;
                    }
                }
                Inst::ImmCode(t) => {
                    if let Some(&canon) = canonical_code.get(&(*t, sym(&code_sym)))
                        && canon != idx as ValueId
                    {
                        redirect[idx] = Some(canon);
                        any = true;
                    }
                }
                Inst::TlsAddr(off) => {
                    if let Some(&canon) = canonical_tls.get(&(*off, sym(&tls_sym)))
                        && canon != idx as ValueId
                    {
                        redirect[idx] = Some(canon);
                        any = true;
                    }
                }
                _ => {}
            }
        }
    }
    if !any {
        return;
    }
    fn resolve(redirect: &[Option<ValueId>], mut v: ValueId) -> ValueId {
        let mut guard = 0u32;
        while v != NO_VALUE && (v as usize) < redirect.len() {
            match redirect[v as usize] {
                Some(t) if t != v => {
                    v = t;
                    guard += 1;
                    if guard > redirect.len() as u32 {
                        break;
                    }
                }
                _ => break,
            }
        }
        v
    }
    for inst in func.insts.iter_mut() {
        if matches!(inst, Inst::ImmData(_) | Inst::ImmCode(_) | Inst::TlsAddr(_)) {
            continue;
        }
        for_each_operand_mut(inst, |op| *op = resolve(&redirect, *op));
    }
    for block in func.blocks.iter_mut() {
        if block.exit_acc != NO_VALUE {
            block.exit_acc = resolve(&redirect, block.exit_acc);
        }
        match &mut block.terminator {
            Terminator::Bz { cond, .. } | Terminator::Bnz { cond, .. } => {
                *cond = resolve(&redirect, *cond);
            }
            Terminator::Return(v) if *v != NO_VALUE => {
                *v = resolve(&redirect, *v);
            }
            Terminator::JumpTable { idx, .. } => {
                *idx = resolve(&redirect, *idx);
            }
            _ => {}
        }
    }
}

fn for_each_operand_mut(inst: &mut Inst, mut f: impl FnMut(&mut ValueId)) {
    match inst {
        Inst::Imm(_)
        | Inst::ImmData(_)
        | Inst::ImmCode(_)
        | Inst::ImmExtCode(_)
        | Inst::BlockAddr(_)
        | Inst::LocalAddr(_)
        | Inst::TlsAddr(_)
        | Inst::LoadLocal { .. }
        | Inst::TailExt(_)
        | Inst::AllocaInit(_)
        | Inst::ParamRef { .. } => {}
        Inst::Load { addr, .. } => f(addr),
        Inst::Store { addr, value, .. } => {
            f(addr);
            f(value);
        }
        Inst::StoreLocal { value, .. } => f(value),
        Inst::LoadIndexed { base, index, .. } => {
            f(base);
            f(index);
        }
        Inst::StoreIndexed {
            base, index, value, ..
        } => {
            f(base);
            f(index);
            f(value);
        }
        Inst::Binop { lhs, rhs, .. } => {
            f(lhs);
            f(rhs);
        }
        Inst::BinopI { lhs, .. } => f(lhs),
        Inst::Fneg(v) => f(v),
        Inst::Fma { a, b, c, .. } => {
            f(a);
            f(b);
            f(c);
        }
        Inst::Extend { value, .. } => f(value),
        Inst::FpCast { value, .. } => f(value),
        Inst::Call { args, .. }
        | Inst::CallExt { args, .. }
        | Inst::Intrinsic { args, .. }
        | Inst::InlineAsm { args, .. } => {
            for a in args {
                f(a);
            }
        }
        Inst::CallIndirect { target, args, .. } => {
            f(target);
            for a in args {
                f(a);
            }
        }
        Inst::Mcpy { dst, src, .. } => {
            f(dst);
            f(src);
        }
        Inst::AtomicRmw { addr, value, .. } => {
            f(addr);
            f(value);
        }
        Inst::AtomicCas {
            addr,
            expected_addr,
            desired,
            ..
        } => {
            f(addr);
            f(expected_addr);
            f(desired);
        }
        Inst::Phi { incoming, .. } => {
            for (_, v) in incoming {
                f(v);
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::run_one;
    use crate::c5::ir::{Block, FunctionSsa, Inst, LoadKind, NO_VALUE, Terminator};
    use alloc::vec::Vec;

    fn fresh(insts: Vec<Inst>, blocks: Vec<Block>) -> FunctionSsa {
        FunctionSsa {
            name: alloc::string::String::new(),
            ent_pc: 0,
            end_pc: 0,
            locals: 0,
            n_params: 0,
            is_variadic: false,
            is_inline: false,
            is_always_inline: false,
            is_naked: false,
            inst_src: alloc::vec![(0, 0); insts.len()],
            f32_values: alloc::vec![false; insts.len()],
            param_fp_mask: 0,
            agg_descs: alloc::vec::Vec::new(),
            param_aggs: alloc::vec::Vec::new(),
            param_local_slots: alloc::vec::Vec::new(),
            ret_agg: None,
            ret_is_fp: false,
            ret_type_tag: 0,
            indirect_result_slot: 0,
            computed_goto_targets: Vec::new(),
            jump_tables: Vec::new(),
            synthetic_base: 0,
            multi_cell_slots: Vec::new(),
            has_returns_twice_call: false,
            did_unroll: false,
            insts,
            blocks,
            extern_call_refs: Vec::new(),
            extern_imm_code_refs: Vec::new(),
            extern_imm_data_refs: Vec::new(),
            extern_tls_refs: Vec::new(),
        }
    }

    /// CFG:
    ///   b0: v0 = ImmData(7); v1 = Load(v0); Bz v1, b2, b1
    ///   b1: v2 = ImmData(7); v3 = Load(v2); Return(v3)   // duplicate ImmData
    ///   b2: Return(v0)
    ///
    /// b0 dominates b1, so the dedup pass must redirect v3's `addr` operand
    /// from v2 to v0. v2 then becomes dead (use_counts == 0).
    #[test]
    fn cross_block_immdata_dedup_redirects_consumers_to_entry_canonical() {
        let mut f = fresh(
            alloc::vec![
                Inst::ImmData(7),
                Inst::Load {
                    addr: 0,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                },
                Inst::ImmData(7),
                Inst::Load {
                    addr: 2,
                    disp: 0,
                    kind: LoadKind::I64,
                    volatile: false,
                },
            ],
            alloc::vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..2,
                    terminator: Terminator::Bz {
                        cond: 1,
                        target: 2,
                        fall_through: 1,
                    },
                    exit_acc: 1,
                },
                Block {
                    start_pc: 0,
                    inst_range: 2..4,
                    terminator: Terminator::Return(3),
                    exit_acc: 3,
                },
                Block {
                    start_pc: 0,
                    inst_range: 4..4,
                    terminator: Terminator::Return(0),
                    exit_acc: 0,
                },
            ],
        );
        run_one(&mut f);
        // v3's addr operand was v2 (the duplicate); after dedup it should be v0.
        let Inst::Load { addr, .. } = f.insts[3] else {
            panic!("expected Load at v3, got {:?}", f.insts[3]);
        };
        assert_eq!(
            addr, 0,
            "Load(v3)'s addr operand should redirect from v2 to the entry-block canonical v0",
        );
    }

    /// When the entry block has no `ImmData(K)` for a key that later blocks
    /// duplicate, the pass leaves the later occurrences alone (no
    /// dominance guarantee). Locks the conservatism in.
    #[test]
    fn no_entry_canonical_means_no_redirect() {
        let mut f = fresh(
            alloc::vec![
                // Entry block has no ImmData.
                Inst::Imm(0),
                // b1 and b2 both have ImmData(5) but neither dominates
                // the other.
                Inst::ImmData(5),
                Inst::ImmData(5),
            ],
            alloc::vec![
                Block {
                    start_pc: 0,
                    inst_range: 0..1,
                    terminator: Terminator::Bz {
                        cond: 0,
                        target: 2,
                        fall_through: 1,
                    },
                    exit_acc: 0,
                },
                Block {
                    start_pc: 0,
                    inst_range: 1..2,
                    terminator: Terminator::Return(1),
                    exit_acc: 1,
                },
                Block {
                    start_pc: 0,
                    inst_range: 2..3,
                    terminator: Terminator::Return(2),
                    exit_acc: 2,
                },
            ],
        );
        run_one(&mut f);
        // Both ImmData stay distinct; their Return values stay distinct.
        let returns: Vec<u32> = f
            .blocks
            .iter()
            .filter_map(|b| match b.terminator {
                Terminator::Return(v) if v != NO_VALUE => Some(v),
                _ => None,
            })
            .collect();
        assert_eq!(returns.len(), 2);
        assert_ne!(
            returns[0], returns[1],
            "without an entry-block canonical, v1 and v2 must stay distinct",
        );
    }
}
