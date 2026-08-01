//! Propagate a constant argument into the parameter it initialises.
//!
//! C99 6.9.1p10: the arguments of a call are the initial values of the
//! callee's parameters. A function with internal linkage (6.2.2) whose
//! address is never taken is reached only through the call sites of
//! this translation unit, so when every one of them passes the same
//! integer constant for a parameter, that constant is the parameter's
//! value on every entry.
//!
//! `Inst::ParamRef` is exactly the entry value of a parameter -- a
//! later assignment to the parameter object produces its own
//! definition -- so replacing it with the constant is correct
//! independently of what the body does with the parameter afterwards.
//! A parameter whose storage the body addresses is never seeded with a
//! `ParamRef` and is left alone.
//!
//! Runs after unrolling and before inlining: a callee a splice absorbs
//! gets the same constant by argument substitution, so what this
//! reaches is the bodies that stay out of line -- where a guard written
//! on the parameter would otherwise keep the call it guards. gcc covers
//! the same shapes with interprocedural constant propagation.
//!
//! A rewritten `ParamRef` leaves the parameter's incoming register with
//! no reader; `FunctionSsa::const_params` records that so the prologue
//! drops the cell's entry spill as it does for a seeded one.

use crate::c5::ir::{FunctionSsa, Inst, LoadKind, NO_VALUE, ValueId};
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

/// The value a parameter read at `kind` yields for an argument whose
/// constant is `k`: the low bytes, canonically extended per C99
/// 6.3.1.3. `None` for a floating parameter, whose value an integer
/// immediate does not describe.
fn narrow_to_kind(k: i64, kind: LoadKind) -> Option<i64> {
    match kind {
        LoadKind::I64 => Some(k),
        LoadKind::I32 => Some(k as i32 as i64),
        LoadKind::U32 => Some(k as u32 as i64),
        LoadKind::I16 => Some(k as i16 as i64),
        LoadKind::U16 => Some(k as u16 as i64),
        LoadKind::I8 => Some(k as i8 as i64),
        LoadKind::U8 => Some(k as u8 as i64),
        LoadKind::F32 | LoadKind::F64 => None,
    }
}

fn const_operand(func: &FunctionSsa, v: ValueId) -> Option<i64> {
    if v == NO_VALUE {
        return None;
    }
    match func.insts.get(v as usize)? {
        Inst::Imm(k) => Some(*k),
        _ => None,
    }
}

fn is_ident_byte(b: u8) -> bool {
    b.is_ascii_alphanumeric() || b == b'_'
}

#[cfg(test)]
thread_local! {
    /// Bytes the asm-name search read, and what re-scanning every
    /// template for every name would have read. Read by the scaling
    /// test, which bounds the first against the second.
    pub(crate) static ASM_NAME_SEARCH: core::cell::Cell<(usize, usize)> =
        const { core::cell::Cell::new((0, 0)) };
}

#[cfg(test)]
fn note_search(read: usize, rescan: usize) {
    ASM_NAME_SEARCH.with(|c| {
        let (a, b) = c.get();
        c.set((a + read, b + rescan));
    });
}

#[cfg(not(test))]
fn note_search(_read: usize, _rescan: usize) {}

/// The distinct maximal runs of identifier characters across `texts`.
fn identifier_runs<'a>(texts: &[&'a [u8]]) -> Vec<&'a [u8]> {
    let mut seen: hashbrown::HashSet<&[u8]> = hashbrown::HashSet::new();
    for t in texts {
        let mut i = 0;
        while i < t.len() {
            if !is_ident_byte(t[i]) {
                i += 1;
                continue;
            }
            let start = i;
            while i < t.len() && is_ident_byte(t[i]) {
                i += 1;
            }
            seen.insert(&t[start..i]);
        }
    }
    seen.into_iter().collect()
}

