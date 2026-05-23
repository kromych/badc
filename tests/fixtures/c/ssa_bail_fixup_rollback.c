// SSA-emit regression for fixup-vector rollback on a per-function
// bail. When the SSA emit bails partway through a function, the
// outer pool path re-emits the same function from scratch. The
// SSA attempt's snapshot-rollback must also truncate every
// pending fixup vector; otherwise the stale fixups patch later
// code with offsets relative to the discarded SSA-emit byte
// stream and downstream calls jump into nonsense.
//
// A five-argument function with a NULL-fast-path branch and
// a wide u32 ld32 / st32 helper set is enough to force several
// fixups in the bailed function (the SSA Mcpy shape the emit
// doesn't yet handle) so the rollback path's completeness
// matters.

typedef unsigned char u8;
typedef unsigned int u32;
typedef unsigned long u64;

static u32 ld32(const u8 *x) {
    u32 u = x[3];
    u = (u<<8)|x[2];
    u = (u<<8)|x[1];
    return (u<<8)|x[0];
}

static void core(u8 *out, const u8 *in, const u8 *k, const u8 *c) {
    u32 x[16];
    int i;
    for (i = 0; i < 4; i++) {
        x[5*i] = ld32(c + 4*i);
        x[1+i] = ld32(k + 4*i);
        x[6+i] = ld32(in + 4*i);
        x[11+i] = ld32(k + 16 + 4*i);
    }
    out[0] = (u8)(x[0] ^ x[5] ^ x[10] ^ x[15]);
}

static const u8 sigma[16] = "expand 32-byte k";

static int stream_xor(u8 *c, const u8 *m, u64 b, const u8 *n, const u8 *k) {
    u8 z[16], x[64];
    u32 i;
    if (!b) return 0;
    for (i = 0; i < 16; i++) z[i] = 0;
    for (i = 0; i < 8; i++) z[i] = n[i];
    while (b >= 64) {
        core(x, z, k, sigma);
        for (i = 0; i < 64; i++) c[i] = (m ? m[i] : 0) ^ x[i];
        b -= 64;
        c += 64;
        if (m) m += 64;
    }
    return 0;
}

int main(void) {
    u8 c[64], n[8] = {1,2,3,4,5,6,7,8}, k[32];
    int i;
    for (i = 0; i < 32; i++) k[i] = (u8)i;
    stream_xor(c, 0, 64, n, k);
    // The pool-path output for this exact input pins c[0] to a
    // specific value; a stale-fixup miscompile reorders the
    // arithmetic and produces a different byte.
    return c[0] == 77 ? 0 : 1;
}
