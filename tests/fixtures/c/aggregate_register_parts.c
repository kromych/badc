/* Aggregates the host ABIs pass and return in registers (System V AMD64
   3.2.3, AAPCS64 6.4.2, Win64): the shapes -O keeps in registers -- whole
   eightbytes, sub-register fields, a short tail, byte fields, floating-point
   members -- and the ones that keep their frame object: an address that
   escapes, a union, a float beside an integer, two floats in one eightbyte,
   a memory-class aggregate. Each result is checked against scalar
   arithmetic; the exit code names the first mismatch. A 64-bit field or
   value is `long long`: `long` is 32 bits under LLP64. */

#include <stdarg.h>

#define NOINLINE __attribute__((noinline))

struct P { long long a, b; };
struct Q { int a, b; };
struct R { long long a; int b; };
struct S { char x[3]; };
struct T { char c; short s; int i; long long l; };
struct D { double x, y; };
struct F3 { float x, y, z; };
struct F1 { float x; };
struct DL { double d; long long l; };
struct FI { float f; int i; };
union U { long long l; double d; };
struct W1 { char c; };
struct W2 { short s; };
struct W4 { int i; };
struct W8 { long long l; };
struct N { struct Q q; long long l; };
struct PP { int *p; long long n; };
struct B { long long a, b, c; };

NOINLINE struct P by_value(struct P v) { v.a += 1; return v; }
NOINLINE struct P make_pair(long long a, long long b) { struct P p; p.a = a; p.b = b; return p; }
NOINLINE struct Q swapq(struct Q v) { struct Q r; r.a = v.b; r.b = v.a; return r; }
NOINLINE struct R tail(struct R v) { struct R r; r.a = v.a + v.b; r.b = v.b * 2; return r; }
NOINLINE struct S bytes(struct S v) { v.x[0] += 1; v.x[1] += 2; v.x[2] += 3; return v; }
NOINLINE struct T mixed(struct T v) {
    struct T r;
    r.c = (char)(v.c + 1);
    r.s = (short)(v.s + v.c);
    r.i = v.i + v.s;
    r.l = v.l + v.i;
    return r;
}
NOINLINE struct D dsum(struct D v) { struct D r; r.x = v.x + v.y; r.y = v.x - v.y; return r; }
NOINLINE struct F3 rot3(struct F3 v) { struct F3 r; r.x = v.y; r.y = v.z; r.z = v.x; return r; }
NOINLINE struct F1 twice(struct F1 v) { v.x = v.x * 2; return v; }
NOINLINE struct DL dl(struct DL v) { v.d = v.d * 2; v.l += 1; return v; }
NOINLINE struct FI fi(struct FI v) { v.f += 1; v.i += 1; return v; }
NOINLINE union U ubump(union U v) { v.l += 1; return v; }
NOINLINE struct W1 w1(struct W1 v) { v.c += 1; return v; }
NOINLINE struct W2 w2(struct W2 v) { v.s += 1; return v; }
NOINLINE struct W4 w4(struct W4 v) { v.i += 1; return v; }
NOINLINE struct W8 w8(struct W8 v) { v.l += 1; return v; }
NOINLINE struct N nested(struct N v) {
    struct N r;
    r.q.a = v.q.b;
    r.q.b = v.q.a;
    r.l = v.l + v.q.a;
    return r;
}
NOINLINE struct PP pp(struct PP v) { v.p += 1; v.n -= 1; return v; }
NOINLINE struct B big(struct B v) { v.c += v.a + v.b; return v; }

NOINLINE long long sum_via_ptr(const struct P *p) { return p->a + p->b; }
NOINLINE void bump_via_ptr(struct P *p) { p->a += 10; p->b += 20; }
NOINLINE long long escape(struct P v) { return sum_via_ptr(&v); }
NOINLINE struct P escape_ret(struct P v) { bump_via_ptr(&v); return v; }
NOINLINE struct P forward(struct P v) { return by_value(v); }
NOINLINE struct P pick(struct P v, int k) {
    if (k) {
        return v;
    }
    return make_pair(v.b, v.a);
}
NOINLINE long long live(struct P v, long long k) {
    long long t = k * 3;
    struct P w = by_value(v);
    return t + w.a + w.b;
}
struct P g = {100, 200};
NOINLINE struct P ret_global(void) { return g; }
NOINLINE struct P lit(long long x) { return (struct P){x, x + 1}; }
NOINLINE struct P rec(struct P v, int n) {
    if (n == 0) {
        return v;
    }
    v.a += n;
    return rec(v, n - 1);
}
NOINLINE long long loop(struct P v) {
    long long s = 0;
    int i;
    for (i = 0; i < 4; i++) {
        s += v.a;
        v.a += v.b;
    }
    return s;
}
NOINLINE long long spill(struct P v, long long a, long long b, long long c,
                         long long d, long long e, long long f) {
    long long m0 = a * b, m1 = c * d, m2 = e * f, m3 = a + c + e, m4 = b + d + f;
    long long m5 = m0 ^ m1, m6 = m2 ^ m3, m7 = m4 * 7;
    struct P w = by_value(v);
    return m0 + m1 + m2 + m3 + m4 + m5 + m6 + m7 + w.a * 1000 + w.b;
}
NOINLINE struct P self_assign(struct P v) { v = v; v.b -= v.a; return v; }
NOINLINE long long lo128(__int128 a, long long c) { return (long long)a + c; }
NOINLINE __int128 bump128(__int128 a) { return a + 1; }
NOINLINE long long named_va(long long x, struct P p, ...) {
    va_list ap;
    long long c;
    va_start(ap, p);
    c = va_arg(ap, long long);
    va_end(ap);
    return p.b * 1000 + p.a + c * 7 + x;
}
static volatile long long sunk;
NOINLINE long long sink(long long x) { sunk = x; return x + 1; }
NOINLINE struct P const_across(long long x) { struct P r = {7, 8}; sink(x); return r; }
NOINLINE struct P keep_across(struct P v, long long x) { sink(x); return v; }
NOINLINE struct P va_ret(int n, ...) {
    va_list ap;
    struct P r;
    va_start(ap, n);
    r.a = va_arg(ap, long long);
    r.b = n;
    va_end(ap);
    return r;
}

