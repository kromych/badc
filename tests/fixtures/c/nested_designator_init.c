// C99 6.7.8p7 designator chains: a `.member` step may be followed
// by another `.submember` or `[N]` step so a nested field can be
// targeted from a single brace level. `.outer.inner = v` is
// equivalent to `.outer = { .inner = v }`. badc used to surface
// `=` expected after `.outer` designator and stop; both the
// constant-staging path (file-scope / `static` locals) and the
// runtime path (block-scope locals with non-constant entries) now
// resolve the chain and emit a single store at the cumulative
// offset.

struct point {
    int x;
    int y;
};

struct line {
    struct point a;
    struct point b;
};

// File-scope: constant-staging path.
static struct line edge = {
    .a.x = 1,
    .a.y = 2,
    .b.x = 3,
    .b.y = 4,
};

int main(void) {
    if (edge.a.x != 1) return 11;
    if (edge.a.y != 2) return 12;
    if (edge.b.x != 3) return 13;
    if (edge.b.y != 4) return 14;

    // Block scope with a non-constant entry routes through the
    // runtime-local-init path.
    int dyn = 10;
    struct line local = {
        .a.x = dyn,
        .a.y = 20,
        .b.x = 30,
        .b.y = 40,
    };
    if (local.a.x != 10) return 21;
    if (local.a.y != 20) return 22;
    if (local.b.x != 30) return 23;
    if (local.b.y != 40) return 24;

    return 0;
}
