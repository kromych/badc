// C99 6.5.2.5: the address of a compound literal `&(T){ ... }` may be a
// pointer's initializer, including as an array element, a struct member, and
// nested (`&(T){ .p = &(U){...} }`). QEMU's config-struct tables use the
// nested form (`.u.udp.data = &(ChardevUdp){ .remote = &(SocketAddressLegacy)
// {...} }`). badc handled it only for a top-level scalar pointer; here it is
// exercised inside aggregates and nested, at file scope and block scope.
// Returns 0 on success.

struct Leaf { int v; int w; };
struct Mid { struct Leaf *leaf; int m; };
struct Top { struct Mid *mid; int t; };

// File scope: struct member = &(compound literal), nested two deep.
static const struct Top top = {
    .mid = &(struct Mid){ .leaf = &(struct Leaf){ 42, 43 }, .m = 7 },
    .t = 9,
};

// File scope: array of pointers to compound literals.
static struct Leaf *const leaves[] = {
    &(struct Leaf){ 1, 2 },
    &(struct Leaf){ 3, 4 },
};

static int check_static(void) {
    if (top.mid->leaf->v != 42 || top.mid->leaf->w != 43) return 1;
    if (top.mid->m != 7 || top.t != 9) return 2;
    if (leaves[0]->v != 1 || leaves[0]->w != 2) return 3;
    if (leaves[1]->v != 3 || leaves[1]->w != 4) return 4;
    return 0;
}

static int check_local(void) {
    // Block scope: array of structs whose member is &(compound literal),
    // with a nested literal.
    struct Top arr[2] = {
        { .mid = &(struct Mid){ .leaf = &(struct Leaf){ 11, 12 }, .m = 5 }, .t = 6 },
    };
    if (arr[0].mid->leaf->v != 11 || arr[0].mid->leaf->w != 12) return 10;
    if (arr[0].mid->m != 5 || arr[0].t != 6) return 11;
    if (arr[1].mid != 0 || arr[1].t != 0) return 12;   // zeroed
    return 0;
}

int main(void) {
    int rc = check_static();
    if (rc) return rc;
    return check_local();
}
