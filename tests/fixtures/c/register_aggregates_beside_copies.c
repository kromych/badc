/* Aggregates passed and returned in registers in functions that also copy
 * other aggregates: the parameter object and the call's result temporary
 * take their register parts field by field whatever other copies the
 * function makes. `seed` is volatile, so no input is a translation-time
 * constant. */

volatile long seed = 5;

struct W { unsigned long bits; };
struct S { char c; int i; };
struct P { long a, b; };
struct B { char c; char d[3]; };

__attribute__((noinline)) struct W make_w(long v) { struct W w = {(unsigned long)v * 3}; return w; }
__attribute__((noinline)) struct S make_s(long v) { struct S s = {(char)v, (int)v * 7}; return s; }
__attribute__((noinline)) struct P make_p(long v) { struct P p = {v, -v}; return p; }
__attribute__((noinline)) struct B make_b(char v) { struct B b = {v, {1, 2, 3}}; return b; }

__attribute__((noinline)) long param_beside(struct S s, struct P *dst, const struct P *src) {
    *dst = *src;
    struct S t = s;
    return t.c + t.i + dst->a;
}

__attribute__((noinline)) long results_beside(struct P *dst, const struct P *src) {
    *dst = *src;
    struct W w = make_w(seed);
    struct S s = make_s(seed);
    struct P p = make_p(seed);
    struct B b = make_b((char)seed);
    return (long)w.bits + s.c + s.i + p.a - p.b + b.c + b.d[2] + dst->b;
}

int main(void) {
    struct P src = {seed, seed * 2}, dst = {0, 0};
    struct S s = {3, 40};
    if (param_beside(s, &dst, &src) != 48)
        return 1;
    if (results_beside(&dst, &src) != 83)
        return 2;
    return 0;
}
