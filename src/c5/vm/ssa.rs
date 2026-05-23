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
use super::super::ir::{
    BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, StoreKind, Terminator, ValueId,
};

/// Tagged-address marker for `LocalAddr` results. The interpreter
/// has no real address space yet; `LocalAddr(off)` encodes the
/// c5-slot offset into the high bits so a downstream `Load` /
/// `Store` can decode it back. Real heap pointers (set by a
/// future `malloc` shim) would use a different tag.
const LOCAL_ADDR_TAG: i64 = 0x4000_0000_0000_0000;

/// Tagged-address marker for `ImmData` results: bit 62 set,
/// bit 61 clear (distinguishes from `LOCAL_ADDR_TAG` which sets
/// bit 62 too). The low bits hold the data-segment byte offset.
const DATA_ADDR_TAG: i64 = 0x2000_0000_0000_0000;
/// Tagged-address marker for `ImmCode` results: bits 62+61 both
/// set. The low bits hold the callee's `ent_pc` so
/// `Inst::CallIndirect` can dispatch through `Program::lookup`.
const CODE_ADDR_TAG: i64 = 0x6000_0000_0000_0000;
const ADDR_TAG_MASK: i64 = 0x6000_0000_0000_0000;
const ADDR_OFFSET_MASK: i64 = 0x0fff_ffff_ffff_ffff;

/// Multi-function program context. The SSA-VM walks
/// `Vec<FunctionSsa>`; `Inst::Call` resolves a callee by
/// `target_pc` through `ent_pc_to_idx`. Kept as a struct so the
/// per-arch JIT shim, the host-call bridge, and the c5
/// trampoline pool can later attach without changing `run_func`'s
/// signature.
struct Program<'a> {
    funcs: &'a [FunctionSsa],
    /// `ent_pc` -> index into `funcs`. Built once at program
    /// entry; `Inst::Call` does a constant-time lookup.
    ent_pc_to_idx: alloc::collections::BTreeMap<usize, usize>,
    /// Initial-data bytes (string literals + zero-initialised
    /// globals). `Inst::ImmData(off)` returns a tagged address
    /// that decodes to a slice of this buffer. `None` when the
    /// SSA-VM is invoked without a `Program` (e.g. the
    /// single-function `run_ssa` shape used by unit tests).
    data: &'a [u8],
}

impl<'a> Program<'a> {
    fn new(funcs: &'a [FunctionSsa]) -> Self {
        let ent_pc_to_idx = funcs
            .iter()
            .enumerate()
            .map(|(i, f)| (f.ent_pc, i))
            .collect();
        Self {
            funcs,
            ent_pc_to_idx,
            data: &[],
        }
    }

    fn with_data(mut self, data: &'a [u8]) -> Self {
        self.data = data;
        self
    }

    fn lookup(&self, ent_pc: usize) -> Option<&'a FunctionSsa> {
        self.ent_pc_to_idx.get(&ent_pc).map(|&i| &self.funcs[i])
    }
}

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

/// Single-function entry: wrap `func` in a one-element `Program`
/// and run it. `Inst::Call` in this shape will fail with a
/// "not found" runtime error because there's only one function.
pub(super) fn run_ssa(func: &FunctionSsa) -> Result<i64, C5Error> {
    let funcs = core::slice::from_ref(func);
    let prog = Program::new(funcs);
    run_func(&prog, func, &[])
}

/// Multi-function entry: pick the function at `entry_pc` and run
/// it with no arguments. `Inst::Call` resolves callees through
/// `funcs`' `ent_pc` lookup; `Inst::ImmData(off)` indexes into
/// `data` for string-literal / global reads.
pub(super) fn run_program(
    funcs: &[FunctionSsa],
    data: &[u8],
    entry_pc: usize,
) -> Result<i64, C5Error> {
    let prog = Program::new(funcs).with_data(data);
    let entry = prog.lookup(entry_pc).ok_or_else(|| {
        C5Error::Runtime(format!(
            "vm_ssa: run_program: no function at ent_pc {entry_pc}",
        ))
    })?;
    run_func(&prog, entry, &[])
}

