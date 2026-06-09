//! Embedded runtime C sources auto-linked into the native
//! link path.
//!
//! Mirrors `embedded_headers`: each entry is `include_str!`'d
//! at build time so the runtime ships inside the badc binary
//! and the link path doesn't need to read the filesystem. The
//! native-link driver compiles each `(name, body)` to a
//! native ELF ET_REL alongside the user's translation units.
//!
//! Two registries:
//!   * [`EMBEDDED_RUNTIME`] -- data definitions (`environ` /
//!     `_environ`) linked into every native image.
//!   * [`EMBEDDED_START_RUNTIME`] -- the libc-`exit` wrapper
//!     (`__c5_exit`) the writer's `_start` stub calls instead
//!     of the raw `exit_group` syscall. Linked only when a
//!     `_start` stub is emitted; images with no stub (shared
//!     libraries, passthrough-entry subsystems) skip it so
//!     they carry no user-mode libc `exit` import.

/// Runtime data sources linked into every native image.
pub fn embedded_runtime() -> &'static [(&'static str, &'static str)] {
    EMBEDDED_RUNTIME
}

/// Runtime sources linked only when the writer emits a `_start`
/// CRT stub (native executables, not shared libraries or
/// passthrough-entry subsystems).
pub fn embedded_start_runtime() -> &'static [(&'static str, &'static str)] {
    EMBEDDED_START_RUNTIME
}

pub(super) const EMBEDDED_RUNTIME: &[(&str, &str)] =
    &[("runtime.c", include_str!("../../lib/runtime.c"))];

pub(super) const EMBEDDED_START_RUNTIME: &[(&str, &str)] = &[(
    "runtime_libc_exit.c",
    include_str!("../../lib/runtime_libc_exit.c"),
)];
