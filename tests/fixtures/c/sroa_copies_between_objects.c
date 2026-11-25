/* Whole-object copies between address-taken automatic aggregates: swaps
 * and rotations through temporaries, where each object is the source of a
 * copy into another, a copy of a member aggregate at an offset, objects
 * whose members the two ends name at different widths, and FP members.
 * `seed` is volatile, so no input is a translation-time constant. */

volatile long long seed = 11;

struct W { unsigned long long bits; };
struct P { long long a, b; };
struct Q { long long tag; struct P p; };
struct H { int lo, hi; };
union L { long long l; struct H h; };
struct D { double d; };

__attribute__((noinline)) long long swap_loop(long n) {
    struct W x = {seed}, y = {seed * 3};
    for (long i = 0; i < n; i++) {
        struct W t = x;
        x = y;
        y = t;
        y.bits += (unsigned long long)i;
    }
    return (long long)(x.bits - y.bits);
}

__attribute__((noinline)) long long rotate(long n) {
    struct P a = {seed, 1}, b = {2, seed}, c = {3, 4};
    for (long i = 0; i < n; i++) {
        struct P t = a;
        a = b;
        b = c;
        c = t;
        c.a += i;
    }
    return a.a * 1000000 + a.b * 10000 + b.a * 100 + c.b;
}

__attribute__((noinline)) long long member_copy(long n) {
    struct Q q = {seed, {seed + 1, seed + 2}};
    struct P r = {0, 0};
    for (long i = 0; i < n; i++) {
        struct P t = q.p;
        q.p = r;
        r = t;
        q.tag += r.a;
    }
    return q.tag + q.p.b - r.b;
}

__attribute__((noinline)) long long two_widths(long n) {
    union L u = {.l = seed};
    union L v;
    for (long i = 0; i < n; i++) {
        v = u;
        u.h.lo = v.h.hi + (int)i;
        u.h.hi = v.h.lo;
    }
    v = u;
    return v.l;
}

__attribute__((noinline)) double fp_swap(long n) {
    struct D x = {(double)seed}, y = {0.5};
    for (long i = 0; i < n; i++) {
        struct D t = x;
        x = y;
        y = t;
        y.d += 1.0;
    }
    return x.d - y.d;
}

int main(void) {
    if (swap_loop(5) != 20)
        return 1;
    if (rotate(4) != 3110501)
        return 2;
    if (member_copy(3) != 22)
        return 3;
    if (two_widths(3) != 0xc00000002LL)
        return 4;
    if (fp_swap(3) != -11.5)
        return 5;
    return 0;
}
