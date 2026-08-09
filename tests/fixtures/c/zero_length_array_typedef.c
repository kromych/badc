// A zero-length array (`T x[0]`, a GCC extension) occupies no storage
// but still places at its element type's alignment, and that holds when
// the array type arrives through a typedef rather than being written in
// the member's own declarator. The ALSA userspace ABI headers use the
// idiom to make one struct describe both the 32- and 64-bit layouts.
// Values below come from gcc 16 on linux/x86_64 and linux/aarch64.

#include <stddef.h>

typedef char pad0_t[0];
typedef long lpad0_t[0];

struct through_typedef {
    pad0_t p;
    long x;
};

struct between_members {
    long a;
    pad0_t p;
    long b;
};

// The same shape written directly in the member.
struct directly {
    char p[0];
    long x;
};

// A zero-length alias still imposes its element type's alignment.
struct aligning {
    char c;
    lpad0_t p;
    char d;
};

// Zero extent survives further array decoration: an array of a
// zero-length alias, and a multi-dimensional zero-length alias.
typedef pad0_t pad0_arr_t[2];
typedef char pad0_2d_t[0][4];
struct decorated {
    pad0_arr_t p;
    pad0_2d_t q;
    long x;
};

// The `struct __snd_pcm_mmap_control64` shape from the ALSA uapi header.
typedef char pad_before_t[0];
struct mmap_control {
    pad_before_t pad1;
    unsigned long appl_ptr;
    pad_before_t pad2;
    pad_before_t pad3;
    unsigned long avail_min;
};

int main(void) {
    if (sizeof(pad0_t) != 0) return 1;
    if (sizeof(lpad0_t) != 0) return 2;
    if (_Alignof(lpad0_t) != 8) return 3;

    if (sizeof(struct through_typedef) != 8) return 4;
    if (offsetof(struct through_typedef, p) != 0) return 5;
    if (offsetof(struct through_typedef, x) != 0) return 6;

    if (sizeof(struct between_members) != 16) return 7;
    if (offsetof(struct between_members, p) != 8) return 8;
    if (offsetof(struct between_members, b) != 8) return 9;

    // The typedef'd and the directly written member agree.
    if (sizeof(struct directly) != sizeof(struct through_typedef)) return 10;
    if (offsetof(struct directly, x) != offsetof(struct through_typedef, x)) return 11;

    if (sizeof(struct aligning) != 16) return 12;
    if (offsetof(struct aligning, d) != 8) return 13;

    if (sizeof(pad0_arr_t) != 0) return 14;
    if (sizeof(pad0_2d_t) != 0) return 15;
    if (sizeof(struct decorated) != 8) return 16;
    if (offsetof(struct decorated, x) != 0) return 17;

    if (sizeof(struct mmap_control) != 16) return 18;
    if (offsetof(struct mmap_control, appl_ptr) != 0) return 19;
    if (offsetof(struct mmap_control, avail_min) != 8) return 20;

    // The zero-length members overlay the following one, and writing
    // through the struct leaves the two real fields addressable.
    struct mmap_control c;
    c.appl_ptr = 0x1122334455667788UL;
    c.avail_min = 9;
    if (c.appl_ptr != 0x1122334455667788UL) return 21;
    if (c.avail_min != 9) return 22;
    if ((char *) &c.avail_min - (char *) &c.appl_ptr != 8) return 23;
    return 0;
}
