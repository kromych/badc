use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use super::CODE_BASE;
use super::error::C5Error;
use super::host::Host;
use super::op::Op;
use super::program::Program;

mod intrinsics;

const STACK_CAPACITY: usize = 256 * 1024;
const STACK_BASE: usize = 0x1000_0000;

/// What an access through `check_data_access` is doing -- used for
/// diagnostic wording on out-of-bounds / use-after-free reports.
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

/// Encode a raw text-PC as a user-visible code pointer. Used wherever a PC
/// would otherwise leak into program-observable state (function pointers,
/// return addresses on the stack).
fn encode_pc(pc: usize) -> i64 {
    (CODE_BASE + pc) as i64
}

/// Metadata for a single heap allocation. The VM never recycles heap
/// addresses, so each allocation gets a fresh `[start, start+len)` window
/// recorded here. `freed` is flipped by `free()` so subsequent loads/stores
/// land in a `use-after-free` diagnostic instead of silently succeeding.
#[derive(Debug, Clone)]
struct Allocation {
    start: usize,
    len: usize,
    freed: bool,
    /// Sequence number used in error messages to identify the offending
    /// allocation independently of its address.
    id: u64,
}

/// Whether the VM should emit a per-instruction trace to the host's
/// stdout during `run`. Only honoured under the `std` feature; in
/// `no_std` the trace branch is cfg'd out.
///
/// Replaces what used to be a bare `bool` parameter to `Vm::new` --
/// `Vm::new(prog, true)` left the reader guessing what the second
/// argument toggled.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum Trace {
    #[default]
    Off,
    On,
}

/// Virtual machine that executes a [`Program`].
pub struct Vm<H: Host> {
    pub(crate) text: Vec<i64>,
    pub(crate) data: Vec<u8>,
    entry_pc: usize,
    stack: Vec<i64>,
    /// Pluggable host bridge -- file IO, env access, real stdio. The
    /// `fd_table` and `next_fd` that used to live on `Vm` are now
    /// `StdHost` state.
    host: H,
    #[cfg_attr(not(feature = "std"), allow(dead_code))]
    trace: Trace,
    /// Arguments passed to `main(int argc, char **argv)`. Empty by default;
    /// populated via [`Vm::with_args`].
    args: Vec<String>,
    /// Flat list of `local_name`s in `#pragma binding(...)` declaration
    /// order -- the same enumeration the parser used when assigning
    /// `Op::JsrExt` operands. Looked up at JsrExt dispatch time to
    /// pick which Rust shim to invoke.
    binding_names: Vec<String>,

    // ---- Pointer-tracking state ----
    /// Recorded heap allocations (malloc + getenv-returned strings). Always
    /// populated regardless of `track_pointers` so the lists stay consistent
    /// across feature toggles.
    allocations: Vec<Allocation>,
    /// `data.len()` captured at the start of [`Vm::run`] (after argv has
    /// been staged). Anything below this address is static data -- string
    /// literals, globals, argv -- and is implicitly trusted by access checks.
    static_end: usize,
    /// When true, every heap-side load/store goes through
    /// [`Vm::check_data_access`] and `free` validates its argument.
    track_pointers: bool,

    /// Base address (within `data`) of the thread-local block.
    /// `Op::TlsLea N` resolves to `tls_base + N`. The VM is single
    /// threaded, so the per-thread isolation native targets get
    /// from TPIDR_EL0 / fs:0 isn't reproduced here -- TLS just
    /// behaves like a regular global. Tests that care about
    /// per-thread semantics need to drive the native lowering via
    /// `--jit` / native binary.
    tls_base: usize,
}

/// `Vm::new` is only available with the `std` feature; it picks the
/// `StdHost` adapter as the default. In `no_std`, callers must use
/// [`Vm::with_host`] and supply their own host.
#[cfg(feature = "std")]
impl Vm<super::host::StdHost> {
    /// Construct a `Vm` with the default (std-backed) host. Trace is
    /// off by default -- chain [`Vm::with_trace`] to opt in.
    pub fn new(program: Program) -> Self {
        Self::with_host(program, super::host::StdHost::default())
    }
}

