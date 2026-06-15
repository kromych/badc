#include <stdlib.h>

// Tree nodes are packed as long long[3]: [value, left, right]
long long* insert(long long *root, long long val) {
    if (root == 0) {
        root = malloc(sizeof(long long) + 2 * sizeof(long long *));
        root[0] = val;
        root[1] = 0;
        root[2] = 0;
        return root;
    }
    if (val < root[0]) {
        root[1] = (long long)insert((long long *)root[1], val);
    } else {
        root[2] = (long long)insert((long long *)root[2], val);
    }
    return root;
}

int search(long long *root, long long val) {
    if (root == 0) return 0;
    if (root[0] == val) return 1;
    if (val < root[0]) return search((long long *)root[1], val);
    return search((long long *)root[2], val);
}

int main() {
    long long *root;
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
