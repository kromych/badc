/* AArch64 inline asm: the `w` operand at every width gcc and clang take --
 * a float, a double, an 8-, 16-, 32- and 64-bit integer, and 8- and 16-byte
 * vectors -- as an input, an output, a read-write and a matched operand, and
 * the `x` and `y` classes beside it. `%bN`, `%hN`, `%sN`, `%dN` and `%qN`
 * name an operand's views; an output stores its own width alone, which the
 * bytes after it check. clang takes no 1-byte `w` operand and `x` only for a
 * 16-byte one, `y` for none of these; gcc takes them all, and so does badc.
 * The exit code is the line of the first mismatch. Elsewhere the program
 * exits 0. */

#if defined(__aarch64__)
#include <arm_neon.h>
#include <string.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

static float add_s(float a, float b) {
    float r;
    __asm__("fadd %s0, %s1, %s2" : "=w"(r) : "w"(a), "w"(b));
    return r;
}

static float neg_s(float a) {
    __asm__("fneg %s0, %s0" : "+w"(a));
    return a;
}

static float mul_s_matched(float a, float b) {
    float r;
    __asm__("fmul %s0, %s0, %s2" : "=w"(r) : "0"(a), "w"(b));
    return r;
}

static double sub_d(double a, double b) {
    double r;
    __asm__("fsub %d0, %d1, %d2" : "=w"(r) : "w"(a), "w"(b));
    return r;
}

static double abs_d(double a) {
    __asm__("fabs %d0, %d0" : "+w"(a));
    return a;
}

#if !defined(__clang__)
static float add_s_xy(float a, float b) {
    float r;
    __asm__("fadd %s0, %s1, %s2" : "=x"(r) : "x"(a), "y"(b));
    return r;
}
#endif

static int32x4_t add_4s_x(int32x4_t a, int32x4_t b) {
    int32x4_t r;
    __asm__("add %0.4s, %1.4s, %2.4s" : "=x"(r) : "x"(a), "x"(b));
    return r;
}

static long long add_ll(long long a, long long b) {
    long long r;
    __asm__("add %d0, %d1, %d2" : "=w"(r) : "w"(a), "w"(b));
    return r;
}

static int int_bits(float f) {
    int r;
    __asm__("fmov %w0, %s1" : "=r"(r) : "w"(f));
    return r;
}

static int int_through_w(int i) {
    int r;
    __asm__("fmov %w0, %s1" : "=r"(r) : "w"(i));
    return r;
}

static int8x8_t add_8b(int8x8_t a, int8x8_t b) {
    int8x8_t r;
    __asm__("add %0.8b, %1.8b, %2.8b" : "=w"(r) : "w"(a), "w"(b));
    return r;
}

static int8x8_t neg_8b(int8x8_t a) {
    __asm__("neg %0.8b, %0.8b" : "+w"(a));
    return a;
}

static int32x4_t add_4s_matched(int32x4_t a, int32x4_t b) {
    int32x4_t r;
    __asm__("add %0.4s, %0.4s, %2.4s" : "=w"(r) : "0"(a), "w"(b));
    return r;
}

/* An output of each integer width written from a GP register through the
   lane view, with the bytes after it left as they were. */
struct guarded {
    union {
        char c;
        short s;
        int i;
        long long ll;
    } v;
    unsigned char after[8];
};

static int narrow_outputs(void) {
    struct guarded g;
    memset(&g, 0xa5, sizeof g);
#if !defined(__clang__)
    __asm__("ins %0.b[0], %w1" : "=w"(g.v.c) : "r"(0x5a));
    CHECK(g.v.c == 0x5a && ((unsigned char *)&g.v)[1] == 0xa5);
    char c = 3;
    __asm__("add %0.8b, %0.8b, %0.8b" : "+w"(c));
    CHECK(c == 6);
#endif
    __asm__("ins %0.h[0], %w1" : "=w"(g.v.s) : "r"(0x1234));
    CHECK(g.v.s == 0x1234 && ((unsigned char *)&g.v)[2] == 0xa5);
    __asm__("fmov %s0, %w1" : "=w"(g.v.i) : "r"(0x13572468));
    CHECK(g.v.i == 0x13572468 && ((unsigned char *)&g.v)[4] == 0xa5);
    __asm__("fmov %d0, %x1" : "=w"(g.v.ll) : "r"(0x0102030405060708LL));
    CHECK(g.v.ll == 0x0102030405060708LL && g.after[0] == 0xa5);
    short s = 300;
    __asm__("add %0.4h, %0.4h, %0.4h" : "+w"(s));
    CHECK(s == 600);
    return 0;
}

/* Each view of one 16-byte operand stores its own width. */
static int views(void) {
    uint8x16_t v = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    unsigned char out[16];
    memset(out, 0, sizeof out);
    __asm__("str %b1, [%0]" : : "r"(out), "w"(v) : "memory");
    CHECK(out[0] == 1 && out[1] == 0);
    __asm__("str %h1, [%0]" : : "r"(out), "w"(v) : "memory");
    CHECK(out[1] == 2 && out[2] == 0);
    __asm__("str %s1, [%0]" : : "r"(out), "w"(v) : "memory");
    CHECK(out[3] == 4 && out[4] == 0);
    __asm__("str %d1, [%0]" : : "r"(out), "w"(v) : "memory");
    CHECK(out[7] == 8 && out[8] == 0);
    __asm__("str %q1, [%0]" : : "r"(out), "w"(v) : "memory");
    CHECK(out[15] == 16);
    return 0;
}

static int run(void) {
    volatile float two = 2.0f, three = 3.0f;
    CHECK(add_s(two, three) == 5.0f);
    CHECK(neg_s(two) == -2.0f);
    CHECK(mul_s_matched(two, three) == 6.0f);
#if !defined(__clang__)
    CHECK(add_s_xy(two, three) == 5.0f);
#endif
    CHECK(int_bits(1.0f) == 0x3f800000);
    CHECK(int_through_w(0x40490fdb) == 0x40490fdb);
    volatile double d = 7.5;
    CHECK(sub_d(d, 2.25) == 5.25);
    CHECK(abs_d(-d) == 7.5);
    CHECK(add_ll(1LL << 40, 5) == (1LL << 40) + 5);
    int8x8_t a = {1, 2, 3, 4, 5, 6, 7, 8}, b = {10, 20, 30, 40, 50, 60, 70, 80};
    int8x8_t s8 = add_8b(a, b), n8 = neg_8b(a);
    CHECK(s8[0] == 11 && s8[7] == 88 && n8[3] == -4);
    int32x4_t p = {1, 2, 3, 4}, q = {100, 200, 300, 400};
    int32x4_t s4 = add_4s_matched(p, q), x4 = add_4s_x(p, q);
    CHECK(s4[0] == 101 && s4[3] == 404 && x4[1] == 202);
    int line = narrow_outputs();
    return line ? line : views();
}

int main(void) {
    return run();
}
#else
int main(void) {
    return 0;
}
#endif
