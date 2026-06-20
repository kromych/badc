//! SSA-source selector for the codegen backends. The walker
//! drives every parsed function via its captured AST snapshot;
//! pre-built `synthetic_ssa_funcs` (sys-trampolines, CRT entry)
//! and `user_ssa_funcs` (archive reload) come through directly.

use crate::c5::Target;
use crate::c5::error::C5Error;
use crate::c5::ir::FunctionSsa;
use crate::c5::program::Program;
use alloc::vec::Vec;

/// Walks every entry in `program.finished_functions` through
/// [`crate::c5::ast::walk::walk_function`] and returns one
/// `FunctionSsa` per source function in `ent_pc` order. Sys
/// trampolines and the synthetic CRT entry don't go through
/// the AST walker; the caller layers them on from
/// `program.synthetic_ssa_funcs` after this returns.
pub(crate) fn walk_program(program: &Program, target: Target) -> Result<Vec<FunctionSsa>, C5Error> {
    // Walker entries from AST snapshots, keyed by ent_pc.
    let mut walker_pcs: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let mut out: Vec<FunctionSsa> = Vec::with_capacity(program.finished_functions.len());
    let mut ordered: Vec<usize> = (0..program.finished_functions.len()).collect();
    ordered.sort_by_key(|&i| program.finished_functions[i].ent_pc);
    for i in ordered {
        let f = &program.finished_functions[i];
        walker_pcs.insert(f.ent_pc);
        let mut func = crate::c5::ast::walk::walk_function(
            &f.ast,
            &program.symbols,
            &program.structs,
            target,
            f.ent_pc,
            f.end_pc,
            f.n_params,
            f.is_variadic,
            f.n_locals,
            &f.param_tys,
            &f.param_local_slots,
            f.returns_struct,
            f.return_struct_size,
            f.return_ty,
            f.alloca_top_slot,
        )
        .map_err(|e| {
            C5Error::Compile(crate::c5::error::fmt_internal_err(&alloc::format!(
                "ast::walk: function `{}` (ent_pc={}): {}",
                f.name,
                f.ent_pc,
                e,
            )))
        })?;
        func.name = f.name.clone();
        func.is_inline = f.is_inline;
        // Seed declared multi-cell extents alongside the synthetic ones the
        // walker recorded. Slot coalescing reserves every interior cell.
        func.multi_cell_slots.extend_from_slice(&f.multi_cell_slots);
        // `n_params` on FinishedFunction is the parser's
        // declared count. The codegen prologue spills the
        // matching host-arg regs into slots [2, 2+n). Use the
        // max of the declared count and the touched count
        // (`walker_param_count`): a struct-by-value param
        // wraps its slot-2 read inside the entry-Mcpy whose
        // dst is `slot -N`, so the touched scan would miss
        // slot 2 and the codegen wouldn't spill the host arg
        // -- the callee then reads junk for the struct
        // address.
        let touched = walker_param_count(&func);
        func.n_params = touched.max(f.n_params);
        out.push(func);
    }
    // Parser-emitted helpers (sys-trampolines) come through
    // `program.synthetic_ssa_funcs`. `program.user_ssa_funcs`
    // carries every other walker-translated function not present
    // in `finished_functions`. Merge both into the output, keyed
    // by ent_pc to keep the entry-per-PC invariant.
    let mut covered_pcs: alloc::collections::BTreeSet<usize> = walker_pcs.iter().copied().collect();
    for f in &program.synthetic_ssa_funcs {
        if covered_pcs.insert(f.ent_pc) {
            out.push(f.clone());
        }
    }
    for f in &program.user_ssa_funcs {
        if covered_pcs.insert(f.ent_pc) {
            out.push(f.clone());
        }
    }
    out.sort_by_key(|f| f.ent_pc);
    drop_unreachable_statics(&mut out, program);
    Ok(out)
}

