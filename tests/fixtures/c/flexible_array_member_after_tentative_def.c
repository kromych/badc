// C99 6.9.2: a file-scope declaration with no initializer is a tentative
// definition, and it reserves `sizeof` bytes -- the flexible array member's
// element count is unknown without an initializer (6.7.2.1p16). The later
// defining declaration is larger, so it must take fresh storage rather than
// write its elements past the tentative slot and over the next object.
//
// Distinct from the `extern`-forward-declared form: an `extern` FAM struct
// reserves nothing, a tentative one reserves the fixed part.

struct list_head {
    struct list_head *next, *prev;
};

struct cls {
    struct list_head list;
    long long ident;
    char name[16];
    const char *netid[];
};

static struct cls a;
static struct cls b;
static struct cls c;

// References emitted before the definitions: they must address the objects'
// final storage.
static struct cls *const table[] = { &a, &b, &c };

static struct cls a = {
    .list = { &a.list, &a.list },
    .name = "first",
    .ident = 11,
    .netid = { "a0" },
};

static struct cls b = {
    .list = { &b.list, &b.list },
    .name = "second",
    .ident = 22,
    .netid = { "b0", "b1", "b2" },
};

static struct cls c = {
    .list = { &c.list, &c.list },
    .name = "third",
    .ident = 33,
    .netid = { "c0", "c1" },
};

static int overlap(const void *p, long long pn, const void *q, long long qn) {
    const char *p0 = (const char *)p;
    const char *q0 = (const char *)q;
    return p0 < q0 + qn && q0 < p0 + pn;
}

static int streq(const char *x, const char *y) {
    while (*x && *x == *y) {
        x++;
        y++;
    }
    return *x == *y;
}

int main(void) {
    if (table[0] != &a || table[1] != &b || table[2] != &c) {
        return 1;
    }
    if (a.ident != 11 || b.ident != 22 || c.ident != 33) {
        return 2;
    }
    if (a.list.next != &a.list || b.list.next != &b.list ||
        c.list.next != &c.list) {
        return 3;
    }
    if (a.list.prev != &a.list || b.list.prev != &b.list ||
        c.list.prev != &c.list) {
        return 4;
    }
    if (!streq(a.name, "first") || !streq(b.name, "second") ||
        !streq(c.name, "third")) {
        return 5;
    }
    if (!streq(a.netid[0], "a0")) {
        return 6;
    }
    if (!streq(b.netid[0], "b0") || !streq(b.netid[1], "b1") ||
        !streq(b.netid[2], "b2")) {
        return 7;
    }
    if (!streq(c.netid[0], "c0") || !streq(c.netid[1], "c1")) {
        return 8;
    }
    // Each object spans its fixed part plus its initialized elements, and no
    // two of those spans may intersect.
    {
        long long na = (long long)sizeof(struct cls) + 1 * (long long)sizeof(char *);
        long long nb = (long long)sizeof(struct cls) + 3 * (long long)sizeof(char *);
        long long nc = (long long)sizeof(struct cls) + 2 * (long long)sizeof(char *);
        if (overlap(&a, na, &b, nb) || overlap(&a, na, &c, nc) ||
            overlap(&b, nb, &c, nc)) {
            return 9;
        }
    }
    return 0;
}
