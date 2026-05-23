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

/// `Inst::ImmCode` results are tagged with this bit set so
/// `Inst::CallIndirect` can distinguish a function pointer from
/// a real memory address. The low bits hold the callee's
/// `ent_pc`; the tag is cleared before `Program::lookup`.
const CODE_ADDR_TAG: i64 = 0x4000_0000_0000_0000;
const CODE_ADDR_MASK: i64 = 0x4000_0000_0000_0000;

/// Byte-addressed memory backing the SSA-VM. Layout:
///
///   bytes[0..data_end]              -- read-only data segment
///   bytes[data_end..stack_end]      -- per-frame stack region;
///                                     `Frame::stack_base` /
///                                     `Frame::frame_size` bound
///                                     each call's slot bytes.
///
/// `Inst::LocalAddr(off)` returns a real byte address into
/// `bytes`. `Inst::ImmData(off)` returns `off` (which lands in
/// the data region). `Inst::ImmCode` is the only address that
/// stays tagged because code addresses don't map to bytes.
struct Memory {
    bytes: Vec<u8>,
    data_end: usize,
    /// Bump-pointer next-frame-allocation cursor. Pushed by
    /// `alloc_frame` on call entry; reset to the saved base on
    /// return. Each frame's locals + params occupy
    /// `(locals + n_params) * 8` bytes starting at this offset.
    stack_top: usize,
}

impl Memory {
    fn new(data: &[u8]) -> Self {
        // Reserve a fixed 256 KiB stack region. C99 doesn't pin
        // a stack limit; this matches the bytecode VM's
        // `STACK_CAPACITY` order of magnitude and is plenty for
        // every cargo fixture today.
        const STACK_BYTES: usize = 256 * 1024;
        let data_end = data.len();
        let mut bytes = Vec::with_capacity(data_end + STACK_BYTES);
        bytes.extend_from_slice(data);
        bytes.resize(data_end + STACK_BYTES, 0);
        Self {
            bytes,
            data_end,
            stack_top: data_end,
        }
    }

    fn alloc_frame(&mut self, frame_bytes: usize) -> Result<usize, C5Error> {
        let base = self.stack_top;
        let next = base.checked_add(frame_bytes).ok_or_else(|| {
            C5Error::Runtime(format!(
                "vm_ssa: stack overflow allocating {frame_bytes} bytes from {base}",
            ))
        })?;
        if next > self.bytes.len() {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: stack overflow ({next} > {})",
                self.bytes.len(),
            )));
        }
        // Zero the new frame's bytes so undefined reads observe
        // the C standard's static-storage initial value.
        for b in &mut self.bytes[base..next] {
            *b = 0;
        }
        self.stack_top = next;
        Ok(base)
    }

    fn release_frame(&mut self, base: usize) {
        self.stack_top = base;
    }

    fn read_bytes(&self, addr: usize, n: usize) -> Result<&[u8], C5Error> {
        if addr + n > self.bytes.len() {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: load: addr 0x{addr:x}..0x{:x} past memory len {}",
                addr + n,
                self.bytes.len(),
            )));
        }
        Ok(&self.bytes[addr..addr + n])
    }

    fn write_bytes(&mut self, addr: usize, src: &[u8]) -> Result<(), C5Error> {
        if addr < self.data_end || addr + src.len() > self.bytes.len() {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: store: addr 0x{addr:x}..0x{:x} out of writable stack range \
                 (data_end={}, mem_len={})",
                addr + src.len(),
                self.data_end,
                self.bytes.len(),
            )));
        }
        self.bytes[addr..addr + src.len()].copy_from_slice(src);
        Ok(())
    }

    fn copy_within(&mut self, dst: usize, src: usize, n: usize) -> Result<(), C5Error> {
        if dst + n > self.bytes.len() || src + n > self.bytes.len() {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: Mcpy: src=0x{src:x}..0x{:x} / dst=0x{dst:x}..0x{:x} \
                 past memory len {}",
                src + n,
                dst + n,
                self.bytes.len(),
            )));
        }
        if dst < self.data_end {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: Mcpy: dst 0x{dst:x} in read-only data region",
            )));
        }
        self.bytes.copy_within(src..src + n, dst);
        Ok(())
    }
}

