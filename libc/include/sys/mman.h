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
#define MAP_NORESERVE 0x40
#else
#define MAP_ANON      0x20
#define MAP_ANONYMOUS 0x20
// Linux (asm-generic/mman-common.h + mman.h) placement flags.
#define MAP_GROWSDOWN 0x0100
#define MAP_LOCKED    0x2000
#define MAP_NORESERVE 0x4000
#define MAP_POPULATE  0x8000
#define MAP_NONBLOCK  0x10000
#define MAP_STACK     0x20000
#define MAP_HUGETLB   0x40000
#endif
#define MAP_FAILED    ((void*)-1)

#define MS_ASYNC      1
#define MS_SYNC       4
#define MS_INVALIDATE 2

// mlockall() flags. MCL_CURRENT / MCL_FUTURE share values across the POSIX
// targets; MCL_ONFAULT is Linux-only.
#define MCL_CURRENT 1
#define MCL_FUTURE  2
#ifdef __linux__
#define MCL_ONFAULT 4
#endif

// madvise advice values shared by the POSIX targets; the caller guards each
// on #ifdef. MADV_FREE diverges (macOS 5, Linux 8).
#define MADV_NORMAL     0
#define MADV_RANDOM     1
#define MADV_SEQUENTIAL 2
#define MADV_WILLNEED   3
#define MADV_DONTNEED   4
#ifdef __APPLE__
#define MADV_FREE 5
#else
#define MADV_FREE 8
// Linux-specific madvise advice (asm-generic/mman-common.h).
#define MADV_REMOVE      9
#define MADV_DONTFORK    10
#define MADV_DOFORK      11
#define MADV_MERGEABLE   12
#define MADV_UNMERGEABLE 13
#define MADV_HUGEPAGE    14
#define MADV_NOHUGEPAGE  15
#define MADV_DONTDUMP    16
#define MADV_DODUMP      17
#define MADV_WIPEONFORK  18
#define MADV_KEEPONFORK  19
#define MADV_COLD        20
#define MADV_PAGEOUT     21
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::mmap,     "_mmap")
#pragma binding(libc::munmap,   "_munmap")
// mremap is Linux-only; unbound here so a use fails at link.
#pragma binding(libc::msync,    "_msync")
#pragma binding(libc::mprotect, "_mprotect")
#pragma binding(libc::madvise,    "_madvise")
#pragma binding(libc::mincore,    "_mincore")
#pragma binding(libc::shm_open,   "_shm_open")
#pragma binding(libc::shm_unlink, "_shm_unlink")
#pragma binding(libc::mlockall,   "_mlockall")
#pragma binding(libc::munlockall, "_munlockall")
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
#pragma binding(libc::madvise,    "madvise")
#pragma binding(libc::mincore,    "mincore")
#pragma binding(libc::shm_open,   "shm_open")
#pragma binding(libc::shm_unlink, "shm_unlink")
#pragma binding(libc::mlockall,   "mlockall")
#pragma binding(libc::munlockall, "munlockall")
#pragma binding(libc::memfd_create, "memfd_create")
// The MFD_* flags live in their canonical kernel header.
#include <linux/memfd.h>
int memfd_create(const char *name, unsigned int flags);
#endif

// POSIX: the mapping length is size_t and the file offset is off_t, both
// 64-bit. An `int` length/offset truncates a mapping at or past 2GB.
// `long` / `unsigned long` match off_t / size_t on LP64 (this block's
// POSIX targets).
char *mmap(char *addr, unsigned long len, int prot, int flags, int fd, long offset);
int munmap(char *addr, unsigned long len);
// Report which pages of a mapping are resident; `vec` gets one byte per page.
int mincore(char *addr, unsigned long len, unsigned char *vec);
char *mremap(char *old, unsigned long old_size, unsigned long new_size, int flags);
int msync(char *addr, unsigned long len, int flags);
int mprotect(char *addr, unsigned long len, int prot);
int madvise(char *addr, unsigned long len, int advice);
// POSIX shared memory objects; mode is mode_t (an unsigned int on the
// targets). Darwin declares shm_open variadic and reads the mode via
// va_arg (from the stack on arm64), so the prototype must match; glibc
// declares the fixed three-argument POSIX shape.
#ifdef __APPLE__
int shm_open(const char *name, int oflag, ...);
#else
int shm_open(const char *name, int oflag, int mode);
#endif
int shm_unlink(const char *name);
// Lock/unlock the whole address space (POSIX); flags are the MCL_* set.
int mlockall(int flags);
int munlockall(void);
