// C99 6.7.2.1p4: a `signed` bit-field of width N stores values in
// [-2^(N-1), 2^(N-1)-1] using two's complement. The read path must
// sign-extend so that the high bit of the bit-field propagates
// through the high half of the accumulator; without that, a stored
// value of `-1` (bit pattern `1...1`) reads back as the unsigned
// `(1 << N) - 1` and arithmetic on it goes through the wrong sign.
//
// Standalone -- no headers. Each failure returns a distinct nonzero
// code so a regression's cause is visible from the exit.

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

struct s_short {
    short a : 2;
    short b : 2;
    short c : 12;
};

struct s_int {
    int a : 3;
    int b : 8;
    int c : 21;
};

struct mixed_signedness {
    unsigned int idx : 12;
    signed short dx : 2;
    signed short dy : 2;
};

int main(void) {
    {
        struct s_short s;
        s.a = -1;
        s.b = 1;
        s.c = -2048;
        if (s.a != -1) return 11;
        if (s.b != 1) return 12;
        if (s.c != -2048) return 13;
        if (s.a + 2 != 1) return 14;
    }

    {
        struct s_int s;
        s.a = -4;
        s.b = -128;
        s.c = -1;
        if (s.a != -4) return 21;
        if (s.b != -128) return 22;
        if (s.c != -1) return 23;
        if (s.a > 0) return 24;
        if ((long long)s.c >= 0) return 25;
    }

    {
        // Mixed-width signed/unsigned in one storage unit: the
        // tinycc-stb regression that triggered this fixture. An
        // unsigned 12-bit clump_index packed next to two signed
        // 2-bit deltas; reading dx must yield -1 for bit pattern
        // `11`, not the unsigned `3`.
        struct mixed_signedness m;
        m.idx = 7;
        m.dx = -1;
        m.dy = 1;
        if (m.idx != 7) return 31;
        if (m.dx != -1) return 32;
        if (m.dy != 1) return 33;
        // The addition that surfaced the bug: dx + base index.
        int base = 6;
        if (m.dx + base != 5) return 34;
    }

    return 0;
}