/// Multi-function program context. The SSA-VM walks
/// `Vec<FunctionSsa>`; `Inst::Call` resolves a callee by
/// `target_pc` through `ent_pc_to_idx`.
struct Program<'a> {
    funcs: &'a [FunctionSsa],
    /// `ent_pc` -> index into `funcs`. Built once at program
    /// entry; `Inst::Call` does a constant-time lookup.
    ent_pc_to_idx: alloc::collections::BTreeMap<usize, usize>,
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
        }
    }

    fn lookup(&self, ent_pc: usize) -> Option<&'a FunctionSsa> {
        self.ent_pc_to_idx.get(&ent_pc).map(|&i| &self.funcs[i])
    }
}

/// Per-call frame the SSA interpreter walks. Holds the value-ID
/// register file, the basic-block cursor, and the byte range
/// inside `Memory::bytes` that backs this frame's locals + params.
struct Frame<'a> {
    func: &'a FunctionSsa,
    /// Indexed by `ValueId`. `i64::MIN` sentinel means "not yet
    /// written" -- harmless because the SSA tier never reads a
    /// value before its def emits.
    regs: Vec<i64>,
    /// Byte offset into `Memory::bytes` where this frame's
    /// locals + params start. Slot `-N` lives at
    /// `stack_base + (N - 1) * 8`; param `i + 2` lives at
    /// `stack_base + (locals + i) * 8`.
    stack_base: usize,
    /// Total bytes the frame allocated; saved here so
    /// `release_frame` lines up with the alloc_frame returned by
    /// `Memory::alloc_frame`.
    frame_bytes: usize,
    /// Number of declared locals (slot offsets `-1..=-locals`).
    locals: usize,
    block_idx: usize,
}

impl Frame<'_> {
    /// c5-slot offset -> byte address in `Memory::bytes`.
    fn slot_addr(&self, off: i64) -> Option<usize> {
        if off < 0 {
            let idx = (-off - 1) as usize;
            (idx < self.locals).then_some(self.stack_base + idx * 8)
        } else if off >= 2 {
            let i = (off - 2) as usize;
            let frame_slots = self.frame_bytes / 8;
            (self.locals + i < frame_slots).then_some(self.stack_base + (self.locals + i) * 8)
        } else {
            None
        }
    }
}

/// Single-function entry: wrap `func` in a one-element `Program`
/// with an empty data segment. `Inst::Call` in this shape fails
/// with a "not found" runtime error because there's only one
/// function.
pub(super) fn run_ssa(func: &FunctionSsa) -> Result<i64, C5Error> {
    let funcs = core::slice::from_ref(func);
    run_program(funcs, &[], func.ent_pc)
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
    let prog = Program::new(funcs);
    let mut mem = Memory::new(data);
    let entry = prog.lookup(entry_pc).ok_or_else(|| {
        C5Error::Runtime(format!(
            "vm_ssa: run_program: no function at ent_pc {entry_pc}",
        ))
    })?;
    run_func(&prog, &mut mem, entry, &[])
}

/// Run one function in the program context. `args` lands in the
/// parameter byte slots per the c5 cdecl: arg `i` at
/// `stack_base + (locals + i) * 8`.
fn run_func(
    prog: &Program<'_>,
    mem: &mut Memory,
    func: &FunctionSsa,
    args: &[i64],
) -> Result<i64, C5Error> {
    let locals = func.locals.max(0) as usize;
    let n_params = func.n_params.max(args.len());
    let frame_bytes = (locals + n_params) * 8;
    let stack_base = mem.alloc_frame(frame_bytes)?;
    for (i, &v) in args.iter().enumerate() {
        let addr = stack_base + (locals + i) * 8;
        mem.write_bytes(addr, &v.to_le_bytes())?;
    }
    let mut frame = Frame {
        func,
        regs: alloc::vec![i64::MIN; func.insts.len()],
        stack_base,
        frame_bytes,
        locals,
        block_idx: 0,
    };
    let result: Result<i64, C5Error> = loop {
        let block = &frame.func.blocks[frame.block_idx];
        let mut step_err: Option<C5Error> = None;
        for v in block.inst_range.clone() {
            if let Err(e) = run_inst(prog, mem, &mut frame, v) {
                step_err = Some(e);
                break;
            }
        }
        if let Some(e) = step_err {
            break Err(e);
        }
        match block.terminator {
            Terminator::Return(rv) => {
                let r = if rv == super::super::ir::NO_VALUE {
                    0
                } else {
                    frame.regs[rv as usize]
                };
                break Ok(r);
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
                break Err(C5Error::Runtime(
                    "vm_ssa: Terminator::TailExt not implemented".to_string(),
                ));
            }
        }
    };
    mem.release_frame(stack_base);
    result
}