int main(void) {
    struct P p = {7, 11};
    struct Q q = {3, 4};
    struct R r = {5, 6};
    struct S s = {{1, 2, 3}};
    struct T t = {1, 2, 3, 4};
    struct D d = {1.5, 0.25};
    struct F3 f = {1.0f, 2.0f, 3.0f};
    struct F1 f1 = {1.5f};
    struct DL dlv = {2.5, 9};
    struct FI fiv = {0.5f, 8};
    union U u;
    struct W1 a1 = {5};
    struct W2 a2 = {600};
    struct W4 a4 = {70000};
    struct W8 a8 = {8000000000LL};
    struct N n = {{1, 2}, 30};
    int arr[4] = {0, 1, 2, 3};
    struct PP ppv = {arr, 4};
    struct B b = {1, 2, 3};

    p = by_value(p);
    if (p.a != 8 || p.b != 11) {
        return 1;
    }
    p = make_pair(21, 22);
    if (p.a != 21 || p.b != 22) {
        return 2;
    }
    q = swapq(q);
    if (q.a != 4 || q.b != 3) {
        return 3;
    }
    r = tail(r);
    if (r.a != 11 || r.b != 12) {
        return 4;
    }
    s = bytes(s);
    if (s.x[0] != 2 || s.x[1] != 4 || s.x[2] != 6) {
        return 5;
    }
    t = mixed(t);
    if (t.c != 2 || t.s != 3 || t.i != 5 || t.l != 7) {
        return 6;
    }
    d = dsum(d);
    if (d.x != 1.75 || d.y != 1.25) {
        return 7;
    }
    f = rot3(f);
    if (f.x != 2.0f || f.y != 3.0f || f.z != 1.0f) {
        return 8;
    }
    f1 = twice(f1);
    if (f1.x != 3.0f) {
        return 9;
    }
    dlv = dl(dlv);
    if (dlv.d != 5.0 || dlv.l != 10) {
        return 10;
    }
    fiv = fi(fiv);
    if (fiv.f != 1.5f || fiv.i != 9) {
        return 11;
    }
    u.l = 41;
    u = ubump(u);
    if (u.l != 42) {
        return 12;
    }
    a1 = w1(a1);
    a2 = w2(a2);
    a4 = w4(a4);
    a8 = w8(a8);
    if (a1.c != 6 || a2.s != 601 || a4.i != 70001 || a8.l != 8000000001LL) {
        return 13;
    }
    n = nested(n);
    if (n.q.a != 2 || n.q.b != 1 || n.l != 31) {
        return 14;
    }
    ppv = pp(ppv);
    if (ppv.p != arr + 1 || ppv.n != 3 || *ppv.p != 1) {
        return 15;
    }
    b = big(b);
    if (b.a != 1 || b.b != 2 || b.c != 6) {
        return 16;
    }
    p.a = 7;
    p.b = 11;
    if (escape(p) != 18) {
        return 17;
    }
    p = escape_ret(p);
    if (p.a != 17 || p.b != 31) {
        return 18;
    }
    p = forward(p);
    if (p.a != 18 || p.b != 31) {
        return 19;
    }
    p = pick(p, 1);
    if (p.a != 18 || p.b != 31) {
        return 20;
    }
    p = pick(p, 0);
    if (p.a != 31 || p.b != 18) {
        return 21;
    }
    if (live(p, 2) != 6 + 32 + 18) {
        return 22;
    }
    p = ret_global();
    if (p.a != 100 || p.b != 200) {
        return 23;
    }
    p = lit(5);
    if (p.a != 5 || p.b != 6) {
        return 24;
    }
    p = rec(p, 4);
    if (p.a != 15 || p.b != 6) {
        return 25;
    }
    if (loop(p) != 15 + 21 + 27 + 33) {
        return 26;
    }
    if (spill(p, 1, 2, 3, 4, 5, 6) != 16192) {
        return 27;
    }
    p = self_assign(p);
    if (p.a != 15 || p.b != -9) {
        return 28;
    }
    {
        __int128 w = ((__int128)5 << 64) | 11;
        w = bump128(w);
        if (lo128(w, 3) != 15 || (long long)(w >> 64) != 5) {
            return 29;
        }
    }
    if (named_va(1, p, 3LL) != -9000 + 15 + 21 + 1) {
        return 30;
    }
    p = va_ret(4, 9LL);
    if (p.a != 9 || p.b != 4) {
        return 31;
    }
    p = const_across(3);
    if (p.a != 7 || p.b != 8 || sunk != 3) {
        return 32;
    }
    p.a = 40;
    p = keep_across(p, 5);
    if (p.a != 40 || p.b != 8 || sunk != 5) {
        return 33;
    }
    return 0;
}
