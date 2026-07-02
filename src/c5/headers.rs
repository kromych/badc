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
    (
        "_builtins.h",
        include_str!("../../headers/include/_builtins.h"),
    ),
    (
        "stdalign.h",
        include_str!("../../headers/include/stdalign.h"),
    ),
    ("stddef.h", include_str!("../../headers/include/stddef.h")),
    ("stdint.h", include_str!("../../headers/include/stdint.h")),
    (
        "inttypes.h",
        include_str!("../../headers/include/inttypes.h"),
    ),
    ("setjmp.h", include_str!("../../headers/include/setjmp.h")),
    ("limits.h", include_str!("../../headers/include/limits.h")),
    ("string.h", include_str!("../../headers/include/string.h")),
    ("sched.h", include_str!("../../headers/include/sched.h")),
    ("spawn.h", include_str!("../../headers/include/spawn.h")),
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
    (
        "stdatomic.h",
        include_str!("../../headers/include/stdatomic.h"),
    ),
    ("ctype.h", include_str!("../../headers/include/ctype.h")),
    ("math.h", include_str!("../../headers/include/math.h")),
    ("float.h", include_str!("../../headers/include/float.h")),
    ("locale.h", include_str!("../../headers/include/locale.h")),
    ("signal.h", include_str!("../../headers/include/signal.h")),
    ("errno.h", include_str!("../../headers/include/errno.h")),
    ("endian.h", include_str!("../../headers/include/endian.h")),
    ("assert.h", include_str!("../../headers/include/assert.h")),
    ("time.h", include_str!("../../headers/include/time.h")),
    ("utime.h", include_str!("../../headers/include/utime.h")),
    (
        "sys/utime.h",
        include_str!("../../headers/include/sys/utime.h"),
    ),
    ("netdb.h", include_str!("../../headers/include/netdb.h")),
    (
        "sys/utsname.h",
        include_str!("../../headers/include/sys/utsname.h"),
    ),
    ("grp.h", include_str!("../../headers/include/grp.h")),
    (
        "langinfo.h",
        include_str!("../../headers/include/langinfo.h"),
    ),
    (
        "netinet/in.h",
        include_str!("../../headers/include/netinet/in.h"),
    ),
    (
        "netinet/tcp.h",
        include_str!("../../headers/include/netinet/tcp.h"),
    ),
    (
        "arpa/inet.h",
        include_str!("../../headers/include/arpa/inet.h"),
    ),
    ("dirent.h", include_str!("../../headers/include/dirent.h")),
    ("ftw.h", include_str!("../../headers/include/ftw.h")),
    ("fts.h", include_str!("../../headers/include/fts.h")),
    ("pwd.h", include_str!("../../headers/include/pwd.h")),
    ("unistd.h", include_str!("../../headers/include/unistd.h")),
    ("fcntl.h", include_str!("../../headers/include/fcntl.h")),
    ("syslog.h", include_str!("../../headers/include/syslog.h")),
    (
        "execinfo.h",
        include_str!("../../headers/include/execinfo.h"),
    ),
    (
        "sys/types.h",
        include_str!("../../headers/include/sys/types.h"),
    ),
    ("sys/uio.h", include_str!("../../headers/include/sys/uio.h")),
    ("sys/un.h", include_str!("../../headers/include/sys/un.h")),
    ("net/if.h", include_str!("../../headers/include/net/if.h")),
    (
        "net/ethernet.h",
        include_str!("../../headers/include/net/ethernet.h"),
    ),
    (
        "sys/file.h",
        include_str!("../../headers/include/sys/file.h"),
    ),
    (
        "sys/attr.h",
        include_str!("../../headers/include/sys/attr.h"),
    ),
    (
        "libkern/OSByteOrder.h",
        include_str!("../../headers/include/libkern/OSByteOrder.h"),
    ),
    (
        "sys/paths.h",
        include_str!("../../headers/include/sys/paths.h"),
    ),
    (
        "sys/param.h",
        include_str!("../../headers/include/sys/param.h"),
    ),
    (
        "sys/syslimits.h",
        include_str!("../../headers/include/sys/syslimits.h"),
    ),
    (
        "copyfile.h",
        include_str!("../../headers/include/copyfile.h"),
    ),
    (
        "mach/mach_time.h",
        include_str!("../../headers/include/mach/mach_time.h"),
    ),
    (
        "mach/mach.h",
        include_str!("../../headers/include/mach/mach.h"),
    ),
    (
        "mach/task.h",
        include_str!("../../headers/include/mach/task.h"),
    ),
    (
        "sysexits.h",
        include_str!("../../headers/include/sysexits.h"),
    ),
    (
        "sys/sys_domain.h",
        include_str!("../../headers/include/sys/sys_domain.h"),
    ),
    (
        "sys/sysctl.h",
        include_str!("../../headers/include/sys/sysctl.h"),
    ),
    (
        "mach-o/dyld.h",
        include_str!("../../headers/include/mach-o/dyld.h"),
    ),
    (
        "mach-o/loader.h",
        include_str!("../../headers/include/mach-o/loader.h"),
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
        "sys/random.h",
        include_str!("../../headers/include/sys/random.h"),
    ),
    (
        "sys/syscall.h",
        include_str!("../../headers/include/sys/syscall.h"),
    ),
    ("libintl.h", include_str!("../../headers/include/libintl.h")),
    ("elf.h", include_str!("../../headers/include/elf.h")),
    ("link.h", include_str!("../../headers/include/link.h")),
    (
        "linux/random.h",
        include_str!("../../headers/include/linux/random.h"),
    ),
    (
        "linux/auxvec.h",
        include_str!("../../headers/include/linux/auxvec.h"),
    ),
    ("linux/fs.h", include_str!("../../headers/include/linux/fs.h")),
    (
        "linux/sched.h",
        include_str!("../../headers/include/linux/sched.h"),
    ),
    (
        "linux/wait.h",
        include_str!("../../headers/include/linux/wait.h"),
    ),
    (
        "linux/memfd.h",
        include_str!("../../headers/include/linux/memfd.h"),
    ),
    (
        "linux/limits.h",
        include_str!("../../headers/include/linux/limits.h"),
    ),
    (
        "sys/auxv.h",
        include_str!("../../headers/include/sys/auxv.h"),
    ),
    (
        "sys/pidfd.h",
        include_str!("../../headers/include/sys/pidfd.h"),
    ),
    ("pty.h", include_str!("../../headers/include/pty.h")),
    ("utmp.h", include_str!("../../headers/include/utmp.h")),
    (
        "sys/timerfd.h",
        include_str!("../../headers/include/sys/timerfd.h"),
    ),
    (
        "sys/sendfile.h",
        include_str!("../../headers/include/sys/sendfile.h"),
    ),
    (
        "sys/eventfd.h",
        include_str!("../../headers/include/sys/eventfd.h"),
    ),
    (
        "sys/sysmacros.h",
        include_str!("../../headers/include/sys/sysmacros.h"),
    ),
    (
        "sys/xattr.h",
        include_str!("../../headers/include/sys/xattr.h"),
    ),
    (
        "sys/mount.h",
        include_str!("../../headers/include/sys/mount.h"),
    ),
    (
        "sys/statvfs.h",
        include_str!("../../headers/include/sys/statvfs.h"),
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
        "sys/resource.h",
        include_str!("../../headers/include/sys/resource.h"),
    ),
    ("wctype.h", include_str!("../../headers/include/wctype.h")),
    (
        "sys/ioctl.h",
        include_str!("../../headers/include/sys/ioctl.h"),
    ),
    (
        "sys/time.h",
        include_str!("../../headers/include/sys/time.h"),
    ),
    (
        "sys/times.h",
        include_str!("../../headers/include/sys/times.h"),
    ),
    ("termios.h", include_str!("../../headers/include/termios.h")),
    ("poll.h", include_str!("../../headers/include/poll.h")),
    (
        "malloc/malloc.h",
        include_str!("../../headers/include/malloc/malloc.h"),
    ),
    ("strings.h", include_str!("../../headers/include/strings.h")),
    ("libgen.h", include_str!("../../headers/include/libgen.h")),
    ("util.h", include_str!("../../headers/include/util.h")),
    ("glob.h", include_str!("../../headers/include/glob.h")),
    ("pthread.h", include_str!("../../headers/include/pthread.h")),
    (
        "semaphore.h",
        include_str!("../../headers/include/semaphore.h"),
    ),
    ("dlfcn.h", include_str!("../../headers/include/dlfcn.h")),
    ("fenv.h", include_str!("../../headers/include/fenv.h")),
    ("io.h", include_str!("../../headers/include/io.h")),
    ("direct.h", include_str!("../../headers/include/direct.h")),
    ("intrin.h", include_str!("../../headers/include/intrin.h")),
    ("bcrypt.h", include_str!("../../headers/include/bcrypt.h")),
    (
        "TargetConditionals.h",
        include_str!("../../headers/include/TargetConditionals.h"),
    ),
    (
        "AvailabilityMacros.h",
        include_str!("../../headers/include/AvailabilityMacros.h"),
    ),
    ("os/log.h", include_str!("../../headers/include/os/log.h")),
    ("windows.h", include_str!("../../headers/include/windows.h")),
    ("winbase.h", include_str!("../../headers/include/winbase.h")),
    (
        "winioctl.h",
        include_str!("../../headers/include/winioctl.h"),
    ),
    ("pathcch.h", include_str!("../../headers/include/pathcch.h")),
    ("psapi.h", include_str!("../../headers/include/psapi.h")),
    (
        "versionhelpers.h",
        include_str!("../../headers/include/versionhelpers.h"),
    ),
    ("crtdbg.h", include_str!("../../headers/include/crtdbg.h")),
    ("aclapi.h", include_str!("../../headers/include/aclapi.h")),
    ("lmcons.h", include_str!("../../headers/include/lmcons.h")),
    ("sddl.h", include_str!("../../headers/include/sddl.h")),
    ("shlwapi.h", include_str!("../../headers/include/shlwapi.h")),
    (
        "sys/locking.h",
        include_str!("../../headers/include/sys/locking.h"),
    ),
    (
        "wincrypt.h",
        include_str!("../../headers/include/wincrypt.h"),
    ),
    ("tchar.h", include_str!("../../headers/include/tchar.h")),
    (
        "winapifamily.h",
        include_str!("../../headers/include/winapifamily.h"),
    ),
    (
        "sdkddkver.h",
        include_str!("../../headers/include/sdkddkver.h"),
    ),
    ("cpuid.h", include_str!("../../headers/include/cpuid.h")),
    (
        "winerror.h",
        include_str!("../../headers/include/winerror.h"),
    ),
    ("process.h", include_str!("../../headers/include/process.h")),
    ("conio.h", include_str!("../../headers/include/conio.h")),
    (
        "winsock2.h",
        include_str!("../../headers/include/winsock2.h"),
    ),
    (
        "ws2tcpip.h",
        include_str!("../../headers/include/ws2tcpip.h"),
    ),
    ("mstcpip.h", include_str!("../../headers/include/mstcpip.h")),
    ("mswsock.h", include_str!("../../headers/include/mswsock.h")),
    (
        "iphlpapi.h",
        include_str!("../../headers/include/iphlpapi.h"),
    ),
    ("ws2bth.h", include_str!("../../headers/include/ws2bth.h")),
    ("Rpc.h", include_str!("../../headers/include/rpc.h")),
    ("rpc.h", include_str!("../../headers/include/rpc.h")),
    (
        "hvsocket.h",
        include_str!("../../headers/include/hvsocket.h"),
    ),
    (
        "pshpack1.h",
        include_str!("../../headers/include/pshpack1.h"),
    ),
    ("poppack.h", include_str!("../../headers/include/poppack.h")),
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
    fn header_declaring_finds_pread64() {
        // glibc large-file variants. sqlite's os_unix layer references
        // them by name under USE_PREAD64; without the prototype they are
        // implicitly declared and the address-of trampoline forwards no
        // arguments.
        assert_eq!(header_declaring("pread64"), Some("unistd.h"));
        assert_eq!(header_declaring("pwrite64"), Some("unistd.h"));
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
