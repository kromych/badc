// A function parameter of type "pointer to an array typedef"
// (`Node *nodes` where `typedef T Node[N]`) is a pointer to the array,
// not an array parameter, so C99 6.7.5.3p7 does not adjust it. Indexing
// `nodes[k]` selects the k-th N-element row: the address arithmetic
// strides by `sizeof(Node)` and the row decays to a `T *` (no load).
//
// The parameter path used to add a second pointer level (making `nodes`
// a `T **`), so `nodes[k]` strided by a pointer width and loaded a word
// as the row address -- the shape qemu's `phys_page_compact(..., Node
// *nodes)` with `p = nodes[lp->ptr]` crashed on. Uses `long long` so the
// element is 64-bit under both LP64 and LLP64.

typedef long long Node[8]; // sizeof(Node) == 64

static void set_row(Node *nodes, long k, long long base) {
    for (int j = 0; j < 8; j++) {
        nodes[k][j] = base + j;
    }
}

static long long sum_row(Node *nodes, long k) {
    long long s = 0;
    for (int j = 0; j < 8; j++) {
        s += nodes[k][j];
    }
    return s;
}

// Pointer to a row obtained by address-of a subscript: `&nodes[k]` is a
// `Node *` again (stride must still be a whole row).
static long long first_of(Node *nodes, long k) {
    Node *row = &nodes[k];
    return (*row)[0];
}

int main(void) {
    Node grid[4];
    for (long k = 0; k < 4; k++) {
        set_row(grid, k, k * 100);
    }

    // Rows must not overlap: a wrong stride would make them alias.
    // row 0: 0..7  -> 28 ; row 2: 200..207 -> 1628 ; row 3: 300..307 -> 2428
    if (sum_row(grid, 0) != 28) {
        return 1;
    }
    if (sum_row(grid, 2) != 1628) {
        return 2;
    }
    if (sum_row(grid, 3) != 2428) {
        return 3;
    }
    if (first_of(grid, 3) != 300) {
        return 4;
    }
    return 0;
}
