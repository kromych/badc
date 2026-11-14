//! SSA-driven VM interpreter: walks `Vec<FunctionSsa>`.
//! `super::Vm::run` dispatches here via
//! [`run_program_with_args_tracked`].
//!
//! Per-call state is a `Vec<i64>` register file keyed by `ValueId`;
//! the host-bridge / argv staging / exit-code plumbing lives in
//! `super::Vm`.

#![allow(dead_code)]

use alloc::format;
use alloc::string::ToString;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::host::Host;
use super::super::ir::{
    AtomicRmwOp, BinOp, FpCastKind, FunctionSsa, Inst, LoadKind, StoreKind, Terminator, ValueId,
};
use super::eval::{self, round_if_f32};
use super::fenv::{BINARY32, BINARY64, Format, FpEnv, Round};

mod asm_a64;
mod locale;
mod printf;
mod scan;
mod sort;
mod stream;
mod string;
mod strtox;
mod system;

/// `Inst::ImmCode` results are tagged with this bit set so
/// `Inst::CallIndirect` can distinguish a function pointer from
/// a real memory address. The low bits hold the callee's
/// `ent_pc`; the tag is cleared before `Program::lookup`.
/// `Vm::with_host` patches static-initializer function pointers in
/// the data image with the same tag so a value loaded from data
/// compares equal to one materialized from an `Inst::ImmCode`.
pub(super) const CODE_ADDR_TAG: i64 = 0x4000_0000_0000_0000;
const CODE_ADDR_MASK: i64 = 0x4000_0000_0000_0000;

/// Set, besides `CODE_ADDR_TAG`, on a position inside a function's code,
/// so that no label or return address equals a function pointer.
const CODE_POSITION_TAG: i64 = 0x1000_0000_0000_0000;

/// Each field of a code position holds fewer than this many values.
const CODE_POSITION_FIELD: usize = 1 << 20;

/// A position inside a function's code: the function's index in
/// `Program::funcs` above bit 40, the block above bit 20 and the
/// instruction offset within the block below it. `Inst::BlockAddr` is
/// offset 0 of the label's block and a return address the offset after
/// the call, so the positions in one function order the way its blocks
/// do, as native addresses do.
pub(super) fn code_position(func_idx: usize, block: usize, offset: usize) -> i64 {
    CODE_ADDR_TAG
        | CODE_POSITION_TAG
        | ((func_idx as i64) << 40)
        | ((block as i64) << 20)
        | offset as i64
}

/// The block of `func`, at `func_idx` in `Program::funcs`, that a `goto *`
/// to `position` enters: a block whose address `Inst::BlockAddr` or a
/// `&&label` initializer gives, which `computed_goto_targets` lists. `None`
/// for any other value, which no label address of this function equals.
fn label_block(func: &FunctionSsa, func_idx: usize, position: i64) -> Option<usize> {
    let block = ((position >> 20) & 0xF_FFFF) as usize;
    let label = func.computed_goto_targets.contains(&(block as u32));
    (label && position == code_position(func_idx, block, 0)).then_some(block)
}

/// `Inst::ImmExtCode` results carry this bit so `Inst::CallIndirect`
/// routes a call through an imported-function address (`&strcmp`)
/// to the libc dispatch by binding index rather than looking up a
/// c5 function body. The low bits hold the binding index.
pub(super) const IMPORT_ADDR_TAG: i64 = 0x2000_0000_0000_0000;

/// Byte-addressed memory backing the SSA-VM. Layout:
///
///   bytes[0..data_end]              -- read-only data segment
///   bytes[data_end..stack_end]      -- per-frame stack region;
///                                     `Frame::stack_base` /
///                                     `Frame::frame_size` bound
///                                     each call's slot bytes.
///   bytes[heap_base..heap_top]      -- bump-pointer heap;
///                                     `malloc` advances
///                                     `heap_top`, `free` is a
///                                     no-op (the SSA-VM is
///                                     short-lived). The whole
///                                     memory stays within
///                                     [`Memory::LIMIT`] bytes.
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
    /// First byte of the heap region (`data_end + STACK_BYTES`).
    /// Fixed at construction; `malloc` allocations start here
    /// and grow upward. Retained so a future `free`/`realloc`
    /// can resolve a pointer back to its allocator origin.
    heap_base: usize,
    /// Next free byte in the heap. C99 7.20.3.3 leaves `malloc`'s
    /// alignment unspecified except that it must suffice for any
    /// object; we round each allocation up to 16 bytes to match
    /// what host malloc implementations typically guarantee.
    heap_top: usize,
    /// First byte of the stack region (= `data_end`). Stack
    /// addresses are exempt from the allocations check since
    /// frames come and go on every call.
    stack_base: usize,
    /// Per-allocation registry; populated for every `malloc`
    /// regardless of `track_pointers` so the lists stay
    /// consistent across feature toggles.
    allocations: Vec<Allocation>,
    /// Monotonic allocation id; surfaces in error messages so
    /// the offending heap region is identifiable even after
    /// addresses get reused.
    next_alloc_id: u64,
    /// When true, every heap-side load / store / bulk-copy goes
    /// through `check_data_access`. Off by default; opt in via
    /// `run_program_with_args_tracked` (or the
    /// `Vm::with_pointer_tracking` constructor).
    track_pointers: bool,
    /// Base of the stdio block ([`STDIO_ERRNO`]) in the data image.
    stdio: usize,
    /// The interpreted target, whose `long` and `long double` formats and
    /// libc conventions the library shims follow.
    target: crate::c5::codegen::Target,
    /// The program's floating-point environment.
    fp: FpEnv,
    /// Where `strtok` resumes, 0 before its first call.
    strtok_next: usize,
    /// The open streams by the address of their `FILE` object.
    streams: alloc::collections::BTreeMap<usize, stream::Stream>,
    /// The "C" locale's strings and `struct lconv`, 0 before first use.
    locale: usize,
    /// The generator `rand` draws from.
    rand: system::Rand,
    /// The `strerror` messages installed so far, by error number.
    messages: alloc::collections::BTreeMap<i32, usize>,
}

/// Metadata for one heap allocation. The SSA-VM never reuses
/// heap addresses (the bump-pointer `heap_top` only grows), so
/// each allocation gets a fresh window recorded here. `free`
/// flips `freed`; subsequent loads / stores into the window
/// land in a `use-after-free` diagnostic.
#[derive(Clone, Debug)]
struct Allocation {
    start: usize,
    len: usize,
    freed: bool,
    id: u64,
}

/// Direction of a tracked access. Used purely for diagnostic
/// wording in `check_data_access`.
#[derive(Clone, Copy, Debug)]
enum AccessKind {
    Read,
    Write,
}

impl AccessKind {
    fn label(self) -> &'static str {
        match self {
            AccessKind::Read => "read",
            AccessKind::Write => "write",
        }
    }
}

impl Memory {
    /// `data` holds the stdio block's [`STDIO_BYTES`] at `stdio`.
    fn new(data: &[u8], stdio: usize, target: crate::c5::codegen::Target) -> Self {
        // Reserve a fixed 256 KiB stack region + 256 KiB heap.
        // C99 doesn't pin either limit; this sizing fits every
        // cargo fixture today.
        const STACK_BYTES: usize = 256 * 1024;
        const HEAP_BYTES: usize = 256 * 1024;
        let data_end = data.len();
        let total = data_end + STACK_BYTES + HEAP_BYTES;
        let mut bytes = Vec::with_capacity(total);
        bytes.extend_from_slice(data);
        bytes.resize(total, 0);
        let heap_base = data_end + STACK_BYTES;
        let mut mem = Self {
            bytes,
            data_end,
            stack_top: data_end,
            heap_base,
            heap_top: heap_base,
            stack_base: data_end,
            allocations: Vec::new(),
            next_alloc_id: 1,
            track_pointers: false,
            stdio: 0,
            target,
            fp: FpEnv::new(target),
            strtok_next: 0,
            streams: alloc::collections::BTreeMap::new(),
            locale: 0,
            rand: system::Rand::new(Libc::of(target)),
            messages: alloc::collections::BTreeMap::new(),
        };
        let base = stdio;
        for i in 0..3 {
            let file = (base + i * STDIO_FILE_BYTES) as u64;
            let slot = base + STDIO_SLOTS + i * 8;
            mem.bytes[slot..slot + 8].copy_from_slice(&file.to_le_bytes());
            mem.streams
                .insert(file as usize, stream::Stream::new(i as i64));
        }
        mem.stdio = base;
        mem
    }

    /// Memory over `data` with a stdio block appended.
    #[cfg(test)]
    fn with_stdio(data: &[u8], target: crate::c5::codegen::Target) -> Self {
        let mut data = data.to_vec();
        let stdio = reserve_stdio(&mut data);
        Self::new(&data, stdio, target)
    }

    /// The stdio block.
    fn stdio(&self) -> usize {
        self.stdio
    }

    /// The `FILE *` standard stream `i` (0, 1, 2) names: a program may
    /// assign another stream to it.
    fn std_stream(&self, i: usize) -> i64 {
        let at = self.stdio + STDIO_SLOTS + i * 8;
        i64::from_le_bytes(self.bytes[at..at + 8].try_into().unwrap())
    }

    /// Store `ENOMEM` in `errno`, as a failed allocation function does.
    fn set_enomem(&mut self) {
        self.set_errno(ENOMEM);
    }

    fn set_errno(&mut self, value: i32) {
        let at = self.stdio + STDIO_ERRNO;
        self.bytes[at..at + 4].copy_from_slice(&value.to_le_bytes());
    }

    fn with_track_pointers(mut self, on: bool) -> Self {
        self.track_pointers = on;
        self
    }

    fn record_allocation(&mut self, start: usize, len: usize) {
        let id = self.next_alloc_id;
        self.next_alloc_id += 1;
        self.allocations.push(Allocation {
            start,
            len,
            freed: false,
            id,
        });
    }

    /// Validate a `[addr, addr+len)` access. C99 doesn't pin
    /// dangling-pointer behavior, but mistaken accesses get
    /// surfaced here when `track_pointers` is on. Reads / writes
    /// into a freed allocation, past an allocation's end, or
    /// against a never-allocated heap byte each surface as a
    /// runtime error. Static data, stack frames, and zero-length
    /// reads are exempt.
    fn check_data_access(&self, addr: usize, len: usize, kind: AccessKind) -> Result<(), C5Error> {
        if !self.track_pointers || len == 0 {
            return Ok(());
        }
        if addr < self.data_end {
            return Ok(());
        }
        if (self.stack_base..self.heap_base).contains(&addr) {
            return Ok(());
        }
        for alloc in &self.allocations {
            if addr >= alloc.start && addr < alloc.start + alloc.len {
                if alloc.freed {
                    return Err(C5Error::Runtime(format!(
                        "use-after-free: {} access at 0x{addr:x} inside freed allocation #{} (start=0x{:x}, len={})",
                        kind.label(),
                        alloc.id,
                        alloc.start,
                        alloc.len
                    )));
                }
                if addr + len > alloc.start + alloc.len {
                    return Err(C5Error::Runtime(format!(
                        "out-of-bounds: {}-byte {} access at 0x{addr:x} runs past allocation #{} end=0x{:x}",
                        len,
                        kind.label(),
                        alloc.id,
                        alloc.start + alloc.len
                    )));
                }
                return Ok(());
            }
        }
        Err(C5Error::Runtime(format!(
            "out-of-bounds: {} access at 0x{addr:x} ({len} bytes) is not inside any live allocation",
            kind.label(),
        )))
    }

    /// Copy a byte slice into the heap, append a NUL byte, and
    /// return the base address of the resulting C string. Used by
    /// `getenv` / `dlerror`, which need to hand back a pointer
    /// into VM-addressable memory rather than into the host's
    /// process address space. Returns 0 if the heap is exhausted.
    fn install_cstring(&mut self, src: &[u8]) -> usize {
        let base = self.heap_alloc(src.len() as u64 + 1);
        if base == 0 {
            return 0;
        }
        self.bytes[base..base + src.len()].copy_from_slice(src);
        self.bytes[base + src.len()] = 0;
        base
    }

    /// Bytes the guest memory may span. A request past it, or past what
    /// the host reserves, is space that cannot be allocated, for which
    /// the allocation functions return a null pointer (C99 7.20.3).
    const LIMIT: u64 = 4 << 30;

    /// Bump-pointer `malloc`: the base of `n` fresh bytes, or 0 when the
    /// memory cannot grow to hold them. A zero-size request takes 16
    /// bytes, so each pointer returned is distinct (C99 7.20.3p1).
    fn heap_alloc(&mut self, n: u64) -> usize {
        let base = self.heap_top;
        let next = n
            .max(1)
            .checked_next_multiple_of(16)
            .and_then(|size| (base as u64).checked_add(size))
            .filter(|&end| end <= Self::LIMIT)
            .and_then(|end| usize::try_from(end).ok());
        let Some(next) = next else {
            return 0;
        };
        if next > self.bytes.len() {
            let more = next - self.bytes.len();
            if self.bytes.try_reserve(more).is_err() && self.bytes.try_reserve_exact(more).is_err()
            {
                return 0;
            }
            self.bytes.resize(next, 0);
        }
        // Zero the new region so a `malloc` caller doesn't read
        // a previous allocation's leftovers (C99 doesn't promise
        // zeroed memory but it's friendlier than uninitialised).
        self.bytes[base..next].fill(0);
        self.heap_top = next;
        self.record_allocation(base, n as usize);
        base
    }

    /// `n` bytes at `addr` set to `val`, checked as [`Self::write_bytes`]
    /// checks a store.
    fn fill_bytes(&mut self, addr: usize, val: u8, n: usize) -> Result<(), C5Error> {
        if addr.checked_add(n).is_none_or(|end| end > self.bytes.len()) {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: store: addr 0x{addr:x}, {n} bytes past memory len {}",
                self.bytes.len(),
            )));
        }
        self.bytes[addr..addr + n].fill(val);
        Ok(())
    }

    /// Size of the per-frame record: the link to the caller's record and
    /// the return address, in the native frame record's order.
    const FRAME_RECORD_BYTES: usize = 16;

    /// Reserve a frame of `frame_bytes` on a 16-byte boundary, so every
    /// 8-byte slot gives the guest an aligned address as a native frame
    /// does; the gap is reclaimed with the enclosing frame.
    fn alloc_frame(&mut self, frame_bytes: usize) -> Result<usize, C5Error> {
        let base = (self.stack_top + 15) & !15;
        let next = base.checked_add(frame_bytes).ok_or_else(|| {
            C5Error::Runtime(format!(
                "vm_ssa: stack overflow allocating {frame_bytes} bytes from {base}",
            ))
        })?;
        // Frames must stay inside [stack_base, heap_base); a frame
        // written past heap_base would zero live heap allocations.
        if next > self.heap_base {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: stack overflow: frame of {frame_bytes} bytes exceeds the \
                 {}-byte stack region",
                self.heap_base - self.stack_base,
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

    /// Reserve `bytes` of frame storage whose base offset into `bytes` is a
    /// multiple of `align` (a power of two). The interpreter's addresses are
    /// byte offsets, so an aligned base gives the guest an aligned pointer.
    /// The gap to the aligned base plus the region is reclaimed with the
    /// enclosing frame by `release_frame`. Backs over-aligned automatic
    /// objects (C11 6.7.5).
    fn alloc_aligned_frame(&mut self, align: usize, bytes: usize) -> Result<usize, C5Error> {
        let base = (self.stack_top + align - 1) & !(align - 1);
        let next = base.checked_add(bytes).ok_or_else(|| {
            C5Error::Runtime(format!(
                "vm_ssa: stack overflow allocating {bytes} aligned bytes from {}",
                self.stack_top,
            ))
        })?;
        if next > self.heap_base {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: stack overflow: aligned frame region of {bytes} bytes exceeds \
                 the {}-byte stack region",
                self.heap_base - self.stack_base,
            )));
        }
        for b in &mut self.bytes[self.stack_top..next] {
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
        // C99 doesn't mandate that the data segment be read-only;
        // global / static / BSS objects are writable. String
        // literals are UB-protected at the language level, not by
        // the runtime. Only out-of-bounds writes trip a runtime
        // error here.
        if addr + src.len() > self.bytes.len() {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: store: addr 0x{addr:x}..0x{:x} past memory len {}",
                addr + src.len(),
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
        // A struct assignment to a writable global / static (`g = f()`)
        // copies into the data segment, which holds writable objects. The
        // data segment is not runtime-protected: scalar `store` writes
        // there too (see its note), and writing a string literal is UB at
        // the language level. Only the out-of-bounds check above applies.
        self.bytes.copy_within(src..src + n, dst);
        Ok(())
    }
}

/// Multi-function program context. The SSA-VM walks
/// `Vec<FunctionSsa>`; `Inst::Call` resolves a callee by
/// `target_pc` through `ent_pc_to_idx`; `Inst::CallExt`
/// resolves a libc binding by index into `binding_names`.
struct Program<'a> {
    funcs: &'a [FunctionSsa],
    /// `ent_pc` -> index into `funcs`. Built once at program
    /// entry; `Inst::Call` does a constant-time lookup.
    ent_pc_to_idx: alloc::collections::BTreeMap<usize, usize>,
    /// Flat list of `local_name`s in `#pragma binding(...)`
    /// declaration order -- the same enumeration the parser
    /// used when assigning `Inst::CallExt::binding_idx`. The
    /// SSA-VM looks the name up and dispatches to the matching
    /// libc shim.
    binding_names: &'a [alloc::string::String],
    /// Byte offset within `Memory::bytes` where the thread-local
    /// block starts. `Inst::TlsAddr(off)` resolves to
    /// `tls_base + off`. The interpreter is single-threaded and
    /// the TLS block is appended onto the data segment per C11
    /// 7.5p1 (single-thread `_Thread_local` storage duration).
    tls_base: usize,
    /// The inline asm templates are AArch64's, not x86-64's.
    aarch64: bool,
    /// `--trace`: each executed instruction is printed to stderr.
    trace: bool,
}

impl<'a> Program<'a> {
    fn new(funcs: &'a [FunctionSsa], target: crate::c5::codegen::Target) -> Self {
        let ent_pc_to_idx = funcs
            .iter()
            .enumerate()
            .map(|(i, f)| (f.ent_pc, i))
            .collect();
        Self {
            funcs,
            ent_pc_to_idx,
            binding_names: &[],
            tls_base: 0,
            aarch64: target.is_aarch64(),
            trace: false,
        }
    }

    fn with_bindings(mut self, names: &'a [alloc::string::String]) -> Self {
        self.binding_names = names;
        self
    }

    fn with_tls_base(mut self, tls_base: usize) -> Self {
        self.tls_base = tls_base;
        self
    }

    fn with_trace(mut self, on: bool) -> Self {
        self.trace = on;
        self
    }

    fn lookup(&self, ent_pc: usize) -> Option<usize> {
        self.ent_pc_to_idx.get(&ent_pc).copied()
    }

    fn binding_name(&self, idx: i64) -> Result<&'a str, C5Error> {
        let i = usize::try_from(idx)
            .ok()
            .filter(|i| *i < self.binding_names.len())
            .ok_or_else(|| {
                C5Error::Runtime(format!(
                    "vm_ssa: CallExt: binding_idx {idx} out of range \
                     (program has {} bindings)",
                    self.binding_names.len(),
                ))
            })?;
        Ok(self.binding_names[i].as_str())
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
    /// Byte offset of this frame's record, just above its slots: the
    /// caller's record offset in its first eight bytes and the return
    /// address (a code position) in the next eight, both 0 for the entry
    /// frame. `Intrinsic::FrameAddress` answers with it, so a chained
    /// load walks callers the way it does on a native frame pointer, and
    /// `Intrinsic::ReturnAddress` reads the slot beside the link.
    record: usize,
    /// Index of `func` in `Program::funcs`: the function field of every
    /// code position this frame materializes.
    func_idx: usize,
    /// Total bytes the frame allocated; saved here so
    /// `release_frame` lines up with the alloc_frame returned by
    /// `Memory::alloc_frame`.
    frame_bytes: usize,
    /// Number of declared locals (slot offsets `-1..=-locals`).
    locals: usize,
    /// Base offset of the frame's realigned region (over-aligned automatic
    /// objects, C11 6.7.5), or 0 when the function has none. Each entry in
    /// `func.over_aligned` places its object at `realign_base + region_off`.
    realign_base: usize,
    block_idx: usize,
    /// The 128-, 256- and 512-bit values (`V128` / `V256` / `V512` loads,
    /// `Inst::VecBinop`), by `ValueId`, in the low bytes; their `regs`
    /// entries stay 0.
    vregs: alloc::collections::BTreeMap<ValueId, [u8; 64]>,
}

