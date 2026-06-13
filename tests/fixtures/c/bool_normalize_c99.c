// C99 6.3.1.2: when any scalar value is converted to `_Bool`, the
// result is 0 if the value compares equal to 0, otherwise 1. The
// type occupies one byte (6.2.5p2 / 6.5.3.4) and a load reads back
// the stored 0 / 1. Every conversion site -- initialiser,
// assignment, cast, struct-field store, function argument, return
// value, arithmetic operand -- must apply the normalisation.

#include <stdbool.h>

struct flags {
    _Bool a;
    int n;
    _Bool b;
};

static _Bool ret_bool(int v) {
    return v; // return conversion normalises
}

static int take_bool(_Bool b) {
    return (int)b; // argument conversion normalises
}

int main(void) {
    if (sizeof(_Bool) != 1) return 1;

    _Bool i = 5; // initialiser
    if ((int)i != 1) return 2;
    _Bool z = 0;
    if ((int)z != 0) return 3;
    _Bool neg = -7;
    if ((int)neg != 1) return 4;

    _Bool wide = 256; // not truncated to the low byte
    if ((int)wide != 1) return 5;

    _Bool c;
    c = 42; // assignment
    if ((int)c != 1) return 6;

    int local = 3;
    _Bool fromptr = (_Bool)&local; // pointer is non-null -> 1
    if ((int)fromptr != 1) return 7;

    _Bool fp_nz = 0.5; // floating non-zero -> 1
    if ((int)fp_nz != 1) return 8;
    _Bool fp_z = 0.0;
    if ((int)fp_z != 0) return 9;

    struct flags f;
    f.a = 99;
    f.n = 7;
    f.b = 0;
    if ((int)f.a != 1) return 10;
    if (f.n != 7) return 11;
    if ((int)f.b != 0) return 12;

    if ((int)ret_bool(42) != 1) return 13;
    if ((int)ret_bool(0) != 0) return 14;
    if (take_bool(123) != 1) return 15;

    _Bool arr[3];
    arr[0] = 9;
    arr[1] = 0;
    arr[2] = -3;
    if ((int)arr[0] != 1 || (int)arr[1] != 0 || (int)arr[2] != 1) return 16;

    // The promoted operand participates in arithmetic as 0 / 1.
    _Bool sum = i + z + neg; // 1 + 0 + 1 = 2, stored as 1
    if ((int)sum != 1) return 17;

    bool t = true, ff = false; // <stdbool.h> spellings
    if (!t || ff) return 18;
    bool m = 17;
    if ((int)m != 1) return 19;

    return 0;
}
