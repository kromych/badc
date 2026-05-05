#include <stdlib.h>

// Tree nodes are flat long[3] = [value, left, right]; the left/right
// cells hold pointer-shaped values so the storage type has to be
// `long` (8 bytes) under M31 -- `int` is 4 bytes and would truncate
// the pointer cast.
void free_tree(long *root) {
    if (root == 0) return;

    // Post-order traversal: visit children before the parent
    free_tree((long *)root[1]); // left
    free_tree((long *)root[2]); // right

    free(root);
}

long* insert(long *root, long val) {
    if (root == 0) {
        root = malloc(sizeof(long) + 2 * sizeof(long *));
        root[0] = val; root[1] = 0; root[2] = 0;
        return root;
    }
    if (val < root[0]) root[1] = (long)insert((long *)root[1], val);
    else root[2] = (long)insert((long *)root[2], val);
    return root;
}

int main() {
    long *root;
    root = 0;
    root = insert(root, 50);
    insert(root, 30);
    insert(root, 70);

    // This validates the recursive calls for deallocation
    free_tree(root);

    return 0; // Success if no VM crash
}
