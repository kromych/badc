/* Frames larger than one page. A single stack-pointer decrement past a
   guard region would leave the first store below it, so the prologue
   descends in probed steps; the probe writes into the frame it just
   reserved, which must not disturb any object living there. Covers the
   straight-line walk (two pages), the counted-loop walk (48 pages), a
   recursion that stacks probed frames, and a large by-value argument
   whose outgoing area is walked the same way. Returns 42. */

struct big {
    long head;
    char pad[9000];
    long tail;
};

static long touch(char *p, long n) {
    p[0] = 1;
    p[n / 2] = 2;
    p[n - 1] = 3;
    return p[0] + p[n / 2] + p[n - 1];
}

static long two_pages(void) {
    volatile char a[9000];
    return touch((char *)a, 9000);
}

static long fifty_pages(void) {
    volatile char a[200000];
    return touch((char *)a, 200000);
}

static long by_value(struct big b) {
    return b.head + b.tail + b.pad[0] + b.pad[8999];
}

static long recurse(long depth) {
    volatile char a[9000];
    long s = touch((char *)a, 9000);
    if (depth > 0) {
        s += recurse(depth - 1);
    }
    return s;
}

int main(void) {
    struct big b;
    long s = two_pages() + fifty_pages();
    if (s != 12) {
        return 1;
    }
    b.head = 4;
    b.tail = 5;
    b.pad[0] = 6;
    b.pad[8999] = 7;
    if (by_value(b) != 22) {
        return 2;
    }
    /* 8 nested frames of just over two pages each. */
    if (recurse(7) != 48) {
        return 3;
    }
    return 42;
}
