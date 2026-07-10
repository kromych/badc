// A bitfield struct member initialized at block scope by a non-constant
// (runtime) value: the walker read-modify-writes the storage unit so
// adjacent bitfields in the same unit are preserved. Signedness, packing
// across storage units, and interleaving with regular fields all match
// GCC/clang. Returns 0 on success; distinct non-zero per fail.

struct Packed {
    unsigned a : 4;
    unsigned b : 4;
    int c : 5;      // signed
    unsigned d : 20;
};

// Bitfields interleaved with a regular field and spanning a unit boundary.
struct Mixed {
    unsigned short tag;
    unsigned lo : 3;
    unsigned mid : 10;
    unsigned hi : 19;
    int trailer;
};

int build_packed(int x, int y, int z, int w) {
    struct Packed s = {x, y, z, w};
    return s.a == (unsigned)(x & 0xF) && s.b == (unsigned)(y & 0xF) && s.c == z &&
           s.d == (unsigned)(w & 0xFFFFF);
}

int build_mixed(int t, int a, int b, int cc, int tr) {
    struct Mixed m = {t, a, b, cc, tr};
    return m.tag == (unsigned short)t && m.lo == (unsigned)(a & 0x7) &&
           m.mid == (unsigned)(b & 0x3FF) && m.hi == (unsigned)(cc & 0x7FFFF) && m.trailer == tr;
}

int main(void) {
    if (!build_packed(5, 10, -3, 0x12345)) {
        return 1;
    }
    if (!build_packed(0xFF, 0x1F, 15, 0xFFFFFFF)) { // truncation to field widths
        return 2;
    }
    if (!build_packed(0, 0, -16, 0)) { // c:5 min signed value = -16
        return 3;
    }
    if (!build_mixed(0x1234, 6, 500, 100000, -77)) {
        return 4;
    }
    if (!build_mixed(0xFFFF, 7, 1023, 0x7FFFF, 0x7fffffff)) {
        return 5;
    }
    return 0;
}
