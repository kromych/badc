/* Live-range splitting of a spilled value.

   Both functions hold sixteen invariants across one cold call, so none
   of them may sit in a caller-saved register for its whole range and the
   callee-saved bank cannot hold them all.

   `hot` is the reducible shape: the loop-depth-weighted spill cost sees
   the loop, colors the invariants the loop reads first, and leaves the
   split nothing to recover -- the run it plans is measured against the
   unsplit allocation and dropped. `weird` jumps into the middle of its
   loop, which makes the flow graph irreducible: no natural loop is
   found, every block weighs the same, and the invariants the loop reads
   spill like the rest. Each read then reloads, and splitting the
   call-free run of reads out into its own value lets that stretch hold a
   caller-saved register the loop leaves free.

   The result is exercised for its value, not its placement: unsigned
   arithmetic at the full 64-bit width keeps the wraparound defined
   (C99 6.2.5p9) without the narrowing masks that would give each use its
   own value, so the answer is identical under any allocation. */

static unsigned long long sink;

static void cold(unsigned long long v) {
    sink += v;
}

/* Reached through a volatile pointer so no inliner can remove the call
   and with it the cross-call constraint the fixture is about. */
static void (*volatile cold_p)(unsigned long long) = cold;

#define DECLS(a)                              \
    unsigned long long c0 = (a)[0] + 1u;      \
    unsigned long long c1 = (a)[1] + 2u;      \
    unsigned long long c2 = (a)[2] + 3u;      \
    unsigned long long c3 = (a)[3] + 4u;      \
    unsigned long long c4 = (a)[4] + 5u;      \
    unsigned long long c5 = (a)[5] + 6u;      \
    unsigned long long c6 = (a)[6] + 7u;      \
    unsigned long long c7 = (a)[7] + 8u;      \
    unsigned long long c8 = (a)[0] ^ (a)[3];  \
    unsigned long long c9 = (a)[1] ^ (a)[5];  \
    unsigned long long c10 = (a)[2] ^ (a)[6]; \
    unsigned long long c11 = (a)[3] ^ (a)[7]; \
    unsigned long long c12 = (a)[4] + (a)[0]; \
    unsigned long long c13 = (a)[5] + (a)[1]; \
    unsigned long long c14 = (a)[6] + (a)[2]; \
    unsigned long long c15 = (a)[7] + (a)[3];

#define MIX (c0 ^ c1 ^ c2 ^ c3 ^ c4 ^ c5 ^ c6 ^ c7 ^ c8 ^ c9 ^ c10 ^ c11 \
             ^ c12 ^ c13 ^ c14 ^ c15)

/* Three reads of one invariant with no call between them: the run a
   whole-range placement reloads three times and a split reloads once. */
#define STEP(c)              \
    acc ^= (c) + i;          \
    acc += (c) * 3u;         \
    acc -= (c) ^ (acc >> 3);

static unsigned long long hot(const unsigned long long *a, unsigned n) {
    DECLS(a)
    unsigned long long acc = 0u;
    unsigned i;
    if (n == 0u) {
        cold_p(c0 ^ c15);
    }
    for (i = 0u; i < n; i++) {
        STEP(c0)
        STEP(c1)
        STEP(c2)
        STEP(c3)
        STEP(c4)
        STEP(c5)
    }
    return acc ^ MIX;
}

static unsigned long long weird(const unsigned long long *a, unsigned n) {
    DECLS(a)
    unsigned long long acc = 0u;
    unsigned i = 0u;
    unsigned k = n;
    if (n == 0u) {
        cold_p(c0 ^ c15);
    }
    if ((n & 1u) != 0u) {
        goto middle;
    }
    for (;;) {
        STEP(c0)
        STEP(c1)
        STEP(c2)
        STEP(c3)
    middle:
        STEP(c4)
        STEP(c5)
        STEP(c6)
        STEP(c7)
        i++;
        if (--k == 0u) {
            break;
        }
    }
    return acc ^ MIX;
}

int main(void) {
    unsigned long long a[8] = {3u, 5u, 7u, 11u, 13u, 17u, 19u, 23u};
    unsigned long long r = hot(a, 100u) ^ weird(a, 41u) ^ weird(a, 40u);
    if (sink != 0u) {
        return 1;
    }
    return (int)(r & 0xFFu);
}
