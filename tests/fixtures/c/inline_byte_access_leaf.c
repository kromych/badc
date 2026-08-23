// Byte-access leaves taking a pointer parameter, called in a tight
// loop -- the shape crypto compression functions are written in. The
// byte-merge pass collapses each helper body to a wide access, which
// the inliner takes only when it measures the callee on what the emit
// issues; the asm snapshots hold that `mix` pays no call.
//
// Returns 0 on success, otherwise the number of the failing check.

typedef unsigned char u8;
typedef unsigned int u32;
typedef unsigned long long u64;

static u64 get_be64(const u8 *p) {
    u64 v = 0;
    int i;
    for (i = 0; i < 8; ++i) {
        v = (v << 8) | p[i];
    }
    return v;
}

static void put_be64(u8 *p, u64 v) {
    int i;
    for (i = 7; i >= 0; --i) {
        p[i] = (u8)v;
        v >>= 8;
    }
}

static u32 get_le32(const u8 *p) {
    return (u32)p[0] | ((u32)p[1] << 8) | ((u32)p[2] << 16) | ((u32)p[3] << 24);
}

// Eight round-trips through the leaves per call, as a compression
// function's block load / store does.
static void mix(u8 *state, const u8 *in) {
    int i;
    for (i = 0; i < 8; ++i) {
        u64 a = get_be64(state + 8 * i);
        u64 b = get_be64(in + 8 * i);
        put_be64(state + 8 * i, a ^ (b + (u64)get_le32(in + 4 * i)));
    }
}

int main(void) {
    u8 state[64];
    u8 in[64];
    unsigned i;

    for (i = 0; i < 64; ++i) {
        state[i] = (u8)(i * 7u + 1u);
        in[i] = (u8)(i * 13u + 5u);
    }
    if (get_be64(in) != 0x05121f2c39465360ull) {
        return 1;
    }
    if (get_le32(in) != 0x2c1f1205u) {
        return 2;
    }
    put_be64(state, 0x0102030405060708ull);
    if (get_be64(state) != 0x0102030405060708ull) {
        return 3;
    }
    if (state[0] != 0x01 || state[7] != 0x08) {
        return 4;
    }

    mix(state, in);
    if (get_be64(state) != (0x0102030405060708ull ^ (0x05121f2c39465360ull + 0x2c1f1205ull))) {
        return 5;
    }
    // Every group is covered, not just the first.
    for (i = 1; i < 8; ++i) {
        u64 want = (u64)((u8)((8 * i) * 7u + 1u));
        unsigned j;
        for (j = 1; j < 8; ++j) {
            want = (want << 8) | (u64)((u8)((8 * i + j) * 7u + 1u));
        }
        {
            u64 b = get_be64(in + 8 * i);
            u32 c = get_le32(in + 4 * i);
            if (get_be64(state + 8 * i) != (want ^ (b + (u64)c))) {
                return 6;
            }
        }
    }
    return 0;
}
