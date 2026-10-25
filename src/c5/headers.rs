//! Embedded standard-style headers, served to the preprocessor's
//! `#include` machinery.
//!
//! Each entry is `include_str!`'d at build time, so the headers ship
//! inside the badc binary and the compiler doesn't need a filesystem
//! search path. The user writes `#include <stdio.h>` and the
//! preprocessor pulls the matching string out of [`embedded_header`].
//!
//! Each header `#ifdef`s on the target macros (`__APPLE__`, `__linux__`,
//! `_WIN32`) to pick the right `#pragma dylib(...)` and
//! `#pragma binding(...)`. Each entry also names the targets it is served
//! on: those whose C library, SDK or compiler ships the header, as
//! `libc/header-targets.txt` records them, plus the ones
//! `BEYOND_REFERENCE` gives a reason for. On any other target the name
//! is not found, as with the system compilers, so `__has_include` and
//! `#include` probes select the target's own interfaces.
//!
//! Adding a header: drop the file under `libc/include/`, add an entry to
//! [`EMBEDDED_HEADERS`], document the symbols it binds at the top of the
//! file, and measure its targets with `scripts/measure_header_targets.py`.

use crate::c5::codegen::Target;

/// A set of targets, one bit per [`Target`].
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub struct TargetSet(u8);

impl TargetSet {
    const fn of(target: Target) -> TargetSet {
        TargetSet(match target {
            Target::MacOSAarch64 => 1,
            Target::LinuxAarch64 => 2,
            Target::LinuxX64 => 4,
            Target::WindowsX64 => 8,
            Target::WindowsAarch64 => 16,
        })
    }

    pub(super) const fn or(self, other: TargetSet) -> TargetSet {
        TargetSet(self.0 | other.0)
    }

    pub fn contains(self, target: Target) -> bool {
        self.0 & TargetSet::of(target).0 != 0
    }
}

const MACOS: TargetSet = TargetSet::of(Target::MacOSAarch64);
const LINUX: TargetSet = TargetSet::of(Target::LinuxAarch64).or(TargetSet::of(Target::LinuxX64));
const WINDOWS: TargetSet =
    TargetSet::of(Target::WindowsX64).or(TargetSet::of(Target::WindowsAarch64));
const POSIX: TargetSet = MACOS.or(LINUX);
const ALL: TargetSet = POSIX.or(WINDOWS);
const X86_64: TargetSet = TargetSet::of(Target::LinuxX64).or(TargetSet::of(Target::WindowsX64));
const AARCH64: TargetSet = MACOS
    .or(TargetSet::of(Target::LinuxAarch64))
    .or(TargetSet::of(Target::WindowsAarch64));

/// The registry entry spelled `name` between the `#include` delimiters
/// (`"sys/syscall.h"`), whichever targets it is served on.
fn registry_entry(name: &str) -> Option<&'static (&'static str, TargetSet, &'static str)> {
    EMBEDDED_HEADERS.iter().find(|&&(n, _, _)| n == name)
}

/// The in-binary body of `name` for an `#include` on `target`, or `None`
/// when the registry lacks it or does not serve it there. A bundled
/// header including another (`from_bundled`) reaches every entry: the
/// bundled headers are written against each other, and `<winsock2.h>`
/// builds on `<sys/socket.h>` where the program is not served the
/// latter. `own_header` consults it after the on-disk header roots
/// wherever the include search reaches the bundled set, for either
/// include form. A name no search step resolves is a hard error, B1010,
/// raised by `finish_include`.
pub(super) fn embedded_header(
    name: &str,
    target: Target,
    from_bundled: bool,
) -> Option<&'static str> {
    let &(_, ts, body) = registry_entry(name)?;
    (from_bundled || ts.contains(target)).then_some(body)
}

/// Whether the registry carries `name` and does not serve it on `target`:
/// the program's `#include` of it is not part of the compiler's set
/// there, whichever header root holds a copy.
pub(super) fn withheld(name: &str, target: Target) -> bool {
    registry_entry(name).is_some_and(|&(_, ts, _)| !ts.contains(target))
}

/// The headers served on targets whose reference toolchain lacks them,
/// with those targets and the reason.
#[cfg(test)]
pub(super) const BEYOND_REFERENCE: &[(&str, TargetSet, &str)] = &[
    (
        "msvc_compat.h",
        ALL,
        "badc's own; a no-op off Windows, so one `-include msvc_compat.h` serves every target",
    ),
    (
        "dlfcn.h",
        WINDOWS,
        "libc/lib/dlfcn_ext.c defines dlopen, dlsym, dlclose and dlerror over kernel32",
    ),
    (
        "fnmatch.h",
        WINDOWS,
        "libc/lib/pattern.c defines fnmatch, which msvcrt lacks",
    ),
    (
        "regex.h",
        WINDOWS,
        "libc/lib/pattern.c defines regcomp, regexec, regerror and regfree",
    ),
];

