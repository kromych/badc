// <sysexits.h>: the BSD exit-status codes. They are integer constants
// with no platform library behind them, so every target sees the same
// values and the set is contiguous from EX__BASE to EX__MAX.
//
// Returns 0 on success, otherwise the number of the failing check.

#include <sysexits.h>

int main(void) {
    if (EX_OK != 0) {
        return 1;
    }
    if (EX__BASE != 64 || EX_USAGE != 64) {
        return 2;
    }
    if (EX_DATAERR != 65 || EX_NOINPUT != 66 || EX_NOUSER != 67) {
        return 3;
    }
    if (EX_NOHOST != 68 || EX_UNAVAILABLE != 69 || EX_SOFTWARE != 70) {
        return 4;
    }
    if (EX_OSERR != 71 || EX_OSFILE != 72 || EX_CANTCREAT != 73) {
        return 5;
    }
    if (EX_IOERR != 74 || EX_TEMPFAIL != 75 || EX_PROTOCOL != 76) {
        return 6;
    }
    if (EX_NOPERM != 77 || EX_CONFIG != 78 || EX__MAX != 78) {
        return 7;
    }
    if (EX__MAX - EX__BASE != 14) {
        return 8;
    }
    return 0;
}
