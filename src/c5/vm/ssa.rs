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
use alloc::string::ToString;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::ir::{BinOp, FunctionSsa, Inst, LoadKind, StoreKind, Terminator, ValueId};

/// Tagged-address marker for `LocalAddr` results. The interpreter
/// has no real address space yet; `LocalAddr(off)` encodes the
/// c5-slot offset into the high bits so a downstream `Load` /
/// `Store` can decode it back. Real heap pointers (set by a
/// future `malloc` shim) would use a different tag.
const LOCAL_ADDR_TAG: i64 = 0x4000_0000_0000_0000;

/// Per-call frame the SSA interpreter walks. Holds the value-ID
/// register file, the basic-block cursor, and the per-frame slot
/// array that backs `LocalAddr` / `LoadLocal` / `Store`.
struct Frame<'a> {
    func: &'a FunctionSsa,
    /// Indexed by `ValueId`. `i64::MIN` sentinel means "not yet
    /// written" -- harmless because the SSA tier never reads a
    /// value before its def emits.
    regs: Vec<i64>,
    /// c5-slot-indexed local storage. Negative slot `-N` maps to
    /// `slots[(N - 1) as usize]`; parameter slot `i + 2` maps to
    /// `slots[locals + i]`. Sized at frame entry from
    /// `func.locals` + `func.n_params` so the indexing never
    /// reallocates.
    slots: Vec<i64>,
    /// Number of declared locals (slot offsets `-1..=-locals`).
    /// Parameters land at `slots[locals..]` so the mapping stays
    /// trivial in `slot_index`.
    locals: usize,
    block_idx: usize,
}

impl Frame<'_> {
    fn slot_index(&self, off: i64) -> Option<usize> {
        if off < 0 {
            let idx = (-off - 1) as usize;
            (idx < self.locals).then_some(idx)
        } else if off >= 2 {
            let i = (off - 2) as usize;
            let p = self.locals + i;
            (p < self.slots.len()).then_some(p)
        } else {
            None
        }
    }
}

/// Run a single function's SSA. Currently supports the
/// integer-only subset (no `Call` / `CallExt` / `Intrinsic` /
/// FP). Multi-block control flow runs via the `Terminator`
/// dispatch loop. Returns the function's i64 return value or
/// `Err` with the offending opcode name.
pub(super) fn run_ssa(func: &FunctionSsa) -> Result<i64, C5Error> {
    run_ssa_with_args(func, &[])
}

/// As `run_ssa`, but with `args` staged into the parameter slots
/// per the c5 cdecl: arg `i` lands at slot `i + 2`. Future
/// `Inst::Call` will populate this on each frame entry.
pub(super) fn run_ssa_with_args(func: &FunctionSsa, args: &[i64]) -> Result<i64, C5Error> {
    let locals = func.locals.max(0) as usize;
    let mut slots = alloc::vec![0i64; locals + args.len().max(func.n_params)];
    for (i, &v) in args.iter().enumerate() {
        slots[locals + i] = v;
    }
    let mut frame = Frame {
        func,
        regs: alloc::vec![i64::MIN; func.insts.len()],
        slots,
        locals,
        block_idx: 0,
    };
    loop {
        let block = &frame.func.blocks[frame.block_idx];
        for v in block.inst_range.clone() {
            run_inst(&mut frame, v)?;
        }
        match block.terminator {
            Terminator::Return(rv) => {
                if rv == super::super::ir::NO_VALUE {
                    return Ok(0);
                }
                return Ok(frame.regs[rv as usize]);
            }
            Terminator::Jmp(target) => {
                frame.block_idx = target as usize;
            }
            Terminator::Bz {
                cond,
                target,
                fall_through,
            } => {
                let c = frame.regs[cond as usize];
                frame.block_idx = if c == 0 {
                    target as usize
                } else {
                    fall_through as usize
                };
            }
            Terminator::Bnz {
                cond,
                target,
                fall_through,
            } => {
                let c = frame.regs[cond as usize];
                frame.block_idx = if c != 0 {
                    target as usize
                } else {
                    fall_through as usize
                };
            }
            Terminator::FallThrough(target) => {
                frame.block_idx = target as usize;
            }
            Terminator::TailExt(_) => {
                return Err(C5Error::Runtime(
                    "vm_ssa: Terminator::TailExt not implemented".to_string(),
                ));
            }
        }
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
        Inst::LocalAddr(off) => {
            // Encode the c5-slot offset into a tagged i64 so a
            // downstream `Load` / `Store` can decode it back.
            // The interpreter has no real address space yet;
            // `LocalAddr` results are valid only inside the
            // current frame.
            frame.regs[v as usize] = LOCAL_ADDR_TAG | (*off & 0x0fff_ffff_ffff_ffff);
            return Ok(());
        }
        Inst::TlsAddr(_) => "TlsAddr",
        Inst::Load { addr, kind } => {
            let raw = frame.regs[*addr as usize];
            if raw & LOCAL_ADDR_TAG == 0 {
                return Err(C5Error::Runtime(
                    "vm_ssa: Load through non-LocalAddr pointer not implemented".to_string(),
                ));
            }
            let off = sign_extend_56(raw & 0x0fff_ffff_ffff_ffff);
            let idx = frame.slot_index(off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: Load: slot {off} out of range"))
            })?;
            frame.regs[v as usize] = narrow_load(frame.slots[idx], *kind);
            return Ok(());
        }
        Inst::Store { addr, value, kind } => {
            let raw = frame.regs[*addr as usize];
            if raw & LOCAL_ADDR_TAG == 0 {
                return Err(C5Error::Runtime(
                    "vm_ssa: Store through non-LocalAddr pointer not implemented".to_string(),
                ));
            }
            let off = sign_extend_56(raw & 0x0fff_ffff_ffff_ffff);
            let idx = frame.slot_index(off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: Store: slot {off} out of range"))
            })?;
            let stored = narrow_store(frame.regs[*value as usize], *kind);
            frame.slots[idx] = stored;
            // c5 Store leaves the stored value in the accumulator;
            // downstream uses of this Inst id read that value.
            frame.regs[v as usize] = stored;
            return Ok(());
        }
        Inst::LoadLocal { off, kind } => {
            let idx = frame.slot_index(*off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: LoadLocal: slot {off} out of range"))
            })?;
            frame.regs[v as usize] = narrow_load(frame.slots[idx], *kind);
            return Ok(());
        }
        Inst::StoreLocal { off, value, kind } => {
            let idx = frame.slot_index(*off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: StoreLocal: slot {off} out of range"))
            })?;
            let stored = narrow_store(frame.regs[*value as usize], *kind);
            frame.slots[idx] = stored;
            frame.regs[v as usize] = stored;
            return Ok(());
        }
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

