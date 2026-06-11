// C99 6.7.2.1 + 6.7.2.2: a non-negative enum has an unsigned
// underlying type, so an enum bitfield reads unsigned -- a stored
// value whose top bit (within the field width) is set must
// zero-extend, not sign-extend. Exercised through a typedef'd enum
// (the common form), a direct `enum { ... }` field, and a switch on
// the field (the shape that surfaced in quickjs's closure handling).

typedef enum {
    K0, K1, K2, K3, K4, K5, K6 // 0..6; values 4..6 set the field's top bit
} Kind;

struct ViaTypedef {
    Kind k : 3;
};

struct Direct {
    enum { D0, D1, D2, D3, D4, D5, D6 } k : 3;
};

static int dispatch(Kind k) {
    switch (k) {
    case K0: return 0;
    case K4: return 40;
    case K5: return 50;
    case K6: return 60;
    default: return -1;
    }
}

int main(void) {
    struct ViaTypedef t;
    t.k = K6;
    if ((int)t.k != 6) return 1; // 6 must not read as -2
    t.k = K4;
    if ((int)t.k != 4) return 2;
    t.k = K2;
    if ((int)t.k != 2) return 3;

    struct Direct d;
    d.k = D5;
    if ((int)d.k != 5) return 4; // 5 must not read as -3

    // A switch on the bitfield must reach the right case for the
    // top-bit-set values.
    if (dispatch(K6) != 60) return 5;
    if (dispatch(K5) != 50) return 6;
    if (dispatch(K4) != 40) return 7;
    if (dispatch(K0) != 0) return 8;

    return 0;
}
