// A value read from memory and only tested against zero, at every load
// width and signedness: values whose low byte, word or double word is
// zero while the object is not, zero objects between non-zero neighbors,
// both senses of the test, the subscripted and the frame-slot forms, and
// a store into the tested object between its read and the branch. The
// exit code names the first check that fails.

#define NOINLINE __attribute__((noinline))

struct cells {
    unsigned char before8;
    signed char s8;
    unsigned char after8;
    unsigned char pad;
    unsigned short before16;
    short s16;
    unsigned short after16;
    unsigned short pad16;
    unsigned before32;
    int s32;
    unsigned after32;
    unsigned pad32;
    unsigned long before64;
    long s64;
    unsigned long after64;
};

NOINLINE static int set8(const struct cells *c) { if (c->s8) return 1; return 0; }
NOINLINE static int clear8(const struct cells *c) { if (!c->s8) return 1; return 0; }
NOINLINE static int set16(const struct cells *c) { if (c->s16) return 1; return 0; }
NOINLINE static int clear16(const struct cells *c) { if (!c->s16) return 1; return 0; }
NOINLINE static int set32(const struct cells *c) { if (c->s32) return 1; return 0; }
NOINLINE static int clear32(const struct cells *c) { if (!c->s32) return 1; return 0; }
NOINLINE static int set64(const struct cells *c) { if (c->s64) return 1; return 0; }
NOINLINE static int clear64(const struct cells *c) { if (!c->s64) return 1; return 0; }

NOINLINE static int setu8(const unsigned char *p) { if (*p) return 1; return 0; }
NOINLINE static int setu16(const unsigned short *p) { if (*p) return 1; return 0; }
NOINLINE static int setu32(const unsigned *p) { if (*p) return 1; return 0; }

NOINLINE static int set_at16(const short *a, long i) { if (a[i]) return 1; return 0; }
NOINLINE static int set_at64(const long *a, int i) { if (a[i]) return 1; return 0; }

NOINLINE static void fill(long *out, long v) { *out = v; }

// The tested object is a frame slot whose address escaped.
NOINLINE static int set_local(long v) {
    long slot;
    fill(&slot, v);
    if (slot) return 1;
    return 0;
}

// The branch decides on the value read before the store.
NOINLINE static int read_then_clear(char *p, char *q) {
    char c = *p;
    *q = 0;
    if (c) return 1;
    return 0;
}

NOINLINE static long length(const char *s) {
    const char *p = s;
    while (*p) p++;
    return p - s;
}

int main(void) {
    struct cells c = {0xff, 0, 0xff, 0, 0xffff, 0, 0xffff, 0, 0xffffffffu, 0, 0xffffffffu, 0,
                      0xfffffffffffffffful, 0, 0xfffffffffffffffful};
    // Zero objects between all-ones neighbors.
    if (set8(&c) || !clear8(&c) || set16(&c) || !clear16(&c)) return 1;
    if (set32(&c) || !clear32(&c) || set64(&c) || !clear64(&c)) return 2;

    // Only the top bit of each object.
    c.s8 = -128;
    c.s16 = -32768;
    c.s32 = -2147483647 - 1;
    c.s64 = -9223372036854775807L - 1;
    if (!set8(&c) || clear8(&c) || !set16(&c) || clear16(&c)) return 3;
    if (!set32(&c) || clear32(&c) || !set64(&c) || clear64(&c)) return 4;

    // A zero low part under a non-zero upper part.
    c.s16 = 0x100;
    c.s32 = 0x10000;
    c.s64 = 0x100000000L;
    if (!set16(&c) || clear16(&c) || !set32(&c) || clear32(&c) || !set64(&c) || clear64(&c)) return 5;

    unsigned char u8[2] = {0x80, 0};
    unsigned short u16[2] = {0x8000, 0};
    unsigned u32[2] = {0x80000000u, 0};
    if (!setu8(u8) || setu8(u8 + 1) || !setu16(u16) || setu16(u16 + 1)) return 6;
    if (!setu32(u32) || setu32(u32 + 1)) return 7;

    short a16[4] = {0, 0x100, 0, -1};
    long a64[4] = {0, 0x100000000L, 0, -1};
    if (set_at16(a16, 0) || !set_at16(a16, 1) || set_at16(a16 + 3, -1) || !set_at16(a16, 3)) return 8;
    if (set_at64(a64, 0) || !set_at64(a64, 1) || set_at64(a64 + 3, -1) || !set_at64(a64, 3)) return 9;

    if (set_local(0) || !set_local(0x100000000L) || !set_local(-1)) return 10;

    char cell = 5;
    if (!read_then_clear(&cell, &cell) || cell != 0) return 11;
    if (read_then_clear(&cell, &cell)) return 12;

    if (length("") != 0 || length("seven77") != 7) return 13;
    return 0;
}
