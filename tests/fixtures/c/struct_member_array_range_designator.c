// A struct member that is an array can be initialized with a GNU range
// designator `[a ... b] = value`, filling every element in [a, b]. The
// top-level array path already supported ranges; the struct-member array
// path did not. Mixed single and range designators, plus a following
// scalar member, must all land at the right offsets.

enum { PRI_MAX = 4 };

struct S {
    int head[PRI_MAX + 1];
    int tail;
};

static struct S all = {
    .head = { [0 ... PRI_MAX] = 7 },
    .tail = 99,
};

static struct S mixed = {
    .head = { [1] = 3, [2 ... 4] = 5 },
};

int main(void) {
    for (int i = 0; i <= PRI_MAX; i++) {
        if (all.head[i] != 7) return 1;
    }
    if (all.tail != 99) return 2;
    if (mixed.head[0] != 0) return 3;       /* untouched, stays zero */
    if (mixed.head[1] != 3) return 4;
    if (mixed.head[2] != 5 || mixed.head[3] != 5 || mixed.head[4] != 5) return 5;
    return 0;
}
