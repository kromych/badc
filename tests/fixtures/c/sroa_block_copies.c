/* Block copies that fill or read an address-taken automatic aggregate.
 * Each function is one shape scalar promotion either splits field by
 * field or leaves in memory: copies in from a pointer, out through a
 * pointer, between two locals and within one object; unions, bitfields,
 * padding and a flexible array member; volatile, escaping and by-value
 * objects; struct returns, setjmp, a VLA; and the objects too large or
 * array-bearing to leave their block copy. `seed` is volatile, so no
 * input is a translation-time constant. */

#include <setjmp.h>

volatile long seed = 11;

struct P { long a, b; };
struct Q { int x; struct P p; char tag; };

__attribute__((noinline)) long from_ptr(struct P *p) {
    struct P t = *p;
    return t.a + t.b;
}

static long sum(struct P *q) { return q->a + q->b; }

__attribute__((noinline)) long from_ptr_inl(struct P *p) {
    struct P t = *p;
    return sum(&t);
}

__attribute__((noinline)) long local_copy(long x, long y) {
    struct P t = {x, y};
    struct P u = t;
    return u.a + u.b;
}

__attribute__((noinline)) void literal_ptr(struct P *p, long x) {
    *p = (struct P){x, 7};
}

__attribute__((noinline)) struct P by_value(struct P v) {
    v.a += 1;
    return v;
}

__attribute__((noinline)) long nested(struct Q *q) {
    struct Q t = *q;
    t.p.b = t.x;
    return t.p.a + t.p.b + t.tag;
}

union U { long l; int i; };

__attribute__((noinline)) long union_one_width(long x) {
    union U u;
    u.l = x;
    union U v = u;
    return v.l;
}

/* Read at two widths: the copy moves the representation. */
__attribute__((noinline)) long union_two_widths(union U *out, long x) {
    union U u;
    u.l = x;
    u.i = 5;
    *out = u;
    return u.l & 0xffffffff;
}

struct B { unsigned a : 3, b : 5; unsigned c : 12; long d; };

__attribute__((noinline)) void bitfield_copy(struct B *out, long x) {
    struct B t = {.a = 5, .b = 17, .d = x};
    t.c = (unsigned)x & 0xfff;
    *out = t;
}

struct C { char c; long l; };

__attribute__((noinline)) void padded_copy(struct C *out, long x) {
    *out = (struct C){(char)x, x * 3};
}

/* Assignment copies no element of the flexible array member. */
struct F { long n; long tail[]; };

__attribute__((noinline)) long fam_copy(long *buf, long x) {
    struct F f;
    f.n = x;
    *(struct F *)buf = f;
    return buf[0] + buf[1];
}

__attribute__((noinline)) long self_assign(long x, long y) {
    struct P t = {x, y};
    t = t;
    return t.a - t.b;
}

struct R { struct P p1, p2; };

__attribute__((noinline)) long member_copy(long x, long y) {
    struct R r = {{x, y}, {y, x}};
    r.p1 = r.p2;
    r.p2.a = 1;
    return r.p1.a * 10 + r.p1.b + r.p2.a * 100;
}

__attribute__((noinline)) long volatile_copy(struct P *out, long x) {
    volatile struct P vt = {x, x + 1};
    struct P w = vt;
    *out = vt;
    return w.a + w.b;
}

__attribute__((noinline)) static void clobber(struct P *p) {
    p->a = -1;
    p->b = -2;
}

__attribute__((noinline)) long escape_after_copy(struct P *out, long x) {
    struct P t = {x, 2 * x};
    *out = t;
    clobber(&t);
    return t.a + t.b + out->a + out->b;
}

__attribute__((noinline)) static long take(struct P v) { return v.a * 3 + v.b; }

__attribute__((noinline)) long by_value_arg(struct P *out, long x) {
    struct P t = {x, 4};
    *out = t;
    return take(t);
}

__attribute__((noinline)) struct P make_pair(long x) {
    struct P t = {x, 9};
    return t;
}

struct L { long a, b, c; };

__attribute__((noinline)) struct L make_large(long x) {
    struct L t = {x, 1, 2};
    t.c += x;
    return t;
}

static inline struct L make_large_inl(long x) {
    struct L t = {x, 3, 4};
    return t;
}

__attribute__((noinline)) long large_return_inlined(long x) {
    struct L l = make_large_inl(x);
    return l.a + l.b + l.c;
}

static jmp_buf jb;

__attribute__((noinline)) static void jump_back(void) { longjmp(jb, 1); }

__attribute__((noinline)) long copy_across_setjmp(struct P *out, long x) {
    struct P t = {x, 5};
    if (setjmp(jb)) {
        *out = t;
        return out->a + out->b;
    }
    jump_back();
    return -1;
}

__attribute__((noinline)) long vla_copy(struct P *p, long n) {
    char buf[n];
    buf[n - 1] = 3;
    struct P t = *p;
    t.b += buf[n - 1];
    struct P u = t;
    return u.a + u.b;
}

