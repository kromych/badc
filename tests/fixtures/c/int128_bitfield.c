// Bitfields declared with the GCC 128-bit integer type. The storage
// unit is 16 bytes and the width may reach 128 bits; a field that would
// straddle the unit starts a new one. Covers layout, read / write,
// truncation to the width, sign extension of a signed field, neighbour
// preservation, static and runtime initializers, the compound
// assignments and increments, and the C99 6.3.1.1p2 promotion that
// makes a field of 32 bits or fewer read as `int`. Every expected value
// is what gcc -O0 / -O2 and clang -O2 produce.
// Each check returns a distinct non-zero code on failure.

typedef unsigned __int128 u128;
typedef __int128 s128;

struct A {
    u128 f : 100;
};
struct B {
    u128 f : 100;
    u128 g : 28;
};
struct C {
    u128 f : 100;
    u128 g : 29;
};
struct D {
    unsigned char c;
    u128 f : 100;
};
struct E {
    s128 f : 100;
    s128 g : 28;
};
struct F {
    u128 f : 128;
};
struct G {
    unsigned a : 5;
    u128 f : 60;
    unsigned long long t : 20;
};

static struct A sa = {((u128)1 << 99) | 0x1234};
static struct B sb = {7, 9};

static int chk(u128 got, unsigned long long want_hi, unsigned long long want_lo, int code) {
    if ((unsigned long long)got != want_lo) {
        return code;
    }
    if ((unsigned long long)(got >> 64) != want_hi) {
        return code + 1;
    }
    return 0;
}

