// Diamond join with both arms writing the slot, then a single load
// at the merge. The IDF places one phi at the join; both incoming
// sources are forward (defined before the phi). populate_phi_hints
// already propagates a single hint across the group, but the
// back-edge coalesce hack does not fire. Verifies the union-find
// pass covers the forward shape uniformly.

int test(int cond, int a, int b) {
    int x;
    if (cond) x = a + 1;
    else x = b - 1;
    return x;
}

int main(void) {
    int t1;
    int t2;
    t1 = test(1, 10, 0);
    t2 = test(0, 0, 20);
    return t1 + t2;
}
