// sys/wait.h -- POSIX process-exit collection.
//
// Programs that fork(2)/execvp(2) collect the child's exit
// status here. The `W*` decode macros operate on the int value
// the kernel writes through the `status` pointer.

#pragma once

#include <stddef.h>

// POSIX bit layout of wait(2)'s status integer:
//   bits 7..0  -- low byte:
//       low 7 bits = signal number that killed the child, or 0
//                    for a normal exit;
//       bit 7      = "core dumped" flag (signals only).
//   bits 15..8 -- high byte: WEXITSTATUS for normal exits.
//   bit 16 onward (Linux ptrace etc.) is implementation-defined
//   and not exposed here.
#define WEXITSTATUS(s)  (((s) >> 8) & 0xff)
#define WTERMSIG(s)     ((s) & 0x7f)
#define WIFEXITED(s)    (((s) & 0x7f) == 0)
#define WIFSIGNALED(s)  ((((s) & 0x7f) + 1) >> 1 > 0)
#define WCOREDUMP(s)    ((s) & 0x80)
#define WIFSTOPPED(s)   (((s) & 0xff) == 0x7f)
#define WSTOPSIG(s)     WEXITSTATUS(s)

// waitpid(2) options.
#define WNOHANG    1
#define WUNTRACED  2

#if defined(__APPLE__) || defined(__linux__)
// waitid(2): which children to wait for. `id_t` (a pid or pgid) comes
// from <sys/types.h>.
#include <sys/types.h>
typedef enum { P_ALL, P_PID, P_PGID } idtype_t;

// `options` flags for waitid(2). The numbering is target-specific
// because the value reaches the host libc.
#ifdef __APPLE__
#define WEXITED    0x04
#define WSTOPPED   0x08
#define WCONTINUED 0x10
#define WNOWAIT    0x20
#else
#define WEXITED    0x04
#define WSTOPPED   0x02
#define WCONTINUED 0x08
#define WNOWAIT    0x01000000
#endif

// siginfo_t carries the child's exit details waitid writes. The kernel
// fills it, so the leading fields must sit at the host's offsets; the
// trailing padding covers the platform's full size (macOS 104 B, Linux
// glibc 128 B). On 64-bit Linux a pad word aligns the id fields to 16.
#ifdef __APPLE__
typedef struct {
    int          si_signo;
    int          si_errno;
    int          si_code;
    int          si_pid;
    unsigned int si_uid;
    int          si_status;
    unsigned char __pad[104 - 24];
} siginfo_t;
#else
typedef struct {
    int          si_signo;
    int          si_errno;
    int          si_code;
    int          __pad0;
    int          si_pid;
    unsigned int si_uid;
    int          si_status;
    unsigned char __pad[128 - 28];
} siginfo_t;
#endif
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::wait,    "_wait")
#pragma binding(libc::waitpid, "_waitpid")
#pragma binding(libc::waitid,  "_waitid")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::wait,    "wait")
#pragma binding(libc::waitpid, "waitpid")
#pragma binding(libc::waitid,  "waitid")
#endif

#ifdef _WIN32
// Windows has no fork(2) / wait(2) family. Programs that drive
// a child process there go through CreateProcess +
// WaitForSingleObject instead.
#endif

int wait(int *status);
int waitpid(int pid, int *status, int options);
#if defined(__APPLE__) || defined(__linux__)
int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
#endif