/// Run one function in the program context. `args` lands in the
/// parameter slots per the c5 cdecl: arg `i` at slot `i + 2`.
fn run_func(prog: &Program<'_>, func: &FunctionSsa, args: &[i64]) -> Result<i64, C5Error> {
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
            run_inst(prog, &mut frame, v)?;
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

fn run_inst(prog: &Program<'_>, frame: &mut Frame<'_>, v: ValueId) -> Result<(), C5Error> {
    let inst = &frame.func.insts[v as usize];
    let name = match inst {
        Inst::Imm(k) => {
            frame.regs[v as usize] = *k;
            return Ok(());
        }
        Inst::ImmData(off) => {
            // Tag a data-segment byte offset so a downstream
            // `Load` / `Store` can decode it back. `Store` to
            // ImmData currently fails -- the data segment is
            // read-only in the SSA-VM (matches what the bytecode
            // VM's pointer-tracking would flag).
            frame.regs[v as usize] = DATA_ADDR_TAG | (*off & ADDR_OFFSET_MASK);
            return Ok(());
        }
        Inst::ImmCode(target_pc) => {
            frame.regs[v as usize] = CODE_ADDR_TAG | ((*target_pc as i64) & ADDR_OFFSET_MASK);
            return Ok(());
        }
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
            match raw & ADDR_TAG_MASK {
                t if t == LOCAL_ADDR_TAG => {
                    let off = sign_extend_56(raw & ADDR_OFFSET_MASK);
                    let idx = frame.slot_index(off).ok_or_else(|| {
                        C5Error::Runtime(format!("vm_ssa: Load: slot {off} out of range"))
                    })?;
                    frame.regs[v as usize] = narrow_load(frame.slots[idx], *kind);
                }
                t if t == DATA_ADDR_TAG => {
                    let off = (raw & ADDR_OFFSET_MASK) as usize;
                    frame.regs[v as usize] = load_from_data(prog.data, off, *kind)?;
                }
                _ => {
                    return Err(C5Error::Runtime(format!(
                        "vm_ssa: Load through untagged pointer (raw=0x{raw:016x}) not implemented",
                    )));
                }
            }
            return Ok(());
        }
        Inst::Store { addr, value, kind } => {
            let raw = frame.regs[*addr as usize];
            if raw & ADDR_TAG_MASK != LOCAL_ADDR_TAG {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: Store through non-LocalAddr pointer (raw=0x{raw:016x}) not implemented",
                )));
            }
            let off = sign_extend_56(raw & ADDR_OFFSET_MASK);
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
        Inst::Fneg(src) => {
            let raw = frame.regs[*src as usize];
            let neg = (-f64::from_bits(raw as u64)).to_bits() as i64;
            frame.regs[v as usize] = neg;
            return Ok(());
        }
        Inst::FpCast { kind, value } => {
            let raw = frame.regs[*value as usize];
            frame.regs[v as usize] = match kind {
                FpCastKind::FpToInt => f64::from_bits(raw as u64) as i64,
                FpCastKind::IntToFp => (raw as f64).to_bits() as i64,
            };
            return Ok(());
        }
        Inst::Call { target_pc, args } => {
            let callee = prog.lookup(*target_pc).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: Call: no function at ent_pc {target_pc}",))
            })?;
            let mut arg_vals: Vec<i64> = Vec::with_capacity(args.len());
            for &a in args {
                arg_vals.push(frame.regs[a as usize]);
            }
            let ret = run_func(prog, callee, &arg_vals)?;
            frame.regs[v as usize] = ret;
            return Ok(());
        }
        Inst::CallIndirect { target, args } => {
            let raw = frame.regs[*target as usize];
            if raw & ADDR_TAG_MASK != CODE_ADDR_TAG {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: CallIndirect: target raw=0x{raw:016x} is not a code pointer",
                )));
            }
            let target_pc = (raw & ADDR_OFFSET_MASK) as usize;
            let callee = prog.lookup(target_pc).ok_or_else(|| {
                C5Error::Runtime(format!(
                    "vm_ssa: CallIndirect: no function at ent_pc {target_pc}",
                ))
            })?;
            let mut arg_vals: Vec<i64> = Vec::with_capacity(args.len());
            for &a in args {
                arg_vals.push(frame.regs[a as usize]);
            }
            let ret = run_func(prog, callee, &arg_vals)?;
            frame.regs[v as usize] = ret;
            return Ok(());
        }
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

