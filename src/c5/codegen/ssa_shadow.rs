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