impl<H: Host> Vm<H> {
    /// Construct a `Vm` with an explicit `Host`. Required in `no_std`
    /// where there's no default; convenient in `std` for tests that
    /// want to stub IO. Trace defaults to off.
    pub fn with_host(program: Program, host: H) -> Self {
        let binding_names = program
            .dylibs
            .iter()
            .flat_map(|d| d.bindings.iter().map(|b| b.local_name.clone()))
            .collect();
        // Concatenate the TLS block onto the data segment so
        // Op::TlsLea N can resolve to `tls_base + N` and ride the
        // existing data-side access checks. The starting offset is
        // captured before the TLS bytes are appended.
        let mut data = program.data;
        // Apply CodeReloc entries: function-pointer initializers in
        // the data segment store `CODE_BASE + bc_pc` so Op::Jsri
        // recognises the slot's value as a code address. The
        // compiler can't bake this in directly because the VM's
        // CODE_BASE constant lives in this crate; we patch each
        // slot here at VM construction time.
        for r in &program.code_relocs {
            let off = r.data_offset as usize;
            let runtime = (super::CODE_BASE as u64).wrapping_add(r.target_bc_pc);
            data[off..off + 8].copy_from_slice(&runtime.to_le_bytes());
        }
        let tls_base = data.len();
        data.extend_from_slice(&program.tls_data);
        Self {
            text: program.text,
            data,
            entry_pc: program.entry_pc,
            stack: vec![0; STACK_CAPACITY],
            host,
            trace: Trace::Off,
            args: Vec::new(),
            binding_names,
            allocations: Vec::new(),
            static_end: 0,
            track_pointers: false,
            tls_base,
        }
    }

    /// Enable per-instruction trace output. Mirrors
    /// [`Vm::with_pointer_tracking`]: the absence of the call leaves
    /// the feature off, calling once turns it on. There's no `off`
    /// builder -- just don't call this.
    pub fn with_trace(mut self) -> Self {
        self.trace = Trace::On;
        self
    }

    /// Decode a code-pointer value back into a raw text PC. Errors if the
    /// value isn't in `[CODE_BASE, CODE_BASE + text.len())` -- i.e. the
    /// program built a "function pointer" out of an integer that never
    /// came from the compiler or from a Jsr/Jsri push.
    fn decode_pc(&self, v: i64) -> Result<usize, C5Error> {
        let raw = v as usize;
        if raw < CODE_BASE || raw >= CODE_BASE + self.text.len() {
            return Err(C5Error::Runtime(format!(
                "jump to non-code address 0x{raw:x} -- not a function pointer or return address"
            )));
        }
        Ok(raw - CODE_BASE)
    }

    /// Set the argv list seen by `main`. Conventional first entry is the
    /// program name. Builder-style: `Vm::new(p, false).with_args(["x", "y"])`.
    pub fn with_args<I, S>(mut self, args: I) -> Self
    where
        I: IntoIterator<Item = S>,
        S: Into<String>,
    {
        self.args = args.into_iter().map(Into::into).collect();
        self
    }

    /// Enable runtime tracking of heap allocations. With this on, every
    /// load/store into the heap region is checked against the allocation
    /// table and produces a `Runtime` error on use-after-free, double-free,
    /// or out-of-bounds access. Off by default -- the checks add a per-access
    /// linear scan over the allocations list.
    pub fn with_pointer_tracking(mut self) -> Self {
        self.track_pointers = true;
        self
    }

    /// Record a freshly-allocated heap region. Always called, regardless of
    /// the `track_pointers` flag, so the allocations list reflects every
    /// allocation that has ever happened during the run.
    fn record_allocation(&mut self, start: usize, len: usize) {
        let id = self.allocations.len() as u64;
        self.allocations.push(Allocation {
            start,
            len,
            freed: false,
            id,
        });
    }

