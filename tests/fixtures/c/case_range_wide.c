// A GCC `case lo ... hi` range is dispatched by a `lo <= disc <= hi` bounds
// comparison rather than one label per value, so a wide range works -- QEMU's
// register-decode and page-table switches span millions of values. Covers a
// large unsigned range, the top-of-u32 range, a signed range, ranges mixed
// with single labels and fall-through, boundary values just inside/outside,
// and gaps. Returns 0 on success.

#include <stdint.h>

static int classify_u(uint32_t x) {
    switch (x) {
    case 0:
        return 100;
    case 1048576 ... 2097151:
        return 1; // 1M-value range
    case 5:
    case 7 ... 9:
        return 2; // single label falling through into a small range
    case 4026531840u ... 4294967295u:
        return 3; // top of the u32 space
    default:
        return 0;
    }
}

static int classify_s(int x) {
    switch (x) {
    case -100 ... -50:
        return 10;
    case 0:
        return 11;
    default:
        return 12;
    }
}

int main(void) {
    if (classify_u(0) != 100) return 1;
    if (classify_u(1048576) != 1 || classify_u(2097151) != 1 || classify_u(1500000) != 1) return 2;
    if (classify_u(1048575) != 0 || classify_u(2097152) != 0) return 3; // just outside
    if (classify_u(5) != 2 || classify_u(7) != 2 || classify_u(9) != 2) return 4;
    if (classify_u(6) != 0) return 5;         // gap between 5 and 7..9
    if (classify_u(4026531840u) != 3 || classify_u(4294967295u) != 3) return 6;
    if (classify_u(4026531839u) != 0) return 7;
    if (classify_s(-100) != 10 || classify_s(-50) != 10 || classify_s(-75) != 10) return 8;
    if (classify_s(-101) != 12 || classify_s(-49) != 12) return 9;
    if (classify_s(0) != 11) return 10;
    return 0;
}
