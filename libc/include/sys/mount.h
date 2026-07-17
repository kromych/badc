// sys/mount.h -- mount-flag constants (macOS / BSD) and the Linux mount(2)
// interface (MS_* flags plus mount / umount / umount2).

#pragma once

#ifdef __APPLE__
// Filesystem mount flags reported by statfs(2). Only the bits programs
// translate into the portable statvfs ST_* set are defined here.
#define MNT_RDONLY      0x00000001
#define MNT_SYNCHRONOUS 0x00000002
#define MNT_NOEXEC      0x00000004
#define MNT_NOSUID      0x00000008
#define MNT_NODEV       0x00000010
#define MNT_LOCAL       0x00001000
#define MNT_QUOTA       0x00002000
#define MNT_RDWR        0x00000000
#endif

#ifdef __linux__
// mount(2) flags (Linux sys/mount.h).
#define MS_RDONLY      1
#define MS_NOSUID      2
#define MS_NODEV       4
#define MS_NOEXEC      8
#define MS_SYNCHRONOUS 16
#define MS_REMOUNT     32
#define MS_MANDLOCK    64
#define MS_DIRSYNC     128
#define MS_NOSYMFOLLOW 256
#define MS_NOATIME     1024
#define MS_NODIRATIME  2048
#define MS_BIND        4096
#define MS_MOVE        8192
#define MS_REC         16384
#define MS_SILENT      32768
#define MS_UNBINDABLE  (1 << 17)
#define MS_PRIVATE     (1 << 18)
#define MS_SLAVE       (1 << 19)
#define MS_SHARED      (1 << 20)
#define MS_RELATIME    (1 << 21)
#define MS_STRICTATIME (1 << 24)
#define MS_LAZYTIME    (1 << 25)

// umount2() behavior flags.
#define MNT_FORCE       1
#define MNT_DETACH      2
#define MNT_EXPIRE      4
#define UMOUNT_NOFOLLOW 8

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::mount,   "mount")
#pragma binding(libc::umount,  "umount")
#pragma binding(libc::umount2, "umount2")
// The filesystem-specific `data` argument is opaque; passed by address.
int mount(char *source, char *target, char *fstype, unsigned long flags, char *data);
int umount(char *target);
int umount2(char *target, int flags);
#endif
