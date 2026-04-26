//! Library-call implementations.
//!
//! Each `Op::*` arm in [`super::Vm::run`] that handles a host-call
//! delegates to a method here. The split keeps `mod.rs` focused on the
//! interpreter mechanics (dispatch, memory, allocation tracking,
//! mprotect) while `syscalls.rs` is a flat catalogue of "what the C
//! standard-library names do under badc". Adding a new syscall is now
//! "register a name in `lexer::LIB_OPS`, add an `Op::*` variant, write
//! one method here, and one match arm in `run`".
//!
//! All host-side IO goes through `self.host` (the `Host` trait); this
//! is what keeps the file `no_std`-clean.

// Rust's default visibility ("private to declaring module + descendants")
// means we can reach into mod.rs's private fields and methods without
// any pub annotations -- `syscalls` is a child of `vm`, so all of vm's
// internals are in scope.
use alloc::format;
use alloc::string::ToString;
use alloc::vec;

use super::super::host::Overwrite;
use super::{AccessKind, C4Error, Host, Op, ProtectedRegion, Vm};

impl<H: Host> Vm<H> {
    /// Load an `i64` size argument from the stack and validate it as a
    /// non-negative `usize`. Without this, a negative size silently
    /// becomes `~2^63` after the `as usize` cast -- the sort of value
    /// that turns `Vec::resize`/`vec![0; n]` into a host-process panic
    /// or sends `memset` looping until it walks off the heap. The
    /// `name` is included in the error so the diagnostic points at the
    /// offending syscall rather than the underlying read/store error.
    pub(super) fn read_size(&self, addr: usize, name: &str) -> Result<usize, C4Error> {
        let n = self.load_i64(addr)?;
        if n < 0 {
            return Err(C4Error::Runtime(format!("{name}: negative size {n}")));
        }
        Ok(n as usize)
    }

    /// `int open(const char *path, int flags)` -- opens for reading
    /// regardless of `flags` (the host trait doesn't model write modes).
    /// Returns a fresh non-negative fd, or -1 on error.
    pub(super) fn syscall_open(&mut self, sp: usize) -> Result<i64, C4Error> {
        let name_addr = self.load_i64(sp + 8)? as usize;
        let _flags = self.load_i64(sp)?;
        let name = self.read_cstring(name_addr)?;
        Ok(self.host.open(&name))
    }

    /// `int read(int fd, void *buf, int count)` -- reads up to `count`
    /// bytes through the host. fd 0 is conventionally stdin.
    pub(super) fn syscall_read(&mut self, sp: usize) -> Result<i64, C4Error> {
        let fd = self.load_i64(sp + 16)?;
        let buf_addr = self.load_i64(sp + 8)? as usize;
        let size = self.read_size(sp, "read")?;
        let mut buf = vec![0u8; size];
        let n = self.host.read(fd, &mut buf);
        if n < 0 {
            return Ok(-1);
        }
        for (i, &byte) in buf.iter().enumerate().take(n as usize) {
            self.store_u8(buf_addr + i, byte)?;
        }
        Ok(n)
    }

    /// `int close(int fd)` -- returns 0 on success, -1 if `fd` wasn't open.
    pub(super) fn syscall_close(&mut self, sp: usize) -> Result<i64, C4Error> {
        let fd = self.load_i64(sp)?;
        Ok(self.host.close(fd))
    }

    /// `void *malloc(size_t size)` -- bump-allocates from the data
    /// segment. Always rounds up to 8 bytes. Reserves the NULL page on
    /// the first call so the returned pointer is never 0.
    pub(super) fn syscall_malloc(&mut self, sp: usize) -> Result<i64, C4Error> {
        let size = self.read_size(sp, "malloc")?;
        let aligned_size = (size + 7) & !7;
        if self.data.is_empty() {
            self.data.resize(8, 0);
        }
        let start = self.data.len();
        self.data.resize(start + aligned_size, 0);
        self.record_allocation(start, aligned_size);
        Ok(start as i64)
    }