/// Drop every `FunctionSsa` whose ent_pc is unreachable from the
/// program's static-DCE roots. Roots are the entry point (`main`),
/// every externally-linked function (`Linkage::External` /
/// `Linkage::None`), and every name starting with `_` (the gcc /
/// clang -Wunused-function convention -- treated as deliberately
/// retained, matching what `warn_unused_static_functions`
/// exempts). Anything transitively reachable from a root via
/// `Inst::Call` or `Inst::ImmCode` survives. `Inst::CallIndirect`
/// is handled conservatively: any function whose address appears
/// in `Inst::ImmCode` is already marked reachable, so an indirect
/// dispatch cannot reach a function the marker hasn't seen.
fn drop_unreachable_statics(funcs: &mut Vec<FunctionSsa>, program: &Program) {
    use crate::c5::ir::Inst;
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;

    let mut linkage_by_name: alloc::collections::BTreeMap<&str, Linkage> =
        alloc::collections::BTreeMap::new();
    for sym in &program.symbols {
        if sym.class == Token::Fun as i64 && !sym.name.is_empty() {
            linkage_by_name.insert(sym.name.as_str(), sym.linkage);
        }
    }

    let mut by_pc: alloc::collections::BTreeMap<usize, usize> = alloc::collections::BTreeMap::new();
    for (i, f) in funcs.iter().enumerate() {
        by_pc.insert(f.ent_pc, i);
    }

    let mut reachable: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
    let mut queue: alloc::vec::Vec<usize> = alloc::vec::Vec::new();

    for f in funcs.iter() {
        let is_root = f.name == "main"
            || f.name.starts_with('_')
            || matches!(
                linkage_by_name.get(f.name.as_str()).copied(),
                Some(Linkage::External) | Some(Linkage::None)
            );
        if is_root {
            queue.push(f.ent_pc);
        }
    }
    // Static initialisers of the form `int (*fp)(int) = some_fn;`
    // park the target's ent_pc in `program.code_relocs` (the slot
    // is patched at link / load time). Treat each entry as a root
    // so the function whose address sits in the data segment
    // survives DCE even when it has no in-text call site.
    for r in &program.code_relocs {
        queue.push(r.target_ent_pc as usize);
    }
    // Every export name binds a function. Treat as a root so
    // `#pragma export(<name>)` keeps the body around when the
    // user's source has no in-image call site.
    for e in &program.exports {
        queue.push(e.ent_pc);
    }

    while let Some(pc) = queue.pop() {
        if !reachable.insert(pc) {
            continue;
        }
        let Some(&idx) = by_pc.get(&pc) else { continue };
        for inst in &funcs[idx].insts {
            match inst {
                Inst::Call { target_pc, .. } => queue.push(*target_pc),
                Inst::ImmCode(target_pc) => queue.push(*target_pc),
                _ => {}
            }
        }
    }

    funcs.retain(|f| {
        let keep = reachable.contains(&f.ent_pc);
        #[cfg(feature = "codegen_test")]
        if !keep && std::env::var("BADC_DEBUG_STATIC_DCE").is_ok() {
            std::eprintln!(
                "[static_dce] dropping unreachable function `{}` ent_pc={}",
                f.name,
                f.ent_pc,
            );
        }
        keep
    });
}

/// SSA-source pick for the codegen backends and the Vm. Two
/// sources, in priority order:
///
///   1. `program.finished_functions` non-empty -> walk_program
///      walks each AST snapshot. The in-memory compile+link
///      path takes this branch.
///
///   2. `program.user_ssa_funcs` or `program.synthetic_ssa_funcs`
///      non-empty -> the linker merged per-unit walker output.
///      Combine the user and synthetic vectors (sys-trampolines +
///      synthetic CRT entry). The archive-reload path of every
///      `.o` produced after the walker became canonical takes
///      this branch.
///
/// Programs with neither populated (the empty-text writer
/// fixtures) return an empty `Vec`.
pub(crate) fn produce_ssa_funcs(
    program: &Program,
    target: Target,
) -> Result<Vec<FunctionSsa>, C5Error> {
    if !program.finished_functions.is_empty() {
        let mut funcs = walk_program(program, target)?;
        // C99 6.2.2: a function with internal linkage that no reachable
        // code or data references is unobservable; drop it before codegen
        // so the unused `static inline` helpers headers pull into every
        // unit do not reach the image.
        let live = compute_live_functions(&funcs, program);
        funcs.retain(|f| live.contains(&f.ent_pc));
        return Ok(funcs);
    }
    if !program.user_ssa_funcs.is_empty() || !program.synthetic_ssa_funcs.is_empty() {
        let mut covered: alloc::collections::BTreeSet<usize> = alloc::collections::BTreeSet::new();
        let mut out: Vec<FunctionSsa> =
            Vec::with_capacity(program.user_ssa_funcs.len() + program.synthetic_ssa_funcs.len());
        for f in &program.user_ssa_funcs {
            if covered.insert(f.ent_pc) {
                out.push(f.clone());
            }
        }
        for f in &program.synthetic_ssa_funcs {
            if covered.insert(f.ent_pc) {
                out.push(f.clone());
            }
        }
        out.sort_by_key(|f| f.ent_pc);
        return Ok(out);
    }
    Ok(Vec::new())
}

