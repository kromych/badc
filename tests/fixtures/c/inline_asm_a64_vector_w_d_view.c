/* AArch64 inline asm: 8-byte vector values as `w` operands, read through
 * the d view (`%dN`) and the 64-bit arrangements (`%N.2s`, `%N.8b`), as
 * inputs, outputs, read-write and matched operands. An input is the
 * vector's bits, not its address, and a matched input of either width
 * enters the SIMD register of the output it names. AArch64 only; elsewhere
 * the unit is empty. */

#if defined(__aarch64__)
typedef float f32x2 __attribute__((vector_size(8)));
typedef unsigned char u8x8 __attribute__((vector_size(8)));
typedef unsigned long long u64x1 __attribute__((vector_size(8)));
typedef unsigned char u8x16 __attribute__((vector_size(16)));

static u8x16 xor16_matched(u8x16 a, u8x16 b) {
    u8x16 r;
    __asm__("eor %0.16b, %0.16b, %1.16b" : "=w"(r) : "w"(b), "0"(a));
    return r;
}

static f32x2 fadd2(f32x2 a, f32x2 b) {
    f32x2 r;
    __asm__("fadd %0.2s, %1.2s, %2.2s" : "=w"(r) : "w"(a), "w"(b));
    return r;
}

static f32x2 fmul2_matched(f32x2 a, f32x2 b) {
    f32x2 r;
    __asm__("fmul %0.2s, %0.2s, %1.2s" : "=w"(r) : "w"(b), "0"(a));
    return r;
}

static u8x8 xor8(u8x8 a, u8x8 b) {
    u8x8 r;
    __asm__("eor %0.8b, %1.8b, %2.8b" : "=w"(r) : "w"(a), "w"(b));
    return r;
}

static u64x1 add1(u64x1 a, u64x1 b) {
    u64x1 r;
    __asm__("add %d0, %d1, %d2" : "=w"(r) : "w"(a), "w"(b));
    return r;
}

static u64x1 sub_into(u64x1 acc, u64x1 b) {
    __asm__("sub %d0, %d0, %d1" : "+w"(acc) : "w"(b));
    return acc;
}

int main(void) {
    f32x2 a = {1.5f, -2.0f}, b = {0.5f, 4.0f};
    f32x2 s = fadd2(a, b), m = fmul2_matched(a, b);
    if (s[0] != 2.0f || s[1] != 2.0f) return 1;
    if (m[0] != 0.75f || m[1] != -8.0f) return 2;
    u8x8 x = {1, 2, 3, 4, 5, 6, 7, 8}, y = {0xff, 0, 0xf0, 0x0f, 0, 0, 0, 0x80};
    u8x8 e = xor8(x, y);
    if (e[0] != 0xfe || e[2] != 0xf3 || e[3] != 0x0b || e[7] != 0x88) return 3;
    u64x1 p = {40}, q = {2};
    if (add1(p, q)[0] != 42 || add1(q, q)[0] != 4) return 4;
    if (sub_into(p, q)[0] != 38) return 5;
    u8x16 h = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}, k = {0};
    k[15] = 0xf0;
    u8x16 z = xor16_matched(h, k);
    if (z[0] != 1 || z[14] != 15 || z[15] != 0xe0) return 6;
    return 0;
}
#else
int main(void) { return 0; }
#endif
