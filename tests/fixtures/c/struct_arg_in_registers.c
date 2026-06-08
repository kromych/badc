// C99 6.5.2.2 + AAPCS64 6.8.2: a small (<= 16-byte) integer
// aggregate argument is passed in general-purpose argument registers
// rather than by the caller's address. The callee receives a private
// copy (by-value semantics, 6.5.2.2p4): mutating a parameter must not
// change the caller's object. Exercises one-eightbyte and
// two-eightbyte aggregates, aggregates mixed with scalar arguments
// before and after, nested aggregates, and multiple aggregate
// arguments in one call.

struct pair {
    int x;
    int y;
};

struct wide {
    long a;
    long b;
};

struct mixed {
    int tag;
    short lo;
    short hi;
    int extra;
};

struct nested {
    struct pair p;
    int z;
};

static int sum_pair(struct pair p) {
    return p.x + p.y;
}

static long sum_wide(struct wide w) {
    return w.a + w.b;
}

static int sum_mixed(struct mixed m) {
    return m.tag + m.lo + m.hi + m.extra;
}

static int sum_nested(struct nested n) {
    return n.p.x + n.p.y + n.z;
}

// Aggregate argument between two scalar arguments: the scalars take
// integer argument registers around the aggregate's eightbytes.
static int around(int pre, struct pair p, int post) {
    return pre + p.x * 10 + p.y * 100 + post * 1000;
}

// Two aggregate arguments in one call: the second's eightbytes follow
// the first's in the argument registers.
static int two(struct pair a, struct pair b) {
    return a.x + a.y * 2 + b.x * 3 + b.y * 4;
}

// By-value: mutating the parameter leaves the caller's object intact.
static int mutate(struct pair p) {
    p.x = 100;
    p.y = 200;
    return p.x + p.y;
}

int main(void) {
    struct pair p;
    p.x = 3;
    p.y = 5;
    if (sum_pair(p) != 8) return 1;

    struct wide w;
    w.a = 1000;
    w.b = 337;
    if (sum_wide(w) != 1337) return 2;

    struct mixed m;
    m.tag = 1;
    m.lo = 2;
    m.hi = 3;
    m.extra = 4;
    if (sum_mixed(m) != 10) return 3;

    struct nested n;
    n.p.x = 7;
    n.p.y = 11;
    n.z = 13;
    if (sum_nested(n) != 31) return 4;

    if (around(9, p, 2) != 9 + 30 + 500 + 2000) return 5;

    struct pair q;
    q.x = 1;
    q.y = 1;
    if (two(p, q) != 3 + 10 + 3 + 4) return 6;

    if (mutate(p) != 300) return 7;
    if (p.x != 3 || p.y != 5) return 8;

    return 0;
}
