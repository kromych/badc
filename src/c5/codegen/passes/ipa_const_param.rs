//! Propagate what the call sites agree about an argument into the
//! parameter it initialises: the constant it is, and the range it lies
//! in.
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
//!
//! The same admission test licenses a weaker fact for the parameters no
//! single constant reaches: the hull of the ranges the arguments carry,
//! returned for [`super::value_range`] to use as the callee's entry
//! facts. Each argument's range is read from its own instruction shape
//! with nothing else in scope, so no parameter range depends on another
//! function's, and a recursive or mutually recursive call contributes
//! its argument like any other site -- one pass, no fixed point.
//! TODO: an argument that is a counted loop's induction variable stays
//! unbounded. Definition ranges do not close it -- the counter's phi
//! ascends, and widening sends the endpoint that moves to the register
//! limit, from where the increment's narrowing extend pushes the other
//! endpoint out too -- and the loop guard's own fact lands on the masked
//! comparison operand, not on the value the call passes. Complete
//! peeling of the loop does close it, and the counted loops that feed
//! such sites have a second exit, which `super::unroll` does not
//! expand.

use super::value_range::{Range, UNIVERSE};
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
        LoadKind::F32 | LoadKind::F64 | LoadKind::F80 | LoadKind::F128 => None,
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
fn identifier_runs<'a>(texts: &[&'a [u8]]) -> hashbrown::HashSet<&'a [u8]> {
    let mut seen: hashbrown::HashSet<&'a [u8]> = hashbrown::HashSet::new();
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
    seen
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
    // A C function name is a run of identifier characters, so a
    // template referencing one holds it as a whole maximal run; the
    // same name inside a longer identifier is a different symbol. The
    // distinct runs answer that by equality, over far fewer bytes than
    // re-scanning every template once per function.
    let runs = identifier_runs(&asm_texts);
    let asm_bytes: usize = asm_texts.iter().map(|t| t.len()).sum();
    for f in funcs {
        let name = f.name.as_bytes();
        if name.is_empty() {
            continue;
        }
        note_search(0, asm_bytes);
        let hit = if name.iter().all(|&b| is_ident_byte(b)) {
            note_search(name.len(), 0);
            runs.contains(name)
        } else {
            asm_texts.iter().any(|t| {
                note_search(t.len(), 0);
                t.windows(name.len()).any(|w| w == name)
            })
        };
        if hit {
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

/// What the call sites of one function agree about its parameters.
struct Agreed {
    /// The constant every site seen so far passes, cleared as soon as
    /// one site disagrees.
    consts: Vec<Option<i64>>,
    /// The hull of the ranges the arguments carry. The first site
    /// assigns; every later one joins.
    ranges: Vec<Range>,
}

/// Replace every parameter read that every call site agrees on with
/// the constant it agrees on, and report the range each parameter's
/// argument stays inside. `escaping` names the functions with a
/// reachable path the call sites do not describe.
pub(crate) fn run(
    funcs: &mut [FunctionSsa],
    escaping: &BTreeSet<usize>,
) -> BTreeMap<usize, Vec<Range>> {
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
        return BTreeMap::new();
    }

    let mut agreed: BTreeMap<usize, Agreed> = params
        .iter()
        .map(|(&pc, &n)| {
            (
                pc,
                Agreed {
                    consts: alloc::vec![None; n],
                    ranges: alloc::vec![UNIVERSE; n],
                },
            )
        })
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
            let Some(n) = agreed.get(target_pc).map(|a| a.consts.len()) else {
                continue;
            };
            // A site whose argument list does not match the declared
            // one leaves the parameter positions undetermined.
            if args.len() != n {
                agreed.remove(target_pc);
                continue;
            }
            let first = called.insert(*target_pc);
            let slots = agreed.get_mut(target_pc).expect("looked up above");
            for (i, &arg) in args.iter().enumerate() {
                match (const_operand(f, arg), slots.consts[i]) {
                    (Some(k), None) if first => slots.consts[i] = Some(k),
                    (Some(k), Some(prev)) if k == prev => {}
                    _ => slots.consts[i] = None,
                }
                let r = super::value_range::arg_range(f.insts.as_slice(), arg);
                slots.ranges[i] = if first { r } else { slots.ranges[i].hull(r) };
            }
        }
    }
    agreed.retain(|pc, _| called.contains(pc));

    for f in funcs.iter_mut() {
        let Some(slots) = agreed.get(&f.ent_pc).map(|a| &a.consts) else {
            continue;
        };
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

    // Only the functions some parameter is bounded for are worth
    // carrying; an all-unbounded row says nothing the callee's own
    // parameter widths do not.
    agreed
        .into_iter()
        .filter(|(_, a)| a.ranges.iter().any(|r| !r.is_universe()))
        .map(|(pc, a)| (pc, a.ranges))
        .collect()
}