impl Frame<'_> {
    fn vbytes(&self, v: ValueId) -> Result<[u8; 64], C5Error> {
        self.vregs
            .get(&v)
            .copied()
            .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: v{v} is not a vector value")))
    }

    fn v128(&self, v: ValueId) -> Result<[u8; 16], C5Error> {
        Ok(self.vbytes(v)?[..16].try_into().unwrap())
    }

    /// Value `v`, the low `bytes.len()` bytes of the register.
    fn set_vbytes(&mut self, v: ValueId, bytes: &[u8]) {
        let mut b = [0u8; 64];
        b[..bytes.len()].copy_from_slice(bytes);
        self.regs[v as usize] = 0;
        self.vregs.insert(v, b);
    }

    fn set_v128(&mut self, v: ValueId, bytes: [u8; 16]) {
        self.set_vbytes(v, &bytes);
    }

    /// The link a call at instruction `call` of this frame hands `callee`.
    fn link_to(&self, callee: usize, call: ValueId) -> CallLink {
        let block = &self.func.blocks[self.block_idx];
        let offset = (call - block.inst_range.start + 1) as usize;
        CallLink {
            func_idx: callee,
            caller_record: self.record,
            return_address: code_position(self.func_idx, self.block_idx, offset),
        }
    }

    /// c5-slot offset -> byte address in `Memory::bytes`.
    ///
    /// The c5 cdecl assigns local slot `-N` (N >= 1) to byte
    /// address `bp - N*8`. Translating to this interpreter's
    /// frame (which grows up from `stack_base`, with bp
    /// conceptually at `stack_base + locals*8`) gives
    /// `stack_base + (locals - N) * 8`. The previous direction
    /// (`base + (N-1)*8`) inverted the order so a multi-slot
    /// array's footprint overlapped the next-declared local.
    fn slot_addr(&self, off: i64) -> Option<usize> {
        if off < 0 {
            // An over-aligned automatic object's storage is in the frame's
            // realigned region, not the fp-relative slot (C11 6.7.5).
            if self.realign_base != 0
                && let Some(m) = self.func.over_aligned.iter().find(|m| m.slot == off)
            {
                return Some(self.realign_base + m.off as usize);
            }
            let slot_n = (-off) as usize;
            (slot_n >= 1 && slot_n <= self.locals)
                .then_some(self.stack_base + (self.locals - slot_n) * 8)
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
/// with an empty data segment and a `NullHost`. `Inst::Call` in
/// this shape fails with a "not found" runtime error because
/// there's only one function.
pub(super) fn run_ssa(func: &FunctionSsa) -> Result<i64, C5Error> {
    let funcs = core::slice::from_ref(func);
    let mut host = NullHost;
    let target = crate::c5::codegen::Target::host();
    run_program(funcs, &[], &[], func.ent_pc, &mut host, target)
}

/// Multi-function entry: pick the function at `entry_pc` and run
/// it with no arguments. `Inst::Call` resolves callees through
/// `funcs`' `ent_pc` lookup; `Inst::ImmData(off)` indexes into
/// `data` for string-literal / global reads;
/// `Inst::CallExt(binding_idx, ...)` resolves `binding_idx`
/// into `binding_names` and dispatches to a libc shim that
/// either operates purely on `mem` or pumps IO through `host`.
pub(super) fn run_program<H: Host>(
    funcs: &[FunctionSsa],
    data: &[u8],
    binding_names: &[alloc::string::String],
    entry_pc: usize,
    host: &mut H,
    target: crate::c5::codegen::Target,
) -> Result<i64, C5Error> {
    run_program_with_args(funcs, data, binding_names, 0, entry_pc, host, &[], target)
}

/// Multi-function entry that stages `args` as `argv` for the
/// entry function. Per C99 5.1.2.2.1, `main` may be declared
/// either as `int main(void)` or `int main(int argc, char *argv[])`;
/// the parser emits the latter shape with `argc` at param slot 0
/// (frame slot 2) and `argv` at param slot 1 (frame slot 3).
/// When `args` is empty both pass through as 0; C99 5.1.2.2.1
/// allows that shape for a hosted program.
#[allow(clippy::too_many_arguments)]
pub(super) fn run_program_with_args<H: Host>(
    funcs: &[FunctionSsa],
    data: &[u8],
    binding_names: &[alloc::string::String],
    tls_base: usize,
    entry_pc: usize,
    host: &mut H,
    args: &[alloc::string::String],
    target: crate::c5::codegen::Target,
) -> Result<i64, C5Error> {
    let mut data = data.to_vec();
    let stdio = reserve_stdio(&mut data);
    run_program_with_args_tracked(
        funcs,
        (&data, stdio),
        binding_names,
        tls_base,
        entry_pc,
        host,
        args,
        false,
        false,
        &[],
        &[],
        target,
    )
}

/// Same as [`run_program_with_args`] with an explicit
/// `track_pointers` flag, which `super::Vm::with_pointer_tracking`
/// forwards for the watchful load / store / Mcpy checks, and the
/// `trace` flag `super::Vm::with_trace` forwards.
#[allow(clippy::too_many_arguments)]
pub(super) fn run_program_with_args_tracked<H: Host>(
    funcs: &[FunctionSsa],
    (data, stdio): (&[u8], usize),
    binding_names: &[alloc::string::String],
    tls_base: usize,
    entry_pc: usize,
    host: &mut H,
    args: &[alloc::string::String],
    track_pointers: bool,
    trace: bool,
    init_pcs: &[usize],
    fini_pcs: &[usize],
    target: crate::c5::codegen::Target,
) -> Result<i64, C5Error> {
    let too_large = funcs.len() >= CODE_POSITION_FIELD
        || funcs.iter().any(|f| {
            f.blocks.len() >= CODE_POSITION_FIELD
                || (f.blocks.iter()).any(|b| b.inst_range.len() >= CODE_POSITION_FIELD)
        });
    if too_large {
        return Err(C5Error::Runtime(
            "vm_ssa: the program has more functions, blocks or instructions in a block \
             than a code position encodes"
                .to_string(),
        ));
    }
    let prog = Program::new(funcs, target)
        .with_bindings(binding_names)
        .with_tls_base(tls_base)
        .with_trace(trace);
    let (data_with_argv, argc, argv_addr) = stage_argv(data, args);
    let mut mem = Memory::new(&data_with_argv, stdio, target).with_track_pointers(track_pointers);
    // `__attribute__((constructor))` functions run before the entry, in
    // the native `.init_array` order the caller already sorted. An
    // `exit()` from a constructor short-circuits to the exit status.
    for &pc in init_pcs {
        let ctor = prog
            .lookup(pc)
            .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: no constructor at ent_pc {pc}")))?;
        if let Err(e) = run_func(&prog, &mut mem, host, CallLink::entry(ctor), &[], &[]) {
            return match exit_status_of(&e) {
                Some(status) => Ok(status),
                None => Err(e),
            };
        }
    }
    let entry = prog.lookup(entry_pc).ok_or_else(|| {
        C5Error::Runtime(format!(
            "vm_ssa: run_program: no function at ent_pc {entry_pc}",
        ))
    })?;
    let entry_args: [i64; 2] = [argc, argv_addr];
    let slice: &[i64] = if prog.funcs[entry].n_params == 0 {
        &[]
    } else {
        &entry_args
    };
    let status = match run_func(&prog, &mut mem, host, CallLink::entry(entry), slice, &[]) {
        Err(e) => match exit_status_of(&e) {
            Some(status) => status,
            None => return Err(e),
        },
        Ok(v) => v,
    };
    // `__attribute__((destructor))` functions run in reverse after the
    // entry returns. The VM has no atexit chain, so an `exit()` path
    // does not reach these (documented in `Vm::fini_pcs`).
    for &pc in fini_pcs.iter().rev() {
        let dtor = prog
            .lookup(pc)
            .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: no destructor at ent_pc {pc}")))?;
        if let Err(e) = run_func(&prog, &mut mem, host, CallLink::entry(dtor), &[], &[]) {
            match exit_status_of(&e) {
                Some(s) => return Ok(s),
                None => return Err(e),
            }
        }
    }
    Ok(status)
}

/// `exit(status)` unwinds the interpreter through the `Result`
/// channel. The sentinel stays private to this module: it is
/// produced only by the `exit` shim and consumed at the program
/// boundary above, so it never surfaces as a user-visible error.
const EXIT_SIGNAL_PREFIX: &str = "vm_ssa-exit-status:";

fn exit_signal(status: i64) -> C5Error {
    C5Error::Runtime(format!("{EXIT_SIGNAL_PREFIX}{status}"))
}

fn exit_status_of(e: &C5Error) -> Option<i64> {
    match e {
        C5Error::Runtime(msg) => msg.strip_prefix(EXIT_SIGNAL_PREFIX)?.parse().ok(),
        _ => None,
    }
}

/// Lay out the argv strings + the argv pointer array at the end
/// of the data segment and return (data_with_argv, argc, argv_addr).
/// argc and argv_addr are both 0 when `args` is empty; a `main`
/// declared without parameters ignores them either way.
fn stage_argv(data: &[u8], args: &[alloc::string::String]) -> (Vec<u8>, i64, i64) {
    let mut out = data.to_vec();
    if args.is_empty() {
        return (out, 0, 0);
    }
    if out.is_empty() {
        out.resize(8, 0);
    }
    let argc = args.len();
    let argv_addr = out.len();
    out.resize(argv_addr + (argc + 1) * 8, 0);
    let mut entries: Vec<i64> = Vec::with_capacity(argc);
    for arg in args {
        let start = out.len();
        out.extend_from_slice(arg.as_bytes());
        out.push(0);
        entries.push(start as i64);
    }
    for (i, &addr) in entries.iter().enumerate() {
        let slot = argv_addr + i * 8;
        out[slot..slot + 8].copy_from_slice(&addr.to_le_bytes());
    }
    (out, argc as i64, argv_addr as i64)
}

/// Host trait stand-in for SSA-VM call sites that don't route
/// IO -- the regression tests for pure-math fixtures. Returns
/// EBADF-shaped errors on every syscall so a stray call surfaces
/// loudly.
struct NullHost;

impl Host for NullHost {
    fn read(&mut self, _fd: i64, _buf: &mut [u8]) -> i64 {
        -1
    }
    fn write(&mut self, _fd: i64, _buf: &[u8]) -> i64 {
        -1
    }
    fn open(&mut self, _path: &str) -> i64 {
        -1
    }
    fn close(&mut self, _fd: i64) -> i64 {
        -1
    }
    fn getenv(&mut self, _name: &str) -> Option<alloc::string::String> {
        None
    }
    fn setenv(&mut self, _name: &str, _value: &str, _overwrite: super::super::host::Overwrite) {}
    fn dlopen(&mut self, _path: Option<&str>, _flags: i64) -> i64 {
        0
    }
    fn dlsym(&mut self, _handle: i64, _name: &str) -> i64 {
        0
    }
    fn dlclose(&mut self, _handle: i64) -> i64 {
        -1
    }
    fn dlerror(&mut self) -> Option<alloc::string::String> {
        None
    }
}

/// What a call hands the callee's frame: the callee and the two words
/// its frame record holds, the caller's record and the position the
/// callee returns to. Both words are 0 for a frame the program entry
/// runs.
#[derive(Clone, Copy)]
struct CallLink {
    func_idx: usize,
    caller_record: usize,
    return_address: i64,
}

impl CallLink {
    fn entry(func_idx: usize) -> Self {
        Self {
            func_idx,
            caller_record: 0,
            return_address: 0,
        }
    }
}

/// Run one function in the program context. `args` lands in the
/// parameter byte slots per the c5 cdecl: arg `i` at
/// `stack_base + (locals + i) * 8`.
///
/// `arg_aggs` is the call site's per-argument aggregate tagging, which
/// says how an aggregate argument was passed: an entry names the
/// layout when the operand is the address of the caller's copy, and is
/// unset when the operand is the aggregate's value in one machine
/// word. Empty for a call with no aggregate argument and for the
/// program entry.
fn run_func<H: Host>(
    prog: &Program<'_>,
    mem: &mut Memory,
    host: &mut H,
    link: CallLink,
    args: &[i64],
    arg_aggs: &[Option<u32>],
) -> Result<i64, C5Error> {
    let func = &prog.funcs[link.func_idx];
    let locals = func.locals.max(0) as usize;
    let n_params = func.n_params.max(args.len());
    let frame_bytes = (locals + n_params) * 8;
    // The record sits above the slots: the arena grows up, so that keeps
    // the frame-address proxy above the stack-pointer one, as on a native
    // stack.
    let stack_base = mem.alloc_frame(frame_bytes + Memory::FRAME_RECORD_BYTES)?;
    let record = stack_base + frame_bytes;
    mem.write_bytes(record, &(link.caller_record as u64).to_le_bytes())?;
    mem.write_bytes(record + 8, &link.return_address.to_le_bytes())?;
    // C11 6.7.5: reserve the aligned region for over-aligned automatic objects
    // above this frame; `release_frame(stack_base)` reclaims it on return.
    let realign_base = if func.over_aligned.is_empty() {
        0
    } else {
        mem.alloc_aligned_frame(
            func.frame_align as usize,
            func.realign_region_bytes as usize,
        )?
    };
    let mut frame = Frame {
        func,
        regs: alloc::vec![i64::MIN; func.insts.len()],
        stack_base,
        record,
        func_idx: link.func_idx,
        frame_bytes,
        locals,
        realign_base,
        block_idx: 0,
        vregs: alloc::collections::BTreeMap::new(),
    };
    for (i, &v) in args.iter().enumerate() {
        // Host-ABI register-passed aggregate parameter. The callee body
        // reads the aggregate from a parser-reserved body local (no entry
        // copy in the SSA), so fill that local here -- the native
        // prologue's register scatter, in interpreter terms.
        if let Some(Some(idx)) = func.param_aggs.get(i).copied() {
            let size = func.agg_descs[idx as usize].size as usize;
            let slot = func.param_local_slots[i];
            let dst = frame.slot_addr(slot).ok_or_else(|| {
                C5Error::Runtime(format!(
                    "vm_ssa: aggregate parameter {i}: slot {slot} out of range"
                ))
            })?;
            if arg_aggs.get(i).copied().flatten().is_some() {
                // Address form: `v` is the caller's copy.
                mem.copy_within(dst, v as usize, size)?;
            } else {
                // Value form: the callee's parameter list was not in scope
                // at the call site, so the walker loaded an aggregate of at
                // most one machine word into `v`. The word is the object's
                // bytes, not its address.
                let bytes = v.to_le_bytes();
                mem.write_bytes(dst, &bytes[..size.min(bytes.len())])?;
            }
            continue;
        }
        let addr = stack_base + (locals + i) * 8;
        mem.write_bytes(addr, &v.to_le_bytes())?;
    }
    let result: Result<i64, C5Error> = loop {
        let block = &frame.func.blocks[frame.block_idx];
        let mut step_err: Option<C5Error> = None;
        for v in block.inst_range.clone() {
            #[cfg(feature = "std")]
            if prog.trace {
                let inst = &frame.func.insts[v as usize];
                std::eprintln!("{} b{} v{v} {inst:?}", frame.func.name, frame.block_idx);
            }
            if let Err(e) = run_inst(prog, mem, host, &mut frame, v) {
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
            Terminator::GotoIndirect { target } => {
                // GNU C labels as values: the operand must be the address
                // of a label in this function; any other jump is undefined
                // and stops the run.
                let raw = frame.regs[target as usize];
                let Some(block) = label_block(frame.func, frame.func_idx, raw) else {
                    break Err(C5Error::Runtime(format!(
                        "vm_ssa: goto *: 0x{raw:x} is not the address of a label in this function"
                    )));
                };
                frame.block_idx = block;
            }
            Terminator::JumpTable { idx, table } => {
                // The lowering's bounds check proves the index in
                // range; an out-of-range value here is a lowering bug.
                let i = frame.regs[idx as usize] as u64 as usize;
                let Some(&t) = frame
                    .func
                    .jump_tables
                    .get(table as usize)
                    .and_then(|tbl| tbl.get(i))
                else {
                    break Err(C5Error::Runtime(alloc::format!(
                        "vm_ssa: JumpTable index {i} out of range"
                    )));
                };
                frame.block_idx = t as usize;
            }
            Terminator::TailExt(_) => {
                break Err(C5Error::Runtime(
                    "vm_ssa: Terminator::TailExt not implemented".to_string(),
                ));
            }
            Terminator::AsmGoto { .. } => {
                // The template's label branches have no interpreted
                // form; asm goto is native-only.
                break Err(C5Error::Runtime(
                    "vm_ssa: asm goto is not supported by the interpreter".to_string(),
                ));
            }
            Terminator::Unreachable => {
                // Sealed after a noreturn call; reaching it means the call
                // returned when it should not have.
                break Err(C5Error::Runtime(
                    "vm_ssa: reached Terminator::Unreachable".to_string(),
                ));
            }
        }
    };
    mem.release_frame(stack_base);
    result
}

/// Materialize a call's result. For a host-ABI aggregate return,
/// `ret` is the callee's struct address (in its just-released frame,
/// bytes intact); copy the aggregate into the caller's result temp at
/// `ret_slot` and yield the temp's address. A scalar return passes
/// `ret` through unchanged.
fn finish_agg_return(
    frame: &Frame<'_>,
    mem: &mut Memory,
    ret_agg: Option<u32>,
    ret_slot_local: i64,
    ret: i64,
) -> Result<i64, C5Error> {
    let Some(ai) = ret_agg else {
        return Ok(ret);
    };
    let size = frame.func.agg_descs[ai as usize].size as usize;
    let dst = frame.slot_addr(ret_slot_local).ok_or_else(|| {
        C5Error::Runtime(format!(
            "vm_ssa: aggregate return: slot {ret_slot_local} out of range"
        ))
    })?;
    mem.copy_within(dst, ret as usize, size)?;
    Ok(dst as i64)
}

/// A call of the interpreter's C library function `name`. A result the
/// caller takes as an object (`ret_agg`), a `long double` wider than
/// `double`, is returned as the object's address.
struct LibraryCall<'a> {
    name: &'a str,
    ret_agg: Option<u32>,
    ret_slot_local: i64,
}

/// Run `call` with the values of `args`, made at instruction `v` of
/// `frame`. The sorting and searching functions call the program's
/// comparison function back from there.
fn call_library<H: Host>(
    prog: &Program<'_>,
    mem: &mut Memory,
    host: &mut H,
    frame: &Frame<'_>,
    v: ValueId,
    call: LibraryCall<'_>,
    args: &[ValueId],
) -> Result<i64, C5Error> {
    let arg_vals: Vec<i64> = args.iter().map(|&a| frame.regs[a as usize]).collect();
    let mut compare = |mem: &mut Memory, f: i64, operands: &[i64]| -> Result<i64, C5Error> {
        if f & IMPORT_ADDR_TAG != 0 {
            let name = prog.binding_name(f & !IMPORT_ADDR_TAG)?;
            return dispatch_callext(name, operands, mem, host);
        }
        let link = frame.link_to(function_at(prog, f)?, v);
        run_func(prog, mem, host, link, operands, &[])
    };
    let ret = match sort::call(call.name, &arg_vals, mem, &mut compare) {
        Some(r) => r?,
        None => dispatch_callext(call.name, &arg_vals, mem, host)?,
    };
    finish_agg_return(frame, mem, call.ret_agg, call.ret_slot_local, ret)
}

/// The function a function pointer value `raw` designates, by its index:
/// `Inst::ImmCode` tags it with `CODE_ADDR_TAG`, a static initializer's
/// slot with the `CODE_BASE` bias. A label or a return address is no
/// function.
fn function_at(prog: &Program<'_>, raw: i64) -> Result<usize, C5Error> {
    let position = CODE_ADDR_TAG | CODE_POSITION_TAG;
    let target_pc = if raw & position == position {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: CallIndirect: target 0x{raw:016x} is a label or return address, \
             not a function",
        )));
    } else if raw & CODE_ADDR_MASK != 0 {
        (raw & !CODE_ADDR_MASK) as usize
    } else if (raw as usize) >= super::super::CODE_BASE {
        (raw as usize) - super::super::CODE_BASE
    } else {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: CallIndirect: target raw=0x{raw:016x} is not a code pointer",
        )));
    };
    prog.lookup(target_pc).ok_or_else(|| {
        C5Error::Runtime(format!(
            "vm_ssa: CallIndirect: no function at ent_pc {target_pc}",
        ))
    })
}

/// Build the callee's flat argument list. A variadic by-value
/// aggregate (`arg_aggs[i]` set, `i` past the fixed parameters) is
/// expanded into its eightbytes so the callee's `va_arg`, which
/// advances by the aggregate's span, reads them contiguously. A fixed
/// struct parameter stays its source address; `run_func`'s
/// `param_aggs` scatter copies it into the body local.
///
/// A `float`-typed argument's cell carries the f32 bit pattern: the
/// callee reads it back with `ParamRef { F32 }` / `LoadLocal { F32 }`
/// (native callers store the s-register view the same way). The
/// interpreter's register convention holds every f32 value as the f64
/// pattern of its single-precision value, so narrow at the cell
/// boundary.
fn collect_call_args(
    frame: &Frame<'_>,
    mem: &Memory,
    args: &[ValueId],
    arg_aggs: &[Option<u32>],
    fixed_args: usize,
) -> Result<alloc::vec::Vec<i64>, C5Error> {
    let mut out = alloc::vec::Vec::with_capacity(args.len());
    for (i, &a) in args.iter().enumerate() {
        let val = frame.regs[a as usize];
        if i >= fixed_args
            && let Some(Some(idx)) = arg_aggs.get(i).copied()
        {
            let size = frame.func.agg_descs[idx as usize].size as usize;
            let mut off = 0usize;
            while off < size {
                out.push(load_from_memory(mem, (val as usize) + off, LoadKind::I64)?);
                off += 8;
            }
            continue;
        }
        if matches!(frame.func.f32_values.get(a as usize), Some(true)) {
            out.push(i64::from(super::fenv::reg_to_f32(val as u64)));
            continue;
        }
        out.push(val);
    }
    Ok(out)
}

