// linux/fs.h -- filesystem ioctls from the kernel uapi header. The
// values expand the kernel's _IOW('\x94', nr, size) encoding:
// dir 1 (write) << 30 | size << 16 | 0x94 << 8 | nr. TODO: the
// FS_IOC_* attribute ioctls.

#pragma once

#ifdef __linux__
#include <stdint.h>

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
#endif
