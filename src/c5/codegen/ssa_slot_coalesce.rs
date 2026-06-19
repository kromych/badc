//! Synthetic stack-slot coalescing.
//!
//! The SSA builder reserves a fresh frame slot per synthetic temporary
//! (`alloc_synthetic_local`, the phi substitute at every control-flow merge)
//! and never reuses one, so a function with many merges -- a large `switch`,
//! say -- accumulates a frame far larger than its live slot count. A frame
//! whose per-call growth exceeds a caller's stack-overflow margin defeats any
//! recursion guard built on that margin.
//!
//! This pass reuses synthetic scalar slots whose live ranges do not overlap.
//! It runs before the optimization passes, so it sees the builder's raw slot
//! assignment, and it touches only the synthetic range (offset magnitude
//! greater than `synthetic_base`): the parser's declared locals, whose
//! per-local sizes are not represented in the SSA, keep their offsets. A slot
//! is a candidate only when every reference to it is a scalar `LoadLocal` /
//! `StoreLocal`; any slot whose address is taken (`LocalAddr`), that backs an
//! aggregate call result (`ret_slot_local`), that holds an `alloca` arena
//! (`AllocaInit`), or that is a cell of a synthetic aggregate
//! (`synthetic_struct_slots`) is reserved, so a reused scalar never lands on
//! storage an instruction reaches another way.
//!
//! TODO: apply the coalescing (remap the candidate slots to their colors and
//! compact the synthetic range). The analysis below computes the colouring;
//! the rewrite + `func.locals` recomputation is the remaining step.

use super::super::ir::{FunctionSsa, Inst};
use super::ssa_mem2reg::successors;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

pub(crate) fn run(funcs: &mut [FunctionSsa]) {
    for f in funcs.iter_mut() {
        coalesce(f);
    }
}