fn run_inst<H: Host>(
    prog: &Program<'_>,
    mem: &mut Memory,
    host: &mut H,
    frame: &mut Frame<'_>,
    v: ValueId,
) -> Result<(), C5Error> {
    let inst = &frame.func.insts[v as usize];
    let name = match inst {
        Inst::Imm(k) => {
            // An f32-marked imm carries the f32 bit pattern (the shape
            // the native emit materializes); the interpreter's register
            // convention keeps every f32 value as the f64 pattern of
            // its single-precision value, so widen at the definition.
            frame.regs[v as usize] = if matches!(frame.func.f32_values.get(v as usize), Some(true))
            {
                super::fenv::f32_to_reg(*k as u32) as i64
            } else {
                *k
            };
            return Ok(());
        }
        // Any value is the indeterminate one; zero, as the native lowering.
        Inst::Undef => {
            frame.regs[v as usize] = 0;
            return Ok(());
        }
        Inst::ImmData(off) => {
            // Data-segment offset lands directly in the
            // byte-addressed memory; `ImmData(off)` returns the
            // real address (which sits below `mem.data_end`).
            frame.regs[v as usize] = *off;
            return Ok(());
        }
        Inst::ExceptionCode | Inst::ParentLocalAddr { .. } => {
            unreachable!("the interpreter refuses a `__try` region")
        }
        Inst::ImmCode(target_pc) => {
            // Code pointers don't map to bytes; tag with
            // `CODE_ADDR_TAG` so `CallIndirect` recognizes them.
            frame.regs[v as usize] = CODE_ADDR_TAG | (*target_pc as i64);
            return Ok(());
        }
        Inst::ImmExtCode(binding_idx) => {
            // Address of an imported function (`&strcmp`). The VM has
            // no native code for libc, so the pointer carries the
            // binding index under `IMPORT_ADDR_TAG`; `CallIndirect`
            // routes it to the libc dispatch.
            frame.regs[v as usize] = IMPORT_ADDR_TAG | *binding_idx;
            return Ok(());
        }
        Inst::BlockAddr(b) => {
            // Label address (GNU C `&&label`): the code position at the
            // start of the label's block, which GotoIndirect decodes.
            frame.regs[v as usize] = code_position(frame.func_idx, *b as usize, 0);
            return Ok(());
        }
        Inst::LocalAddr(off) => {
            let addr = frame.slot_addr(*off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: LocalAddr: slot {off} out of range"))
            })?;
            frame.regs[v as usize] = addr as i64;
            return Ok(());
        }
        Inst::TlsAddr(off) => {
            // C11 7.5: the implementation chooses where the
            // thread-local block lives. The VM is single-threaded;
            // we concatenate the TLS block onto the data segment
            // at `Program::tls_base` so a TLS address is just a
            // regular data-segment offset.
            frame.regs[v as usize] = (prog.tls_base as i64).wrapping_add(*off);
            return Ok(());
        }
        Inst::Load {
            addr, disp, kind, ..
        } => {
            let a = frame.regs[*addr as usize].wrapping_add(*disp as i64);
            if a & CODE_ADDR_MASK != 0
                || a < 0
                || ((a as usize) >= super::super::CODE_BASE
                    && (a as usize) < super::super::CODE_BASE + (1usize << 20))
            {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: Load: addr 0x{a:016x} is not a data pointer (code is not data)",
                )));
            }
            mem.check_data_access(a as usize, load_width(*kind), AccessKind::Read)?;
            if matches!(kind, LoadKind::V128 | LoadKind::V256 | LoadKind::V512) {
                let bytes = mem.read_bytes(a as usize, load_width(*kind))?;
                frame.set_vbytes(v, bytes);
                return Ok(());
            }
            frame.regs[v as usize] = load_from_memory(mem, a as usize, *kind)?;
            return Ok(());
        }
        Inst::Store {
            addr,
            disp,
            value,
            kind,
            ..
        } => {
            let a = frame.regs[*addr as usize].wrapping_add(*disp as i64);
            if a & CODE_ADDR_MASK != 0
                || a < 0
                || ((a as usize) >= super::super::CODE_BASE
                    && (a as usize) < super::super::CODE_BASE + (1usize << 20))
            {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: Store: addr 0x{a:016x} is not a data pointer (code is not data)",
                )));
            }
            mem.check_data_access(a as usize, store_width(*kind), AccessKind::Write)?;
            if matches!(kind, StoreKind::V128 | StoreKind::V256 | StoreKind::V512) {
                let bytes = frame.vbytes(*value)?;
                mem.write_bytes(a as usize, &bytes[..store_width(*kind)])?;
                return Ok(());
            }
            let stored = narrow_store(frame.regs[*value as usize], *kind);
            store_to_memory(mem, a as usize, stored, *kind)?;
            // c5 Store leaves the stored value in the accumulator;
            // downstream uses of this Inst id read that value.
            frame.regs[v as usize] = stored;
            return Ok(());
        }
        Inst::LoadLocal {
            off, disp, kind, ..
        } => {
            let addr = frame
                .slot_addr(*off)
                .map(|a| (a as i64 + i64::from(*disp)) as usize)
                .ok_or_else(|| {
                    C5Error::Runtime(format!("vm_ssa: LoadLocal: slot {off} out of range"))
                })?;
            frame.regs[v as usize] = load_from_memory(mem, addr, *kind)?;
            return Ok(());
        }
        Inst::StoreLocal {
            off,
            disp,
            value,
            kind,
            ..
        } => {
            let addr = frame
                .slot_addr(*off)
                .map(|a| (a as i64 + i64::from(*disp)) as usize)
                .ok_or_else(|| {
                    C5Error::Runtime(format!("vm_ssa: StoreLocal: slot {off} out of range"))
                })?;
            let stored = narrow_store(frame.regs[*value as usize], *kind);
            store_to_memory(mem, addr, stored, *kind)?;
            frame.regs[v as usize] = stored;
            return Ok(());
        }
        Inst::Mcpy { dst, src, size, .. } => {
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
            mem.check_data_access(src_addr as usize, *size as usize, AccessKind::Read)?;
            mem.check_data_access(dst_addr as usize, *size as usize, AccessKind::Write)?;
            mem.copy_within(dst_addr as usize, src_addr as usize, *size as usize)?;
            // Mcpy returns the destination address (c5 model).
            frame.regs[v as usize] = dst_addr;
            return Ok(());
        }
        Inst::Mzero { dst, size, .. } => {
            let dst_addr = frame.regs[*dst as usize];
            if dst_addr & CODE_ADDR_MASK != 0 {
                return Err(C5Error::Runtime(
                    "vm_ssa: Mzero: dst is a code pointer".to_string(),
                ));
            }
            if dst_addr < 0 || *size < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: Mzero: bad operands (dst=0x{dst_addr:x}, size={size})",
                )));
            }
            mem.check_data_access(dst_addr as usize, *size as usize, AccessKind::Write)?;
            mem.fill_bytes(dst_addr as usize, 0, *size as usize)?;
            return Ok(());
        }
        Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
            ..
        } => {
            // C11 7.17.7. The interpreter is single-threaded, so a
            // load-op-store reproduces the architectural effect, whatever
            // the order; the prior contents are the result (7.17.7p2).
            let a = frame.regs[*addr as usize];
            let operand = frame.regs[*value as usize];
            atomic_addr_check(a, "AtomicRmw")?;
            let (lk, sk) = atomic_kinds(*width);
            mem.check_data_access(a as usize, *width as usize, AccessKind::Read)?;
            mem.check_data_access(a as usize, *width as usize, AccessKind::Write)?;
            let old = load_from_memory(mem, a as usize, lk)?;
            let new = match op {
                AtomicRmwOp::Xchg => operand,
                AtomicRmwOp::Add => old.wrapping_add(operand),
                AtomicRmwOp::Sub => old.wrapping_sub(operand),
                AtomicRmwOp::And => old & operand,
                AtomicRmwOp::Or => old | operand,
                AtomicRmwOp::Xor => old ^ operand,
            };
            store_to_memory(mem, a as usize, narrow_store(new, sk), sk)?;
            frame.regs[v as usize] = old;
            return Ok(());
        }
        Inst::AtomicCas {
            addr,
            expected,
            desired,
            width,
            ..
        } => {
            // C11 7.17.7.4. Single-threaded: load, compare the low `width`
            // bytes with the comparand's, store `desired` on a match. The
            // prior contents, zero-extended, are the result.
            let a = frame.regs[*addr as usize];
            atomic_addr_check(a, "AtomicCas")?;
            let (_, sk) = atomic_kinds(*width);
            mem.check_data_access(a as usize, *width as usize, AccessKind::Read)?;
            mem.check_data_access(a as usize, *width as usize, AccessKind::Write)?;
            let cur = load_from_memory(mem, a as usize, atomic_load_kind(*width))?;
            let mask = if *width < 8 {
                (1i64 << (8 * *width)) - 1
            } else {
                -1
            };
            if cur == frame.regs[*expected as usize] & mask {
                let des = frame.regs[*desired as usize];
                store_to_memory(mem, a as usize, narrow_store(des, sk), sk)?;
            }
            frame.regs[v as usize] = cur;
            return Ok(());
        }
        Inst::AtomicCas16 {
            addr,
            expected,
            desired,
            ..
        } => {
            // C11 7.17.7.4 on 16 bytes, single-threaded: compare the object
            // with the comparand, store the replacement on a match, else
            // write the prior contents over the comparand.
            let a = frame.regs[*addr as usize];
            let (e, d) = (
                frame.regs[*expected as usize],
                frame.regs[*desired as usize],
            );
            atomic_addr_check(a, "AtomicCas16")?;
            let pair = |mem: &mut Memory, at: i64| -> Result<[i64; 2], C5Error> {
                Ok([
                    load_from_memory(mem, at as usize, LoadKind::I64)?,
                    load_from_memory(mem, at as usize + 8, LoadKind::I64)?,
                ])
            };
            mem.check_data_access(a as usize, 16, AccessKind::Read)?;
            mem.check_data_access(a as usize, 16, AccessKind::Write)?;
            let cur = pair(mem, a)?;
            let matched = cur == pair(mem, e)?;
            let (to, val) = if matched {
                (a, pair(mem, d)?)
            } else {
                (e, cur)
            };
            store_to_memory(mem, to as usize, val[0], StoreKind::I64)?;
            store_to_memory(mem, to as usize + 8, val[1], StoreKind::I64)?;
            frame.regs[v as usize] = i64::from(matched);
            return Ok(());
        }
        // C11 7.17.7.1 / 7.17.7.2. The order has no effect in the
        // single-threaded interpreter; the load zero-extends as the
        // native access does.
        Inst::AtomicLoad { addr, width, .. } => {
            let a = frame.regs[*addr as usize];
            atomic_addr_check(a, "AtomicLoad")?;
            mem.check_data_access(a as usize, *width as usize, AccessKind::Read)?;
            frame.regs[v as usize] = load_from_memory(mem, a as usize, atomic_load_kind(*width))?;
            return Ok(());
        }
        Inst::AtomicStore {
            addr, value, width, ..
        } => {
            let a = frame.regs[*addr as usize];
            atomic_addr_check(a, "AtomicStore")?;
            let (_, sk) = atomic_kinds(*width);
            mem.check_data_access(a as usize, *width as usize, AccessKind::Write)?;
            let stored = narrow_store(frame.regs[*value as usize], sk);
            store_to_memory(mem, a as usize, stored, sk)?;
            return Ok(());
        }
        Inst::LoadIndexed { .. } => "LoadIndexed",
        Inst::StoreIndexed { .. } => "StoreIndexed",
        Inst::Binop { op, lhs, rhs } => {
            let lv = frame.regs[*lhs as usize];
            let rv = frame.regs[*rhs as usize];
            frame.regs[v as usize] = binop(&mut mem.fp, *op, lv, rv, format_of(frame, v))?;
            return Ok(());
        }
        Inst::BinopI { op, lhs, rhs_imm } => {
            let lv = frame.regs[*lhs as usize];
            frame.regs[v as usize] = binop(&mut mem.fp, *op, lv, *rhs_imm, format_of(frame, v))?;
            return Ok(());
        }
        Inst::Neg(src) => {
            frame.regs[v as usize] = frame.regs[*src as usize].wrapping_neg();
            return Ok(());
        }
        Inst::Fneg(src) => {
            let raw = frame.regs[*src as usize];
            let neg = eval::eval_fneg(raw);
            frame.regs[v as usize] = round_if_f32(neg, frame.func.f32_values.get(v as usize));
            return Ok(());
        }
        Inst::Bswap { value, width } => {
            frame.regs[v as usize] = eval::eval_bswap(frame.regs[*value as usize], *width);
            return Ok(());
        }
        Inst::BitCount { op, value, width } => {
            frame.regs[v as usize] = eval::eval_bit_count(*op, frame.regs[*value as usize], *width);
            return Ok(());
        }
        Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => {
            let negate = |x: i64, neg: bool| x as u64 ^ (u64::from(neg) << 63);
            let a = negate(frame.regs[*a as usize], *neg_product);
            let c = negate(frame.regs[*c as usize], *neg_addend);
            let f = format_of(frame, v);
            frame.regs[v as usize] = mem.fp.fma(a, frame.regs[*b as usize] as u64, c, f) as i64;
            return Ok(());
        }
        Inst::Udiv128 { hi, lo, divisor } => {
            let (h, l, d) = (
                frame.regs[*hi as usize],
                frame.regs[*lo as usize],
                frame.regs[*divisor as usize],
            );
            let Some(q) = eval::udiv128(h, l, d) else {
                return Err(C5Error::Runtime(
                    "vm_ssa: 128-by-64 division overflow".into(),
                ));
            };
            frame.regs[v as usize] = q;
            return Ok(());
        }
        Inst::MulAdd {
            a,
            b,
            c,
            neg_product,
        } => {
            let product = frame.regs[*a as usize].wrapping_mul(frame.regs[*b as usize]);
            let c = frame.regs[*c as usize];
            frame.regs[v as usize] = if *neg_product {
                c.wrapping_sub(product)
            } else {
                c.wrapping_add(product)
            };
            return Ok(());
        }
        Inst::ShiftOp {
            op,
            lhs,
            rhs,
            shift,
            amount,
        } => {
            let eval = |op, a, b| crate::c5::ir::eval_int_binop(op, a, b).unwrap_or(0);
            let shifted = eval(*shift, frame.regs[*rhs as usize], i64::from(*amount));
            frame.regs[v as usize] = eval(*op, frame.regs[*lhs as usize], shifted);
            return Ok(());
        }
        Inst::BitField {
            value,
            lsb,
            width,
            signed,
        } => {
            let x = frame.regs[*value as usize];
            frame.regs[v as usize] = crate::c5::ir::eval_bit_field(x, *lsb, *width, *signed);
            return Ok(());
        }
        Inst::Extend { value, kind, .. } => {
            let raw = frame.regs[*value as usize];
            frame.regs[v as usize] = eval::eval_extend(raw, *kind);
            return Ok(());
        }
        Inst::Copy { value, .. } => {
            frame.regs[v as usize] = frame.regs[*value as usize];
            return Ok(());
        }
        Inst::Select { cond, a, b, .. } => {
            let c = frame.regs[*cond as usize];
            let low_word = matches!(frame.func.cmp32.get(v as usize), Some(true));
            let pick = if (if low_word { c as u32 as i64 } else { c }) != 0 {
                a
            } else {
                b
            };
            frame.regs[v as usize] = frame.regs[*pick as usize];
            return Ok(());
        }
        Inst::FpCast { kind, value } => {
            let raw = frame.regs[*value as usize];
            let f = format_of(frame, v);
            let fp = &mut mem.fp;
            frame.regs[v as usize] = match kind {
                FpCastKind::FpToInt => fp.float_to_int(raw as u64, true),
                FpCastKind::UFpToInt => fp.float_to_int(raw as u64, false),
                FpCastKind::IntToFp => fp.int_to_float(i128::from(raw), f) as i64,
                FpCastKind::UIntToFp => fp.int_to_float(i128::from(raw as u64), f) as i64,
                FpCastKind::F32ToF64 => fp.widen(raw as u64) as i64,
                FpCastKind::F64ToF32 => fp.narrow(raw as u64) as i64,
                FpCastKind::FpBits | FpCastKind::BitsFp => raw,
            };
            return Ok(());
        }
        Inst::Call {
            target_pc,
            args,
            fixed_args,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => {
            let callee = prog.lookup(*target_pc).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: Call: no function at ent_pc {target_pc}",))
            })?;
            let arg_vals = collect_call_args(frame, mem, args, arg_aggs, *fixed_args)?;
            let link = frame.link_to(callee, v);
            let ret = run_func(prog, mem, host, link, &arg_vals, arg_aggs)?;
            frame.regs[v as usize] = finish_agg_return(frame, mem, *ret_agg, *ret_slot_local, ret)?;
            return Ok(());
        }
        Inst::CallIndirect {
            target,
            args,
            fixed_args,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } => {
            let raw = frame.regs[*target as usize];
            // A call through the address of an imported function
            // (`Inst::ImmExtCode`, `fp = strcmp; fp(...)`) carries the
            // binding index under `IMPORT_ADDR_TAG`; dispatch it the
            // same way `Inst::CallExt` resolves a libc binding.
            if raw & IMPORT_ADDR_TAG != 0 {
                let name = prog.binding_name(raw & !IMPORT_ADDR_TAG)?;
                let (agg, slot) = (*ret_agg, *ret_slot_local);
                let call = LibraryCall {
                    name,
                    ret_agg: agg,
                    ret_slot_local: slot,
                };
                frame.regs[v as usize] = call_library(prog, mem, host, frame, v, call, args)?;
                return Ok(());
            }
            let callee = function_at(prog, raw)?;
            let arg_vals = collect_call_args(frame, mem, args, arg_aggs, *fixed_args)?;
            let link = frame.link_to(callee, v);
            let ret = run_func(prog, mem, host, link, &arg_vals, arg_aggs)?;
            frame.regs[v as usize] = finish_agg_return(frame, mem, *ret_agg, *ret_slot_local, ret)?;
            return Ok(());
        }
        Inst::CallExt {
            binding_idx,
            args,
            ret_agg,
            ret_slot_local,
            ..
        } => {
            let call = LibraryCall {
                name: prog.binding_name(*binding_idx)?,
                ret_agg: *ret_agg,
                ret_slot_local: *ret_slot_local,
            };
            frame.regs[v as usize] = call_library(prog, mem, host, frame, v, call, args)?;
            return Ok(());
        }
        Inst::TailExt(_) => "TailExt",
        Inst::Intrinsic { kind, args } => {
            run_intrinsic(mem, frame, v, *kind, args)?;
            return Ok(());
        }
        Inst::Simd { op, imm, args } => {
            run_x86_simd(mem, frame, *op, *imm, args)?;
            return Ok(());
        }
        // The -O rewrites producing these never reach the VM.
        Inst::SimdVal { .. } => "SimdVal",
        Inst::VecInsert { .. } => "VecInsert",
        Inst::VecSplat { .. } => "VecSplat",
        Inst::VecConst { .. } => "VecConst",
        Inst::VecExtract { .. } => "VecExtract",
        Inst::VecBinop {
            op,
            lane,
            bytes,
            lhs,
            rhs,
        } => {
            if *bytes == 8 {
                // The 8-byte operands are the bits of their registers.
                let wide = |x: i64| {
                    let mut b = [0u8; 16];
                    b[..8].copy_from_slice(&x.to_le_bytes());
                    b
                };
                let (a, c) = (frame.regs[*lhs as usize], frame.regs[*rhs as usize]);
                let r = vec_binop(*op, *lane, wide(a), wide(c));
                frame.regs[v as usize] = i64::from_le_bytes(r[..8].try_into().unwrap());
            } else {
                // A wider operation is the 128-bit one on each 16 bytes.
                let (a, c) = (frame.vbytes(*lhs)?, frame.vbytes(*rhs)?);
                let n = usize::from(*bytes);
                let mut r = [0u8; 64];
                for h in (0..n).step_by(16) {
                    let part = |x: &[u8; 64]| -> [u8; 16] { x[h..h + 16].try_into().unwrap() };
                    r[h..h + 16].copy_from_slice(&vec_binop(*op, *lane, part(&a), part(&c)));
                }
                frame.set_vbytes(v, &r[..n]);
            }
            return Ok(());
        }
        Inst::InlineAsm { asm, args } => {
            if prog.aarch64 {
                asm_a64::run(mem, frame, asm, args, v)?;
            } else {
                run_inline_asm(mem, frame, asm, args, v)?;
            }
            return Ok(());
        }
        Inst::LifetimeEnd(_) => {
            // A lifetime marker names no storage the interpreter
            // reclaims: the frame cell stays until the call returns.
            return Ok(());
        }
        Inst::AsmOut { .. } => return Ok(()),
        Inst::AllocaInit(_) => {
            // No-op for v0 == AllocaInit(0); the SSA-VM does not
            // expose alloca yet -- callers requesting a real
            // arena get the "not implemented" path below.
            return Ok(());
        }
        Inst::ParamRef { idx, kind } => {
            // The i-th declared parameter sits at c5 cdecl slot
            // i+2 (run_func wrote each `args[i]` to
            // `stack_base + (locals + i) * 8`). Read the 8-byte
            // value back so the SSA-VM sees the same i64 the
            // call site passed. A `float` parameter's cell holds
            // the f32 bit pattern (see `collect_call_args`); the
            // F32 read widens it back to the f64-pattern register
            // convention.
            let off = (*idx as i64) + 2;
            let addr = frame.slot_addr(off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: ParamRef({idx}): slot {off} out of range"))
            })?;
            let read_kind = if matches!(kind, LoadKind::F32) {
                LoadKind::F32
            } else {
                LoadKind::I64
            };
            let raw = load_from_memory(mem, addr, read_kind)?;
            // Mirror the native entry lowering: a narrow signed kind
            // sign-extends from its width (C99 6.5.2.2p4 / 6.3.1.3), so
            // a caller that passed the value unextended still yields
            // the canonical parameter value.
            frame.regs[v as usize] = match kind {
                LoadKind::I8 => raw as i8 as i64,
                LoadKind::I16 => raw as i16 as i64,
                LoadKind::I32 => raw as i32 as i64,
                _ => raw,
            };
            return Ok(());
        }
        // The interpreter has no segment base to model an x86 named
        // address space; a direct segment access reports unimplemented
        // rather than reading the generic address space.
        Inst::SegLoad { .. } => "SegLoad",
        Inst::SegStore { .. } => "SegStore",
        // Emitted by the `-O` pipeline, which the interpreter's SSA skips.
        Inst::ParamPart { .. } => "ParamPart",
        Inst::RetPart { .. } => "RetPart",
        Inst::AggParts { .. } => "AggParts",
        Inst::Phi { .. } => "Phi",
    };
    Err(C5Error::Runtime(format!("vm_ssa: {name} not implemented",)))
}

/// The stdio block: a record per standard stream, as far apart as the bundled
/// `<stdio.h>` steps from `__iob_func()` on Windows, then the `FILE *` object
/// each stream's data symbol names, then the `errno` cell, then the object a
/// library function returning a `long double` wider than `double` fills.
const STDIO_FILE_BYTES: usize = 48;
const STDIO_SLOTS: usize = 3 * STDIO_FILE_BYTES;
const STDIO_ERRNO: usize = STDIO_SLOTS + 3 * 8;
const STDIO_RETURN: usize = STDIO_ERRNO + 8;
const STDIO_BYTES: usize = STDIO_RETURN + 16;

/// Append a stdio block to the data image `data`; its offset.
pub(super) fn reserve_stdio(data: &mut Vec<u8>) -> usize {
    let at = data.len().next_multiple_of(16);
    data.resize(at + STDIO_BYTES, 0);
    at
}

/// The `FILE *` object of the standard stream a data symbol names, in the
/// stdio block at `stdio`: the cell `dlsym` gives for the name as well.
pub(super) fn std_stream_object(stdio: usize, sym: &str) -> Option<usize> {
    std_stream_index(sym).map(|i| stdio + STDIO_SLOTS + i * 8)
}
/// `ENOMEM` as the bundled `<errno.h>` numbers it on every target.
const ENOMEM: i32 = 12;

fn std_stream_index(sym: &str) -> Option<usize> {
    match sym {
        "stdin" | "__stdinp" => Some(0),
        "stdout" | "__stdoutp" => Some(1),
        "stderr" | "__stderrp" => Some(2),
        _ => None,
    }
}

/// The descriptor of the stream that standard stream `i` names.
fn std_stream_fd(name: &str, i: usize, mem: &Memory) -> Result<i64, C5Error> {
    stream_fd(name, &[mem.std_stream(i)], 0, mem)
}

/// The descriptor of the open stream argument `idx` of `name` names.
fn stream_fd(name: &str, args: &[i64], idx: usize, mem: &Memory) -> Result<i64, C5Error> {
    let stream = args.get(idx).copied().unwrap_or(0);
    match mem.streams.get(&(stream as usize)) {
        Some(s) => Ok(s.fd),
        None => Err(C5Error::Runtime(format!(
            "vm_ssa: {name}: 0x{stream:x} is not an open stream"
        ))),
    }
}

fn cstring_arg(name: &str, args: &[i64], idx: usize, mem: &Memory) -> Result<Vec<u8>, C5Error> {
    match args.get(idx).copied() {
        Some(addr) if addr >= 0 => read_cstring_bytes(mem, addr as usize),
        _ => Err(C5Error::Runtime(format!(
            "vm_ssa: {name}: bad string argument"
        ))),
    }
}

/// Whether [`dispatch_callext`] defines `name`: a call to a function the
/// unit declares but neither defines nor binds runs that definition, as a
/// native link takes the one its C library offers.
pub(super) fn interp_supplies(name: &str) -> bool {
    strtox::NAMES.contains(&name)
        || string::NAMES.contains(&name)
        || printf::NAMES.contains(&name)
        || scan::NAMES.contains(&name)
        || locale::NAMES.contains(&name)
        || stream::NAMES.contains(&name)
        || sort::NAMES.contains(&name)
        || system::NAMES.contains(&name)
        || matches!(
            name,
            "exit"
                | "memcpy"
                | "memmove"
                | "memset"
                | "memcmp"
                | "write"
                | "read"
                | "pread"
                | "pwrite"
                | "lseek"
                | "lseek64"
                | "_lseek"
                | "_lseeki64"
                | "copy_file_range"
                | "close"
                | "malloc"
                | "calloc"
                | "realloc"
                | "free"
                | "__iob_func"
                | "errno_location"
                | "fputs"
                | "puts"
                | "fputc"
                | "putc"
                | "fwrite"
                | "fflush"
                | "fileno"
                | "putchar"
                | "open"
                | "getenv"
                | "setenv"
                | "_putenv_s"
                | "dlopen"
                | "dlsym"
                | "dlclose"
                | "dlerror"
                | "feraiseexcept"
                | "feupdateenv"
        )
}

/// The `<fenv.h>` functions and the `<math.h>` functions that round in
/// the current direction (C99 7.6, 7.12.9.3-5), over the program's
/// floating-point environment; `None` for any other name. A `long double`
/// variant is the `double` one where the two types share a format.
fn fenv_call(name: &str, args: &[i64], mem: &mut Memory) -> Option<Result<i64, C5Error>> {
    let arg = |i: usize| {
        (args.get(i).copied())
            .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing argument")))
    };
    let narrow_long_double = mem.target.long_double() == crate::c5::codegen::LongDoubleKind::F64;
    let call = || -> Result<i64, C5Error> {
        let fp = &mut mem.fp;
        Ok(match name {
            "fegetround" => i64::from(fp.get_round()),
            "fesetround" => i64::from(!fp.set_round(arg(0)? as i32)),
            "feclearexcept" => {
                fp.clear(arg(0)? as i32);
                0
            }
            "feraiseexcept" => {
                fp.raise(arg(0)? as i32);
                0
            }
            "fetestexcept" => i64::from(fp.test(arg(0)? as i32)),
            "fegetexceptflag" => {
                let raised = fp.test(arg(1)? as i32).to_le_bytes();
                let n = fp.except_size();
                mem.write_bytes(arg(0)? as usize, &raised[..n])?;
                0
            }
            "fesetexceptflag" => {
                let n = fp.except_size();
                let mut b = [0u8; 4];
                b[..n].copy_from_slice(mem.read_bytes(arg(0)? as usize, n)?);
                let fp = &mut mem.fp;
                let excepts = fp.flags_of(arg(1)? as i32);
                fp.flags = fp.flags & !excepts | fp.flags_of(i32::from_le_bytes(b)) & excepts;
                0
            }
            "fegetenv" | "feholdexcept" => {
                let img = fp.env_image();
                if name == "feholdexcept" {
                    fp.flags = 0;
                }
                mem.write_bytes(arg(0)? as usize, &img)?;
                0
            }
            "fesetenv" | "feupdateenv" => {
                let raised = if name == "feupdateenv" { fp.flags } else { 0 };
                let (env, n) = (arg(0)?, fp.env_size());
                // glibc's FE_DFL_ENV is `(const fenv_t *)-1`.
                if env == -1 {
                    fp.set_default_env();
                } else {
                    let img = mem.read_bytes(env as usize, n)?.to_vec();
                    mem.fp.set_env_image(&img);
                }
                mem.fp.flags |= raised;
                0
            }
            "rint" | "rintf" | "rintl" => fp.round_integral(arg(0)? as u64, true) as i64,
            "nearbyint" | "nearbyintf" | "nearbyintl" => {
                fp.round_integral(arg(0)? as u64, false) as i64
            }
            "lrint" | "lrintf" | "lrintl" => {
                fp.lrint(arg(0)? as u64, mem.target.long_width_bytes() as u32 * 8)
            }
            "llrint" | "llrintf" | "llrintl" => fp.lrint(arg(0)? as u64, 64),
            _ => unreachable!("{name} is no fenv_call name"),
        })
    };
    let known = matches!(
        name,
        "fegetround"
            | "fesetround"
            | "feclearexcept"
            | "feraiseexcept"
            | "fetestexcept"
            | "fegetexceptflag"
            | "fesetexceptflag"
            | "fegetenv"
            | "feholdexcept"
            | "fesetenv"
            | "feupdateenv"
            | "rint"
            | "rintf"
            | "nearbyint"
            | "nearbyintf"
            | "lrint"
            | "lrintf"
            | "llrint"
            | "llrintf"
    ) || (narrow_long_double
        && matches!(name, "rintl" | "nearbyintl" | "lrintl" | "llrintl"));
    known.then(call)
}

