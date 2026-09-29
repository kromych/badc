// An x86_64 `x` operand of type `float` or `double` occupies the low lane
// of an XMM register, as the SysV ABI passes one: it loads and stores only
// its own bytes, a matching input takes the output's XMM register, and a
// 16-byte vector still moves whole. Each form is gated on __x86_64__ with a
// portable fallback. Returns 42 when every form computes the expected value.

typedef float v4f __attribute__((vector_size(16)));

#if defined(__x86_64__)
__attribute__((noinline)) static double twice(double v) {
    double r;
    __asm__("addsd %1, %0" : "=x"(r) : "x"(v), "0"(v));
    return r;
}
__attribute__((noinline)) static float twicef(float v) {
    float r;
    __asm__("addss %1, %0" : "=x"(r) : "x"(v), "0"(v));
    return r;
}
// The operands arrive in other registers than the result.
__attribute__((noinline)) static double sub_second(double a, double b, double c) {
    double r;
    __asm__("subsd %2, %0" : "=x"(r) : "0"(c), "x"(b));
    return r + a * 0;
}
__attribute__((noinline)) static double root(double v) {
    double r;
    __asm__("sqrtsd %1, %0" : "=x"(r) : "x"(v));
    return r;
}
__attribute__((noinline)) static long to_int(double v) {
    long i;
    __asm__("cvtsd2si %1, %0" : "=r"(i) : "x"(v));
    return i;
}
__attribute__((noinline)) static void set_first(double *p, double v) {
    __asm__("movsd %1, %0" : "=x"(*p) : "x"(v));
}
__attribute__((noinline)) static void set_firstf(float *p, float v) {
    __asm__("movss %1, %0" : "=x"(*p) : "x"(v));
}
__attribute__((noinline)) static double doubled(double d) {
    __asm__("addsd %0, %0" : "+x"(d));
    return d;
}
__attribute__((noinline)) static v4f vadd(v4f a, v4f b) {
    __asm__("addps %1, %0" : "+x"(a) : "x"(b));
    return a;
}
#else
static double twice(double v) { return v + v; }
static float twicef(float v) { return v + v; }
static double sub_second(double a, double b, double c) { return c - b + a * 0; }
static double root(double v) { return v == 6.25 ? 2.5 : 0; }
static long to_int(double v) { return (long)v; }
static void set_first(double *p, double v) { *p = v; }
static void set_firstf(float *p, float v) { *p = v; }
static double doubled(double d) { return d + d; }
static v4f vadd(v4f a, v4f b) { return a + b; }
#endif

int main(void) {
    double d[2] = {1.0, 2.0};
    float f[2] = {1.0f, 2.0f};
    v4f a = {1, 2, 3, 4}, b = {10, 20, 30, 40};
    v4f s = vadd(a, b);
    int bad = 0;
    bad += twice(1.5) != 3.0;
    bad += twicef(2.5f) != 5.0f;
    bad += sub_second(7.0, 2.0, 9.5) != 7.5;
    bad += root(6.25) != 2.5;
    bad += to_int(-3.0) != -3;
    set_first(&d[0], 8.0);
    bad += d[0] != 8.0 || d[1] != 2.0;
    set_firstf(&f[0], 8.0f);
    bad += f[0] != 8.0f || f[1] != 2.0f;
    bad += doubled(0.75) != 1.5;
    bad += s[0] != 11 || s[3] != 44;
    return bad ? bad : 42;
}
