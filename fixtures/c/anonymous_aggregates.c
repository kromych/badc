// Anonymous struct / union members (C11 6.7.2.1p13) -- the
// MSVC-style `LARGE_INTEGER` shape and a few generalisations.
//
// "An unnamed member whose type specifier is a structure
//  specifier with no tag is called an anonymous structure;
//  an unnamed member whose type specifier is a union specifier
//  with no tag is called an anonymous union. The members of an
//  anonymous structure or union are considered to be members
//  of the containing structure or union."
//
// Each test returns a unique non-zero id on failure so the
// FIRST mismatch points to its scenario.

#include <stdio.h>

// ---------------------------------------------------------------
// 1. The canonical LARGE_INTEGER union: anonymous struct +
//    named struct `u` + scalar QuadPart, all overlapping at
//    offset 0. Members of the anonymous struct (`LowPart`,
//    `HighPart`) are reachable as `li.LowPart` directly.

union BigInt {
    struct {
        unsigned int low;
        int high;
    };
    struct {
        unsigned int low;
        int high;
    } u;
    long long quad;
};

// ---------------------------------------------------------------
// 2. Anonymous union inside a struct -- the union's members
//    promote into the outer struct's namespace.

struct Variant {
    int tag;
    union {
        int    as_int;
        double as_double;
        char  *as_str;
    };
    int after;
};

// ---------------------------------------------------------------
// 3. Two anonymous structs in series, sharing field-name
//    namespaces between them. Each anonymous struct gets its
//    own offset slice; field names must be unique across the
//    whole flattened scope (we silently shadow on collision).

struct TwoAnon {
    struct {
        int x;
        int y;
    };
    struct {
        int z;
        int w;
    };
};

// ---------------------------------------------------------------
// 4. Anonymous struct nested inside an anonymous union nested
//    inside a regular struct. Three levels of "members
//    promote into containing scope" recursion.

struct Nested {
    int prefix;
    union {
        struct {
            short hi;
            short lo;
        };
        int packed;
    };
    int suffix;
};

// ---------------------------------------------------------------
// 5. Anonymous struct with an initial char field -- forces the
//    enclosing struct to align ITS cursor to the anon's
//    alignment (1 in this case, but the next non-anon field
//    after the anon should still align naturally to its own
//    type).

struct AlignAfter {
    char           tag;       // @ 0
    struct {                  // @ 1, size 4 (char + char), align 1
        char  a;
        char  b;
        char  c;
        char  d;
    };
    long long      total;     // @ 8 (re-align to 8)
};

int main() {
    // ---- BigInt ----
    if (sizeof(union BigInt) != 8) return 1;

    union BigInt b;
    b.quad = 0x1234567890ABCDEFLL;
    if (b.low  != (unsigned int)0x90ABCDEF) return 2;
    if (b.high != (int)0x12345678) return 3;
    if (b.u.low  != (unsigned int)0x90ABCDEF) return 4;
    if (b.u.high != (int)0x12345678) return 5;

    // Promoted-vs-qualified -- writing through the anon-struct
    // path must be visible through the named `u` path because
    // they overlap at offset 0.
    b.low  = 0xCAFEBABE;
    b.high = 0x0BADF00D;
    if (b.u.low  != (unsigned int)0xCAFEBABE) return 6;
    if (b.u.high != (int)0x0BADF00D) return 7;
    if (b.quad   != (long long)0x0BADF00DCAFEBABELL) return 8;

    // ---- Variant ----
    struct Variant v;
    v.tag      = 1;
    v.as_int   = 42;
    v.after    = 99;
    if (v.tag != 1) return 10;
    if (v.as_int != 42) return 11;
    if (v.after != 99) return 12;
    // Anonymous union member overlaps -- writing as_double
    // must trash the as_int interpretation, but tag/after are
    // OUTSIDE the union and stay intact.
    v.as_double = 3.14;
    if (v.tag != 1) return 13;
    if (v.after != 99) return 14;

    // ---- TwoAnon ----
    if (sizeof(struct TwoAnon) != 16) return 20;
    struct TwoAnon t;
    t.x = 10; t.y = 20; t.z = 30; t.w = 40;
    if (t.x != 10) return 21;
    if (t.y != 20) return 22;
    if (t.z != 30) return 23;
    if (t.w != 40) return 24;

    // ---- Nested ----
    struct Nested n;
    n.prefix = 7;
    n.hi = 0x1234;
    n.lo = (short)0x5678;
    n.suffix = 9;
    if (n.prefix != 7) return 30;
    if (n.hi != 0x1234) return 31;
    if (n.lo != (short)0x5678) return 32;
    if (n.suffix != 9) return 33;

    // The hi/lo anon-struct overlaps with `packed` via the
    // outer anon-union. `hi` sits at the union base (offset 0
    // within the union), `lo` at offset 2. On every c5 target
    // (all little-endian), `packed` reads as
    //     byte0..byte3 = { hi_lo, hi_hi, lo_lo, lo_hi }
    // i.e. `packed == (hi & 0xFFFF) | ((lo & 0xFFFF) << 16)`.
    {
        unsigned int packed_expected =
            ((unsigned int)(unsigned short)0x1234) |
            (((unsigned int)(unsigned short)0x5678) << 16);
        if ((unsigned int)n.packed != packed_expected) return 34;
    }

    // ---- AlignAfter ----
    struct AlignAfter aa;
    aa.tag = 'X';
    aa.a = 'a'; aa.b = 'b'; aa.c = 'c'; aa.d = 'd';
    aa.total = 0x123456789ABCDEF0LL;
    if (aa.tag != 'X') return 40;
    if (aa.a != 'a') return 41;
    if (aa.b != 'b') return 42;
    if (aa.c != 'c') return 43;
    if (aa.d != 'd') return 44;
    if (aa.total != 0x123456789ABCDEF0LL) return 45;

    return 0;
}