/// Dispatch a libc binding by name. Implementations land here
/// as they're ported off the `Vm<H>` host-bridge into the
/// byte-addressed `Memory` model. Unimplemented bindings
/// return a runtime error so the caller sees which shim needs
/// writing next.
fn dispatch_callext<H: Host>(
    name: &str,
    args: &[i64],
    mem: &mut Memory,
    host: &mut H,
) -> Result<i64, C5Error> {
    if let Some(r) = fenv_call(name, args, mem) {
        return r;
    }
    if let Some(r) = strtox::call(name, args, mem) {
        return r;
    }
    if let Some(r) = string::call(name, args, mem) {
        return r;
    }
    if let Some(r) = scan::call(name, args, mem, host) {
        return r;
    }
    if let Some(r) = system::call(name, args, mem, host) {
        return r;
    }
    if let Some(r) = stream::call(name, args, mem, host) {
        return r;
    }
    if let Some(r) = locale::call(name, args, mem) {
        return r;
    }
    if let Some(r) = printf::call(name, args, mem, host) {
        return r;
    }
    match name {
        // `exit(int code)` terminates the hosted program (C99
        // 7.20.4.3). The Err unwinds every interpreter frame;
        // `run_program_with_args_tracked` converts the sentinel
        // back into an Ok(status) at the program boundary.
        "exit" => {
            let code = args.first().copied().unwrap_or(0);
            Err(exit_signal(code))
        }
        // `void *memcpy(void *dst, const void *src, size_t n)`.
        // c5's cdecl pushes args right-to-left; the walker
        // delivers them to `Inst::CallExt::args` in declared
        // order, so `args[0] = dst`, `args[1] = src`, `args[2] = n`.
        "memcpy" => {
            let (dst, src, n) = libc_three_arg(name, args)?;
            mem.check_data_access(src, n, AccessKind::Read)?;
            mem.check_data_access(dst, n, AccessKind::Write)?;
            mem.copy_within(dst, src, n)?;
            Ok(dst as i64)
        }
        // `void *memmove(void *dst, const void *src, size_t n)`
        // (C99 7.21.2.2): as memcpy, but defined when the objects
        // overlap. `copy_within` already moves.
        "memmove" => {
            let (dst, src, n) = libc_three_arg(name, args)?;
            mem.check_data_access(src, n, AccessKind::Read)?;
            mem.check_data_access(dst, n, AccessKind::Write)?;
            mem.copy_within(dst, src, n)?;
            Ok(dst as i64)
        }
        // `void *memset(void *dst, int val, size_t n)`. C99
        // 7.21.6.1 narrows `val` to `unsigned char` before
        // writing.
        "memset" => {
            let dst = args
                .first()
                .copied()
                .ok_or_else(|| C5Error::Runtime("vm_ssa: memset: missing dst".to_string()))?;
            let val = args.get(1).copied().unwrap_or(0) as u8;
            let n = libc_size(name, args.get(2).copied())?;
            if dst < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: memset: negative dst 0x{:x}",
                    dst as usize,
                )));
            }
            mem.check_data_access(dst as usize, n, AccessKind::Write)?;
            mem.fill_bytes(dst as usize, val, n)?;
            Ok(dst)
        }
        // `int memcmp(const void *s1, const void *s2, size_t n)`.
        // C99 7.21.4.1: returns negative/zero/positive on the
        // first byte that differs, comparing as `unsigned char`.
        "memcmp" => {
            let (s1, s2, n) = libc_three_arg(name, args)?;
            mem.check_data_access(s1, n, AccessKind::Read)?;
            mem.check_data_access(s2, n, AccessKind::Read)?;
            for i in 0..n {
                let a = mem.read_bytes(s1 + i, 1)?[0];
                let b = mem.read_bytes(s2 + i, 1)?[0];
                if a != b {
                    return Ok(a as i64 - b as i64);
                }
            }
            Ok(0)
        }
        // `ssize_t write(int fd, const void *buf, size_t count)`.
        // Routes through `host.write`; fd 1 / 2 land on stdout /
        // stderr by convention.
        "write" => {
            if args.len() < 3 {
                return Err(C5Error::Runtime("vm_ssa: write expects 3 args".to_string()));
            }
            let fd = args[0];
            let buf_addr = args[1];
            let n = libc_size(name, Some(args[2]))?;
            if buf_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: write: negative buf addr 0x{buf_addr:x}",
                )));
            }
            let slice = mem.read_bytes(buf_addr as usize, n)?;
            // `host.write` returns an i64; we trust its sign convention.
            // Take a small detour through an owned Vec to drop the
            // borrow on `mem` before any &mut-touching follow-on
            // (none today, but it keeps the borrow checker tame as
            // the dispatch grows).
            let owned: alloc::vec::Vec<u8> = slice.to_vec();
            Ok(host.write(fd, &owned))
        }
        // `ssize_t read(int fd, void *buf, size_t count)`.
        "read" => {
            if args.len() < 3 {
                return Err(C5Error::Runtime("vm_ssa: read expects 3 args".to_string()));
            }
            let fd = args[0];
            let buf_addr = args[1];
            let n = libc_size(name, Some(args[2]))?;
            if buf_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: read: negative buf addr 0x{buf_addr:x}",
                )));
            }
            // No more can arrive than the memory past `buf` holds.
            let n = n.min(mem.bytes.len().saturating_sub(buf_addr as usize));
            let mut buf = alloc::vec![0u8; n];
            let read_bytes = host.read(fd, &mut buf);
            if read_bytes < 0 {
                return Ok(read_bytes);
            }
            let actual = (read_bytes as usize).min(n);
            mem.write_bytes(buf_addr as usize, &buf[..actual])?;
            Ok(read_bytes)
        }
        // `pread` / `pwrite` (POSIX): the transfer at `offset`, the
        // descriptor's own position left where it was; a descriptor that
        // cannot seek fails with ESPIPE.
        "pread" | "pwrite" => {
            if args.len() < 4 {
                return Err(C5Error::Runtime(format!("vm_ssa: {name} expects 4 args")));
            }
            let (fd, buf_addr, offset) = (args[0], args[1] as usize, args[3]);
            let n = libc_size(name, Some(args[2]))?;
            let here = host.seek(fd, 0, 1);
            if here < 0 || host.seek(fd, offset, 0) < 0 {
                mem.set_errno(29);
                return Ok(-1);
            }
            let done = if name == "pread" {
                let n = n.min(mem.bytes.len().saturating_sub(buf_addr));
                let mut buf = alloc::vec![0u8; n];
                let got = host.read(fd, &mut buf);
                if got > 0 {
                    mem.write_bytes(buf_addr, &buf[..(got as usize).min(n)])?;
                }
                got
            } else {
                let owned = mem.read_bytes(buf_addr, n)?.to_vec();
                host.write(fd, &owned)
            };
            host.seek(fd, here, 0);
            Ok(done)
        }
        // `lseek` and its Windows and large-file spellings: the new position,
        // or -1 with ESPIPE for a descriptor that cannot seek. `_lseek`
        // takes and returns a 32-bit `long`.
        "lseek" | "lseek64" | "_lseek" | "_lseeki64" => {
            if args.len() < 3 {
                return Err(C5Error::Runtime(format!("vm_ssa: {name} expects 3 args")));
            }
            let offset = match name {
                "_lseek" => args[1] as i32 as i64,
                _ => args[1],
            };
            let at = host.seek(args[0], offset, args[2] as i32);
            if at < 0 {
                mem.set_errno(29);
            }
            Ok(at)
        }
        // Linux `copy_file_range`: up to `len` bytes from `fd_in` to
        // `fd_out`. A null offset pointer names the descriptor's own
        // position, which the copy advances; a non-null one names the
        // start, leaves the descriptor alone and advances by the count.
        "copy_file_range" => {
            if args.len() < 6 {
                return Err(C5Error::Runtime(
                    "vm_ssa: copy_file_range expects 6 args".into(),
                ));
            }
            let (fd_in, off_in, fd_out, off_out) = (args[0], args[1], args[2], args[3]);
            let len = libc_size(name, Some(args[4]))?;
            let mut moved = Vec::new();
            for (fd, ptr) in [(fd_in, off_in), (fd_out, off_out)] {
                let here = host.seek(fd, 0, 1);
                let start = match ptr {
                    0 => here,
                    p => load_from_memory(mem, p as usize, LoadKind::I64)?,
                };
                if here < 0 || host.seek(fd, start, 0) < 0 {
                    mem.set_errno(29);
                    return Ok(-1);
                }
                moved.push((fd, ptr, here, start));
            }
            let mut buf = alloc::vec![0u8; len];
            let got = host.read(fd_in, &mut buf);
            let done = if got > 0 {
                host.write(fd_out, &buf[..got as usize])
            } else {
                got
            };
            for &(fd, ptr, here, start) in &moved {
                if ptr != 0 {
                    host.seek(fd, here, 0);
                    if done > 0 {
                        store_to_memory(mem, ptr as usize, start + done, StoreKind::I64)?;
                    }
                }
            }
            Ok(done)
        }
        // `int close(int fd)` -- pure host bridge.
        "close" => {
            let fd = args.first().copied().unwrap_or(-1);
            Ok(host.close(fd))
        }
        // `void *malloc(size_t n)` -- bump-pointer heap. A null pointer
        // with `errno` set to ENOMEM when the space cannot be allocated
        // (C99 7.20.3), as the C libraries do.
        "malloc" => {
            let n = alloc_size(name, args, 0)?;
            Ok(guest_alloc(mem, Some(n)))
        }
        // `void *calloc(size_t nmemb, size_t size)` (C99 7.20.3.1): a
        // product past `size_t` is space that cannot be allocated. The
        // heap hands out zeroed bytes.
        "calloc" => {
            let n = alloc_size(name, args, 0)?.checked_mul(alloc_size(name, args, 1)?);
            Ok(guest_alloc(mem, n))
        }
        // `void *realloc(void *ptr, size_t size)` (C99 7.20.3.4): a new
        // object holding the old one's bytes up to the lesser size; when
        // it cannot be allocated, a null pointer, and the old object
        // stays as it was.
        "realloc" => {
            let ptr = args.first().copied().unwrap_or(0);
            let n = alloc_size(name, args, 1)?;
            if ptr == 0 {
                return Ok(guest_alloc(mem, Some(n)));
            }
            let p = ptr as usize;
            let Some(old) = mem.allocations.iter().position(|a| a.start == p) else {
                return Err(C5Error::Runtime(format!(
                    "realloc of unknown pointer 0x{p:x} (not returned by malloc)"
                )));
            };
            let Allocation { len, freed, id, .. } = mem.allocations[old];
            if freed && mem.track_pointers {
                return Err(C5Error::Runtime(format!(
                    "realloc of allocation #{id} at 0x{p:x} after it was freed"
                )));
            }
            let base = guest_alloc(mem, Some(n));
            if base != 0 {
                mem.copy_within(base as usize, p, len.min(n as usize))?;
                mem.allocations[old].freed = true;
            }
            Ok(base)
        }
        // `void free(void *p)` -- no actual reclamation (the
        // bump-pointer heap only grows). Under `track_pointers`,
        // flips the matching allocation to `freed`; subsequent
        // accesses surface a use-after-free. Errors on double-
        // free or an unknown pointer.
        "free" => {
            let ptr = args.first().copied().unwrap_or(0);
            if ptr == 0 || !mem.track_pointers {
                return Ok(0);
            }
            let p = ptr as usize;
            match mem.allocations.iter_mut().find(|a| a.start == p) {
                Some(alloc) if alloc.freed => {
                    return Err(C5Error::Runtime(format!(
                        "double free: allocation #{} at 0x{p:x} freed twice",
                        alloc.id
                    )));
                }
                Some(alloc) => alloc.freed = true,
                None => {
                    return Err(C5Error::Runtime(format!(
                        "free of unknown pointer 0x{p:x} (not returned by malloc)"
                    )));
                }
            }
            Ok(0)
        }
        // The bundled headers reach a stream through its data symbol (`dlsym`
        // below) or `__iob_func()`, and `errno` through `errno_location()`.
        "__iob_func" => Ok(mem.stdio() as i64),
        "errno_location" => Ok((mem.stdio() + STDIO_ERRNO) as i64),
        "fputs" => {
            let fd = stream_fd(name, args, 1, mem)?;
            let _ = host.write(fd, &cstring_arg(name, args, 0, mem)?);
            Ok(0)
        }
        "puts" => {
            let mut line = cstring_arg(name, args, 0, mem)?;
            line.push(b'\n');
            let _ = host.write(std_stream_fd(name, 1, mem)?, &line);
            Ok(0)
        }
        "fputc" | "putc" => {
            let fd = stream_fd(name, args, 1, mem)?;
            let byte = args.first().copied().unwrap_or(-1) as u8;
            let _ = host.write(fd, &[byte]);
            Ok(i64::from(byte))
        }
        "fwrite" => {
            let fd = stream_fd(name, args, 3, mem)?;
            let (buf, size, n) = libc_three_arg(name, args)?;
            let bytes = mem.read_bytes(buf, size.saturating_mul(n))?.to_vec();
            let _ = host.write(fd, &bytes);
            Ok(if size == 0 { 0 } else { n as i64 })
        }
        "fflush" => Ok(0),
        "fileno" => stream_fd(name, args, 0, mem),
        // `int putchar(int c)` -- write one byte to stdout, returns
        // the byte (or EOF on error; we return the byte unconditionally).
        "putchar" => {
            let c = args.first().copied().unwrap_or(-1);
            let byte = c as u8;
            let _ = host.write(std_stream_fd(name, 1, mem)?, &[byte]);
            Ok(c)
        }
        // `int open(const char *path, int flags)` -- routes through
        // the host. C99 doesn't model the POSIX flag set; the host
        // adapter decides what `flags` mean.
        "open" => {
            let path_addr = args
                .first()
                .copied()
                .ok_or_else(|| C5Error::Runtime("vm_ssa: open: missing path".to_string()))?;
            if path_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: open: bad path addr 0x{path_addr:x}",
                )));
            }
            let path = read_cstring(mem, path_addr as usize)?;
            Ok(host.open(&path))
        }
        // `char *getenv(const char *name)` -- on hit, the host's
        // value is copied into the heap so the returned pointer
        // stays valid through subsequent allocations (the host's
        // own buffer may not).
        "getenv" => {
            let name_addr = args
                .first()
                .copied()
                .ok_or_else(|| C5Error::Runtime("vm_ssa: getenv: missing name".to_string()))?;
            if name_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: getenv: bad name addr 0x{name_addr:x}",
                )));
            }
            let env_name = read_cstring(mem, name_addr as usize)?;
            Ok(match host.getenv(&env_name) {
                Some(value) => mem.install_cstring(value.as_bytes()) as i64,
                None => 0,
            })
        }
        // `int setenv(const char *name, const char *value, int overwrite)`.
        // C99 doesn't standardize setenv; this matches POSIX.
        // The `int overwrite` is normalized through the `Overwrite`
        // enum at the trait boundary.
        "setenv" => {
            if args.len() < 3 {
                return Err(C5Error::Runtime(
                    "vm_ssa: setenv expects 3 args".to_string(),
                ));
            }
            let name_addr = args[0];
            let val_addr = args[1];
            let overwrite = if args[2] != 0 {
                super::super::host::Overwrite::Force
            } else {
                super::super::host::Overwrite::Skip
            };
            if name_addr < 0 || val_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: setenv: bad addrs name=0x{name_addr:x} val=0x{val_addr:x}",
                )));
            }
            let env_name = read_cstring(mem, name_addr as usize)?;
            let env_val = read_cstring(mem, val_addr as usize)?;
            host.setenv(&env_name, &env_val, overwrite);
            Ok(0)
        }
        // `int _putenv_s(const char *name, const char *value)` -- msvcrt's
        // 2-argument setter, always replacing. The Windows `<stdlib.h>`
        // setenv wrapper calls it after its own overwrite check, so the
        // bridge forces the write.
        "_putenv_s" => {
            if args.len() < 2 {
                return Err(C5Error::Runtime(
                    "vm_ssa: _putenv_s expects 2 args".to_string(),
                ));
            }
            let name_addr = args[0];
            let val_addr = args[1];
            if name_addr < 0 || val_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: _putenv_s: bad addrs name=0x{name_addr:x} val=0x{val_addr:x}",
                )));
            }
            let env_name = read_cstring(mem, name_addr as usize)?;
            let env_val = read_cstring(mem, val_addr as usize)?;
            host.setenv(&env_name, &env_val, super::super::host::Overwrite::Force);
            Ok(0)
        }
        // `void *dlopen(const char *filename, int flags)` -- a NULL
        // filename maps to `Option::None` so the host can produce
        // dlopen(NULL, ...) (the global symbol table).
        "dlopen" => {
            if args.len() < 2 {
                return Err(C5Error::Runtime(
                    "vm_ssa: dlopen expects 2 args".to_string(),
                ));
            }
            let path_addr = args[0];
            let flags = args[1];
            let path = if path_addr == 0 {
                None
            } else if path_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: dlopen: bad path addr 0x{path_addr:x}",
                )));
            } else {
                Some(read_cstring(mem, path_addr as usize)?)
            };
            Ok(host.dlopen(path.as_deref(), flags))
        }
        // `void *dlsym(void *handle, const char *name)` -- returns
        // a raw host-process address; the c5 side treats it as an
        // opaque integer.
        "dlsym" => {
            if args.len() < 2 {
                return Err(C5Error::Runtime("vm_ssa: dlsym expects 2 args".to_string()));
            }
            let handle = args[0];
            let name_addr = args[1];
            if name_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: dlsym: bad name addr 0x{name_addr:x}",
                )));
            }
            let sym = read_cstring(mem, name_addr as usize)?;
            if let Some(at) = std_stream_object(mem.stdio(), &sym) {
                return Ok(at as i64);
            }
            Ok(host.dlsym(handle, &sym))
        }
        // `int dlclose(void *handle)` -- pure host bridge.
        "dlclose" => {
            let handle = args.first().copied().unwrap_or(0);
            Ok(host.dlclose(handle))
        }
        // `char *dlerror(void)` -- copy the most recent loader
        // error into the heap so the returned pointer outlives
        // any subsequent dl-family call (whose host-side static
        // buffer would otherwise be clobbered).
        "dlerror" => Ok(match host.dlerror() {
            Some(msg) => mem.install_cstring(msg.as_bytes()) as i64,
            None => 0,
        }),
        // TODO: the library surface bound here is partial; `strcpy`,
        // `abs` and `atoi` are among the calls with no binding.
        _ => Err(C5Error::Runtime(format!(
            "vm_ssa: library call `{name}` is not implemented under --interp",
        ))),
    }
}

/// Read a NUL-terminated C string out of memory. Bounds-checks
/// up to the data segment / stack / heap end so a stray pointer
/// returns a runtime error rather than reading past the buffer.
/// Read the NUL-terminated C string at `addr` as raw bytes. A C string
/// is an arbitrary byte sequence; the caller decides how to interpret
/// bytes >= 0x80 rather than forcing a Latin-1 -> UTF-8 round-trip.
fn read_cstring_bytes(mem: &Memory, addr: usize) -> Result<Vec<u8>, C5Error> {
    let mut i = addr;
    while i < mem.bytes.len() && mem.bytes[i] != 0 {
        i += 1;
    }
    if i >= mem.bytes.len() {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: read_cstring: missing NUL terminator past addr 0x{addr:x}",
        )));
    }
    Ok(mem.bytes[addr..i].to_vec())
}

/// Read a C string for a Rust `&str` consumer (path names, env keys).
/// Bytes >= 0x80 that are not valid UTF-8 become U+FFFD, giving defined
/// behavior rather than the prior plausible-but-wrong Latin-1 mapping.
fn read_cstring(mem: &Memory, addr: usize) -> Result<alloc::string::String, C5Error> {
    let bytes = read_cstring_bytes(mem, addr)?;
    Ok(alloc::string::String::from_utf8_lossy(&bytes).into_owned())
}

/// Argument-width selector from a conversion spec's length
/// modifier (C99 7.19.6.1p7). The variadic tail holds one i64
/// per argument; the modifier decides how many low bits carry
/// the value.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ArgLen {
    Char,  // hh
    Short, // h
    Int,   // (none)
    Long,  // 64-bit: ll / j / z / t / L, and l where `long` is 64 bits
}

/// One parsed conversion specification (C99 7.19.6.1p4).
struct PrintfSpec {
    minus: bool,
    plus: bool,
    space: bool,
    alt: bool,
    zero: bool,
    width: Option<usize>,
    precision: Option<usize>,
    len: ArgLen,
    /// `L`: a floating conversion's argument is a `long double`.
    long_double: bool,
    conv: u8,
}

/// The variable arguments of a formatting function: the call's own values,
/// or the eightbyte slots a `va_list` cursor points at, where a `long
/// double` wider than `double` occupies two holding its image.
enum Varargs<'a> {
    Values(&'a [i64], usize),
    List(usize),
}

impl<'a> Varargs<'a> {
    fn values(args: &'a [i64]) -> Self {
        Varargs::Values(args, 0)
    }

    /// The arguments a `va_list` argument `ap` holds: on the Linux targets
    /// `va_list` is an array, passed as its address, whose first eightbyte
    /// the interpreter keeps the cursor in; elsewhere it is the cursor.
    fn list(mem: &Memory, ap: i64) -> Result<Self, C5Error> {
        let cursor =
            if mem.target.is_windows() || mem.target == crate::c5::codegen::Target::MacOSAarch64 {
                ap
            } else {
                load_from_memory(mem, ap as usize, LoadKind::I64)?
            };
        Ok(Varargs::List(cursor as usize))
    }

    fn next(&mut self, mem: &Memory) -> Result<i64, C5Error> {
        match self {
            Varargs::Values(args, i) => {
                let v = args.get(*i).copied().ok_or_else(|| {
                    C5Error::Runtime(format!(
                        "vm_ssa: the format wants argument #{} but only {} were passed",
                        *i + 1,
                        args.len(),
                    ))
                })?;
                *i += 1;
                Ok(v)
            }
            Varargs::List(at) => {
                let v = load_from_memory(mem, *at, LoadKind::I64)?;
                *at += 8;
                Ok(v)
            }
        }
    }

    /// A floating argument: binary64 bits, or under `L` where `long double`
    /// is wider, the address of its image.
    fn next_float(&mut self, mem: &Memory, long_double: bool) -> Result<i64, C5Error> {
        let wide =
            long_double && mem.target.long_double() != crate::c5::codegen::LongDoubleKind::F64;
        match self {
            Varargs::List(at) if wide => {
                *at += 16;
                Ok(*at as i64 - 16)
            }
            _ => self.next(mem),
        }
    }
}

/// printf formatter (C99 7.19.6.1). Parses the full spec grammar
/// -- flags, width (incl. `*`), precision (incl. `.*`), length
/// modifiers -- and pulls arguments from `args` as each
/// conversion requires. Returns the raw output bytes for the
/// caller to hand to `host.write`. An unrecognized conversion
/// emits its spec text verbatim without consuming an argument
/// (undefined per 7.19.6.1p9).
fn format_printf(fmt: &[u8], mut args: Varargs<'_>, mem: &mut Memory) -> Result<Vec<u8>, C5Error> {
    let mut out: Vec<u8> = Vec::new();
    let mut i = 0usize;
    while i < fmt.len() {
        let c = fmt[i];
        i += 1;
        if c != b'%' {
            out.push(c);
            continue;
        }
        let spec_start = i;
        let mut s = PrintfSpec {
            minus: false,
            plus: false,
            space: false,
            alt: false,
            zero: false,
            width: None,
            precision: None,
            len: ArgLen::Int,
            long_double: false,
            conv: 0,
        };
        while let Some(&f) = fmt.get(i) {
            match f {
                b'-' => s.minus = true,
                b'+' => s.plus = true,
                b' ' => s.space = true,
                b'#' => s.alt = true,
                b'0' => s.zero = true,
                _ => break,
            }
            i += 1;
        }
        if fmt.get(i) == Some(&b'*') {
            i += 1;
            // A negative `*` width means `-` flag plus the
            // absolute value (7.19.6.1p5).
            let w = args.next(mem)? as i32;
            s.width = Some(w.unsigned_abs() as usize);
            s.minus |= w < 0;
        } else {
            while let Some(d) = fmt.get(i).filter(|d| d.is_ascii_digit()) {
                s.width = Some(s.width.unwrap_or(0) * 10 + (d - b'0') as usize);
                i += 1;
            }
        }
        if fmt.get(i) == Some(&b'.') {
            i += 1;
            if fmt.get(i) == Some(&b'*') {
                i += 1;
                // A negative `*` precision reads as omitted (p5).
                let p = args.next(mem)? as i32;
                s.precision = (p >= 0).then_some(p as usize);
            } else {
                s.precision = Some(0);
                while let Some(d) = fmt.get(i).filter(|d| d.is_ascii_digit()) {
                    s.precision = Some(s.precision.unwrap_or(0) * 10 + (d - b'0') as usize);
                    i += 1;
                }
            }
        }
        match fmt.get(i) {
            Some(b'h') => {
                i += 1;
                s.len = ArgLen::Short;
                if fmt.get(i) == Some(&b'h') {
                    i += 1;
                    s.len = ArgLen::Char;
                }
            }
            Some(b'l') => {
                i += 1;
                // `l` names the target's `long`, 32 bits under LLP64.
                s.len = if mem.target.long_width_bytes() == 4 {
                    ArgLen::Int
                } else {
                    ArgLen::Long
                };
                if fmt.get(i) == Some(&b'l') {
                    i += 1;
                    s.len = ArgLen::Long;
                }
            }
            Some(b'j') | Some(b'z') | Some(b't') | Some(b'L') => {
                s.long_double = fmt[i] == b'L';
                i += 1;
                s.len = ArgLen::Long;
            }
            _ => {}
        }
        let Some(&conv) = fmt.get(i) else {
            // Incomplete trailing spec: emit verbatim.
            out.push(b'%');
            out.extend_from_slice(&fmt[spec_start..]);
            break;
        };
        i += 1;
        s.conv = conv;
        match conv {
            b'%' => out.push(b'%'),
            b'd' | b'i' => {
                let raw = args.next(mem)?;
                let v = match s.len {
                    ArgLen::Char => raw as i8 as i64,
                    ArgLen::Short => raw as i16 as i64,
                    ArgLen::Int => raw as i32 as i64,
                    ArgLen::Long => raw,
                };
                let sign = if v < 0 {
                    "-"
                } else if s.plus {
                    "+"
                } else if s.space {
                    " "
                } else {
                    ""
                };
                let digits = format!("{}", v.unsigned_abs());
                push_int(&mut out, &s, sign, &digits, v == 0);
            }
            b'u' | b'o' | b'x' | b'X' => {
                let raw = args.next(mem)?;
                let v = match s.len {
                    ArgLen::Char => raw as u8 as u64,
                    ArgLen::Short => raw as u16 as u64,
                    ArgLen::Int => raw as u32 as u64,
                    ArgLen::Long => raw as u64,
                };
                let digits = match conv {
                    b'u' => format!("{v}"),
                    b'o' => format!("{v:o}"),
                    b'x' => format!("{v:x}"),
                    _ => format!("{v:X}"),
                };
                // `#`: force a leading 0 on octal; prefix 0x / 0X
                // on a nonzero hex value (7.19.6.1p6).
                let (prefix, digits) = match conv {
                    b'o' if s.alt && !digits.starts_with('0') => ("", format!("0{digits}")),
                    b'x' if s.alt && v != 0 => ("0x", digits),
                    b'X' if s.alt && v != 0 => ("0X", digits),
                    _ => ("", digits),
                };
                push_int(&mut out, &s, prefix, &digits, v == 0);
            }
            b'c' => {
                let v = args.next(mem)?;
                push_padded(&mut out, &s, &[v as u8]);
            }
            b's' => {
                let val = args.next(mem)?;
                if val < 0 {
                    return Err(C5Error::Runtime(format!(
                        "vm_ssa: printf %s: bad ptr 0x{val:x}",
                    )));
                }
                let mut bytes = read_cstring_bytes(mem, val as usize)?;
                if let Some(p) = s.precision {
                    bytes.truncate(p);
                }
                push_padded(&mut out, &s, &bytes);
            }
            b'p' => {
                // The text is implementation-defined (7.19.6.1p8): glibc
                // writes a null pointer as `(nil)`, the UCRT every pointer
                // as 16 upper-case digits.
                let v = args.next(mem)? as u64;
                let text = match Libc::of(mem.target) {
                    Libc::Glibc if v == 0 => "(nil)".into(),
                    Libc::Ucrt => format!("{v:016X}"),
                    _ => format!("0x{v:x}"),
                };
                push_padded(&mut out, &s, text.as_bytes());
            }
            b'f' | b'F' | b'e' | b'E' | b'g' | b'G' | b'a' | b'A' => {
                let raw = args.next_float(mem, s.long_double)?;
                let (v, hex) = float_arg(mem, raw, s.long_double)?;
                let libc = Libc::of(mem.target);
                let sign = if v.is_nan() {
                    nan_sign(v, &s, libc)
                } else if v.is_sign_negative() {
                    "-"
                } else if s.plus {
                    "+"
                } else if s.space {
                    " "
                } else {
                    ""
                };
                let (prefix, body) = match hex {
                    _ if v.is_nan() => (sign.into(), nan_body(v, conv, libc)),
                    Some(h) if matches!(conv, b'a' | b'A') => {
                        let radix = if conv == b'A' { "0X" } else { "0x" };
                        let style = Libc::of(mem.target);
                        let neg = v.is_sign_negative();
                        let body = format_hex(h, &s, style, mem.fp.round, neg);
                        (format!("{sign}{radix}"), body)
                    }
                    _ => (sign.into(), format_float(v, &s, mem.fp.round)),
                };
                // The `0` flag does not pad an infinity or NaN (7.19.6.1p6).
                s.zero &= v.is_finite();
                push_int(&mut out, &s, &prefix, &body, false);
            }
            b'n' => {
                // Store the byte count written so far (7.19.6.1p8).
                let addr = args.next(mem)?;
                if addr < 0 {
                    return Err(C5Error::Runtime(format!(
                        "vm_ssa: printf %n: bad ptr 0x{addr:x}",
                    )));
                }
                let kind = match s.len {
                    ArgLen::Char => StoreKind::I8,
                    ArgLen::Short => StoreKind::I16,
                    ArgLen::Int => StoreKind::I32,
                    ArgLen::Long => StoreKind::I64,
                };
                store_to_memory(mem, addr as usize, out.len() as i64, kind)?;
            }
            _ => {
                out.push(b'%');
                out.extend_from_slice(&fmt[spec_start..i]);
            }
        }
    }
    Ok(out)
}