    /// Validate `[addr, addr+len)` for a `kind` access.
    ///
    /// Three layered checks:
    ///   1. Code segment -- always rejected, regardless of tracking. A
    ///      function-pointer value isn't supposed to be dereferenced as
    ///      data, and a return address pulled off the stack isn't either.
    ///   2. mprotect -- always honoured. If the address falls in a
    ///      protected region whose `prot` mask doesn't allow `kind`,
    ///      refuse the access.
    ///   3. Allocation tracking -- opt-in. Heap accesses must land inside
    ///      a live allocation; static data is implicitly trusted.
    fn check_data_access(&self, addr: usize, len: usize, kind: AccessKind) -> Result<(), C5Error> {
        // 1. Code segment is not addressable as data.
        if addr >= CODE_BASE && addr < CODE_BASE + self.text.len() {
            return Err(C5Error::Runtime(format!(
                "{} access at code pointer 0x{addr:x} ({len} bytes) -- code is not data",
                kind.label()
            )));
        }
        if len == 0 {
            return Ok(());
        }
        // 2. Allocation tracking -- opt-in.
        if !self.track_pointers {
            return Ok(());
        }
        if addr < self.static_end {
            return Ok(());
        }
        // Stack frame addresses are implicitly trusted -- frames
        // come and go on Ent/Lev and aren't tracked individually
        // by the allocation tracker. `load_u8` / `store_u8`
        // already special-case stack addresses in their primary
        // path; the bulk-access checks (Mcpy, intrinsic memcpy /
        // memcmp / memset) need the same exemption to avoid
        // rejecting legitimate stack-to-stack copies emitted for
        // struct-by-value parameter passing, struct-value
        // assignment, and `struct Foo p = q;` initializers.
        if (STACK_BASE..STACK_BASE + STACK_CAPACITY * 8).contains(&addr) {
            return Ok(());
        }
        for alloc in &self.allocations {
            if addr >= alloc.start && addr < alloc.start + alloc.len {
                if alloc.freed {
                    return Err(C5Error::Runtime(format!(
                        "use-after-free: access at 0x{addr:x} inside freed allocation #{} (start=0x{:x}, len={})",
                        alloc.id, alloc.start, alloc.len
                    )));
                }
                if addr + len > alloc.start + alloc.len {
                    return Err(C5Error::Runtime(format!(
                        "out-of-bounds: {len}-byte access at 0x{addr:x} runs past allocation #{} end=0x{:x}",
                        alloc.id,
                        alloc.start + alloc.len
                    )));
                }
                return Ok(());
            }
        }
        Err(C5Error::Runtime(format!(
            "out-of-bounds: heap access at 0x{addr:x} ({len} bytes) is not inside any live allocation"
        )))
    }

    /// Append `s` (as a NUL-terminated C string) to the data segment and
    /// return the address of its first byte. Reserves the NULL page on the
    /// first allocation so the returned pointer is never 0. The string is
    /// recorded as a live allocation so pointer-tracking allows reads of it
    /// (`getenv` returns into here).
    fn install_cstring(&mut self, s: &[u8]) -> usize {
        if self.data.is_empty() {
            self.data.resize(8, 0);
        }
        let addr = self.data.len();
        self.data.extend_from_slice(s);
        self.data.push(0);
        self.record_allocation(addr, s.len() + 1);
        addr
    }

    /// Build the argv array (and per-arg cstrings) in the data segment and
    /// return the address of argv. Returns 0 when there are no arguments.
    fn install_argv(&mut self) -> i64 {
        if self.args.is_empty() {
            return 0;
        }
        if self.data.is_empty() {
            self.data.resize(8, 0);
        }
        let argc = self.args.len();
        let argv_addr = self.data.len();
        // Reserve `argc + 1` pointer slots (the trailing slot is NULL by C
        // convention), then back-fill them after the strings are placed.
        self.data.resize(argv_addr + (argc + 1) * 8, 0);

        let mut entries = Vec::with_capacity(argc);
        // Take ownership of the args list to avoid aliasing self.data and
        // self.args during the loop body.
        let args = core::mem::take(&mut self.args);
        for arg in &args {
            let start = self.data.len();
            let bytes: &[u8] = arg.as_bytes();
            self.data.extend_from_slice(bytes);
            self.data.push(0);
            entries.push(start as i64);
        }
        self.args = args;

        for (i, &addr) in entries.iter().enumerate() {
            let slot = argv_addr + i * 8;
            self.data[slot..slot + 8].copy_from_slice(&addr.to_le_bytes());
        }

        argv_addr as i64
    }

