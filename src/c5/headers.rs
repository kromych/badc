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
    EMBEDDED_HEADERS
        .iter()
        .find_map(|&(n, body)| if n == name { Some(body) } else { None })
}

/// All bundled headers, as a `(name, body)` slice. Public so the
/// CLI's `--dump-headers` flag can iterate the registry without
/// reaching into the preprocessor.
pub fn embedded_headers() -> &'static [(&'static str, &'static str)] {
    EMBEDDED_HEADERS
}

/// Every header the registry knows about, as a `(name, body)` slice.
/// Iterable -- the compiler walks this list when an unknown function
/// call appears in source so it can suggest the right `#include`.
/// `memory.h` is omitted: it's a legacy alias for `string.h` and
/// would just produce duplicate hits in the diagnostic.
pub(super) const EMBEDDED_HEADERS: &[(&str, &str)] = &[
    ("stddef.h", include_str!("../../headers/include/stddef.h")),
    ("stdint.h", include_str!("../../headers/include/stdint.h")),
    (
        "inttypes.h",
        include_str!("../../headers/include/inttypes.h"),
    ),
    ("setjmp.h", include_str!("../../headers/include/setjmp.h")),
    ("limits.h", include_str!("../../headers/include/limits.h")),
    ("string.h", include_str!("../../headers/include/string.h")),
    ("stdio.h", include_str!("../../headers/include/stdio.h")),
    ("stdlib.h", include_str!("../../headers/include/stdlib.h")),
    ("alloca.h", include_str!("../../headers/include/alloca.h")),
    ("malloc.h", include_str!("../../headers/include/malloc.h")),
    ("stdarg.h", include_str!("../../headers/include/stdarg.h")),
    ("stdbool.h", include_str!("../../headers/include/stdbool.h")),
    (
        "stdnoreturn.h",
        include_str!("../../headers/include/stdnoreturn.h"),
    ),
    ("ctype.h", include_str!("../../headers/include/ctype.h")),
    ("math.h", include_str!("../../headers/include/math.h")),
    ("float.h", include_str!("../../headers/include/float.h")),
    ("locale.h", include_str!("../../headers/include/locale.h")),
    ("signal.h", include_str!("../../headers/include/signal.h")),
    ("errno.h", include_str!("../../headers/include/errno.h")),
    ("assert.h", include_str!("../../headers/include/assert.h")),
    ("time.h", include_str!("../../headers/include/time.h")),
    ("dirent.h", include_str!("../../headers/include/dirent.h")),
    ("pwd.h", include_str!("../../headers/include/pwd.h")),
    ("unistd.h", include_str!("../../headers/include/unistd.h")),
    ("fcntl.h", include_str!("../../headers/include/fcntl.h")),
    (
        "sys/types.h",
        include_str!("../../headers/include/sys/types.h"),
    ),
    (
        "sys/stat.h",
        include_str!("../../headers/include/sys/stat.h"),
    ),
    (
        "sys/mman.h",
        include_str!("../../headers/include/sys/mman.h"),
    ),
    (
        "sys/socket.h",
        include_str!("../../headers/include/sys/socket.h"),
    ),
    (
        "sys/select.h",
        include_str!("../../headers/include/sys/select.h"),
    ),
    (
        "sys/wait.h",
        include_str!("../../headers/include/sys/wait.h"),
    ),
    (
        "sys/ioctl.h",
        include_str!("../../headers/include/sys/ioctl.h"),
    ),
    (
        "sys/time.h",
        include_str!("../../headers/include/sys/time.h"),
    ),
    ("termios.h", include_str!("../../headers/include/termios.h")),
    ("poll.h", include_str!("../../headers/include/poll.h")),
    ("strings.h", include_str!("../../headers/include/strings.h")),
    ("libgen.h", include_str!("../../headers/include/libgen.h")),
    ("glob.h", include_str!("../../headers/include/glob.h")),
    ("pthread.h", include_str!("../../headers/include/pthread.h")),
    ("dlfcn.h", include_str!("../../headers/include/dlfcn.h")),
    ("windows.h", include_str!("../../headers/include/windows.h")),
    (
        "winternl.h",
        include_str!("../../headers/include/winternl.h"),
    ),
    ("wchar.h", include_str!("../../headers/include/wchar.h")),
    // Opt-in MSVC-shape predefines: no `#pragma binding`
    // here, just `#define _MSC_VER 1900`, `#define __int64 long
    // long`, the `__declspec(x)` family of empty-decorator
    // macros, etc. Build drivers that need to compile MSVC-
    // shaped C against the Windows backend opt in via
    // `badc -include msvc_compat.h ...`. Internally guarded by
    // `#ifdef _WIN32` so the same command line stays valid on
    // every host.
    (
        "msvc_compat.h",
        include_str!("../../headers/include/msvc_compat.h"),
    ),
    // Legacy alias: <memory.h> predates POSIX's consolidation of
    // mem*/str* under <string.h>. Mapped from `embedded_header` but
    // not enumerated here -- the suggestion path would otherwise
    // emit two header names for any `mem*` symbol.
    #[allow(dead_code)]
    ("memory.h", include_str!("../../headers/include/memory.h")),
];

// Build-time-generated `&[(name, header)]` sorted by name. Produced
// by `build.rs`'s `emit_binding_to_header_index`, which walks
// `headers/include/*.h` once per build and harvests every
// `#pragma binding(<dylib>::<name>, ...)` local symbol plus every
// file-scope function-prototype identifier. First-occurrence-wins
// per name in lexicographic header order; a duplicate declaration
// in a second header is silently dropped.
include!(concat!(env!("OUT_DIR"), "/binding_to_header.rs"));

/// Look up a function name in the build-time-generated index and
/// return the header that declares it, or `None` for a name we
/// don't recognise. O(log N) over the binding index. Used by the
/// compiler's "unknown function" diagnostic to suggest the right
/// `#include`, and by `Compiler::compile_with_options` to drive
/// the auto-include retry (force-include the header naming the
/// missing symbol, then re-compile).
pub(super) fn header_declaring(name: &str) -> Option<&'static str> {
    BINDING_TO_HEADER
        .binary_search_by_key(&name, |&(n, _)| n)
        .ok()
        .map(|i| BINDING_TO_HEADER[i].1)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn header_declaring_finds_printf_in_stdio() {
        assert_eq!(header_declaring("printf"), Some("stdio.h"));
    }

    #[test]
    fn header_declaring_finds_malloc_in_stdlib() {
        assert_eq!(header_declaring("malloc"), Some("stdlib.h"));
    }

    #[test]
    fn header_declaring_finds_strlen_in_string() {
        assert_eq!(header_declaring("strlen"), Some("string.h"));
    }

    #[test]
    fn header_declaring_finds_pthread_create() {
        assert_eq!(header_declaring("pthread_create"), Some("pthread.h"));
    }

    #[test]
    fn header_declaring_finds_socket() {
        assert_eq!(header_declaring("socket"), Some("sys/socket.h"));
    }

    #[test]
    fn header_declaring_returns_none_for_unknown() {
        assert_eq!(header_declaring("definitely_not_in_any_header"), None);
    }

    #[test]
    fn header_declaring_doesnt_match_prefix() {
        // `print` is not declared anywhere; it's a prefix of
        // `printf` but the trailing `(` and the binding ` ::printf,`
        // pattern guard against false hits.
        assert_eq!(header_declaring("print"), None);
    }
}
