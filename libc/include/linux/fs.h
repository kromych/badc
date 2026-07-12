// linux/fs.h -- filesystem ioctls from the kernel uapi header. The
// values expand the kernel's _IOW('\x94', nr, size) encoding:
// dir 1 (write) << 30 | size << 16 | 0x94 << 8 | nr. TODO: the
// FS_IOC_* attribute ioctls.

#pragma once

#ifdef __linux__
#include <stdint.h>
#include <stddef.h>
#include <linux/ioctl.h>

struct file_clone_range {
    int64_t src_fd;
    uint64_t src_offset;
    uint64_t src_length;
    uint64_t dest_offset;
};

// _IOW(0x94, 9, int)
#define FICLONE 0x40049409
// _IOW(0x94, 13, struct file_clone_range)
#define FICLONERANGE 0x4020940d

// Inode attribute ioctls (the FS_*_FL flag bits below carry the values).
#define FS_IOC_GETFLAGS   _IOR('f', 1, long)
#define FS_IOC_SETFLAGS   _IOW('f', 2, long)
#define FS_IOC_GETVERSION _IOR('v', 1, long)
#define FS_IOC_SETVERSION _IOW('v', 2, long)

#define FS_SECRM_FL        0x00000001 // secure deletion
#define FS_UNRM_FL         0x00000002 // undelete
#define FS_COMPR_FL        0x00000004 // compress file
#define FS_SYNC_FL         0x00000008 // synchronous updates
#define FS_IMMUTABLE_FL    0x00000010 // immutable file
#define FS_APPEND_FL       0x00000020 // append-only
#define FS_NODUMP_FL       0x00000040 // do not dump
#define FS_NOATIME_FL      0x00000080 // do not update atime
#define FS_JOURNAL_DATA_FL 0x00004000 // journal file data
#define FS_NOCOW_FL        0x00800000 // do not copy-on-write

// Block-device ioctls (uapi type 0x12), encoded via the shared _IO macros.
#define BLKROSET     _IO(0x12, 93)
#define BLKROGET     _IO(0x12, 94)
#define BLKRRPART    _IO(0x12, 95)
#define BLKGETSIZE   _IO(0x12, 96)
#define BLKFLSBUF    _IO(0x12, 97)
#define BLKRASET     _IO(0x12, 98)
#define BLKRAGET     _IO(0x12, 99)
#define BLKFRASET    _IO(0x12, 100)
#define BLKFRAGET    _IO(0x12, 101)
#define BLKSECTSET   _IO(0x12, 102)
#define BLKSECTGET   _IO(0x12, 103)
#define BLKSSZGET    _IO(0x12, 104)
#define BLKBSZGET    _IOR(0x12, 112, size_t)
#define BLKBSZSET    _IOW(0x12, 113, size_t)
#define BLKGETSIZE64 _IOR(0x12, 114, size_t)
#define BLKDISCARD   _IO(0x12, 119)
#define BLKIOMIN     _IO(0x12, 120)
#define BLKIOOPT     _IO(0x12, 121)
#define BLKALIGNOFF  _IO(0x12, 122)
#define BLKPBSZGET   _IO(0x12, 123)
#define BLKDISCARDZEROES _IO(0x12, 124)
#define BLKSECDISCARD _IO(0x12, 125)
#define BLKROTATIONAL _IO(0x12, 126)
#define BLKZEROOUT   _IO(0x12, 127)
#endif
