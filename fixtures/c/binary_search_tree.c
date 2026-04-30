#include <stdlib.h>

// Tree nodes are packed as int[3]: [value, left, right]. The left/
// right cells hold pointer-shaped values, so we cast on the way in
// and out to keep badc's type-checker quiet about mixing `int` and
// `int *` -- the c4 dialect has no int** so flat-array nodes are
// the natural shape, but the cells still want the right typing.
int* insert(int *root, int val) {
    if (root == 0) {
        root = malloc(sizeof(int) + 2 * sizeof(int *));
        root[0] = val;
        root[1] = 0;
        root[2] = 0;
        return root;
    }
    if (val < root[0]) {
        root[1] = (int)insert((int *)root[1], val);
    } else {
        root[2] = (int)insert((int *)root[2], val);
    }
    return root;
}

int search(int *root, int val) {
    if (root == 0) return 0;
    if (root[0] == val) return 1;
    if (val < root[0]) return search((int *)root[1], val);
    return search((int *)root[2], val);
}

int main() {
    int *root;
    root = 0;
    root = insert(root, 50);
    insert(root, 30);
    insert(root, 70);
    insert(root, 20);
    insert(root, 40);

    if (search(root, 20) == 0) return 1; // Failed to find existing
    if (search(root, 40) == 0) return 2; // Failed to find existing
    if (search(root, 99) == 1) return 3; // Found non-existent

    return 0; // Success
}
