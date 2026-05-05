// sys/mman.h -- memory protection flags.
//
// Just the `PROT_*` bits, which line up across POSIX (used by
// `mprotect`) and Win32 (used as the flags arg to `VirtualProtect`
// once you mask through to PAGE_*). c4 never had `mprotect` as a
// first-class op, so anyone exercising memory protection reaches
// for `dlsym` and these flags.

#pragma once

#define PROT_NONE  0
#define PROT_READ  1
#define PROT_WRITE 2
#define PROT_EXEC  4

#define MAP_SHARED    0x01
#define MAP_PRIVATE   0x02
#define MAP_FIXED     0x10
#define MAP_ANONYMOUS 0x20
#define MAP_FAILED    ((void*)-1)

#define MS_ASYNC      1
#define MS_SYNC       4
#define MS_INVALIDATE 2

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::mmap,     "_mmap")
#pragma binding(libc::munmap,   "_munmap")
#pragma binding(libc::mremap,   "_mremap")
#pragma binding(libc::msync,    "_msync")
#pragma binding(libc::mprotect, "_mprotect")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::mmap,     "mmap")
#pragma binding(libc::munmap,   "munmap")
#pragma binding(libc::mremap,   "mremap")
#pragma binding(libc::msync,    "msync")
#pragma binding(libc::mprotect, "mprotect")
#endif

char *mmap(char *addr, int len, int prot, int flags, int fd, int offset);
int munmap(char *addr, int len);
char *mremap(char *old, int old_size, int new_size, int flags);
int msync(char *addr, int len, int flags);
int mprotect(char *addr, int len, int prot);
