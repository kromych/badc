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
#ifndef _C5_SYS_TYPES_H
#define _C5_SYS_TYPES_H

typedef long ssize_t;
typedef long off_t;
typedef long off64_t;
typedef long loff_t;
typedef int pid_t;
typedef int uid_t;
typedef int gid_t;
typedef int mode_t;
typedef int dev_t;
typedef long ino_t;
typedef long ino64_t;
typedef int nlink_t;
typedef int blksize_t;
typedef long blkcnt_t;
typedef long blkcnt64_t;
typedef int id_t;
typedef int useconds_t;
typedef int suseconds_t;
typedef int clockid_t;
typedef int timer_id_t;
typedef long fsblkcnt_t;
typedef long fsfilcnt_t;
typedef int socklen_t;
typedef int key_t;

#endif
