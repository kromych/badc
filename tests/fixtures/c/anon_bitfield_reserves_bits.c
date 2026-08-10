// C99 6.7.2.1p11: an unnamed bit-field with a non-zero width reserves
// that many bits of padding; only a width of zero is special, ending the
// current storage unit without reserving anything. Both forms have to
// survive a `packed` attribute that follows the closing brace, which
// re-lays the members. The shapes below are the kernel's IOAM6 on-wire
// headers and the nouveau CRC notifier register overlay. Values come
// from gcc 16 on linux/x86_64 and linux/aarch64, which agree on all of
// them; unpacked members are typed so the aggregate's alignment comes
// from a named member, which the two targets also agree on.

#include <stddef.h>
#include <string.h>

// `packed` after the body, the spelling that re-lays the members.
struct post_packed {
    unsigned char a;
    unsigned char : 8;
    unsigned char b;
} __attribute__((packed));

// The same struct with `packed` before the tag must agree.
struct __attribute__((packed)) pre_packed {
    unsigned char a;
    unsigned char : 8;
    unsigned char b;
};

struct unpacked {
    unsigned char a;
    unsigned char : 8;
    unsigned char b;
};

// Only unnamed bit-fields: the struct is as wide as the bits they take.
struct only_anon {
    unsigned int : 24;
} __attribute__((packed));

// A width-zero unnamed bit-field ends the storage unit; a packed layout
// still honors the break.
struct zero_width {
    unsigned char a;
    unsigned int : 0;
    unsigned char b;
} __attribute__((packed));

// Bits pack with no storage-unit padding when the struct is packed.
struct bit_run {
    unsigned int a : 12;
    unsigned int : 5;
    unsigned int b : 20;
} __attribute__((packed));

// A union member with no name still occupies its own storage.
union anon_in_union {
    unsigned char a;
    unsigned int : 24;
} __attribute__((packed));

// `struct ioam6_hdr` -- the reserved byte is part of the wire format.
struct ioam6_hdr {
    unsigned char opt_type;
    unsigned char opt_len;
    unsigned char : 8;
    unsigned char type;
} __attribute__((packed));

// `struct ioam6_trace_hdr` -- two reserved bits precede `overflow`.
struct ioam6_trace_hdr {
    unsigned short namespace_id;
    unsigned char : 1, : 1, overflow : 1, nodelen : 5;
    unsigned char remlen : 7;
} __attribute__((packed));

// `struct crc907d_notifier` -- a reserved register word before the array.
struct crc_notifier {
    unsigned int status;
    unsigned int : 32;
    unsigned int entries[2];
} __attribute__((packed));

int main(void) {
    if (sizeof(struct post_packed) != 3) return 1;
    if (offsetof(struct post_packed, b) != 2) return 2;
    if (sizeof(struct pre_packed) != 3) return 3;
    if (offsetof(struct pre_packed, b) != 2) return 4;
    if (sizeof(struct unpacked) != 3) return 5;
    if (offsetof(struct unpacked, b) != 2) return 6;

    if (sizeof(struct only_anon) != 3) return 7;

    // The break puts `b` at byte 4 on every target. The tail padding
    // after it is target-defined: AArch64 keeps the unnamed bit-field's
    // 4-byte boundary through `packed` and rounds the struct to 8,
    // x86_64 does not and leaves it at 5.
    if (offsetof(struct zero_width, b) != 4) return 8;
#if defined(__aarch64__)
    if (sizeof(struct zero_width) != 8) return 9;
    if (_Alignof(struct zero_width) != 4) return 30;
#else
    if (sizeof(struct zero_width) != 5) return 9;
    if (_Alignof(struct zero_width) != 1) return 30;
#endif

    // 12 + 5 + 20 = 37 bits, rounded up to 5 bytes.
    if (sizeof(struct bit_run) != 5) return 10;

    if (sizeof(union anon_in_union) != 3) return 11;

    if (sizeof(struct ioam6_hdr) != 4) return 12;
    if (offsetof(struct ioam6_hdr, type) != 3) return 13;

    if (sizeof(struct ioam6_trace_hdr) != 4) return 14;
    if (sizeof(struct crc_notifier) != 16) return 15;
    if (offsetof(struct crc_notifier, entries) != 8) return 16;

    // The reserved bits are where the wire format puts them: `overflow`
    // is bit 18 of the header and `nodelen` bits 19..23, so each lands
    // in byte 2 rather than sliding down into the reserved pair.
    {
        struct ioam6_trace_hdr t;
        unsigned char *b = (unsigned char *) &t;

        memset(&t, 0, sizeof t);
        t.overflow = 1;
        if (b[0] != 0 || b[1] != 0 || b[2] != 0x04 || b[3] != 0) return 17;

        memset(&t, 0, sizeof t);
        t.nodelen = 0x1f;
        if (b[0] != 0 || b[1] != 0 || b[2] != 0xf8 || b[3] != 0) return 18;

        memset(&t, 0, sizeof t);
        t.remlen = 0x7f;
        if (b[0] != 0 || b[1] != 0 || b[2] != 0 || b[3] != 0x7f) return 19;

        // The fields read back what was written.
        memset(&t, 0, sizeof t);
        t.overflow = 1;
        t.nodelen = 9;
        t.remlen = 100;
        if (t.overflow != 1 || t.nodelen != 9 || t.remlen != 100) return 20;
    }

    // The reserved byte of the option header keeps `type` at byte 3.
    {
        struct ioam6_hdr h;
        unsigned char *b = (unsigned char *) &h;
        memset(&h, 0, sizeof h);
        h.type = 0xff;
        if (b[0] != 0 || b[1] != 0 || b[2] != 0 || b[3] != 0xff) return 21;
    }

    // Members after the reserved word read the array the device wrote.
    {
        struct crc_notifier n;
        memset(&n, 0, sizeof n);
        n.status = 1;
        n.entries[0] = 0x11223344;
        n.entries[1] = 0x55667788;
        if (n.status != 1) return 22;
        if (n.entries[0] != 0x11223344 || n.entries[1] != 0x55667788) return 23;
        if ((char *) &n.entries[0] - (char *) &n != 8) return 24;
    }
    return 0;
}
