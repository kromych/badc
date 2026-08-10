// `copy_file_range`: a Linux system call bound to the Linux C library
// and, on every other target, the read/write emulation in
// `libc/lib/unistd_ext.c`. The cases below are the offset bookkeeping
// the system call defines: a null offset argument names the
// descriptor's own position and the copy advances it, a non-null one
// names the starting position, leaves the descriptor alone and is
// advanced by the byte count returned.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <stdio.h>
#include <string.h>
#include <unistd.h>

static const char PAYLOAD[] = "0123456789abcdef";
#define PAYLOAD_LEN 16

static int fill(FILE *f) {
    if (fwrite(PAYLOAD, 1, PAYLOAD_LEN, f) != PAYLOAD_LEN) {
        return -1;
    }
    if (fflush(f) != 0) {
        return -1;
    }
    return fileno(f);
}

int main(void) {
    FILE *src = tmpfile();
    FILE *dst = tmpfile();
    char back[PAYLOAD_LEN + 1];
    long in_off;
    long out_off;
    long n;
    int in_fd;
    int out_fd;

    if (!src || !dst) {
        return 1;
    }
    in_fd = fill(src);
    out_fd = fileno(dst);
    if (in_fd < 0 || out_fd < 0) {
        return 2;
    }

    // Explicit offsets: copy the middle eight bytes to the head of the
    // output, then confirm both offsets advanced by the byte count.
    in_off = 4;
    out_off = 0;
    n = copy_file_range(in_fd, &in_off, out_fd, &out_off, 8, 0);
    if (n != 8) {
        return 3;
    }
    if (in_off != 12 || out_off != 8) {
        return 4;
    }
    // With explicit offsets the descriptors' own positions are
    // untouched; the input's is still where `fill` left it.
    if (lseek(in_fd, 0, SEEK_CUR) != PAYLOAD_LEN) {
        return 5;
    }
    if (lseek(out_fd, 0, SEEK_CUR) != 0) {
        return 6;
    }
    if (lseek(out_fd, 0, SEEK_SET) != 0) {
        return 7;
    }
    if (read(out_fd, back, 8) != 8) {
        return 8;
    }
    if (memcmp(back, PAYLOAD + 4, 8) != 0) {
        return 9;
    }

    // Null offsets: the copy starts at each descriptor's position and
    // advances both.
    if (lseek(in_fd, 2, SEEK_SET) != 2) {
        return 10;
    }
    if (lseek(out_fd, 8, SEEK_SET) != 8) {
        return 11;
    }
    n = copy_file_range(in_fd, 0, out_fd, 0, 4, 0);
    if (n != 4) {
        return 12;
    }
    if (lseek(in_fd, 0, SEEK_CUR) != 6) {
        return 13;
    }
    if (lseek(out_fd, 0, SEEK_CUR) != 12) {
        return 14;
    }
    if (lseek(out_fd, 8, SEEK_SET) != 8) {
        return 15;
    }
    if (read(out_fd, back, 4) != 4) {
        return 16;
    }
    if (memcmp(back, PAYLOAD + 2, 4) != 0) {
        return 17;
    }

    // A request past the end of the input copies what is there and
    // returns that count; a request at the end returns 0.
    in_off = PAYLOAD_LEN - 3;
    out_off = 0;
    n = copy_file_range(in_fd, &in_off, out_fd, &out_off, 64, 0);
    if (n != 3 || in_off != PAYLOAD_LEN || out_off != 3) {
        return 18;
    }
    in_off = PAYLOAD_LEN;
    out_off = 0;
    if (copy_file_range(in_fd, &in_off, out_fd, &out_off, 64, 0) != 0) {
        return 19;
    }
    if (in_off != PAYLOAD_LEN || out_off != 0) {
        return 20;
    }
    // A zero-length request copies nothing and leaves the offsets alone.
    in_off = 5;
    out_off = 5;
    if (copy_file_range(in_fd, &in_off, out_fd, &out_off, 0, 0) != 0) {
        return 21;
    }
    if (in_off != 5 || out_off != 5) {
        return 22;
    }

    fclose(src);
    fclose(dst);
    return 0;
}
