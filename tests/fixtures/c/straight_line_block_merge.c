// `&&`, `||`, `?:` and an inlined predicate leave a comparison one jump
// away from the branch that tests it; at -O the phi between them gives
// way to the comparison and the two blocks become one. Every row of each
// truth table is checked against the same condition computed without
// control flow, and the exit code names the first check that fails. The
// blocks that must stay apart are here too: labels whose address is
// taken, switch rows, loop headers, a block that jumps to itself, and a
// float constant behind a one-input phi.

#define NOINLINE __attribute__((noinline))

static volatile int sink;

NOINLINE static int note(int x) {
    sink += x;
    return x;
}

// All-ones when `c` is non-zero, without a branch.
static int mask(int c) { return -(c != 0); }

static int choose(int c, int yes, int no) { return (mask(c) & yes) | (~mask(c) & no); }

NOINLINE static int both(int a, int b) {
    if (a < 3 && b < 7) return note(a) + 100;
    return -1;
}

NOINLINE static int either(int a, int b) {
    if (a < 3 || b < 7) return note(b) + 200;
    return -2;
}

NOINLINE static int pick(int a, int b, int c) { return a ? (b ? 1 : 2) : (c ? 3 : 4); }

// A value defined ahead of the first test and read past the last one.
NOINLINE static int carry(int a, int b) {
    int t = a * 3 + 1;
    if (a < 3 && b < 7) return t + note(b);
    if (a > 5 || b > 9) return t - b;
    return t;
}

// The predicate's `return t == b` reaches the caller's `if` through the
// join of its two returns.
static _Bool same(int a, int b) {
    int t = 0;
    while (a > 0) {
        t += a % 10;
        if (t > b) return 0;
        a = a / 10;
    }
    return t == b;
}

NOINLINE static long tally(int n) {
    long c = 0;
    for (int i = 0; i < n; i++) {
        if (same(i, i)) c++;
    }
    return c;
}

// Three predicates deep: a line of three blocks.
static _Bool above(int a) { return a > 1; }
static _Bool inside(int a) { return above(a) && a < 9; }
static _Bool wanted(int a) { return inside(a) || a == 100; }

NOINLINE static int count_wanted(int lo, int hi) {
    int n = 0;
    for (int i = lo; i < hi; i++) {
        if (wanted(i)) n++;
    }
    return n;
}

// The line ends in a switch dispatch; its rows are entered from a table.
NOINLINE static int route(int a, int b, int c) {
    int r = 0;
    if (a && b) {
        switch (c) {
        case 0: r = 10; break;
        case 1: r = 11; break;
        case 2: r = 12; break;
        case 3: r = 13; break;
        case 4: r = 14; break;
        case 5: r = 15; break;
        default: r = 19; break;
        }
    }
    return r + a;
}

// A block that is its own predecessor.
NOINLINE static int spin(int k) {
    int n = 0;
    do {
        n += k;
    } while (--k > 0);
    return n;
}

// Short-circuit tests inside a loop body, one leaving through `continue`
// and one through `break`.
NOINLINE static int scan(const int *p, int n, int lo, int hi) {
    int hits = 0;
    for (int i = 0; i < n; i++) {
        if (p[i] >= lo && p[i] <= hi) {
            hits++;
            continue;
        }
        if (p[i] == -1 || p[i] == 99) break;
        hits += 100;
    }
    return hits;
}

// Each rung falls into the next and is also entered through the table.
NOINLINE static int ladder(int i) {
    static void *const rung[] = {&&r0, &&r1, &&r2};
    int x = 0;
    goto *rung[i];
r0:
    x += 1;
r1:
    x += 2;
r2:
    x += 4;
    return x;
}

NOINLINE static int fork_at(int c) {
    void *t = c ? &&yes : &&no;
    int x = 5;
    goto *t;
yes:
    x += 10;
no:
    x += 1;
    return x;
}

// With a constant argument the unselected arm goes and the float
// constant is left behind a one-input phi.
static double level(int c) { return c ? 1.5 : 2.5; }
static float levelf(int c) { return c ? 0.25f : 0.75f; }

NOINLINE static double lift(double v) { return level(1) + v; }
NOINLINE static float liftf(float v) { return levelf(0) + v; }

// The first failing check; `main` has one return.
#define CHECK(n, ok) \
    do { \
        if (!fail && !(ok)) fail = (n); \
    } while (0)

int main(void) {
    int fail = 0;
    for (int a = 0; a < 6; a++) {
        for (int b = 4; b < 10; b++) {
            CHECK(1, both(a, b) == choose((a < 3) & (b < 7), a + 100, -1));
            CHECK(2, either(a, b) == choose((a < 3) | (b < 7), b + 200, -2));
            int t = a * 3 + 1;
            int want = choose((a < 3) & (b < 7), t + b, choose((a > 5) | (b > 9), t - b, t));
            CHECK(3, carry(a, b) == want);
        }
    }
    CHECK(4, carry(7, 12) == 22 - 12);

    for (int row = 0; row < 8; row++) {
        int a = row & 4, b = row & 2, c = row & 1;
        CHECK(5, pick(a, b, c) == choose(a, choose(b, 1, 2), choose(c, 3, 4)));
        for (int k = -1; k < 8; k++) {
            int r = choose((k >= 0) & (k <= 5), 10 + k, 19);
            CHECK(6, route(a, b, k) == choose((a != 0) & (b != 0), r, 0) + a);
        }
    }

    // A number equals its own digit sum exactly when it has one digit.
    CHECK(7, tally(0) == 0);
    CHECK(8, tally(5) == 5);
    CHECK(9, tally(1000) == 10);
    CHECK(10, same(19, 10) == 1 && same(19, 9) == 0 && same(91, 1) == 0);

    CHECK(11, count_wanted(-5, 200) == 8);
    CHECK(12, count_wanted(9, 100) == 0);
    CHECK(13, count_wanted(100, 101) == 1);

    CHECK(14, spin(1) == 1 && spin(4) == 10 && spin(-3) == -3);

    static const int run[] = {5, 1, 7, 12, 3, 99, 4};
    CHECK(15, scan(run, 7, 3, 7) == 203);
    CHECK(16, scan(run, 7, 0, 100) == 7);
    CHECK(17, scan(run, 0, 0, 100) == 0);

    CHECK(18, ladder(0) == 7 && ladder(1) == 6 && ladder(2) == 4);
    CHECK(19, fork_at(1) == 16 && fork_at(0) == 6);

    CHECK(20, lift(0.25) == 1.75);
    CHECK(21, liftf(0.5f) == 1.25f);

    // Every `note` call above, summed another way: `both` notes `a` on its
    // 9 true rows, `either` notes `b` on its 27 and `carry` on its 9.
    int noted = 0;
    for (int a = 0; a < 6; a++) {
        for (int b = 4; b < 10; b++) {
            noted += choose((a < 3) & (b < 7), a + b, 0);
            noted += choose((a < 3) | (b < 7), b, 0);
        }
    }
    CHECK(22, sink == noted);
    return fail;
}
