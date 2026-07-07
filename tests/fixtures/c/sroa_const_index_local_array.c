/* A fixed-size local array whose subscripts all become constant once the
 * trip loops fully unroll: `passes::sroa` splits the array into
 * per-element slots and the mem2reg re-run promotes them to SSA values.
 * `a` is carried across the runtime-trip while loop, so the promoted
 * elements need header phis (locked by the SSA snapshot -- no LocalAddr
 * or Store to the array base survives). The eight-element array stays
 * within the usable-GPR budget of both targets, so it promotes on each.
 * The rotated shift-and-carry exercises the per-element reaching
 * definition across the collapsed inner loop; the computed sum is the
 * runtime check. */
typedef unsigned long long u64;

u64 rounds(u64 *in, int n) {
    u64 a[8];
    for (int i = 0; i < 8; i++) a[i] = in[i];
    while (n-- > 0) {
        u64 last = a[7];
        for (int j = 7; j > 0; j--) a[j] = a[j - 1] + (a[j] << 1);
        a[0] = last ^ (a[0] << 1);
    }
    u64 s = 0;
    for (int i = 0; i < 8; i++) s += a[i];
    return s;
}

int main(void) {
    u64 in[8];
    for (int i = 0; i < 8; i++) in[i] = (u64)i * 0x1111 + 7;
    if (rounds(in, 5) != 21938052ULL) return 1;
    return 0;
}
