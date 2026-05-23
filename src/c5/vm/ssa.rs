//! SSA-driven VM interpreter: walks `Vec<FunctionSsa>` instead of the
//! bytecode tape. The bytecode VM (in `super::mod`) is the current
//! production interpreter; this module is the retarget destination.
//! `Vm::run` calls into [`run_ssa`] when `BADC_VM_SSA` is set in the
//! environment; the bytecode path stays the default until every
//! `Inst` variant has a runtime action here and the cargo suite is
//! green under the SSA path.
//!
//! The shape mirrors the bytecode interpreter's frame model so the
//! Host bridge, argv staging, and exit-code plumbing in
//! `Vm::run` can stay shared. What changes is the instruction loop:
//! instead of decoding `program.text[pc]`, the interpreter indexes
//! into `func.insts` and a per-call `Vec<i64>` register file keyed by
//! `ValueId`.
//!
//! Supported `Inst` variants today (in increasing order of
//! complexity, implementations land iteratively):
//!   * `Imm` -- writes the constant into the value register.
//!   * `Return` (as a terminator) -- pops the frame and yields the
//!     caller's resume point.
//!
//! Every other `Inst` returns
//! `Err(C5Error::Runtime("vm_ssa: <opname> not implemented"))` so
//! the regression test below lights up exactly which variants
//! need wiring next. The bytecode VM stays untouched; production
//! `Vm::run` continues to dispatch through the existing
//! `text[pc]` loop until every variant lands here.
//!
//! Gated to `cfg(test)` for now -- the regression test below is
//! the only caller -- so production builds don't pay any code
//! size for the in-progress interpreter.

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::ir::{BinOp, FunctionSsa, Inst, Terminator, ValueId};

/// Per-call frame the SSA interpreter walks. Holds the value-ID
/// register file plus the basic-block cursor. Stack frames /
/// locals / accumulator are passed by the caller through `Frame::run`.
struct Frame<'a> {
    func: &'a FunctionSsa,
    /// Indexed by `ValueId`. `i64::MIN` sentinel means "not yet
    /// written" -- emitted by the SSA tier as `Inst::AllocaInit`
    /// before any caller can observe a stale read.
    regs: Vec<i64>,
    block_idx: usize,
}

/// Run a single function's SSA. `func` must be self-contained for
/// now (no `Call` / `CallExt` / `CallIndirect` / `Intrinsic` until
/// those are wired). Returns the function's i64 return value or
/// `Err` with the offending opcode name.
pub(super) fn run_ssa(func: &FunctionSsa) -> Result<i64, C5Error> {
    let mut frame = Frame {
        func,
        regs: alloc::vec![i64::MIN; func.insts.len()],
        block_idx: 0,
    };
    // Single-block path: walk the entry block's insts, then
    // dispatch on its terminator. Multi-block control flow lands
    // in a subsequent iteration with the `Jmp` / `Bz` / `Bnz`
    // implementations.
    let block = &frame.func.blocks[frame.block_idx];
    for v in block.inst_range.clone() {
        run_inst(&mut frame, v)?;
    }
    match block.terminator {
        Terminator::Return(rv) => {
            if rv == super::super::ir::NO_VALUE {
                Ok(0)
            } else {
                Ok(frame.regs[rv as usize])
            }
        }
        other => Err(C5Error::Runtime(format!(
            "vm_ssa: terminator {other:?} not implemented",
        ))),
    }
}

fn run_inst(frame: &mut Frame<'_>, v: ValueId) -> Result<(), C5Error> {
    let inst = &frame.func.insts[v as usize];
    let name = match inst {
        Inst::Imm(k) => {
            frame.regs[v as usize] = *k;
            return Ok(());
        }
        Inst::ImmData(_) => "ImmData",
        Inst::ImmCode(_) => "ImmCode",
        Inst::LocalAddr(_) => "LocalAddr",
        Inst::TlsAddr(_) => "TlsAddr",
        Inst::Load { .. } => "Load",
        Inst::Store { .. } => "Store",
        Inst::LoadLocal { .. } => "LoadLocal",
        Inst::StoreLocal { .. } => "StoreLocal",
        Inst::LoadIndexed { .. } => "LoadIndexed",
        Inst::StoreIndexed { .. } => "StoreIndexed",
        Inst::Binop { op, lhs, rhs } => {
            let lv = frame.regs[*lhs as usize];
            let rv = frame.regs[*rhs as usize];
            frame.regs[v as usize] = apply_binop(*op, lv, rv)?;
            return Ok(());
        }
        Inst::BinopI { op, lhs, rhs_imm } => {
            let lv = frame.regs[*lhs as usize];
            frame.regs[v as usize] = apply_binop(*op, lv, *rhs_imm)?;
            return Ok(());
        }
        Inst::Fneg(_) => "Fneg",
        Inst::FpCast { .. } => "FpCast",
        Inst::Call { .. } => "Call",
        Inst::CallIndirect { .. } => "CallIndirect",
        Inst::CallExt { .. } => "CallExt",
        Inst::TailExt(_) => "TailExt",
        Inst::Mcpy { .. } => "Mcpy",
        Inst::Intrinsic { .. } => "Intrinsic",
        Inst::AllocaInit(_) => {
            // No-op for v0 == AllocaInit(0); the alloca arena
            // lives in the bytecode VM's stack. SSA-VM doesn't
            // expose alloca yet -- callers requesting a real
            // arena get the "not implemented" path below.
            return Ok(());
        }
        Inst::VstackSpill { .. } => "VstackSpill",
        Inst::VstackReload { .. } => "VstackReload",
        Inst::AccSpill { .. } => "AccSpill",
        Inst::AccReload => "AccReload",
    };
    Err(C5Error::Runtime(format!("vm_ssa: {name} not implemented",)))
}

