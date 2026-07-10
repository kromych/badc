// C99 6.7.2.1p11: consecutive bitfields are packed by bit position. A
// bitfield is placed at the running bit cursor and bumped to the next
// storage-unit boundary of its declared type only when it would
// otherwise straddle one. A following bitfield of a smaller base type
// shares the bits left in a larger neighbour's unit rather than opening
// a new unit -- the layout gcc and clang produce. The earlier code
// opened a new unit on every base-type change, which shifted every
// field after a mixed-base bitfield run (it mislaid a real-world
// header whose `uint32_t len:31; uint8_t is_wide:1;` pair must share
// one 4-byte unit).

#include <stdint.h>

// A mixed-base bitfield header shape.
struct Hdr {
    uint32_t len : 31;
    uint8_t is_wide : 1;
    uint32_t hash : 30;
    uint8_t atom_type : 2;
    uint32_t next;
    uint8_t data[4];
};

int main(void) {
    // The two mixed-base bitfield pairs share one 4-byte unit each, so
    // `next` sits at offset 8 and `data` at offset 12 (total size 16).
    if (sizeof(struct Hdr) != 16) return 1;

    struct Hdr h;
    h.len = 0x7FFFFFFF; // all 31 bits
    h.is_wide = 1;
    h.hash = 0x3FFFFFFF; // all 30 bits
    h.atom_type = 3;     // both bits
    h.next = 0xDEADBEEF;
    h.data[0] = 0xAB;

    // Each field round-trips with no overlap (a packing error would
    // bleed a neighbour's bits into one of these reads).
    if (h.len != 0x7FFFFFFF) return 2;
    if (h.is_wide != 1) return 3;
    if (h.hash != 0x3FFFFFFF) return 4;
    if (h.atom_type != 3) return 5;
    if (h.next != 0xDEADBEEF) return 6;
    if (h.data[0] != 0xAB) return 7;

    // `next` must land in its own 4-byte unit at offset 8, not be
    // disturbed by the bitfield writes above.
    h.len = 0;
    h.atom_type = 0;
    if (h.next != 0xDEADBEEF) return 8;

    // A bitfield that straddles its declared unit boundary is bumped to
    // the next unit: two 9-bit uint16 fields occupy 4 bytes, not 3.
    struct Straddle {
        uint16_t a : 9;
        uint16_t b : 9;
    };
    if (sizeof(struct Straddle) != 4) return 9;
    struct Straddle s;
    s.a = 0x1FF;
    s.b = 0x123;
    if (s.a != 0x1FF || s.b != 0x123) return 10;

    return 0;
}