/// Header names whose contents are part of the compiler implementation:
/// the intrinsic wrappers built on badc's own builtins and inline-asm
/// encoders. Another compiler's copy of such
/// a header is written against that compiler's builtins and can never
/// compile here, so when a build line puts a foreign toolchain's private
/// include directory on the search path (an `-isystem
/// $(cc -print-file-name=include)` folded into `-I`), these names must still
/// resolve to the embedded copy. They are also the set `-nostdinc` keeps:
/// that flag withdraws the standard library headers, as it does in gcc,
/// and leaves the compiler's own facilities in place. Ordinary headers keep
/// the usual order (`-I` shadows the embedded set, as it does in gcc and
/// clang). Each is served on the architecture whose instructions it wraps,
/// as gcc installs it.
pub(super) const COMPILER_OWNED_HEADERS: &[&str] = &[
    "arm_neon.h",
    "x86intrin.h",
    "immintrin.h",
    "xmmintrin.h",
    "emmintrin.h",
    "tmmintrin.h",
    "smmintrin.h",
    "wmmintrin.h",
];

/// Whether `name` is a compiler-owned intrinsic header.
pub(super) fn compiler_owned_header(name: &str) -> bool {
    COMPILER_OWNED_HEADERS.contains(&name)
}

/// All bundled headers, as `(name, targets, body)`. Public so the CLI's
/// `--dump-headers` and `--install` can write the registry out, for every
/// target, without reaching into the preprocessor.
pub fn embedded_headers() -> &'static [(&'static str, TargetSet, &'static str)] {
    EMBEDDED_HEADERS
}

/// A registry entry: the name, the targets it is served on and the body
/// of `libc/include/<file>`, `<file>` being the name unless given.
macro_rules! header {
    ($name:literal, $targets:expr) => {
        header!($name => $name, $targets)
    };
    ($name:literal => $file:literal, $targets:expr) => {
        ($name, $targets, include_str!(concat!("../../libc/include/", $file)))
    };
}

