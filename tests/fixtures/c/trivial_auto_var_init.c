// snapshot-flags: -ftrivial-auto-var-init=zero
// `-ftrivial-auto-var-init=zero` / `=pattern`: every automatic object
// declared without an initializer holds the selected byte on entry to
// its scope. `EXPECT` is that byte -- 0 under `=zero`, 0xFE under
// `=pattern` -- and the build passes it in. Each probe runs after a callee
// has written 0xAA over the stack region the probe's frame reuses, so a
// missing store reads back as 0xAA rather than as the zeros a fresh page
// holds. A scalar is read by value, which is the form `-O` promotes; an
// aggregate, an array, a variable-length array and a wide scalar are read
// byte by byte through a volatile pointer. The exit code counts the bytes
// and values that differ, 0 when every object holds the byte.

#ifndef EXPECT
#define EXPECT 0
#endif

#if !__has_attribute(uninitialized)
#error "the opt-out attribute is not reported"
#endif

#define REP1 ((unsigned char)EXPECT)
#define REP2 ((unsigned short)(EXPECT * 0x0101u))
#define REP4 ((unsigned)(EXPECT * 0x01010101u))
#define REP8 ((unsigned long)EXPECT * 0x0101010101010101ul)

struct S {
    char c;
    int i;
    long l;
};

union U {
    char c;
    long l;
};

__attribute__((noinline)) static void dirty(void) {
    volatile unsigned char buf[8192];
    unsigned i;
    for (i = 0; i < sizeof buf; i++) {
        buf[i] = 0xAA;
    }
}

__attribute__((noinline)) static int mismatches(const void *p, unsigned long n) {
    const volatile unsigned char *b = p;
    unsigned long i;
    int bad = 0;
    for (i = 0; i < n; i++) {
        if (b[i] != REP1) {
            bad++;
        }
    }
    return bad;
}

__attribute__((noinline)) static int scalar_int(void) {
    int x;
    return (unsigned)x != REP4;
}

__attribute__((noinline)) static int scalar_short(void) {
    short h;
    return (unsigned short)h != REP2;
}

__attribute__((noinline)) static int scalar_char(void) {
    unsigned char c;
    return c != REP1;
}

__attribute__((noinline)) static int scalar_long(void) {
    long l;
    return (unsigned long)l != REP8;
}

__attribute__((noinline)) static int scalar_ptr(void) {
    char *p;
    return (unsigned long)p != REP8;
}

__attribute__((noinline)) static int scalar_double(void) {
    union {
        double d;
        unsigned long u;
    } v;
    double d;
    v.d = d;
    return v.u != REP8;
}

__attribute__((noinline)) static int scalar_float(void) {
    union {
        float f;
        unsigned u;
    } v;
    float f;
    v.f = f;
    return v.u != REP4;
}

__attribute__((noinline)) static int scalar_long_double(void) {
    long double ld;
    return mismatches(&ld, sizeof ld);
}

__attribute__((noinline)) static int scalar_int128(void) {
    __int128 w;
    return mismatches(&w, sizeof w);
}

// The shape from the report: eight ints summed without a store.
__attribute__((noinline)) static int array_sum(void) {
    int a[8];
    int i, s = 0;
    for (i = 0; i < 8; i++) {
        s += a[i];
    }
    return (unsigned)s != (unsigned)(8 * (int)REP4);
}

__attribute__((noinline)) static int array_bytes(void) {
    int a[8];
    return mismatches(a, sizeof a);
}

__attribute__((noinline)) static int struct_bytes(void) {
    struct S s;
    return mismatches(&s.c, sizeof s.c) + mismatches(&s.i, sizeof s.i) +
           mismatches(&s.l, sizeof s.l);
}

__attribute__((noinline)) static int union_bytes(void) {
    union U u;
    return mismatches(&u, sizeof u);
}

// Past the inline-store bound: the fill is a loop.
__attribute__((noinline)) static int big_array(void) {
    char buf[4096];
    return mismatches(buf, sizeof buf);
}

// Runtime size: the store follows the allocation.
__attribute__((noinline)) static int vla_bytes(int n) {
    long v[n];
    return mismatches(v, sizeof v);
}

__attribute__((noinline)) static int vla_odd(int n) {
    char v[n];
    return mismatches(v, sizeof v);
}

// The store sits at the declaration, so a block re-entered by a loop
// re-initializes its object each time.
__attribute__((noinline)) static int loop_block(void) {
    int k, bad = 0;
    for (k = 0; k < 2; k++) {
        int t;
        if (k == 0) {
            t = 77;
        } else {
            bad += (unsigned)t != REP4;
        }
    }
    return bad;
}

// `-fno-strict-aliasing` shape: the object is addressed before it is read.
__attribute__((noinline)) static int addressed_int(void) {
    int x;
    int *p = &x;
    return (unsigned)*p != REP4;
}

// The attribute opts an object out; it is written before it is read.
__attribute__((noinline)) static int opted_out(int v) {
    int __attribute__((uninitialized)) y;
    y = v;
    return y != v;
}

int main(void) {
    int bad = 0;
    dirty();
    bad += scalar_int();
    dirty();
    bad += scalar_short();
    dirty();
    bad += scalar_char();
    dirty();
    bad += scalar_long();
    dirty();
    bad += scalar_ptr();
    dirty();
    bad += scalar_double();
    dirty();
    bad += scalar_float();
    dirty();
    bad += scalar_long_double();
    dirty();
    bad += scalar_int128();
    dirty();
    bad += array_sum();
    dirty();
    bad += array_bytes();
    dirty();
    bad += struct_bytes();
    dirty();
    bad += union_bytes();
    dirty();
    bad += big_array();
    dirty();
    bad += vla_bytes(37);
    dirty();
    bad += vla_odd(5);
    dirty();
    bad += vla_bytes(0);
    dirty();
    bad += loop_block();
    dirty();
    bad += addressed_int();
    dirty();
    bad += opted_out(3);
    return bad > 100 ? 100 : bad;
}
