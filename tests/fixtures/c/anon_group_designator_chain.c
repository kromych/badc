/* C99 6.7.8p7: a designator list inside the brace of a flattened
   anonymous union/struct member may continue past the member as
   `.member[i]` or `.member.inner` before `=`. The top-level struct path
   already resolved such chains; this pins the same for the anonymous
   union/struct brace handlers, on both the constant and the runtime
   (non-constant) store paths. */

struct inner {
    int first;
    unsigned count;
};

/* Array member of an anonymous union, indexed by a `.extent[i]` chain. */
struct umap {
    unsigned nr;
    union {
        struct inner extent[5];
        long raw;
    };
};

/* Array member of an anonymous struct, plus a nested-member chain. */
struct smap {
    unsigned nr;
    struct {
        struct inner arr[5];
        struct inner one;
    };
};

static int check_runtime(int vf, int vc) {
    struct umap m = {
        .nr = 1,
        {.extent[0] = {.first = vf, .count = vc}},
    };
    struct smap s = {
        .nr = 2,
        {.arr[1] = {.first = vf, .count = vc}, .one.first = vf},
    };
    if (!(m.nr == 1 && m.extent[0].first == vf && m.extent[0].count == vc))
        return 1;
    if (m.extent[1].first != 0)
        return 2;
    if (!(s.nr == 2 && s.arr[1].first == vf && s.arr[1].count == vc))
        return 3;
    if (!(s.arr[0].first == 0 && s.one.first == vf))
        return 4;
    return 0;
}

int main(void) {
    struct umap m = {
        .nr = 1,
        {.extent[0] = {.first = 3, .count = 9}},
    };
    if (!(m.nr == 1 && m.extent[0].first == 3 && m.extent[0].count == 9))
        return 5;
    if (m.extent[1].first != 0)
        return 6;

    struct smap s = {
        .nr = 2,
        {.arr[1] = {.first = 7, .count = 8}, .one.first = 11},
    };
    if (!(s.nr == 2 && s.arr[1].first == 7 && s.arr[1].count == 8))
        return 7;
    if (!(s.arr[0].first == 0 && s.one.first == 11))
        return 8;

    return check_runtime(20, 22);
}
