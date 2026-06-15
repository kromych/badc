// localtime() fills `struct tm`, and a program reads the BSD extension
// members back, so they must sit at the host's offsets. On macOS and
// glibc `tm_gmtoff` is a `long` (8-aligned), placing `tm_zone` at offset
// 48; an `int tm_gmtoff` would put it at 40 and read a garbage pointer
// (which crashes in CPython's time-module timezone setup).

#include <time.h>
#include <stddef.h>
#include <string.h>

int main(void) {
#if defined(__APPLE__) || defined(__linux__)
    if (offsetof(struct tm, tm_gmtoff) != 40) return 1;
    if (offsetof(struct tm, tm_zone) != 48) return 2;
    if (sizeof(struct tm) != 56) return 3;

    // The filled tm_zone must be a readable string, not a stray pointer.
    time_t t = time((time_t *) 0);
    struct tm out;
    if (localtime_r(&t, &out) == 0) return 4;
    if (out.tm_zone == 0) return 5;
    // Reading the abbreviation must not fault; a real zone name is short.
    if (strlen(out.tm_zone) > 64) return 6;
#endif
    return 0;
}
