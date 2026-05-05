// sys/types.h -- POSIX-style fundamental scalar typedefs.
//
// All collapse to plain `int` in c5 (every integer is the 64-bit
// machine word). Real libc has separate widths per type; programs
// that pass these through libc bindings get the right semantics
// because the underlying syscall reads only the byte range it
// cares about.
#ifndef _C5_SYS_TYPES_H
#define _C5_SYS_TYPES_H

typedef int ssize_t;
typedef int off_t;
typedef int off64_t;
typedef int loff_t;
typedef int pid_t;
typedef int uid_t;
typedef int gid_t;
typedef int mode_t;
typedef int dev_t;
typedef int ino_t;
typedef int ino64_t;
typedef int nlink_t;
typedef int blksize_t;
typedef int blkcnt_t;
typedef int blkcnt64_t;
typedef int id_t;
typedef int useconds_t;
typedef int suseconds_t;
typedef int clockid_t;
typedef int timer_id_t;
typedef int fsblkcnt_t;
typedef int fsfilcnt_t;
typedef int socklen_t;
typedef int key_t;

#endif