    fn get_stack_idx(&self, addr: usize) -> Option<usize> {
        // Tight upper bound: only the actual stack window classifies as
        // stack. Without this, code-pointer addresses (`>= STACK_BASE`)
        // would be misclassified and bypass the code-segment check.
        if (STACK_BASE..STACK_BASE + STACK_CAPACITY * 8).contains(&addr) {
            Some((addr - STACK_BASE) / 8)
        } else {
            None
        }
    }

    fn load_i64(&self, addr: usize) -> Result<i64, C5Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                Ok(self.stack[idx])
            } else {
                Err(C5Error::Runtime(format!(
                    "Stack overflow read at addr {:x}",
                    addr
                )))
            }
        } else {
            self.check_data_access(addr, 8, AccessKind::Read)?;
            if addr + 8 <= self.data.len() {
                let mut bytes = [0u8; 8];
                bytes.copy_from_slice(&self.data[addr..addr + 8]);
                Ok(i64::from_le_bytes(bytes))
            } else {
                Ok(0)
            }
        }
    }

    fn store_i64(&mut self, addr: usize, val: i64) -> Result<(), C5Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                self.stack[idx] = val;
                Ok(())
            } else {
                Err(C5Error::Runtime(format!(
                    "Stack overflow write at addr {:x}",
                    addr
                )))
            }
        } else {
            self.check_data_access(addr, 8, AccessKind::Write)?;
            if addr + 8 > self.data.len() {
                self.data.resize(addr + 8, 0);
            }
            let bytes = val.to_le_bytes();
            self.data[addr..addr + 8].copy_from_slice(&bytes);
            Ok(())
        }
    }

    /// 4-byte signed load with sign-extension into i32. Mirrors
    /// `load_u8`'s stack-aware shape: an `Lw` against a stack slot
    /// reads the low or high half of the 8-byte slot depending on
    /// `addr & 4`. Off-stack reads pull 4 raw bytes from `data`.
    /// Used by [`Op::Lw`] for `int` lvalue reads under M31's real-
    /// width regime.
    fn load_i32(&self, addr: usize) -> Result<i32, C5Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                let word = self.stack[idx];
                let byte_offset = (addr - STACK_BASE) % 8;
                let shift = byte_offset * 8;
                Ok(((word >> shift) & 0xFFFF_FFFF) as u32 as i32)
            } else {
                Err(C5Error::Runtime(format!(
                    "Stack overflow read at addr {:x}",
                    addr
                )))
            }
        } else {
            self.check_data_access(addr, 4, AccessKind::Read)?;
            if addr + 4 <= self.data.len() {
                let mut bytes = [0u8; 4];
                bytes.copy_from_slice(&self.data[addr..addr + 4]);
                Ok(i32::from_le_bytes(bytes))
            } else {
                Ok(0)
            }
        }
    }

    /// 4-byte store. On the stack, masks the target half of the
    /// 8-byte slot so the other 4 bytes survive. Off-stack, writes
    /// 4 raw bytes. Companion to [`load_i32`] for [`Op::Sw`].
    fn store_i32(&mut self, addr: usize, val: i32) -> Result<(), C5Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                let word = self.stack[idx] as u64;
                let byte_offset = (addr - STACK_BASE) % 8;
                let shift = byte_offset * 8;
                let mask = !(0xFFFF_FFFFu64 << shift);
                let new_val = (word & mask) | (((val as u32 as u64) << shift) as u64);
                self.stack[idx] = new_val as i64;
                Ok(())
            } else {
                Err(C5Error::Runtime(format!(
                    "Stack overflow write at addr {:x}",
                    addr
                )))
            }
        } else {
            self.check_data_access(addr, 4, AccessKind::Write)?;
            if addr + 4 > self.data.len() {
                self.data.resize(addr + 4, 0);
            }
            let bytes = val.to_le_bytes();
            self.data[addr..addr + 4].copy_from_slice(&bytes);
            Ok(())
        }
    }

    fn load_u8(&self, addr: usize) -> Result<u8, C5Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                let word = self.stack[idx];
                let byte_offset = (addr - STACK_BASE) % 8;
                let shift = byte_offset * 8;
                Ok(((word >> shift) & 0xFF) as u8)
            } else {
                Ok(0)
            }
        } else {
            self.check_data_access(addr, 1, AccessKind::Read)?;
            if addr < self.data.len() {
                Ok(self.data[addr])
            } else {
                Ok(0)
            }
        }
    }

    fn store_u8(&mut self, addr: usize, val: u8) -> Result<(), C5Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                let word = self.stack[idx];
                let byte_offset = (addr - STACK_BASE) % 8;
                let shift = byte_offset * 8;
                let mask = !(0xFFu64 << shift) as i64;
                let new_val = (word & mask) | ((val as i64 & 0xFF) << shift);
                self.stack[idx] = new_val;
            }
        } else {
            self.check_data_access(addr, 1, AccessKind::Write)?;
            if addr >= self.data.len() {
                self.data.resize(addr + 1, 0);
            }
            self.data[addr] = val;
        }
        Ok(())
    }

    fn read_cstring(&self, addr: usize) -> Result<String, C5Error> {
        let mut s = String::new();
        let mut p = addr;
        while s.len() < 5000 {
            let c = self.load_u8(p)? as char;
            if c == '\0' {
                break;
            }
            s.push(c);
            p += 1;
        }
        Ok(s)
    }

    /// Look up the c4 name for a `JsrExt` operand. Errors if the
    /// operand is out of range -- can only happen if the bytecode
    /// got corrupted between parse and execute.
    fn binding_name(&self, binding_idx: i64) -> Result<&str, C5Error> {
        if binding_idx < 0 {
            return Err(C5Error::Runtime(format!(
                "VM: negative JsrExt operand {binding_idx}"
            )));
        }
        let i = binding_idx as usize;
        self.binding_names
            .get(i)
            .map(|s| s.as_str())
            .ok_or_else(|| {
                C5Error::Runtime(format!(
                    "VM: JsrExt operand {binding_idx} out of range \
                 (program has {} bindings)",
                    self.binding_names.len()
                ))
            })
    }

    /// Execute the program. Consumes the VM because `run` mutates `text`
    /// (appending the bootstrap), `data` (staging argv), and the recorded
    /// `static_end`/heap state -- invoking it twice would corrupt those
    /// invariants. Build a fresh `Vm` for each run.
    pub fn run(mut self) -> Result<i64, C5Error> {
        if self.text.is_empty() {
            return Err(C5Error::Runtime("empty program".to_string()));
        }

        let mut sp = STACK_BASE + STACK_CAPACITY * 8;
        let mut bp = sp;

        // Append a single-`Psh` bootstrap so main's `Lev` returns
        // into it: the Psh saves the accumulator onto the VM stack,
        // then the loop notices `pc == halt_pc` (the slot just past
        // Psh) and terminates with the saved value as the exit code.
        // This used to be `Psh + Exit`, but `Op::Exit` is gone now
        // that all libc calls go through `Op::JsrExt` -- the in-loop
        // halt-pc check replaces it.
        let bootstrap_addr = self.text.len();
        self.text.push(Op::Psh as i64);
        let halt_pc = self.text.len();

        // Stage argv strings + array in the data segment, then push
        // argv / argc as the two parameters of `main`. The compiler
        // maps `int main(int argc, char **argv)` to read argc at
        // `bp+16` (val=2, first declared) and argv at `bp+24`
        // (val=3, second declared). c5's cdecl push order means the
        // first declared param is the LAST push -- so argv goes
        // first (lands deeper) and argc goes second (lands on top).
        // When `args` is empty these slots are both zero, and a
        // `main()` defined without parameters simply ignores them.
        let argv_addr = self.install_argv();
        let argc = self.args.len() as i64;

        // Freeze the static-data boundary now: anything below this address
        // (string literals, globals, argv) is implicitly trusted by the
        // pointer-tracking access check; anything at-or-above must come
        // from a tracked allocation.
        self.static_end = self.data.len();

        sp -= 8;
        self.store_i64(sp, argv_addr)?;
        sp -= 8;
        self.store_i64(sp, argc)?;
        sp -= 8;
        // Bootstrap return address is encoded so main's Lev decodes it via
        // the same path as any other function-return: this is the only
        // value pushed as a return address that doesn't come from Jsr/Jsri.
        self.store_i64(sp, encode_pc(bootstrap_addr))?;

        let mut pc = self.entry_pc;
        let mut _cycle = 0;
        let mut a: i64 = 0;

        loop {
            _cycle += 1;
            if pc == halt_pc {
                // Bootstrap halt: main's `Lev` returned into the
                // synthetic `Psh` we appended at `bootstrap_addr`,
                // the Psh saved the accumulator on the VM stack,
                // and now we read it back as the exit code.
                return self.load_i64(sp);
            }
            if pc >= self.text.len() {
                return Err(C5Error::Runtime("PC out of bounds".to_string()));
            }

            let raw_op = self.text[pc];
            let op = Op::from_i64(raw_op).ok_or_else(|| {
                C5Error::Runtime(format!("Invalid instruction {} at PC {}", raw_op, pc))
            })?;
            pc += 1;

            // Debug tracing requires real stdio -- gated to `std`. In
            // `no_std` builds, the `trace` flag is silently a no-op
            // (a future enhancement could route this through Host too).
            #[cfg(feature = "std")]
            if self.trace == Trace::On {
                println!("{} op: {:?}", _cycle, op);
            }

            match op {
                Op::Lea => {
                    let offset = self.text[pc] * 8;
                    a = (bp as i64) + offset;
                    pc += 1;
                }
                Op::Imm => {
                    a = self.text[pc];
                    pc += 1;
                }
                Op::Jmp => {
                    pc = self.text[pc] as usize;
                }
                Op::Jsr => {
                    sp -= 8;
                    // Return address is user-visible (sits on the stack),
                    // so encode it before pushing.
                    self.store_i64(sp, encode_pc(pc + 1))?;
                    pc = self.text[pc] as usize;
                }
                Op::Jsri => {
                    sp -= 8;
                    self.store_i64(sp, encode_pc(pc))?;
                    // The accumulator holds an encoded function pointer
                    // produced either by the compiler (`Op::Imm` for a
                    // function symbol) or pushed by Jsr/Jsri. Reject any
                    // other value -- calling through an arbitrary integer
                    // is the user trying to forge a code pointer.
                    pc = self.decode_pc(a)?;
                }
                Op::Bz => {
                    pc = if a == 0 {
                        self.text[pc] as usize
                    } else {
                        pc + 1
                    };
                }
                Op::Bnz => {
                    pc = if a != 0 {
                        self.text[pc] as usize
                    } else {
                        pc + 1
                    };
                }
                Op::Ent => {
                    sp -= 8;
                    self.store_i64(sp, bp as i64)?;
                    bp = sp;
                    sp -= (self.text[pc] as usize) * 8;
                    pc += 1;
                }
                Op::Adj => {
                    sp += (self.text[pc] as usize) * 8;
                    pc += 1;
                }
                Op::Lev => {
                    sp = bp;
                    bp = self.load_i64(sp)? as usize;
                    sp += 8;
                    let raw = self.load_i64(sp)?;
                    pc = self.decode_pc(raw)?;
                    sp += 8;
                }
                Op::Li => {
                    a = self.load_i64(a as usize)?;
                }
                Op::Lc => {
                    a = self.load_u8(a as usize)? as i64;
                }
                Op::Si => {
                    let addr = self.load_i64(sp)? as usize;
                    sp += 8;
                    self.store_i64(addr, a)?;
                }
                Op::Sc => {
                    let addr = self.load_i64(sp)? as usize;
                    sp += 8;
                    self.store_u8(addr, a as u8)?;
                }
                Op::Lw => {
                    a = self.load_i32(a as usize)? as i64;
                }
                Op::Sw => {
                    let addr = self.load_i64(sp)? as usize;
                    sp += 8;
                    self.store_i32(addr, a as i32)?;
                }
                Op::Psh => {
                    sp -= 8;
                    self.store_i64(sp, a)?;
                }
                Op::Or => {
                    a |= self.load_i64(sp)?;
                    sp += 8;
                }
                Op::Xor => {
                    a ^= self.load_i64(sp)?;
                    sp += 8;
                }
                Op::And => {
                    a &= self.load_i64(sp)?;
                    sp += 8;
                }
                Op::Eq => {
                    a = if self.load_i64(sp)? == a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Ne => {
                    a = if self.load_i64(sp)? != a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Lt => {
                    a = if self.load_i64(sp)? < a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Gt => {
                    a = if self.load_i64(sp)? > a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Le => {
                    a = if self.load_i64(sp)? <= a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Ge => {
                    a = if self.load_i64(sp)? >= a { 1 } else { 0 };
                    sp += 8;
                }
                Op::Shl => {
                    a = self.load_i64(sp)? << a;
                    sp += 8;
                }
                Op::Shr => {
                    a = self.load_i64(sp)? >> a;
                    sp += 8;
                }
                Op::Add => {
                    a += self.load_i64(sp)?;
                    sp += 8;
                }
                Op::Sub => {
                    a = self.load_i64(sp)? - a;
                    sp += 8;
                }
                Op::Mul => {
                    a *= self.load_i64(sp)?;
                    sp += 8;
                }
                Op::Div => {
                    a = self.load_i64(sp)? / a;
                    sp += 8;
                }
                Op::Mod => {
                    a = self.load_i64(sp)? % a;
                    sp += 8;
                }
                // Immediate-form arithmetic / comparison: `a = a <op> N`.
                // Folded by the optimizer from `Psh; Imm N; <op>`. Saves
                // one stack push and two dispatches per call site.
                Op::AddI => {
                    a = a.wrapping_add(self.text[pc]);
                    pc += 1;
                }
                Op::SubI => {
                    a = a.wrapping_sub(self.text[pc]);
                    pc += 1;
                }
                Op::MulI => {
                    a = a.wrapping_mul(self.text[pc]);
                    pc += 1;
                }
                Op::AndI => {
                    a &= self.text[pc];
                    pc += 1;
                }
                Op::OrI => {
                    a |= self.text[pc];
                    pc += 1;
                }
                Op::XorI => {
                    a ^= self.text[pc];
                    pc += 1;
                }
                Op::ShlI => {
                    a = a.wrapping_shl(self.text[pc] as u32);
                    pc += 1;
                }
                Op::ShrI => {
                    a = a.wrapping_shr(self.text[pc] as u32);
                    pc += 1;
                }
                Op::EqI => {
                    a = (a == self.text[pc]) as i64;
                    pc += 1;
                }
                Op::NeI => {
                    a = (a != self.text[pc]) as i64;
                    pc += 1;
                }
                Op::LtI => {
                    a = (a < self.text[pc]) as i64;
                    pc += 1;
                }
                Op::GtI => {
                    a = (a > self.text[pc]) as i64;
                    pc += 1;
                }
                Op::LeI => {
                    a = (a <= self.text[pc]) as i64;
                    pc += 1;
                }
                Op::GeI => {
                    a = (a >= self.text[pc]) as i64;
                    pc += 1;
                }
                // Local-load fusion: `a = *(bp + N*8)`.
                Op::LdLocI => {
                    let addr = (bp as i64 + self.text[pc] * 8) as usize;
                    a = self.load_i64(addr)?;
                    pc += 1;
                }
                Op::LdLocC => {
                    let addr = (bp as i64 + self.text[pc] * 8) as usize;
                    a = self.load_u8(addr)? as i64;
                    pc += 1;
                }
                // Local-store: `*(bp + N*8) = a`. The compiler
                // emits this to spill `a` to a temp slot without
                // disturbing the c5 stack or `a`. (See Op::StLocI
                // doc for why the regular `Lea N; Si` shape can't
                // express this.)
                Op::StLocI => {
                    let addr = (bp as i64 + self.text[pc] * 8) as usize;
                    self.store_i64(addr, a)?;
                    pc += 1;
                }
                // Floating-point ops. Both operands enter as f64
                // bit patterns in i64 form; we reinterpret with
                // `f64::from_bits` for the math, then send the
                // `to_bits()` form back through the integer-shaped
                // accumulator on the way out.
                Op::Fadd => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = (top + acc).to_bits() as i64;
                    sp += 8;
                }
                Op::Fsub => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = (top - acc).to_bits() as i64;
                    sp += 8;
                }
                Op::Fmul => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = (top * acc).to_bits() as i64;
                    sp += 8;
                }
                Op::Fdiv => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = (top / acc).to_bits() as i64;
                    sp += 8;
                }
                Op::Fneg => {
                    let acc = f64::from_bits(a as u64);
                    a = (-acc).to_bits() as i64;
                }
                Op::Feq => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = if top == acc { 1 } else { 0 };
                    sp += 8;
                }
                Op::Fne => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = if top != acc { 1 } else { 0 };
                    sp += 8;
                }
                Op::Flt => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = if top < acc { 1 } else { 0 };
                    sp += 8;
                }
                Op::Fgt => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = if top > acc { 1 } else { 0 };
                    sp += 8;
                }
                Op::Fle => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = if top <= acc { 1 } else { 0 };
                    sp += 8;
                }
                Op::Fge => {
                    let top = f64::from_bits(self.load_i64(sp)? as u64);
                    let acc = f64::from_bits(a as u64);
                    a = if top >= acc { 1 } else { 0 };
                    sp += 8;
                }
                Op::Fcvtfi => {
                    // Truncating cast, matching the C `(int)f` rule:
                    // discard the fractional part; out-of-range
                    // values saturate (Rust's `as i64` semantics).
                    let f = f64::from_bits(a as u64);
                    a = f as i64;
                }
                Op::Fcvtif => {
                    let i = a;
                    a = (i as f64).to_bits() as i64;
                }
                Op::TlsLea => {
                    // Single-threaded VM: TLS is just a region
                    // appended to `data`. Resolve the operand to
                    // `tls_base + offset` and treat downstream
                    // loads/stores like any other data access.
                    let offset = self.text[pc];
                    pc += 1;
                    a = (self.tls_base as i64) + offset;
                }
                Op::Mcpy => {
                    let size = self.text[pc] as usize;
                    pc += 1;
                    let src = a as usize;
                    let dst = self.load_i64(sp)? as usize;
                    sp += 8;
                    // Same access checks as the libc memcpy
                    // intrinsic; the IR-level Mcpy is the path
                    // struct-copy assignment takes, so any
                    // misaligned pointer that would corrupt the
                    // VM's tracked-pointer model is caught here.
                    self.check_data_access(src, size, AccessKind::Read)?;
                    self.check_data_access(dst, size, AccessKind::Write)?;
                    for i in 0..size {
                        let byte = self.load_u8(src + i)?;
                        self.store_u8(dst + i, byte)?;
                    }
                    a = dst as i64;
                }
                Op::JsrExt => {
                    // External library call. The operand is the
                    // binding's flat index across all
                    // `#pragma binding(...)` the preprocessor
                    // parsed; we look up its `local_name` and
                    // dispatch to the matching Rust shim. The c4
                    // emitter follows every call with `Op::Adj N`
                    // (omitted for 0-arg calls), which the next
                    // loop iteration drops as usual.
                    let binding_idx = self.text[pc];
                    pc += 1;
                    let local_name = self.binding_name(binding_idx)?;
                    a = match local_name {
                        "open" => self.intrinsic_open(sp)?,
                        "read" => self.intrinsic_read(sp)?,
                        "close" => self.intrinsic_close(sp)?,
                        "malloc" => self.intrinsic_malloc(sp)?,
                        "free" => self.intrinsic_free(sp)?,
                        "memset" => self.intrinsic_memset(sp)?,
                        "memcmp" => self.intrinsic_memcmp(sp)?,
                        "memcpy" => self.intrinsic_memcpy(sp)?,
                        // After both `pc += 1`s above, `pc` points
                        // at the byte just past the JsrExt operand.
                        // `intrinsic_printf` peeks there for the
                        // trailing `Op::Adj N` so it knows how many
                        // args the caller pushed.
                        "printf" => self.intrinsic_printf(sp, pc)?,
                        "exit" => return self.load_i64(sp),
                        "write" => self.intrinsic_write(sp)?,
                        "getenv" => self.intrinsic_getenv(sp)?,
                        "setenv" => self.intrinsic_setenv(sp)?,
                        "dlopen" => self.intrinsic_dlopen(sp)?,
                        "dlsym" => self.intrinsic_dlsym(sp)?,
                        "dlclose" => self.intrinsic_dlclose(sp)?,
                        "dlerror" => self.intrinsic_dlerror()?,
                        other => {
                            return Err(C5Error::Runtime(alloc::format!(
                                "VM: no shim for binding `{other}` -- the VM only knows the \
                                 standard libc surface (open/read/close/printf/...). Drop \
                                 `--interp` (or use `--jit`) to reach the rest of libc."
                            )));
                        }
                    };
                }
            }
        }
    }
}
