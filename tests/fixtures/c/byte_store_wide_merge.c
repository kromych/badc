// The store counterpart of the byte-assembly merge: a run of byte
// stores of one value's successive bytes collapses to one wide store,
// with a byte reversal of the value first when the run writes the
// big-endian order on a little-endian target. The loop form stands in
// for the per-byte loop the same code is often written as, and the
// 3-byte writer has no hardware width to merge into.
//
// Returns 0 on success, otherwise the number of the failing check.

typedef unsigned char u8;
typedef unsigned int u32;
typedef unsigned long long u64;

void store_be32(u8 *p, u32 v) {
    p[0] = (u8)(v >> 24);
    p[1] = (u8)(v >> 16);
    p[2] = (u8)(v >> 8);
    p[3] = (u8)v;
}

void store_le32(u8 *p, u32 v) {
    p[0] = (u8)v;
    p[1] = (u8)(v >> 8);
    p[2] = (u8)(v >> 16);
    p[3] = (u8)(v >> 24);
}

void store_be64(u8 *p, u64 v) {
    int i;
    for (i = 7; i >= 0; --i) {
        p[i] = (u8)v;
        v >>= 8;
    }
}

void store_le16(u8 *p, unsigned v) {
    p[0] = (u8)v;
    p[1] = (u8)(v >> 8);
}

void store_be24(u8 *p, u32 v) {
    p[0] = (u8)(v >> 16);
    p[1] = (u8)(v >> 8);
    p[2] = (u8)v;
}

static int check(const u8 *p, const u8 *want, unsigned n) {
    unsigned i;
    for (i = 0; i < n; ++i) {
        if (p[i] != want[i]) {
            return 0;
        }
    }
    return 1;
}

int main(void) {
    u8 buf[16];
    unsigned i;
    for (i = 0; i < sizeof buf; ++i) {
        buf[i] = 0;
    }

    store_be32(buf, 0x11223344u);
    {
        static const u8 want[4] = {0x11, 0x22, 0x33, 0x44};
        if (!check(buf, want, 4)) {
            return 1;
        }
    }
    store_le32(buf + 4, 0x11223344u);
    {
        static const u8 want[4] = {0x44, 0x33, 0x22, 0x11};
        if (!check(buf + 4, want, 4)) {
            return 2;
        }
    }
    store_be32(buf + 9, 0xaabbccddu);
    {
        static const u8 want[4] = {0xaa, 0xbb, 0xcc, 0xdd};
        if (!check(buf + 9, want, 4)) {
            return 3;
        }
    }
    store_be64(buf + 1, 0x0102030405060708ull);
    {
        static const u8 want[8] = {1, 2, 3, 4, 5, 6, 7, 8};
        if (!check(buf + 1, want, 8)) {
            return 4;
        }
    }
    store_le16(buf + 11, 0xfeedu);
    {
        static const u8 want[2] = {0xed, 0xfe};
        if (!check(buf + 11, want, 2)) {
            return 5;
        }
    }
    store_be24(buf + 13, 0x778899u);
    {
        static const u8 want[3] = {0x77, 0x88, 0x99};
        if (!check(buf + 13, want, 3)) {
            return 6;
        }
    }
    // The bytes the runs did not name keep their value.
    if (buf[0] != 0x11 || buf[9] != 0xaa) {
        return 7;
    }
    return 0;
}
