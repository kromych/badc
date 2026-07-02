// A struct with a trailing `__attribute__((packed))` re-lays its
// fields with no inter-member padding. Bitfield members must keep
// their storage: C99 6.7.2.1p11 leaves the addressable unit
// implementation-defined, and the packed layout (matching gcc and
// clang) allocates bitfields at the bit level, placing the next
// non-bitfield member at the following byte boundary. Sizes,
// offsets, and read-back values are checked against clang output.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#include <stddef.h>

struct A { int flags:8; char c; } __attribute__((packed));
struct B { int a:17; int b:10; char c; } __attribute__((packed));
struct C { char a:3; char b:7; char c; } __attribute__((packed));
struct E { char c; int b:16; } __attribute__((packed));

struct A ga = { 85, 7 };

int main(void) {
    if (sizeof(struct A) != 2 || offsetof(struct A, c) != 1) return 1;
    if (sizeof(struct B) != 5 || offsetof(struct B, c) != 4) return 2;
    if (sizeof(struct C) != 3 || offsetof(struct C, c) != 2) return 3;
    if (sizeof(struct E) != 3) return 4;

    // Writing the plain member must not clobber the bitfield's
    // storage unit (they overlapped when the repack dropped the
    // bitfield's byte).
    struct A a;
    a.flags = 85;
    a.c = 7;
    if (a.flags != 85 || a.c != 7) return 5;

    // A run straddling byte boundaries packs contiguously.
    struct B b;
    b.a = 65000;
    b.b = 500;
    b.c = 9;
    if (b.a != 65000 || b.b != 500 || b.c != 9) return 6;

    struct C c;
    c.a = 3;
    c.b = 60;
    c.c = 4;
    if (c.a != 3 || c.b != 60 || c.c != 4) return 7;

    // Trailing bitfield: the access window stays inside the struct.
    struct E e;
    e.c = 11;
    e.b = 30000;
    if (e.c != 11 || e.b != 30000) return 8;

    // Static initializer merges into the packed unit.
    if (ga.flags != 85 || ga.c != 7) return 9;
    return 0;
}
