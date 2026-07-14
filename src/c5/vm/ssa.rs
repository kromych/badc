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
    AtomicRmwOp, BinOp, FunctionSsa, Inst, LoadKind, StoreKind, Terminator, ValueId,
};
use super::eval::{self, round_if_f32};

/// `Inst::ImmCode` results are tagged with this bit set so
/// `Inst::CallIndirect` can distinguish a function pointer from
/// a real memory address. The low bits hold the callee's
/// `ent_pc`; the tag is cleared before `Program::lookup`.
/// `Vm::with_host` patches static-initializer function pointers in
/// the data image with the same tag so a value loaded from data
/// compares equal to one materialized from an `Inst::ImmCode`.
pub(super) const CODE_ADDR_TAG: i64 = 0x4000_0000_0000_0000;
const CODE_ADDR_MASK: i64 = 0x4000_0000_0000_0000;

/// `Inst::ImmExtCode` results carry this bit so `Inst::CallIndirect`
/// routes a call through an imported-function address (`&strcmp`)
/// to the libc dispatch by binding index rather than looking up a
/// c5 function body. The low bits hold the binding index.
const IMPORT_ADDR_TAG: i64 = 0x2000_0000_0000_0000;

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
///                                     short-lived).
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
    fn new(data: &[u8]) -> Self {
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
        Self {
            bytes,
            data_end,
            stack_top: data_end,
            heap_base,
            heap_top: heap_base,
            stack_base: data_end,
            allocations: Vec::new(),
            next_alloc_id: 1,
            track_pointers: false,
        }
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
    /// dangling-pointer behaviour, but mistaken accesses get
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
        let base = self.heap_alloc(src.len() + 1);
        if base == 0 {
            return 0;
        }
        self.bytes[base..base + src.len()].copy_from_slice(src);
        self.bytes[base + src.len()] = 0;
        base
    }

    /// Bump-pointer `malloc`. Grows `bytes` on demand.
    fn heap_alloc(&mut self, n: usize) -> usize {
        let aligned = (n + 15) & !15;
        let base = self.heap_top;
        let next = base.saturating_add(aligned);
        if next > self.bytes.len() {
            self.bytes.resize(next, 0);
        }
        // Zero the new region so a `malloc` caller doesn't read
        // a previous allocation's leftovers (C99 doesn't promise
        // zeroed memory but it's friendlier than uninitialised).
        for b in &mut self.bytes[base..next] {
            *b = 0;
        }
        self.heap_top = next;
        self.record_allocation(base, n);
        base
    }

    fn alloc_frame(&mut self, frame_bytes: usize) -> Result<usize, C5Error> {
        let base = self.stack_top;
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
            binding_names: &[],
            tls_base: 0,
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

    fn lookup(&self, ent_pc: usize) -> Option<&'a FunctionSsa> {
        self.ent_pc_to_idx.get(&ent_pc).map(|&i| &self.funcs[i])
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
    run_program(funcs, &[], &[], func.ent_pc, &mut host)
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
) -> Result<i64, C5Error> {
    run_program_with_args(funcs, data, binding_names, 0, entry_pc, host, &[])
}

/// Multi-function entry that stages `args` as `argv` for the
/// entry function. Per C99 5.1.2.2.1, `main` may be declared
/// either as `int main(void)` or `int main(int argc, char *argv[])`;
/// the parser emits the latter shape with `argc` at param slot 0
/// (frame slot 2) and `argv` at param slot 1 (frame slot 3).
/// When `args` is empty both pass through as 0; C99 5.1.2.2.1
/// allows that shape for a hosted program.
pub(super) fn run_program_with_args<H: Host>(
    funcs: &[FunctionSsa],
    data: &[u8],
    binding_names: &[alloc::string::String],
    tls_base: usize,
    entry_pc: usize,
    host: &mut H,
    args: &[alloc::string::String],
) -> Result<i64, C5Error> {
    run_program_with_args_tracked(
        funcs,
        data,
        binding_names,
        tls_base,
        entry_pc,
        host,
        args,
        false,
        &[],
        &[],
    )
}