/// Pad `body` to the spec's field width (7.19.6.1p5): spaces on
/// the left by default, on the right under `-`.
fn push_padded(out: &mut Vec<u8>, s: &PrintfSpec, body: &[u8]) {
    let pad = s.width.unwrap_or(0).saturating_sub(body.len());
    if !s.minus {
        out.resize(out.len() + pad, b' ');
    }
    out.extend_from_slice(body);
    if s.minus {
        out.resize(out.len() + pad, b' ');
    }
}

/// Assemble a numeric conversion: precision zero-extends the
/// digit string (and suppresses a zero value at precision 0);
/// the `0` flag zero-pads between the sign / base prefix and the
/// digits unless `-` or an explicit precision overrides it
/// (7.19.6.1p6).
fn push_int(out: &mut Vec<u8>, s: &PrintfSpec, prefix: &str, digits: &str, is_zero: bool) {
    let mut digits = alloc::string::String::from(digits);
    let floating = matches!(
        s.conv,
        b'f' | b'F' | b'e' | b'E' | b'g' | b'G' | b'a' | b'A'
    );
    if let Some(p) = s.precision
        && !floating
    {
        if is_zero && p == 0 {
            digits.clear();
        }
        while digits.len() < p {
            digits.insert(0, '0');
        }
    }
    let body_len = prefix.len() + digits.len();
    let pad = s.width.unwrap_or(0).saturating_sub(body_len);
    let zero_pad = s.zero && !s.minus && (floating || s.precision.is_none());
    if zero_pad {
        out.extend_from_slice(prefix.as_bytes());
        out.resize(out.len() + pad, b'0');
        out.extend_from_slice(digits.as_bytes());
        return;
    }
    if !s.minus {
        out.resize(out.len() + pad, b' ');
    }
    out.extend_from_slice(prefix.as_bytes());
    out.extend_from_slice(digits.as_bytes());
    if s.minus {
        out.resize(out.len() + pad, b' ');
    }
}

/// The sign a NaN takes (7.19.6.1p8 "[-]nan") from the target's C library:
/// glibc and the UCRT write the sign bit and honor `+` and space; Apple's
/// writes none of the three.
fn nan_sign(v: f64, s: &PrintfSpec, libc: Libc) -> &'static str {
    match libc {
        Libc::Apple => "",
        _ if v.is_sign_negative() => "-",
        _ if s.plus => "+",
        _ if s.space => " ",
        _ => "",
    }
}

/// A NaN's text after its sign: `nan`, and in the UCRT's form `nan(ind)` for
/// the x86 default NaN (sign bit, quiet bit, no payload) and `nan(snan)` for
/// a signaling one; upper-case under an upper-case conversion.
fn nan_body(v: f64, conv: u8, libc: Libc) -> alloc::string::String {
    let bits = v.to_bits();
    let text = match libc {
        Libc::Ucrt if bits == 0xFFF8_0000_0000_0000 => "nan(ind)",
        Libc::Ucrt if bits & (1 << 51) == 0 => "nan(snan)",
        _ => "nan",
    };
    if conv.is_ascii_uppercase() {
        text.to_ascii_uppercase()
    } else {
        text.into()
    }
}

/// Format `|v|` for the f / e / g conversion families
/// (7.19.6.1p8); the caller prepends the sign and applies the
/// field width. Uppercase conversions upper-case the result.
fn format_float(v: f64, s: &PrintfSpec, round: Round) -> alloc::string::String {
    let upper = matches!(s.conv, b'F' | b'E' | b'G' | b'A');
    if v.is_nan() {
        return if upper { "NAN".into() } else { "nan".into() };
    }
    if v.is_infinite() {
        return if upper { "INF".into() } else { "inf".into() };
    }
    let dec = Decimal {
        av: v.abs(),
        neg: v.is_sign_negative(),
        round,
    };
    let p = s.precision.unwrap_or(6);
    let body = match s.conv {
        b'f' | b'F' => {
            let mut b = dec.fixed(p);
            if s.alt && p == 0 {
                b.push('.');
            }
            b
        }
        b'e' | b'E' => format_exp(&dec, p, s.alt),
        _ => {
            // g/G: precision P counts significant digits (0 reads
            // as 1). Style e when the exponent X < -4 or X >= P,
            // else style f with precision P-1-X; trailing zeros
            // drop unless `#`. X is the exponent after rounding, so a
            // value rounding up a decade takes its style from the result.
            let pp = p.max(1);
            let exp = dec.scientific(pp - 1).1;
            let mut b = if exp < -4 || exp >= pp as i32 {
                format_exp(&dec, pp - 1, s.alt)
            } else {
                dec.fixed((pp as i32 - 1 - exp).max(0) as usize)
            };
            if !s.alt && b.contains('.') {
                let frac_end = b.find(['e', 'E']).unwrap_or(b.len());
                let trimmed = b[..frac_end].trim_end_matches('0').trim_end_matches('.');
                b = format!("{}{}", trimmed, &b[frac_end..]);
            }
            b
        }
    };
    if upper { body.to_uppercase() } else { body }
}

/// The decimal digits of a finite magnitude `av`, rounded in the current
/// direction as the targets' C libraries round them: Rust's formatting to
/// nearest, the exact expansion cut and stepped otherwise.
struct Decimal {
    av: f64,
    neg: bool,
    round: Round,
}

impl Decimal {
    /// The exact expansion: every digit, the point after `point` of them.
    /// A binary64 value has at most 1074 fraction digits.
    fn exact(&self) -> (Vec<u8>, usize) {
        let s = format!("{:.1074}", self.av);
        let (int, frac) = s.split_once('.').unwrap_or((s.as_str(), ""));
        let digits = int.bytes().chain(frac.bytes()).map(|b| b - b'0').collect();
        (digits, int.len())
    }

    /// `digits` cut to `keep` and stepped away from zero when the
    /// direction asks; true when the step carried into a new digit.
    fn cut(&self, digits: &mut Vec<u8>, keep: usize) -> bool {
        let dropped = digits
            .get(keep..)
            .is_some_and(|t| t.iter().any(|&d| d != 0));
        digits.resize(keep, 0);
        let away = match self.round {
            Round::Up => !self.neg && dropped,
            Round::Down => self.neg && dropped,
            Round::Nearest | Round::Zero => false,
        };
        if away {
            for d in digits.iter_mut().rev() {
                if *d < 9 {
                    *d += 1;
                    return false;
                }
                *d = 0;
            }
            digits.insert(0, 1);
            return true;
        }
        false
    }

    /// `ddd.ddd` with `p` fraction digits (the f conversion).
    fn fixed(&self, p: usize) -> alloc::string::String {
        if self.round == Round::Nearest {
            return format!("{:.p$}", self.av);
        }
        let (mut digits, mut point) = self.exact();
        point += usize::from(self.cut(&mut digits, point + p));
        let text: alloc::string::String = digits.iter().map(|&d| char::from(b'0' + d)).collect();
        if p == 0 {
            text
        } else {
            format!("{}.{}", &text[..point], &text[point..])
        }
    }

    /// `d.ddd` with `prec` fraction digits and the decimal exponent (the
    /// e conversion).
    fn scientific(&self, prec: usize) -> (alloc::string::String, i32) {
        if self.round == Round::Nearest || self.av == 0.0 {
            let raw = format!("{:.prec$e}", self.av);
            let (mantissa, exp) = raw.split_once('e').unwrap_or((raw.as_str(), "0"));
            return (mantissa.into(), exp.parse().unwrap_or(0));
        }
        let (digits, point) = self.exact();
        let lead = digits.iter().position(|&d| d != 0).unwrap_or(0);
        let mut sig = digits[lead..].to_vec();
        let mut exp = point as i32 - lead as i32 - 1;
        if self.cut(&mut sig, prec + 1) {
            exp += 1;
            sig.truncate(prec + 1);
        }
        let mut m = alloc::string::String::from(char::from(b'0' + sig[0]));
        if prec > 0 {
            m.push('.');
            m.extend(sig[1..].iter().map(|&d| char::from(b'0' + d)));
        }
        (m, exp)
    }
}

/// `d.dddde+/-dd` with `prec` fraction digits (7.19.6.1p8, the e
/// conversion), the exponent in the sign + minimum-two-digit C form.
fn format_exp(dec: &Decimal, prec: usize, alt: bool) -> alloc::string::String {
    let (mut mantissa, exp) = dec.scientific(prec);
    if alt && prec == 0 {
        mantissa.push('.');
    }
    format!(
        "{mantissa}e{}{:02}",
        if exp < 0 { '-' } else { '+' },
        exp.unsigned_abs(),
    )
}

/// A finite value as `%a` writes it: leading hex digit `sig >> 4 * width`,
/// `width` fraction digits below it, scaled by `2^exp`.
#[derive(Clone, Copy)]
struct HexForm {
    sig: u128,
    width: u32,
    exp: i32,
}

/// The value of a floating argument `raw`: binary64 bits, or under `L`
/// where `long double` is wider, the address of its 16-byte image. The
/// interpreter computes `long double` in binary64, so narrowing an image
/// it built is exact; the decimal conversions format any other image
/// rounded to binary64. The `%a` form keeps the argument's own digits and
/// is `None` for an infinity or NaN.
fn float_arg(mem: &Memory, raw: i64, long_double: bool) -> Result<(f64, Option<HexForm>), C5Error> {
    use crate::c5::codegen::LongDoubleKind;
    let wide = if long_double {
        mem.target.long_double()
    } else {
        LongDoubleKind::F64
    };
    let addr = usize::try_from(raw)
        .map_err(|_| C5Error::Runtime(format!("vm_ssa: printf %L: bad ptr 0x{raw:x}")));
    let (bits, sig, width, exp) = match wide {
        LongDoubleKind::F64 => {
            let (sig, exp) = ieee_digits(u128::from(raw as u64), 52, 11);
            (raw as u64, sig, 13, exp)
        }
        LongDoubleKind::X87 => {
            let addr = addr?;
            let frac = load_from_memory(mem, addr, LoadKind::I64)? as u64;
            let se = load_from_memory(mem, addr + 8, LoadKind::U16)? as u16;
            // The explicit integer bit leads the first digit (glibc).
            let exp = if frac == 0 {
                0
            } else {
                i32::from(se & 0x7fff).max(1) - 16383 - 3
            };
            (
                crate::c5::softfp::f80_to_f64(frac, se),
                u128::from(frac),
                15,
                exp,
            )
        }
        LongDoubleKind::Binary128 => {
            let addr = addr?;
            let lo = load_from_memory(mem, addr, LoadKind::I64)? as u64;
            let hi = load_from_memory(mem, addr + 8, LoadKind::I64)? as u64;
            let (sig, exp) = ieee_digits(u128::from(hi) << 64 | u128::from(lo), 112, 15);
            (crate::c5::softfp::f128_to_f64(lo, hi), sig, 28, exp)
        }
    };
    let v = f64::from_bits(bits);
    Ok((v, v.is_finite().then_some(HexForm { sig, width, exp })))
}

/// Significand and exponent of an IEEE interchange encoding with `mant`
/// fraction and `ebits` exponent bits; a subnormal leads with 0 at the
/// minimum exponent.
fn ieee_digits(bits: u128, mant: u32, ebits: u32) -> (u128, i32) {
    let bias = (1 << (ebits - 1)) - 1;
    let e = ((bits >> mant) & ((1 << ebits) - 1)) as i32;
    let m = bits & ((1 << mant) - 1);
    match (e, m) {
        (0, 0) => (0, 0),
        (0, _) => (m, 1 - bias),
        _ => (1 << mant | m, e - bias),
    }
}

/// The target's C library, for the choices C99 leaves open. For `%a`
/// (7.19.6.1p8), each variant's note.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Libc {
    /// Subnormals as `0x0.` at the minimum exponent, trailing zeros
    /// dropped, a halfway tail rounded to even.
    Glibc,
    /// Subnormals normalized; a dropped tail rounds only when its first
    /// digit is nonzero: to nearest when that digit is above 8, or is 8
    /// followed by an odd digit.
    Apple,
    /// As glibc, but without a precision every fraction digit is written.
    Ucrt,
}

impl Libc {
    fn of(target: crate::c5::codegen::Target) -> Self {
        use crate::c5::codegen::Target;
        match target {
            Target::LinuxX64 | Target::LinuxAarch64 => Libc::Glibc,
            Target::MacOSAarch64 => Libc::Apple,
            Target::WindowsX64 | Target::WindowsAarch64 => Libc::Ucrt,
        }
    }

    /// Whether dropping the low `shift` bits `rem` of a digit string ending
    /// in `kept`, of a value of sign `neg`, steps it away from zero in
    /// direction `r`.
    fn rounds_up(self, r: Round, neg: bool, kept: u128, rem: u128, shift: u32) -> bool {
        let d1 = rem >> (shift - 4);
        let dropped = if self == Libc::Apple {
            d1 != 0
        } else {
            rem != 0
        };
        match r {
            Round::Up => !neg && dropped,
            Round::Down => neg && dropped,
            Round::Zero => false,
            Round::Nearest if self == Libc::Apple => {
                let d2 = if shift >= 8 {
                    (rem >> (shift - 8)) & 0xf
                } else {
                    0
                };
                d1 > 8 || (d1 == 8 && d2 & 1 == 1)
            }
            Round::Nearest => {
                let half = 1u128 << (shift - 1);
                rem > half || (rem == half && kept & 1 == 1)
            }
        }
    }
}

/// `h.hhhp[+-]d` for `%a` / `%A` (7.19.6.1p8) of a value of sign `neg`,
/// without the sign and `0x`.
fn format_hex(
    h: HexForm,
    s: &PrintfSpec,
    style: Libc,
    round: Round,
    neg: bool,
) -> alloc::string::String {
    let HexForm {
        mut sig,
        width,
        mut exp,
    } = h;
    if style == Libc::Apple && sig != 0 {
        while sig >> (4 * width) == 0 {
            sig <<= 1;
            exp -= 1;
        }
    }
    let frac = sig & ((1 << (4 * width)) - 1);
    let p = s.precision.unwrap_or(match style {
        Libc::Ucrt => width as usize,
        _ => (width - frac.trailing_zeros().min(4 * width) / 4) as usize,
    });
    let keep = width.min(p as u32);
    let shift = 4 * (width - keep);
    let mut kept = sig >> shift;
    if shift > 0 && style.rounds_up(round, neg, kept, sig & ((1 << shift) - 1), shift) {
        kept += 1;
    }
    // A carry out of a leading `f` starts a new leading digit.
    if kept >> (4 * keep) > 0xf {
        kept >>= 4;
        exp += 4;
    }
    let mut b = format!("{:x}", kept >> (4 * keep));
    if p > 0 || s.alt {
        b.push('.');
    }
    if keep > 0 {
        let digits = keep as usize;
        b += &format!("{:0digits$x}", kept & ((1 << (4 * keep)) - 1));
    }
    b.extend(core::iter::repeat_n('0', p - keep as usize));
    b += &format!("p{}{}", if exp < 0 { '-' } else { '+' }, exp.unsigned_abs());
    if s.conv == b'A' { b.to_uppercase() } else { b }
}

/// Parse `(dst/buf, src/buf, n)` argument triples used by
/// memcpy / memcmp. Validates the size argument and converts
/// pointer args to `usize`.
fn libc_three_arg(name: &str, args: &[i64]) -> Result<(usize, usize, usize), C5Error> {
    if args.len() < 3 {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: {name} expects 3 args, got {}",
            args.len(),
        )));
    }
    let a = args[0];
    let b = args[1];
    let n = libc_size(name, Some(args[2]))?;
    if a < 0 || b < 0 {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: {name}: negative pointer arg",
        )));
    }
    Ok((a as usize, b as usize, n))
}

/// Argument `idx` of an allocation function, a `size_t`: every bit
/// pattern is a size, the largest ones sizes no memory can hold.
fn alloc_size(name: &str, args: &[i64], idx: usize) -> Result<u64, C5Error> {
    let raw = (args.get(idx).copied())
        .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing size arg")))?;
    Ok(raw as u64)
}

/// A heap block of `n` bytes for the guest, or a null pointer with
/// `errno` set to ENOMEM when `n` is `None` (a size past `size_t`) or
/// cannot be allocated.
fn guest_alloc(mem: &mut Memory, n: Option<u64>) -> i64 {
    let base = n.map_or(0, |n| mem.heap_alloc(n));
    if base == 0 {
        mem.set_enomem();
    }
    base as i64
}

