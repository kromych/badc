// `struct stat` is a write-target for libc's fstat/stat family: its
// field offsets must match the platform layout, and its size must match
// the platform ABI so `sizeof`, by-value copies and arrays interoperate.
// The bundled header used to append a 64-byte trailing pad, inflating the
// size (208 vs the real 144/128). This checks the per-target size and a
// functional readback of the fields fstat fills.
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(void) {
#ifdef __linux__
#ifdef __aarch64__
    if (sizeof(struct stat) != 128) {
        return 1;
    }
#else
    if (sizeof(struct stat) != 144) {
        return 1;
    }
#endif
#else
    if (sizeof(struct stat) != 144) {
        return 1;
    }
#endif
    if (offsetof(struct stat, st_dev) != 0) {
        return 2;
    }

    char path[64];
    sprintf(path, "badc_stat_%d.bin", (int)getpid());
    int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        return 3;
    }
    if (write(fd, "0123456789ABCDEF", 16) != 16) {
        unlink(path);
        return 4;
    }
    struct stat st;
    memset(&st, 0, sizeof st);
    if (fstat(fd, &st) != 0) {
        unlink(path);
        return 5;
    }
    if (st.st_size != 16) {
        unlink(path);
        return 6;
    }
    if ((st.st_mode & S_IFMT) != S_IFREG) {
        unlink(path);
        return 7;
    }
    close(fd);
    unlink(path);
    return 0;
}
