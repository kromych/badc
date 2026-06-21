// An anonymous private mapping must succeed: the MAP_ANONYMOUS flag value
// reaches the host's mmap, and it diverges between macOS (0x1000) and
// Linux (0x20). A wrong value drops the anonymous bit, so mmap tries to
// map the fd (-1) as a real file and fails with MAP_FAILED -- which
// surfaces downstream as a spurious out-of-memory. Windows has no POSIX
// mmap, so the body is guarded.

#include <stdio.h>

#if defined(__APPLE__) || defined(__linux__)
#include <sys/mman.h>

int main(void) {
    unsigned long len = 16384;
    char *p = mmap(0, len, PROT_READ | PROT_WRITE,
                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (p == MAP_FAILED) return 1;
    // The mapping is usable: write and read back.
    for (unsigned long i = 0; i < len; i += 4096) {
        p[i] = (char) (i / 4096 + 1);
    }
    for (unsigned long i = 0; i < len; i += 4096) {
        if (p[i] != (char) (i / 4096 + 1)) return 2;
    }
    if (munmap(p, len) != 0) return 3;
    return 0;
}
#else
int main(void) { return 0; }
#endif
