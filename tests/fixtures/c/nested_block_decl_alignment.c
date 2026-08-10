// C11 6.7.5 applies to a declaration in any block, not only the one that
// opens a function body: a static local's data placement and an automatic
// object's frame placement both honour the requested alignment, whether it
// comes from the declarator or from the type.

struct wide {
    unsigned int pad[8];
} __attribute__((aligned(64)));

static int side(void) { return 1; }

static int nested_static(void) {
    if (side()) {
        static struct wide w;
        w.pad[0] = 3;
        return ((unsigned long long)&w & 63u) == 0 && w.pad[0] == 3;
    }
    return 0;
}

static int loop_static(void) {
    for (;;) {
        static _Alignas(128) char c;
        c = 5;
        return ((unsigned long long)&c & 127u) == 0 && c == 5;
    }
}

static int nested_auto(void) {
    if (side()) {
        _Alignas(64) char b[8];
        b[0] = 7;
        return ((unsigned long long)b & 63u) == 0 && b[0] == 7;
    }
    return 0;
}

static int nested_auto_typed(void) {
    if (side()) {
        struct wide w;
        w.pad[0] = 9;
        return ((unsigned long long)&w & 63u) == 0 && w.pad[0] == 9;
    }
    return 0;
}

int main(void) {
    int ok = nested_static() + loop_static() + nested_auto() + nested_auto_typed();
    return ok == 4 ? 42 : ok;
}