struct Big { long w[16]; };

__attribute__((noinline)) long big_copy(struct Big *out, struct Big *in, long x) {
    struct Big b = *in;
    b.w[3] = x;
    *out = b;
    return out->w[3] + out->w[15];
}

struct Arr { long a[2]; };

__attribute__((noinline)) void array_member_copy(struct Arr *out, long x) {
    struct Arr s = {{x, x + 5}};
    *out = s;
}

struct Wide { long a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p; };

__attribute__((noinline)) void wide_copy(struct Wide *out, long x) {
    struct Wide w = {.a = x, .p = x + 1};
    *out = w;
}

struct D { double x, y; };

__attribute__((noinline)) void fp_copy(struct D *out, long x) {
    *out = (struct D){(double)x, 0.5};
}

__attribute__((noinline)) void sub_object_copy(struct P *out, long x) {
    struct Q t = {1, {x, x + 2}, 'q'};
    *out = t.p;
}

__attribute__((noinline)) void chain_copy(struct P *out, long x, long y) {
    struct P a = {x, y};
    struct P b = a;
    struct P c = b;
    *out = c;
}

struct field { unsigned off, mask; };
#define FIELD32(m) ((struct field){.off = __builtin_ctz(m), .mask = (m)})

static inline void set_field(unsigned *reg, const struct field f, unsigned value) {
    *reg = (*reg & ~f.mask) | ((value << f.off) & f.mask);
}

__attribute__((noinline)) unsigned field_literals(unsigned v) {
    unsigned reg = 0;
    set_field(&reg, FIELD32(0x000000ff), v);
    set_field(&reg, FIELD32(0x0000ff00), v + 1);
    set_field(&reg, FIELD32(0x00010000), 1);
    return reg;
}

int main(void) {
    long k = seed;
    struct P p = {k, k + 1};
    if (from_ptr(&p) != 2 * k + 1) return 1;
    if (from_ptr_inl(&p) != 2 * k + 1) return 2;
    if (local_copy(k, 4) != k + 4) return 3;
    struct P o;
    literal_ptr(&o, k);
    if (o.a != k || o.b != 7) return 4;
    struct P bv = by_value(p);
    if (bv.a != k + 1 || bv.b != k + 1) return 5;
    struct Q q = {(int)k, {2, 3}, 'x'};
    if (nested(&q) != 2 + k + 'x') return 6;
    if (union_one_width(k) != k) return 7;
    union U uo;
    if (union_two_widths(&uo, k << 32 | 9) != 5 || uo.i != 5) return 8;
    struct B bo;
    bitfield_copy(&bo, k);
    if (bo.a != 5 || bo.b != 17 || bo.c != (k & 0xfff) || bo.d != k) return 9;
    struct C co;
    padded_copy(&co, k);
    if (co.c != (char)k || co.l != 3 * k) return 10;
    long buf[3] = {-1, 42, 43};
    if (fam_copy(buf, k) != k + 42 || buf[2] != 43) return 11;
    if (self_assign(k, 3) != k - 3) return 12;
    if (member_copy(k, 2) != 20 + k + 100) return 13;
    struct P vo;
    if (volatile_copy(&vo, k) != 2 * k + 1 || vo.a != k || vo.b != k + 1) return 14;
    struct P eo;
    if (escape_after_copy(&eo, k) != 3 * k - 3) return 15;
    struct P ao;
    if (by_value_arg(&ao, k) != 3 * k + 4 || ao.a != k || ao.b != 4) return 16;
    struct P mp = make_pair(k);
    if (mp.a != k || mp.b != 9) return 17;
    struct L ml = make_large(k);
    if (ml.a != k || ml.b != 1 || ml.c != 2 + k) return 18;
    if (large_return_inlined(k) != k + 7) return 19;
    struct P so;
    if (copy_across_setjmp(&so, k) != k + 5) return 20;
    if (vla_copy(&p, k) != 2 * k + 4) return 21;
    struct Big bi, bo2;
    for (int i = 0; i < 16; i++) bi.w[i] = i * k;
    if (big_copy(&bo2, &bi, 5) != 5 + 15 * k || bo2.w[2] != 2 * k) return 22;
    struct Arr ar;
    array_member_copy(&ar, k);
    if (ar.a[0] != k || ar.a[1] != k + 5) return 23;
    struct Wide wd;
    wide_copy(&wd, k);
    if (wd.a != k || wd.h != 0 || wd.p != k + 1) return 24;
    struct D d;
    fp_copy(&d, k);
    if (d.x != (double)k || d.y != 0.5) return 25;
    struct P sub;
    sub_object_copy(&sub, k);
    if (sub.a != k || sub.b != k + 2) return 26;
    struct P ch;
    chain_copy(&ch, k, 6);
    if (ch.a != k || ch.b != 6) return 27;
    unsigned want = ((unsigned)k & 0xff) | ((((unsigned)k + 1) << 8) & 0xff00) | 0x10000;
    if (field_literals((unsigned)k) != want) return 28;
    return 0;
}
