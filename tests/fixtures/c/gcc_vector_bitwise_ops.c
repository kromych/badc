// GCC vector extension: the bitwise operators `^`, `&`, `|` (and their
// compound `^=`, `&=`, `|=`) on two same-width vectors are element-wise.
// Bitwise ops carry no value between lanes, so the result is independent of
// how the byte block is chunked; the walker lowers it in the widest chunks
// that fit. This pins the operator layer on top of the vector-type foundation.
// Arithmetic and mixed vector/scalar operands still reject (checked elsewhere).
// Sizes stay data-model portable (int is 32-bit on every target).

typedef __attribute__((vector_size(16))) unsigned char u8x16;
typedef __attribute__((vector_size(16))) unsigned int u32x4;
typedef __attribute__((vector_size(8))) unsigned char u8x8;

// Trailing-form vector typedef used as a struct member, mirroring a common
// SIMD-state layout: a vector operator result stored back through a pointer.
typedef unsigned char StateVec __attribute__((vector_size(16)));
typedef struct {
    StateVec v;
} State;

static void xor_into(State *ret, const State *st, const State *key) {
    u8x16 t = (u8x16)st->v;
    ret->v = (StateVec)t ^ key->v;
}

static int same16(u8x16 v, const unsigned char *want) {
    const unsigned char *p = (const unsigned char *)&v;
    for (int i = 0; i < 16; i++) {
        if (p[i] != want[i]) return 0;
    }
    return 1;
}

int main(void) {
    u8x16 a = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    u8x16 b = {0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0,
               0xf0, 0xf0, 0xf0, 0xf0, 0x0f, 0x0f, 0x0f, 0x0f};

    const unsigned char *pa = (const unsigned char *)&a;
    const unsigned char *pb = (const unsigned char *)&b;
    unsigned char wx[16], wn[16], wo[16];
    for (int i = 0; i < 16; i++) {
        wx[i] = pa[i] ^ pb[i];
        wn[i] = pa[i] & pb[i];
        wo[i] = pa[i] | pb[i];
    }

    if (!same16(a ^ b, wx)) return 1;
    if (!same16(a & b, wn)) return 2;
    if (!same16(a | b, wo)) return 3;

    // Chained element-wise ops.
    if (!same16((a ^ b) ^ b, pa)) return 4; // x ^ y ^ y == x

    // Compound assignment updates in place.
    u8x16 t = a;
    t ^= b;
    if (!same16(t, wx)) return 5;
    t = a;
    t &= b;
    if (!same16(t, wn)) return 6;
    t = a;
    t |= b;
    if (!same16(t, wo)) return 7;

    // A 4-lane u32 vector: same 16 bytes, wider lanes, still element-wise.
    u32x4 c = (u32x4)a;
    u32x4 d = (u32x4)b;
    u32x4 e = c ^ d;
    if (!same16((u8x16)e, wx)) return 8;

    // An 8-byte vector exercises the single-chunk path.
    u8x8 h = {1, 2, 3, 4, 5, 6, 7, 8};
    u8x8 k = {0xff, 0, 0xff, 0, 0xff, 0, 0xff, 0};
    h ^= k;
    const unsigned char *ph = (const unsigned char *)&h;
    if (ph[0] != (1 ^ 0xff) || ph[1] != 2 || ph[7] != 8) return 9;

    // Store a vector operator result back through a pointer's member.
    State s, key, out;
    unsigned char *ps = (unsigned char *)&s, *pk = (unsigned char *)&key;
    for (int i = 0; i < 16; i++) {
        ps[i] = (unsigned char)(i * 7 + 1);
        pk[i] = (unsigned char)(200 - i);
    }
    xor_into(&out, &s, &key);
    const unsigned char *po = (const unsigned char *)&out;
    for (int i = 0; i < 16; i++) {
        if (po[i] != (unsigned char)(ps[i] ^ pk[i])) return 10;
    }

    return 0;
}
