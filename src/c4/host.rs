//! Host bridge — the trait that abstracts every system-level service the
//! VM's syscall layer needs (file IO, env, real stdio).
//!
//! The split is what makes the rest of the library `no_std`-clean: the
//! VM is generic over `H: Host`, and concrete impls (`StdHost`) carry
//! the host-specific state (`fd_table`, `next_fd`). Embedded /
//! sandboxed consumers can plug in their own impl that, e.g., stubs
//! out file IO or routes `printf` over a UART.
//!
//! Method semantics mirror POSIX:
//!  - `open` returns a non-negative fd or `-1` on failure
//!  - `read` / `write` return bytes processed or `-1`
//!  - `close` returns 0 / `-1`
//!  - `getenv` returns `Some(String)` on hit, `None` on miss
//!  - `setenv` takes an [`Overwrite`] enum (was previously `i64`,
//!    inherited from the C-side calling convention)
//!
//! fd 0 is conventionally stdin, fd 1 stdout, fd 2 stderr; the VM
//! special-cases them in syscalls but the trait hides whether they map
//! to host streams, in-memory buffers, or are just refused.

use alloc::string::String;

/// Whether [`Host::setenv`] should replace an existing value.
///
/// Mirrors POSIX `setenv`'s third argument, but as a typed enum so the
/// trait signature can't be passed an arbitrary integer.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Overwrite {
    /// Leave the existing value alone if `name` is already set.
    Skip,
    /// Replace any existing value.
    Force,
}

pub trait Host {
    /// Open `name` for reading. Returns a fresh non-negative fd or `-1`.
    fn open(&mut self, name: &str) -> i64;

    /// Close `fd`. Returns 0 on success, `-1` if `fd` wasn't open.
    fn close(&mut self, fd: i64) -> i64;

    /// Read up to `buf.len()` bytes from `fd` into `buf`. Returns the
    /// number of bytes read, or `-1` on failure. fd 0 reads stdin.
    fn read(&mut self, fd: i64, buf: &mut [u8]) -> i64;

    /// Write `buf` to `fd`. Returns bytes written, or `-1` on failure.
    /// fd 1 → stdout, fd 2 → stderr.
    fn write(&mut self, fd: i64, buf: &[u8]) -> i64;

    /// Look up `name` in the host environment. None on miss.
    fn getenv(&mut self, name: &str) -> Option<String>;

    /// Set `name` to `value`, honouring `overwrite`.
    fn setenv(&mut self, name: &str, value: &str, overwrite: Overwrite);
}

#[cfg(feature = "std")]
mod std_host {
    use super::{Host, Overwrite};
    use alloc::string::String;
    use std::collections::HashMap;
    use std::fs::File;
    use std::io::{Read, Write as IoWrite};

    /// Default [`Host`] impl, available when the `std` feature is on
    /// (the default). File IO and env access go through `std::fs` /
    /// `std::env`; stdio goes through `std::io::{stdin, stdout, stderr}`.
    pub struct StdHost {
        fd_table: HashMap<i64, File>,
        next_fd: i64,
    }

    impl Default for StdHost {
        fn default() -> Self {
            // Start fds at 3: 0/1/2 are stdin/stdout/stderr (never in
            // the table; the trait's read/write special-case them).
            Self {
                fd_table: HashMap::new(),
                next_fd: 3,
            }
        }
    }

    impl Host for StdHost {
        fn open(&mut self, name: &str) -> i64 {
            match File::open(name) {
                Ok(file) => {
                    let fd = self.next_fd;
                    self.next_fd += 1;
                    self.fd_table.insert(fd, file);
                    fd
                }
                Err(_) => -1,
            }
        }

        fn close(&mut self, fd: i64) -> i64 {
            if self.fd_table.remove(&fd).is_some() {
                0
            } else {
                -1
            }
        }

        fn read(&mut self, fd: i64, buf: &mut [u8]) -> i64 {
            let res = if fd == 0 {
                std::io::stdin().read(buf)
            } else {
                let Some(file) = self.fd_table.get_mut(&fd) else {
                    return -1;
                };
                file.read(buf)
            };
            res.map(|n| n as i64).unwrap_or(-1)
        }

        fn write(&mut self, fd: i64, buf: &[u8]) -> i64 {
            let res = match fd {
                1 => std::io::stdout().write(buf),
                2 => std::io::stderr().write(buf),
                _ => match self.fd_table.get_mut(&fd) {
                    Some(file) => file.write(buf),
                    None => return -1,
                },
            };
            res.map(|n| n as i64).unwrap_or(-1)
        }

        fn getenv(&mut self, name: &str) -> Option<String> {
            std::env::var(name).ok()
        }

        fn setenv(&mut self, name: &str, value: &str, overwrite: Overwrite) {
            if overwrite == Overwrite::Force || std::env::var(name).is_err() {
                // SAFETY: env mutation is process-global; tests must
                // serialise via a Mutex on the variable name. The
                // 2024 edition flags this as unsafe to surface that
                // exposure.
                unsafe { std::env::set_var(name, value) };
            }
        }
    }
}

#[cfg(feature = "std")]
pub use std_host::StdHost;
