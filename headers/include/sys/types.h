// sys/types.h -- POSIX-style fundamental scalar typedefs.
//
// Width-sensitive types (`ssize_t`, `off_t`, byte counts) are
// pointer-wide so libc routines that take them through their
// natural register slot don't see truncation -- e.g.
// `read(fd, buf, BIG)` was silently passing a 4-byte length
// before #52 lifted these to `long`. Smaller scalar types
// (uid_t, mode_t, ...) keep `int` since their on-disk shape is
// 4 bytes everywhere and their c5-side stack slot is 8 bytes
// either way.
//
// On Windows we're LLP64, so `long` is 32 bits. The byte-count
// and offset types have to switch to `long long` to keep the
// 8-byte width that the Windows ABI / UCRT expects (e.g.
// `_off64_t`, `__time64_t`, `size_t`).
#ifndef _C5_SYS_TYPES_H
#define _C5_SYS_TYPES_H

/* POSIX-2017 requires `<sys/types.h>` to make `size_t` visible.
** In c5 the canonical declaration lives in `<stddef.h>`; pulling
** it in transitively lets `<unistd.h>` (which includes this
** header) deliver `size_t` alongside `ssize_t` / `off_t` /
** `pid_t` without each caller needing a separate `<stddef.h>`. */
#include <stddef.h>

#ifdef __BADC_WINDOWS__
typedef long long ssize_t;
typedef long long off_t;
typedef long long off64_t;
typedef long long loff_t;
#else
typedef long ssize_t;
typedef long off_t;
typedef long off64_t;
typedef long loff_t;
#endif
typedef int pid_t;
typedef int uid_t;
typedef int gid_t;
typedef int mode_t;
typedef int dev_t;
// BSD fixed-width unsigned aliases. Present on Linux and macOS; some
// platform sources (macOS file-attribute code) use them directly.
typedef unsigned char u_int8_t;
typedef unsigned short u_int16_t;
typedef unsigned int u_int32_t;
typedef unsigned long long u_int64_t;
#ifdef __BADC_WINDOWS__
typedef long long ino_t;
typedef long long ino64_t;
#else
typedef long ino_t;
typedef long ino64_t;
#endif
typedef int nlink_t;
typedef int blksize_t;
#ifdef __BADC_WINDOWS__
typedef long long blkcnt_t;
typedef long long blkcnt64_t;
#else
typedef long blkcnt_t;
typedef long blkcnt64_t;
#endif
typedef int id_t;
typedef int useconds_t;
typedef int suseconds_t;
typedef int clockid_t;
typedef int timer_id_t;
#ifdef __BADC_WINDOWS__
typedef long long fsblkcnt_t;
typedef long long fsfilcnt_t;
#else
typedef long fsblkcnt_t;
typedef long fsfilcnt_t;
#endif
typedef int socklen_t;
typedef int key_t;

/* glibc's <sys/types.h> makes `fd_set` and the `FD_*` macros visible
** (under __USE_MISC, on by default), so POSIX code that reaches select()
** through <sys/types.h> alone -- without <sys/select.h> and without a
** configure-detected HAVE_SYS_SELECT_H -- still sees the type. The
** select surface is POSIX; on Windows `fd_set` comes from ws2_32, so
** the transitive include is gated off there. <sys/select.h> guards with
** `#pragma once`, so a direct include elsewhere stays a no-op. */
#ifndef __BADC_WINDOWS__
#include <sys/select.h>
#endif

#endif