/// Entry PCs whose function can be reached other than through the
/// `Inst::Call` sites in `funcs`: a body materialises the address, a
/// static initializer holds it, an alias gives it a second name, or an
/// asm template names it. Any of those admits a call the pass cannot
/// see the arguments of.
pub(crate) fn escaping_functions(
    funcs: &[FunctionSsa],
    program: &crate::c5::program::Program,
) -> BTreeSet<usize> {
    let mut out: BTreeSet<usize> = program
        .code_relocs
        .iter()
        .map(|r| r.target_ent_pc as usize)
        .collect();
    let mut named: BTreeSet<&str> = program
        .function_aliases
        .iter()
        .map(|a| a.target.as_str())
        .collect();
    // Assembly reaches a symbol by name, so any template mentioning one
    // is treated as a reference to it.
    let mut asm_texts: Vec<&[u8]> = program.file_asm.iter().map(|s| s.as_bytes()).collect();
    for f in funcs {
        for inst in &f.insts {
            match inst {
                Inst::ImmCode(pc) => {
                    out.insert(*pc);
                }
                Inst::InlineAsm { asm, .. } => asm_texts.push(&asm.template),
                _ => {}
            }
        }
    }
    // A C function name is a run of identifier characters, so any
    // occurrence of one in a template lies inside a maximal such run.
    // Searching the distinct runs is the same test over far fewer bytes
    // than re-scanning every template once per function.
    let runs = identifier_runs(&asm_texts);
    let asm_bytes: usize = asm_texts.iter().map(|t| t.len()).sum();
    for f in funcs {
        let name = f.name.as_bytes();
        if name.is_empty() {
            continue;
        }
        let haystacks: &[&[u8]] = if name.iter().all(|&b| is_ident_byte(b)) {
            &runs
        } else {
            &asm_texts
        };
        note_search(0, asm_bytes);
        if haystacks.iter().any(|t| {
            note_search(t.len(), 0);
            t.windows(name.len()).any(|w| w == name)
        }) {
            named.insert(f.name.as_str());
        }
    }
    if !named.is_empty() {
        for f in funcs {
            if named.contains(f.name.as_str()) {
                out.insert(f.ent_pc);
            }
        }
    }
    out
}

/// Replace every parameter read that every call site agrees on with
/// the constant it agrees on. `escaping` names the functions with a
/// reachable path the call sites do not describe.
pub(crate) fn run(funcs: &mut [FunctionSsa], escaping: &BTreeSet<usize>) {
    // Candidates keyed by entry PC. A variadic list has no fixed
    // parameter positions, and a naked body is machine code the pass
    // does not model.
    let params: BTreeMap<usize, usize> = funcs
        .iter()
        .filter(|f| {
            f.is_internal
                && !f.is_variadic
                && !f.is_naked
                && f.n_params > 0
                && !escaping.contains(&f.ent_pc)
        })
        .map(|f| (f.ent_pc, f.n_params))
        .collect();
    if params.is_empty() {
        return;
    }

    // Per candidate: the constant every site seen so far passes for
    // each parameter, cleared as soon as one site disagrees.
    let mut agreed: BTreeMap<usize, Vec<Option<i64>>> = params
        .iter()
        .map(|(&pc, &n)| (pc, alloc::vec![None; n]))
        .collect();
    let mut called: BTreeSet<usize> = BTreeSet::new();
    for f in funcs.iter() {
        for inst in &f.insts {
            let Inst::Call {
                target_pc, args, ..
            } = inst
            else {
                continue;
            };
            let Some(slots) = agreed.get_mut(target_pc) else {
                continue;
            };
            // A site whose argument list does not match the declared
            // one leaves the parameter positions undetermined.
            if args.len() != slots.len() {
                agreed.remove(target_pc);
                continue;
            }
            let first = called.insert(*target_pc);
            for (i, slot) in slots.iter_mut().enumerate() {
                match (const_operand(f, args[i]), *slot) {
                    (Some(k), None) if first => *slot = Some(k),
                    (Some(k), Some(prev)) if k == prev => {}
                    _ => *slot = None,
                }
            }
        }
    }

    for f in funcs.iter_mut() {
        let Some(slots) = agreed.get(&f.ent_pc) else {
            continue;
        };
        if !called.contains(&f.ent_pc) {
            continue;
        }
        // A `ParamRef` still feeding its own cell's entry spill is the
        // record that the cell holds that argument, which the inliner
        // reads to resolve the cell at a splice. Leave those; the
        // splice substitutes the same constant from the call site.
        let pinned: BTreeSet<ValueId> = f
            .insts
            .iter()
            .filter_map(|inst| match inst {
                Inst::StoreLocal { off, value, .. } => match f.insts.get(*value as usize) {
                    Some(Inst::ParamRef { idx, .. }) if *idx as i64 + 2 == *off => Some(*value),
                    _ => None,
                },
                _ => None,
            })
            .collect();
        let mut folded: u64 = 0;
        for (v, inst) in f.insts.iter_mut().enumerate() {
            if pinned.contains(&(v as ValueId)) {
                continue;
            }
            let Inst::ParamRef { idx, kind } = inst else {
                continue;
            };
            if *idx >= 64 {
                continue;
            }
            let Some(Some(k)) = slots.get(*idx as usize) else {
                continue;
            };
            let Some(c) = narrow_to_kind(*k, *kind) else {
                continue;
            };
            folded |= 1u64 << *idx;
            *inst = Inst::Imm(c);
        }
        f.const_params |= folded;
    }
}