/// Validate a libc size argument. Negative sizes turn into
/// `~2^63` after an `as usize` cast and silently allocate /
/// loop on the host; reject them up front with a diagnostic
/// that names the offending shim.
fn libc_size(name: &str, raw: Option<i64>) -> Result<usize, C5Error> {
    let n = raw.ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {name}: missing size arg")))?;
    if n < 0 {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: {name}: negative size {n}",
        )));
    }
    Ok(n as usize)
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
/// * AArch64 setjmp / longjmp intrinsics return "not implemented";
///   they only land in JIT / AOT output.
/// Evaluate a GNU C extended-asm statement (`Inst::InlineAsm`) in the
/// interpreter. The template is parsed into instructions and executed
/// against a 16-entry model register file seeded from the operand
/// values; the results are stored through the output addresses, a value
/// output into the statement's own register `site`. This reproduces the
/// semantics the native encoding runs on hardware, so a fixture
/// round-trips identically on any host. Non-deterministic reads
/// (timestamp counter) yield zero, matching the native fallback in
/// value tests.
fn run_inline_asm(
    mem: &mut Memory,
    frame: &mut Frame<'_>,
    asm: &crate::c5::ir::AsmBlock,
    args: &[ValueId],
    site: ValueId,
) -> Result<(), C5Error> {
    use crate::c5::codegen::x86_64::asm::{AsmOpnd, Mnemonic, parse_template};
    use crate::c5::ir::AsmRegSize;

    // `%zN` prints operand N's size suffix into its mnemonic, as the
    // native lowering resolves it before parsing.
    let text = core::str::from_utf8(&asm.template).map_err(|_| {
        C5Error::Runtime(alloc::string::String::from("inline asm: non-UTF8 template"))
    })?;
    let sized = crate::c5::asm::expand_size_suffix_refs(text, &|idx| {
        asm.operands
            .get(idx as usize)
            .and_then(|op| crate::c5::codegen::x86_64::asm::att_size_suffix(op.width))
    })
    .map_err(C5Error::Runtime)?;
    let insns =
        parse_template(sized.as_deref().unwrap_or(text).as_bytes()).map_err(C5Error::Runtime)?;
    // A cache line write-back or prefetch leaves the interpreter's memory as
    // it is, whatever its operand.
    let insns: alloc::vec::Vec<_> = (insns.into_iter())
        .filter(|i| {
            !matches!(
                i.mnemonic,
                Mnemonic::Table("clflushopt" | "clwb" | "prefetchw" | "prefetchwt1")
            )
        })
        .collect();
    // An `asm goto` label branch transfers control between blocks,
    // which this per-instruction evaluator cannot model.
    if insns.iter().any(|i| {
        i.operands
            .iter()
            .any(|o| matches!(o, AsmOpnd::GotoLabel(_)))
    }) {
        return Err(C5Error::Runtime(alloc::string::String::from(
            "inline asm: asm goto is not supported under --interp",
        )));
    }
    // Explicit `disp(%reg)` references and label addresses touch machine
    // memory / code layout the register model does not carry.
    if insns.iter().any(|i| {
        i.operands.iter().any(|o| {
            matches!(
                o,
                AsmOpnd::Mem { .. }
                    | AsmOpnd::AbsMem { .. }
                    | AsmOpnd::AbsMemRef { .. }
                    | AsmOpnd::IndexMem { .. }
                    | AsmOpnd::SymMem { .. }
                    | AsmOpnd::SymRipRel { .. }
                    | AsmOpnd::RipRel { .. }
                    | AsmOpnd::RipRelRef { .. }
                    | AsmOpnd::LabelAddr { .. }
                    | AsmOpnd::ImmLabel { .. }
                    | AsmOpnd::ImmSym { .. }
            )
        })
    }) {
        return Err(C5Error::Runtime(alloc::string::String::from(
            "inline asm: explicit memory operands are not supported under --interp",
        )));
    }
    crate::c5::codegen::x86_64::asm::check_operand_refs(&insns, asm.operands.len())
        .map_err(C5Error::Runtime)?;
    let op_reg = crate::c5::codegen::x86_64::asm::assign_operand_regs(
        &asm.operands,
        asm.clobber_regs,
        asm.clobber_fp_regs,
        &|i| {
            args.get(i)
                .and_then(|&a| crate::c5::asm::asm_operand_const(frame.func, a))
        },
        // The register model holds every memory operand's address.
        &|_| false,
        crate::c5::codegen::Target::host(),
    )
    .map_err(C5Error::Runtime)?;
    // The interpreter models only the 16 GPRs; an `x` (xmm) operand carries a
    // 128-bit SSE value that has no modeled slot. Such asm also uses SSE
    // instructions, refused below -- reject the operand up front with a clear
    // message rather than mis-model it as a GPR.
    if asm
        .operands
        .iter()
        .any(|op| matches!(op.constraint, crate::c5::ir::AsmConstraint::Fp))
    {
        return Err(C5Error::Runtime(alloc::string::String::from(
            "inline asm: `x` (xmm) register operands are not supported under --interp",
        )));
    }
    // The interpreter carries no condition-flag state across template
    // instructions, so a flag output has nothing to read.
    if asm
        .operands
        .iter()
        .any(|op| matches!(op.constraint, crate::c5::ir::AsmConstraint::Flags(_)))
    {
        return Err(C5Error::Runtime(alloc::string::String::from(
            "inline asm: `=@cc` flag outputs are not supported under --interp",
        )));
    }
    // Model register file; operand `%N` reads / writes its assigned slot.
    let mut xregs = [0i64; 16];
    // Seed input registers, and the current value of a `+` (read-write)
    // output loaded from its destination address.
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        // A bound operand is the stack or frame pointer itself: seed the
        // modeled slot with the proxy `StackPointer` / `FrameAddress` read,
        // and never treat it as a destination address.
        if let crate::c5::ir::AsmConstraint::Bound(b) = op.constraint {
            let rsp = crate::c5::codegen::x86_64::asm::reg_by_name("rsp").map(|(n, _)| n);
            xregs[r as usize] = if Some(b) == rsp {
                frame.stack_base
            } else {
                frame.record
            } as i64;
            continue;
        }
        if !op.is_output || (op.is_rw && op.value) {
            xregs[r as usize] = frame.regs[args[i] as usize];
        } else if op.is_rw {
            let addr = frame.regs[args[i] as usize] as usize;
            xregs[r as usize] = load_from_memory(mem, addr, width_load_kind(op.width))?;
        }
    }

    // Resolve one template operand to its current value and its width.
    let value_of = |o: &AsmOpnd, xregs: &[i64; 16]| -> (i64, AsmRegSize) {
        match *o {
            AsmOpnd::Imm(v) => (v, AsmRegSize::Long),
            // Only the 16 GPRs are modeled; MMX / control / debug / segment
            // registers (marked with register numbers >= 16) read as zero.
            AsmOpnd::Reg { reg, size } if (reg as usize) < 16 => (xregs[reg as usize], size),
            AsmOpnd::Reg { size, .. } => (0, size),
            // The high byte of one of the first four GPRs.
            AsmOpnd::HighReg(n) => ((xregs[n as usize - 4] >> 8) & 0xff, AsmRegSize::Byte),
            AsmOpnd::HighRef(idx) => match op_reg[idx as usize] {
                Some(r) if r < 4 => ((xregs[r as usize] >> 8) & 0xff, AsmRegSize::Byte),
                _ => (0, AsmRegSize::Byte),
            },
            AsmOpnd::Ref { idx, size } => {
                let sz = size.unwrap_or(AsmRegSize::from_width(asm.operands[idx as usize].width));
                match op_reg[idx as usize] {
                    Some(r) => (xregs[r as usize], sz),
                    None => (frame.regs[args[idx as usize] as usize], sz),
                }
            }
            // `%cN` / `%PN`: the operand's value, as an immediate.
            AsmOpnd::RefConst { idx, .. } => (
                frame.regs[args[idx as usize] as usize],
                AsmRegSize::from_width(asm.operands[idx as usize].width),
            ),
            // Label / memory references are refused before this loop.
            AsmOpnd::Label { .. }
            | AsmOpnd::LabelAddr { .. }
            | AsmOpnd::ImmLabel { .. }
            | AsmOpnd::ImmSym { .. }
            | AsmOpnd::GotoLabel(_)
            | AsmOpnd::Mem { .. }
            | AsmOpnd::AbsMem { .. }
            | AsmOpnd::AbsMemRef { .. }
            | AsmOpnd::IndexMem { .. }
            | AsmOpnd::SymMem { .. }
            | AsmOpnd::SymRipRel { .. }
            | AsmOpnd::RipRel { .. }
            | AsmOpnd::RipRelRef { .. } => (0, AsmRegSize::Long),
        }
    };
    // The model register a destination operand writes into.
    let dst_reg = |o: &AsmOpnd| -> Option<usize> {
        match *o {
            // A write into an unmodelled register (MMX / control / debug /
            // segment, marked >= 16) has no modeled slot: no-op.
            AsmOpnd::Reg { reg, .. } => (reg < 16).then_some(reg as usize),
            AsmOpnd::Ref { idx, .. } => op_reg[idx as usize].map(|r| r as usize),
            // A high-byte write updates bits 8..16 of its GPR, which the
            // model's whole-register slots do not express: no-op.
            AsmOpnd::HighReg(_)
            | AsmOpnd::HighRef(_)
            | AsmOpnd::Imm(_)
            | AsmOpnd::RefConst { .. }
            | AsmOpnd::Label { .. }
            | AsmOpnd::LabelAddr { .. }
            | AsmOpnd::ImmLabel { .. }
            | AsmOpnd::ImmSym { .. }
            | AsmOpnd::GotoLabel(_)
            | AsmOpnd::Mem { .. }
            | AsmOpnd::AbsMem { .. }
            | AsmOpnd::AbsMemRef { .. }
            | AsmOpnd::IndexMem { .. }
            | AsmOpnd::SymMem { .. }
            | AsmOpnd::SymRipRel { .. }
            | AsmOpnd::RipRel { .. }
            | AsmOpnd::RipRelRef { .. } => None,
        }
    };

    for insn in &insns {
        let ops = &insn.operands;
        match insn.mnemonic {
            // Literal machine bytes, emit-time data directives, `.skip`
            // padding, and `.align` padding are opaque to the register model,
            // like the privileged / port ops below: no modeled effect under
            // the VM.
            Mnemonic::RawBytes | Mnemonic::Data(_) | Mnemonic::Skip => {}
            // The interpreter is not a CPU emulator: a mnemonic reached through
            // the catalog is refused rather than modeled. Such inline asm is
            // an ahead-of-time / JIT construct, executed natively there.
            // The interpreter is single-threaded: a fence orders nothing.
            Mnemonic::Table("mfence" | "lfence" | "sfence") => {}
            Mnemonic::Table(name) | Mnemonic::ExtMov { name, .. } => {
                return Err(C5Error::Runtime(alloc::format!(
                    "inline asm: `{name}` is not supported under --interp"
                )));
            }
            // `stmxcsr` / `ldmxcsr` of a memory operand, whose register in the
            // model holds the stored value or, for an input, the address.
            Mnemonic::MemExt0F {
                opcode: 0xAE,
                ext: ext @ (2 | 3),
                ..
            } => {
                let AsmOpnd::Ref { idx, .. } = ops[0] else {
                    return Err(C5Error::Runtime(alloc::string::String::from(
                        "inline asm: MXCSR access needs a memory operand under --interp",
                    )));
                };
                let Some(r) = op_reg[idx as usize] else {
                    continue;
                };
                if ext == 3 {
                    xregs[r as usize] = mem.fp.mxcsr() as i64;
                } else {
                    let v = load_from_memory(mem, xregs[r as usize] as usize, LoadKind::U32)?;
                    if let Err(what) = mem.fp.set_mxcsr(v as u32) {
                        return Err(C5Error::Runtime(alloc::format!(
                            "inline asm: MXCSR {v:#x} {what}, which the interpreter does not model"
                        )));
                    }
                }
            }
            Mnemonic::Sse2Rr { .. }
            | Mnemonic::SseMov { .. }
            | Mnemonic::SseRmImm { .. }
            | Mnemonic::SseShiftImm { .. }
            | Mnemonic::SseSignMask { .. }
            | Mnemonic::SseRegPair { .. }
            | Mnemonic::VexSignMask { .. }
            | Mnemonic::SseCvt { .. }
            | Mnemonic::Vex { .. }
            | Mnemonic::VexMov { .. }
            | Mnemonic::VexMovd { .. }
            | Mnemonic::Vex2 { .. }
            | Mnemonic::VexImm3 { .. }
            | Mnemonic::VexImm2 { .. }
            | Mnemonic::VexShiftImm { .. }
            | Mnemonic::VexNullary { .. }
            | Mnemonic::VexElemExtract { .. }
            | Mnemonic::VexElemInsert { .. }
            | Mnemonic::MaskOp { .. }
            | Mnemonic::Kmov { .. }
            | Mnemonic::Evex(_)
            | Mnemonic::VexGpr { .. } => {
                // The interpreter has no XMM register file; SSE inline asm is a
                // native / JIT construct, refused here rather than mis-modeled.
                return Err(C5Error::Runtime(alloc::string::String::from(
                    "inline asm: SSE register ops are not supported under --interp",
                )));
            }
            Mnemonic::Crc32 => {
                let (data, size) = value_of(&ops[0], &xregs);
                let (acc, _) = value_of(&ops[1], &xregs);
                let bytes = insn.suffix.unwrap_or(size).bytes() as u32;
                if let Some(r) = dst_reg(&ops[1]) {
                    xregs[r] = i64::from(crc32(acc as u32, data as u64, bytes, true));
                }
            }
            Mnemonic::Nop | Mnemonic::Rdtsc | Mnemonic::Rdtscp => {
                // No host clock: the timestamp read produces zero in the
                // registers it defines (rax/rdx, and rcx for rdtscp).
                if !matches!(insn.mnemonic, Mnemonic::Nop) {
                    xregs[0] = 0;
                    xregs[2] = 0;
                    xregs[1] = 0;
                }
            }
            Mnemonic::Cpuid => {
                // No host CPUID: the identification read produces zero
                // (feature-absent) in rax/rbx/rcx/rdx.
                xregs[0] = 0;
                xregs[3] = 0;
                xregs[1] = 0;
                xregs[2] = 0;
            }
            Mnemonic::Xgetbv => {
                // No extended control registers: the read produces zero
                // in rax/rdx.
                xregs[0] = 0;
                xregs[2] = 0;
            }
            Mnemonic::Bswap => {
                let (val, size) = value_of(&ops[0], &xregs);
                let w = insn.suffix.unwrap_or(size);
                let sw = byte_swap(val, w);
                if let Some(r) = dst_reg(&ops[0]) {
                    xregs[r] = sw;
                }
            }
            Mnemonic::In => {
                // No I/O ports under the VM (port access is firmware, never
                // a sandboxed fixture): a read yields zero in the accumulator.
                if let Some(r) = dst_reg(&ops[0]) {
                    xregs[r] = 0;
                }
            }
            Mnemonic::Out => {
                // Port write is a no-op: no hardware to receive it.
            }
            Mnemonic::Pause | Mnemonic::SizedNullary { .. } | Mnemonic::Int => {
                // Spin-hint / flags-push / breakpoint: no observable effect
                // on the VM's register model (a debugger is not attached).
            }
            Mnemonic::Movd => {
                // No modeled MMX register file. A read into a GPR (the AT&T
                // destination is a GPR: reg < 16) yields zero; a write into an
                // MMX register is a no-op.
                if let Some(r) = dst_reg(&ops[1])
                    && r < 16
                {
                    xregs[r] = 0;
                }
            }
            Mnemonic::Rdmsr | Mnemonic::Rdpmc => {
                // No MSRs / performance counters under the VM: the eax:edx
                // result reads as zero.
                xregs[0] = 0;
                xregs[2] = 0;
            }
            Mnemonic::Cli
            | Mnemonic::Sti
            | Mnemonic::Invd
            | Mnemonic::Wbinvd
            | Mnemonic::Wrmsr
            | Mnemonic::Monitor
            | Mnemonic::Mwait
            | Mnemonic::AddrReg { .. }
            | Mnemonic::Hlt
            | Mnemonic::Prefix(_) => {
                // Interrupt-flag / cache / MSR-write / monitor-wait / halt
                // control and the legacy prefixes: no observable effect on
                // the VM's register model.
            }
            // The string primitives step %rsi / %rdi and access guest memory,
            // and the x87 / far-branch / SSE-control / invalidation memory
            // forms have no register-model equivalent. Rejecting keeps the VM
            // from silently skipping a memory effect the caller depends on.
            Mnemonic::Fixed(_)
            | Mnemonic::Fsubp
            | Mnemonic::StringOp { .. }
            | Mnemonic::MemExt { .. }
            | Mnemonic::MemExt0F { .. }
            | Mnemonic::FarBranch { .. }
            | Mnemonic::InvMem { .. } => {
                return Err(C5Error::Runtime(alloc::string::String::from(
                    "inline asm: string / x87 / far-branch / system instruction is not supported under the VM",
                )));
            }
            Mnemonic::Inc | Mnemonic::Dec => {
                let (v, sz) = value_of(&ops[0], &xregs);
                let w = insn.suffix.unwrap_or(sz);
                let res = if insn.mnemonic == Mnemonic::Inc {
                    v.wrapping_add(1)
                } else {
                    v.wrapping_sub(1)
                };
                if let Some(r) = dst_reg(&ops[0]) {
                    xregs[r] = merge_width(xregs[r], res, w);
                }
            }
            Mnemonic::Xadd => {
                // `xadd src, dst`: dst gets dst+src, src gets the old dst.
                let (src, ssz) = value_of(&ops[0], &xregs);
                let (dst, dsz) = value_of(&ops[1], &xregs);
                let w = insn.suffix.unwrap_or(dsz);
                let sum = dst.wrapping_add(src);
                if let Some(r) = dst_reg(&ops[1]) {
                    xregs[r] = merge_width(xregs[r], sum, w);
                }
                if let Some(r) = dst_reg(&ops[0]) {
                    xregs[r] = merge_width(xregs[r], dst, insn.suffix.unwrap_or(ssz));
                }
            }
            Mnemonic::Cmpxchg => {
                // `cmpxchg src, dst`: if the accumulator equals dst, dst gets
                // src; otherwise the accumulator gets dst.
                let (src, _) = value_of(&ops[0], &xregs);
                let (dst, dsz) = value_of(&ops[1], &xregs);
                let w = insn.suffix.unwrap_or(dsz);
                if mask_width(xregs[0], w) == mask_width(dst, w) {
                    if let Some(r) = dst_reg(&ops[1]) {
                        xregs[r] = merge_width(xregs[r], src, w);
                    }
                } else {
                    xregs[0] = merge_width(xregs[0], dst, w);
                }
            }
            Mnemonic::Shld | Mnemonic::Shrd => {
                let (count, _) = value_of(&ops[0], &xregs);
                let (src, _) = value_of(&ops[1], &xregs);
                let (dst, dsz) = value_of(&ops[2], &xregs);
                let w = insn.suffix.unwrap_or(dsz);
                let res = double_shift(insn.mnemonic == Mnemonic::Shld, dst, src, count, w);
                if let Some(r) = dst_reg(&ops[2]) {
                    xregs[r] = merge_width(xregs[r], res, w);
                }
            }
            Mnemonic::Shl | Mnemonic::Shr | Mnemonic::Sar => {
                let (dst, dsz) = value_of(ops.last().unwrap(), &xregs);
                let w = insn.suffix.unwrap_or(dsz);
                let count = if ops.len() == 2 {
                    value_of(&ops[0], &xregs).0
                } else {
                    1
                };
                let res = single_shift(insn.mnemonic, dst, count, w);
                if let Some(r) = dst_reg(ops.last().unwrap()) {
                    xregs[r] = merge_width(xregs[r], res, w);
                }
            }
            Mnemonic::Or
            | Mnemonic::And
            | Mnemonic::Add
            | Mnemonic::Sub
            | Mnemonic::Xor
            | Mnemonic::Mov => {
                let (src, _) = value_of(&ops[0], &xregs);
                let (dst, dsz) = value_of(&ops[1], &xregs);
                let w = insn.suffix.unwrap_or(dsz);
                let res = match insn.mnemonic {
                    Mnemonic::Or => dst | src,
                    Mnemonic::And => dst & src,
                    Mnemonic::Add => dst.wrapping_add(src),
                    Mnemonic::Sub => dst.wrapping_sub(src),
                    Mnemonic::Xor => dst ^ src,
                    _ => src,
                };
                if let Some(r) = dst_reg(&ops[1]) {
                    xregs[r] = merge_width(xregs[r], res, w);
                }
            }
        }
    }

    // Store the outputs back through their destination addresses; a value
    // output is the register of the statement or of its `AsmOut`.
    let values = frame.func.asm_output_values(site);
    for (i, op) in asm.operands.iter().enumerate() {
        if op.is_output
            && !matches!(op.constraint, crate::c5::ir::AsmConstraint::Bound(_))
            && let Some(r) = op_reg[i]
        {
            if op.value {
                if let Some(&(_, dst)) = values
                    .iter()
                    .find(|&&(k, d)| k == i && d != crate::c5::ir::NO_VALUE)
                {
                    frame.regs[dst as usize] = xregs[r as usize];
                }
                continue;
            }
            let addr = frame.regs[args[i] as usize] as usize;
            store_to_memory(mem, addr, xregs[r as usize], width_store_kind(op.width))?;
        }
    }
    Ok(())
}

/// Mask a value to `w`'s low bits (an infinite-precision result is
/// truncated to the operand width before it lands in a register).
fn mask_width(v: i64, w: crate::c5::ir::AsmRegSize) -> i64 {
    match w.bytes() {
        1 => v & 0xFF,
        2 => v & 0xFFFF,
        4 => v & 0xFFFF_FFFF,
        _ => v,
    }
}

/// Write a result into a model register with x86 destination semantics: a
/// byte or word operation leaves the upper bits of the destination intact,
/// a 32-bit operation zero-extends to 64.
fn merge_width(prev: i64, res: i64, w: crate::c5::ir::AsmRegSize) -> i64 {
    match w.bytes() {
        1 => (prev & !0xFFi64) | (res & 0xFF),
        2 => (prev & !0xFFFFi64) | (res & 0xFFFF),
        _ => mask_width(res, w),
    }
}

/// Byte-reverse the low `w` bytes of `v` (BSWAP).
/// The reflected CRC-32 of `data`'s low `bytes`, accumulated onto `acc` with
/// no inversion, as the CRC32 instructions compute it: the IEEE polynomial,
/// or Castagnoli's (x86 CRC32, AArch64 CRC32C*).
pub(super) fn crc32(mut acc: u32, data: u64, bytes: u32, castagnoli: bool) -> u32 {
    let poly = if castagnoli { 0x82F6_3B78 } else { 0xEDB8_8320 };
    for k in 0..bytes {
        acc ^= u32::from((data >> (8 * k)) as u8);
        for _ in 0..8 {
            acc = (acc >> 1) ^ (poly & (acc & 1).wrapping_neg());
        }
    }
    acc
}

fn byte_swap(v: i64, w: crate::c5::ir::AsmRegSize) -> i64 {
    match w.bytes() {
        8 => v.swap_bytes(),
        _ => (v as u32).swap_bytes() as i64,
    }
}

/// Double-precision shift (SHLD / SHRD): shift `dst` by `count`,
/// feeding in bits from `src`. `w` is the operand bit width.
fn double_shift(left: bool, dst: i64, src: i64, count: i64, w: crate::c5::ir::AsmRegSize) -> i64 {
    let bits = (w.bytes() as u32) * 8;
    let n = (count as u64 as u32) % bits;
    let dst = mask_width(dst, w) as u64;
    let src = mask_width(src, w) as u64;
    if n == 0 {
        return mask_width(dst as i64, w);
    }
    let r = if left {
        (dst << n) | (src >> (bits - n))
    } else {
        (dst >> n) | (src << (bits - n))
    };
    mask_width(r as i64, w)
}

/// Single-operand shift (SHL / SHR / SAR).
fn single_shift(
    m: crate::c5::codegen::x86_64::asm::Mnemonic,
    dst: i64,
    count: i64,
    w: crate::c5::ir::AsmRegSize,
) -> i64 {
    use crate::c5::codegen::x86_64::asm::Mnemonic;
    let bits = (w.bytes() as u32) * 8;
    let n = (count as u64 as u32) & (bits - 1);
    let val = mask_width(dst, w) as u64;
    match m {
        Mnemonic::Shl => (val << n) as i64,
        Mnemonic::Shr => (val >> n) as i64,
        _ => {
            // Arithmetic: sign-extend from the operand width, then shift.
            let signed = sign_extend(dst, w);
            signed >> n
        }
    }
}

/// Sign-extend the low `w` bits of `v` to a full i64.
fn sign_extend(v: i64, w: crate::c5::ir::AsmRegSize) -> i64 {
    match w.bytes() {
        1 => v as i8 as i64,
        2 => v as i16 as i64,
        4 => v as i32 as i64,
        _ => v,
    }
}

fn width_load_kind(width: u8) -> LoadKind {
    match width {
        1 => LoadKind::U8,
        2 => LoadKind::U16,
        4 => LoadKind::U32,
        _ => LoadKind::I64,
    }
}

fn width_store_kind(width: u8) -> StoreKind {
    match width {
        1 => StoreKind::I8,
        2 => StoreKind::I16,
        4 => StoreKind::I32,
        _ => StoreKind::I64,
    }
}

/// Evaluate one x86 SIMD instruction on the interpreter's memory. The
/// operand images are read from and written back to the addresses the
/// walker passed, so the result placement matches the native lowering.
fn run_x86_simd(
    mem: &mut Memory,
    frame: &mut Frame<'_>,
    op: u32,
    imm: Option<u8>,
    args: &[ValueId],
) -> Result<(), C5Error> {
    use crate::c5::simd::{self, Form};
    let row = simd::get(op);
    if row.bytes >= 32 || row.form.is_opmask() {
        return run_x86_simd_wide(mem, frame, row, imm, args);
    }
    let reg = |i: usize| frame.regs[args[i] as usize] as usize;
    // An MMX form reads and writes the low `row.bytes` of each image; a
    // widening or narrowing one its operands' and its result's widths.
    let n = usize::from(row.bytes);
    let read_n = |mem: &Memory, addr: usize, n: usize| -> Result<[u8; 16], C5Error> {
        let mut v = [0u8; 16];
        v[..n].copy_from_slice(mem.read_bytes(addr, n)?);
        Ok(v)
    };
    let read = |mem: &Memory, addr: usize| read_n(mem, addr, n);
    let arg = |mem: &Memory, k: usize| read_n(mem, reg(k + 1), usize::from(row.arg_bytes(k)));
    let ret_n = usize::from(row.ret_bytes()).max(1);
    // The destination plus the sources, less what the node carries as an
    // immediate: the folded `imm8` and a constant shift count.
    let want = if row.form == Form::Store {
        2
    } else {
        row.form.arity() + 1
            - usize::from(row.form.takes_imm())
            - usize::from(row.form == Form::Shift && imm.is_some())
    };
    if args.len() < want {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: {} expects {want} operands",
            row.name
        )));
    }
    let imm8 = imm.unwrap_or(0);
    match row.form {
        Form::Vvv | Form::VvvI
            if row.bytes <= 16 && (row.form == Form::Vvv || row.base_sem() != row.sem) =>
        {
            let (acc, a, b) = (arg(mem, 0)?, arg(mem, 1)?, arg(mem, 2)?);
            let (sem, b, _) = simd::by_element(row.sem, &b, imm8);
            let out = simd::eval_float_acc(&mut mem.fp, sem, (&acc, &a, &b), n)
                .or_else(|| simd::eval_acc(sem, &acc, &a, &b));
            let Some(out) = out else {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: {} has no 16-byte form",
                    row.name
                )));
            };
            mem.write_bytes(reg(0), &out[..ret_n])?;
        }
        Form::Vvv
        | Form::VvvI
        | Form::CmpMask
        | Form::MaskBlend
        | Form::MaskLoad
        | Form::MaskStore
        | Form::Narrow
        | Form::Widen
        | Form::Zext => {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: {} has no 16-byte form",
                row.name
            )));
        }
        Form::Vv | Form::VvI => {
            let (a, b) = (arg(mem, 0)?, arg(mem, 1)?);
            let (sem, b, imm8) = simd::by_element(row.sem, &b, imm8);
            let out = simd::eval_float_in(&mut mem.fp, sem, &a, &b, imm8, n).unwrap_or_else(|| {
                if n == 8 && ret_n == 8 {
                    simd::eval64(sem, &a, &b, imm8, 0)
                } else {
                    simd::eval(sem, &a, &b, imm8, 0)
                }
            });
            mem.write_bytes(reg(0), &out[..ret_n])?;
        }
        Form::V | Form::VI => {
            let a = arg(mem, 0)?;
            let out = simd::eval_float_in(&mut mem.fp, row.sem, &a, &[0u8; 16], imm8, n)
                .unwrap_or_else(|| simd::eval(row.sem, &a, &[0u8; 16], imm8, 0));
            mem.write_bytes(reg(0), &out[..ret_n])?;
        }
        Form::Shift => {
            let a = read(mem, reg(1))?;
            // A non-constant count arrives as a value; the instruction
            // reads it as an unsigned 64-bit quantity.
            let count = match imm {
                Some(n) => n as u64,
                None => frame.regs[args[2] as usize] as u64,
            };
            let out = simd::eval(row.sem, &a, &[0u8; 16], 0, count);
            mem.write_bytes(reg(0), &out[..ret_n])?;
        }
        Form::Load => {
            let a = read(mem, reg(1))?;
            mem.write_bytes(reg(0), &a)?;
        }
        Form::Store => {
            let a = read(mem, reg(1))?;
            mem.write_bytes(reg(0), &a)?;
        }
        Form::ToInt => {
            let a = read(mem, reg(1))?;
            let bits = 8 * u32::from(row.int_width);
            let x = simd::eval_to_int(&mut mem.fp, row.sem, &a, bits).unwrap_or(0);
            mem.write_bytes(reg(0), &x.to_le_bytes()[..row.int_width as usize])?;
        }
        Form::Extract => {
            let a = read(mem, reg(1))?;
            let x = simd::eval_extract(&a, row.int_width, imm8);
            mem.write_bytes(reg(0), &(x as i64).to_le_bytes())?;
        }
        Form::MoveMask => {
            let a = read(mem, reg(1))?;
            let x = simd::eval_movemask(&a);
            mem.write_bytes(reg(0), &(x as i64).to_le_bytes())?;
        }
        Form::Insert => {
            let a = read(mem, reg(1))?;
            let x = frame.regs[args[2] as usize] as u64;
            let out = simd::eval_insert(&a, row.int_width, imm8, x);
            mem.write_bytes(reg(0), &out)?;
        }
        Form::RdRand => {
            // The interpreter has no entropy source. `rdrand` reports the
            // failure the ISA defines for that state -- a zero destination
            // and a clear carry -- which callers must already handle.
            let n = row.int_width as usize;
            mem.write_bytes(reg(1), &0u64.to_le_bytes()[..n])?;
            mem.write_bytes(reg(0), &0i64.to_le_bytes())?;
        }
    }
    Ok(())
}

