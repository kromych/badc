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
//! `#ifdef`s on the target macros (`__APPLE__`, `__linux__`,
//! `_WIN32`) to pick the right `#pragma dylib(...)` and
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
pub(super) fn embedded_header(name: &str) -> Option<&'static str> {
    Some(match name {
        "string.h" => include_str!("../../headers/include/string.h"),
        "stdio.h" => include_str!("../../headers/include/stdio.h"),
        "stdlib.h" => include_str!("../../headers/include/stdlib.h"),
        "stdarg.h" => include_str!("../../headers/include/stdarg.h"),
        "unistd.h" => include_str!("../../headers/include/unistd.h"),
        "fcntl.h" => include_str!("../../headers/include/fcntl.h"),
        "sys/mman.h" => include_str!("../../headers/include/sys/mman.h"),
        "sys/socket.h" => include_str!("../../headers/include/sys/socket.h"),
        "sys/select.h" => include_str!("../../headers/include/sys/select.h"),
        "pthread.h" => include_str!("../../headers/include/pthread.h"),
        "dlfcn.h" => include_str!("../../headers/include/dlfcn.h"),
        "windows.h" => include_str!("../../headers/include/windows.h"),
        // Legacy alias: <memory.h> predates POSIX's consolidation
        // of mem*/str* under <string.h>. Forwards to string.h.
        "memory.h" => include_str!("../../headers/include/memory.h"),
        _ => return None,
    })
}