/// Every header the registry knows about, with the targets it is served
/// on.
pub(super) static EMBEDDED_HEADERS: &[(&str, TargetSet, &str)] = &[
    header!("arm_neon.h", AARCH64),
    header!("x86intrin.h", X86_64),
    header!("immintrin.h", X86_64),
    header!("xmmintrin.h", X86_64),
    header!("emmintrin.h", X86_64),
    header!("tmmintrin.h", X86_64),
    header!("smmintrin.h", X86_64),
    header!("wmmintrin.h", X86_64),
    header!("stdalign.h", ALL),
    header!("stddef.h", ALL),
    header!("stdint.h", ALL),
    header!("inttypes.h", ALL),
    header!("setjmp.h", ALL),
    header!("limits.h", ALL),
    header!("string.h", ALL),
    header!("sched.h", ALL),
    header!("spawn.h", POSIX),
    header!("stdio.h", ALL),
    header!("stdlib.h", ALL),
    header!("alloca.h", POSIX),
    header!("malloc.h", LINUX.or(WINDOWS)),
    header!("stdarg.h", ALL),
    header!("stdbool.h", ALL),
    header!("iso646.h", ALL),
    header!("stdnoreturn.h", ALL),
    header!("stdatomic.h", ALL),
    header!("ctype.h", ALL),
    header!("math.h", ALL),
    header!("tgmath.h", ALL),
    header!("float.h", ALL),
    header!("locale.h", ALL),
    header!("signal.h", ALL),
    header!("errno.h", ALL),
    header!("endian.h", LINUX),
    header!("byteswap.h", LINUX),
    header!("sys/endian.h", MACOS),
    header!("machine/endian.h", MACOS),
    header!("assert.h", ALL),
    header!("time.h", ALL),
    header!("utime.h", ALL),
    header!("sys/utime.h", WINDOWS),
    header!("netdb.h", POSIX),
    header!("err.h", POSIX),
    header!("ucontext.h", POSIX),
    header!("sys/ucontext.h", POSIX),
    header!("sys/prctl.h", LINUX),
    header!("sys/epoll.h", LINUX),
    header!("sys/signalfd.h", LINUX),
    header!("sys/reboot.h", POSIX),
    header!("sys/inotify.h", LINUX),
    header!("sys/utsname.h", POSIX),
    header!("sys/sysinfo.h", LINUX),
    header!("grp.h", POSIX),
    header!("langinfo.h", POSIX),
    header!("iconv.h", POSIX),
    header!("netinet/in.h", POSIX),
    header!("netinet/tcp.h", POSIX),
    header!("arpa/inet.h", POSIX),
    header!("dirent.h", ALL),
    header!("ftw.h", ALL),
    header!("fts.h", POSIX),
    header!("pwd.h", POSIX),
    header!("shadow.h", LINUX),
    header!("unistd.h", ALL),
    header!("getopt.h", ALL),
    header!("fcntl.h", ALL),
    header!("syslog.h", POSIX),
    header!("execinfo.h", POSIX),
    header!("sys/types.h", ALL),
    header!("sys/uio.h", POSIX),
    header!("sys/ipc.h", POSIX),
    header!("sys/shm.h", POSIX),
    header!("sys/sem.h", POSIX),
    header!("sys/msg.h", POSIX),
    header!("sys/queue.h", POSIX),
    header!("sys/un.h", POSIX),
    header!("net/if.h", POSIX),
    header!("net/ethernet.h", POSIX),
    header!("sys/file.h", ALL),
    header!("sys/errno.h", POSIX),
    header!("sys/cdefs.h", ALL),
    header!("CoreFoundation/CoreFoundation.h", MACOS),
    header!("CommonCrypto/CommonCryptoError.h", MACOS),
    header!("CommonCrypto/CommonRandom.h", MACOS),
    header!("CoreVideo/CoreVideo.h", MACOS),
    header!("CoreVideo/CVBase.h", MACOS),
    header!("CoreVideo/CVReturn.h", MACOS),
    header!("CoreVideo/CVHostTime.h", MACOS),
    header!("SystemConfiguration/SCDynamicStoreCopySpecific.h", MACOS),
    header!("sys/attr.h", MACOS),
    header!("libkern/OSByteOrder.h", MACOS),
    header!("sys/paths.h", MACOS),
    header!("sys/param.h", ALL),
    header!("sys/syslimits.h", MACOS),
    header!("copyfile.h", MACOS),
    header!("mach/mach_time.h", MACOS),
    header!("mach/mach.h", MACOS),
    header!("mach/task.h", MACOS),
    header!("mach/vm_statistics.h", MACOS),
    header!("mach/machine.h", MACOS),
    header!("mach/vm_prot.h", MACOS),
    header!("mach/vm_region.h", MACOS),
    header!("mach/mach_vm.h", MACOS),
    header!("libproc.h", MACOS),
    header!("sys/proc.h", MACOS),
    header!("sysexits.h", POSIX),
    header!("sys/sys_domain.h", MACOS),
    header!("sys/sysctl.h", MACOS),
    header!("mach-o/dyld.h", MACOS),
    header!("mach-o/loader.h", MACOS),
    header!("mach-o/fat.h", MACOS),
    header!("mach-o/nlist.h", MACOS),
    header!("sys/stat.h", ALL),
    header!("sys/mman.h", POSIX),
    header!("sys/random.h", POSIX),
    header!("sys/syscall.h", POSIX),
    header!("asm/unistd.h", LINUX),
    header!("linux/unistd.h", LINUX),
    header!("libintl.h", LINUX),
    header!("elf.h", LINUX),
    header!("link.h", LINUX),
    header!("linux/random.h", LINUX),
    header!("linux/auxvec.h", LINUX),
    header!("linux/fs.h", LINUX),
    header!("linux/sched.h", LINUX),
    header!("linux/wait.h", LINUX),
    header!("linux/memfd.h", LINUX),
    header!("linux/futex.h", LINUX),
    header!("linux/ioctl.h", LINUX),
    header!("linux/types.h", LINUX),
    header!("linux/limits.h", LINUX),
    header!("sys/auxv.h", LINUX),
    header!("sys/pidfd.h", LINUX),
    header!("pty.h", LINUX),
    header!("utmp.h", POSIX),
    header!("sys/timerfd.h", LINUX),
    header!("sys/sendfile.h", LINUX),
    header!("sys/eventfd.h", LINUX),
    header!("sys/sysmacros.h", LINUX),
    header!("sys/xattr.h", POSIX),
    header!("sys/mount.h", POSIX),
    header!("sys/statvfs.h", POSIX),
    header!("sys/vfs.h", LINUX),
    header!("sys/socket.h", POSIX),
    header!("sys/select.h", POSIX),
    header!("sys/wait.h", POSIX),
    header!("sys/resource.h", POSIX),
    header!("wctype.h", ALL),
    header!("sys/ioctl.h", POSIX),
    header!("sys/time.h", ALL),
    header!("sys/times.h", POSIX),
    header!("termios.h", POSIX),
    header!("poll.h", POSIX),
    header!("malloc/malloc.h", MACOS),
    header!("strings.h", ALL),
    header!("libgen.h", ALL),
    header!("util.h", MACOS),
    header!("glob.h", POSIX),
    header!("fnmatch.h", ALL),
    header!("regex.h", ALL),
    header!("pthread.h", ALL),
    header!("semaphore.h", ALL),
    header!("mqueue.h", LINUX),
    header!("aio.h", POSIX),
    header!("dlfcn.h", ALL),
    header!("fenv.h", ALL),
    header!("io.h", WINDOWS),
    header!("direct.h", WINDOWS),
    header!("intrin.h", WINDOWS),
    header!("bcrypt.h", WINDOWS),
    header!("TargetConditionals.h", MACOS),
    header!("AvailabilityMacros.h", MACOS),
    header!("os/log.h", MACOS),
    header!("os/lock.h", MACOS),
    header!("crt_externs.h", MACOS),
    header!("windows.h", WINDOWS),
    header!("winbase.h", WINDOWS),
    header!("stringapiset.h", WINDOWS),
    header!("intsafe.h", WINDOWS),
    header!("share.h", WINDOWS),
    header!("corecrt.h", WINDOWS),
    header!("winioctl.h", WINDOWS),
    header!("pathcch.h", WINDOWS),
    header!("psapi.h", WINDOWS),
    header!("versionhelpers.h", WINDOWS),
    header!("crtdbg.h", WINDOWS),
    header!("aclapi.h", WINDOWS),
    header!("lmcons.h", WINDOWS),
    header!("sddl.h", WINDOWS),
    header!("shlwapi.h", WINDOWS),
    header!("sys/locking.h", WINDOWS),
    header!("wincrypt.h", WINDOWS),
    header!("tchar.h", WINDOWS),
    header!("mbstring.h", WINDOWS),
    header!("mbctype.h", WINDOWS),
    header!("winapifamily.h", WINDOWS),
    header!("sdkddkver.h", WINDOWS),
    header!("cpuid.h", X86_64),
    header!("winerror.h", WINDOWS),
    header!("process.h", WINDOWS),
    header!("conio.h", WINDOWS),
    header!("winsock2.h", WINDOWS),
    header!("ws2tcpip.h", WINDOWS),
    header!("mstcpip.h", WINDOWS),
    header!("mswsock.h", WINDOWS),
    header!("iphlpapi.h", WINDOWS),
    header!("ws2bth.h", WINDOWS),
    header!("Rpc.h" => "rpc.h", WINDOWS),
    header!("rpc.h", WINDOWS),
    header!("hvsocket.h", WINDOWS),
    header!("pshpack1.h", WINDOWS),
    header!("pshpack2.h", WINDOWS),
    header!("pshpack4.h", WINDOWS),
    header!("wingdi.h", WINDOWS),
    header!("poppack.h", WINDOWS),
    header!("winternl.h", WINDOWS),
    header!("wchar.h", ALL),
    // Opt-in MSVC-shape predefines: no `#pragma binding`
    // here, just `#define _MSC_VER 1900`, `#define __int64 long
    // long`, the `__declspec(x)` family of empty-decorator
    // macros, etc. Build drivers that need to compile MSVC-
    // shaped C against the Windows backend opt in via
    // `badc -include msvc_compat.h ...`. Internally guarded by
    // `#ifdef _WIN32` so the same command line stays valid on
    header!("scsi/sg.h", LINUX),
    header!("linux/magic.h", LINUX),
    header!("linux/falloc.h", LINUX),
    header!("linux/ppdev.h", LINUX),
    header!("linux/parport.h", LINUX),
    header!("linux/vm_sockets.h", LINUX),
    header!("linux/time_types.h", LINUX),
    header!("linux/errqueue.h", LINUX),
    header!("linux/blkzoned.h", LINUX),
    header!("linux/cdrom.h", LINUX),
    header!("linux/dm-ioctl.h", LINUX),
    header!("linux/hdreg.h", LINUX),
    header!("linux/fd.h", LINUX),
    header!("linux/can.h", LINUX),
    header!("linux/can/raw.h", LINUX),
    header!("msvc_compat.h", ALL),
    // Legacy alias: <memory.h> predates POSIX's consolidation of
    // mem*/str* under <string.h>. The binding index leaves it out, so
    // the suggestion path names one header for a `mem*` symbol.
    header!("memory.h", ALL),
];

