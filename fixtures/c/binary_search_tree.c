int* insert(int *root, int val) {
    if (root == 0) {
        root = malloc(24); // [0]=val, [1]=left, [2]=right
        root[0] = val;
        root[1] = 0;
        root[2] = 0;
        return root;
    }
    if (val < root[0]) {
        root[1] = insert(root[1], val);
    } else {
        root[2] = insert(root[2], val);
    }
    return root;
}

int search(int *root, int val) {
    if (root == 0) return 0;
    if (root[0] == val) return 1;
    if (val < root[0]) return search(root[1], val);
    return search(root[2], val);
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
