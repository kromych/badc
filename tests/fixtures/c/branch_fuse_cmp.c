// A comparison whose only consumer is a branch condition branches on
// the flags the compare set instead of materializing a 0/1 value and
// re-testing it; a zero test branches on the value register directly.
// A comparison with another consumer still materializes (C99 6.5.8p6,
// 6.5.9p3: the result is 0 or 1 of type int). `volatile` keeps every
// operand a runtime value so the branch shapes are emitted.

static volatile long sa = 5, sb = 9;
static volatile unsigned long ua = 5, ub = 9;
static volatile long lz = 0, lnz = 3;

static int sink;

// Single-use compares in branch position: signed, unsigned, register
// and immediate operands.
static int relational(void) {
    int hits = 0;
    if (sa < sb) hits += 1;
    if (sa > sb) hits += 100;
    if (sa <= sb) hits += 1;
    if (sa >= sb) hits += 100;
    if (ua < ub) hits += 1;
    if (ua > ub) hits += 100;
    if (sa == 5) hits += 1;
    if (sb != 9) hits += 100;
    if (ua <= 4) hits += 100;
    if (ub >= 9) hits += 1;
    return hits; // 5
}

// Zero tests branch on the tested value itself.
static int zero_tests(void) {
    int hits = 0;
    if (lz) hits += 100;
    if (!lz) hits += 1;
    if (lnz) hits += 1;
    if (!lnz) hits += 100;
    if (lnz != 0) hits += 1;
    if (lz == 0) hits += 1;
    return hits; // 4
}

// The comparison's value has a second consumer: it must materialize,
// and the branch outcome is unchanged.
static int multi_use(void) {
    int c = sa < sb; // 1
    sink = c;
    if (c) {
        return sink + 1; // 2
    }
    return 100;
}

// An addition sits between the compare and the branch that consumes
// it. Where its lowering writes the flags the compare re-tests; the
// outcome is identical either way.
static int work_between(void) {
    int c = sa < sb;   // 1
    long s = sa + sb;  // 14
    if (c) {
        return (int)s; // 14
    }
    return 100;
}

int main(void) {
    if (relational() != 5) {
        return 1;
    }
    if (zero_tests() != 4) {
        return 2;
    }
    if (multi_use() != 2) {
        return 3;
    }
    if (work_between() != 14) {
        return 4;
    }
    return 0;
}
