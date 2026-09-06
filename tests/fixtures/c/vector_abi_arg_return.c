// A GCC `vector_size` value crossing a function boundary travels in the
// SIMD argument registers, not the general-purpose ones: System V AMD64
// psABI 3.2.3 classes a 16-byte vector SSE + SSEUP and assigns it one
// whole xmm0-xmm7 register; AAPCS64 6.4.2 Stage C.1 assigns a 64- or
// 128-bit Short Vector to v0-v7. Returns take the same banks (xmm0 /
// v0). This fixture pins the values that cross the boundary; the asm
// snapshots pin the registers.
//
// The paths covered:
//
//   * a 128-bit vector as an argument and as a return value,
//   * a 64-bit vector, which is one SSE eightbyte rather than a whole
//     vector register,
//   * a struct whose only member is a vector, which classifies as the
//     vector does,
//   * nine vector arguments, so the ninth exhausts the eight SIMD
//     argument registers and takes the stack slot instead,
//   * vectors interleaved with doubles, which share the same bank and
//     must not collide, and
//   * a vector wider than a register (32 bytes), which neither ABI
//     passes in one and both send to memory.
//
// Every check returns a distinct nonzero code, so the exit code is 0
// only when every path agrees.

typedef unsigned char u8x16 __attribute__((vector_size(16)));
typedef unsigned char u8x8 __attribute__((vector_size(8)));
typedef float f32x4 __attribute__((vector_size(16)));
typedef unsigned char u8x32 __attribute__((vector_size(32)));

struct wrap {
    u8x16 v;
};

// External linkage keeps the call boundary in the emitted code whatever
// the inliner decides about the bodies.
u8x16 vec_sub(u8x16 a, u8x16 b) { return b - a; }
u8x8 vec8_sub(u8x8 a, u8x8 b) { return b - a; }
f32x4 vecf_add(f32x4 a, f32x4 b) { return a + b; }
struct wrap wrap_double(struct wrap w) {
    struct wrap r;
    r.v = w.v + w.v;
    return r;
}
u8x16 nine(u8x16 a, u8x16 b, u8x16 c, u8x16 d, u8x16 e, u8x16 f, u8x16 g,
           u8x16 h, u8x16 i) {
    return a + b + c + d + e + f + g + h + i;
}
// Two vectors and two doubles interleaved: the vectors take v0/v1 (xmm0/
// xmm1) and the doubles v2/v3 (xmm2/xmm3), each argument advancing the
// one bank it belongs to.
double mixed(u8x16 a, double x, u8x16 b, double y) {
    return (double)(a[0] - b[0]) + x * y;
}
u8x32 wide_sub(u8x32 a, u8x32 b) { return b - a; }

static u8x16 ramp(unsigned char base) {
    u8x16 v;
    int i;
    for (i = 0; i < 16; i++) v[i] = (unsigned char)(base + i);
    return v;
}

int main(void) {
    int i;

    u8x16 a = ramp(1);
    u8x16 b = ramp(100);
    u8x16 r = vec_sub(a, b);
    for (i = 0; i < 16; i++) {
        if (r[i] != 99) return 1;
    }

    u8x8 p, q;
    for (i = 0; i < 8; i++) {
        p[i] = (unsigned char)(i + 1);
        q[i] = (unsigned char)(i + 40);
    }
    u8x8 r8 = vec8_sub(p, q);
    for (i = 0; i < 8; i++) {
        if (r8[i] != 39) return 2;
    }

    f32x4 fa = {1.0f, 2.0f, 3.0f, 4.0f};
    f32x4 fb = {10.0f, 20.0f, 30.0f, 40.0f};
    f32x4 fr = vecf_add(fa, fb);
    if (fr[0] != 11.0f || fr[1] != 22.0f || fr[2] != 33.0f || fr[3] != 44.0f) {
        return 3;
    }

    struct wrap w;
    w.v = ramp(2);
    struct wrap wr = wrap_double(w);
    for (i = 0; i < 16; i++) {
        if (wr.v[i] != (unsigned char)(2 * (2 + i))) return 4;
    }

    u8x16 one = ramp(1);
    u8x16 n = nine(one, one, one, one, one, one, one, one, one);
    for (i = 0; i < 16; i++) {
        if (n[i] != (unsigned char)(9 * (1 + i))) return 5;
    }

    // 50 - 10 = 40 in lane 0, plus 3.0 * 4.0.
    if (mixed(ramp(50), 3.0, ramp(10), 4.0) != 52.0) return 6;

    u8x32 wa, wb;
    for (i = 0; i < 32; i++) {
        wa[i] = (unsigned char)(i + 1);
        wb[i] = (unsigned char)(i + 70);
    }
    u8x32 wsub = wide_sub(wa, wb);
    for (i = 0; i < 32; i++) {
        if (wsub[i] != 69) return 7;
    }

    return 0;
}
