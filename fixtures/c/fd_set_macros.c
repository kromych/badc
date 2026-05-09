// FD_SET / FD_ZERO / FD_CLR / FD_ISSET should now be real macros
// in <sys/select.h> -- the c5 preprocessor handles `do { ... }
// while (0)` multi-line macros, so the bitmap manipulation can
// live in the header instead of every caller open-coding it.
//
// Layout the macros assume: an `unsigned char[]` bitmap with bit
// `fd` at byte `fd / 8`, mask `1 << (fd & 7)`. We sanity-check by
// allocating FD_SET_BYTES on the stack, flipping a few bits, and
// asserting against the expected raw bytes.
#include <stdio.h>
#include <sys/select.h>

int main() {
    char fds[FD_SET_BYTES];

    FD_ZERO(fds);
    int i = 0;
    while (i < FD_SET_BYTES) {
        if (fds[i] != 0) return 1;
        i = i + 1;
    }

    FD_SET(0, fds);
    FD_SET(7, fds);
    FD_SET(8, fds);
    FD_SET(100, fds);

    if (!FD_ISSET(0, fds))   return 2;
    if (!FD_ISSET(7, fds))   return 3;
    if (!FD_ISSET(8, fds))   return 4;
    if (!FD_ISSET(100, fds)) return 5;
    if (FD_ISSET(1, fds))    return 6;
    if (FD_ISSET(50, fds))   return 7;

    // Raw byte check: byte 0 has bits 0+7 set = 0x81; byte 1 has
    // bit 8-of-set (= bit 0 within byte) set = 0x01; byte 12 has
    // bit 100-of-set (= bit 4 within byte) set = 0x10.
    unsigned char *raw = (unsigned char *)fds;
    if (raw[0]  != 0x81) return 11;
    if (raw[1]  != 0x01) return 12;
    if (raw[12] != 0x10) return 13;

    FD_CLR(7, fds);
    if (FD_ISSET(7, fds))    return 21;
    if (!FD_ISSET(0, fds))   return 22;  // sibling bit untouched
    if (!FD_ISSET(8, fds))   return 23;

    // Double-set is idempotent.
    FD_SET(0, fds);
    if (!FD_ISSET(0, fds))   return 24;

    // FD_ZERO clears everything again.
    FD_ZERO(fds);
    if (FD_ISSET(0, fds))    return 25;
    if (FD_ISSET(100, fds))  return 26;

    printf("OK\n");
    return 0;
}
