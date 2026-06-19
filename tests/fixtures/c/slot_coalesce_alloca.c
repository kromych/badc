/* A function that calls alloca and also has disjoint-lifetime declared
   scalars. Slot coalescing reuses the scalar slots and compacts the frame,
   but the per-frame alloca arena -- reserved below the named locals -- must
   stay within the prologue's stack reservation. If the frame is compacted
   below the arena, the alloca storage lands at or under the stack pointer and
   a callee's frame overlaps it. `burn` writes only its own array; `buf` must
   read back unchanged across the call. Returns 0 on success. */

static long burn(int n) {
    volatile long acc[24];
    long s = 0;
    for (int i = 0; i < 24; i++) acc[i] = (long)(i + 1) * n;
    for (int i = 0; i < 24; i++) s += acc[i];
    return s;
}

int main(void) {
    long a0 = 1, a1 = 2; long sa = a0 * a1 + a0;
    long b0 = 3, b1 = 4; long sb = b0 * b1 + b0;
    long c0 = 5, c1 = 6; long sc = c0 * c1 + c0;
    long d0 = 7, d1 = 8; long sd = d0 * d1 + d0;
    long base = sa + sb + sc + sd;

    long *buf = __builtin_alloca(8 * sizeof(long));
    for (int i = 0; i < 8; i++) buf[i] = base + i;

    long t = burn((int)base);
    if (t == 0) return 2;

    for (int i = 0; i < 8; i++)
        if (buf[i] != base + i) return 1;
    return 0;
}
