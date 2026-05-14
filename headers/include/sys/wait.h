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

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::wait,    "_wait")
#pragma binding(libc::waitpid, "_waitpid")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::wait,    "wait")
#pragma binding(libc::waitpid, "waitpid")
#endif

#ifdef _WIN32
// Windows has no fork(2) / wait(2) family. Programs that drive
// a child process there go through CreateProcess +
// WaitForSingleObject instead.
#endif

int wait(int *status);
int waitpid(int pid, int *status, int options);
