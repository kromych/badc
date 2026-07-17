// Regression: dev_t must match the platform width.
//
// dev_t is 4 bytes on macOS (int32_t) and Windows (unsigned int), 8 on
// Linux (glibc __dev_t is unsigned long). The width matters in struct
// layout: a cache struct holding `int fd; dev_t st_dev; ino_t st_ino;`
// is read back by a separately-compiled module against the host's
// layout. A too-narrow dev_t shifts every later field.

#include <sys/types.h>

struct cache {
    int fd;
    dev_t st_dev;
    ino_t st_ino;
};

int main(void) {
#if defined(__APPLE__)
    if (sizeof(dev_t) != 4) {
        return 1;
    }
    // 4-byte int, 4-byte dev_t, 8-byte ino_t 8-aligned: size 16.
    if (sizeof(struct cache) != 16) {
        return 2;
    }
#elif defined(__linux__)
    if (sizeof(dev_t) != 8) {
        return 1;
    }
    // 4-byte int + 4 pad, 8-byte dev_t, 8-byte ino_t: size 24.
    if (sizeof(struct cache) != 24) {
        return 2;
    }
#endif
    return 0;
}