    /// `void free(void *ptr)` -- no actual reclamation (the data segment
    /// only grows). Under `--track-pointers`, marks the allocation
    /// freed so subsequent access errors with `use-after-free`. Errors
    /// on double-free or an unknown pointer.
    pub(super) fn syscall_free(&mut self, sp: usize) -> Result<i64, C4Error> {
        let ptr = self.load_i64(sp)? as usize;
        if self.track_pointers {
            match self.allocations.iter_mut().find(|a| a.start == ptr) {
                Some(alloc) if alloc.freed => {
                    return Err(C4Error::Runtime(format!(
                        "double free: allocation #{} at 0x{ptr:x} freed twice",
                        alloc.id
                    )));
                }
                Some(alloc) => alloc.freed = true,
                None => {
                    return Err(C4Error::Runtime(format!(
                        "free of unknown pointer 0x{ptr:x} (not returned by malloc)"
                    )));
                }
            }
        }
        Ok(0)
    }

    /// `void *memset(void *dst, int val, size_t n)` -- block-checks the
    /// destination range up front, then writes byte-by-byte.
    pub(super) fn syscall_memset(&mut self, sp: usize) -> Result<i64, C4Error> {
        let dst_addr = self.load_i64(sp + 16)? as usize;
        let val = self.load_i64(sp + 8)? as u8;
        let size = self.read_size(sp, "memset")?;
        self.check_data_access(dst_addr, size, AccessKind::Write)?;
        for i in 0..size {
            self.store_u8(dst_addr + i, val)?;
        }
        Ok(dst_addr as i64)
    }

    /// `int memcmp(const void *s1, const void *s2, size_t n)` -- block-
    /// checks both reads, then compares byte-by-byte.
    pub(super) fn syscall_memcmp(&mut self, sp: usize) -> Result<i64, C4Error> {
        let s1_addr = self.load_i64(sp + 16)? as usize;
        let s2_addr = self.load_i64(sp + 8)? as usize;
        let size = self.read_size(sp, "memcmp")?;
        self.check_data_access(s1_addr, size, AccessKind::Read)?;
        self.check_data_access(s2_addr, size, AccessKind::Read)?;
        for i in 0..size {
            let c1 = self.load_u8(s1_addr + i)?;
            let c2 = self.load_u8(s2_addr + i)?;
            if c1 != c2 {
                return Ok((c1 as i64) - (c2 as i64));
            }
        }
        Ok(0)
    }

    /// `void *memcpy(void *dst, const void *src, size_t n)` -- block-
    /// checks src (read) and dst (write), copies front-to-back. Standard
    /// memcpy is undefined for overlapping regions; we don't diagnose
    /// overlap.
    pub(super) fn syscall_memcpy(&mut self, sp: usize) -> Result<i64, C4Error> {
        let dst_addr = self.load_i64(sp + 16)? as usize;
        let src_addr = self.load_i64(sp + 8)? as usize;
        let size = self.read_size(sp, "memcpy")?;
        self.check_data_access(src_addr, size, AccessKind::Read)?;
        self.check_data_access(dst_addr, size, AccessKind::Write)?;
        for i in 0..size {
            let byte = self.load_u8(src_addr + i)?;
            self.store_u8(dst_addr + i, byte)?;
        }
        Ok(dst_addr as i64)
    }

    /// `int mprotect(void *addr, size_t len, int prot)` -- record a
    /// permission window. Subsequent loads/stores into `[addr, addr+len)`
    /// are filtered by `check_data_access`. Always honoured, regardless
    /// of `--track-pointers`.
    pub(super) fn syscall_mprotect(&mut self, sp: usize) -> Result<i64, C4Error> {
        let addr = self.load_i64(sp + 16)? as usize;
        let len = self.read_size(sp + 8, "mprotect")?;
        let prot = self.load_i64(sp)? as u8;
        self.protections.push(ProtectedRegion {
            start: addr,
            len,
            prot,
        });
        Ok(0)
    }

