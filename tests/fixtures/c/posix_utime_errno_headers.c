// badc bundles the POSIX <utime.h> (struct utimbuf with the actime / modtime
// time_t fields, POSIX 7.49) and the ENOTCONN errno constant. Exercise the
// type and the constant without a libc call so this runs on every lane.
// Asserted by return code.

#include <errno.h>
#include <utime.h>

int main(void) {
    struct utimbuf t;
    t.actime = 100;
    t.modtime = 200;
    if (t.actime + t.modtime != 300) return 1;
    if (sizeof(t.actime) != 8) return 2; // time_t is 8 bytes on every target
    if (ENOTCONN == 0) return 3;
    return 0;
}
