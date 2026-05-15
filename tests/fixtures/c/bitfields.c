// bitfields. Pack into shared 8-byte storage units; reads
// emit a `Li; Shr; And` extraction; writes emit a load-clear-shift-
// or-store sequence that preserves the other bits in the unit.
//
// SQLite uses bitfields heavily in Vdbe / Pager flag fields; this
// fixture exercises the patterns that show up there.

#include <stdlib.h>

// C99 6.7.2.1p4 leaves the signedness of a plain `int` bitfield
// implementation-defined, but a signed bitfield of width N can
// only hold values in [-2^(N-1), 2^(N-1)-1]. The boolean / flag
// patterns below ask for the unsigned ranges; declare them
// unsigned so the read-back values match the assignments.
struct Flags {
    unsigned int present:1;
    unsigned int dirty:1;
    unsigned int kind:3;
    unsigned int prio:5;
    unsigned int wide:32;
    int normal;
};

struct Bits {
    unsigned int a:1;
    unsigned int b:1;
    unsigned int c:1;
    unsigned int d:1;
    unsigned int e:4;
    unsigned int f:8;
};

int main() {
    struct Flags fl;
    struct Bits b;

    fl.present = 1;
    fl.dirty = 0;
    fl.kind = 5;
    fl.prio = 17;
    fl.wide = 0x12345678;
    fl.normal = 999;

    if (fl.present != 1) return 1;
    if (fl.dirty != 0) return 2;
    if (fl.kind != 5) return 3;
    if (fl.prio != 17) return 4;
    if (fl.wide != 0x12345678) return 5;
    if (fl.normal != 999) return 6;

    // Mutating one bitfield must not disturb the others in the
    // same storage word.
    fl.present = 0;
    if (fl.present != 0) return 7;
    if (fl.dirty != 0) return 8;
    if (fl.kind != 5) return 9;
    if (fl.prio != 17) return 10;
    if (fl.wide != 0x12345678) return 11;
    if (fl.normal != 999) return 12;

    fl.kind = 7;
    if (fl.kind != 7) return 13;
    if (fl.prio != 17) return 14;
    if (fl.present != 0) return 15;

    // Pure bitfield struct.
    b.a = 1;
    b.b = 1;
    b.c = 0;
    b.d = 1;
    b.e = 11;
    b.f = 200;

    if (b.a != 1) return 16;
    if (b.b != 1) return 17;
    if (b.c != 0) return 18;
    if (b.d != 1) return 19;
    if (b.e != 11) return 20;
    if (b.f != 200) return 21;

    // Mutate via bitwise operators on the bitfield value -- the
    // expression `b.f + 1` reads, adds, and stores back.
    b.f = b.f + 1;
    if (b.f != 201) return 22;

    return 0;
}
