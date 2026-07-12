#pragma once

// sys/sysmacros.h -- compose and decompose a device number (Linux).
// The encoding splits the major and minor numbers across a 64-bit dev_t
// exactly as the platform's mknod / stat expect.

#define major(dev) \
    ((unsigned int) ((((unsigned long long)(dev) >> 32) & 0xfffff000u) \
                     | (((unsigned int)(dev) >> 8) & 0x00000fffu)))

#define minor(dev) \
    ((unsigned int) ((((unsigned long long)(dev) >> 12) & 0xffffff00u) \
                     | ((unsigned int)(dev) & 0x000000ffu)))

#define makedev(maj, min) \
    ((unsigned long long) \
     ((((unsigned long long)((maj) & 0xfffff000u)) << 32) \
      | (((unsigned long long)((maj) & 0x00000fffu)) << 8) \
      | (((unsigned long long)((min) & 0xffffff00u)) << 12) \
      | ((unsigned long long)((min) & 0x000000ffu))))