/// Read a typed value out of the data segment. Width / sign
/// behaviour matches `narrow_load`. Out-of-range offsets trip
/// a runtime error rather than reading uninitialised memory.
fn load_from_data(data: &[u8], off: usize, kind: LoadKind) -> Result<i64, C5Error> {
    let need = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
    };
    if off + need > data.len() {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: Load: data offset {off}..{} past data segment len {}",
            off + need,
            data.len(),
        )));
    }
    let slice = &data[off..off + need];
    let val: i64 = match kind {
        LoadKind::I64 => i64::from_le_bytes(slice.try_into().unwrap()),
        LoadKind::I32 => i32::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::U32 => u32::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::F32 => u32::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::I16 => i16::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::U16 => u16::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::I8 => slice[0] as i8 as i64,
        LoadKind::U8 => slice[0] as i64,
    };
    Ok(val)
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
        BinOp::Div => {
            if rhs == 0 {
                return Err(C5Error::Runtime(
                    "vm_ssa: signed integer division by zero".to_string(),
                ));
            }
            lhs.wrapping_div(rhs)
        }
        BinOp::Mod => {
            if rhs == 0 {
                return Err(C5Error::Runtime(
                    "vm_ssa: signed integer modulo by zero".to_string(),
                ));
            }
            lhs.wrapping_rem(rhs)
        }
        BinOp::Divu => {
            let r = rhs as u64;
            if r == 0 {
                return Err(C5Error::Runtime(
                    "vm_ssa: unsigned integer division by zero".to_string(),
                ));
            }
            ((lhs as u64) / r) as i64
        }
        BinOp::Modu => {
            let r = rhs as u64;
            if r == 0 {
                return Err(C5Error::Runtime(
                    "vm_ssa: unsigned integer modulo by zero".to_string(),
                ));
            }
            ((lhs as u64) % r) as i64
        }
        BinOp::Fadd => (f64::from_bits(lhs as u64) + f64::from_bits(rhs as u64)).to_bits() as i64,
        BinOp::Fsub => (f64::from_bits(lhs as u64) - f64::from_bits(rhs as u64)).to_bits() as i64,
        BinOp::Fmul => (f64::from_bits(lhs as u64) * f64::from_bits(rhs as u64)).to_bits() as i64,
        BinOp::Fdiv => (f64::from_bits(lhs as u64) / f64::from_bits(rhs as u64)).to_bits() as i64,
        BinOp::Feq => (f64::from_bits(lhs as u64) == f64::from_bits(rhs as u64)) as i64,
        BinOp::Fne => (f64::from_bits(lhs as u64) != f64::from_bits(rhs as u64)) as i64,
        BinOp::Flt => (f64::from_bits(lhs as u64) < f64::from_bits(rhs as u64)) as i64,
        BinOp::Fgt => (f64::from_bits(lhs as u64) > f64::from_bits(rhs as u64)) as i64,
        BinOp::Fle => (f64::from_bits(lhs as u64) <= f64::from_bits(rhs as u64)) as i64,
        BinOp::Fge => (f64::from_bits(lhs as u64) >= f64::from_bits(rhs as u64)) as i64,
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

    fn run_full_program(src: &str) -> i64 {
        let program = Compiler::new(src.to_string())
            .compile()
            .expect("compile fixture");
        let funcs = super::super::super::codegen::ssa_shadow::produce_ssa_funcs(
            &program,
            super::super::super::Target::MacOSAarch64,
        )
        .expect("ssa lift");
        run_program(&funcs, &program.data, program.entry_pc).expect("ssa run")
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
    fn call_passes_args_and_returns() {
        // Multi-function dispatch: `main` calls `add` with two
        // arguments and returns the result. Exercises
        // `Inst::Call` + `Program::lookup` + frame nesting.
        assert_eq!(
            run_full_program(
                "int add(int a, int b) { return a + b; }
                 int main(void) { return add(7, 35); }",
            ),
            42,
        );
    }

    #[test]
    fn recursive_factorial() {
        // Recursion exercises the same `Inst::Call` path back
        // into the caller and verifies the Rust stack survives
        // a typical recursion depth (5! -> depth 6).
        assert_eq!(
            run_full_program(
                "int fact(int n) { if (n < 2) return 1; return n * fact(n - 1); }
                 int main(void) { return fact(5); }",
            ),
            120,
        );
    }

    #[test]
    fn call_indirect_through_fn_pointer() {
        // C99 6.5.2.2: a call through a function-pointer value
        // delivers the args and returns the callee's result.
        // `ImmCode` writes the encoded `ent_pc` into the register;
        // `CallIndirect` decodes and dispatches via `Program::lookup`.
        assert_eq!(
            run_full_program(
                "int double_it(int x) { return x * 2; }
                 int main(void) {
                     int (*fp)(int) = double_it;
                     return fp(21);
                 }",
            ),
            42,
        );
    }

    #[test]
    fn data_segment_string_literal_byte() {
        // `"X"[0]` exercises `Inst::ImmData(off)` + `Inst::Load`
        // through the data-segment tag path. The walker emits
        // `StrLit -> ImmData(<offset>); LoadIndexed{base, idx, scale=1, kind=I8}`,
        // but the index-fold path collapses to
        // `BinopI(Add, ImmData, 0); Load { kind: I8 }` -- the
        // identity fold then drops the `Add 0`, so the Load
        // reads byte 0 of the data segment.
        assert_eq!(
            run_full_program("int main(void) { return \"X\"[0]; }"),
            'X' as i64,
        );
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
