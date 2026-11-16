// A GNU vector shifted by a vector of counts shifts each lane by the count
// in the same lane: left, right logically for an unsigned lane and right
// arithmetically for a signed one, every count within the lane width. Each
// lane is checked against the scalar shift. Returns 0 when every check
// passes, else a code naming the type and the operator.

typedef signed char s8x16 __attribute__((vector_size(16)));
typedef unsigned char u8x16 __attribute__((vector_size(16)));
typedef short s16x8 __attribute__((vector_size(16)));
typedef unsigned short u16x16 __attribute__((vector_size(32)));
typedef int s32x8 __attribute__((vector_size(32)));
typedef unsigned u32x4 __attribute__((vector_size(16)));
typedef long long s64x2 __attribute__((vector_size(16)));
typedef unsigned long long u64x4 __attribute__((vector_size(32)));

static unsigned long long state = 0x2545f4914f6cdd1dull;

static unsigned long long next(void) {
    state = state * 6364136223846793005ull + 1442695040888963407ull;
    return state >> 11;
}

#define CASE(V, E, ID)                                                           \
    __attribute__((noinline)) static void shifts_##V(V *r, const V *pa, const V *pc) { \
        V a = *pa, c = *pc;                                                      \
        r[0] = a << c;                                                           \
        r[1] = a >> c;                                                           \
    }                                                                            \
    static int check_##V(void) {                                                 \
        enum { N = sizeof(V) / sizeof(E), BITS = 8 * sizeof(E) };                \
        V a, c, r[2];                                                            \
        for (int k = 0; k < 20; k++) {                                           \
            for (int i = 0; i < N; i++) {                                        \
                a[i] = (E)next();                                                \
                c[i] = (E)(next() % BITS);                                       \
            }                                                                    \
            shifts_##V(r, &a, &c);                                               \
            for (int i = 0; i < N; i++) {                                        \
                E left = (E)((unsigned long long)a[i] << c[i]);                  \
                E right = (E)(a[i] >> c[i]);                                     \
                if (r[0][i] != left)                                             \
                    return 2 * ID + 1;                                           \
                if (r[1][i] != right)                                            \
                    return 2 * ID + 2;                                           \
            }                                                                    \
        }                                                                        \
        return 0;                                                                \
    }

CASE(s8x16, signed char, 0)
CASE(u8x16, unsigned char, 1)
CASE(s16x8, short, 2)
CASE(u16x16, unsigned short, 3)
CASE(s32x8, int, 4)
CASE(u32x4, unsigned, 5)
CASE(s64x2, long long, 6)
CASE(u64x4, unsigned long long, 7)

int main(void) {
    int (*const checks[])(void) = {check_s8x16, check_u8x16, check_s16x8, check_u16x16,
                                   check_s32x8, check_u32x4, check_s64x2, check_u64x4};
    for (unsigned i = 0; i < sizeof checks / sizeof checks[0]; i++) {
        int e = checks[i]();
        if (e)
            return e;
    }
    return 0;
}
