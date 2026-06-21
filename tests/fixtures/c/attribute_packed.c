// GCC `__attribute__((packed))` lays a struct out without inter-member
// padding and with an alignment of 1. The attribute may sit between the
// `struct` keyword and the tag or follow the closing brace, and spells
// as `packed` or `__packed__`. A non-packed struct of the same members
// keeps its natural padding, so the two sizes differ.

#include <stddef.h>

struct __attribute__((packed)) before {
    char c;
    long l;
    int i;
};

struct after {
    char c;
    long l;
    int i;
} __attribute__((__packed__));

struct unpacked {
    char c;
    long l;
    int i;
};

int main(void) {
    // char(1) + long(8) + int(4) = 13, no padding.
    if (sizeof(struct before) != 13) return 1;
    if (sizeof(struct after) != 13) return 2;
    // Natural layout pads the long to offset 8, the int after it, and
    // the tail to a multiple of 8: 24 bytes.
    if (sizeof(struct unpacked) != 24) return 3;

    // Members sit at consecutive offsets in the packed struct.
    if (offsetof(struct before, c) != 0) return 4;
    if (offsetof(struct before, l) != 1) return 5;
    if (offsetof(struct before, i) != 9) return 6;

    // A packed struct in an array has stride == its packed size (no
    // per-element alignment padding).
    struct before arr[2];
    if ((char *) &arr[1] - (char *) &arr[0] != 13) return 7;

    // The fields read and write at their packed offsets.
    struct before b;
    b.c = 1;
    b.l = 0x1122334455667788L;
    b.i = -7;
    if (b.c != 1 || b.l != 0x1122334455667788L || b.i != -7) return 8;
    return 0;
}
