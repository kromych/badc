#include <stdlib.h>

// Tree nodes are flat long long[3] = [value, left, right]; the
// left/right cells hold pointer-shaped values, so the storage type
// has to be 8 bytes (`int` is 4 bytes everywhere; `long` is only 4
// on Windows LLP64). `long long` is 8 bytes on every target.
void free_tree(long long *root) {
    if (root == 0) return;

    // Post-order traversal: visit children before the parent
    free_tree((long long *)root[1]); // left
    free_tree((long long *)root[2]); // right

    free(root);
}

long long* insert(long long *root, long long val) {
    if (root == 0) {
        root = malloc(sizeof(long long) + 2 * sizeof(long long *));
        root[0] = val; root[1] = 0; root[2] = 0;
        return root;
    }
    if (val < root[0]) root[1] = (long long)insert((long long *)root[1], val);
    else root[2] = (long long)insert((long long *)root[2], val);
    return root;
}

int main() {
    long long *root;
    root = 0;
    root = insert(root, 50);
    insert(root, 30);
    insert(root, 70);

    // This validates the recursive calls for deallocation
    free_tree(root);

    return 0; // Success if no VM crash
}
