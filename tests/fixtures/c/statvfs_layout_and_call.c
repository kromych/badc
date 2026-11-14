// statvfs() and fstatvfs() through the C library's struct statvfs: the size
// and member offsets of the macOS SDK and glibc LP64 layouts, and the counts
// a call on the working directory fills.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <fcntl.h>
#include <stddef.h>
#include <sys/statvfs.h>
#include <unistd.h>

int main(void) {
#ifdef __APPLE__
    if (sizeof(struct statvfs) != 64 || offsetof(struct statvfs, f_blocks) != 16 ||
        offsetof(struct statvfs, f_files) != 28 || offsetof(struct statvfs, f_fsid) != 40 ||
        offsetof(struct statvfs, f_namemax) != 56) {
        return 1;
    }
#else
    if (sizeof(struct statvfs) != 112 || offsetof(struct statvfs, f_blocks) != 16 ||
        offsetof(struct statvfs, f_files) != 40 || offsetof(struct statvfs, f_fsid) != 64 ||
        offsetof(struct statvfs, f_namemax) != 80 || offsetof(struct statvfs, f_type) != 88) {
        return 1;
    }
#endif
    if ((fsblkcnt_t)-1 < 0 || (fsfilcnt_t)-1 < 0) {
        return 2;
    }
    struct statvfs v;
    if (statvfs(".", &v) != 0) {
        return 3;
    }
    if (v.f_bsize == 0 || v.f_frsize == 0 || v.f_blocks == 0 || v.f_namemax == 0) {
        return 4;
    }
    if (v.f_bfree > v.f_blocks || v.f_bavail > v.f_blocks || v.f_ffree > v.f_files) {
        return 5;
    }
    int fd = open(".", O_RDONLY);
    if (fd < 0) {
        return 6;
    }
    struct statvfs w;
    int rc = fstatvfs(fd, &w);
    close(fd);
    if (rc != 0 || w.f_frsize != v.f_frsize || w.f_blocks != v.f_blocks || w.f_fsid != v.f_fsid) {
        return 7;
    }
    return 0;
}
