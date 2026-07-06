/* A local array with a runtime subscript stays memory-resident: the
 * trip-8 fill loop unrolls (so the function is a scalar-promotion
 * candidate), but the runtime-indexed reads `a[k & 7]` cannot map to a
 * fixed element slot, so `passes::sroa` must leave the whole array in the
 * frame (locked by the SSA snapshot -- the array is still addressed
 * through its base). The computed value is the runtime check. */
typedef unsigned long long u64;

u64 pick(u64 *in, int k) {
    u64 a[8];
    for (int i = 0; i < 8; i++) a[i] = in[i] * 3 + 1;
    return a[k & 7] + a[(k + 5) & 7];
}

int main(void) {
    u64 in[8];
    for (int i = 0; i < 8; i++) in[i] = (u64)i;
    if (pick(in, 10) != 29ULL) return 1;
    return 0;
}
