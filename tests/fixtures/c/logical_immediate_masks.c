/* AND, ORR and EOR against constants: bitmask immediates of each element
 * size in the 64- and 32-bit forms, masks outside that encoding, masks
 * invariant in a loop, mask tests ahead of a branch and bit-field updates.
 * Each result is checked against the same operation with the mask read
 * from a volatile object. */

typedef unsigned long long u64;
typedef unsigned int u32;

u64 inputs[] = {
    0x0123456789abcdefULL, 0xfedcba9876543210ULL, 0, 0xffffffffffffffffULL,
    0x8000000000000001ULL, 0x00000000ffffffffULL, 0x5a5a5a5a0f0f0f0fULL, 42,
};
#define N (int)(sizeof inputs / sizeof inputs[0])

static u64 ref_and(u64 x, u64 m) { volatile u64 v = m; return x & v; }
static u64 ref_or(u64 x, u64 m) { volatile u64 v = m; return x | v; }
static u64 ref_xor(u64 x, u64 m) { volatile u64 v = m; return x ^ v; }
static u32 ref_and32(u32 x, u32 m) { volatile u32 v = m; return x & v; }
static u32 ref_or32(u32 x, u32 m) { volatile u32 v = m; return x | v; }
static u32 ref_xor32(u32 x, u32 m) { volatile u32 v = m; return x ^ v; }

/* 64-bit masks, one per element size. */
__attribute__((noinline)) u64 and_e64(u64 x) { return x & 0xff; }
__attribute__((noinline)) u64 or_e8(u64 x) { return x | 0xf0f0f0f0f0f0f0f0ULL; }
__attribute__((noinline)) u64 xor_top(u64 x) { return x ^ 0x8000000000000000ULL; }
__attribute__((noinline)) u64 and_align(u64 x) { return x & ~15ULL; }
__attribute__((noinline)) u64 or_wrap(u64 x) { return x | 0xff000000000000ffULL; }
__attribute__((noinline)) u64 xor_e2(u64 x) { return x ^ 0x5555555555555555ULL; }
__attribute__((noinline)) u64 and_e4(u64 x) { return x & 0x7777777777777777ULL; }
__attribute__((noinline)) u64 and_e16(u64 x) { return x & 0x00ff00ff00ff00ffULL; }
__attribute__((noinline)) u64 or_e32(u64 x) { return x | 0x0000ffff0000ffffULL; }
__attribute__((noinline)) u64 xor_run(u64 x) { return x ^ 0x00000ffffff00000ULL; }

/* 32-bit operands with masks that repeat within the low word only. */
__attribute__((noinline)) u32 and32_e8(u32 x) { return x & 0x0f0f0f0fu; }
__attribute__((noinline)) u32 or32_top(u32 x) { return x | 0x80000000u; }
__attribute__((noinline)) u32 xor32_e16(u32 x) { return x ^ 0x00ff00ffu; }
__attribute__((noinline)) int and32_neg(int x) { return x & -256; }
__attribute__((noinline)) int xor32_e2(int x) { return x ^ 0x55555555; }
__attribute__((noinline)) int or32_e4(int x) { return x | 0x33333333; }

/* Masks that are not bitmask immediates. */
__attribute__((noinline)) u64 and_plain(u64 x) { return x & 0x1234; }
__attribute__((noinline)) u64 or_plain(u64 x) { return x | 0x12345678; }
__attribute__((noinline)) u64 xor_plain(u64 x) { return x ^ 5; }

__attribute__((noinline)) u64 mix_loop(const u64 *v, int n) {
    u64 acc = 1;
    for (int i = 0; i < n; i++) {
        acc = ((acc << 7) | (acc >> 57)) ^ (v[i] & 0xff00ff00ff00ff00ULL);
        acc |= 0x10;
        acc ^= v[i] & 0x1234;
    }
    return acc;
}

static u64 mix_ref(const u64 *v, int n) {
    volatile u64 m1 = 0xff00ff00ff00ff00ULL, m2 = 0x10, m3 = 0x1234;
    u64 acc = 1;
    for (int i = 0; i < n; i++) {
        acc = ((acc << 7) | (acc >> 57)) ^ (v[i] & m1);
        acc |= m2;
        acc ^= v[i] & m3;
    }
    return acc;
}

