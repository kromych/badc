// <search.h>'s binary search trees on the Windows targets, as libmingwex
// defines them: an unbalanced tree of nodes whose first member is the key
// pointer, so the node pointer the calls return reads as a pointer to the
// key. tdelete returns the parent of the node it removes, or the removed
// root itself. Elsewhere the file is empty; the link offers it like an
// archive member.

#ifdef _WIN32

#define _GNU_SOURCE 1
#include <search.h>
#include <stdlib.h>

typedef struct node {
    const void *key;
    struct node *left, *right;
} node;

typedef int (*compar_fn)(const void *, const void *);

void *tsearch(const void *key, void **rootp, compar_fn compar) {
    node **link = (node **)rootp;
    node *n;
    if (!link)
        return 0;
    while (*link) {
        int r = compar(key, (*link)->key);
        if (!r)
            return *link;
        link = r < 0 ? &(*link)->left : &(*link)->right;
    }
    if ((n = malloc(sizeof *n))) {
        n->key = key;
        n->left = n->right = 0;
        *link = n;
    }
    return n;
}

void *tfind(const void *key, void *const *rootp, compar_fn compar) {
    node *n = rootp ? *(node *const *)rootp : 0;
    while (n) {
        int r = compar(key, n->key);
        if (!r)
            return n;
        n = r < 0 ? n->left : n->right;
    }
    return 0;
}

void *tdelete(const void *restrict key, void **restrict rootp, compar_fn compar) {
    node **link = (node **)rootp;
    node *parent, *gone, *repl;
    int r;
    if (!link || !*link)
        return 0;
    parent = *link;
    while ((r = compar(key, (*link)->key))) {
        parent = *link;
        link = r < 0 ? &(*link)->left : &(*link)->right;
        if (!*link)
            return 0;
    }
    gone = *link;
    if (!gone->left) {
        repl = gone->right;
    } else if (!gone->right) {
        repl = gone->left;
    } else {
        // The in-order successor, the right subtree's leftmost node.
        node **succ = &gone->right;
        while ((*succ)->left)
            succ = &(*succ)->left;
        repl = *succ;
        *succ = repl->right;
        repl->left = gone->left;
        repl->right = gone->right;
    }
    *link = repl;
    free(gone);
    return parent;
}

static void walk(const node *n, void (*action)(const void *, VISIT, int), int depth) {
    if (!n->left && !n->right) {
        action(n, leaf, depth);
        return;
    }
    action(n, preorder, depth);
    if (n->left)
        walk(n->left, action, depth + 1);
    action(n, postorder, depth);
    if (n->right)
        walk(n->right, action, depth + 1);
    action(n, endorder, depth);
}

void twalk(const void *root, void (*action)(const void *, VISIT, int)) {
    if (root && action)
        walk(root, action, 0);
}

static void destroy(node *n, void (*free_node)(void *)) {
    if (!n)
        return;
    destroy(n->left, free_node);
    destroy(n->right, free_node);
    free_node((void *)n->key);
    free(n);
}

void tdestroy(void *root, void (*free_node)(void *)) {
    destroy(root, free_node);
}

#endif
