// A conditional between objects of more than one word, each built in its
// own arm, is read word by word through the chosen address: every word
// reads the value its arm stored, whether the caller uses one word or all
// of them. Returns 0 when every result matches.

typedef struct {
    long a, b;
} Pair;

typedef struct {
    long a, b, c;
} Triple;

int flag;
int acc;

static __int128 wide(void) {
    if (flag >= 0)
        return 5;
    return 0;
}

static __int128 wide_high(void) {
    if (flag >= 0)
        return (__int128)7 << 64 | 3;
    return 0;
}

static inline Pair pair_of(long x) {
    Pair p = {x, x + 1};
    return p;
}

static inline Pair pair_neg(long x) {
    Pair p = {-x, -x - 1};
    return p;
}

static inline Triple triple_of(long x) {
    Triple t = {x, 2 * x, 3 * x};
    return t;
}

static inline Triple triple_zero(void) {
    Triple t = {0, 0, 0};
    return t;
}

__attribute__((noinline)) static long pick_pair(long x, int c) {
    Pair p = c ? pair_of(x) : pair_neg(x);
    return p.a * 100 + p.b;
}

__attribute__((noinline)) static long pick_triple(long x, int c) {
    Triple t = c ? triple_of(x) : triple_zero();
    return t.a + t.b * 10 + t.c * 100;
}

int main(void) {
    // The low word reads the stored 5; the high word is dead.
    acc ^= wide();
    if (acc != 5)
        return 1;
    __int128 w = wide_high();
    if ((long)w != 3 || (long)(w >> 64) != 7)
        return 2;
    if (pick_pair(4, 1) != 405)
        return 3;
    if (pick_pair(4, 0) != -405)
        return 4;
    if (pick_triple(2, 1) != 2 + 40 + 600)
        return 5;
    if (pick_triple(2, 0) != 0)
        return 6;
    return 0;
}