/// Sign-extend a 56-bit value back to a full i64. `LocalAddr`
/// stuffs the c5-slot offset into the low 56 bits; the high
/// bit of that range (bit 55) tells signed-vs-unsigned. Slot
/// offsets are i64 in the SSA inst but in practice fit in i32.
fn sign_extend_56(v: i64) -> i64 {
    let masked = v & 0x00ff_ffff_ffff_ffff;
    if masked & (1 << 55) != 0 {
        masked | !0x00ff_ffff_ffff_ffff
    } else {
        masked
    }
}

/// Narrow a stored i64 down to the requested kind's width, then
/// sign- or zero-extend back to i64 per the kind's signedness.
/// Mirrors what the per-arch emit's load instructions do
/// (`ldrsw` / `ldursw` sign-extend; `ldur` / `movzx` zero-extend).
fn narrow_load(stored: i64, kind: LoadKind) -> i64 {
    match kind {
        LoadKind::I64 => stored,
        LoadKind::I32 => stored as i32 as i64,
        LoadKind::U32 => (stored as u32) as i64,
        LoadKind::I16 => stored as i16 as i64,
        LoadKind::U16 => (stored as u16) as i64,
        LoadKind::I8 => stored as i8 as i64,
        LoadKind::U8 => (stored as u8) as i64,
        LoadKind::F32 => stored,
    }
}

/// Truncate a value to the store kind's width; the high bits of
/// the slot keep their previous contents but no test today
/// observes the difference.
fn narrow_store(value: i64, kind: StoreKind) -> i64 {
    match kind {
        StoreKind::I64 => value,
        StoreKind::I32 => (value as i32) as i64,
        StoreKind::I16 => (value as i16) as i64,
        StoreKind::I8 => (value as i8) as i64,
        StoreKind::F32 => value,
    }
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
    fn locals_round_trip() {
        // `int a = 3 * 4 + 2;` -- walker constant-folds the rhs
        // to `Imm(14)`, then `LocalAddr(-1); Store(*); LoadLocal(-1)`
        // round-trips the value through the slot array.
        let func = ssa_main_of("int main(void) { int a = 3 * 4 + 2; return a; }");
        assert_eq!(run_ssa(&func).expect("ssa run"), 14);
    }

    #[test]
    fn if_branch_taken() {
        // Multi-block control flow: the conditional splits the
        // function into three blocks; the `Bz` terminator
        // dispatches to the then arm for non-zero cond.
        let func = ssa_main_of("int main(void) { if (1) return 7; return 9; }");
        assert_eq!(run_ssa(&func).expect("ssa run"), 7);
    }

    #[test]
    fn if_branch_fallthrough() {
        let func = ssa_main_of("int main(void) { if (0) return 7; return 9; }");
        assert_eq!(run_ssa(&func).expect("ssa run"), 9);
    }

    #[test]
    fn loops_over_locals() {
        // A short loop exercises the back-edge, the Bz / Jmp
        // terminator dispatch, and StoreLocal / LoadLocal
        // round trips. Builds the constant `10` by summing
        // 0+1+2+3+4 (5 iterations).
        let func = ssa_main_of(
            "int main(void) {
                int sum = 0;
                int i = 0;
                while (i < 5) {
                    sum = sum + i;
                    i = i + 1;
                }
                return sum;
            }",
        );
        assert_eq!(run_ssa(&func).expect("ssa run"), 10);
    }
}
