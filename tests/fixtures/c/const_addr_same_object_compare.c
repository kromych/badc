// C99 6.5.8p5 / 6.5.9p6: comparing two pointers into the same object
// answers by their offsets, so the answer is fixed at translation time
// even though the object's own address is not. A build-time assert
// written on such a comparison must leave no call behind -- the
// declared-but-undefined function below makes linking the assertion.
// Addresses over two *different* objects keep their comparison: the
// data layout, not the source, decides their order.
//
// gcc 16 folds every guard below at -O2 and all but the one written on
// integer casts of the addresses (5) already at -O0.

#define BUILD_BUG_ON(cond, tag)                                                                    \
    do {                                                                                           \
        extern void compiletime_assert_##tag(void);                                                \
        if (!(!(cond)))                                                                            \
            compiletime_assert_##tag();                                                            \
    } while (0)

struct list_head {
    struct list_head *next, *prev;
};

typedef struct {
    int lead;
    struct list_head node;
    char tail[8];
} host;

static struct list_head migrate_nodes;
static host nest;
static int grid[4][3];

// The second word of a two-pointer object aliased as a whole object:
// its address is inside `migrate_nodes` but is neither its start nor
// its end.
#define DUP_HEAD ((struct list_head *)&migrate_nodes.prev)

static int sink;

static void guards(void) {
    // Member offset against the containing object's bounds.
    BUILD_BUG_ON(DUP_HEAD <= &migrate_nodes, 1);
    BUILD_BUG_ON(DUP_HEAD >= &migrate_nodes + 1, 2);
    // Nested member, both directions, through a cast that keeps the
    // whole address.
    BUILD_BUG_ON((char *)&nest.node < (char *)&nest, 3);
    BUILD_BUG_ON((char *)&nest.tail[0] <= (char *)&nest.node, 4);
    // An integer cast keeps the whole address only in a pointer-sized
    // type; `unsigned long` is 32-bit on LLP64.
    BUILD_BUG_ON((unsigned long long)&nest.tail[7] >= (unsigned long long)(&nest + 1), 5);
    // Constant array subscripts, including the row-major ordering of a
    // two-dimensional array.
    BUILD_BUG_ON(&grid[0][0] != (int *)&grid, 6);
    BUILD_BUG_ON(&grid[1][2] <= &grid[1][1], 7);
    BUILD_BUG_ON((int *)&grid[3] + 2 >= (int *)&grid + 12, 8);
    // Equality of one address with itself, and of two spellings of it.
    BUILD_BUG_ON(&nest.node != &nest.node, 9);
    BUILD_BUG_ON(&grid[2][0] != (int *)&grid + 6, 10);
}

// Two distinct objects: the comparison is not a constant, so the guard
// stays and must answer correctly at run time.
static int distinct_objects_still_compare(void) {
    return (char *)&nest != (char *)&migrate_nodes;
}

int main(void) {
    guards();
    if (!distinct_objects_still_compare())
        return 1;
    // The folded comparisons must have folded to the right answers.
    if ((char *)DUP_HEAD - (char *)&migrate_nodes != (long)sizeof(void *))
        return 2;
    if (&grid[2][0] != (int *)&grid + 6)
        return 3;
    sink = 0;
    return sink;
}
