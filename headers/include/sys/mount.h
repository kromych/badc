// sys/mount.h -- mount-flag constants (macOS / BSD).

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
