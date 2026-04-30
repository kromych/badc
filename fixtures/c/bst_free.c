#include <stdlib.h>

// Tree nodes are flat int[3] = [value, left, right]; the left/right
// cells hold pointer-shaped values, hence the casts.
void free_tree(int *root) {
    if (root == 0) return;

    // Post-order traversal: visit children before the parent
    free_tree((int *)root[1]); // left
    free_tree((int *)root[2]); // right

    free(root);
}

int* insert(int *root, int val) {
    if (root == 0) {
        root = malloc(sizeof(int) + 2 * sizeof(int *));
        root[0] = val; root[1] = 0; root[2] = 0;
        return root;
    }
    if (val < root[0]) root[1] = (int)insert((int *)root[1], val);
    else root[2] = (int)insert((int *)root[2], val);
    return root;
}

int main() {
    int *root;
    root = 0;
    root = insert(root, 50);
    insert(root, 30);
    insert(root, 70);

    // This validates the recursive calls for deallocation
    free_tree(root);

    return 0; // Success if no VM crash
}
