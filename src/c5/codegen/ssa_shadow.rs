//! Shadow-comparison entry: runs the bytecode-tier lift against a
//! single function's `[ent_pc, end_pc)` region and returns the
//! resulting `FunctionSsa`. Used by the AST validator
//! (`Compiler::validate_finished_asts`) to compare the walker's
//! output against the lift's per-function shape.
//!
//! Thin re-export over `ssa::lift_function`: codegen's own
//! pipeline still calls `lift_function` directly. This wrapper
//! only exists to expose the entry to the compiler module without
//! widening `ssa.rs` itself.
//!
//! The wrapper also walks the bytecode to recover `FuncMeta`
//! (parameter count + variadic flag). The compiler validator
//! already knows these from `FinishedFunction`, so the
//! `(n_params, is_variadic)` fields are taken from the caller.

use crate::c5::error::C5Error;
use crate::c5::ir::FunctionSsa;
use crate::c5::program::Program;
use crate::c5::Target;
use alloc::vec::Vec;

/// Lift a single function's bytecode region into a `FunctionSsa`.
/// `text` is the program's full bytecode vector; `[ent_pc,
/// end_pc)` is the function's region; the metadata arrays
/// (`data_imm_positions`, `code_imm_positions`,
/// `call_fp_arg_masks`) come straight from the compiler-side
/// fields of the same name.
#[allow(clippy::too_many_arguments)]
pub(crate) fn lift_single(
    text: &[i64],
    ent_pc: usize,
    end_pc: usize,
    n_params: usize,
    is_variadic: bool,
    data_imm_positions: &[usize],
    code_imm_positions: &[usize],
    call_fp_arg_masks: &[(usize, u32)],
) -> Result<FunctionSsa, C5Error> {
    let meta = super::FuncMeta {
        n_params,
        is_variadic,
    };
    super::ssa::lift_function(
        text,
        ent_pc,
        end_pc,
        meta,
        data_imm_positions,
        code_imm_positions,
        call_fp_arg_masks,
    )
}

/// Instruction-category counts on a `FunctionSsa`. The compiler
/// validator pivots on these for shadow comparison: a non-zero
/// delta in any field between the walker's and the lift's
/// output flags a per-category divergence the developer should
/// inspect.
#[derive(Debug, Default, Clone, Copy)]
#[allow(dead_code)]
pub(crate) struct InstCounts {
    pub imm: u32,
    pub local_addr: u32,
    pub tls_addr: u32,
    pub imm_data: u32,
    pub imm_code: u32,
    pub load: u32,
    pub store: u32,
    pub load_local: u32,
    pub store_local: u32,
    pub binop: u32,
    pub binop_imm: u32,
    pub fneg: u32,
    pub fp_cast: u32,
    pub call: u32,
    pub call_ext: u32,
    pub call_indirect: u32,
    pub tail_ext: u32,
    pub mcpy: u32,
    pub intrinsic: u32,
    pub alloca_init: u32,
    pub vstack_spill: u32,
    pub vstack_reload: u32,
    pub acc_spill: u32,
    pub acc_reload: u32,
    pub blocks: u32,
}

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
pub(crate) fn walk_program(
    program: &Program,
    target: Target,
) -> Result<Vec<FunctionSsa>, C5Error> {
    // Walker entries from AST snapshots, keyed by ent_pc. Sys
    // trampolines, the synthetic CRT entry, and any other
    // post-parser function bodies don't go through the dual-emit
    // and are recovered from the bytecode lift below.
    let mut walker_pcs: alloc::collections::BTreeSet<usize> =
        alloc::collections::BTreeSet::new();
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
    // Recover bytecode-only functions (Sys trampolines, synthetic
    // helpers) by lifting them. Each `Op::Ent` in the bytecode
    // that didn't show up in `finished_functions` is one of
    // these. The lift produces the same `FunctionSsa` shape the
    // walker would have, so the rest of the codegen sees them
    // identically.
    let lift_funcs = super::ssa::lift_program(program)?;
    for f in lift_funcs {
        if !walker_pcs.contains(&f.ent_pc) {
            out.push(f);
        }
    }
    out.sort_by_key(|f| f.ent_pc);
    Ok(out)
}

/// SSA-source pick for the codegen backends. Honors the
/// environment variable `BADC_USE_AST_SSA`:
///
///   * unset / `0` / `false` -> bytecode lift
///     ([`super::ssa::lift_program`]).
///   * `1` / `true`           -> AST walk ([`walk_program`]).
///
/// The fall-through is `lift_program`, so an env-less build keeps
/// the bytecode-tier path until Phase C5 retires it. The flag is
/// `std`-only because the env API requires it; `no_std` builds
/// always fall through.
pub(crate) fn produce_ssa_funcs(
    program: &Program,
    target: Target,
) -> Result<Vec<FunctionSsa>, C5Error> {
    if use_ast_ssa() && !program.finished_functions.is_empty() {
        walk_program(program, target)
    } else {
        super::ssa::lift_program(program)
    }
}

#[cfg(feature = "std")]
fn use_ast_ssa() -> bool {
    match std::env::var("BADC_USE_AST_SSA") {
        Ok(s) => matches!(s.as_str(), "1" | "true" | "TRUE" | "yes"),
        Err(_) => false,
    }
}

#[cfg(not(feature = "std"))]
fn use_ast_ssa() -> bool {
    false
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

/// Walk `func.insts` + `func.blocks` and produce a category
/// histogram. Iterates once; constant-time per inst.
pub(crate) fn count_insts(func: &FunctionSsa) -> InstCounts {
    use crate::c5::ir::Inst;
    let mut c = InstCounts {
        blocks: func.blocks.len() as u32,
        ..InstCounts::default()
    };
    for inst in &func.insts {
        match inst {
            Inst::Imm(_) => c.imm += 1,
            Inst::LocalAddr(_) => c.local_addr += 1,
            Inst::TlsAddr(_) => c.tls_addr += 1,
            Inst::ImmData(_) => c.imm_data += 1,
            Inst::ImmCode(_) => c.imm_code += 1,
            Inst::Load { .. } => c.load += 1,
            Inst::Store { .. } => c.store += 1,
            Inst::LoadLocal { .. } => c.load_local += 1,
            Inst::StoreLocal { .. } => c.store_local += 1,
            Inst::LoadIndexed { .. } => c.load += 1,
            Inst::StoreIndexed { .. } => c.store += 1,
            Inst::Binop { .. } => c.binop += 1,
            Inst::BinopI { .. } => c.binop_imm += 1,
            Inst::Fneg(_) => c.fneg += 1,
            Inst::FpCast { .. } => c.fp_cast += 1,
            Inst::Call { .. } => c.call += 1,
            Inst::CallExt { .. } => c.call_ext += 1,
            Inst::CallIndirect { .. } => c.call_indirect += 1,
            Inst::TailExt(_) => c.tail_ext += 1,
            Inst::Mcpy { .. } => c.mcpy += 1,
            Inst::Intrinsic { .. } => c.intrinsic += 1,
            Inst::AllocaInit(_) => c.alloca_init += 1,
            Inst::VstackSpill { .. } => c.vstack_spill += 1,
            Inst::VstackReload { .. } => c.vstack_reload += 1,
            Inst::AccSpill { .. } => c.acc_spill += 1,
            Inst::AccReload => c.acc_reload += 1,
        }
    }
    c
}