fn run_inst(
    prog: &Program<'_>,
    mem: &mut Memory,
    frame: &mut Frame<'_>,
    v: ValueId,
) -> Result<(), C5Error> {
    let inst = &frame.func.insts[v as usize];
    let name = match inst {
        Inst::Imm(k) => {
            frame.regs[v as usize] = *k;
            return Ok(());
        }
        Inst::ImmData(off) => {
            // Data-segment offset lands directly in the
            // byte-addressed memory; `ImmData(off)` returns the
            // real address (which sits below `mem.data_end`).
            frame.regs[v as usize] = *off;
            return Ok(());
        }
        Inst::ImmCode(target_pc) => {
            // Code pointers don't map to bytes; tag with
            // `CODE_ADDR_TAG` so `CallIndirect` recognises them.
            frame.regs[v as usize] = CODE_ADDR_TAG | (*target_pc as i64);
            return Ok(());
        }
        Inst::LocalAddr(off) => {
            let addr = frame.slot_addr(*off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: LocalAddr: slot {off} out of range"))
            })?;
            frame.regs[v as usize] = addr as i64;
            return Ok(());
        }
        Inst::TlsAddr(_) => "TlsAddr",
        Inst::Load { addr, kind } => {
            let a = frame.regs[*addr as usize];
            if a & CODE_ADDR_MASK != 0 || a < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: Load: addr 0x{a:016x} is not a data pointer",
                )));
            }
            frame.regs[v as usize] = load_from_memory(mem, a as usize, *kind)?;
            return Ok(());
        }
        Inst::Store { addr, value, kind } => {
            let a = frame.regs[*addr as usize];
            if a & CODE_ADDR_MASK != 0 || a < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: Store: addr 0x{a:016x} is not a data pointer",
                )));
            }
            let stored = narrow_store(frame.regs[*value as usize], *kind);
            store_to_memory(mem, a as usize, stored, *kind)?;
            // c5 Store leaves the stored value in the accumulator;
            // downstream uses of this Inst id read that value.
            frame.regs[v as usize] = stored;
            return Ok(());
        }
        Inst::LoadLocal { off, kind } => {
            let addr = frame.slot_addr(*off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: LoadLocal: slot {off} out of range"))
            })?;
            frame.regs[v as usize] = load_from_memory(mem, addr, *kind)?;
            return Ok(());
        }
        Inst::StoreLocal { off, value, kind } => {
            let addr = frame.slot_addr(*off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: StoreLocal: slot {off} out of range"))
            })?;
            let stored = narrow_store(frame.regs[*value as usize], *kind);
            store_to_memory(mem, addr, stored, *kind)?;
            frame.regs[v as usize] = stored;
            return Ok(());
        }
        Inst::Mcpy { dst, src, size } => {
            let dst_addr = frame.regs[*dst as usize];
            let src_addr = frame.regs[*src as usize];
            if dst_addr & CODE_ADDR_MASK != 0 || src_addr & CODE_ADDR_MASK != 0 {
                return Err(C5Error::Runtime(
                    "vm_ssa: Mcpy: src or dst is a code pointer".to_string(),
                ));
            }
            if dst_addr < 0 || src_addr < 0 || *size < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: Mcpy: bad operands (dst=0x{dst_addr:x}, src=0x{src_addr:x}, size={size})",
                )));
            }
            mem.copy_within(dst_addr as usize, src_addr as usize, *size as usize)?;
            // Mcpy returns the destination address (c5 model).
            frame.regs[v as usize] = dst_addr;
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
            let ret = run_func(prog, mem, callee, &arg_vals)?;
            frame.regs[v as usize] = ret;
            return Ok(());
        }
        Inst::CallIndirect { target, args } => {
            let raw = frame.regs[*target as usize];
            if raw & CODE_ADDR_MASK == 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: CallIndirect: target raw=0x{raw:016x} is not a code pointer",
                )));
            }
            let target_pc = (raw & !CODE_ADDR_MASK) as usize;
            let callee = prog.lookup(target_pc).ok_or_else(|| {
                C5Error::Runtime(format!(
                    "vm_ssa: CallIndirect: no function at ent_pc {target_pc}",
                ))
            })?;
            let mut arg_vals: Vec<i64> = Vec::with_capacity(args.len());
            for &a in args {
                arg_vals.push(frame.regs[a as usize]);
            }
            let ret = run_func(prog, mem, callee, &arg_vals)?;
            frame.regs[v as usize] = ret;
            return Ok(());
        }
        Inst::CallExt { .. } => "CallExt",
        Inst::TailExt(_) => "TailExt",
        Inst::Intrinsic { kind, args } => {
            run_intrinsic(mem, frame, v, *kind, args)?;
            return Ok(());
        }
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

