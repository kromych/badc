//! Library-call implementations.
//!
//! Each `Op::*` arm in [`super::Vm::run`] that handles a host-call
//! delegates to a method here. The split keeps `mod.rs` focused on the
//! interpreter mechanics (dispatch, memory, allocation tracking,
//! mprotect) while `syscalls.rs` is a flat catalogue of "what the C
//! standard-library names do under badc". Adding a new intrinsic is now
//! "register a name in `lexer::LIB_OPS`, add an `Op::*` variant, write
//! one method here, and one match arm in `run`".
//!
//! All host-side IO goes through `self.host` (the `Host` trait); this
//! is what keeps the file `no_std`-clean.

// Rust's default visibility ("private to declaring module + descendants")
// means we can reach into mod.rs's private fields and methods without
// any pub annotations -- `intrinsics` is a child of `vm`, so all of vm's
// internals are in scope.
use alloc::format;
use alloc::string::ToString;
use alloc::vec;

use super::super::host::Overwrite;
use super::{AccessKind, C5Error, Host, Op, Vm};

impl<H: Host> Vm<H> {
    /// Load an `i64` size argument from the stack and validate it as a
    /// non-negative `usize`. Without this, a negative size silently
    /// becomes `~2^63` after the `as usize` cast -- the sort of value
    /// that turns `Vec::resize`/`vec![0; n]` into a host-process panic
    /// or sends `memset` looping until it walks off the heap. The
    /// `name` is included in the error so the diagnostic points at the
    /// offending intrinsic rather than the underlying read/store error.
    pub(super) fn read_size(&self, addr: usize, name: &str) -> Result<usize, C5Error> {
        let n = self.load_i64(addr)?;
        if n < 0 {
            return Err(C5Error::Runtime(format!("{name}: negative size {n}")));
        }
        Ok(n as usize)
    }

    /// `int open(const char *path, int flags)` -- opens for reading
    /// regardless of `flags` (the host trait doesn't model write modes).
    /// Returns a fresh non-negative fd, or -1 on error.
    pub(super) fn intrinsic_open(&mut self, sp: usize) -> Result<i64, C5Error> {
        // c5 cdecl push order: arg 0 is at sp+0, arg 1 at sp+8, ...
        let name_addr = self.load_i64(sp)? as usize;
        let _flags = self.load_i64(sp + 8)?;
        let name = self.read_cstring(name_addr)?;
        Ok(self.host.open(&name))
    }

