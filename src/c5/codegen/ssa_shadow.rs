//! SSA-source selector for the codegen backends. The walker
//! drives every parsed function via its captured AST snapshot;
//! `lift_program` recovers post-parser synthetic functions
//! (sys-trampolines, the CRT entry) that have no AST and any
//! program reloaded from an archive (linker / optimizer path).

use crate::c5::Target;
use crate::c5::error::C5Error;
use crate::c5::ir::FunctionSsa;
use crate::c5::program::Program;
use alloc::vec::Vec;

/// AST-driven counterpart to [`super::ssa::lift_program`]. Walks
/// every entry in `program.finished_functions` through
/// [`crate::c5::ast::walk::walk_function`] and returns one
/// `FunctionSsa` per source function in `ent_pc` order.
///
/// The walker needs the symbol-table snapshot kept on the
/// program (`array_size` for the C99 6.3.2.1p3 array-decay
/// detection + `type_` for the local-decl width). If the
/// snapshot is empty (linker / optimizer reload), the caller is
/// expected to keep using `lift_program` instead.
pub(crate) fn walk_program(program: &Program, target: Target) -> Result<Vec<FunctionSsa>, C5Error> {
    // Walker entries from AST snapshots, keyed by ent_pc. Sys
    // trampolines, the synthetic CRT entry, and any other
    // post-parser function bodies don't go through the dual-emit
    // and are recovered from the bytecode lift below.
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
            f.n_params,
            f.is_variadic,
            f.n_locals,
            &f.param_tys,
            &f.param_local_slots,
            f.returns_struct,
            f.return_struct_size,
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
    // carries every other walker-translated function from
    // units that didn't survive into `finished_functions`
    // (typically a `.o` reload whose AST snapshot got stripped
    // during write_object). Merge both into the output, keyed
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
    Ok(out)
}

/// SSA-source pick for the codegen backends. The walker drives
/// every source function with a captured `Ast` snapshot; the
/// bytecode lift recovers post-parser synthetic functions (Sys
/// trampolines, the synthetic CRT entry) that have no AST.
/// When the program carries no finished functions (linker /
/// optimizer reload from an archive) the lift handles the whole
/// program.
///
/// TODO: switch the no-finished-functions branch over to
/// `program.user_ssa_funcs` once the codegen produces
/// runtime-equivalent code from that input on every demo
/// (current gap: archive-reload of multi-TU programs segfaults
/// at runtime even with the optimizer's Inst PC remap in place).
pub(crate) fn produce_ssa_funcs(
    program: &Program,
    target: Target,
) -> Result<Vec<FunctionSsa>, C5Error> {
    if !program.finished_functions.is_empty() {
        return walk_program(program, target);
    }
    if !program.user_ssa_funcs.is_empty() {
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
    super::ssa::lift_program(program)
}

/// Maximum param slot the function reads or writes. C5's
/// calling convention places declared param `i` (0-indexed) at
/// frame slot `i + 2`; the codegen prologue spills the matching
/// argument register into that slot. Returns the *touched*
/// count -- a declared-but-unused param is dropped so the frame
/// stays in step with `codegen::param_count_for_func`, the
/// bytecode-side equivalent the lift produces.
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