/// Dispatch a compiler-builtin `Intrinsic`. `kind` matches the
/// discriminant of `crate::c5::op::Intrinsic`; the SSA-VM
/// implements the targets that survive on every host:
///
/// * `Alloca(n)` -- bumps the per-frame `Memory::stack_top` by
///   `n` (16-byte rounded) and returns the previous top as the
///   new pointer. The arena auto-releases when `release_frame`
///   restores `stack_top` at the enclosing function's return.
/// * `VaStart(&ap, &last)` -- writes `&last + 8` into `*&ap`.
///   c5 stages variadic args at an 8-byte stride above the
///   last fixed arg.
/// * `VaArg(&ap)` -- reads `*&ap`, advances `*&ap` by 8, returns
///   the captured cursor as the variadic value.
/// * `VaEnd(&ap)` -- no-op on every supported host.
/// * `VaCopy(&dst, &src)` -- `*dst = *src`.
/// * AArch64 setjmp / longjmp intrinsics return "not implemented"
///   because the bytecode VM also rejects them; they only land
///   in JIT / AOT output.
fn run_intrinsic(
    mem: &mut Memory,
    frame: &mut Frame<'_>,
    v: ValueId,
    kind: i64,
    args: &[ValueId],
) -> Result<(), C5Error> {
    use crate::c5::op::Intrinsic;
    let intr = Intrinsic::from_i64(kind).ok_or_else(|| {
        C5Error::Runtime(format!("vm_ssa: unknown Intrinsic discriminant {kind}"))
    })?;
    match intr {
        Intrinsic::Alloca => {
            let n_raw = args
                .first()
                .map(|&a| frame.regs[a as usize])
                .ok_or_else(|| C5Error::Runtime("vm_ssa: Alloca expects 1 argument".to_string()))?;
            if n_raw < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: Alloca: negative size {n_raw}",
                )));
            }
            let rounded = ((n_raw as usize) + 15) & !15;
            let base = mem.alloc_frame(rounded)?;
            frame.regs[v as usize] = base as i64;
            Ok(())
        }
        Intrinsic::VaStart => {
            let ap_addr = frame.regs[args[0] as usize] as usize;
            let last_addr = frame.regs[args[1] as usize];
            store_to_memory(mem, ap_addr, last_addr + 8, StoreKind::I64)
        }
        Intrinsic::VaArg => {
            let ap_addr = frame.regs[args[0] as usize] as usize;
            let cursor = load_from_memory(mem, ap_addr, LoadKind::I64)?;
            store_to_memory(mem, ap_addr, cursor + 8, StoreKind::I64)?;
            // Walker doesn't pass the value width through args
            // here; the SSA-VM returns the cursor itself, mirroring
            // the bytecode VM. Downstream casts truncate as needed.
            frame.regs[v as usize] = load_from_memory(mem, cursor as usize, LoadKind::I64)?;
            Ok(())
        }
        Intrinsic::VaEnd => Ok(()),
        Intrinsic::VaCopy => {
            let dst_addr = frame.regs[args[0] as usize] as usize;
            let src_addr = frame.regs[args[1] as usize] as usize;
            let cursor = load_from_memory(mem, src_addr, LoadKind::I64)?;
            store_to_memory(mem, dst_addr, cursor, StoreKind::I64)
        }
        Intrinsic::SetjmpAArch64 | Intrinsic::LongjmpAArch64 => Err(C5Error::Runtime(format!(
            "vm_ssa: Intrinsic::{intr:?} is AArch64-specific and not supported here",
        ))),
    }
}

