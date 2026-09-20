// An aggregate a body builds in a temporary and copies once is built in
// the destination instead. The shapes below fix what the rewrite must
// and must not do: a literal wider than the field-splitting budget, one
// whose initializer reads the destination, one whose address a callee
// takes, and one assigned over an object the same statement reads.

struct big {
    long long v[8];
};
struct pair {
    long long a, b;
};

static void fill(struct big *b, long long s)
{
    *b = (struct big){ s, s + 1, s + 2, s + 3, s + 4, s + 5, s + 6, s + 7 };
}

// The initializer reads the destination, so the writes may not move
// ahead of the read.
static void shift(struct pair *p)
{
    *p = (struct pair){ p->b, p->a };
}

// A literal whose address a callee takes keeps its own object.
static long long *held;
static void hold(long long *q) { held = q; }
static long long through_callee(long long s)
{
    struct pair q = (struct pair){ s, s + 1 };
    hold(&q.b);
    return *held + q.a;
}

// A partial assignment leaves the rest of the destination alone.
static void half(struct pair *p, long long s)
{
    p->a = s;
}

int main(void)
{
    struct big b;
    for (int i = 0; i < 8; i++)
        b.v[i] = -1;
    fill(&b, 10);
    for (int i = 0; i < 8; i++)
        if (b.v[i] != 10 + i)
            return 1 + i;

    struct pair p = { 3, 5 };
    shift(&p);
    if (p.a != 5 || p.b != 3)
        return 10;

    if (through_callee(7) != 8 + 7)
        return 11;

    struct pair h = { 1, 2 };
    half(&h, 9);
    if (h.a != 9 || h.b != 2)
        return 12;

    // Two literals in a row over the same object: the second must win.
    struct big c;
    fill(&c, 100);
    fill(&c, 200);
    for (int i = 0; i < 8; i++)
        if (c.v[i] != 200 + i)
            return 20 + i;
    return 0;
}
