#include <stdlib.h>

// Tree nodes are packed as long[3]: [value, left, right]. The cells
// hold pointer-shaped values, so under M31 (where `int` is 4 bytes
// and a pointer is 8) the storage type has to be `long`. We cast
// between `long *` and `long` at every store/load to mix value and
// pointer cells in the same array; the c4 dialect has no long**
// so flat-array nodes are the natural shape.
long* insert(long *root, long val) {
    if (root == 0) {
        root = malloc(sizeof(long) + 2 * sizeof(long *));
        root[0] = val;
        root[1] = 0;
        root[2] = 0;
        return root;
    }
    if (val < root[0]) {
        root[1] = (long)insert((long *)root[1], val);
    } else {
        root[2] = (long)insert((long *)root[2], val);
    }
    return root;
}

int search(long *root, long val) {
    if (root == 0) return 0;
    if (root[0] == val) return 1;
    if (val < root[0]) return search((long *)root[1], val);
    return search((long *)root[2], val);
}

int main() {
    long *root;
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
