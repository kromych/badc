//! Embedded runtime C sources auto-linked into every native
//! executable.
//!
//! Mirrors `embedded_headers`: each entry is `include_str!`'d
//! at build time so the runtime ships inside the badc binary
//! and the link path doesn't need to read the filesystem. The
//! native-link driver compiles each `(name, body)` to a
//! native ELF ET_REL alongside the user's translation units
//! and links them in unconditionally.
//!
//! Today the registry carries one source: a libc-`exit`
//! wrapper the writer's `_start` stub calls instead of the
//! raw `exit_group` syscall. Calling libc `exit` runs the
//! atexit chain (including stdio fflush) before the kernel
//! reaps the process, so any buffered output is committed
//! before the program leaves. Future entries: a C-side
//! `_start` (pending `__builtin_argc` / `__builtin_argv`
//! intrinsics).

/// All bundled runtime sources, as a `(name, body)` slice.
pub fn embedded_runtime() -> &'static [(&'static str, &'static str)] {
    EMBEDDED_RUNTIME
}

pub(super) const EMBEDDED_RUNTIME: &[(&str, &str)] =
    &[("runtime.c", include_str!("../../lib/runtime.c"))];