int main(void) {
    int r;

    // The declared type sizes and aligns the unit; a 29-bit field
    // after a 100-bit one no longer fits in 128 bits and starts a new one.
    if (sizeof(struct A) != 16 || _Alignof(struct A) != 16) {
        return 1;
    }
    if (sizeof(struct B) != 16 || sizeof(struct C) != 32) {
        return 2;
    }
    if (sizeof(struct D) != 16 || sizeof(struct E) != 16) {
        return 3;
    }
    if (sizeof(struct F) != 16 || sizeof(struct G) != 16) {
        return 4;
    }

    // Static initializers merge into the unit's bytes.
    if ((r = chk(sa.f, 0x800000000ULL, 0x1234, 10))) {
        return r;
    }
    if ((r = chk(sb.f, 0, 7, 13))) {
        return r;
    }
    if ((r = chk(sb.g, 0, 9, 16))) {
        return r;
    }

    // Read back a value spanning both halves, then one that overflows
    // the width and is truncated to it.
    struct A a;
    a.f = ((u128)1 << 99) | 5;
    if ((r = chk(a.f, 0x800000000ULL, 5, 20))) {
        return r;
    }
    a.f = ((u128)1 << 100) | 7;
    if ((r = chk(a.f, 0, 7, 23))) {
        return r;
    }

    // Two fields in one unit: each masks to its own width and leaves
    // the other's bits alone.
    struct B b;
    b.f = ~(u128)0;
    b.g = ~(u128)0;
    if ((r = chk(b.f, 0xfffffffffULL, 0xffffffffffffffffULL, 26))) {
        return r;
    }
    if ((r = chk(b.g, 0, 0xfffffff, 29))) {
        return r;
    }
    b.f = 0;
    if ((r = chk(b.f, 0, 0, 32))) {
        return r;
    }
    if ((r = chk(b.g, 0, 0xfffffff, 35))) {
        return r;
    }

    // A full-width field is the whole unit.
    struct F f;
    f.f = ((u128)0x0123456789abcdefULL << 64) | 0xfedcba9876543210ULL;
    if ((r = chk(f.f, 0x0123456789abcdefULL, 0xfedcba9876543210ULL, 38))) {
        return r;
    }

    // C99 6.7.2.1p10: a signed field reads sign-extended from its width.
    struct E e;
    e.f = -((s128)1 << 60);
    e.g = -3;
    if ((r = chk((u128)e.f, 0xffffffffffffffffULL, 0xf000000000000000ULL, 41))) {
        return r;
    }
    if ((r = chk((u128)(s128)e.g, 0xffffffffffffffffULL, 0xfffffffffffffffdULL, 44))) {
        return r;
    }
    e.f = ((s128)1 << 99);
    if ((r = chk((u128)e.f, 0xfffffff800000000ULL, 0, 47))) {
        return r;
    }
    e.f = ((s128)1 << 98);
    if ((r = chk((u128)e.f, 0x400000000ULL, 0, 50))) {
        return r;
    }

    // A field after a narrower member, and one sharing its unit with
    // members of other types.
    struct D d;
    d.c = 0xab;
    d.f = ((u128)1 << 77) | 3;
    if ((r = chk(d.f, 0x2000, 3, 53))) {
        return r;
    }
    if (d.c != 0xab) {
        return 56;
    }
    struct G g;
    g.a = 31;
    g.f = ((u128)1 << 59) | 11;
    g.t = 0xfffff;
    if ((r = chk(g.f, 0, 0x080000000000000bULL, 57))) {
        return r;
    }
    if (g.a != 31 || g.t != 0xfffff) {
        return 60;
    }

    // C99 6.5.16.2: the compound assignments read, apply the operator
    // in the field's type, and write the low bits back.
    struct A ca;
    ca.f = 1;
    ca.f += ((u128)1 << 90);
    if ((r = chk(ca.f, 0x4000000, 1, 61))) {
        return r;
    }
    ca.f *= 3;
    if ((r = chk(ca.f, 0xc000000, 3, 64))) {
        return r;
    }
    ca.f -= 1;
    if ((r = chk(ca.f, 0xc000000, 2, 67))) {
        return r;
    }
    ca.f <<= 5;
    if ((r = chk(ca.f, 0x180000000ULL, 0x40, 70))) {
        return r;
    }
    ca.f >>= 3;
    if ((r = chk(ca.f, 0x30000000, 8, 73))) {
        return r;
    }
    ca.f |= 0xff;
    if ((r = chk(ca.f, 0x30000000, 0xff, 76))) {
        return r;
    }
    ca.f &= ~(u128)0xf;
    if ((r = chk(ca.f, 0x30000000, 0xf0, 79))) {
        return r;
    }
    ca.f ^= 0x55;
    if ((r = chk(ca.f, 0x30000000, 0xa5, 82))) {
        return r;
    }
    ca.f /= 7;
    if ((r = chk(ca.f, 0x6db6db6, 0xdb6db6db6db6db85ULL, 85))) {
        return r;
    }
    ca.f %= 1000003;
    if ((r = chk(ca.f, 0, 0x247c3, 88))) {
        return r;
    }

    // Increment and decrement wrap at the field's width, and the
    // postfix form yields the prior value.
    ca.f = ~(u128)0;
    ca.f++;
    if ((r = chk(ca.f, 0, 0, 91))) {
        return r;
    }
    ca.f = 0;
    --ca.f;
    if ((r = chk(ca.f, 0xfffffffffULL, 0xffffffffffffffffULL, 94))) {
        return r;
    }
    ca.f = 5;
    if ((r = chk((u128)(ca.f++), 0, 5, 97))) {
        return r;
    }
    if ((r = chk(ca.f, 0, 6, 100))) {
        return r;
    }
    ca.f = 5;
    if ((r = chk((u128)(++ca.f), 0, 6, 103))) {
        return r;
    }

    // C99 6.3.1.1p2: a field of 32 bits or fewer reads as `int`, so it
    // stays in a register even though its unit is 16 bytes wide.
    struct B nb;
    nb.f = 0;
    nb.g = 1000;
    if (sizeof(nb.g + 0) != sizeof(int) || sizeof(nb.f + 0) != 16) {
        return 106;
    }
    if (nb.g != 1000 || nb.g * 3 != 3000) {
        return 107;
    }
    nb.g += 7;
    if (nb.g != 1007) {
        return 108;
    }
    nb.g++;
    if (nb.g != 1008) {
        return 109;
    }
    struct E ne;
    ne.f = 0;
    ne.g = -5;
    if (ne.g != -5 || !(ne.g < 0)) {
        return 110;
    }
    // The neighbour in the same unit is untouched by those writes.
    if ((r = chk(nb.f, 0, 0, 111))) {
        return r;
    }

    // A runtime initializer fills the fields of one unit.
    u128 seed = ((u128)1 << 80) | 0x99;
    struct B ib = {seed, 0x123};
    if ((r = chk(ib.f, 0x10000, 0x99, 114))) {
        return r;
    }
    if ((r = chk(ib.g, 0, 0x123, 117))) {
        return r;
    }
    return 0;
}