/// Reachable user functions: the set of `ent_pc`s the program can reach.
/// Roots are externally-visible functions (C99 6.2.2 external linkage --
/// callable from another unit) and functions whose address is stored in
/// the data segment (dispatch tables, via `code_relocs`). From the roots,
/// a function's direct calls (`Inst::Call`) and address-of references
/// (`Inst::ImmCode`) keep their targets reachable. A function absent from
/// the result has internal linkage and no reference path, so it can be
/// dropped before codegen.
pub(crate) fn compute_live_functions(
    funcs: &[FunctionSsa],
    program: &Program,
) -> alloc::collections::BTreeSet<usize> {
    use crate::c5::ir::Inst;
    use crate::c5::symbol::Linkage;
    use crate::c5::token::Token;
    use alloc::collections::{BTreeMap, BTreeSet};

    let by_ent: BTreeMap<usize, &FunctionSsa> = funcs.iter().map(|f| (f.ent_pc, f)).collect();
    let mut live: BTreeSet<usize> = BTreeSet::new();
    let mut work: alloc::vec::Vec<usize> = alloc::vec::Vec::new();

    for s in &program.symbols {
        if s.class == Token::Fun as i64
            && matches!(s.linkage, Linkage::External)
            && by_ent.contains_key(&(s.val as usize))
            && live.insert(s.val as usize)
        {
            work.push(s.val as usize);
        }
    }
    for r in &program.code_relocs {
        let ent = r.target_ent_pc as usize;
        if by_ent.contains_key(&ent) && live.insert(ent) {
            work.push(ent);
        }
    }
    while let Some(ent) = work.pop() {
        let Some(f) = by_ent.get(&ent) else { continue };
        for inst in &f.insts {
            let target = match inst {
                Inst::Call { target_pc, .. } => Some(*target_pc),
                Inst::ImmCode(t) => Some(*t),
                _ => None,
            };
            if let Some(t) = target
                && by_ent.contains_key(&t)
                && live.insert(t)
            {
                work.push(t);
            }
        }
    }
    live
}

/// Maximum param slot the function reads or writes. C5's
/// calling convention places declared param `i` (0-indexed) at
/// frame slot `i + 2`; the codegen prologue spills the matching
/// argument register into that slot. Returns the *touched*
/// count -- a declared-but-unused param is dropped so the frame
/// matches the body's actual reads.
fn walker_param_count(func: &FunctionSsa) -> usize {
    use crate::c5::ir::Inst;
    let mut max_seen: Option<i64> = None;
    for inst in &func.insts {
        let slot = match inst {
            Inst::LoadLocal { off, .. } => Some(*off),
            Inst::StoreLocal { off, .. } => Some(*off),
            Inst::LocalAddr(off) => Some(*off),
            _ => None,
        };
        if let Some(s) = slot
            && s >= 2
        {
            max_seen = Some(max_seen.map_or(s, |m| m.max(s)));
        }
    }
    // Param `i` (0-indexed) sits at slot `i + 2`, so the count
    // is `max_slot - 1` (e.g. only slot 2 touched -> 1 param).
    match max_seen {
        Some(s) => (s - 1).max(0) as usize,
        None => 0,
    }
}
