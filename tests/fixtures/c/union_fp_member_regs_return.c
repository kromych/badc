// A 16-byte struct whose first eightbyte is a union overlapping a double
// with integer/pointer members returns in the integer result registers
// (System V AMD64 rax/rdx, AAPCS64 x0/x1), not through an out-pointer: the
// eightbyte classifies as INTEGER because not every overlapping field is
// floating-point. The double bits ride the integer register and the caller
// reads them back bit-for-bit. This is a common tagged-value shape.

#include <string.h>

struct Val {
    union {
        int i;
        double d;
        void *p;
    } u;
    long tag;
};

static struct Val mk_d(double x) {
    struct Val v;
    v.u.d = x;
    v.tag = 11;
    return v;
}

static struct Val mk_i(int x) {
    struct Val v;
    v.u.i = x;
    v.tag = 22;
    return v;
}

int main(void) {
    struct Val a = mk_d(3.25);
    if (a.u.d != 3.25) return 1;
    if (a.tag != 11) return 2;

    struct Val b = mk_i(0x1234);
    if (b.u.i != 0x1234) return 3;
    if (b.tag != 22) return 4;

    // A second double call to catch a stale register dependence in the
    // eightbyte recovery.
    struct Val c = mk_d(-7.5);
    if (c.u.d != -7.5) return 5;
    if (c.tag != 11) return 6;

    return 0;
}