/// [`run_x86_simd`] for an AVX2 or AVX-512 form over 32- or 64-byte vectors
/// ([`crate::c5::simd::eval_wide`]).
fn run_x86_simd_wide(
    mem: &mut Memory,
    frame: &mut Frame<'_>,
    row: &crate::c5::x86_simd::SimdOp,
    imm: Option<u8>,
    args: &[ValueId],
) -> Result<(), C5Error> {
    use crate::c5::simd::{self, Form};
    let n = usize::from(row.bytes);
    let operand = |i: usize| -> Result<usize, C5Error> {
        args.get(i)
            .map(|&a| frame.regs[a as usize] as usize)
            .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: {} lacks operand {i}", row.name)))
    };
    let read = |mem: &Memory, addr: usize| -> Result<[u8; 64], C5Error> {
        let mut v = [0u8; 64];
        v[..n].copy_from_slice(mem.read_bytes(addr, n)?);
        Ok(v)
    };
    let (imm8, zero) = (imm.unwrap_or(0), [0u8; 64]);
    let eval = |a: &[u8; 64], b: &[u8; 64], c: &[u8; 64], count: u64| {
        simd::eval_wide(row.sem, (a, b, c), imm8, count, n)
    };
    let out = match row.form {
        Form::Vv | Form::VvI => {
            let (a, b) = (read(mem, operand(1)?)?, read(mem, operand(2)?)?);
            // A floating-point row runs on each 16-byte part in the
            // interpreter's floating-point environment.
            let mut out = [0u8; 64];
            let mut float = true;
            for k in (0..n).step_by(16) {
                let part = |v: &[u8; 64]| -> [u8; 16] { v[k..k + 16].try_into().unwrap() };
                match simd::eval_float(&mut mem.fp, row.sem, &part(&a), &part(&b), imm8) {
                    Some(o) => out[k..k + 16].copy_from_slice(&o),
                    None => float = false,
                }
            }
            if float { out } else { eval(&a, &b, &zero, 0) }
        }
        Form::Vvv | Form::VvvI => {
            let (a, b, c) = (
                read(mem, operand(1)?)?,
                read(mem, operand(2)?)?,
                read(mem, operand(3)?)?,
            );
            let mut out = [0u8; 64];
            let mut float = true;
            for k in (0..n).step_by(16) {
                let part = |v: &[u8; 64]| -> [u8; 16] { v[k..k + 16].try_into().unwrap() };
                let abc = (&part(&a), &part(&b), &part(&c));
                match simd::eval_float_acc(&mut mem.fp, row.sem, abc, 16) {
                    Some(o) => out[k..k + 16].copy_from_slice(&o),
                    None => float = false,
                }
            }
            if float { out } else { eval(&a, &b, &c, 0) }
        }
        Form::V | Form::VI => {
            let a = read(mem, operand(1)?)?;
            let mut out = [0u8; 64];
            let mut float = true;
            for k in (0..n).step_by(16) {
                let part: [u8; 16] = a[k..k + 16].try_into().unwrap();
                match simd::eval_float(&mut mem.fp, row.sem, &part, &[0; 16], imm8) {
                    Some(o) => out[k..k + 16].copy_from_slice(&o),
                    None => float = false,
                }
            }
            if float {
                out
            } else {
                eval(&a, &zero, &zero, 0)
            }
        }
        Form::Shift => {
            let count = match imm {
                Some(n) => u64::from(n),
                None => frame.regs[args[2] as usize] as u64,
            };
            eval(&read(mem, operand(1)?)?, &zero, &zero, count)
        }
        Form::Load | Form::Store => read(mem, operand(1)?)?,
        Form::Narrow => {
            let (a, p) = (read(mem, operand(1)?)?, usize::from(row.int_width));
            let k = usize::from(imm8) % (n / p);
            return mem.write_bytes(operand(0)?, &a[k * p..k * p + p]);
        }
        Form::Widen => {
            let (mut out, p) = (read(mem, operand(1)?)?, usize::from(row.int_width));
            let k = usize::from(imm8) % (n / p);
            out[k * p..k * p + p].copy_from_slice(mem.read_bytes(operand(2)?, p)?);
            out
        }
        Form::Zext => {
            let (mut out, p) = ([0u8; 64], usize::from(row.int_width));
            out[..p].copy_from_slice(mem.read_bytes(operand(1)?, p)?);
            out
        }
        Form::CmpMask => {
            let (a, b) = (read(mem, operand(1)?)?, read(mem, operand(2)?)?);
            let m = simd::eval_cmp_mask(row.sem, &a, &b, imm8, n);
            mem.write_bytes(operand(0)?, &(m as i64).to_le_bytes())?;
            return Ok(());
        }
        Form::MaskBlend => {
            let (mut out, m, a) = (
                read(mem, operand(1)?)?,
                operand(2)? as u64,
                read(mem, operand(3)?)?,
            );
            let w = usize::from(row.int_width);
            for i in (0..n / w).filter(|&i| m >> i & 1 != 0) {
                out[i * w..i * w + w].copy_from_slice(&a[i * w..i * w + w]);
            }
            out
        }
        // Only the selected lanes are read or written, as the instruction
        // suppresses faults in the others.
        Form::MaskLoad => {
            let (m, p, w) = (operand(1)? as u64, operand(2)?, usize::from(row.int_width));
            let mut out = [0u8; 64];
            for i in (0..n / w).filter(|&i| m >> i & 1 != 0) {
                out[i * w..i * w + w].copy_from_slice(mem.read_bytes(p + i * w, w)?);
            }
            out
        }
        Form::MaskStore => {
            let (p, m, v) = (operand(0)?, operand(1)? as u64, read(mem, operand(2)?)?);
            let w = usize::from(row.int_width);
            for i in (0..n / w).filter(|&i| m >> i & 1 != 0) {
                mem.write_bytes(p + i * w, &v[i * w..i * w + w])?;
            }
            return Ok(());
        }
        Form::MoveMask => {
            let a = read(mem, operand(1)?)?;
            let mut m = 0u64;
            for k in (0..n).step_by(16) {
                m |= simd::eval_movemask(a[k..k + 16].try_into().unwrap()) << k;
            }
            mem.write_bytes(operand(0)?, &(m as i64).to_le_bytes())?;
            return Ok(());
        }
        _ => {
            return Err(C5Error::Runtime(format!(
                "vm_ssa: {} has no {n}-byte form",
                row.name
            )));
        }
    };
    mem.write_bytes(operand(0)?, &out[..n])
}

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
            // 16-byte size rounding and base alignment, matching the native
            // lowering where sp stays 16-aligned: the storage is suitably
            // aligned for any object type (C11 6.2.8), 16-aligned VLA
            // element types included.
            let rounded = ((n_raw as usize) + 15) & !15;
            let base = mem.alloc_aligned_frame(16, rounded)?;
            frame.regs[v as usize] = base as i64;
            Ok(())
        }
        // VLA block reclamation (C99 6.7.6.2): snapshot / restore the
        // frame's bump-allocation cursor so a VLA declared in a block
        // (or a loop body, once per iteration) frees on exit.
        Intrinsic::AllocaSave => {
            frame.regs[v as usize] = mem.stack_top as i64;
            Ok(())
        }
        Intrinsic::AllocaRestore => {
            let saved = args
                .first()
                .map(|&a| frame.regs[a as usize])
                .ok_or_else(|| {
                    C5Error::Runtime("vm_ssa: AllocaRestore expects 1 argument".to_string())
                })?;
            mem.release_frame(saved as usize);
            Ok(())
        }
        Intrinsic::VaStart => {
            let ap_addr = frame.regs[args[0] as usize] as usize;
            let first = frame.stack_base + (frame.locals + frame.func.n_params) * 8;
            store_to_memory(mem, ap_addr, first as i64, StoreKind::I64)
        }
        Intrinsic::VaArg => {
            // `__builtin_va_arg(self, descriptor)` returns the cursor's
            // current value (the address of the next variadic slot) and
            // advances `*self` by the argument's eightbyte span. A
            // scalar occupies one eightbyte; a by-value aggregate spans
            // `ceil(size/8)`, matching how the caller laid it down in the
            // flat single-region va_list. `args[1]` is the packed
            // `VaArgDesc`.
            let descriptor = args.get(1).map(|&a| frame.regs[a as usize]).unwrap_or(0);
            let desc = crate::c5::op::VaArgDesc::unpack(descriptor);
            let size = if desc.by_ref { 8 } else { i64::from(desc.size) };
            let stride = ((size + 7) & !7).max(8);
            let ap_addr = frame.regs[args[0] as usize] as usize;
            if desc.kind == crate::c5::op::VaArgDesc::NONE {
                frame.regs[v as usize] = ap_addr as i64;
                return Ok(());
            }
            let cursor = load_from_memory(mem, ap_addr, LoadKind::I64)?;
            store_to_memory(mem, ap_addr, cursor + stride, StoreKind::I64)?;
            frame.regs[v as usize] = if desc.by_ref {
                load_from_memory(mem, cursor as usize, LoadKind::I64)?
            } else {
                cursor
            };
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
        Intrinsic::Fma | Intrinsic::Fmaf => Err(C5Error::Runtime(format!(
            "vm_ssa: Intrinsic::{intr:?} lowers to Inst::Fma, not Inst::Intrinsic",
        ))),
        // The walker answers 0 on the unoptimized SSA the interpreter
        // runs; the node exists only inside the `-O` pass pipeline.
        Intrinsic::ConstantP
        | Intrinsic::ObjectSize
        | Intrinsic::SubobjectBound
        | Intrinsic::BuiltinArg => Err(C5Error::Runtime(
            "vm_ssa: a deferred builtin is resolved before execution".to_string(),
        )),
        Intrinsic::Sqrt | Intrinsic::Sqrtf => {
            let x = frame.regs[args[0] as usize] as u64;
            let f = if matches!(intr, Intrinsic::Sqrtf) {
                BINARY32
            } else {
                BINARY64
            };
            frame.regs[v as usize] = mem.fp.sqrt(x, f) as i64;
            Ok(())
        }
        Intrinsic::Fabs | Intrinsic::Fabsf => {
            // Clear the IEEE 754 sign bit. The value is held as an f64
            // bit pattern; an f32 value occupies the same sign position.
            let raw = frame.regs[args[0] as usize];
            frame.regs[v as usize] = round_if_f32(
                raw & 0x7fff_ffff_ffff_ffff,
                frame.func.f32_values.get(v as usize),
            );
            Ok(())
        }
        Intrinsic::Floor
        | Intrinsic::Floorf
        | Intrinsic::Ceil
        | Intrinsic::Ceilf
        | Intrinsic::Trunc
        | Intrinsic::Truncf => {
            let x = f64::from_bits(frame.regs[args[0] as usize] as u64);
            let r = match intr {
                Intrinsic::Floor | Intrinsic::Floorf => libm::floor(x),
                Intrinsic::Ceil | Intrinsic::Ceilf => libm::ceil(x),
                _ => libm::trunc(x),
            };
            frame.regs[v as usize] =
                round_if_f32(r.to_bits() as i64, frame.func.f32_values.get(v as usize));
            Ok(())
        }
        // `__builtin_trap()` raises an illegal-instruction exception on
        // the native targets; the interpreter cannot continue past it,
        // so it surfaces as a runtime failure.
        Intrinsic::Trap => Err(C5Error::Runtime("__builtin_trap".to_string())),
        // A spin-loop hint with no architectural effect; the
        // interpreter need do nothing.
        Intrinsic::CpuRelax => {
            frame.regs[v as usize] = 0;
            Ok(())
        }
        // A fence has no effect in the single-threaded interpreter; no
        // operand, no result.
        Intrinsic::AtomicThreadFence
        | Intrinsic::AtomicAcquireFence
        | Intrinsic::AtomicReleaseFence
        | Intrinsic::AtomicSignalFence => Ok(()),
        Intrinsic::X87StoreControlWord => {
            let addr = frame.regs[args[0] as usize] as usize;
            store_to_memory(mem, addr, i64::from(mem.fp.x87_control()), StoreKind::I16)
        }
        Intrinsic::X87LoadControlWord => {
            let addr = frame.regs[args[0] as usize] as usize;
            let fcw = load_from_memory(mem, addr, LoadKind::U16)? as u32;
            mem.fp.set_x87_control(fcw).map_err(|what| {
                C5Error::Runtime(alloc::format!(
                    "fldcw: the {what}, which the interpreter does not model"
                ))
            })
        }
        // The control and status state the environment models; the register
        // area holds zeros, as no x87 or XMM register outlives a statement.
        Intrinsic::X86FxSave => {
            let addr = frame.regs[args[0] as usize] as usize;
            let mut area = [0u8; 512];
            area[..32].copy_from_slice(&mem.fp.fxsave_header());
            mem.write_bytes(addr, &area)
        }
        Intrinsic::X86FxRestore => {
            let addr = frame.regs[args[0] as usize] as usize;
            let header = mem.read_bytes(addr, 32)?.to_vec();
            mem.fp.fxrstor_header(&header).map_err(|what| {
                C5Error::Runtime(alloc::format!(
                    "fxrstor: the {what}, which the interpreter does not model"
                ))
            })
        }
        Intrinsic::X86Sgdt | Intrinsic::X86Sidt | Intrinsic::X86Sldt | Intrinsic::X86Str => {
            // Store forms: no modeled descriptor tables. Zero the operand so
            // a caller reads a defined result. sgdt/sidt write a 10-byte
            // pseudo-descriptor (2-byte limit + 8-byte base); sldt/str write a
            // 2-byte selector.
            let addr = frame.regs[args[0] as usize] as usize;
            let width = match intr {
                Intrinsic::X86Sgdt | Intrinsic::X86Sidt => 10,
                _ => 2,
            };
            for off in 0..width {
                store_to_memory(mem, addr + off, 0, StoreKind::I8)?;
            }
            Ok(())
        }
        Intrinsic::X86Lgdt | Intrinsic::X86Lidt | Intrinsic::X86Lldt | Intrinsic::X86Clflush => {
            // Load a descriptor-table register / flush a cache line: no
            // observable effect on the interpreter's memory or register model.
            Ok(())
        }
        Intrinsic::Divq128 => {
            // Unsigned 128/64 division. args: [q_addr, rem_addr, n0, n1, d].
            // Dividend = (n1 << 64) | n0; quotient -> *q, remainder -> *r.
            let q_addr = frame.regs[args[0] as usize] as usize;
            let rem_addr = frame.regs[args[1] as usize] as usize;
            let n0 = frame.regs[args[2] as usize] as u64 as u128;
            let n1 = frame.regs[args[3] as usize] as u64 as u128;
            let d = frame.regs[args[4] as usize] as u64 as u128;
            if d == 0 {
                return Err(C5Error::Runtime("vm_ssa: divq divide by zero".to_string()));
            }
            let num = (n1 << 64) | n0;
            let quot = (num / d) as u64 as i64;
            let rem = (num % d) as u64 as i64;
            store_to_memory(mem, q_addr, quot, StoreKind::I64)?;
            store_to_memory(mem, rem_addr, rem, StoreKind::I64)?;
            Ok(())
        }
        Intrinsic::Atomic128CmpXchg
        | Intrinsic::Atomic128Xchg
        | Intrinsic::Atomic128FetchAnd
        | Intrinsic::Atomic128FetchOr => {
            // args: [ptr, &oldl, &oldh, in...]. Load the current 128-bit
            // value, publish it through &oldl / &oldh, then store the
            // computed value. Single-threaded, so the exclusive access is
            // an ordinary load / store pair.
            let ptr = frame.regs[args[0] as usize] as usize;
            let oldl_addr = frame.regs[args[1] as usize] as usize;
            let oldh_addr = frame.regs[args[2] as usize] as usize;
            let cur_l = load_from_memory(mem, ptr, LoadKind::I64)?;
            let cur_h = load_from_memory(mem, ptr + 8, LoadKind::I64)?;
            store_to_memory(mem, oldl_addr, cur_l, StoreKind::I64)?;
            store_to_memory(mem, oldh_addr, cur_h, StoreKind::I64)?;
            let (store, new_l, new_h) = match intr {
                Intrinsic::Atomic128CmpXchg => {
                    let cmpl = frame.regs[args[3] as usize];
                    let cmph = frame.regs[args[4] as usize];
                    let newl = frame.regs[args[5] as usize];
                    let newh = frame.regs[args[6] as usize];
                    (cur_l == cmpl && cur_h == cmph, newl, newh)
                }
                Intrinsic::Atomic128Xchg => (
                    true,
                    frame.regs[args[3] as usize],
                    frame.regs[args[4] as usize],
                ),
                Intrinsic::Atomic128FetchAnd => (
                    true,
                    cur_l & frame.regs[args[3] as usize],
                    cur_h & frame.regs[args[4] as usize],
                ),
                _ => (
                    true,
                    cur_l | frame.regs[args[3] as usize],
                    cur_h | frame.regs[args[4] as usize],
                ),
            };
            if store {
                store_to_memory(mem, ptr, new_l, StoreKind::I64)?;
                store_to_memory(mem, ptr + 8, new_h, StoreKind::I64)?;
            }
            Ok(())
        }
        Intrinsic::Atomic128Load | Intrinsic::Atomic128LoadEx => {
            // args: [ptr, &l, &h]. Read the 128-bit object and publish its
            // two halves. Single-threaded, so the exclusive form is a plain
            // load.
            let ptr = frame.regs[args[0] as usize] as usize;
            let l_addr = frame.regs[args[1] as usize] as usize;
            let h_addr = frame.regs[args[2] as usize] as usize;
            let cur_l = load_from_memory(mem, ptr, LoadKind::I64)?;
            let cur_h = load_from_memory(mem, ptr + 8, LoadKind::I64)?;
            store_to_memory(mem, l_addr, cur_l, StoreKind::I64)?;
            store_to_memory(mem, h_addr, cur_h, StoreKind::I64)?;
            Ok(())
        }
        Intrinsic::Atomic128Store | Intrinsic::Atomic128StoreEx => {
            // args: [ptr, l, h]. Store the 128-bit value.
            let ptr = frame.regs[args[0] as usize] as usize;
            let l = frame.regs[args[1] as usize];
            let h = frame.regs[args[2] as usize];
            store_to_memory(mem, ptr, l, StoreKind::I64)?;
            store_to_memory(mem, ptr + 8, h, StoreKind::I64)?;
            Ok(())
        }
        Intrinsic::Atomic128StoreInsert => {
            // args: [ptr, vl, vh, ml, mh]. Masked insert:
            // *mem = (*mem & ~msk) | val.
            let ptr = frame.regs[args[0] as usize] as usize;
            let vl = frame.regs[args[1] as usize];
            let vh = frame.regs[args[2] as usize];
            let ml = frame.regs[args[3] as usize];
            let mh = frame.regs[args[4] as usize];
            let cur_l = load_from_memory(mem, ptr, LoadKind::I64)?;
            let cur_h = load_from_memory(mem, ptr + 8, LoadKind::I64)?;
            store_to_memory(mem, ptr, (cur_l & !ml) | vl, StoreKind::I64)?;
            store_to_memory(mem, ptr + 8, (cur_h & !mh) | vh, StoreKind::I64)?;
            Ok(())
        }
        Intrinsic::AArch64DsbIsh | Intrinsic::AArch64Isb => {
            // Barriers have no observable effect in the single-threaded
            // interpreter.
            Ok(())
        }
        Intrinsic::AArch64DcCvau | Intrinsic::AArch64IcIvau => {
            // Cache maintenance is a no-op against the interpreter's flat
            // memory; the pointer argument is evaluated but unused.
            Ok(())
        }
        Intrinsic::AArch64ReadCacheType => {
            // No host CTR_EL0; return a fixed value with 64-byte data and
            // instruction cache lines (D/IminLine = 4) so a caller
            // computing line sizes gets a sane, non-zero result.
            let addr = frame.regs[args[0] as usize] as usize;
            store_to_memory(mem, addr, 0x8444_C004, StoreKind::I64)?;
            Ok(())
        }
        Intrinsic::FrameAddress => {
            // The interpreter has no native frame pointer; return this
            // frame's record in the byte arena. It is non-zero, stable
            // within a frame, distinct across nested calls, and links to
            // the caller's record at offset 0, so the load chain the
            // parser emits for a level above 0 walks callers as it does
            // natively and reads 0 past the entry frame. (The arena grows
            // up, so a deeper frame has a larger address than on a native
            // stack.)
            frame.regs[v as usize] = frame.record as i64;
            Ok(())
        }
        Intrinsic::StackPointer => {
            // No native stack pointer in the interpreter; return this
            // frame's arena base, the same proxy `FrameAddress` uses. It
            // is non-zero and stable within a frame, enough for callers
            // that store or compare it.
            frame.regs[v as usize] = frame.stack_base as i64;
            Ok(())
        }
        // No unwinder walks the interpreter's frames, so `setjmp` stores
        // the frame that makes `longjmp` restore without unwinding.
        Intrinsic::EstablisherFrame => {
            frame.regs[v as usize] = 0;
            Ok(())
        }
        Intrinsic::FuncletFrame => unreachable!("the interpreter refuses a `__try` region"),
        // The OS's value in x18 (the Windows TEB) has no interpreter
        // counterpart.
        Intrinsic::PlatformRegister => Err(C5Error::Runtime(
            "vm_ssa: the platform register x18 is not modeled under --interp".to_string(),
        )),
        Intrinsic::ReturnAddress => {
            // The return slot of a frame record: this frame's without an
            // operand, the walked-to frame's with one, as natively.
            let record = match args {
                [] => frame.record,
                [walked] => frame.regs[*walked as usize] as usize,
                _ => {
                    return Err(C5Error::Runtime(
                        "vm_ssa: ReturnAddress: expected at most 1 arg".to_string(),
                    ));
                }
            };
            frame.regs[v as usize] = load_from_memory(mem, record + 8, LoadKind::I64)?;
            Ok(())
        }
        // The walker lowers the bit-count and byte-swap builtins to
        // `Inst::BitCount` / `Inst::Bswap`; they never reach the VM as an
        // `Inst::Intrinsic`.
        Intrinsic::Clz
        | Intrinsic::Ctz
        | Intrinsic::Popcount
        | Intrinsic::Clzll
        | Intrinsic::Ctzll
        | Intrinsic::Popcountll
        | Intrinsic::Clrsb
        | Intrinsic::Clrsbll
        | Intrinsic::Parity
        | Intrinsic::Parityll
        | Intrinsic::Ffs
        | Intrinsic::Ffsll
        | Intrinsic::Bswap16
        | Intrinsic::Bswap32
        | Intrinsic::Bswap64 => Err(C5Error::Runtime(
            "vm_ssa: bit builtin reached the intrinsic dispatch".to_string(),
        )),
    }
}

/// Read a typed value out of byte-addressed memory at `addr`.
/// Sign / zero extension follows C99 6.3.1.3 per the LoadKind's
/// signedness. Bounds errors trip a runtime error so a stray
/// pointer doesn't read uninitialised state.
/// `Inst::VecBinop` over the little-endian lane images of its operands:
/// integer lanes wrap, floating ones round as the scalar operation does.
fn vec_binop(
    op: crate::c5::ir::BinOp,
    lane: crate::c5::ir::VecLane,
    a: [u8; 16],
    b: [u8; 16],
) -> [u8; 16] {
    use crate::c5::ir::{BinOp, VecLane};
    let w = lane.bytes() as usize;
    let mut out = [0u8; 16];
    for i in (0..16).step_by(w) {
        let mut x = [0u8; 8];
        let mut y = [0u8; 8];
        x[..w].copy_from_slice(&a[i..i + w]);
        y[..w].copy_from_slice(&b[i..i + w]);
        let (x, y) = (u64::from_le_bytes(x), u64::from_le_bytes(y));
        let r = match (lane, op) {
            (VecLane::F32, _) => {
                let (p, q) = (f32::from_bits(x as u32), f32::from_bits(y as u32));
                u64::from(
                    match op {
                        BinOp::Fadd => p + q,
                        BinOp::Fsub => p - q,
                        BinOp::Fmul => p * q,
                        _ => p / q,
                    }
                    .to_bits(),
                )
            }
            (VecLane::F64, _) => {
                let (p, q) = (f64::from_bits(x), f64::from_bits(y));
                match op {
                    BinOp::Fadd => p + q,
                    BinOp::Fsub => p - q,
                    BinOp::Fmul => p * q,
                    _ => p / q,
                }
                .to_bits()
            }
            (_, BinOp::Add) => x.wrapping_add(y),
            (_, BinOp::Sub) => x.wrapping_sub(y),
            (_, BinOp::Mul) => x.wrapping_mul(y),
            (_, BinOp::And) => x & y,
            (_, BinOp::Or) => x | y,
            _ => x ^ y,
        };
        out[i..i + w].copy_from_slice(&r.to_le_bytes()[..w]);
    }
    out
}

fn load_width(kind: LoadKind) -> usize {
    match kind {
        // The x87 read covers the 10 significant bytes; the binary128
        // read covers all 16.
        LoadKind::F80 => 10,
        LoadKind::F128 | LoadKind::V128 => 16,
        LoadKind::V256 => 32,
        LoadKind::V512 => 64,
        LoadKind::I64 | LoadKind::F64 => 8,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
    }
}

fn store_width(kind: StoreKind) -> usize {
    match kind {
        // The x87 store (`fstp` m80) writes 10 bytes and leaves the 6
        // padding bytes untouched; binary128 writes 16.
        StoreKind::F80 => 10,
        StoreKind::F128 | StoreKind::V128 => 16,
        StoreKind::V256 => 32,
        StoreKind::V512 => 64,
        StoreKind::I64 | StoreKind::F64 => 8,
        StoreKind::I32 | StoreKind::F32 => 4,
        StoreKind::I16 => 2,
        StoreKind::I8 => 1,
    }
}

fn load_from_memory(mem: &Memory, addr: usize, kind: LoadKind) -> Result<i64, C5Error> {
    let n = load_width(kind);
    let slice = mem.read_bytes(addr, n)?;
    let val: i64 = match kind {
        LoadKind::I64 => i64::from_le_bytes(slice.try_into().unwrap()),
        LoadKind::I32 => i32::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::U32 => u32::from_le_bytes(slice.try_into().unwrap()) as i64,
        // C99 6.3.1.5: a `float` loaded into a `double`-shaped
        // register widens to the corresponding f64 value. The c5
        // accumulator carries f64 bit patterns, so the load
        // expands the in-memory f32 to f64 and returns its bits.
        LoadKind::F32 => {
            super::fenv::f32_to_reg(u32::from_le_bytes(slice.try_into().unwrap())) as i64
        }
        // `double` is already 8 bytes; the c5 accumulator carries
        // f64 bit patterns, so the load returns the raw 64-bit value.
        LoadKind::F64 => i64::from_le_bytes(slice.try_into().unwrap()),
        // The wide `long double` formats narrow to the f64 the
        // compute path carries (round to nearest, ties to even).
        LoadKind::F80 => {
            let frac = u64::from_le_bytes(slice[..8].try_into().unwrap());
            let se = u16::from_le_bytes(slice[8..10].try_into().unwrap());
            crate::c5::softfp::f80_to_f64(frac, se) as i64
        }
        LoadKind::F128 => {
            let lo = u64::from_le_bytes(slice[..8].try_into().unwrap());
            let hi = u64::from_le_bytes(slice[8..16].try_into().unwrap());
            crate::c5::softfp::f128_to_f64(lo, hi) as i64
        }
        LoadKind::I16 => i16::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::U16 => u16::from_le_bytes(slice.try_into().unwrap()) as i64,
        LoadKind::I8 => slice[0] as i8 as i64,
        LoadKind::U8 => slice[0] as i64,
        // The -O vector promotion producing this kind never reaches the VM.
        LoadKind::V128 | LoadKind::V256 | LoadKind::V512 => {
            return Err(C5Error::Runtime("vector load in the interpreter".into()));
        }
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
        // C99 6.3.1.5: a `double` stored through an lvalue of
        // type `float` is narrowed to single precision. The c5
        // accumulator carries f64 bit patterns, so the store
        // collapses to f32 before writing the 4 bytes.
        StoreKind::F32 => {
            let f = super::fenv::reg_to_f32(value as u64);
            mem.write_bytes(addr, &f.to_le_bytes())
        }
        // `double` is 8 bytes; write the raw f64 bit pattern.
        StoreKind::F64 => mem.write_bytes(addr, &value.to_le_bytes()),
        // The wide `long double` formats widen the f64 exactly.
        StoreKind::F80 => {
            let (frac, se) = crate::c5::softfp::f64_to_f80(value as u64);
            let mut b = [0u8; 10];
            b[..8].copy_from_slice(&frac.to_le_bytes());
            b[8..].copy_from_slice(&se.to_le_bytes());
            mem.write_bytes(addr, &b)
        }
        StoreKind::F128 => {
            let (lo, hi) = crate::c5::softfp::f64_to_f128(value as u64);
            let mut b = [0u8; 16];
            b[..8].copy_from_slice(&lo.to_le_bytes());
            b[8..].copy_from_slice(&hi.to_le_bytes());
            mem.write_bytes(addr, &b)
        }
        StoreKind::V128 | StoreKind::V256 | StoreKind::V512 => {
            Err(C5Error::Runtime("vector store in the interpreter".into()))
        }
    }
}

/// Load / store kinds for a `width`-byte atomic object (C11 7.17.7).
/// The load is signed at the access width so the prior-value result
/// matches a signed read; an unsigned C type's user re-narrows it.
fn atomic_kinds(width: u8) -> (LoadKind, StoreKind) {
    match width {
        1 => (LoadKind::I8, StoreKind::I8),
        2 => (LoadKind::I16, StoreKind::I16),
        4 => (LoadKind::I32, StoreKind::I32),
        _ => (LoadKind::I64, StoreKind::I64),
    }
}

