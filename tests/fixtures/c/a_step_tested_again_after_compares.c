// A step `y = p + 9` that its own block's branch tests for zero, tested
// again by a later block's branch after comparisons that set the flags:
// the later branch tests `y` itself. The shape is a null test repeated
// before each read of one member. Returns 0 when every result is right;
// each failure returns its own code.

static int reports;

__attribute__((noinline)) static void report(void) { reports++; }

struct node {
    struct node *next;
    unsigned char kind;
    unsigned char mark;
};

__attribute__((noinline)) static int classify(struct node *o) {
    int total = 0;
    while (o) {
        unsigned char *m = &o->mark;
        if (!m)
            report();
        int white = (*m & 56) == 0;
        if (!m)
            report();
        int old = (*m & 7) == 6;
        if (white ^ old)
            total += 100;
        total++;
        o = o->next;
    }
    return total;
}

int main(void) {
    struct node n[4] = {{0}};
    for (int i = 0; i < 4; i++) {
        n[i].next = i < 3 ? &n[i + 1] : 0;
        n[i].mark = (unsigned char)(i * 9);
    }
    if (classify(n) != 104)
        return 1;
    if (reports != 0)
        return 2;
    return 0;
}
