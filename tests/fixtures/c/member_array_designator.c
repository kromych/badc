// C99 6.7.8p7 designator chain mixing a `.member` step with an `[index]`
// step: `.member[i] = value` initializes one element of an array-typed
// struct member. QEMU uses it in device init tables (xlnx-versal cfu/cframe
// `.data[k] = ...`, cxl `.entry[0] = ...`, `.active_vcs_bitmask[0] = ...`).
// Covers a const-global and a runtime-local struct, an array-of-struct
// member with a further `.field` step, and -- as a regression -- the plain
// `.a.b` nested-designator chain that shares the resolver. Returns 0 on
// success.

struct Regs {
    int head;
    int data[4];
    int tail;
};

// Const global: designate individual array-member elements; the gaps stay
// zero, later `.field` designators still land, positional resumes correctly.
static const struct Regs g = {
    .head = 1,
    .data[0] = 10,
    .data[2] = 30,
    .tail = 99,
};

struct Inner {
    int a;
    int b;
};
struct Outer {
    struct Inner items[3];
    int n;
};

// Array-of-struct member: `.items[i].b = v` chains member -> index -> member.
static const struct Outer o = {
    .items[0].a = 1,
    .items[0].b = 2,
    .items[2].b = 7,
    .n = 3,
};

// Regression for the shared resolver: a plain `.a.b` chain (no index step).
struct Nest {
    struct Inner in;
    int z;
};
static const struct Nest nest = {
    .in.a = 4,
    .in.b = 5,
    .z = 6,
};

static int check_global(void) {
    if (g.head != 1 || g.tail != 99) return 1;
    if (g.data[0] != 10 || g.data[2] != 30) return 2;
    if (g.data[1] != 0 || g.data[3] != 0) return 3; // gaps zero
    if (o.items[0].a != 1 || o.items[0].b != 2 || o.items[2].b != 7 || o.n != 3) return 4;
    if (o.items[1].a != 0 || o.items[2].a != 0) return 5; // gaps zero
    if (nest.in.a != 4 || nest.in.b != 5 || nest.z != 6) return 6;
    return 0;
}

static int check_runtime(int x, int y) {
    // Runtime values into an array-member designator (the xlnx cfu shape:
    // `.data[k] = wfifo[k]`).
    struct Regs r = {
        .head = x,
        .data[1] = y,
        .data[3] = x + y,
        .tail = x * y,
    };
    if (r.head != x || r.tail != x * y) return 10;
    if (r.data[1] != y || r.data[3] != x + y) return 11;
    if (r.data[0] != 0 || r.data[2] != 0) return 12; // gaps zero
    return 0;
}

int main(void) {
    int rc = check_global();
    if (rc) return rc;
    rc = check_runtime(3, 5);
    if (rc) return rc;
    return 0;
}
