//! Embedded standard-style headers, served to the preprocessor's
//! `#include` machinery.
//!
//! Each entry is `include_str!`'d at build time, so the headers ship
//! inside the badc binary and the compiler doesn't need a filesystem
//! search path. The user writes `#include <stdio.h>` and the
//! preprocessor pulls the matching string out of [`embedded_header`].
//!
//! The set is intentionally small -- POSIX-flavoured names plus
//! `windows.h` for the kernel32 surface. Each header internally
//! `#ifdef`s on the target macros (`__BADC_WINDOWS__`, `__APPLE__`,
//! `__linux__`) to pick the right `#pragma dylib(...)` and
//! `#pragma binding(...)`. That keeps the user-visible header set
//! cross-platform even though the underlying dylib is per-OS.
//!
//! Adding a header: drop the file under `headers/include/`, add a
//! `match` arm here, and (if it's a real header) document the bound
//! symbols at the top of the file.

/// Resolve a header name to its embedded contents.
///
/// `name` is the bare filename as it appears in the `#include`
/// directive -- `"stdio.h"`, not a path. `<...>` and `"..."` forms
/// hit the same registry today; a future filesystem search path
/// could split them.
///
/// Returns `None` for an unknown name. The preprocessor treats that
/// as a silent no-op (matching the historical behaviour where
/// `#include` was unrecognised entirely), so legacy fixtures with
/// e.g. `#include <fcntl.h>` for documentation don't break.
pub(super) fn embedded_header(_name: &str) -> Option<&'static str> {
    // Per-purpose headers land here in the next step (string.h,
    // stdio.h, stdlib.h, unistd.h, dlfcn.h, pthread.h, windows.h).
    // The registry is intentionally empty for now: this commit only
    // wires up the `#include` plumbing.
    None
}
