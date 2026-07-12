// A struct member of pointer-to-array-typedef type (`Node *nodes` where
// `Node` is `E[N]`) is a pointer to the row array, so `s->nodes[k]`
// strides by `sizeof(Node)` and decays to the row's element pointer
// (C99 6.3.2.1p3, 6.5.2.1). The member path used to treat the field as
// a plain element pointer: stride `sizeof(E)`, then a load through the
// row -- the parameter path's fix did not reach fields.
typedef struct {
    unsigned skip : 6;
    unsigned ptr : 26;
} E;
typedef E Node[512];
struct Map {
    int n;
    Node *nodes;
};

static int row_via_arrow(struct Map *map, E *lp) {
    E *p;
    p = map->nodes[lp->ptr];
    return (int)p[2].ptr;
}

static int chained_via_dot(struct Map m) {
    return (int)m.nodes[1][3].ptr;
}

int main(void) {
    static Node nodes[3];
    struct Map m;
    E root;
    m.n = 3;
    m.nodes = nodes;
    root.ptr = 1;
    root.skip = 1;
    nodes[1][2].ptr = 9;
    nodes[1][3].ptr = 5;
    if (row_via_arrow(&m, &root) != 9) {
        return 1;
    }
    if (chained_via_dot(m) != 5) {
        return 2;
    }
    return 0;
}