// Build-time-generated `&[(name, headers)]` sorted by name. Produced
// by `build.rs`'s `emit_binding_to_header_index`, which walks
// `libc/include/*.h` once per build and harvests every
// `#pragma binding(<dylib>::<name>, ...)` local symbol plus every
// file-scope function-prototype identifier. Each name's headers are
// in priority-then-lexicographic scan order.
include!(concat!(env!("OUT_DIR"), "/binding_to_header.rs"));

/// Look up a function name in the build-time-generated index and
/// return the first header declaring it that `target` is served, or
/// `None` for a name we don't recognise. O(log N) over the binding
/// index. Used by the compiler's "unknown function" diagnostic to
/// suggest the right `#include`, and by `Compiler::compile_with_options`
/// to drive the auto-include retry (force-include the header naming the
/// missing symbol, then re-compile).
pub(super) fn header_declaring(name: &str, target: Target) -> Option<&'static str> {
    (headers_declaring(name).iter().copied()).find(|h| !withheld(h, target))
}

/// Every header declaring `name`, in scan order -- the conventional
/// home first. A name can be bound to different libraries in
/// different headers (`_exit` to msvcrt in `<stdlib.h>`, to the C
/// library in `<unistd.h>`), so a caller resolving a binding for one
/// target has to see them all.
pub(super) fn headers_declaring(name: &str) -> &'static [&'static str] {
    BINDING_TO_HEADER
        .binary_search_by_key(&name, |&(n, _)| n)
        .ok()
        .map_or(&[], |i| BINDING_TO_HEADER[i].1)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn header_declaring_finds_printf_in_stdio() {
        assert_eq!(
            header_declaring("printf", Target::LinuxX64),
            Some("stdio.h")
        );
    }

    #[test]
    fn header_declaring_finds_malloc_in_stdlib() {
        assert_eq!(
            header_declaring("malloc", Target::LinuxX64),
            Some("stdlib.h")
        );
    }

    #[test]
    fn header_declaring_finds_strlen_in_string() {
        assert_eq!(
            header_declaring("strlen", Target::LinuxX64),
            Some("string.h")
        );
    }

    #[test]
    fn header_declaring_finds_pthread_create() {
        assert_eq!(
            header_declaring("pthread_create", Target::LinuxX64),
            Some("pthread.h")
        );
    }

    #[test]
    fn header_declaring_finds_socket() {
        assert_eq!(
            header_declaring("socket", Target::LinuxX64),
            Some("sys/socket.h")
        );
    }

    #[test]
    fn header_declaring_finds_pread64() {
        // glibc large-file variants. Some code references them by name
        // (e.g. under a USE_PREAD64 build flag); without the prototype they
        // are implicitly declared and the address-of trampoline forwards no
        // arguments.
        assert_eq!(
            header_declaring("pread64", Target::LinuxX64),
            Some("unistd.h")
        );
        assert_eq!(
            header_declaring("pwrite64", Target::LinuxX64),
            Some("unistd.h")
        );
    }

    #[test]
    fn header_declaring_finds_functions_a_header_defines() {
        // A library function a header provides as a `static inline`
        // definition rather than a prototype is found the same way.
        assert_eq!(
            header_declaring("copysign", Target::LinuxX64),
            Some("math.h")
        );
        assert_eq!(
            header_declaring("strnlen", Target::LinuxX64),
            Some("string.h")
        );
        assert_eq!(
            header_declaring("imaxabs", Target::LinuxX64),
            Some("inttypes.h")
        );
    }

    #[test]
    fn header_declaring_returns_none_for_unknown() {
        assert_eq!(
            header_declaring("definitely_not_in_any_header", Target::LinuxX64),
            None
        );
    }

    #[test]
    fn header_declaring_doesnt_match_prefix() {
        // `print` is not declared anywhere; it's a prefix of
        // `printf` but the trailing `(` and the binding ` ::printf,`
        // pattern guard against false hits.
        assert_eq!(header_declaring("print", Target::LinuxX64), None);
    }

    fn ids(set: TargetSet) -> alloc::vec::Vec<&'static str> {
        (Target::ALL.iter().filter(|t| set.contains(**t)))
            .map(|t| t.id_str())
            .collect()
    }

    /// Each entry is served on the targets whose reference toolchain ships
    /// it -- the `y` and `p` cells of `libc/header-targets.txt`, which
    /// `scripts/measure_header_targets.py` writes -- and on those
    /// `BEYOND_REFERENCE` gives a reason for, which the reference lacks.
    #[test]
    fn target_sets_match_the_measured_reference() {
        const TABLE: &str = include_str!("../../libc/header-targets.txt");
        let columns: alloc::vec::Vec<Target> = (TABLE.lines())
            .find_map(|l| l.strip_prefix("# name\t"))
            .expect("the table names its columns")
            .split('\t')
            .map(|id| Target::parse(Some(id)).expect("a target id"))
            .collect();
        let mut rows = alloc::collections::BTreeMap::new();
        for line in TABLE.lines().filter(|l| !l.starts_with('#')) {
            let mut cells = line.split('\t');
            let name = cells.next().expect("a name");
            let measured = (columns.iter().zip(cells))
                .filter(|(_, cell)| matches!(*cell, "y" | "p"))
                .fold(TargetSet(0), |set, (t, _)| set.or(TargetSet::of(*t)));
            rows.insert(name, measured);
        }
        let mut failures = alloc::vec::Vec::new();
        for &(name, targets, _) in embedded_headers() {
            let Some(measured) = rows.remove(name) else {
                failures.push(alloc::format!("{name}: no measurement"));
                continue;
            };
            let beyond = (BEYOND_REFERENCE.iter().filter(|e| e.0 == name))
                .fold(TargetSet(0), |set, e| set.or(e.1));
            if beyond.0 & measured.0 != 0 {
                failures.push(alloc::format!(
                    "{name}: a reason recorded where the reference ships it"
                ));
            }
            if targets != measured.or(beyond) {
                failures.push(alloc::format!(
                    "{name}: served on {:?}, measured {:?}, beyond the reference {:?}",
                    ids(targets),
                    ids(measured),
                    ids(beyond)
                ));
            }
        }
        failures.extend(
            rows.keys()
                .map(|n| alloc::format!("{n}: measured, not in the registry")),
        );
        assert!(failures.is_empty(), "{}", failures.join("\n"));
    }

    /// Every registry header compiles alone, with and without `_GNU_SOURCE`,
    /// on every target it is served on, and is not found on the others.
    #[test]
    fn every_embedded_header_compiles_where_it_is_served() {
        use crate::{CompileOptions, Compiler, Target};
        let mut failures = alloc::vec::Vec::new();
        for target in Target::ALL {
            for &(name, targets, _) in embedded_headers() {
                for prefix in ["", "#define _GNU_SOURCE 1\n"] {
                    let src = alloc::format!("{prefix}#include <{name}>\n");
                    let opts = CompileOptions::default().with_no_entry_point(true);
                    let result = Compiler::with_options(src, target, opts).compile();
                    let fine = match &result {
                        Ok(_) => targets.contains(target),
                        Err(e) => {
                            !targets.contains(target) && alloc::format!("{e}").contains("[B1010]")
                        }
                    };
                    if !fine {
                        let msg = result
                            .err()
                            .map(|e| alloc::format!("{e}"))
                            .unwrap_or_default();
                        failures.push(alloc::format!(
                            "{} <{name}> {prefix:?}: {msg}",
                            target.id_str()
                        ));
                    }
                }
            }
        }
        assert!(failures.is_empty(), "{}", failures.join("\n"));
    }

    /// The C99 library functions a target lacked a declaration for are
    /// declared on every target with the standard type (C99 7.12, 7.19.6.14).
    #[test]
    fn c99_functions_are_declared_on_every_target() {
        use crate::{CompileOptions, Compiler, Target};
        const DECLS: &[(&str, &str)] = &[
            ("sinhf", "float (*)(float)"),
            ("coshf", "float (*)(float)"),
            ("tanhf", "float (*)(float)"),
            ("log2f", "float (*)(float)"),
            ("exp2f", "float (*)(float)"),
            ("frexpf", "float (*)(float, int *)"),
            ("ldexpf", "float (*)(float, int)"),
            ("modff", "float (*)(float, float *)"),
            ("lrintf", "long (*)(float)"),
            ("llrintf", "long long (*)(float)"),
            ("lroundf", "long (*)(float)"),
            ("llroundf", "long long (*)(float)"),
            ("vsscanf", "int (*)(const char *, const char *, va_list)"),
        ];
        let mut src = alloc::string::String::from(
            "#include <math.h>\n#include <stdarg.h>\n#include <stdio.h>\n",
        );
        for (name, ty) in DECLS {
            src.push_str(&alloc::format!(
                "_Static_assert(_Generic(&{name}, {ty}: 1, default: 0), \"{name}\");\n"
            ));
        }
        for target in Target::ALL {
            let opts = CompileOptions::default().with_no_entry_point(true);
            if let Err(e) = Compiler::with_options(src.clone(), target, opts).compile() {
                panic!("{}: {e}", target.id_str());
            }
        }
    }

    /// The POSIX declarations take POSIX's types on the Linux and macOS
    /// targets, as glibc's and Darwin's headers give them.
    #[test]
    fn posix_declarations_take_posix_types() {
        use crate::{CompileOptions, Compiler, Target};
        const DECLS: &[(&str, &str)] = &[
            ("&dlopen", "void *(*)(const char *, int)"),
            ("&dlsym", "void *(*)(void *, const char *)"),
            ("&dlclose", "int (*)(void *)"),
            ("&truncate", "int (*)(const char *, off_t)"),
            ("&ftruncate", "int (*)(int, off_t)"),
            ("&umask", "mode_t (*)(mode_t)"),
            ("&chmod", "int (*)(const char *, mode_t)"),
            ("&fchmod", "int (*)(int, mode_t)"),
            ("&mkdir", "int (*)(const char *, mode_t)"),
            ("&usleep", "int (*)(useconds_t)"),
            ("(id_t)0", "unsigned int"),
            ("(useconds_t)0", "unsigned int"),
            ("(socklen_t)0", "unsigned int"),
        ];
        for (target, mode) in [
            (Target::LinuxX64, "unsigned int"),
            (Target::LinuxAarch64, "unsigned int"),
            (Target::MacOSAarch64, "unsigned short"),
        ] {
            let mut src = alloc::string::String::from(
                "#include <dlfcn.h>\n#include <sys/types.h>\n#include <unistd.h>\n",
            );
            let mode_row = [("(mode_t)0", mode)];
            for (expr, ty) in DECLS.iter().chain(&mode_row) {
                src.push_str(&alloc::format!(
                    "_Static_assert(_Generic({expr}, {ty}: 1, default: 0), \"{expr}\");\n"
                ));
            }
            let opts = CompileOptions::default().with_no_entry_point(true);
            if let Err(e) = Compiler::with_options(src, target, opts).compile() {
                panic!("{}: {e}", target.id_str());
            }
        }
    }

    /// The C99 and POSIX functions of no parameters are declared with a
    /// prototype, so a call passing an argument is diagnosed (C99
    /// 6.5.2.2p2), and the POSIX id functions return uid_t, gid_t and pid_t,
    /// the ids unsigned on Linux and macOS as their C libraries have them.
    #[test]
    fn parameterless_library_functions_are_prototyped() {
        use crate::{CompileOptions, Compiler, Target};
        let c99 = ["getchar", "rand", "clock", "errno_location", "abort"];
        let posix = [
            "getuid",
            "geteuid",
            "getgid",
            "getegid",
            "getpid",
            "getppid",
            "fork",
            "vfork",
            "sync",
            "dlerror",
            "pthread_self",
            "getpwent",
            "setpwent",
            "endpwent",
        ];
        let shadow = ["getspent", "setspent", "endspent"];
        for target in Target::ALL {
            let posix_target = !target.is_windows();
            let linux = matches!(target, Target::LinuxX64 | Target::LinuxAarch64);
            let mut src = alloc::string::String::from(
                "#include <errno.h>\n#include <stdio.h>\n#include <stdlib.h>\n#include <time.h>\n",
            );
            let mut names: alloc::vec::Vec<&str> = alloc::vec::Vec::new();
            if posix_target {
                src.push_str(
                    "#include <dlfcn.h>\n#include <pthread.h>\n#include <pwd.h>\n\
                     #include <unistd.h>\n\
                     _Static_assert((uid_t)-1 > 0 && (gid_t)-1 > 0, \"unsigned ids\");\n\
                     _Static_assert(_Generic(getuid(), uid_t: 1, default: 0)\n\
                       && _Generic(geteuid(), uid_t: 1, default: 0)\n\
                       && _Generic(getgid(), gid_t: 1, default: 0)\n\
                       && _Generic(getegid(), gid_t: 1, default: 0)\n\
                       && _Generic(getpid(), pid_t: 1, default: 0)\n\
                       && _Generic(fork(), pid_t: 1, default: 0), \"id types\");\n",
                );
                names.extend(posix);
            }
            if linux {
                src.push_str("#include <shadow.h>\n");
                names.extend(shadow);
            }
            names.extend(c99);
            src.push_str("void calls(void) {\n");
            for name in &names {
                src.push_str(&alloc::format!("    (void){name}(0);\n"));
            }
            src.push_str("}\n");
            let opts = CompileOptions::default().with_no_entry_point(true);
            let program = Compiler::with_options(src.clone(), target, opts)
                .compile()
                .unwrap_or_else(|e| panic!("{}: {e}\n{src}", target.id_str()));
            let warnings: alloc::vec::Vec<_> =
                program.warnings.iter().map(|w| w.to_string()).collect();
            for name in &names {
                let text = alloc::format!(
                    "too many arguments to `{name}` (expected 0, got at least 1) [B3005]"
                );
                assert!(
                    warnings.iter().any(|w| w.contains(&text)),
                    "{}: {name}: {warnings:?}",
                    target.id_str()
                );
            }
        }
    }

    /// The Windows CRT block declares its entry points with the SDK's
    /// prototypes -- a call with one argument too many is diagnosed against
    /// the declared count -- and msvcrt's `__argc`, `__argv` and `__wargv`
    /// as the objects they are, which a reference reads through the import.
    #[test]
    fn windows_crt_declarations_are_prototypes() {
        use crate::{CompileOptions, Compiler, Target};
        const FNS: &[(&str, usize)] = &[
            ("localtime_s", 2),
            ("gmtime_s", 2),
            ("ctime_s", 3),
            ("asctime_s", 3),
            ("strerror_s", 3),
            ("_strdup", 1),
            ("_strnicmp", 3),
            ("_stricmp", 2),
            ("_get_errno", 1),
            ("_set_errno", 1),
            ("_errno", 0),
            ("__getmainargs", 5),
            ("_getch", 0),
            ("_kbhit", 0),
            ("_getpid", 0),
            ("__iob_func", 0),
            ("WSACleanup", 0),
        ];
        for target in [Target::WindowsX64, Target::WindowsAarch64] {
            let mut src = alloc::string::String::from(
                "#include <stdio.h>\n#include <string.h>\n#include <conio.h>\n\
                 #include <winsock2.h>\n\
                 _Static_assert(_Generic(&__argc, int *: 1, default: 0)\n\
                   && _Generic(&__argv, char ***: 1, default: 0)\n\
                   && _Generic(&__wargv, wchar_t ***: 1, default: 0), \"data exports\");\n\
                 void calls(void) {\n",
            );
            for (name, n) in FNS {
                let args = alloc::vec!["0"; n + 1].join(", ");
                src.push_str(&alloc::format!("    (void){name}({args});\n"));
            }
            src.push_str("}\n");
            let opts = CompileOptions::default().with_no_entry_point(true);
            let program = Compiler::with_options(src.clone(), target, opts)
                .compile()
                .unwrap_or_else(|e| panic!("{}: {e}\n{src}", target.id_str()));
            let warnings: alloc::vec::Vec<_> =
                program.warnings.iter().map(|w| w.to_string()).collect();
            for (name, n) in FNS {
                let text = alloc::format!(
                    "too many arguments to `{name}` (expected {n}, got at least {})",
                    n + 1
                );
                assert!(
                    warnings.iter().any(|w| w.contains(&text)),
                    "{}: {name}: {warnings:?}",
                    target.id_str()
                );
            }
        }
    }

    /// A program may repeat the C99 and POSIX prototypes after the bundled
    /// headers on every target with no redeclaration diagnostic.
    #[test]
    fn standard_redeclarations_compose_with_the_bundled_headers() {
        use crate::c5::diag::Code;
        use crate::{CompileOptions, Compiler, Target};
        const SRC: &str = include_str!("../../tests/fixtures/libc/standard_prototypes.h");
        let mut failures = alloc::vec::Vec::new();
        for target in Target::ALL {
            let opts = CompileOptions::default().with_no_entry_point(true);
            match Compiler::with_options(SRC.into(), target, opts).compile() {
                Err(err) => failures.push(alloc::format!("{}: {err}", target.id_str())),
                Ok(program) => failures.extend(
                    program
                        .warnings
                        .iter()
                        .filter(|w| w.code == Code::REDECLARATION_MISMATCH)
                        .map(|w| alloc::format!("{}: {w}", target.id_str())),
                ),
            }
        }
        assert!(failures.is_empty(), "{}", failures.join("\n"));
    }

    /// A program may repeat the Win32 prototypes after the bundled
    /// `<windows.h>` with the SDK's types, spelled through the SDK's
    /// typedefs or out in full, with no redeclaration
    /// diagnostic on either Windows target.
    #[test]
    fn win32_redeclarations_compose_with_the_bundled_windows_h() {
        use crate::c5::diag::Code;
        use crate::{CompileOptions, Compiler, Target};
        const SRC: &str = include_str!("../../tests/fixtures/libc/win32_prototypes.h");
        let mut failures = alloc::vec::Vec::new();
        for target in [Target::WindowsX64, Target::WindowsAarch64] {
            let opts = CompileOptions::default().with_no_entry_point(true);
            match Compiler::with_options(SRC.into(), target, opts).compile() {
                Err(err) => failures.push(alloc::format!("{}: {err}", target.id_str())),
                Ok(program) => failures.extend(
                    program
                        .warnings
                        .iter()
                        .filter(|w| w.code == Code::REDECLARATION_MISMATCH)
                        .map(|w| alloc::format!("{}: {w}", target.id_str())),
                ),
            }
        }
        assert!(failures.is_empty(), "{}", failures.join("\n"));
    }
}