__attribute__((noinline)) int classify(u64 x) {
    int r = 0;
    if (x & 0x40)
        r |= 1;
    if ((x & 0xf0) == 0x30)
        r |= 2;
    if (!(x & 0x8000000000000000ULL))
        r |= 4;
    if ((u32)x & 0x0f0f0f0fu)
        r |= 8;
    return r;
}

static int classify_ref(u64 x) {
    volatile u64 a = 0x40, b = 0xf0, c = 0x8000000000000000ULL;
    volatile u32 d = 0x0f0f0f0fu;
    int r = 0;
    if (x & a)
        r |= 1;
    if ((x & b) == 0x30)
        r |= 2;
    if (!(x & c))
        r |= 4;
    if ((u32)x & d)
        r |= 8;
    return r;
}

struct fields {
    unsigned a : 3, b : 5, c : 8, d : 16;
};

__attribute__((noinline)) u32 update(struct fields *f, u32 v) {
    f->b = v;
    f->d ^= v;
    return f->a + f->b + f->c + f->d;
}

int main(void) {
    for (int i = 0; i < N; i++) {
        u64 x = inputs[i];
        u32 w = (u32)x;
        if (and_e64(x) != ref_and(x, 0xff))
            return 1;
        if (or_e8(x) != ref_or(x, 0xf0f0f0f0f0f0f0f0ULL))
            return 2;
        if (xor_top(x) != ref_xor(x, 0x8000000000000000ULL))
            return 3;
        if (and_align(x) != ref_and(x, ~15ULL))
            return 4;
        if (or_wrap(x) != ref_or(x, 0xff000000000000ffULL))
            return 5;
        if (xor_e2(x) != ref_xor(x, 0x5555555555555555ULL))
            return 6;
        if (and_e4(x) != ref_and(x, 0x7777777777777777ULL))
            return 7;
        if (and_e16(x) != ref_and(x, 0x00ff00ff00ff00ffULL))
            return 8;
        if (or_e32(x) != ref_or(x, 0x0000ffff0000ffffULL))
            return 9;
        if (xor_run(x) != ref_xor(x, 0x00000ffffff00000ULL))
            return 10;
        if (and32_e8(w) != ref_and32(w, 0x0f0f0f0fu))
            return 11;
        if (or32_top(w) != ref_or32(w, 0x80000000u))
            return 12;
        if (xor32_e16(w) != ref_xor32(w, 0x00ff00ffu))
            return 13;
        if ((long long)and32_neg((int)w) != (long long)(int)ref_and32(w, (u32)-256))
            return 14;
        if ((long long)xor32_e2((int)w) != (long long)(int)ref_xor32(w, 0x55555555u))
            return 15;
        if ((long long)or32_e4((int)w) != (long long)(int)ref_or32(w, 0x33333333u))
            return 16;
        if (and_plain(x) != ref_and(x, 0x1234))
            return 17;
        if (or_plain(x) != ref_or(x, 0x12345678))
            return 18;
        if (xor_plain(x) != ref_xor(x, 5))
            return 19;
        if (classify(x) != classify_ref(x))
            return 20;
    }
    if (mix_loop(inputs, N) != mix_ref(inputs, N))
        return 21;
    if (and_e64(0x0123456789abcdefULL) != 0xef)
        return 22;
    if (or_e8(0x0123456789abcdefULL) != 0xf1f3f5f7f9fbfdffULL)
        return 23;
    if (xor_top(0x0123456789abcdefULL) != 0x8123456789abcdefULL)
        return 24;
    if (and32_e8(0x89abcdefu) != 0x090b0d0fu)
        return 25;
    {
        struct fields f = {5, 17, 200, 0xbeef};
        volatile u32 v = 0x12345;
        u32 sum = update(&f, v);
        if (f.a != 5 || f.b != (0x12345 & 31) || f.c != 200 ||
            f.d != ((0xbeef ^ 0x12345) & 0xffff))
            return 26;
        if (sum != f.a + f.b + f.c + f.d)
            return 27;
    }
    return 42;
}
