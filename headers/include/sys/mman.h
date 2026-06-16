// sys/mman.h -- memory protection flags.

#pragma once

#define PROT_NONE  0
#define PROT_READ  1
#define PROT_WRITE 2
#define PROT_EXEC  4

#define MAP_SHARED    0x01
#define MAP_PRIVATE   0x02
#define MAP_FIXED     0x10
// The anonymous-mapping flag diverges: macOS uses 0x1000, Linux 0x20.
// The value reaches the host's mmap, so a wrong one drops MAP_ANON and
// the call fails with the fd interpreted as a real file.
#ifdef __APPLE__
#define MAP_ANON      0x1000
#define MAP_ANONYMOUS 0x1000
#else
#define MAP_ANON      0x20
#define MAP_ANONYMOUS 0x20
#endif
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
// `mremap` flags (Linux-only call).
#define MREMAP_MAYMOVE   1
#define MREMAP_FIXED     2
#define MREMAP_DONTUNMAP 4
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::mmap,     "mmap")
#pragma binding(libc::munmap,   "munmap")
#pragma binding(libc::mremap,   "mremap")
#pragma binding(libc::msync,    "msync")
#pragma binding(libc::mprotect, "mprotect")
#endif

// POSIX: the mapping length is size_t and the file offset is off_t, both
// 64-bit. An `int` length/offset truncates a mapping at or past 2GB.
// `long` / `unsigned long` match off_t / size_t on LP64 (this block's
// POSIX targets).
char *mmap(char *addr, unsigned long len, int prot, int flags, int fd, long offset);
int munmap(char *addr, unsigned long len);
char *mremap(char *old, unsigned long old_size, unsigned long new_size, int flags);
int msync(char *addr, unsigned long len, int flags);
int mprotect(char *addr, unsigned long len, int prot);
