// GNU `aligned(N)` on typedefs (C11 6.7.5 does not cover type attributes;
// the semantics follow gcc): the alias carries the alignment to objects,
// members, arrays and `__alignof__`. On a typedef the attribute SETS the
// alignment -- it may lower it -- while a declarator attribute replaces a
// typedef-carried value and otherwise only raises the natural one. An
// attribute after a struct body binds to the struct type (size padded);
// after the alias name it binds to the alias only (size unpadded).

typedef unsigned long long usize_t;

// After-body attribute: the anonymous struct itself is 16-aligned, so its
// size pads to 16.
typedef struct {
    char c;
} __attribute__((aligned(16))) TdStruct16;

// Alias-attached alignment on scalars, in both spellings.
typedef int TdI16 __attribute__((aligned(16)));
typedef __attribute__((aligned(16))) int TdI16Pre;

// Attribute on the tag; the type is 16-aligned wherever it is named.
struct Tag16 {
    char c;
} __attribute__((aligned(16)));

// Attribute after the alias name with the struct defined in the same
// declaration: only the alias is 16-aligned, the tag is not.
typedef struct S2 {
    char c;
} TdTail __attribute__((aligned(16)));

// Alias of a named struct: the tag keeps alignment 1 and size 1; the
// alias is 32-aligned with the size unpadded.
struct Plain {
    char c;
};
typedef struct Plain __attribute__((aligned(32))) TdNamed32;

// Array typedef carrying an alignment: it binds to the 4-byte array
// object, not the elements.
typedef char TdArr16[4] __attribute__((aligned(16)));

// A typedef may lower the alignment below the natural one.
typedef double TdLower2 __attribute__((aligned(2)));
typedef int TdIntLower1 __attribute__((aligned(1)));

// Bare `aligned` is the target's largest fundamental alignment.
typedef char TdMax __attribute__((aligned));

// packed + aligned after the body bind to the struct: packed member
// layout, then the aggregate raised to 8.
typedef struct {
    char c;
    int i;
} __attribute__((packed, aligned(8))) TdPackAl8;

// Chained typedef inherits the carrier.
typedef TdI16 TdChain;

// Member-attribute explicit alignment reaches automatic objects of the
// enclosing struct type.
struct M16 {
    int x __attribute__((aligned(16)));
};

struct HasTd {
    char pad;
    TdI16 m;
};
struct HasTdStruct {
    char pad;
    TdStruct16 m;
};
struct HasTdArr {
    char pad;
    TdArr16 a;
};
struct HasLower {
    char pad;
    TdLower2 d;
};
struct HasTdNamed {
    char pad;
    TdNamed32 m;
};
struct Outer {
    struct HasTd h;
};

static TdI16 g_i16;
static TdNamed32 g_named32;
static TdStruct16 g_struct16;
static TdLower2 g_low;
// A second declarator keeps the carrier even when the initializer parses
// another aligned type.
TdI16 g_first = (int)__alignof__(TdLower2), g_second;

__attribute__((noinline)) static int locals_at_shifted_slots(int seed) {
    // The leading char skews the frame slots so a placement that relies
    // on slot parity fails.
    char skew;
    TdI16 i;
    TdStruct16 s;
    TdNamed32 n;
    struct Tag16 t;
    struct M16 m;
    TdArr16 a;
    TdPackAl8 p;
    skew = (char)seed;
    i = 1;
    s.c = 2;
    n.c = 3;
    t.c = 4;
    m.x = 5;
    a[0] = 6;
    p.c = 7;
    p.i = 8;
    if ((usize_t)&i % 16 != 0) return 30;
    if ((usize_t)&s % 16 != 0) return 31;
    if ((usize_t)&n % 32 != 0) return 32;
    if ((usize_t)&t % 16 != 0) return 33;
    if ((usize_t)&m % 16 != 0) return 34;
    if ((usize_t)&a % 16 != 0) return 35;
    if ((usize_t)&p % 8 != 0) return 36;
    if (__alignof__(i) != 16) return 37;
    if (__alignof__(s) != 16) return 38;
    if (__alignof__(n) != 32) return 39;
    return skew + i + s.c + n.c + t.c + m.x + a[0] + p.c + p.i - seed - 36;
}

