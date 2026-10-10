/* Small aggregates returned in registers (System V AMD64 3.2.3) from
   alloca'd storage, in functions that keep values in callee-saved
   registers across a call: a long double, two floats in one eightbyte, a
   union, a float beside an int, a double beside a long, and twelve bytes.
   The caller keeps its own values live across the calls. Returns 0 when
   every value arrives. */

static volatile long seed = 9;
static volatile long mul[4] = {11, 13, 17, 19};
static void *volatile sink;

__attribute__((noinline)) static void touch(void *p) { sink = p; }

struct L { long double x; };
struct F2 { float a, b; };
union U { long l; double d; };
struct FI { float f; int i; };
struct M { double d; long l; };
struct C { char c[12]; };

/* Element 0 sits lowest in the region, the furthest below the frame. */
__attribute__((noinline)) static struct L fl(long n) {
    struct L *p = (struct L *)__builtin_alloca(sizeof *p * (unsigned long)n);
    long x = n * 3;
    for (long i = 0; i < n; i++) p[i].x = (long double)(i + x);
    touch(p);
    x += n;
    p[0].x += (long double)x;
    return p[0];
}

__attribute__((noinline)) static struct F2 ff(long n) {
    struct F2 *p = (struct F2 *)__builtin_alloca(sizeof *p * (unsigned long)n);
    long x = n * 3;
    for (long i = 0; i < n; i++) p[i] = (struct F2){(float)(i + x), (float)(i + x + 1)};
    touch(p);
    x += n;
    p[0].a += (float)x;
    p[0].b += (float)x;
    return p[0];
}

__attribute__((noinline)) static union U fu(long n) {
    union U *p = (union U *)__builtin_alloca(sizeof *p * (unsigned long)n);
    long x = n * 3;
    for (long i = 0; i < n; i++) p[i].l = i + x;
    touch(p);
    x += n;
    p[0].l += x;
    return p[0];
}

__attribute__((noinline)) static struct FI fi(long n) {
    struct FI *p = (struct FI *)__builtin_alloca(sizeof *p * (unsigned long)n);
    long x = n * 3;
    for (long i = 0; i < n; i++) p[i] = (struct FI){(float)(i + x), (int)(i + x + 1)};
    touch(p);
    x += n;
    p[0].f += (float)x;
    p[0].i += (int)x;
    return p[0];
}

__attribute__((noinline)) static struct M fm(long n) {
    struct M *p = (struct M *)__builtin_alloca(sizeof *p * (unsigned long)n);
    long x = n * 3;
    for (long i = 0; i < n; i++) p[i] = (struct M){(double)(i + x), i + x + 2};
    touch(p);
    x += n;
    p[0].d += (double)x;
    p[0].l += x;
    return p[0];
}

__attribute__((noinline)) static struct C fc(long n) {
    struct C *p = (struct C *)__builtin_alloca(sizeof *p * (unsigned long)n);
    long x = n * 3;
    for (long i = 0; i < n; i++)
        for (int k = 0; k < 12; k++) p[i].c[k] = (char)(i + x + k);
    touch(p);
    x += n;
    for (int k = 0; k < 12; k++) p[0].c[k] = (char)(p[0].c[k] + x);
    return p[0];
}

int main(void) {
    long n = seed;
    long a = n * mul[0], b = n * mul[1], c = n * mul[2], d = n * mul[3];
    long w = 7 * n; /* 3n from the fill, 4n added after the call */
    struct L l = fl(n);
    if (l.x != (long double)w) return 1;
    struct F2 f2 = ff(n);
    if (f2.a != (float)w || f2.b != (float)(w + 1)) return 2;
    union U u = fu(n);
    if (u.l != w) return 3;
    struct FI f1 = fi(n);
    if (f1.f != (float)w || f1.i != (int)(w + 1)) return 4;
    struct M m = fm(n);
    if (m.d != (double)w || m.l != w + 2) return 5;
    struct C s = fc(n);
    for (int k = 0; k < 12; k++)
        if (s.c[k] != (char)(w + k)) return 6;
    if (a != n * mul[0] || b != n * mul[1] || c != n * mul[2] || d != n * mul[3]) return 7;
    return 0;
}
