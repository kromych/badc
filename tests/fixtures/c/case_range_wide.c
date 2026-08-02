// A GCC `case lo ... hi` range is dispatched by a `lo <= disc <= hi` bounds
// comparison rather than one label per value, so a wide range works --
// real-world register-decode and page-table switches span millions of
// values. Covers a large unsigned range, the top-of-u32 range, a signed
// range, ranges mixed with single labels and fall-through, boundary values
// just inside/outside, and gaps. Returns 0 on success.

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

/* Opaque call targets: a volatile pointer load keeps each call real, so
   the range's bounds comparison is emitted rather than inlined and folded
   to the arm the constant argument selects. */
static int (*volatile classify_u_p)(uint32_t) = classify_u;
static int (*volatile classify_s_p)(int) = classify_s;

int main(void) {
    if (classify_u_p(0) != 100) return 1;
    if (classify_u_p(1048576) != 1 || classify_u_p(2097151) != 1 || classify_u_p(1500000) != 1) return 2;
    if (classify_u_p(1048575) != 0 || classify_u_p(2097152) != 0) return 3; // just outside
    if (classify_u_p(5) != 2 || classify_u_p(7) != 2 || classify_u_p(9) != 2) return 4;
    if (classify_u_p(6) != 0) return 5;         // gap between 5 and 7..9
    if (classify_u_p(4026531840u) != 3 || classify_u_p(4294967295u) != 3) return 6;
    if (classify_u_p(4026531839u) != 0) return 7;
    if (classify_s_p(-100) != 10 || classify_s_p(-50) != 10 || classify_s_p(-75) != 10) return 8;
    if (classify_s_p(-101) != 12 || classify_s_p(-49) != 12) return 9;
    if (classify_s_p(0) != 11) return 10;
    return 0;
}
