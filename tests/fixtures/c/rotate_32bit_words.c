// 32-bit unsigned rotates, `(x >> c) | (x << (32 - c))` and the left-hand
// form, with constant and runtime counts: each is the rotate of the low
// word, its result zero-extended, wherever the value is read. Shapes that
// are not a 32-bit rotate -- counts that do not sum to 32, an arithmetic
// right shift, a 64-bit operand -- keep their shifts. Returns 0 when every
// case matches a bit-walk reference; each failure returns a distinct code.

typedef unsigned u32;
typedef unsigned long long u64;

static u32 ref_ror(u32 x, int c) {
    u32 r = 0;
    for (int i = 0; i < 32; i++)
        if (x >> i & 1)
            r |= 1u << ((i - c) & 31);
    return r;
}

__attribute__((noinline)) static u32 ror2(u32 x) { return x << 30 | x >> 2; }
__attribute__((noinline)) static u32 ror7(u32 x) { return (x >> 7) | (x << 25); }
__attribute__((noinline)) static u32 rol13(u32 x) { return (x << 13) | (x >> 19); }
__attribute__((noinline)) static u32 rotr_var(u32 x, u32 c) { return (x >> c) | (x << (32 - c)); }
__attribute__((noinline)) static u32 rotl_var(u32 x, u32 c) { return (x << c) | (x >> (32 - c)); }
__attribute__((noinline)) static u64 widened(u32 x) { return (u64)(x << 30 | x >> 2) + 1; }
__attribute__((noinline)) static u32 not_rot(u32 x) { return (x >> 3) | (x << 30); }
__attribute__((noinline)) static int arith(int x) { return (x >> 2) | (int)((u32)x << 30); }
__attribute__((noinline)) static u64 wide(u64 y) { return (y >> 7) | (y << 25); }

int main(void) {
    static const u32 xs[] = {0u, 1u, 0x80000000u, 0x01234567u, 0xffffffffu, 0xdeadbeefu, 0x9e3779b9u};
    for (unsigned k = 0; k < sizeof xs / sizeof *xs; k++) {
        u32 x = xs[k];
        if (ror2(x) != ref_ror(x, 2)) return 1;
        if (ror7(x) != ref_ror(x, 7)) return 2;
        if (rol13(x) != ref_ror(x, 32 - 13)) return 3;
        for (volatile u32 c = 1; c < 32; c++) {
            if (rotr_var(x, c) != ref_ror(x, (int)c)) return 4;
            if (rotl_var(x, c) != ref_ror(x, 32 - (int)c)) return 5;
        }
        if (widened(x) != (u64)ref_ror(x, 2) + 1) return 6;
        if (not_rot(x) != ((x >> 3) | (u32)(x << 30))) return 7;
        if (arith((int)x) != (int)(((u32)((int)x >> 2)) | (x << 30))) return 8;
    }
    volatile u64 y = 0x0123456789abcdefULL;
    if (wide(y) != ((y >> 7) | (y << 25))) return 9;
    if (wide(y) == ((u64)ref_ror((u32)y, 7))) return 10;
    return 0;
}
