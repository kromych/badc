// sysconf(_SC_PAGESIZE) must return the system page size. The numeric
// _SC_PAGESIZE selector differs between Darwin (29) and Linux (30); a
// wrong value makes glibc/Darwin return a garbage result, which breaks
// callers that align to the page size (sqlite's memory-mapped I/O). The
// page size is a positive power of two -- 4096 on Linux, 16384 on macOS
// arm64.
#include <unistd.h>

int main(void) {
    long pg = sysconf(_SC_PAGESIZE);
    if (pg <= 0) {
        return 1;
    }
    if ((pg & (pg - 1)) != 0) {
        return 2;
    }
    if (pg < 4096 || pg > 1048576) {
        return 3;
    }
    return 0;
}
