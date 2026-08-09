// A trailing `__attribute__((packed))` on a UNION body drops the tail
// padding its natural alignment added: the union's size becomes the
// widest member's storage and its alignment becomes 1. Members already
// sit at offset 0, so nothing moves. Only the size changed, which is
// what a hardware-register overlay asserts -- the kernel's ionic device
// registers are a union of a packed aggregate and a word array, sized to
// the register page.

#include <stddef.h>

typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef unsigned long long u64;

// Widest member is 60 bytes; the 8-byte-aligned `stats` arm would round
// the natural size to 64.
union regs {
    u8 macaddr[6];
    struct { u64 pa; u32 len; } stats;
    u8 pad[60];
} __attribute__((packed));

// The attribute on the type prefix means the same thing.
union __attribute__((packed)) regs_pre {
    u8 macaddr[6];
    struct { u64 pa; u32 len; } stats;
    u8 pad[60];
};

// The union as an anonymous member, and as a named one: the 4-byte
// header is followed immediately by the 60-byte union.
struct anon_member {
    u8  opcode;
    u8  attr;
    u16 vf_index;
    union {
        u8 macaddr[6];
        struct { u64 pa; u32 len; } stats;
        u8 pad[60];
    } __attribute__((packed));
};

struct named_member {
    u8  opcode;
    u8  attr;
    u16 vf_index;
    union regs u;
};

// An explicit `aligned(N)` member still raises the packed union, so an
// array of it keeps every element on that boundary.
union aligned_arm {
    u8 pad[12];
    u32 word __attribute__((aligned(8)));
} __attribute__((packed));

// A bitfield union is sized by the widest member's bits, rounded up.
union bits {
    u32 w : 20;
    u8 b;
} __attribute__((packed));

// Without the attribute the tail padding stays.
union natural {
    u8 macaddr[6];
    struct { u64 pa; u32 len; } stats;
    u8 pad[60];
};

int main(void) {
    if (sizeof(union regs) != 60) return 1;
    if (sizeof(union regs_pre) != 60) return 2;
    if (sizeof(union natural) != 64) return 3;

    if (sizeof(struct anon_member) != 64) return 4;
    if (offsetof(struct anon_member, macaddr) != 4) return 5;
    if (offsetof(struct anon_member, stats) != 4) return 6;
    if (offsetof(struct anon_member, pad) != 4) return 7;

    if (sizeof(struct named_member) != 64) return 8;
    if (offsetof(struct named_member, u) != 4) return 9;

    if (sizeof(union aligned_arm) != 16) return 10;
    {
        union aligned_arm arr[2];
        if ((char *) &arr[1] - (char *) &arr[0] != 16) return 11;
    }

    if (sizeof(union bits) != 3) return 12;

    // The stride of a packed union array is its packed size.
    {
        union regs r[2];
        if ((char *) &r[1] - (char *) &r[0] != 60) return 13;
    }

    // Every arm still starts at the union's base.
    {
        union regs r;
        if ((char *) r.macaddr != (char *) &r) return 14;
        if ((char *) &r.stats != (char *) &r) return 15;
        if ((char *) r.pad != (char *) &r) return 16;
        r.pad[59] = 7;
        if (((u8 *) &r)[59] != 7) return 17;
    }
    return 0;
}
