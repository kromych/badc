/* The GNU vector comparisons of two vectors, the shifts by a constant count
 * and unary `-` and `~` give each lane the result of the scalar operation:
 * all ones where a comparison holds, signed and unsigned, at 8- to 64-bit
 * lanes in 8- and 16-byte vectors. Where the target has one instruction
 * for an operation on the whole vector, it computes it. Each failing group
 * returns its own code. */
typedef signed char s8 __attribute__((vector_size(16)));
typedef unsigned char u8 __attribute__((vector_size(16)));
typedef short s16 __attribute__((vector_size(8)));
typedef unsigned short u16 __attribute__((vector_size(8)));
typedef int s32 __attribute__((vector_size(16)));
typedef unsigned int u32 __attribute__((vector_size(16)));
typedef long long s64 __attribute__((vector_size(16)));
typedef unsigned long long u64 __attribute__((vector_size(16)));
#define CHECK(V, E, A, B, N) do { V r1 = (V)(A < B), r2 = (V)(A <= B), r3 = (V)(A > B), r4 = (V)(A >= B), r5 = (V)(A == B); \
    for (int i = 0; i < N; i++) { \
        if (r1[i] != (A[i] < B[i] ? -1 : 0) || r2[i] != (A[i] <= B[i] ? -1 : 0) || r3[i] != (A[i] > B[i] ? -1 : 0) \
            || r4[i] != (A[i] >= B[i] ? -1 : 0) || r5[i] != (A[i] == B[i] ? -1 : 0)) return E; } } while (0)
int main(void) {
    s8 a = {-128, -1, 0, 1, 127, 5, -5, 3, 3, 9, -9, 100, -100, 0, 7, 8};
    s8 b = {127, 1, 0, -1, -128, 5, 5, -3, 3, 8, -10, 101, -99, 1, 7, 9};
    CHECK(s8, 1, a, b, 16);
    u8 ua = (u8)a, ub = (u8)b;
    CHECK(s8, 2, ua, ub, 16);
    s16 c = {-32768, 1, 300, -2}, d = {32767, 1, -300, -3};
    CHECK(s16, 3, c, d, 4);
    u16 uc = (u16)c, ud = (u16)d;
    CHECK(s16, 4, uc, ud, 4);
    s32 e = {-5, 0x7fffffff, 3, 0}, f = {5, -1, 3, 0};
    CHECK(s32, 5, e, f, 4);
    u32 ue = (u32)e, uf = (u32)f;
    CHECK(s32, 6, ue, uf, 4);
    s64 g = {-1, 5}, h = {1, 5};
    CHECK(s64, 7, g, h, 2);
    u64 ug = (u64)g, uh = (u64)h;
    CHECK(s64, 8, ug, uh, 2);
    s8 sl = a << 3, sr = a >> 2; u8 ur = ua >> 3; s16 cl = c << 5, cr = c >> 15;
    for (int i = 0; i < 16; i++) if (sl[i] != (signed char)(a[i] << 3) || sr[i] != a[i] >> 2 || ur[i] != ua[i] >> 3) return 9;
    for (int i = 0; i < 4; i++) if (cl[i] != (short)(c[i] << 5) || cr[i] != c[i] >> 15) return 10;
    s32 en = -e, ec = ~e; s64 gn = -g; u8 un = ~ua;
    for (int i = 0; i < 4; i++) if (en[i] != (int)(0u - (unsigned)e[i]) || ec[i] != ~e[i]) return 11;
    if (gn[0] != 1 || gn[1] != -5) return 12;
    for (int i = 0; i < 16; i++) if (un[i] != (unsigned char)~ua[i]) return 13;
    return 0;
}
