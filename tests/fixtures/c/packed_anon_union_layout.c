// A trailing `__attribute__((packed))` re-runs the field layout (repack).
// When the struct contains an ANONYMOUS union, the union's promoted members
// must keep overlapping (and a nested anonymous struct keeps its in-arm
// offsets); repack must not lay them out sequentially. This mirrors the
// ACPI bios-linker-loader command entry: a 4-byte tag then an anonymous
// union whose widest arm is a 124-byte pad, so each entry is exactly 128
// bytes and every arm begins right after the tag. Laying the arms
// sequentially inflated the entry (to 188 bytes) and moved every field,
// which a firmware consumer that reads fixed-size records rejects.

#include <stddef.h>
#include <string.h>

struct entry {
    unsigned int command;
    union {
        struct { char file[56]; unsigned int align; unsigned char zone; } alloc;
        struct { char file[56]; unsigned int offset; unsigned int start;
                 unsigned int length; } cksum;
        char pad[124];
    };
} __attribute__((packed));

// An anonymous struct nested inside the anonymous union: `packed` applies to
// this struct's own members, not to the nested struct type, so `b` keeps its
// natural in-arm offset (4) rather than packing tight against `a`.
struct nested {
    unsigned int tag;
    union {
        struct { char a; int b; };
        long c;
    };
} __attribute__((packed));

int main(void) {
    // 4-byte tag + 124-byte widest arm, no inter-member padding.
    if (sizeof(struct entry) != 128) return 1;
    if (offsetof(struct entry, command) != 0) return 2;
    // Every union arm overlaps at the same base, right after the tag.
    if (offsetof(struct entry, alloc) != 4) return 3;
    if (offsetof(struct entry, cksum) != 4) return 4;
    if (offsetof(struct entry, pad) != 4) return 5;
    // In-arm offsets add onto the shared base.
    if (offsetof(struct entry, cksum.offset) != 60) return 6;
    if (offsetof(struct entry, cksum.start) != 64) return 7;
    if (offsetof(struct entry, cksum.length) != 68) return 8;

    // Consecutive entries have stride == packed size (no per-element pad).
    struct entry arr[2];
    if ((char *) &arr[1] - (char *) &arr[0] != 128) return 9;

    // Writing one arm's fields lands at its offsets and leaves the tag and
    // the other bytes alone -- the original defect corrupted the record.
    struct entry e;
    memset(&e, 0, sizeof e);
    e.command = 3;
    e.cksum.offset = 8;
    e.cksum.length = 20;
    unsigned char *p = (unsigned char *) &e;
    if (p[0] != 3) return 10;
    if (p[60] != 8) return 11;
    if (p[68] != 20) return 12;

    // Nested anonymous struct in the anonymous union: a,b keep in-arm
    // offsets 0/4; c overlaps them; union sized by the wider arm (8).
    if (sizeof(struct nested) != 12) return 13;
    if (offsetof(struct nested, tag) != 0) return 14;
    if (offsetof(struct nested, a) != 4) return 15;
    if (offsetof(struct nested, b) != 8) return 16;
    if (offsetof(struct nested, c) != 4) return 17;
    return 0;
}
