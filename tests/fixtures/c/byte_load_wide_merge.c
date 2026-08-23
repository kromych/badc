// Byte-at-a-time readers collapse to one wide load. The big-endian
// assembly -- the shape crypto and container-format code is written in
// -- takes a byte reversal on top on a little-endian target; the
// little-endian assembly is the wide load alone. Both orders appear at
// 4 and 8 bytes, the loop form of the 8-byte reader stands in for the
// per-byte loop the same code is often written as, and the 3-byte
// reader has no hardware width to merge into and stays byte-wise.
//
// The bases are unaligned as well as aligned: the merged access proves
// only the byte alignment its parts had.
//
// Returns 0 on success, otherwise the number of the failing check.

typedef unsigned char u8;
typedef unsigned int u32;
typedef unsigned long long u64;

u32 load_be32(const u8 *p) {
    return ((u32)p[0] << 24) | ((u32)p[1] << 16) | ((u32)p[2] << 8) | (u32)p[3];
}

u32 load_le32(const u8 *p) {
    return (u32)p[0] | ((u32)p[1] << 8) | ((u32)p[2] << 16) | ((u32)p[3] << 24);
}

u64 load_be64(const u8 *p) {
    u64 v = 0;
    int i;
    for (i = 0; i < 8; ++i) {
        v = (v << 8) | p[i];
    }
    return v;
}

unsigned load_le16(const u8 *p) {
    return (unsigned)p[0] | ((unsigned)p[1] << 8);
}

u32 load_be24(const u8 *p) {
    return ((u32)p[0] << 16) | ((u32)p[1] << 8) | (u32)p[2];
}

int main(void) {
    u8 buf[16];
    unsigned i;
    for (i = 0; i < sizeof buf; ++i) {
        buf[i] = (u8)(0x11u * (i + 1));
    }
    if (load_be32(buf) != 0x11223344u) {
        return 1;
    }
    if (load_le32(buf) != 0x44332211u) {
        return 2;
    }
    if (load_be32(buf + 1) != 0x22334455u) {
        return 3;
    }
    if (load_le32(buf + 3) != 0x77665544u) {
        return 4;
    }
    if (load_be64(buf) != 0x1122334455667788ull) {
        return 5;
    }
    if (load_be64(buf + 1) != 0x2233445566778899ull) {
        return 6;
    }
    if (load_le16(buf + 5) != 0x7766u) {
        return 7;
    }
    if (load_be24(buf + 2) != 0x334455u) {
        return 8;
    }
    return 0;
}
