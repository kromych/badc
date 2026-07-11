// GCC `__attribute__((vector_size(N)))` names an N-byte vector of the base
// type (a widely-used extension; the C standard leaves SIMD types as a gap).
// badc models it as a synthesized aggregate of `N / sizeof(base)` lanes so
// sizeof, brace initialization, copy, pass/return by value, and same-size
// reinterpret casts fall out of the existing struct machinery. Element-wise
// operators and the NEON intrinsics are a separate layer; this fixture pins
// the type foundation. Sizes stay data-model portable (int is 32-bit and
// float 32-bit on every target).

typedef __attribute__((vector_size(16))) unsigned char u8x16;
typedef __attribute__((vector_size(16))) unsigned int  u32x4;
typedef __attribute__((vector_size(8)))  float          f32x2;

// The attribute also binds in the trailing position, after the declarator.
typedef unsigned char u8x16_trailing __attribute__((vector_size(16)));

// Pass and return a vector by value.
static u8x16 identity(u8x16 v) { return v; }

int main(void) {
    // sizeof reflects the byte width, independent of the element type.
    if (sizeof(u8x16) != 16) return 1;
    if (sizeof(u32x4) != 16) return 2;
    if (sizeof(f32x2) != 8) return 3;

    // Lane count = width / element size.
    if (sizeof(u8x16) / sizeof(unsigned char) != 16) return 4;
    if (sizeof(u32x4) / sizeof(unsigned int) != 4) return 5;

    // Brace initialization fills lanes in order; `{}` zero-fills.
    u8x16 a = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    u8x16 z = {};

    // Copy and pass/return by value preserve every lane.
    u8x16 b = identity(a);
    unsigned char *pb = (unsigned char *)&b;
    if (pb[0] != 1 || pb[7] != 8 || pb[15] != 16) return 6;

    unsigned char *pz = (unsigned char *)&z;
    for (int i = 0; i < 16; i++) {
        if (pz[i] != 0) return 7;
    }

    // A same-size vector-to-vector cast reinterprets the bytes.
    u32x4 r = (u32x4)a;
    unsigned char *pr = (unsigned char *)&r;
    if (pr[0] != 1 || pr[15] != 16) return 8;

    // The attribute applies directly at block scope, without a typedef.
    __attribute__((vector_size(16))) unsigned char d =
        {16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1};
    unsigned char *pd = (unsigned char *)&d;
    if (pd[0] != 16 || pd[15] != 1) return 9;

    // The attribute does not leak onto the next declaration: a plain scalar
    // that follows a vector object keeps its own width.
    unsigned char scalar = 3;
    if (scalar != 3 || sizeof(scalar) != 1) return 10;

    // The trailing-position typedef names the same 16-byte vector; it must
    // size correctly as a struct member too (a scalar-sized member would
    // truncate the aggregate).
    if (sizeof(u8x16_trailing) != 16) return 11;
    u8x16_trailing tv = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 15, 14, 13, 12, 11, 10};
    unsigned char *ptv = (unsigned char *)&tv;
    if (ptv[0] != 9 || ptv[15] != 10) return 12;
    struct {
        u8x16_trailing m;
    } holder;
    holder.m = tv;
    unsigned char *ph = (unsigned char *)&holder;
    if (sizeof(holder) != 16 || ph[0] != 9 || ph[15] != 10) return 13;

    return 0;
}
