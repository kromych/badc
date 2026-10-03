// C99 6.3.1.2, 6.5.2.1, 6.5.6p8, 6.5.7p3, 6.5.16.2, 6.7.5.2p5 and
// 6.8.4.2p5: an `__int128` operand in a scalar context takes part through
// its value, not the temporary the 128-bit value is held in -- as a
// subscript, a pointer offset, a shift count, the operand of a compound
// assignment to a narrower object, a value converted to `_Bool`, an array
// dimension and a `switch` controlling expression, whose labels compare
// with all 128 bits. Each check exits with its own code; success
// returns 0.

static int a[8] = {0, 10, 20, 30, 40, 50, 60, 70};
static __int128 three = 3, zero, big = (__int128)1 << 64, neg = -2;
static unsigned __int128 uthree = 3;

struct B {
    _Bool b;
    _Bool f : 1;
    int c : 7;
};

static int bp(_Bool b) { return b; }
static _Bool br(__int128 x) { return x; }

static int sw(__int128 x) {
    switch (x) {
    case 3: return 30;
    case -2: return -20;
    case 0x7fffffffffffffffLL: return 7;
    case 0xffffffffffffffffULL: return 8;
    case -1: return -1;
    case (__int128)1 << 64: return 64;
    default: return 99;
    }
}

static int usw(unsigned __int128 x) {
    switch (x) {
    case 3: return 30;
    case -1: return -10;
    case 0 ... 2: return 2;
    default: return 99;
    }
}

static int rsw(__int128 x) {
    switch (x) {
    case 1 ... 5: return 15;
    case -9 ... -3: return -93;
    default: return 99;
    }
}

static int dense(__int128 x) {
    switch (x) {
    case 0: return 10;
    case 1: return 11;
    case 2: return 12;
    case 3: return 13;
    case 4: return 14;
    case 5: return 15;
    case 6: return 16;
    case 7: return 17;
    case 8: return 18;
    case 9: return 19;
    default: return 99;
    }
}

static int pointers(void) {
    int *p = a;
    if (a[three] != 30 || three[a] != 30 || *(a + three) != 30 || *(three + a) != 30) return 1;
    if (&a[three] - a != 3 || (a + three) - a != 3 || *(&a[7] - three) != 40) return 2;
    p += three;
    if (*p != 30) return 3;
    p -= three - 1;
    if (*p != 10) return 4;
    a[uthree] = 33;
    if (a[3] != 33) return 5;
    a[3] = 30;
    char *c = (char *)a;
    if ((int *)(c + three * sizeof(int)) != &a[3]) return 6;
    return 0;
}

static int scalars(void) {
    int v = 1;
    if ((v << three) != 8 || (64 >> three) != 8) return 7;
    v <<= three;
    if (v != 8) return 8;
    v = 5;
    v += three;
    v ^= zero;
    if (v != 8) return 9;
    struct B s = { big, 0, 0 };
    s.f = big;
    s.c = 1;
    s.c <<= three;
    if (!s.b || !s.f || s.c != 8) return 10;
    _Bool t = big;
    if (!t || !(_Bool)big || (_Bool)zero || !bp(big) || !br(big) || br(big - big)) return 11;
    _Bool arr[2] = { big, (_Bool)(big >> 1) };
    if (!arr[0] || !arr[1]) return 12;
    {
        int vla[three];
        if (sizeof vla != 3 * sizeof(int)) return 13;
    }
    return 0;
}

static int switches(void) {
    if (sw(three) != 30 || sw(neg) != -20 || sw(0x7fffffffffffffffLL) != 7) return 14;
    if (sw(0xffffffffffffffffULL) != 8 || sw(-1) != -1 || sw(big) != 64) return 15;
    if (sw(big + 3) != 99 || sw(-big) != 99) return 16;
    if (usw(uthree) != 30 || usw(~(unsigned __int128)0) != -10 || usw(1) != 2) return 17;
    if (usw((unsigned __int128)1 << 64) != 99) return 18;
    if (rsw(three) != 15 || rsw(-5) != -93 || rsw(big + 3) != 99 || rsw(-big - 5) != 99) return 19;
    for (int i = 0; i < 10; i++)
        if (dense(i) != 10 + i) return 20;
    if (dense(big) != 99 || dense(big + 5) != 99 || dense(-1) != 99) return 21;
    return 0;
}

int main(void) {
    int r = pointers();
    if (r) return r;
    r = scalars();
    if (r) return r;
    return switches();
}