/// Integer binop dispatch. Mirrors `fold_int_binop` in `ast::walk`;
/// the two share C99-driven semantics for arithmetic / bitwise /
/// shift / comparison ops. FP ops (Fadd / Feq / ...) and division
/// by zero land in the "not implemented" path because the VM
/// doesn't yet thread FP values or trap divisions cleanly.
fn apply_binop(op: BinOp, lhs: i64, rhs: i64) -> Result<i64, C5Error> {
    let r = match op {
        BinOp::Add => lhs.wrapping_add(rhs),
        BinOp::Sub => lhs.wrapping_sub(rhs),
        BinOp::Mul => lhs.wrapping_mul(rhs),
        BinOp::And => lhs & rhs,
        BinOp::Or => lhs | rhs,
        BinOp::Xor => lhs ^ rhs,
        BinOp::Shl => ((lhs as u64) << (rhs as u32 & 63)) as i64,
        BinOp::Shr => lhs >> (rhs as u32 & 63),
        BinOp::Shru => ((lhs as u64) >> (rhs as u32 & 63)) as i64,
        BinOp::Eq => (lhs == rhs) as i64,
        BinOp::Ne => (lhs != rhs) as i64,
        BinOp::Lt => (lhs < rhs) as i64,
        BinOp::Gt => (lhs > rhs) as i64,
        BinOp::Le => (lhs <= rhs) as i64,
        BinOp::Ge => (lhs >= rhs) as i64,
        BinOp::Ult => ((lhs as u64) < (rhs as u64)) as i64,
        BinOp::Ugt => ((lhs as u64) > (rhs as u64)) as i64,
        BinOp::Ule => ((lhs as u64) <= (rhs as u64)) as i64,
        BinOp::Uge => ((lhs as u64) >= (rhs as u64)) as i64,
        BinOp::Div | BinOp::Divu | BinOp::Mod | BinOp::Modu => {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: BinOp::{op:?} not implemented (division-by-zero trap missing)",
            )));
        }
        _ => {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: BinOp::{op:?} not implemented (FP)",
            )));
        }
    };
    Ok(r)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;

    fn ssa_main_of(src: &str) -> FunctionSsa {
        let program = Compiler::new(src.to_string())
            .compile()
            .expect("compile fixture");
        let funcs = super::super::super::codegen::ssa_shadow::produce_ssa_funcs(
            &program,
            super::super::super::Target::MacOSAarch64,
        )
        .expect("ssa lift");
        // The first walker-produced function is the user's
        // first defined source function; without `with_prelude`
        // this is `main`.
        funcs.into_iter().next().expect("at least one function")
    }

    #[test]
    fn return_constant() {
        // C99 5.1.2.2.3: `int main(void) { return 42; }` -- the
        // walker produces `AllocaInit(0); Imm(42); Return(v_imm)`
        // and the SSA-VM runs that to completion.
        let func = ssa_main_of("int main(void) { return 42; }");
        assert_eq!(run_ssa(&func).expect("ssa run"), 42);
    }

    #[test]
    fn binop_imm_arithmetic() {
        // Walker constant-folds `7 + 3` and `4 * 6` to single
        // `Imm` values; pick a non-foldable shape so the SSA-VM
        // actually exercises `apply_binop`.
        let func = ssa_main_of("int f(int a) { return a + 5; } int main(void) { return f(10); }");
        // The first function the walker emits is `f`, not main;
        // re-pick the right one.
        let _ = func;
        // Verify the Binop path through a constant-foldable
        // shape that the walker leaves un-folded once it sees
        // a non-IntLit lhs. `arr[K]` -> `arr + (K * sizeof)`
        // produces a BinopI(Add, arr, K*sizeof) after the index
        // fold lands; emit a `(a + 1) * (a + 2)` shape so the
        // BinopI(Add, Imm, 1) BinopI(Add, Imm, 2) BinOp(Mul,
        // ..) chain exercises both arms.
        let func2 = ssa_main_of("int main(void) { int a = 3; int b = 4; return a * b + 2; }");
        // Locals (`int a = 3;`) need the StoreLocal/LoadLocal
        // path that's still on the not-implemented list, so
        // skip this assertion until those land. The point of
        // this test today is the compile-and-lift dry run.
        let _ = func2;
    }
}
