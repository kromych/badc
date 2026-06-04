// Entry parameter placement must be a parallel copy when the
// allocator's chosen home registers form a cycle with the incoming
// argument registers. Here `core` keeps four pointer parameters live
// across the loop; the allocator can place a parameter into another
// parameter's incoming argument register (e.g. swap two of them),
// so emitting each `ParamRef` as an independent `mov dst, arg_reg`
// in order clobbers a source before it is read. The Salsa/ChaCha
// `ld32` little-endian word load gives the parameters enough live
// range and register pressure to force the swap under -O.
typedef unsigned char u8;
typedef unsigned int u32;

static u32 ld32(const u8 *x) {
    u32 u = x[3];
    u = (u << 8) | x[2];
    u = (u << 8) | x[1];
    return (u << 8) | x[0];
}

static void core(u8 *out, const u8 *in, const u8 *k, const u8 *c) {
    u32 x[16];
    int i;
    for (i = 0; i < 4; i++) {
        x[5 * i] = ld32(c + 4 * i);
        x[1 + i] = ld32(k + 4 * i);
        x[6 + i] = ld32(in + 4 * i);
        x[11 + i] = ld32(k + 16 + 4 * i);
    }
    out[0] = (u8)(x[0] ^ x[5] ^ x[10] ^ x[15]);
}

static const u8 sigma[16] = "expand 32-byte k";

int main(void) {
    u8 o[1], in[16], k[32];
    int i;
    for (i = 0; i < 16; i++) in[i] = (u8)i;
    for (i = 0; i < 32; i++) k[i] = (u8)i;
    core(o, in, k, sigma);
    // Reference value (interpreter and no-optimizer agree): 77. The
    // pre-fix x86_64 -O emit returned 0 because the `c` parameter was
    // overwritten with `in` by the unscheduled ParamRef placement.
    return o[0];
}
