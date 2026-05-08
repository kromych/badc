#include <stdlib.h>

// Float scalar arithmetic isn't lowered yet, but every operation
// that doesn't require an FP add/sub/mul/div works today: `float`
// and `double` types parse, float pointers stride one slot at a
// time, and `sizeof` reports 8 for both scalars (c5 keeps every
// FP value in an 8-byte slot; the IEEE 754 32-bit narrowing for
// `float` is future work).
//
// 32-bit bit patterns round-trip through `int` (4 bytes everywhere)
// and 64-bit bit patterns through `long long` (8 bytes on every
// target, unlike `long` which is 4 bytes on Windows LLP64).
int main() {
    float *fa;
    double *da;
    int n;
    int sz_f;
    int sz_d;

    // sizeof on the type form.
    sz_f = sizeof(float);
    sz_d = sizeof(double);
    if (sz_f != 8) return 1;
    if (sz_d != 8) return 2;

    // Pointer arithmetic: `fa + 1` advances 8 bytes, just like
    // any non-`char *` pointer.
    n = 4;
    fa = (float *)malloc(n * 8);
    da = (double *)malloc(n * 8);

    // Index-write through float pointer (Sw, the  4-byte
    // store). The single-precision pattern fits in `int`.
    *(int *)&fa[0] = 0x3f800000;        // bit pattern of 1.0f
    *(int *)&fa[1] = 0x40000000;        // bit pattern of 2.0f
    // Double's 64-bit pattern needs a real 8-byte slot -- `int` is
    // 4 bytes and would truncate the high half, and so is `long`
    // on Windows LLP64. `long long` is 8 bytes on every target.
    *(long long *)&da[0] = 0x3ff0000000000000; // bit pattern of 1.0
    *(long long *)&da[1] = 0x4000000000000000; // bit pattern of 2.0

    if (*(int *)&fa[0] != 0x3f800000) return 3;
    if (*(int *)&fa[1] != 0x40000000) return 4;
    if (*(long long *)&da[0] != 0x3ff0000000000000) return 5;
    if (*(long long *)&da[1] != 0x4000000000000000) return 6;

    free((char *)fa);
    free((char *)da);
    return 0;
}
