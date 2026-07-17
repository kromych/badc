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
//! (`runtime.c`) gates its sections on driver-defined macros:
//! `__BADC_C5_CRT__` (the image may import the user-mode C library --
//! hosted executables and shared libraries) selects the Windows C99
//! snprintf / vsnprintf definitions, and `__BADC_C5_START__` (an
//! entry stub is emitted -- hosted executables only) selects the
//! `environ` / `tzname` data and the `__c5_exit` / `__c5_entry`
//! startup. Passthrough-entry subsystems (native / EFI) and
//! freestanding images leave both undefined, so the source compiles
//! to nothing for them: no user-mode CRT import, and no `environ`
//! definition (a library inherits it from the host process).

/// Runtime sources compiled + linked alongside the user's
/// translation units on the native-link path.
pub fn embedded_runtime() -> &'static [(&'static str, &'static str)] {
    EMBEDDED_RUNTIME
}

pub(super) const EMBEDDED_RUNTIME: &[(&str, &str)] =
    &[("runtime.c", include_str!("../../libc/lib/runtime.c"))];

/// Compiler-runtime sources joined to the link on demand: each is
/// compiled and offered like an archive member, pulled in only when
/// it defines a symbol the link still leaves undefined. A pure-badc
/// image references none of these and carries none of their code.
pub fn embedded_compiler_rt() -> &'static [(&'static str, &'static str)] {
    EMBEDDED_COMPILER_RT
}

pub(super) const EMBEDDED_COMPILER_RT: &[(&str, &str)] = &[(
    "compiler_rt.c",
    include_str!("../../libc/lib/compiler_rt.c"),
)];
