// A counted loop whose body branches out of it -- the shape a `break`
// (C99 6.8.6.3) compiles to -- still has a translation-time trip
// count, so each iteration's counter is a literal once the loop is
// peeled.
//
// Each guard below is a block-scope declaration of an undefined
// function called when its condition holds, so linking is the
// assertion. The first two resolve once the copies pass literals; the
// third is the shape the kernel's `min()` carries, and resolves only
// once those literals bound the callee's parameter across every call
// site this unit holds. `main` checks the peeled results against the
// same bodies run with a bound the translation unit cannot fold, which
// keeps them rolled: the peel has to preserve the values crossing
// every exit edge, not just fold the guards.

#define BUILD_BUG_ON(cond, tag)                                                                    \
    do {                                                                                           \
        extern void compiletime_assert_##tag(void);                                                \
        if (!(!(cond)))                                                                            \
            compiletime_assert_##tag();                                                            \
    } while (0)

#define MAX_NR_TIERS 4

static long refaulted[MAX_NR_TIERS];
static long total[MAX_NR_TIERS];
static const long weight[MAX_NR_TIERS] = {1, 10, 100, 1000};

// The signedness guard the kernel's `min(tier, MAX_NR_TIERS - 1)`
// carries: answerable only for a translation-time constant, and
// reached only from the loops below. A guard written into the loop
// body itself would make the body a diamond, which stays rolled for
// reasons that have nothing to do with the mid-body exit.
static long ctrl_pos(int tier) {
    BUILD_BUG_ON(!__builtin_constant_p(tier), 9320);
    return weight[tier < MAX_NR_TIERS - 1 ? tier : MAX_NR_TIERS - 1];
}

static long ctrl_err(int tier) {
    BUILD_BUG_ON(!__builtin_constant_p(tier), 9321);
    return weight[tier] * refaulted[tier];
}

// The kernel's `min()` signedness check: an unsigned bound admits the
// comparison only for an operand that is provably non-negative, which
// is a fact about the parameter's range over every call site rather
// than about any one call. The body keeps a loop of its own, so it
// stays out of line and the fact has to reach it interprocedurally.
#define is_nonneg(x) (__builtin_constant_p((long long)(x) >= 0) && ((long long)(x) >= 0))
#define sign_use(x) ((__typeof__(x))(-1) < (__typeof__(x))1 ? 2 + is_nonneg(x) : 1)
#define types_ok(x, y) (sign_use(x) & sign_use(y))

static long read_pos(int tier, long gain) {
    unsigned int bound = MAX_NR_TIERS - 1U;
    long acc = 0;
    int i;

    BUILD_BUG_ON(!types_ok(tier, bound), 9322);
    for (i = tier % MAX_NR_TIERS; i <= (tier < (int)bound ? tier : (int)bound); i++)
        acc += weight[i];
    return acc * gain;
}

long tier_idx(void);
long tier_idx(void) {
    long sp = read_pos(0, 2);
    int tier;

    for (tier = 1; tier < MAX_NR_TIERS; tier++)
        if (read_pos(tier, 3) <= sp)
            break;
    return tier - 1;
}

long tier_span(long gain);
long tier_span(long gain) {
    return read_pos(MAX_NR_TIERS, gain);
}

// One exit out of the body, landing where the loop's own exit lands:
// the values live past the loop merge over both edges.
long walk(long gain);
long walk(long gain) {
    long acc = 0;
    int tier;

    for (tier = 0; tier < MAX_NR_TIERS; tier++) {
        acc += refaulted[tier] * ctrl_pos(tier) * gain;
        if (total[tier] < 0)
            break;
    }
    return acc + tier;
}

// Two exits out of one body, landing on different blocks, with a value
// live out of each.
long scan(long floor);
long scan(long floor) {
    long acc = 0;
    int i;

    for (i = 0; i < MAX_NR_TIERS; i++) {
        if (refaulted[i] < 0)
            goto bail;
        acc += ctrl_err(i);
        if (total[i] < floor)
            break;
    }
    return acc;
bail:
    return -acc - 1;
}

// The same bodies against a bound this translation unit cannot fold.
static int bound = MAX_NR_TIERS;

static long walk_rolled(long gain) {
    long acc = 0;
    int tier;

    for (tier = 0; tier < bound; tier++) {
        acc += refaulted[tier] * weight[tier < MAX_NR_TIERS - 1 ? tier : MAX_NR_TIERS - 1] * gain;
        if (total[tier] < 0)
            break;
    }
    return acc + tier;
}

static long scan_rolled(long floor) {
    long acc = 0;
    int i;

    for (i = 0; i < bound; i++) {
        if (refaulted[i] < 0)
            goto bail;
        acc += weight[i] * refaulted[i];
        if (total[i] < floor)
            break;
    }
    return acc;
bail:
    return -acc - 1;
}

static void fill(long r0, long r1, long r2, long r3, long t2) {
    refaulted[0] = r0;
    refaulted[1] = r1;
    refaulted[2] = r2;
    refaulted[3] = r3;
    total[0] = 1;
    total[1] = 1;
    total[2] = t2;
    total[3] = 1;
}

int main(void) {
    long gain;
    long floor;

    // No exit taken early: every copy runs.
    fill(1, 2, 3, 4, 1);
    for (gain = 1; gain <= 3; gain++)
        if (walk(gain) != walk_rolled(gain))
            return 1;
    for (floor = -2; floor <= 2; floor++)
        if (scan(floor) != scan_rolled(floor))
            return 2;

    // The mid-body exit fires part way through.
    fill(1, 2, 3, 4, -1);
    for (gain = 1; gain <= 3; gain++)
        if (walk(gain) != walk_rolled(gain))
            return 3;
    for (floor = -2; floor <= 2; floor++)
        if (scan(floor) != scan_rolled(floor))
            return 4;

    // The second exit fires, on its own landing block.
    fill(1, -2, 3, 4, 1);
    if (scan(0) != scan_rolled(0))
        return 5;
    if (walk(2) != walk_rolled(2))
        return 6;

    // The first iteration leaves at once.
    fill(-1, 2, 3, 4, -1);
    if (scan(0) != scan_rolled(0))
        return 7;
    if (walk(1) != walk_rolled(1))
        return 8;

    // Every copy runs, so the result is the whole weighted sum and the
    // counter leaves the loop at the bound.
    fill(1, 2, 3, 4, 1);
    if (walk(2) != 2 * (1 * 1 + 2 * 10 + 3 * 100 + 4 * 1000) + 4)
        return 9;
    if (scan(-2) != 1 * 1 + 2 * 10 + 3 * 100 + 4 * 1000)
        return 10;
    if (tier_idx() != 3)
        return 11;
    if (tier_span(2) != 2 * (1 + 10 + 100 + 1000))
        return 12;
    return 0;
}
