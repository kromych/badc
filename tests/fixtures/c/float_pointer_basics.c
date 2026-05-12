#include <stdlib.h>

// Real IEEE 754 single-precision support: `sizeof(float) == 4`,
// `float *fa; fa + 1` strides 4 bytes, the slot storage is the
// narrow single rather than an 8-byte mirror. The c5 accumulator
// still moves f64 bits across `Op::Lf` / `Op::Sf` (the
// widening/narrowing happens at the load/store boundary), so
// arithmetic ops keep using the f64 dispatch.
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
    if (sz_f != 4) return 1;
    if (sz_d != 8) return 2;

    // Pointer arithmetic: `fa + 1` advances 4 bytes (one IEEE
    // single); `da + 1` still advances 8 bytes.
    n = 4;
    fa = (float *)malloc(n * 4);
    da = (double *)malloc(n * 8);

    // Index-write through float pointer: the single-precision
    // bit pattern fits in `int` (4 bytes everywhere) and the
    // 4-byte stride lands exactly on the slot the matching
    // `*(int *)&fa[i]` re-reads.
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
