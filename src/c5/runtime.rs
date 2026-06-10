//! Embedded runtime C sources auto-linked into the native
//! link path.
//!
//! Mirrors `embedded_headers`: each entry is `include_str!`'d
//! at build time so the runtime ships inside the badc binary
//! and the link path doesn't need to read the filesystem. The
//! native-link driver compiles each `(name, body)` to a
//! native ELF ET_REL alongside the user's translation units.
//!
//! Single registry [`EMBEDDED_RUNTIME`]. Its one source
//! (`runtime.c`) gates everything -- the `environ` / `_environ` data
//! and the `__c5_exit` / `__c5_entry` startup -- on
//! `__BADC_C5_START__`, which the driver defines only when the image
//! writer emits an entry stub. Shared libraries and passthrough-entry
//! subsystems (native / EFI) leave it undefined, so the source
//! compiles to nothing for them: no user-mode CRT import, and no
//! `environ` definition (a library inherits it from the host
//! process).

/// Runtime sources compiled + linked alongside the user's
/// translation units on the native-link path.
pub fn embedded_runtime() -> &'static [(&'static str, &'static str)] {
    EMBEDDED_RUNTIME
}

pub(super) const EMBEDDED_RUNTIME: &[(&str, &str)] =
    &[("runtime.c", include_str!("../../lib/runtime.c"))];
