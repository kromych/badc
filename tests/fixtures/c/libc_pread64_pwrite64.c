// glibc large-file variants pread64 / pwrite64 (_LARGEFILE64_SOURCE).
// Code that references these names directly -- both the direct call and
// the function-pointer-table cast shape -- must reach libc and report the
// transferred byte count. Without a prototype the name is implicitly
// declared, the address-of trampoline forwards no arguments, and the
// indirect call returns garbage. The body is guarded to Linux, where the
// binding exists; on other targets main is a no-op so the fixture stays
// green everywhere.
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>

#ifdef __linux__
typedef long (*pread64_fn)(int, void *, unsigned long, long);
typedef long (*pwrite64_fn)(int, const void *, unsigned long, long);

// A table of opaque function pointers cast back to the real arity at
// the call site, a common syscall-dispatch table shape.
struct vec {
    const char *name;
    void (*fn)(void);
};
static struct vec tbl[] = {
    {"a0", 0}, {"a1", 0}, {"a2", 0}, {"a3", 0},
    {"a4", 0}, {"a5", 0}, {"a6", 0}, {"a7", 0},
    {"pread64", (void (*)(void))pread64},
    {"a9", 0},
    {"pwrite64", (void (*)(void))pwrite64},
};
#endif

int main(void) {
#ifdef __linux__
    char path[64];
    sprintf(path, "badc_p64_%d.bin", (int)getpid());
    int fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        return 1;
    }
    char w[16];
    memcpy(w, "PREAD64-ROUNDTRP", 16);
    char r[16];

    // Direct calls reach libc through the CallExt binding.
    if (pwrite64(fd, w, 16, 0) != 16) {
        unlink(path);
        return 2;
    }
    memset(r, 0, sizeof r);
    if (pread64(fd, r, 16, 0) != 16) {
        unlink(path);
        return 3;
    }
    if (memcmp(w, r, 16) != 0) {
        unlink(path);
        return 4;
    }

    // Function-pointer-table cast shape: the address-of trampoline plus
    // the indirect call own the host-ABI argument setup.
    pwrite64_fn pw = (pwrite64_fn)tbl[10].fn;
    pread64_fn pr = (pread64_fn)tbl[8].fn;
    if (pw(fd, w, 8, 16) != 8) {
        unlink(path);
        return 5;
    }
    memset(r, 0, sizeof r);
    if (pr(fd, r, 8, 16) != 8) {
        unlink(path);
        return 6;
    }
    if (memcmp(w, r, 8) != 0) {
        unlink(path);
        return 7;
    }

    close(fd);
    unlink(path);
#endif
    return 0;
}