    /// `int read(int fd, void *buf, int count)` -- reads up to `count`
    /// bytes through the host. fd 0 is conventionally stdin.
    pub(super) fn intrinsic_read(&mut self, sp: usize) -> Result<i64, C5Error> {
        let fd = self.load_i64(sp)?;
        let buf_addr = self.load_i64(sp + 8)? as usize;
        let size = self.read_size(sp + 16, "read")?;
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
    pub(super) fn intrinsic_close(&mut self, sp: usize) -> Result<i64, C5Error> {
        let fd = self.load_i64(sp)?;
        Ok(self.host.close(fd))
    }

    /// `void *malloc(size_t size)` -- bump-allocates from the data
    /// segment. Always rounds up to 8 bytes. Reserves the NULL page on
    /// the first call so the returned pointer is never 0.
    pub(super) fn intrinsic_malloc(&mut self, sp: usize) -> Result<i64, C5Error> {
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
    pub(super) fn intrinsic_free(&mut self, sp: usize) -> Result<i64, C5Error> {
        let ptr = self.load_i64(sp)? as usize;
        if self.track_pointers {
            match self.allocations.iter_mut().find(|a| a.start == ptr) {
                Some(alloc) if alloc.freed => {
                    return Err(C5Error::Runtime(format!(
                        "double free: allocation #{} at 0x{ptr:x} freed twice",
                        alloc.id
                    )));
                }
                Some(alloc) => alloc.freed = true,
                None => {
                    return Err(C5Error::Runtime(format!(
                        "free of unknown pointer 0x{ptr:x} (not returned by malloc)"
                    )));
                }
            }
        }
        Ok(0)
    }

    /// `void *memset(void *dst, int val, size_t n)` -- block-checks the
    /// destination range up front, then writes byte-by-byte.
    pub(super) fn intrinsic_memset(&mut self, sp: usize) -> Result<i64, C5Error> {
        let dst_addr = self.load_i64(sp)? as usize;
        let val = self.load_i64(sp + 8)? as u8;
        let size = self.read_size(sp + 16, "memset")?;
        self.check_data_access(dst_addr, size, AccessKind::Write)?;
        for i in 0..size {
            self.store_u8(dst_addr + i, val)?;
        }
        Ok(dst_addr as i64)
    }

    /// `int memcmp(const void *s1, const void *s2, size_t n)` -- block-
    /// checks both reads, then compares byte-by-byte.
    pub(super) fn intrinsic_memcmp(&mut self, sp: usize) -> Result<i64, C5Error> {
        let s1_addr = self.load_i64(sp)? as usize;
        let s2_addr = self.load_i64(sp + 8)? as usize;
        let size = self.read_size(sp + 16, "memcmp")?;
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
    pub(super) fn intrinsic_memcpy(&mut self, sp: usize) -> Result<i64, C5Error> {
        let dst_addr = self.load_i64(sp)? as usize;
        let src_addr = self.load_i64(sp + 8)? as usize;
        let size = self.read_size(sp + 16, "memcpy")?;
        self.check_data_access(src_addr, size, AccessKind::Read)?;
        self.check_data_access(dst_addr, size, AccessKind::Write)?;
        for i in 0..size {
            let byte = self.load_u8(src_addr + i)?;
            self.store_u8(dst_addr + i, byte)?;
        }
        Ok(dst_addr as i64)
    }

    /// `int printf(const char *fmt, ...)` -- limited subset (`%d`, `%c`,
    /// `%s`). Reads the arg count by peeking at the next instruction
    /// (it'll be `Op::Adj N` if main called us with N args). Always
    /// returns 0; printed bytes go to `Host::write(1, ...)` (stdout).
    pub(super) fn intrinsic_printf(&mut self, sp: usize, pc: usize) -> Result<i64, C5Error> {
        // The caller emits a trailing `Op::Adj N` after every printf so
        // we can recover N (c5's cdecl push order means arg 0 is at
        // sp+0 and the variadic tail sits above that). If that's
        // missing, do nothing -- silently a no-op rather than reading
        // garbage.
        if pc >= self.text.len() || self.text[pc] != Op::Adj as i64 {
            return Ok(0);
        }
        let nargs = self.text[pc + 1] as usize;
        let fmt_addr = self.load_i64(sp)? as usize;
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
                    let offset = arg_idx * 8;
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
    pub(super) fn intrinsic_write(&mut self, sp: usize) -> Result<i64, C5Error> {
        let fd = self.load_i64(sp)?;
        let buf_addr = self.load_i64(sp + 8)? as usize;
        let size = self.read_size(sp + 16, "write")?;
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
    pub(super) fn intrinsic_getenv(&mut self, sp: usize) -> Result<i64, C5Error> {
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
    pub(super) fn intrinsic_setenv(&mut self, sp: usize) -> Result<i64, C5Error> {
        let name_addr = self.load_i64(sp)? as usize;
        let val_addr = self.load_i64(sp + 8)? as usize;
        let overwrite = if self.load_i64(sp + 16)? != 0 {
            Overwrite::Force
        } else {
            Overwrite::Skip
        };
        let name = self.read_cstring(name_addr)?;
        let value = self.read_cstring(val_addr)?;
        self.host.setenv(&name, &value, overwrite);
        Ok(0)
    }

    /// `void *dlopen(const char *filename, int flags)` -- delegates
    /// to the host's libdl bridge. A NULL filename (c4 pointer 0)
    /// is mapped to `Option::None` so [`Host::dlopen`] can produce
    /// `dlopen(NULL, ...)` (the global symbol table).
    pub(super) fn intrinsic_dlopen(&mut self, sp: usize) -> Result<i64, C5Error> {
        let path_addr = self.load_i64(sp)? as usize;
        let flags = self.load_i64(sp + 8)?;
        let path = if path_addr == 0 {
            None
        } else {
            Some(self.read_cstring(path_addr)?)
        };
        Ok(self.host.dlopen(path.as_deref(), flags))
    }

    /// `void *dlsym(void *handle, const char *name)` -- look up a
    /// symbol's native address in a previously-opened library.
    /// Returned address is a real pointer in the host process; the
    /// VM treats it as an opaque integer (calling through it via
    /// `Op::Jsri` is rejected because `decode_pc` requires a
    /// CODE_BASE-biased c4 PC, not a libc address).
    pub(super) fn intrinsic_dlsym(&mut self, sp: usize) -> Result<i64, C5Error> {
        let handle = self.load_i64(sp)?;
        let name_addr = self.load_i64(sp + 8)? as usize;
        let name = self.read_cstring(name_addr)?;
        Ok(self.host.dlsym(handle, &name))
    }

    /// `int dlclose(void *handle)` -- pass through to the host.
    pub(super) fn intrinsic_dlclose(&mut self, sp: usize) -> Result<i64, C5Error> {
        let handle = self.load_i64(sp)?;
        Ok(self.host.dlclose(handle))
    }

    /// `char *dlerror(void)` -- the most recent loader error
    /// message, copied into the data segment so the c5-side pointer
    /// stays valid after subsequent dl-family calls (the libc
    /// version's static buffer would otherwise be clobbered). 0 if
    /// no error pending.
    pub(super) fn intrinsic_dlerror(&mut self) -> Result<i64, C5Error> {
        Ok(match self.host.dlerror() {
            Some(msg) => self.install_cstring(msg.as_bytes()) as i64,
            None => 0,
        })
    }
}
