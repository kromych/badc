// linux/falloc.h -- fallocate(2) mode flags from the kernel uapi header.
// Passed in the `mode` argument to control whether a range is allocated,
// hole-punched, zeroed, collapsed, or inserted.

#pragma once

#ifdef __linux__

#define FALLOC_FL_ALLOCATE_RANGE 0x00
#define FALLOC_FL_KEEP_SIZE      0x01
#define FALLOC_FL_PUNCH_HOLE     0x02
#define FALLOC_FL_NO_HIDE_STALE  0x04
#define FALLOC_FL_COLLAPSE_RANGE 0x08
#define FALLOC_FL_ZERO_RANGE     0x10
#define FALLOC_FL_INSERT_RANGE   0x20
#define FALLOC_FL_UNSHARE_RANGE  0x40
#define FALLOC_FL_WRITE_ZEROES   0x80

#endif /* __linux__ */