__attribute__((noinline)) static int declarator_vs_typedef(void) {
    // A declarator attribute replaces the typedef carrier outright.
    TdI16 x __attribute__((aligned(4)));
    TdLower2 w __attribute__((aligned(4)));
    _Alignas(16) TdLower2 y;
    TdI16 *ptr;
    x = 1;
    w = 2.0;
    y = 3.0;
    ptr = &x;
    if (__alignof__(x) != 4) return 50;
    if (__alignof__(w) != 4) return 51;
    if (__alignof__(y) != 16) return 52;
    if ((usize_t)&y % 16 != 0) return 53;
    // The carrier binds to the pointee; the pointer stays pointer-aligned.
    if (__alignof__(ptr) != 8) return 54;
    return (int)(x + w + y) - 6 + (int)(*ptr - 1);
}

int main(void) {
    if (sizeof(TdStruct16) != 16) return 1;
    if (__alignof__(TdStruct16) != 16) return 2;
    if (sizeof(TdI16) != 4) return 3;
    if (__alignof__(TdI16) != 16) return 4;
    if (__alignof__(TdI16Pre) != 16) return 5;
    if (sizeof(TdI16Pre) != 4) return 6;
    if (sizeof(struct Tag16) != 16) return 7;
    if (sizeof(TdTail) != 1) return 8;
    if (__alignof__(TdTail) != 16) return 9;
    if (sizeof(struct S2) != 1) return 10;
    if (__alignof__(struct S2) != 1) return 11;
    if (sizeof(struct Plain) != 1 || __alignof__(struct Plain) != 1) return 12;
    if (sizeof(TdNamed32) != 1) return 13;
    if (__alignof__(TdNamed32) != 32) return 14;
    if (sizeof(TdArr16) != 4) return 15;
    if (__alignof__(TdArr16) != 16) return 16;
    if (__alignof__(TdLower2) != 2) return 17;
    if (__alignof__(TdIntLower1) != 1) return 18;
    if (__alignof__(TdMax) != 16) return 19;
    if (sizeof(TdPackAl8) != 8 || __alignof__(TdPackAl8) != 8) return 20;
    if (__alignof__(TdChain) != 16) return 21;

    if (sizeof(struct HasTd) != 32) return 22;
    if (__alignof__(struct HasTd) != 16) return 23;
    if (__builtin_offsetof(struct HasTd, m) != 16) return 24;
    if (sizeof(struct HasTdStruct) != 32) return 25;
    if (__builtin_offsetof(struct HasTdStruct, m) != 16) return 26;
    if (sizeof(struct HasTdArr) != 32) return 27;
    if (__builtin_offsetof(struct HasTdArr, a) != 16) return 28;
    if (sizeof(struct HasLower) != 10) return 29;
    if (__builtin_offsetof(struct HasLower, d) != 2) return 60;
    if (sizeof(struct HasTdNamed) != 64) return 61;
    if (__alignof__(struct HasTdNamed) != 32) return 62;
    if (__builtin_offsetof(struct HasTdNamed, m) != 32) return 63;

    if ((usize_t)&g_i16 % 16 != 0) return 64;
    if ((usize_t)&g_named32 % 32 != 0) return 65;
    if ((usize_t)&g_struct16 % 16 != 0) return 66;
    if ((usize_t)&g_first % 16 != 0) return 67;
    if ((usize_t)&g_second % 16 != 0) return 68;
    if (g_first != 2) return 69;

    if (__alignof__(g_i16) != 16) return 70;
    if (__alignof__(g_low) != 2) return 71;
    if (__alignof__((g_i16)) != 16) return 72;

    {
        struct HasTd h;
        struct Outer o;
        static TdI16 sl;
        h.m = 1;
        o.h.m = 2;
        sl = 3;
        if (__alignof__(h.m) != 16) return 73;
        if (__alignof__(o.h.m) != 16) return 74;
        if (__alignof__(h) != 16) return 75;
        if ((usize_t)&sl % 16 != 0) return 76;
        if (__alignof__(sl) != 16) return 77;
        if (h.m + o.h.m + sl != 6) return 78;
    }

    {
        int r = locals_at_shifted_slots(9);
        if (r != 0) return r;
        r = declarator_vs_typedef();
        if (r != 0) return r;
    }
    return 0;
}
