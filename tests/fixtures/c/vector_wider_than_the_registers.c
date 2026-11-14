// A GNU vector of 32 or 64 bytes computes each operator lane-wise whatever
// width the target's SIMD registers have: every lane of a sum, difference,
// product, bitwise operation, negation, complement, shift and comparison
// matches the scalar operation on the lane. Returns 0 when every check
// passes, else a code naming the type and the operator.

typedef signed char s8x32 __attribute__((vector_size(32)));
typedef unsigned char u8x64 __attribute__((vector_size(64)));
typedef unsigned short u16x16 __attribute__((vector_size(32)));
typedef short s16x32 __attribute__((vector_size(64)));
typedef int s32x8 __attribute__((vector_size(32)));
typedef unsigned u32x16 __attribute__((vector_size(64)));
typedef unsigned long long u64x4 __attribute__((vector_size(32)));
typedef long long s64x8 __attribute__((vector_size(64)));
typedef float f32x8 __attribute__((vector_size(32)));
typedef float f32x16 __attribute__((vector_size(64)));
typedef double f64x4 __attribute__((vector_size(32)));
typedef double f64x8 __attribute__((vector_size(64)));

static unsigned long long state = 0x9e3779b97f4a7c15ull;

static unsigned long long next(void) {
    state = state * 6364136223846793005ull + 1442695040888963407ull;
    return state >> 11;
}

#define INT_CASE(V, E, ID)                                                       \
    __attribute__((noinline)) static void ops_##V(V *r, const V *pa, const V *pb) { \
        V a = *pa, b = *pb;                                                      \
        r[0] = a + b;                                                            \
        r[1] = a - b;                                                            \
        r[2] = a * b;                                                            \
        r[3] = a & b;                                                            \
        r[4] = a | b;                                                            \
        r[5] = a ^ b;                                                            \
        r[6] = -a;                                                               \
        r[7] = ~a;                                                               \
        r[8] = a << 3;                                                           \
        r[9] = a >> 5;                                                           \
        r[10] = (V)(a < b);                                                      \
        r[11] = (V)(a >= b);                                                     \
        r[12] = (V)(a == b);                                                     \
    }                                                                            \
    static int check_##V(void) {                                                 \
        enum { N = sizeof(V) / sizeof(E) };                                      \
        V a, b, r[13];                                                           \
        for (int i = 0; i < N; i++) {                                            \
            a[i] = (E)next();                                                    \
            b[i] = i % 3 ? (E)next() : a[i];                                     \
        }                                                                        \
        ops_##V(r, &a, &b);                                                      \
        for (int i = 0; i < N; i++) {                                            \
            unsigned long long x = (unsigned long long)a[i];                     \
            unsigned long long y = (unsigned long long)b[i];                     \
            E want[13] = {(E)(x + y), (E)(x - y), (E)(x * y), (E)(x & y),        \
                          (E)(x | y), (E)(x ^ y), (E)(0 - x), (E)~x,             \
                          (E)(x << 3), (E)(a[i] >> 5), (E)-(a[i] < b[i]),        \
                          (E)-(a[i] >= b[i]), (E)-(a[i] == b[i])};               \
            for (int k = 0; k < 13; k++)                                         \
                if (r[k][i] != want[k])                                          \
                    return ID * 16 + k + 1;                                      \
        }                                                                        \
        return 0;                                                                \
    }

#define FLOAT_CASE(V, E, ID)                                                     \
    __attribute__((noinline)) static void ops_##V(V *r, const V *pa, const V *pb) { \
        V a = *pa, b = *pb;                                                      \
        r[0] = a + b;                                                            \
        r[1] = a - b;                                                            \
        r[2] = a * b;                                                            \
        r[3] = a / b;                                                            \
        r[4] = -a;                                                               \
    }                                                                            \
    static int check_##V(void) {                                                 \
        enum { N = sizeof(V) / sizeof(E) };                                      \
        V a, b, r[5];                                                            \
        for (int i = 0; i < N; i++) {                                            \
            a[i] = (E)((long long)(next() % 2001) - 1000) / 8;                   \
            b[i] = (E)(next() % 1000 + 1) / 4;                                   \
        }                                                                        \
        ops_##V(r, &a, &b);                                                      \
        for (int i = 0; i < N; i++) {                                            \
            E want[5] = {a[i] + b[i], a[i] - b[i], a[i] * b[i], a[i] / b[i], -a[i]}; \
            for (int k = 0; k < 5; k++)                                          \
                if (r[k][i] != want[k])                                          \
                    return ID * 16 + k + 1;                                      \
        }                                                                        \
        return 0;                                                                \
    }

INT_CASE(s8x32, signed char, 1)
INT_CASE(u8x64, unsigned char, 2)
INT_CASE(u16x16, unsigned short, 3)
INT_CASE(s16x32, short, 4)
INT_CASE(s32x8, int, 5)
INT_CASE(u32x16, unsigned, 6)
INT_CASE(u64x4, unsigned long long, 7)
INT_CASE(s64x8, long long, 8)
FLOAT_CASE(f32x8, float, 9)
FLOAT_CASE(f32x16, float, 10)
FLOAT_CASE(f64x4, double, 11)
FLOAT_CASE(f64x8, double, 12)

int main(void) {
    int (*const checks[])(void) = {
        check_s8x32, check_u8x64, check_u16x16, check_s16x32, check_s32x8, check_u32x16,
        check_u64x4, check_s64x8, check_f32x8,  check_f32x16, check_f64x4,  check_f64x8,
    };
    for (unsigned i = 0; i < sizeof checks / sizeof checks[0]; i++) {
        int e = checks[i]();
        if (e)
            return e;
    }
    return 0;
}
