// Allocation of complete binary trees for the perf table. A tree of depth
// MAX_DEPTH + 1 is built, counted, and freed; a tree of depth MAX_DEPTH
// then stays allocated while, for each depth d from MIN_DEPTH to MAX_DEPTH
// in steps of 2, 2^(MAX_DEPTH - d + MIN_DEPTH) trees of depth d are built,
// counted, and freed one at a time, so every depth allocates the same
// number of nodes. Each node is its own malloc and free. Exercises the
// recursion that builds, walks, and frees the trees, the call into the
// allocator on every node, and the pointer loads of the walk.
//
// A tree of depth d has 2^(d+1) - 1 nodes; every count is checked against
// that.

#include <stdio.h>
#include <stdlib.h>
#include "bench_clock.h"

#define MIN_DEPTH 4
#define MAX_DEPTH 16

struct node {
    struct node *left, *right;
};

static struct node *build(int depth) {
    struct node *n = malloc(sizeof *n);
    if (n == NULL) {
        printf("binary_trees: out of memory\n");
        exit(1);
    }
    if (depth > 0) {
        n->left = build(depth - 1);
        n->right = build(depth - 1);
    } else {
        n->left = n->right = NULL;
    }
    return n;
}

static long count_nodes(const struct node *n) {
    if (n->left == NULL) {
        return 1;
    }
    return 1 + count_nodes(n->left) + count_nodes(n->right);
}

static void destroy(struct node *n) {
    if (n->left != NULL) {
        destroy(n->left);
        destroy(n->right);
    }
    free(n);
}

static long tree_size(int depth) {
    return (2L << depth) - 1;
}

int main(void) {
    long total = 0;
    int bad = 0;

    double t0 = bench_ms();
    struct node *stretch = build(MAX_DEPTH + 1);
    long n = count_nodes(stretch);
    bad |= n != tree_size(MAX_DEPTH + 1);
    total += n;
    destroy(stretch);

    struct node *long_lived = build(MAX_DEPTH);
    for (int d = MIN_DEPTH; d <= MAX_DEPTH; d += 2) {
        long iterations = 1L << (MAX_DEPTH - d + MIN_DEPTH);
        long sum = 0;
        for (long i = 0; i < iterations; i++) {
            struct node *t = build(d);
            sum += count_nodes(t);
            destroy(t);
        }
        bad |= sum != iterations * tree_size(d);
        total += sum;
    }
    n = count_nodes(long_lived);
    bad |= n != tree_size(MAX_DEPTH);
    total += n;
    destroy(long_lived);
    double t1 = bench_ms();

    printf("binary_trees depth %d nodes=%ld in %.2f ms\n", MAX_DEPTH, total, t1 - t0);

    if (bad) {
        printf("WRONG: a tree of depth d does not have 2^(d+1) - 1 nodes\n");
        return 1;
    }
    return 0;
}