    /// `int printf(const char *fmt, ...)` -- limited subset (`%d`, `%c`,
    /// `%s`). Reads the arg count by peeking at the next instruction
    /// (it'll be `Op::Adj N` if main called us with N args). Always
    /// returns 0; printed bytes go to `Host::write(1, ...)` (stdout).
    pub(super) fn syscall_printf(&mut self, sp: usize, pc: usize) -> Result<i64, C4Error> {
        // The caller emits a trailing `Op::Adj N` after every printf so
        // we can recover N (the c4 calling convention pushes args but
        // doesn't tell the callee how many). If that's missing, do
        // nothing -- silently a no-op rather than reading garbage.
        if pc >= self.text.len() || self.text[pc] != Op::Adj as i64 {
            return Ok(0);
        }
        let nargs = self.text[pc + 1] as usize;
        let fmt_addr = self.load_i64(sp + (nargs - 1) * 8)? as usize;
        let s = self.read_cstring(fmt_addr)?;

        let mut arg_idx = 1;
        let mut output = alloc::string::String::new();
        let mut chars = s.chars();
        while let Some(c) = chars.next() {
            if c == '%' {
                let Some(nc) = chars.next() else {
                    continue;
                };
                if arg_idx < nargs {
                    let offset = (nargs - 1 - arg_idx) * 8;
                    let val = self.load_i64(sp + offset)?;
                    arg_idx += 1;
                    match nc {
                        'd' => output.push_str(&val.to_string()),
                        'c' => output.push(val as u8 as char),
                        's' => output.push_str(&self.read_cstring(val as usize)?),
                        _ => output.push(nc),
                    }
                }
            } else if c == '\\' {
                if let Some(nc) = chars.next() {
                    output.push(if nc == 'n' { '\n' } else { nc });
                }
            } else {
                output.push(c);
            }
        }
        self.host.write(1, output.as_bytes());
        Ok(0)
    }

    /// `int write(int fd, const void *buf, size_t n)` -- copies `n`
    /// bytes from the data segment and hands them to the host.
    pub(super) fn syscall_write(&mut self, sp: usize) -> Result<i64, C4Error> {
        let fd = self.load_i64(sp + 16)?;
        let buf_addr = self.load_i64(sp + 8)? as usize;
        let size = self.read_size(sp, "write")?;
        let mut buf = vec![0u8; size];
        for (i, byte) in buf.iter_mut().enumerate() {
            *byte = self.load_u8(buf_addr + i)?;
        }
        Ok(self.host.write(fd, &buf))
    }

    /// `char *getenv(const char *name)` -- looks up `name` through the
    /// host. On hit, the value is copied into the data segment (and
    /// recorded as an allocation so `--track-pointers` allows reads
    /// through the returned pointer); 0 on miss.
    pub(super) fn syscall_getenv(&mut self, sp: usize) -> Result<i64, C4Error> {
        let name_addr = self.load_i64(sp)? as usize;
        let name = self.read_cstring(name_addr)?;
        Ok(match self.host.getenv(&name) {
            Some(value) => self.install_cstring(value.as_bytes()) as i64,
            None => 0,
        })
    }

    /// `int setenv(const char *name, const char *value, int overwrite)` --
    /// the C-side `int` is converted to [`Overwrite`] at the trait
    /// boundary so host impls don't have to remember "non-zero means
    /// replace" themselves.
    pub(super) fn syscall_setenv(&mut self, sp: usize) -> Result<i64, C4Error> {
        let name_addr = self.load_i64(sp + 16)? as usize;
        let val_addr = self.load_i64(sp + 8)? as usize;
        let overwrite = if self.load_i64(sp)? != 0 {
            Overwrite::Force
        } else {
            Overwrite::Skip
        };
        let name = self.read_cstring(name_addr)?;
        let value = self.read_cstring(val_addr)?;
        self.host.setenv(&name, &value, overwrite);
        Ok(0)
    }
}
