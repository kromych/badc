#include <stdlib.h>

// Float scalar arithmetic isn't lowered yet, but every operation
// that doesn't require an FP add/sub/mul/div works today: `float`
// and `double` types parse, float pointers obey the same 8-byte
// stride as `int *`, indexed reads/writes go through Op::Li/Op::Si
// the same way, and `sizeof` reports 8 (one slot per scalar; the
// 32-bit narrowing happens at the future XMM/v boundary, not in
// the in-memory layout).
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

    // Index-write through float pointer (Si). The slot pattern
    // we store is meaningless without FP arithmetic, so we round-
    // trip the int bit pattern instead -- proving the storage
    // path is wired even before the FP ops arrive.
    *(int *)&fa[0] = 0x3f800000;        // bit pattern of 1.0f
    *(int *)&fa[1] = 0x40000000;        // bit pattern of 2.0f
    *(int *)&da[0] = 0x3ff0000000000000; // bit pattern of 1.0
    *(int *)&da[1] = 0x4000000000000000; // bit pattern of 2.0

    if (*(int *)&fa[0] != 0x3f800000) return 3;
    if (*(int *)&fa[1] != 0x40000000) return 4;
    if (*(int *)&da[0] != 0x3ff0000000000000) return 5;
    if (*(int *)&da[1] != 0x4000000000000000) return 6;

    free((char *)fa);
    free((char *)da);
    return 0;
}
