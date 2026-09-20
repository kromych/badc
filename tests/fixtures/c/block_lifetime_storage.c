// Storage shared between automatic objects whose blocks do not overlap
// (C99 6.2.4p2). Each object's address is retained by a callee, so the
// only bound on its storage is the end of its block; every read below
// happens inside the block that declared the object, which is where the
// value has to survive. The checks fix the result at 0.

static int *keep;
static long long *wide;

static void hold(int *p) { keep = p; }
static void hold_wide(long long *p) { wide = p; }

// Four disjoint blocks: one cell is enough for all of them, and each
// must read back what its own block wrote through the retained pointer.
static int disjoint(void)
{
    int sum = 0;
    { int a = 1; hold(&a); *keep += 10; sum += a; }
    { int b = 2; hold(&b); *keep += 20; sum += b; }
    { int c = 3; hold(&c); *keep += 30; sum += c; }
    { int d = 4; hold(&d); *keep += 40; sum += d; }
    return sum; /* 11 + 22 + 33 + 44 */
}

// An object live across an inner block keeps its own storage: the inner
// object's block ends first, but the outer one is written through its
// retained pointer afterwards.
static int nested(void)
{
    int outer_seen;
    {
        int o = 5;
        hold(&o);
        { int i = 6; hold(&i); *keep += 1; if (i != 7) return -1; }
        hold(&o); /* the inner block's pointer died with its object */
        *keep += 100;
        outer_seen = o;
    }
    return outer_seen; /* 105: the inner write must not have reached o */
}

// Objects of different widths in disjoint blocks: the wider one fixes
// the width of the storage they share.
static long long widths(void)
{
    long long total = 0;
    { int s = 7; hold(&s); *keep <<= 1; total += s; }
    { long long w = 0x1122334455667788LL; hold_wide(&w); *wide ^= 1; total += *wide; }
    { int s2 = 9; hold(&s2); *keep += 1; total += s2; }
    return total; /* 14 + 0x1122334455667789 + 10 */
}

// The same blocks inside a loop: each iteration is a fresh lifetime.
static int looped(int n)
{
    int sum = 0;
    for (int i = 0; i < n; i++) {
        { int a = i; hold(&a); *keep += 1; sum += a; }
        { int b = i; hold(&b); *keep += 2; sum += b; }
    }
    return sum;
}

// A volatile object keeps its own storage; the writes through its
// address must all be seen.
static int volatiles(void)
{
    int sum = 0;
    { volatile int a = 1; a = a + 1; sum += a; }
    { volatile int b = 3; b = b + 1; sum += b; }
    return sum; /* 2 + 4 */
}

int main(void)
{
    if (disjoint() != 110)
        return 1;
    if (nested() != 105)
        return 2;
    if (widths() != 14 + 0x1122334455667789LL + 10)
        return 3;
    // (0+1) + (0+2) + (1+1) + (1+2) + (2+1) + (2+2) = 15
    if (looped(3) != 15)
        return 4;
    if (volatiles() != 6)
        return 5;
    return 0;
}