/// Same as [`run_program_with_args`] with an explicit
/// `track_pointers` flag. `super::Vm::with_pointer_tracking`
/// forwards through here so opted-in tests get the watchful
/// load / store / Mcpy checks.
#[allow(clippy::too_many_arguments)]
pub(super) fn run_program_with_args_tracked<H: Host>(
    funcs: &[FunctionSsa],
    data: &[u8],
    binding_names: &[alloc::string::String],
    tls_base: usize,
    entry_pc: usize,
    host: &mut H,
    args: &[alloc::string::String],
    track_pointers: bool,
    init_pcs: &[usize],
    fini_pcs: &[usize],
) -> Result<i64, C5Error> {
    let prog = Program::new(funcs)
        .with_bindings(binding_names)
        .with_tls_base(tls_base);
    let (data_with_argv, argc, argv_addr) = stage_argv(data, args);
    let mut mem = Memory::new(&data_with_argv).with_track_pointers(track_pointers);
    // `__attribute__((constructor))` functions run before the entry, in
    // the native `.init_array` order the caller already sorted. An
    // `exit()` from a constructor short-circuits to the exit status.
    for &pc in init_pcs {
        let ctor = prog
            .lookup(pc)
            .ok_or_else(|| C5Error::Runtime(format!("vm_ssa: no constructor at ent_pc {pc}")))?;
        if let Err(e) = run_func(&prog, &mut mem, host, ctor, &[]) {
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
    let slice: &[i64] = if entry.n_params == 0 {
        &[]
    } else {
        &entry_args
    };
    let status = match run_func(&prog, &mut mem, host, entry, slice) {
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
        if let Err(e) = run_func(&prog, &mut mem, host, dtor, &[]) {
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

/// Run one function in the program context. `args` lands in the
/// parameter byte slots per the c5 cdecl: arg `i` at
/// `stack_base + (locals + i) * 8`.
fn run_func<H: Host>(
    prog: &Program<'_>,
    mem: &mut Memory,
    host: &mut H,
    func: &FunctionSsa,
    args: &[i64],
) -> Result<i64, C5Error> {
    let locals = func.locals.max(0) as usize;
    let n_params = func.n_params.max(args.len());
    let frame_bytes = (locals + n_params) * 8;
    let stack_base = mem.alloc_frame(frame_bytes)?;
    for (i, &v) in args.iter().enumerate() {
        // Host-ABI register-passed aggregate parameter: `v` is the
        // source struct's address. The callee body reads the aggregate
        // from a parser-reserved body local (no entry copy in the SSA),
        // so copy `size` bytes there directly -- the native prologue's
        // register scatter, in interpreter terms.
        if let Some(Some(idx)) = func.param_aggs.get(i).copied() {
            let size = func.agg_descs[idx as usize].size as usize;
            let slot = func.param_local_slots[i];
            let dst = (stack_base as i64 + (locals as i64 + slot) * 8) as usize;
            mem.copy_within(dst, v as usize, size)?;
            continue;
        }
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
                // `target` holds a label-address token produced by
                // Inst::BlockAddr (CODE_ADDR_TAG | block index). Mask the
                // tag to recover the destination block index.
                let tok = frame.regs[target as usize];
                frame.block_idx = (tok & !CODE_ADDR_TAG) as usize;
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

/// Materialise a call's result. For a host-ABI aggregate return,
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
            out.push((f64::from_bits(val as u64) as f32).to_bits() as i64);
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
            // the native emit materialises); the interpreter's register
            // convention keeps every f32 value as the f64 pattern of
            // its single-precision value, so widen at the definition.
            frame.regs[v as usize] = if matches!(frame.func.f32_values.get(v as usize), Some(true))
            {
                (f32::from_bits(*k as u32) as f64).to_bits() as i64
            } else {
                *k
            };
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
        Inst::ImmExtCode(binding_idx) => {
            // Address of an imported function (`&strcmp`). The VM has
            // no native code for libc, so the pointer carries the
            // binding index under `IMPORT_ADDR_TAG`; `CallIndirect`
            // routes it to the libc dispatch.
            frame.regs[v as usize] = IMPORT_ADDR_TAG | *binding_idx;
            return Ok(());
        }
        Inst::BlockAddr(b) => {
            // Label address (GCC `&&label`). Tag the block index as a
            // code pointer so it is non-zero (truthy, like a real label
            // address) and distinct from a data address; GotoIndirect
            // masks the tag back off to recover the block index.
            frame.regs[v as usize] = CODE_ADDR_TAG | (*b as i64);
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
            let stored = narrow_store(frame.regs[*value as usize], *kind);
            store_to_memory(mem, a as usize, stored, *kind)?;
            // c5 Store leaves the stored value in the accumulator;
            // downstream uses of this Inst id read that value.
            frame.regs[v as usize] = stored;
            return Ok(());
        }
        Inst::LoadLocal { off, kind, .. } => {
            let addr = frame.slot_addr(*off).ok_or_else(|| {
                C5Error::Runtime(format!("vm_ssa: LoadLocal: slot {off} out of range"))
            })?;
            frame.regs[v as usize] = load_from_memory(mem, addr, *kind)?;
            return Ok(());
        }
        Inst::StoreLocal {
            off, value, kind, ..
        } => {
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
            mem.check_data_access(src_addr as usize, *size as usize, AccessKind::Read)?;
            mem.check_data_access(dst_addr as usize, *size as usize, AccessKind::Write)?;
            mem.copy_within(dst_addr as usize, src_addr as usize, *size as usize)?;
            // Mcpy returns the destination address (c5 model).
            frame.regs[v as usize] = dst_addr;
            return Ok(());
        }
        Inst::AtomicRmw {
            op,
            addr,
            value,
            width,
        } => {
            // C11 7.17.7. The interpreter is single-threaded, so a
            // load-op-store reproduces the architectural effect; the
            // prior contents are the result (7.17.7p2).
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
            expected_addr,
            desired,
            width,
        } => {
            // C11 7.17.7.4. Single-threaded: load-compare-store. On a
            // mismatch the current contents are written back into
            // `*expected_addr` and the result is 0; on a match
            // `desired` is stored and the result is 1.
            let a = frame.regs[*addr as usize];
            let exp = frame.regs[*expected_addr as usize];
            let des = frame.regs[*desired as usize];
            atomic_addr_check(a, "AtomicCas")?;
            atomic_addr_check(exp, "AtomicCas")?;
            let (lk, sk) = atomic_kinds(*width);
            mem.check_data_access(a as usize, *width as usize, AccessKind::Read)?;
            mem.check_data_access(a as usize, *width as usize, AccessKind::Write)?;
            mem.check_data_access(exp as usize, *width as usize, AccessKind::Read)?;
            mem.check_data_access(exp as usize, *width as usize, AccessKind::Write)?;
            let cur = load_from_memory(mem, a as usize, lk)?;
            let ecur = load_from_memory(mem, exp as usize, lk)?;
            if cur == ecur {
                store_to_memory(mem, a as usize, narrow_store(des, sk), sk)?;
                frame.regs[v as usize] = 1;
            } else {
                store_to_memory(mem, exp as usize, narrow_store(cur, sk), sk)?;
                frame.regs[v as usize] = 0;
            }
            return Ok(());
        }
        Inst::LoadIndexed { .. } => "LoadIndexed",
        Inst::StoreIndexed { .. } => "StoreIndexed",
        Inst::Binop { op, lhs, rhs } => {
            let lv = frame.regs[*lhs as usize];
            let rv = frame.regs[*rhs as usize];
            let res = apply_binop(*op, lv, rv)?;
            frame.regs[v as usize] = round_if_f32(res, frame.func.f32_values.get(v as usize));
            return Ok(());
        }
        Inst::BinopI { op, lhs, rhs_imm } => {
            let lv = frame.regs[*lhs as usize];
            let res = apply_binop(*op, lv, *rhs_imm)?;
            frame.regs[v as usize] = round_if_f32(res, frame.func.f32_values.get(v as usize));
            return Ok(());
        }
        Inst::Fneg(src) => {
            let raw = frame.regs[*src as usize];
            let neg = eval::eval_fneg(raw);
            frame.regs[v as usize] = round_if_f32(neg, frame.func.f32_values.get(v as usize));
            return Ok(());
        }
        Inst::Fma {
            a,
            b,
            c,
            neg_product,
            neg_addend,
        } => {
            let is_f32 = matches!(frame.func.f32_values.get(v as usize), Some(true));
            let res = eval::eval_fma(
                frame.regs[*a as usize],
                frame.regs[*b as usize],
                frame.regs[*c as usize],
                *neg_product,
                *neg_addend,
                is_f32,
            );
            frame.regs[v as usize] = round_if_f32(res, frame.func.f32_values.get(v as usize));
            return Ok(());
        }
        Inst::Extend { value, kind } => {
            let raw = frame.regs[*value as usize];
            frame.regs[v as usize] = eval::eval_extend(raw, *kind);
            return Ok(());
        }
        Inst::FpCast { kind, value } => {
            let raw = frame.regs[*value as usize];
            let result_f32 = matches!(frame.func.f32_values.get(v as usize), Some(true));
            frame.regs[v as usize] = eval::eval_fpcast(*kind, raw, result_f32);
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
            let ret = run_func(prog, mem, host, callee, &arg_vals)?;
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
                let binding_idx = raw & !IMPORT_ADDR_TAG;
                let name = prog.binding_name(binding_idx)?;
                let mut arg_vals: Vec<i64> = Vec::with_capacity(args.len());
                for &a in args {
                    arg_vals.push(frame.regs[a as usize]);
                }
                let ret = dispatch_callext(name, &arg_vals, mem, host)?;
                frame.regs[v as usize] = ret;
                return Ok(());
            }
            // Code pointers may be tagged two ways: SSA-VM bit 62
            // (set by `Inst::ImmCode`) or the `CODE_BASE`-biased
            // form `with_host` writes when it patches the data
            // segment's `CodeReloc` entries so static initialisers
            // can carry function pointers without an SSA-aware
            // fix-up.
            let target_pc = if raw & CODE_ADDR_MASK != 0 {
                (raw & !CODE_ADDR_MASK) as usize
            } else if (raw as usize) >= super::super::CODE_BASE {
                (raw as usize) - super::super::CODE_BASE
            } else {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: CallIndirect: target raw=0x{raw:016x} is not a code pointer",
                )));
            };
            let callee = prog.lookup(target_pc).ok_or_else(|| {
                C5Error::Runtime(format!(
                    "vm_ssa: CallIndirect: no function at ent_pc {target_pc}",
                ))
            })?;
            let arg_vals = collect_call_args(frame, mem, args, arg_aggs, *fixed_args)?;
            let ret = run_func(prog, mem, host, callee, &arg_vals)?;
            frame.regs[v as usize] = finish_agg_return(frame, mem, *ret_agg, *ret_slot_local, ret)?;
            return Ok(());
        }
        Inst::CallExt {
            binding_idx, args, ..
        } => {
            let name = prog.binding_name(*binding_idx)?;
            let mut arg_vals: Vec<i64> = Vec::with_capacity(args.len());
            for &a in args {
                arg_vals.push(frame.regs[a as usize]);
            }
            let ret = dispatch_callext(name, &arg_vals, mem, host)?;
            frame.regs[v as usize] = ret;
            return Ok(());
        }
        Inst::TailExt(_) => "TailExt",
        Inst::Intrinsic { kind, args } => {
            run_intrinsic(mem, frame, v, *kind, args)?;
            return Ok(());
        }
        Inst::InlineAsm { asm, args } => {
            run_inline_asm(mem, frame, asm, args)?;
            return Ok(());
        }
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
        Inst::Phi { .. } => "Phi",
    };
    Err(C5Error::Runtime(format!("vm_ssa: {name} not implemented",)))
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
            let buf = alloc::vec![val; n];
            mem.write_bytes(dst as usize, &buf)?;
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
            let mut buf = alloc::vec![0u8; n];
            let read_bytes = host.read(fd, &mut buf);
            if read_bytes < 0 {
                return Ok(read_bytes);
            }
            let actual = (read_bytes as usize).min(n);
            mem.write_bytes(buf_addr as usize, &buf[..actual])?;
            Ok(read_bytes)
        }
        // `int close(int fd)` -- pure host bridge.
        "close" => {
            let fd = args.first().copied().unwrap_or(-1);
            Ok(host.close(fd))
        }
        // `void *malloc(size_t n)` -- bump-pointer heap.
        // Returns 0 on out-of-heap (C99 null pointer).
        "malloc" => {
            let n = libc_size(name, args.first().copied())?;
            Ok(mem.heap_alloc(n) as i64)
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
        // `int printf(const char *fmt, ...)` -- formats the
        // variadic tail in `args[1..]` per C99 7.19.6.1 and
        // writes the bytes to stdout via the host. Returns the
        // number of bytes transmitted (7.19.6.3p3).
        "printf" => {
            let fmt_addr = *args
                .first()
                .ok_or_else(|| C5Error::Runtime("vm_ssa: printf: missing fmt".to_string()))?;
            if fmt_addr < 0 {
                return Err(C5Error::Runtime(format!(
                    "vm_ssa: printf: bad fmt addr 0x{fmt_addr:x}",
                )));
            }
            let fmt = read_cstring_bytes(mem, fmt_addr as usize)?;
            let out = format_printf(&fmt, &args[1..], mem)?;
            let _ = host.write(1, &out);
            Ok(out.len() as i64)
        }
        // `int putchar(int c)` -- write one byte to stdout, returns
        // the byte (or EOF on error; we return the byte unconditionally).
        "putchar" => {
            let c = args.first().copied().unwrap_or(-1);
            let byte = c as u8;
            let _ = host.write(1, &[byte]);
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
        // C99 doesn't standardise setenv; this matches POSIX.
        // The `int overwrite` is normalised through the `Overwrite`
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
        _ => Err(C5Error::Runtime(format!(
            "vm_ssa: CallExt `{name}` not implemented (port from vm/intrinsics.rs)",
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
    Long,  // l / ll / j / z / t / L
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
    conv: u8,
}

/// printf formatter (C99 7.19.6.1). Parses the full spec grammar
/// -- flags, width (incl. `*`), precision (incl. `.*`), length
/// modifiers -- and pulls arguments from `args` as each
/// conversion requires. Returns the raw output bytes for the
/// caller to hand to `host.write`. An unrecognised conversion
/// emits its spec text verbatim without consuming an argument
/// (undefined per 7.19.6.1p9).
fn format_printf(fmt: &[u8], args: &[i64], mem: &mut Memory) -> Result<Vec<u8>, C5Error> {
    let mut out: Vec<u8> = Vec::new();
    let mut arg_idx = 0usize;
    let next_arg = |arg_idx: &mut usize| -> Result<i64, C5Error> {
        let val = args.get(*arg_idx).copied().ok_or_else(|| {
            C5Error::Runtime(format!(
                "vm_ssa: printf: format wants arg #{arg_idx} but only {} supplied",
                args.len(),
            ))
        })?;
        *arg_idx += 1;
        Ok(val)
    };
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
            let w = next_arg(&mut arg_idx)? as i32;
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
                let p = next_arg(&mut arg_idx)? as i32;
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
                s.len = ArgLen::Long;
                if fmt.get(i) == Some(&b'l') {
                    i += 1;
                }
            }
            Some(b'j') | Some(b'z') | Some(b't') | Some(b'L') => {
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
                let raw = next_arg(&mut arg_idx)?;
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
                let raw = next_arg(&mut arg_idx)?;
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
                let v = next_arg(&mut arg_idx)?;
                push_padded(&mut out, &s, &[v as u8]);
            }
            b's' => {
                let val = next_arg(&mut arg_idx)?;
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
                let v = next_arg(&mut arg_idx)? as u64;
                push_padded(&mut out, &s, format!("0x{v:x}").as_bytes());
            }
            b'f' | b'F' | b'e' | b'E' | b'g' | b'G' => {
                let v = f64::from_bits(next_arg(&mut arg_idx)? as u64);
                let body = format_float(v, &s);
                push_int(
                    &mut out,
                    &s,
                    if v.is_sign_negative() && !v.is_nan() {
                        "-"
                    } else if s.plus {
                        "+"
                    } else if s.space {
                        " "
                    } else {
                        ""
                    },
                    &body,
                    false,
                );
            }
            b'n' => {
                // Store the byte count written so far (7.19.6.1p8).
                let addr = next_arg(&mut arg_idx)?;
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
    if let Some(p) = s.precision
        && !matches!(s.conv, b'f' | b'F' | b'e' | b'E' | b'g' | b'G')
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
    let zero_pad = s.zero
        && !s.minus
        && (matches!(s.conv, b'f' | b'F' | b'e' | b'E' | b'g' | b'G') || s.precision.is_none());
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

/// Format `|v|` for the f / e / g conversion families
/// (7.19.6.1p8); the caller prepends the sign and applies the
/// field width. Uppercase conversions upper-case the result.
fn format_float(v: f64, s: &PrintfSpec) -> alloc::string::String {
    let upper = matches!(s.conv, b'F' | b'E' | b'G');
    if v.is_nan() {
        return if upper { "NAN".into() } else { "nan".into() };
    }
    if v.is_infinite() {
        return if upper { "INF".into() } else { "inf".into() };
    }
    let av = v.abs();
    let p = s.precision.unwrap_or(6);
    let body = match s.conv {
        b'f' | b'F' => {
            let mut b = format!("{av:.p$}");
            if s.alt && p == 0 {
                b.push('.');
            }
            b
        }
        b'e' | b'E' => format_exp(av, p, s.alt),
        _ => {
            // g/G: precision P counts significant digits (0 reads
            // as 1). Style e when the exponent X < -4 or X >= P,
            // else style f with precision P-1-X; trailing zeros
            // drop unless `#`.
            let pp = p.max(1);
            let exp = decimal_exponent(av, pp - 1);
            let mut b = if exp < -4 || exp >= pp as i32 {
                format_exp(av, pp - 1, s.alt)
            } else {
                format!("{:.*}", (pp as i32 - 1 - exp).max(0) as usize, av)
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

/// `d.dddde+/-dd` with `prec` fraction digits (7.19.6.1p8, the e
/// conversion). Rust's `{:e}` produces `d.ddddeN`; rewrite the
/// exponent into the sign + minimum-two-digit C form.
fn format_exp(av: f64, prec: usize, alt: bool) -> alloc::string::String {
    let raw = format!("{av:.prec$e}");
    let (mantissa, exp) = raw.split_once('e').unwrap_or((raw.as_str(), "0"));
    let exp: i32 = exp.parse().unwrap_or(0);
    let mut mantissa = alloc::string::String::from(mantissa);
    if alt && prec == 0 {
        mantissa.push('.');
    }
    format!(
        "{mantissa}e{}{:02}",
        if exp < 0 { '-' } else { '+' },
        exp.unsigned_abs(),
    )
}

/// Decimal exponent of `av` after rounding to `prec` fraction
/// digits in e-style -- the X in C99 7.19.6.1p8's g rules.
/// Deriving it from the rounded e form keeps the boundary cases
/// (9.99... rounding up a decade) consistent with the output.
fn decimal_exponent(av: f64, prec: usize) -> i32 {
    if av == 0.0 {
        return 0;
    }
    let raw = format!("{av:.prec$e}");
    raw.split_once('e')
        .and_then(|(_, e)| e.parse().ok())
        .unwrap_or(0)
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
/// Evaluate a GCC extended-asm statement (`Inst::InlineAsm`) in the
/// interpreter. The template is parsed into instructions and executed
/// against a 16-entry model register file seeded from the operand
/// values; the results are stored through the output addresses. This
/// reproduces the semantics the native encoding runs on hardware, so a
/// fixture round-trips identically on any host. Non-deterministic reads
/// (timestamp counter) yield zero, matching the native fallback in
/// value tests.
fn run_inline_asm(
    mem: &mut Memory,
    frame: &mut Frame<'_>,
    asm: &crate::c5::ir::AsmBlock,
    args: &[ValueId],
) -> Result<(), C5Error> {
    use crate::c5::codegen::x86_64::asm::{AsmOpnd, Mnemonic, parse_template};
    use crate::c5::ir::AsmRegSize;

    let insns = parse_template(&asm.template).map_err(C5Error::Runtime)?;
    let op_reg = crate::c5::codegen::x86_64::asm::assign_operand_regs(&asm.operands)
        .map_err(C5Error::Runtime)?;
    // Model register file; operand `%N` reads / writes its assigned slot.
    let mut xregs = [0i64; 16];
    // Seed input registers, and the current value of a `+` (read-write)
    // output loaded from its destination address.
    for (i, op) in asm.operands.iter().enumerate() {
        let Some(r) = op_reg[i] else { continue };
        if !op.is_output {
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
            AsmOpnd::Reg { reg, size } => (xregs[reg as usize], size),
            AsmOpnd::Ref { idx, size } => {
                let sz = size.unwrap_or(AsmRegSize::from_width(asm.operands[idx as usize].width));
                match op_reg[idx as usize] {
                    Some(r) => (xregs[r as usize], sz),
                    None => (frame.regs[args[idx as usize] as usize], sz),
                }
            }
        }
    };
    // The model register a destination operand writes into.
    let dst_reg = |o: &AsmOpnd| -> Option<usize> {
        match *o {
            AsmOpnd::Reg { reg, .. } => Some(reg as usize),
            AsmOpnd::Ref { idx, .. } => op_reg[idx as usize].map(|r| r as usize),
            AsmOpnd::Imm(_) => None,
        }
    };

    for insn in &insns {
        let ops = &insn.operands;
        match insn.mnemonic {
            Mnemonic::Nop | Mnemonic::Rdtsc | Mnemonic::Rdtscp => {
                // No host clock: the timestamp read produces zero in the
                // registers it defines (rax/rdx, and rcx for rdtscp).
                if !matches!(insn.mnemonic, Mnemonic::Nop) {
                    xregs[0] = 0;
                    xregs[2] = 0;
                    xregs[1] = 0;
                }
            }
            Mnemonic::Bswap => {
                let (val, size) = value_of(&ops[0], &xregs);
                let w = insn.suffix.unwrap_or(size);
                let sw = byte_swap(val, w);
                if let Some(r) = dst_reg(&ops[0]) {
                    xregs[r] = sw;
                }
            }
            Mnemonic::Shld | Mnemonic::Shrd => {
                let (count, _) = value_of(&ops[0], &xregs);
                let (src, _) = value_of(&ops[1], &xregs);
                let (dst, dsz) = value_of(&ops[2], &xregs);
                let w = insn.suffix.unwrap_or(dsz);
                let res = double_shift(insn.mnemonic == Mnemonic::Shld, dst, src, count, w);
                if let Some(r) = dst_reg(&ops[2]) {
                    xregs[r] = res;
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
                    xregs[r] = mask_width(res, w);
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
                    xregs[r] = mask_width(res, w);
                }
            }
        }
    }

    // Store the outputs back through their destination addresses.
    for (i, op) in asm.operands.iter().enumerate() {
        if op.is_output
            && let Some(r) = op_reg[i]
        {
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

/// Byte-reverse the low `w` bytes of `v` (BSWAP).
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
            let last_addr = frame.regs[args[1] as usize];
            store_to_memory(mem, ap_addr, last_addr + 8, StoreKind::I64)
        }
        Intrinsic::VaArg => {
            // `__builtin_va_arg(self, descriptor)` returns the cursor's
            // current value (the address of the next variadic slot) and
            // advances `*self` by the argument's eightbyte span. A
            // scalar occupies one eightbyte; a by-value aggregate spans
            // `ceil(size/8)`, matching how the caller laid it down in the
            // flat single-region va_list. `args[1]` is the packed
            // `(kind << 16) | size` type descriptor.
            let descriptor = args.get(1).map(|&a| frame.regs[a as usize]).unwrap_or(0);
            let size = descriptor & 0xffff;
            let stride = ((size + 7) & !7).max(8);
            let ap_addr = frame.regs[args[0] as usize] as usize;
            let cursor = load_from_memory(mem, ap_addr, LoadKind::I64)?;
            store_to_memory(mem, ap_addr, cursor + stride, StoreKind::I64)?;
            frame.regs[v as usize] = cursor;
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
        Intrinsic::Sqrt | Intrinsic::Sqrtf => {
            let x = f64::from_bits(frame.regs[args[0] as usize] as u64);
            let r = if matches!(intr, Intrinsic::Sqrtf) {
                libm::sqrtf(x as f32) as f64
            } else {
                libm::sqrt(x)
            };
            frame.regs[v as usize] =
                round_if_f32(r.to_bits() as i64, frame.func.f32_values.get(v as usize));
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
        // A memory barrier has no effect in the single-threaded
        // interpreter; no operand, no result.
        Intrinsic::AtomicThreadFence => Ok(()),
        Intrinsic::X87StoreControlWord => {
            // The interpreter evaluates floats with host doubles, so it
            // has no x87 control word to read; store the architectural
            // default so a caller that round-trips it sees a sane value.
            let addr = frame.regs[args[0] as usize] as usize;
            store_to_memory(mem, addr, 0x037f, StoreKind::I16)
        }
        Intrinsic::X87LoadControlWord => {
            // Setting the control word has no effect on host-double
            // arithmetic.
            Ok(())
        }
        Intrinsic::Cpuid => {
            // No host CPUID; zero the four output words so a caller reads a
            // defined (feature-absent) result rather than uninitialized data.
            for &a in &args[0..4] {
                let addr = frame.regs[a as usize] as usize;
                store_to_memory(mem, addr, 0, StoreKind::I32)?;
            }
            Ok(())
        }
        Intrinsic::Xgetbv => {
            for &a in &args[0..2] {
                let addr = frame.regs[a as usize] as usize;
                store_to_memory(mem, addr, 0, StoreKind::I32)?;
            }
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
        Intrinsic::Rdtsc => {
            // No host clock; zero the low/high output words so a caller
            // reads a defined result rather than uninitialized data.
            for &a in &args[0..2] {
                let addr = frame.regs[a as usize] as usize;
                store_to_memory(mem, addr, 0, StoreKind::I32)?;
            }
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
            // frame's base in the byte arena. It is non-zero, stable
            // within a frame, and distinct across nested calls -- enough
            // for a stack-depth comparison. (The arena grows up, so a
            // deeper frame has a larger address than on a native stack.)
            frame.regs[v as usize] = frame.stack_base as i64;
            Ok(())
        }
        Intrinsic::ReturnAddress => {
            // No native return address in the interpreter; return a stable
            // non-zero per-frame proxy, enough for callers that only store
            // or compare it.
            frame.regs[v as usize] = frame.stack_base as i64;
            Ok(())
        }
        // The integer bit-count builtins are lowered to a portable
        // shift / mask sequence in the walker; they never reach the VM
        // as an `Inst::Intrinsic`.
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
        // The C11 atomic operations are lowered to load / store /
        // read-modify-write at the call site; they never reach the VM
        // as an `Inst::Intrinsic`.
        Intrinsic::AtomicLoad
        | Intrinsic::AtomicStore
        | Intrinsic::AtomicExchange
        | Intrinsic::AtomicFetchAdd
        | Intrinsic::AtomicFetchSub
        | Intrinsic::AtomicFetchAnd
        | Intrinsic::AtomicFetchOr
        | Intrinsic::AtomicFetchXor
        | Intrinsic::AtomicCompareExchangeStrong => Err(C5Error::Runtime(
            "vm_ssa: atomic op reached the intrinsic dispatch".to_string(),
        )),
    }
}

/// Read a typed value out of byte-addressed memory at `addr`.
/// Sign / zero extension follows C99 6.3.1.3 per the LoadKind's
/// signedness. Bounds errors trip a runtime error so a stray
/// pointer doesn't read uninitialised state.
fn load_width(kind: LoadKind) -> usize {
    match kind {
        LoadKind::I64 | LoadKind::F64 => 8,
        LoadKind::I32 | LoadKind::U32 | LoadKind::F32 => 4,
        LoadKind::I16 | LoadKind::U16 => 2,
        LoadKind::I8 | LoadKind::U8 => 1,
    }
}

fn store_width(kind: StoreKind) -> usize {
    match kind {
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
            let bits = u32::from_le_bytes(slice.try_into().unwrap());
            (f32::from_bits(bits) as f64).to_bits() as i64
        }
        // `double` is already 8 bytes; the c5 accumulator carries
        // f64 bit patterns, so the load returns the raw 64-bit value.
        LoadKind::F64 => i64::from_le_bytes(slice.try_into().unwrap()),
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
        // C99 6.3.1.5: a `double` stored through an lvalue of
        // type `float` is narrowed to single precision. The c5
        // accumulator carries f64 bit patterns, so the store
        // collapses to f32 before writing the 4 bytes.
        StoreKind::F32 => {
            let f = f64::from_bits(value as u64) as f32;
            mem.write_bytes(addr, &f.to_le_bytes())
        }
        // `double` is 8 bytes; write the raw f64 bit pattern.
        StoreKind::F64 => mem.write_bytes(addr, &value.to_le_bytes()),
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
        StoreKind::F32 | StoreKind::F64 => value,
    }
}

/// Binop dispatch, shared with the compile-time constant folder
/// (`super::eval`); a division trap re-wraps as the VM's runtime
/// error.
fn apply_binop(op: BinOp, lhs: i64, rhs: i64) -> Result<i64, C5Error> {
    eval::apply_binop(op, lhs, rhs).map_err(|t| C5Error::Runtime(t.message().to_string()))
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
        let mut mem = Memory::new(b"\xC3\xA9\x00");
        let out = format_printf(b"%s", &[0], &mut mem).expect("format");
        assert_eq!(out, alloc::vec![0xC3u8, 0xA9]);
    }

    #[test]
    fn printf_char_preserves_high_byte() {
        let mut mem = Memory::new(b"\x00");
        let out = format_printf(b"%c", &[0x80], &mut mem).expect("format");
        assert_eq!(out, alloc::vec![0x80u8]);
    }

    fn fmt1(fmt: &[u8], args: &[i64]) -> alloc::string::String {
        let mut mem = Memory::new(b"abcdef\x00");
        let out = format_printf(fmt, args, &mut mem).expect("format");
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
    }

    #[test]
    fn printf_percent_n_stores_count() {
        // C99 7.19.6.1p8: %n stores the bytes written so far.
        let mut mem = Memory::new(&[0u8; 16]);
        let out = format_printf(b"abc%nd", &[8], &mut mem).expect("format");
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
        let mut mem = Memory::new(&[]);
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
        )
        .expect("ssa lift");
        let mut host = super::super::super::host::StdHost::default();
        let err = run_program(&funcs, &program.data, &[], program.entry_pc, &mut host)
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
        // `strlen` isn't in the SSA-VM dispatch yet; the
        // unimplemented arm surfaces a runtime error pointing
        // at the next port target. Programs that don't touch
        // libc keep running.
        use crate::Compiler;
        let program = Compiler::new(
            "#include <string.h>\nint main(void) { return strlen(\"hi\"); }".to_string(),
        )
        .compile()
        .expect("compile fixture");
        let funcs = super::super::super::codegen::ssa::shadow::produce_ssa_funcs(
            &program,
            super::super::super::Target::MacOSAarch64,
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
        )
        .expect_err("strlen should land in the unimplemented arm");
        match err {
            crate::C5Error::Runtime(msg) => {
                assert!(
                    msg.contains("CallExt `strlen` not implemented")
                        || msg.contains("CallExt `_strlen` not implemented"),
                    "expected strlen in the error, got: {msg}",
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
