// Locks C99 6.7.8: a brace-initializer for a struct with
// bitfield members converts each value to the bitfield's type
// (as if assigned) and packs it into the shared storage unit.
// The naive `write n_bytes(field_size) of value at field.offset`
// pattern stomps every prior field in the same storage unit
// because each successive write overwrites the whole unit; the
// merge has to read-modify-write the bitfield's bits.
//
// Stand-alone -- no headers. Each failure returns a distinct
// nonzero code so a regression's cause is visible from the exit.

typedef unsigned char uint8_t;
typedef unsigned int uint32_t;

struct rotate8 {
    uint8_t a : 2, b : 2, c : 2, d : 2;
};

struct mixed32 {
    uint32_t target : 8, weak : 1, name : 23;
};

struct triplet {
    uint8_t a : 3, b : 3, c : 2;
};

int main(void) {
    {
        struct rotate8 r = { 1, 2, 3, 0 };
        if (r.a != 1) return 11;
        if (r.b != 2) return 12;
        if (r.c != 3) return 13;
        if (r.d != 0) return 14;
    }

    {
        struct mixed32 m = { 0xab, 1, 0x12345 };
        if (m.target != 0xab) return 21;
        if (m.weak != 1) return 22;
        if (m.name != 0x12345) return 23;
    }

    {
        // Maxima for each width: 3-bit fields hold 7, 2-bit holds 3.
        struct triplet t = { 7, 7, 3 };
        if (t.a != 7) return 31;
        if (t.b != 7) return 32;
        if (t.c != 3) return 33;
    }

    {
        // Partial initializer: missing tail elements zero-fill
        // per C99 6.7.8 paragraph 21.
        struct rotate8 r = { 1, 2 };
        if (r.a != 1) return 41;
        if (r.b != 2) return 42;
        if (r.c != 0) return 43;
        if (r.d != 0) return 44;
    }

    return 0;
}
