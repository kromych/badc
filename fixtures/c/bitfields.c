// M27 -- bitfields. Pack into shared 8-byte storage units; reads
// emit a `Li; Shr; And` extraction; writes emit a load-clear-shift-
// or-store sequence that preserves the other bits in the unit.
//
// SQLite uses bitfields heavily in Vdbe / Pager flag fields; this
// fixture exercises the patterns that show up there.

#include <stdlib.h>

struct Flags {
    int present:1;
    int dirty:1;
    int kind:3;
    int prio:5;
    int wide:32;     // wide field within the same storage word
    int normal;      // regular field after bitfields
};

// Pure bitfield struct -- exercises packing into a single storage
// unit and reading every bit.
struct Bits {
    int a:1;
    int b:1;
    int c:1;
    int d:1;
    int e:4;
    int f:8;
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