fn coalesce(f: &mut FunctionSsa) {
    let base = f.synthetic_base;
    let total = f.locals;
    if base <= 0 || total <= base {
        return;
    }

    // Reserved synthetic offsets: a reused scalar must avoid these.
    let mut reserved: BTreeSet<i64> = BTreeSet::new();
    for &(sbase, cells) in &f.synthetic_struct_slots {
        for k in 0..cells {
            reserved.insert(sbase + k);
        }
    }
    for inst in &f.insts {
        match inst {
            Inst::LocalAddr(off) => {
                reserved.insert(*off);
            }
            Inst::Call { ret_slot_local, .. } | Inst::CallIndirect { ret_slot_local, .. } => {
                if *ret_slot_local != 0 {
                    reserved.insert(*ret_slot_local);
                }
            }
            Inst::AllocaInit(off) => {
                reserved.insert(*off);
            }
            _ => {}
        }
    }

    // Candidate synthetic scalar slots: synthetic offset, only ever a scalar
    // LoadLocal / StoreLocal, not reserved.
    let is_synth = |off: i64| off < 0 && -off > base && -off <= total;
    let mut candidates: BTreeSet<i64> = BTreeSet::new();
    for inst in &f.insts {
        if let Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } = inst
            && is_synth(*off)
            && !reserved.contains(off)
        {
            candidates.insert(*off);
        }
    }
    if candidates.len() < 2 {
        return;
    }
    let slots: Vec<i64> = candidates.iter().copied().collect();
    let slot_bit: BTreeMap<i64, usize> = slots.iter().enumerate().map(|(i, &o)| (o, i)).collect();
    let n = slots.len();
    let words = n.div_ceil(64);
    let nb = f.blocks.len();

    // Per-block gen / kill over the candidate slots. gen = a slot loaded
    // before it is stored in the block (upward-exposed use); kill = a slot
    // stored in the block.
    let mut gen_bits = alloc::vec![0u64; nb * words];
    let mut kill = alloc::vec![0u64; nb * words];
    for (b, blk) in f.blocks.iter().enumerate() {
        let mut stored: BTreeSet<usize> = BTreeSet::new();
        for inst in &f.insts[blk.inst_range.start as usize..blk.inst_range.end as usize] {
            match inst {
                Inst::LoadLocal { off, .. } => {
                    if let Some(&bit) = slot_bit.get(off)
                        && !stored.contains(&bit)
                    {
                        gen_bits[b * words + bit / 64] |= 1u64 << (bit % 64);
                    }
                }
                Inst::StoreLocal { off, .. } => {
                    if let Some(&bit) = slot_bit.get(off) {
                        kill[b * words + bit / 64] |= 1u64 << (bit % 64);
                        stored.insert(bit);
                    }
                }
                _ => {}
            }
        }
    }

    // Backward liveness to a fixed point.
    let succ: Vec<Vec<usize>> = f
        .blocks
        .iter()
        .map(|blk| {
            successors(&blk.terminator, &f.computed_goto_targets)
                .iter()
                .map(|&b| b as usize)
                .collect()
        })
        .collect();
    let mut live_in = alloc::vec![0u64; nb * words];
    let mut live_out = alloc::vec![0u64; nb * words];
    let mut changed = true;
    while changed {
        changed = false;
        for b in (0..nb).rev() {
            for w in 0..words {
                let mut out = 0u64;
                for &s in &succ[b] {
                    out |= live_in[s * words + w];
                }
                if out != live_out[b * words + w] {
                    live_out[b * words + w] = out;
                    changed = true;
                }
                let v = gen_bits[b * words + w] | (out & !kill[b * words + w]);
                if v != live_in[b * words + w] {
                    live_in[b * words + w] = v;
                    changed = true;
                }
            }
        }
    }

    // Interference. Walk each block backward; `live` starts at live_out[b].
    // At a StoreLocal def of slot s, s interferes with every other live slot,
    // then leaves the live set; a LoadLocal use adds its slot.
    let mut interfere = alloc::vec![0u64; n * words];
    for (b, blk) in f.blocks.iter().enumerate() {
        let mut live = live_out[b * words..(b + 1) * words].to_vec();
        let r = blk.inst_range.start as usize..blk.inst_range.end as usize;
        for inst in f.insts[r].iter().rev() {
            match inst {
                Inst::StoreLocal { off, .. } => {
                    if let Some(&bit) = slot_bit.get(off) {
                        for w in 0..words {
                            let mut m = live[w];
                            if w == bit / 64 {
                                m &= !(1u64 << (bit % 64));
                            }
                            interfere[bit * words + w] |= m;
                            let mut mm = m;
                            while mm != 0 {
                                let t = w * 64 + mm.trailing_zeros() as usize;
                                interfere[t * words + bit / 64] |= 1u64 << (bit % 64);
                                mm &= mm - 1;
                            }
                        }
                        live[bit / 64] &= !(1u64 << (bit % 64));
                    }
                }
                Inst::LoadLocal { off, .. } => {
                    if let Some(&bit) = slot_bit.get(off) {
                        live[bit / 64] |= 1u64 << (bit % 64);
                    }
                }
                _ => {}
            }
        }
    }

    // Greedy colouring: interfering slots get distinct colours.
    let mut color = alloc::vec![usize::MAX; n];
    let mut ncolors = 0usize;
    for i in 0..n {
        let mut used: BTreeSet<usize> = BTreeSet::new();
        for j in 0..n {
            if color[j] != usize::MAX && interfere[i * words + j / 64] & (1u64 << (j % 64)) != 0 {
                used.insert(color[j]);
            }
        }
        let mut c = 0;
        while used.contains(&c) {
            c += 1;
        }
        color[i] = c;
        ncolors = ncolors.max(c + 1);
    }

    // Remap. Declared locals (offset magnitude <= base) keep their offsets;
    // the synthetic range is compacted just past the declared boundary. A
    // struct group takes a contiguous block (its base, the lowest address, is
    // the largest magnitude); address-taken / aggregate-result / alloca
    // synthetics take one slot each; each colour of the coalesced scalars
    // shares one slot. Unreferenced (dead) synthetics fall away.
    let struct_cells: BTreeSet<i64> = f
        .synthetic_struct_slots
        .iter()
        .flat_map(|&(sbase, cells)| (0..cells).map(move |k| sbase + k))
        .collect();
    let mut new_off: BTreeMap<i64, i64> = BTreeMap::new();
    let mut next_mag = base;
    for &(sbase, cells) in &f.synthetic_struct_slots {
        for k in 0..cells {
            new_off.insert(sbase + k, -(next_mag + cells - k));
        }
        next_mag += cells;
    }
    for &off in &reserved {
        if is_synth(off) && !struct_cells.contains(&off) {
            next_mag += 1;
            new_off.insert(off, -next_mag);
        }
    }
    let mut color_off: Vec<i64> = alloc::vec![0; ncolors];
    let mut color_set: Vec<bool> = alloc::vec![false; ncolors];
    for (i, &off) in slots.iter().enumerate() {
        let c = color[i];
        if !color_set[c] {
            next_mag += 1;
            color_off[c] = -next_mag;
            color_set[c] = true;
        }
        new_off.insert(off, color_off[c]);
    }
    let new_locals = next_mag;
    if new_locals >= total {
        return;
    }
    for inst in &mut f.insts {
        match inst {
            Inst::LocalAddr(off) | Inst::AllocaInit(off) => {
                if let Some(&nn) = new_off.get(off) {
                    *off = nn;
                }
            }
            Inst::LoadLocal { off, .. } | Inst::StoreLocal { off, .. } => {
                if let Some(&nn) = new_off.get(off) {
                    *off = nn;
                }
            }
            Inst::Call { ret_slot_local, .. } | Inst::CallIndirect { ret_slot_local, .. } => {
                if let Some(&nn) = new_off.get(ret_slot_local) {
                    *ret_slot_local = nn;
                }
            }
            _ => {}
        }
    }
    f.synthetic_struct_slots.clear();
    f.locals = new_locals;
}