/// Read a typed value out of byte-addressed memory at `addr`.
/// Sign / zero extension follows C99 6.3.1.3 per the LoadKind's
/// signedness. Bounds errors trip a runtime error so a stray
/// pointer doesn't read uninitialised state.
fn load_from_memory(mem: &Memory, addr: usize, kind: LoadKind) -> Result<i64, C5Error> {
    let n = match kind {
        LoadKind::I64 => 8,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
    };
    let slice = mem.read_bytes(addr, n)?;
    let val: i64 = match kind {
        LoadKind::I64 => i64::from_le_bytes(slice.try_into().unwrap()),
        LoadKind::I32 => i32::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::U32 | LoadKind::F32 => u32::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::I16 => i16::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::U16 => u16::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::I8 => slice[0] as i8 as i64,
        LoadKind::U8 => slice[0] as i64,
    };
    Ok(val)
}

/// Write a typed value into byte-addressed memory. `value` is
/// already narrowed via `narrow_store` so the low `n` bytes
/// carry the storable bit pattern.
fn store_to_memory(
    mem: &mut Memory,
    addr: usize,
    value: i64,
    kind: StoreKind,
) -> Result<(), C5Error> {
    match kind {
        StoreKind::I64 => mem.write_bytes(addr, &value.to_le_bytes()),
        StoreKind::I32 => mem.write_bytes(addr, &(value as i32).to_le_bytes()),
        StoreKind::I16 => mem.write_bytes(addr, &(value as i16).to_le_bytes()),
        StoreKind::I8 => mem.write_bytes(addr, &(value as i8).to_le_bytes()),
        StoreKind::F32 => mem.write_bytes(addr, &(value as u32).to_le_bytes()),
    }
}

/// Truncate a value to the store kind's width; the high bits
/// the byte write doesn't touch keep their previous contents.
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
    fn alloca_bumps_stack_and_returns_writable_pointer() {
        // C99 doesn't standardize `alloca`, but the c5 compiler
        // emits `Intrinsic { kind: Alloca, args: [size] }` for
        // any identifier the preprocessor tagged via
        // `#pragma intrinsic("...")`. <alloca.h> registers
        // `alloca`. The SSA-VM bumps the per-frame stack region
        // and returns a real byte address.
        assert_eq!(
            run_full_program(
                "#pragma intrinsic(\"alloca\")
                 int *alloca(int);
                 int main(void) {
                     int *p = alloca(16);
                     p[0] = 17;
                     p[1] = 25;
                     return p[0] + p[1];
                 }",
            ),
            42,
        );
    }

    #[test]
    fn mcpy_struct_assignment() {
        // C99 6.5.16.1: `s = t` for a struct value copies
        // `sizeof(struct)` bytes through `Inst::Mcpy`. The
        // SSA-VM dispatches Mcpy through `Memory::copy_within`
        // on real byte addresses.
        assert_eq!(
            run_full_program(
                "struct P { int x; int y; };
                 int main(void) {
                     struct P a;
                     struct P b;
                     a.x = 11;
                     a.y = 31;
                     b = a;
                     return b.x + b.y;
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
