// A flexible array member (C99 6.7.2.1p18) declared inside an unnamed
// union, next to a scalar arm -- the shape a union uses to give the same
// trailing bytes a one-element and a variable-length reading.
//
// A static initializer of such a struct is sized in two steps: the fixed
// part is reserved first, then the flexible array's element count is
// measured. The FAM's own offset is not the fixed part's size here -- the
// scalar arm sits at that same offset and extends past it -- so a
// reservation of the offset alone leaves the sibling's store out of
// bounds.
//
// A guard object follows each initialized one, so a store past the fixed
// part is visible.

#include <stdio.h>

struct desc {
    unsigned char len;
    unsigned char type;
    unsigned char sub;
    unsigned char master;
    union {
        unsigned char slave0;
        struct {
            struct { } __empty_slaves;
            unsigned char slaves[];
        };
    };
} __attribute__ ((packed));

static struct desc d_scalar = {
    .len = sizeof(d_scalar),
    .type = 0x24,
    .sub = 0x06,
    .master = 1,
    .slave0 = 2,
};
static unsigned int guard1 = 0xA5A5A5A5u;

// Unpacked, and with a wider union arm than the flexible one, so the
// fixed size exceeds the flexible member's offset by more than a byte.
struct wide {
    int tag;
    union {
        long long whole;
        struct {
            struct { } __empty_parts;
            short parts[];
        };
    };
};

static struct wide w_scalar = { .tag = 9, .whole = 0x1122334455667788LL };
static unsigned int guard2 = 0x33333333u;

// A plain trailing flexible array stays unaffected.
struct plain {
    int n;
    unsigned char v[];
};
static struct plain p = { .n = 3, .v = { 7, 8, 9 } };
static unsigned int guard3 = 0x55555555u;

int main(void) {
    if (sizeof(struct desc) != 5) return 1;
    if (d_scalar.len != 5) return 2;
    if (d_scalar.type != 0x24) return 3;
    if (d_scalar.sub != 0x06) return 4;
    if (d_scalar.master != 1) return 5;
    if (d_scalar.slave0 != 2) return 6;
    if (d_scalar.slaves[0] != 2) return 7;
    if (guard1 != 0xA5A5A5A5u) return 8;

    if (sizeof(struct wide) != 16) return 20;
    if (w_scalar.tag != 9) return 21;
    if (w_scalar.whole != 0x1122334455667788LL) return 22;
    if (guard2 != 0x33333333u) return 23;

    if (p.n != 3) return 40;
    if (p.v[0] != 7 || p.v[1] != 8 || p.v[2] != 9) return 41;
    if (guard3 != 0x55555555u) return 42;

    printf("ok\n");
    return 0;
}
