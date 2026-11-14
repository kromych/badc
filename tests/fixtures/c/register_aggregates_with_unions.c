// Aggregates passed and returned in registers whose integer registers hold
// a union's members or a `float` beside an integer, written and read
// through each member: the bytes one member stores are what another reads
// (C17 6.5.2.3p3 and footnote 97), and each register carries its bytes
// across the call. Returns 0 when every check passes; each failure returns
// a distinct code.

#include <string.h>

typedef union {
    int i;
    double d;
    void *p;
    unsigned char b[8];
} U;

typedef struct {
    U u;
    long long tag;
} V;

typedef struct {
    float f;
    int i;
} FI;

typedef struct {
    char c;
    float f;
    short s;
} CFS;

typedef struct {
    union {
        int i;
        float f;
    } u;
    int n;
    long long k;
} Small;

static int sink;

__attribute__((noinline)) V make_int(int i, long long tag) {
    V v;
    v.u.i = i;
    v.u.b[4] = 0x5a;
    v.tag = tag;
    return v;
}

__attribute__((noinline)) V make_double(double d) {
    V v;
    v.u.d = d;
    v.tag = 7;
    return v;
}

__attribute__((noinline)) V step(V v, V w) {
    V r;
    if (v.tag == 7)
        r.u.d = v.u.d * 2 + (double)w.u.i;
    else
        r.u.p = (char *)v.u.p + w.u.i;
    r.tag = v.tag ^ w.tag;
    return r;
}

__attribute__((noinline)) FI swap_fi(FI a) {
    FI r = {(float)a.i, (int)a.f};
    return r;
}

__attribute__((noinline)) CFS bump(CFS a) {
    a.c++;
    a.f *= 2;
    a.s -= 3;
    return a;
}

__attribute__((noinline)) Small mix(Small a, int as_float) {
    Small r = a;
    if (as_float)
        r.u.f = a.u.f + (float)a.n;
    else
        r.u.i = a.u.i + a.n;
    r.k = a.k * 3;
    return r;
}

// A whole copy through memory between member accesses.
__attribute__((noinline)) V through(V *sp, int n) {
    V ret;
    for (int i = 0; i < n; i++) {
        ret = *--sp;
        if (ret.tag == 7)
            sink += (int)ret.u.d;
        else
            sink += ret.u.i;
    }
    sp[0] = ret;
    sp[0].u.i += 1;
    return sp[0];
}

int main(void) {
    V a = make_int(-5, 3);
    if (a.u.i != -5 || a.u.b[4] != 0x5a || a.tag != 3) return 1;
    V b = make_double(1.25);
    if (b.u.d != 1.25 || b.tag != 7) return 2;
    V c = step(b, a);
    if (c.u.d != -2.5 || c.tag != 4) return 3;
    static char buf[64];
    V q = {.u.p = buf + 8, .tag = 1};
    V d = step(q, make_int(16, 0));
    if (d.u.p != buf + 24 || d.tag != 1) return 4;
    FI e = swap_fi((FI){2.75f, 9});
    if (e.f != 9.0f || e.i != 2) return 5;
    CFS g = bump((CFS){'a', 1.5f, 10});
    if (g.c != 'b' || g.f != 3.0f || g.s != 7) return 6;
    Small h = mix((Small){.u.f = 0.5f, .n = 2, .k = 5}, 1);
    if (h.u.f != 2.5f || h.n != 2 || h.k != 15) return 7;
    Small k = mix((Small){.u.i = 40, .n = 2, .k = -1}, 0);
    if (k.u.i != 42 || k.k != -3) return 8;
    V stack[4] = {make_int(1, 0), make_double(2.0), make_int(3, 0), make_int(4, 0)};
    V t = through(stack + 4, 3);
    if (t.u.i != 1 || t.tag != 7 || sink != 4 + 3 + 2) return 9;
    unsigned char bytes[8];
    memcpy(bytes, &t.u, 8);
    double two = 2.0;
    unsigned char want[8];
    memcpy(want, &two, 8);
    want[0] += 1;
    if (memcmp(bytes, want, 8) != 0) return 10;
    return 0;
}
