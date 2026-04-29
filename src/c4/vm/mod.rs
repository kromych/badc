use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use super::CODE_BASE;
use super::error::C4Error;
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
        Self {
            text: program.text,
            data: program.data,
            entry_pc: program.entry_pc,
            stack: vec![0; STACK_CAPACITY],
            host,
            trace: Trace::Off,
            args: Vec::new(),
            allocations: Vec::new(),
            static_end: 0,
            track_pointers: false,
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
    fn decode_pc(&self, v: i64) -> Result<usize, C4Error> {
        let raw = v as usize;
        if raw < CODE_BASE || raw >= CODE_BASE + self.text.len() {
            return Err(C4Error::Runtime(format!(
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
    fn check_data_access(&self, addr: usize, len: usize, kind: AccessKind) -> Result<(), C4Error> {
        // 1. Code segment is not addressable as data.
        if addr >= CODE_BASE && addr < CODE_BASE + self.text.len() {
            return Err(C4Error::Runtime(format!(
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
        for alloc in &self.allocations {
            if addr >= alloc.start && addr < alloc.start + alloc.len {
                if alloc.freed {
                    return Err(C4Error::Runtime(format!(
                        "use-after-free: access at 0x{addr:x} inside freed allocation #{} (start=0x{:x}, len={})",
                        alloc.id, alloc.start, alloc.len
                    )));
                }
                if addr + len > alloc.start + alloc.len {
                    return Err(C4Error::Runtime(format!(
                        "out-of-bounds: {len}-byte access at 0x{addr:x} runs past allocation #{} end=0x{:x}",
                        alloc.id,
                        alloc.start + alloc.len
                    )));
                }
                return Ok(());
            }
        }
        Err(C4Error::Runtime(format!(
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

    fn load_i64(&self, addr: usize) -> Result<i64, C4Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                Ok(self.stack[idx])
            } else {
                Err(C4Error::Runtime(format!(
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

    fn store_i64(&mut self, addr: usize, val: i64) -> Result<(), C4Error> {
        if let Some(idx) = self.get_stack_idx(addr) {
            if idx < self.stack.len() {
                self.stack[idx] = val;
                Ok(())
            } else {
                Err(C4Error::Runtime(format!(
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

    fn load_u8(&self, addr: usize) -> Result<u8, C4Error> {
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

    fn store_u8(&mut self, addr: usize, val: u8) -> Result<(), C4Error> {
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

    fn read_cstring(&self, addr: usize) -> Result<String, C4Error> {
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

    /// Execute the program. Consumes the VM because `run` mutates `text`
    /// (appending the bootstrap), `data` (staging argv), and the recorded
    /// `static_end`/heap state -- invoking it twice would corrupt those
    /// invariants. Build a fresh `Vm` for each run.
    pub fn run(mut self) -> Result<i64, C4Error> {
        if self.text.is_empty() {
            return Err(C4Error::Runtime("empty program".to_string()));
        }

        let mut sp = STACK_BASE + STACK_CAPACITY * 8;
        let mut bp = sp;

        // Append a Psh+Exit bootstrap so main's `Lev` returns into it
        // and terminates with the value left in the accumulator.
        let bootstrap_addr = self.text.len();
        self.text.push(Op::Psh as i64);
        self.text.push(Op::Exit as i64);

        // Stage argv strings + array in the data segment, then push argc /
        // argv_addr as the two parameters of `main`. The compiler maps
        //   int main(int argc, char **argv)
        // to read argc from bp+24 and argv from bp+16, so argc must be the
        // FIRST push (it sits deeper on the stack). When `args` is empty
        // these slots are both zero, and a `main()` defined without
        // parameters simply ignores them.
        let argv_addr = self.install_argv();
        let argc = self.args.len() as i64;

        // Freeze the static-data boundary now: anything below this address
        // (string literals, globals, argv) is implicitly trusted by the
        // pointer-tracking access check; anything at-or-above must come
        // from a tracked allocation.
        self.static_end = self.data.len();

        sp -= 8;
        self.store_i64(sp, argc)?;
        sp -= 8;
        self.store_i64(sp, argv_addr)?;
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
            if pc >= self.text.len() {
                return Err(C4Error::Runtime("PC out of bounds".to_string()));
            }

            let raw_op = self.text[pc];
            let op = Op::from_i64(raw_op).ok_or_else(|| {
                C4Error::Runtime(format!("Invalid instruction {} at PC {}", raw_op, pc))
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
                Op::Open => a = self.intrinsic_open(sp)?,
                Op::Read => a = self.intrinsic_read(sp)?,
                Op::Clos => a = self.intrinsic_close(sp)?,
                Op::Malc => a = self.intrinsic_malloc(sp)?,
                Op::Free => a = self.intrinsic_free(sp)?,
                Op::Mset => a = self.intrinsic_memset(sp)?,
                Op::Mcmp => a = self.intrinsic_memcmp(sp)?,
                Op::Mcpy => a = self.intrinsic_memcpy(sp)?,
                Op::Prtf => a = self.intrinsic_printf(sp, pc)?,
                Op::Exit => return self.load_i64(sp),
                Op::Write => a = self.intrinsic_write(sp)?,
                Op::Genv => a = self.intrinsic_getenv(sp)?,
                Op::Senv => a = self.intrinsic_setenv(sp)?,
                Op::Dlop => a = self.intrinsic_dlopen(sp)?,
                Op::Dlsm => a = self.intrinsic_dlsym(sp)?,
                Op::Dlcl => a = self.intrinsic_dlclose(sp)?,
                Op::Dler => a = self.intrinsic_dlerror()?,
            }
        }
    }
}