/// The zero-extending load of `width` bytes an `Inst::AtomicLoad`
/// performs.
fn atomic_load_kind(width: u8) -> LoadKind {
    match width {
        1 => LoadKind::U8,
        2 => LoadKind::U16,
        4 => LoadKind::U32,
        _ => LoadKind::I64,
    }
}

/// Reject a code pointer or negative address for an atomic access,
/// mirroring the `Load` / `Store` checks.
fn atomic_addr_check(addr: i64, op: &str) -> Result<(), C5Error> {
    if addr & CODE_ADDR_MASK != 0
        || addr < 0
        || ((addr as usize) >= super::super::CODE_BASE
            && (addr as usize) < super::super::CODE_BASE + (1usize << 20))
    {
        return Err(C5Error::Runtime(format!(
            "vm_ssa: {op}: addr 0x{addr:016x} is not a data pointer (code is not data)",
        )));
    }
    Ok(())
}

/// Truncate a value to the store kind's width; the high bits
/// the byte write doesn't touch keep their previous contents.
fn narrow_store(value: i64, kind: StoreKind) -> i64 {
    match kind {
        StoreKind::I64 => value,
        StoreKind::I32 => (value as i32) as i64,
        StoreKind::I16 => (value as i16) as i64,
        StoreKind::I8 => (value as i8) as i64,
        StoreKind::F32
        | StoreKind::F64
        | StoreKind::F80
        | StoreKind::F128
        | StoreKind::V128
        | StoreKind::V256
        | StoreKind::V512 => value,
    }
}

/// Binop dispatch: floating arithmetic rounds and raises in the program's
/// environment, which a comparison checks for a signaling NaN; the rest is
/// shared with the compile-time constant folder (`super::eval`), whose
/// division trap re-wraps as the VM's runtime error.
fn binop(fp: &mut FpEnv, op: BinOp, lhs: i64, rhs: i64, f: Format) -> Result<i64, C5Error> {
    let (a, b) = (lhs as u64, rhs as u64);
    let r = match op {
        BinOp::Fadd => fp.add(a, b, f),
        BinOp::Fsub => fp.sub(a, b, f),
        BinOp::Fmul | BinOp::FmulContractible => fp.mul(a, b, f),
        BinOp::Fdiv => fp.div(a, b, f),
        _ => {
            if super::super::ir::fp_compare_signals(op) {
                fp.compare_signaling(a, b);
            } else if super::super::ir::is_fp_op(op) {
                fp.compare_operands(a, b);
            }
            return eval::apply_binop(op, lhs, rhs)
                .map_err(|t| C5Error::Runtime(t.message().to_string()));
        }
    };
    Ok(r as i64)
}

/// The format value `v` of `frame`'s function rounds to.
fn format_of(frame: &Frame<'_>, v: ValueId) -> Format {
    if matches!(frame.func.f32_values.get(v as usize), Some(true)) {
        BINARY32
    } else {
        BINARY64
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::Compiler;

    #[test]
    fn printf_string_preserves_high_bytes() {
        // 0xC3 0xA9 (the UTF-8 encoding of U+00E9) must reach stdout as
        // those two raw bytes, not the 4-byte Latin-1 -> UTF-8 re-encoding
        // the old path produced.
        let mut mem = Memory::with_stdio(b"\xC3\xA9\x00", crate::c5::codegen::Target::LinuxX64);
        let out = format_printf(b"%s", Varargs::values(&[0]), &mut mem).expect("format");
        assert_eq!(out, alloc::vec![0xC3u8, 0xA9]);
    }

    #[test]
    fn printf_char_preserves_high_byte() {
        let mut mem = Memory::with_stdio(b"\x00", crate::c5::codegen::Target::LinuxX64);
        let out = format_printf(b"%c", Varargs::values(&[0x80]), &mut mem).expect("format");
        assert_eq!(out, alloc::vec![0x80u8]);
    }

    fn fmt1(fmt: &[u8], args: &[i64]) -> alloc::string::String {
        let mut mem = Memory::with_stdio(b"abcdef\x00", crate::c5::codegen::Target::LinuxX64);
        let out = format_printf(fmt, Varargs::values(args), &mut mem).expect("format");
        alloc::string::String::from_utf8(out).expect("utf8")
    }

    #[test]
    fn printf_width_precision_flags() {
        // C99 7.19.6.1p5-p6: field width, precision, and the
        // -, +, 0, # flags across the integer conversions.
        assert_eq!(fmt1(b"%5d", &[42]), "   42");
        assert_eq!(fmt1(b"%-5d|", &[42]), "42   |");
        assert_eq!(fmt1(b"%05d", &[-42]), "-0042");
        assert_eq!(fmt1(b"%+d %+d", &[7, -7]), "+7 -7");
        assert_eq!(fmt1(b"% d", &[7]), " 7");
        assert_eq!(fmt1(b"%.5d", &[42]), "00042");
        assert_eq!(fmt1(b"%8.5d", &[42]), "   00042");
        assert_eq!(fmt1(b"%.0d", &[0]), "");
        assert_eq!(fmt1(b"%#x %#o", &[255, 8]), "0xff 010");
        assert_eq!(fmt1(b"%08x", &[0xbeef]), "0000beef");
        assert_eq!(fmt1(b"%*d", &[5, 42]), "   42");
        assert_eq!(fmt1(b"%-*d|", &[5, 42]), "42   |");
        assert_eq!(fmt1(b"%.*d", &[4, 42]), "0042");
        assert_eq!(fmt1(b"%10.3s|", &[0]), "       abc|");
        assert_eq!(fmt1(b"%-6.2s|", &[0]), "ab    |");
        assert_eq!(fmt1(b"%3c|", &[b'z' as i64]), "  z|");
    }

    #[test]
    fn printf_length_modifiers() {
        // C99 7.19.6.1p7: hh / h narrow, l / ll / z / j keep the
        // full 64-bit value; the default int case truncates to 32.
        assert_eq!(fmt1(b"%ld", &[0x1_0000_0001]), "4294967297");
        assert_eq!(fmt1(b"%lld", &[-1]), "-1");
        assert_eq!(fmt1(b"%d", &[0x1_0000_0001]), "1");
        assert_eq!(fmt1(b"%hhd", &[0x1ff]), "-1");
        assert_eq!(fmt1(b"%hu", &[0x1_0005]), "5");
        assert_eq!(fmt1(b"%zu", &[u64::MAX as i64]), "18446744073709551615");
        assert_eq!(fmt1(b"%lx", &[-1]), "ffffffffffffffff");
    }

    #[test]
    fn printf_float_conversions() {
        let b = |v: f64| v.to_bits() as i64;
        assert_eq!(fmt1(b"%f", &[b(3.5)]), "3.500000");
        assert_eq!(fmt1(b"%.2f", &[b(6.54321)]), "6.54");
        assert_eq!(fmt1(b"%8.3f", &[b(-6.54321)]), "  -6.543");
        assert_eq!(fmt1(b"%08.3f", &[b(-6.54321)]), "-006.543");
        assert_eq!(fmt1(b"%e", &[b(65432.1875)]), "6.543219e+04");
        assert_eq!(fmt1(b"%.2E", &[b(0.00123)]), "1.23E-03");
        assert_eq!(fmt1(b"%g", &[b(0.0001)]), "0.0001");
        assert_eq!(fmt1(b"%g", &[b(0.00001)]), "1e-05");
        assert_eq!(fmt1(b"%g", &[b(100.0)]), "100");
        assert_eq!(fmt1(b"%.3g", &[b(1234.5)]), "1.23e+03");
        assert_eq!(fmt1(b"%f", &[b(f64::NAN)]), "nan");
        assert_eq!(fmt1(b"%F", &[b(f64::INFINITY)]), "INF");
        assert_eq!(
            fmt1(b"%06f|%-6e|", &[b(f64::INFINITY), b(f64::NAN)]),
            "   inf|nan   |"
        );
    }

    fn fmt_on(target: crate::c5::codegen::Target, data: &[u8], fmt: &[u8], args: &[i64]) -> String {
        let mut mem = Memory::with_stdio(data, target);
        let out = format_printf(fmt, Varargs::values(args), &mut mem).expect("format");
        String::from_utf8(out).expect("utf8")
    }

    /// C99 7.19.6.1p8 "[-]nan" as each target's C library writes it: glibc
    /// the sign bit with `+` and space honored, Apple's libc neither sign nor
    /// flag, the UCRT the sign bit and `nan(ind)` / `nan(snan)` for the x86
    /// default and a signaling NaN.
    #[test]
    fn printf_nan_follows_the_target_library() {
        use crate::c5::codegen::Target::{LinuxX64, MacOSAarch64, WindowsX64};
        let (pos, neg, ind) = (
            0x7FF8_0000_0000_0001_u64,
            0xFFF8_0000_0000_0001_u64,
            0xFFF8_u64 << 48,
        );
        let snan = 0x7FF0_0000_0000_0001_u64;
        let on = |t, f: &[u8], bits: u64| fmt_on(t, &[], f, &[bits as i64]);
        assert_eq!(on(LinuxX64, b"%f|", neg), "-nan|");
        assert_eq!(on(LinuxX64, b"%+F|", pos), "+NAN|");
        assert_eq!(on(LinuxX64, b"% e|", pos), " nan|");
        assert_eq!(on(MacOSAarch64, b"%f|", neg), "nan|");
        assert_eq!(on(MacOSAarch64, b"%+f|", pos), "nan|");
        assert_eq!(on(WindowsX64, b"%f|", ind), "-nan(ind)|");
        assert_eq!(on(WindowsX64, b"%E|", ind), "-NAN(IND)|");
        assert_eq!(on(WindowsX64, b"%g|", neg), "-nan|");
        assert_eq!(on(WindowsX64, b"%+f|", snan), "+nan(snan)|");
    }

    #[test]
    fn printf_hex_float_follows_the_target_library() {
        // C99 7.19.6.1p8 `%a`: glibc and the UCRT write a subnormal as `0x0.`
        // and round a halfway tail to even; Apple's libc normalizes it.
        use crate::c5::codegen::Target::{LinuxX64, MacOSAarch64, WindowsX64};
        let on = |t, f: &[u8], v: f64| fmt_on(t, &[], f, &[v.to_bits() as i64]);
        assert_eq!(on(LinuxX64, b"%a", 4.5), "0x1.2p+2");
        assert_eq!(on(WindowsX64, b"%a", 4.5), "0x1.2000000000000p+2");
        assert_eq!(on(LinuxX64, b"%a", 5e-324), "0x0.0000000000001p-1022");
        assert_eq!(on(MacOSAarch64, b"%a", 5e-324), "0x1p-1074");
        assert_eq!(on(LinuxX64, b"%.0a", 1.5), "0x2p+0");
        assert_eq!(on(MacOSAarch64, b"%.0a", 1.5), "0x1p+0");
        assert_eq!(on(MacOSAarch64, b"%.0a", 1.50390625), "0x2p+0");
        assert_eq!(on(LinuxX64, b"%#.0A", 1.0), "0X1.P+0");
        assert_eq!(on(LinuxX64, b"%010a", -1.0), "-0x0001p+0");
        assert_eq!(on(LinuxX64, b"%010a", f64::INFINITY), "       inf");
        assert_eq!(on(LinuxX64, b"%.3a", 0.0), "0x0.000p+0");
    }

    #[test]
    fn printf_long_double_reads_the_target_image() {
        // An `L` argument on the Linux targets is the address of the 16-byte
        // image; `%La` writes every digit the format holds.
        use crate::c5::codegen::Target::{LinuxAarch64, LinuxX64};
        let x87 = |frac: u64, se: u16| {
            let mut img = frac.to_le_bytes().to_vec();
            img.extend(se.to_le_bytes());
            img.resize(16, 0);
            img
        };
        let (frac, se) = crate::c5::softfp::f64_to_f80(4.5f64.to_bits());
        let f = b"%Lf %La %d";
        assert_eq!(
            fmt_on(LinuxX64, &x87(frac, se), f, &[0, 0, 7]),
            "4.500000 0x9p-1 7"
        );
        let near_two = x87(u64::MAX, 0x3fff);
        assert_eq!(
            fmt_on(LinuxX64, &near_two, b"%La %.0La", &[0, 0]),
            "0xf.fffffffffffffffp-3 0x1p+1"
        );
        let (lo, hi) = crate::c5::softfp::f64_to_f128((-0.25f64).to_bits());
        let mut img = lo.to_le_bytes().to_vec();
        img.extend(hi.to_le_bytes());
        assert_eq!(
            fmt_on(LinuxAarch64, &img, f, &[0, 0, 7]),
            "-0.250000 -0x1p-2 7"
        );
    }

    #[test]
    fn printf_percent_n_stores_count() {
        // C99 7.19.6.1p8: %n stores the bytes written so far.
        let mut mem = Memory::with_stdio(&[0u8; 16], crate::c5::codegen::Target::LinuxX64);
        let out = format_printf(b"abc%nd", Varargs::values(&[8]), &mut mem).expect("format");
        assert_eq!(out, b"abcd".to_vec());
        assert_eq!(load_from_memory(&mem, 8, LoadKind::I32).unwrap(), 3);
    }

    fn ssa_main_of(src: &str) -> FunctionSsa {
        let program = Compiler::new(src.to_string())
            .compile()
            .expect("compile fixture");
        let funcs = super::super::super::codegen::ssa::shadow::produce_ssa_funcs(
            &program,
            super::super::super::Target::MacOSAarch64,
            false,
            true,
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
        let funcs = super::super::super::codegen::ssa::shadow::produce_ssa_funcs(
            &program,
            super::super::super::Target::MacOSAarch64,
            false,
            true,
        )
        .expect("ssa lift");
        let binding_names: alloc::vec::Vec<alloc::string::String> = program
            .dylibs
            .iter()
            .flat_map(|d| d.bindings.iter().map(|b| b.local_name.clone()))
            .collect();
        let mut host = super::super::super::host::StdHost::default();
        run_program(
            &funcs,
            &program.data,
            &binding_names,
            program.entry_pc,
            &mut host,
            super::super::super::Target::MacOSAarch64,
        )
        .expect("ssa run")
    }

    #[test]
    fn exit_terminates_with_status() {
        // C99 7.20.4.3: `exit(status)` ends the program with that
        // status; the interpreter reports it as the program result
        // instead of a runtime error.
        assert_eq!(
            run_full_program(
                "#include <stdlib.h>
                 int main(void) { exit(7); return 1; }",
            ),
            7,
        );
    }

    #[test]
    fn frame_allocation_is_bounded_by_the_stack_region() {
        // A frame past `heap_base` would zero live heap
        // allocations; exhaustion must be a hard error instead.
        let mut mem = Memory::with_stdio(&[], crate::c5::codegen::Target::LinuxX64);
        let heap = mem.heap_alloc(16);
        mem.bytes[heap] = 7;
        let stack_bytes = mem.heap_base - mem.stack_base;
        let err = mem.alloc_frame(stack_bytes + 8).expect_err("must overflow");
        match err {
            C5Error::Runtime(m) => assert!(m.contains("stack overflow"), "{m}"),
            other => panic!("expected Runtime, got {other:?}"),
        }
        assert_eq!(
            mem.bytes[heap], 7,
            "heap byte must survive the failed frame"
        );
    }

    #[test]
    fn deep_recursion_errors_instead_of_corrupting_the_heap() {
        // 40 frames x ~8 KiB exceeds the 256 KiB stack region but
        // stays inside the old `bytes.len()` bound, which silently
        // wiped heap allocations.
        let program = Compiler::new(
            "int f(int n) { char buf[8192]; buf[0] = (char)n; \
             if (n == 0) return buf[0]; return f(n - 1); } \
             int main(void) { return f(40); }"
                .to_string(),
        )
        .compile()
        .expect("compile fixture");
        let funcs = super::super::super::codegen::ssa::shadow::produce_ssa_funcs(
            &program,
            super::super::super::Target::MacOSAarch64,
            false,
            true,
        )
        .expect("ssa lift");
        let mut host = super::super::super::host::StdHost::default();
        let err = run_program(
            &funcs,
            &program.data,
            &[],
            program.entry_pc,
            &mut host,
            super::super::super::Target::MacOSAarch64,
        )
        .expect_err("recursion past the stack region must fail");
        match err {
            crate::C5Error::Runtime(m) => assert!(m.contains("stack overflow"), "{m}"),
            other => panic!("expected Runtime, got {other:?}"),
        }
    }

    fn expect_runtime_err(src: &str, needle: &str) {
        let program = Compiler::new(src.to_string())
            .compile()
            .expect("compile fixture");
        let err = crate::Vm::new(program).run().expect_err("run must fail");
        match err {
            crate::C5Error::Runtime(m) => assert!(m.contains(needle), "`{m}` lacks `{needle}`"),
            other => panic!("expected Runtime, got {other:?}"),
        }
    }

    #[test]
    fn stream_call_on_other_memory_is_diagnosed() {
        expect_runtime_err(
            "#include <stdio.h>\n\
             int main(void) { char b[48]; return fputs(\"x\", (FILE *)b); }",
            "is not an open stream",
        );
    }

    #[test]
    fn a_declared_function_the_interpreter_defines_runs_without_a_binding() {
        // No header binds `printf` or `puts` here, as on Windows, where the
        // C-library sources define the printf family; the interpreter's own
        // definitions serve the calls.
        let src = "int printf(const char *, ...);\nint puts(const char *);\n\
                   int main(void) { return printf(\"%d\", 12) + puts(\"\") - 2; }\n";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        assert_eq!(crate::Vm::new(program).run().expect("run"), 0);
    }

    #[test]
    fn every_function_the_interpreter_supplies_has_a_definition() {
        let mut mem = Memory::with_stdio(&[0u8; 64], crate::c5::codegen::Target::LinuxX64);
        let names = [
            "exit",
            "memcpy",
            "memmove",
            "memset",
            "memcmp",
            "write",
            "read",
            "pread",
            "pwrite",
            "lseek",
            "lseek64",
            "_lseek",
            "_lseeki64",
            "copy_file_range",
            "close",
            "malloc",
            "free",
            "printf",
            "__iob_func",
            "errno_location",
            "fprintf",
            "fputs",
            "puts",
            "fputc",
            "putc",
            "fwrite",
            "fflush",
            "fileno",
            "putchar",
            "open",
            "getenv",
            "setenv",
            "_putenv_s",
            "dlopen",
            "dlsym",
            "dlclose",
            "dlerror",
        ];
        let libraries = (strtox::NAMES.iter())
            .chain(string::NAMES)
            .chain(printf::NAMES)
            .chain(scan::NAMES)
            .chain(locale::NAMES)
            .chain(stream::NAMES)
            .chain(system::NAMES);
        for name in names.into_iter().chain(libraries.copied()) {
            assert!(interp_supplies(name), "{name}");
            if let Err(C5Error::Runtime(m)) =
                dispatch_callext(name, &[0; 4], &mut mem, &mut NullHost)
            {
                assert!(!m.contains("is not implemented"), "{name}: {m}");
            }
        }
        assert!(sort::NAMES.iter().all(|name| interp_supplies(name)));
        assert!(!interp_supplies("system"));
    }

    #[test]
    fn undefined_extern_call_is_undefined_reference() {
        // A declared-but-undefined callee must not dispatch to the
        // function whose ent_pc collides with the placeholder.
        expect_runtime_err(
            "int bar(int); int helper(int x) { return x + 1; } \
             int main(void) { return bar(41); }",
            "undefined reference to `bar`",
        );
    }

    #[test]
    fn undefined_variadic_extern_call_is_undefined_reference() {
        // main sits at ent_pc 0 here; the pre-fix sentinel made
        // this call recurse into main until the host stack overflowed.
        expect_runtime_err(
            "int ghost(int, ...); int main(void) { return ghost(1, 2); }",
            "undefined reference to `ghost`",
        );
    }

    #[test]
    fn undefined_extern_object_is_undefined_reference() {
        // C99 6.9.2: `extern int x;` defines no storage; reading it
        // with no defining TU is a link error, not a zero read.
        expect_runtime_err(
            "extern int missing_obj; int main(void) { return missing_obj + 7; }",
            "undefined reference to `missing_obj`",
        );
    }

    #[test]
    fn a_static_initializer_naming_an_undefined_object_is_undefined_reference() {
        expect_runtime_err(
            "extern int nowhere; int *p = &nowhere; int main(void) { return p != 0; }",
            "undefined reference to `nowhere`",
        );
    }

    #[test]
    fn an_undefined_weak_name_is_the_null_address() {
        // The address of a weak function or object nothing defines is 0
        // in code and in a static initializer, as a link resolves it; the
        // call the address guards is not made.
        let src = "extern int wv __attribute__((weak));\n\
                   extern int wf(void) __attribute__((weak));\n\
                   extern long pv;\n#pragma weak pv\n\
                   int *pw = &wv;\nint (*fw)(void) = wf;\nlong *pp = &pv + 1;\n\
                   int main(void) {\n\
                     if (&wv || wf || &pv || pw || fw || pp != (long *)0 + 1) return 1;\n\
                     return wf ? wf() : 0;\n\
                   }\n";
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        assert_eq!(crate::Vm::new(program).run().expect("run"), 0);
    }

    #[test]
    fn undefined_extern_fn_pointer_is_undefined_reference() {
        expect_runtime_err(
            "int bar(int); int main(void) { int (*fp)(int) = bar; return fp(1); }",
            "undefined reference to `bar`",
        );
    }

    #[test]
    fn bound_data_global_is_diagnosed_under_interp() {
        // `environ` binds to host data; the interpreter's memory
        // model cannot reach the host cell, so the reference is a
        // clean diagnostic rather than a phantom NULL read. Pinned
        // to the macOS target: the Windows headers route `environ`
        // per-arch and Linux defines it in the runtime, so the
        // host-target shape varies.
        let program = Compiler::with_options(
            "#include <unistd.h>\nint main(void) { return environ != 0; }".to_string(),
            crate::Target::MacOSAarch64,
            crate::CompileOptions::default(),
        )
        .compile()
        .expect("compile fixture");
        let err = crate::Vm::new(program).run().expect_err("run must fail");
        match err {
            crate::C5Error::Runtime(m) => {
                assert!(m.contains("bound to host data"), "{m}")
            }
            other => panic!("expected Runtime, got {other:?}"),
        }
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
    fn getenv_round_trips_through_heap() {
        // POSIX `getenv`: the SSA-VM copies the host's value into
        // its heap so the returned pointer outlives further allocs.
        // Set the var via the host adapter so the test is hermetic.
        let src = "#include <stdlib.h>
                   int main(void) {
                       char *p = getenv(\"BADC_SSA_TEST\");
                       if (p == 0) return -1;
                       return (int)p[0];
                   }";
        let program = Compiler::new(src.to_string())
            .compile()
            .expect("compile fixture");
        let funcs = super::super::super::codegen::ssa::shadow::produce_ssa_funcs(
            &program,
            super::super::super::Target::MacOSAarch64,
            false,
            true,
        )
        .expect("ssa lift");
        let binding_names: alloc::vec::Vec<alloc::string::String> = program
            .dylibs
            .iter()
            .flat_map(|d| d.bindings.iter().map(|b| b.local_name.clone()))
            .collect();
        let mut host = super::super::super::host::StdHost::default();
        host.setenv(
            "BADC_SSA_TEST",
            "Z",
            super::super::super::host::Overwrite::Force,
        );
        let rc = run_program(
            &funcs,
            &program.data,
            &binding_names,
            program.entry_pc,
            &mut host,
            super::super::super::Target::MacOSAarch64,
        )
        .expect("ssa run");
        assert_eq!(rc, 'Z' as i64);
    }

    #[test]
    fn malloc_then_round_trip() {
        // C99 7.20.3.3 + 7.21.2.1: `malloc(16)` returns a real
        // writable pointer; we write two ints and assert the
        // sum matches.
        assert_eq!(
            run_full_program(
                "#include <stdlib.h>
                 int main(void) {
                     int *p = malloc(16);
                     if (p == 0) return 1;
                     p[0] = 17;
                     p[1] = 25;
                     int sum = p[0] + p[1];
                     free(p);
                     return sum;
                 }",
            ),
            42,
        );
    }

    #[test]
    fn memcpy_memset_memcmp_round_trip() {
        // Exercises the three pure-memory libc shims through
        // `Inst::CallExt`. <string.h> registers the bindings;
        // the test memset's 8 bytes to 0xaa, memcpy's them into
        // a second buffer, and asserts memcmp returns 0.
        assert_eq!(
            run_full_program(
                "#include <string.h>
                 int main(void) {
                     char a[8];
                     char b[8];
                     memset(a, 0xaa, 8);
                     memcpy(b, a, 8);
                     return memcmp(a, b, 8);
                 }",
            ),
            0,
        );
    }

    #[test]
    fn callext_unimplemented_returns_runtime_error() {
        // A library call the interpreter has no definition of stops the
        // program with a runtime error naming it.
        use crate::Compiler;
        let program = Compiler::new(
            "#include <stdlib.h>\nint main(void) { return system(\"true\"); }".to_string(),
        )
        .compile()
        .expect("compile fixture");
        let funcs = super::super::super::codegen::ssa::shadow::produce_ssa_funcs(
            &program,
            super::super::super::Target::MacOSAarch64,
            false,
            true,
        )
        .expect("ssa lift");
        let binding_names: alloc::vec::Vec<alloc::string::String> = program
            .dylibs
            .iter()
            .flat_map(|d| d.bindings.iter().map(|b| b.local_name.clone()))
            .collect();
        let mut host = super::super::super::host::StdHost::default();
        let err = run_program(
            &funcs,
            &program.data,
            &binding_names,
            program.entry_pc,
            &mut host,
            super::super::super::Target::MacOSAarch64,
        )
        .expect_err("system should land in the unimplemented arm");
        match err {
            crate::C5Error::Runtime(msg) => {
                assert!(
                    msg.contains("library call `system` is not implemented"),
                    "expected system in the error, got: {msg}",
                );
            }
            other => panic!("expected Runtime, got {other:?}"),
        }
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
