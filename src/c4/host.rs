//! Host bridge -- the trait that abstracts every system-level service the
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
    /// fd 1 -> stdout, fd 2 -> stderr.
    fn write(&mut self, fd: i64, buf: &[u8]) -> i64;

    /// Look up `name` in the host environment. None on miss.
    fn getenv(&mut self, name: &str) -> Option<String>;

    /// Set `name` to `value`, honouring `overwrite`.
    fn setenv(&mut self, name: &str, value: &str, overwrite: Overwrite);

    /// `dlopen` -- load a shared library at runtime. `path = None`
    /// is POSIX `dlopen(NULL, ...)` (the global symbol table). Return
    /// value is an opaque handle the host gets to interpret -- 0
    /// signals failure, anything else is a valid handle. Host impls
    /// that don't support runtime loading return 0 and `dlerror`
    /// returns a "not supported" message.
    fn dlopen(&mut self, path: Option<&str>, flags: i64) -> i64;

    /// `dlsym` -- look up `name` in `handle`. Returns the symbol's
    /// native address (as an integer) or 0 on miss / unsupported.
    fn dlsym(&mut self, handle: i64, name: &str) -> i64;

    /// `dlclose` -- unload a previously dlopened handle. Returns 0
    /// on success, non-zero on failure.
    fn dlclose(&mut self, handle: i64) -> i64;

    /// `dlerror` -- the most recent loader error message (or None
    /// if no error has occurred since the last call). Mirrors POSIX:
    /// fetching the error consumes it.
    fn dlerror(&mut self) -> Option<String>;
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

        // ---- libdl bridge. POSIX has `dlopen` / `dlsym` /
        // `dlclose` / `dlerror`; Windows ships analogous functions
        // (`LoadLibraryA` / `GetProcAddress` / `FreeLibrary` /
        // `GetLastError`) under different names in `kernel32`. The
        // two cfg arms below pick the right one per host. We don't
        // link the `libloading` crate -- avoiding a Cargo dependency
        // keeps the no_std story clean.

        #[cfg(unix)]
        fn dlopen(&mut self, path: Option<&str>, flags: i64) -> i64 {
            unsafe extern "C" {
                fn dlopen(
                    filename: *const std::os::raw::c_char,
                    flags: std::os::raw::c_int,
                ) -> *mut std::os::raw::c_void;
            }
            let flags_c = flags as std::os::raw::c_int;
            match path {
                Some(s) => {
                    let cs = match std::ffi::CString::new(s) {
                        Ok(cs) => cs,
                        // Embedded NUL -- not a legal path. POSIX
                        // would also refuse, just sets dlerror; we
                        // mirror that with a 0 handle.
                        Err(_) => return 0,
                    };
                    unsafe { dlopen(cs.as_ptr(), flags_c) as i64 }
                }
                None => unsafe { dlopen(std::ptr::null(), flags_c) as i64 },
            }
        }

        #[cfg(unix)]
        fn dlsym(&mut self, handle: i64, name: &str) -> i64 {
            unsafe extern "C" {
                fn dlsym(
                    handle: *mut std::os::raw::c_void,
                    name: *const std::os::raw::c_char,
                ) -> *mut std::os::raw::c_void;
            }
            let cs = match std::ffi::CString::new(name) {
                Ok(cs) => cs,
                Err(_) => return 0,
            };
            unsafe { dlsym(handle as *mut _, cs.as_ptr()) as i64 }
        }

        #[cfg(unix)]
        fn dlclose(&mut self, handle: i64) -> i64 {
            unsafe extern "C" {
                fn dlclose(handle: *mut std::os::raw::c_void) -> std::os::raw::c_int;
            }
            unsafe { dlclose(handle as *mut _) as i64 }
        }

        #[cfg(unix)]
        fn dlerror(&mut self) -> Option<String> {
            unsafe extern "C" {
                fn dlerror() -> *const std::os::raw::c_char;
            }
            let ptr = unsafe { dlerror() };
            if ptr.is_null() {
                None
            } else {
                // The pointer is valid until the *next* dlerror
                // call; copy out before returning so callers can
                // hold the message past further dl* operations.
                Some(
                    unsafe { std::ffi::CStr::from_ptr(ptr) }
                        .to_string_lossy()
                        .into_owned(),
                )
            }
        }

        // ---- Windows. `LoadLibraryA` / `GetProcAddress` /
        // `FreeLibrary` map cleanly to dlopen / dlsym / dlclose. For
        // dlopen(NULL) we return `GetModuleHandleA(NULL)` -- the
        // main process handle -- which lets `GetProcAddress` look up
        // symbols in the executable itself. POSIX's "search every
        // loaded library" behaviour is not reproduced; callers that
        // need a libc symbol should `dlopen("ucrtbase.dll")`
        // explicitly. dlerror is approximated via `GetLastError +
        // FormatMessageA`.

        #[cfg(windows)]
        fn dlopen(&mut self, path: Option<&str>, _flags: i64) -> i64 {
            type Hmodule = *mut std::os::raw::c_void;
            unsafe extern "system" {
                fn LoadLibraryA(name: *const std::os::raw::c_char) -> Hmodule;
                fn GetModuleHandleA(name: *const std::os::raw::c_char) -> Hmodule;
            }
            match path {
                Some(s) => {
                    let cs = match std::ffi::CString::new(s) {
                        Ok(cs) => cs,
                        Err(_) => return 0,
                    };
                    unsafe { LoadLibraryA(cs.as_ptr()) as i64 }
                }
                None => unsafe { GetModuleHandleA(std::ptr::null()) as i64 },
            }
        }

        #[cfg(windows)]
        fn dlsym(&mut self, handle: i64, name: &str) -> i64 {
            type Hmodule = *mut std::os::raw::c_void;
            unsafe extern "system" {
                fn GetProcAddress(
                    handle: Hmodule,
                    name: *const std::os::raw::c_char,
                ) -> *mut std::os::raw::c_void;
            }
            if handle == 0 {
                return 0;
            }
            let cs = match std::ffi::CString::new(name) {
                Ok(cs) => cs,
                Err(_) => return 0,
            };
            unsafe { GetProcAddress(handle as Hmodule, cs.as_ptr()) as i64 }
        }

        #[cfg(windows)]
        fn dlclose(&mut self, handle: i64) -> i64 {
            type Hmodule = *mut std::os::raw::c_void;
            unsafe extern "system" {
                fn FreeLibrary(h: Hmodule) -> std::os::raw::c_int;
            }
            if handle == 0 {
                return -1;
            }
            // FreeLibrary returns nonzero on success, zero on
            // failure -- the inverse of POSIX dlclose. Translate.
            let r = unsafe { FreeLibrary(handle as Hmodule) };
            if r != 0 { 0 } else { -1 }
        }

        #[cfg(windows)]
        fn dlerror(&mut self) -> Option<String> {
            unsafe extern "system" {
                fn GetLastError() -> u32;
                fn FormatMessageA(
                    flags: u32,
                    src: *const std::os::raw::c_void,
                    msg_id: u32,
                    lang_id: u32,
                    buf: *mut std::os::raw::c_char,
                    size: u32,
                    args: *mut *mut std::os::raw::c_void,
                ) -> u32;
            }
            const FORMAT_MESSAGE_FROM_SYSTEM: u32 = 0x0000_1000;
            const FORMAT_MESSAGE_IGNORE_INSERTS: u32 = 0x0000_0200;
            let err = unsafe { GetLastError() };
            if err == 0 {
                return None;
            }
            let mut buf = [0u8; 512];
            let n = unsafe {
                FormatMessageA(
                    FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
                    std::ptr::null(),
                    err,
                    0,
                    buf.as_mut_ptr() as *mut _,
                    buf.len() as u32,
                    std::ptr::null_mut(),
                )
            };
            if n == 0 {
                return Some(format!("Windows error {err}"));
            }
            let slice = &buf[..n as usize];
            Some(String::from_utf8_lossy(slice).trim_end().to_string())
        }
    }
}

#[cfg(feature = "std")]
pub use std_host::StdHost;
