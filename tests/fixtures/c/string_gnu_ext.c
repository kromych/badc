// The <string.h> entry points no single C library exports everywhere:
// GNU `strchrnul` / `memrchr` / `explicit_bzero` (absent from libSystem
// and msvcrt) and POSIX `strndup` (absent from msvcrt). Where the
// platform library has none, `libc/lib/string_ext.c` supplies it. The
// cases below are the ones glibc and that source agree on, so a target
// drifting from the Linux behaviour fails here.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <stdlib.h>
#include <string.h>

int main(void) {
    const char *s = "abcabc";
    const char *empty = "";
    // A byte with the high bit set: `char` is signed on x86-64 and
    // unsigned on aarch64, so only one of the lanes catches a compare
    // that widens the two sides differently.
    const char *hi = "\xff" "z";
    char buf[8];
    char counted[5];
    char *dup;
    unsigned i;

    // strchrnul: present, absent, and the terminating NUL itself. The
    // absent case is what separates it from strchr -- the NUL, not null.
    if (strchrnul(s, 'b') != s + 1) {
        return 1;
    }
    if (strchrnul(s, 'z') != s + 6) {
        return 2;
    }
    if (strchrnul(s, '\0') != s + 6) {
        return 3;
    }
    if (strchrnul(empty, 'a') != empty) {
        return 4;
    }
    if (strchrnul(empty, '\0') != empty) {
        return 5;
    }
    if (strchrnul(s, 'a') != s) {
        return 6;
    }
    // `c` is converted to char, so the low byte alone decides.
    if (strchrnul(s, 'a' + 0x100) != s) {
        return 7;
    }
    if (strchrnul(hi, 0xff) != hi) {
        return 20;
    }
    if (strchrnul(hi, 'q') != hi + 2) {
        return 21;
    }

    // memrchr scans backward over a counted region, so it sees NULs and
    // stops at `n` rather than at a terminator.
    counted[0] = 'a';
    counted[1] = '\0';
    counted[2] = 'b';
    counted[3] = '\0';
    counted[4] = 'a';
    if (memrchr(counted, 'a', (int)sizeof counted) != counted + 4) {
        return 8;
    }
    if (memrchr(counted, '\0', (int)sizeof counted) != counted + 3) {
        return 9;
    }
    if (memrchr(counted, 'z', (int)sizeof counted) != 0) {
        return 10;
    }
    if (memrchr(counted, 'a', 0) != 0) {
        return 11;
    }
    // A count short of the last match yields the earlier one.
    if (memrchr(counted, 'a', 3) != counted) {
        return 12;
    }
    if (memrchr((char *)hi, 0xff, 2) != hi) {
        return 22;
    }

    // explicit_bzero clears exactly the region named, neighbours intact.
    for (i = 0; i < sizeof buf; i++) {
        buf[i] = 'x';
    }
    explicit_bzero(buf + 2, sizeof buf - 4);
    if (buf[0] != 'x' || buf[1] != 'x') {
        return 13;
    }
    for (i = 2; i < sizeof buf - 2; i++) {
        if (buf[i] != 0) {
            return 14;
        }
    }
    if (buf[sizeof buf - 2] != 'x' || buf[sizeof buf - 1] != 'x') {
        return 15;
    }
    // A zero count writes nothing.
    buf[0] = 'y';
    explicit_bzero(buf, 0);
    if (buf[0] != 'y') {
        return 16;
    }

    // strndup stops at `n` and NUL-terminates; a count past the string
    // copies only up to the terminator.
    dup = strndup((char *)s, 3);
    if (dup == 0 || strcmp(dup, "abc") != 0) {
        return 17;
    }
    free(dup);
    dup = strndup((char *)s, 100);
    if (dup == 0 || strcmp(dup, s) != 0) {
        return 18;
    }
    free(dup);
    dup = strndup((char *)s, 0);
    if (dup == 0 || dup[0] != 0) {
        return 19;
    }
    free(dup);
    return 0;
}
