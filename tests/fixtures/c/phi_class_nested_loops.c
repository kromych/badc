// Two nested counted loops with independent accumulators.
// The IDF places phi nodes for each loop header; the outer header
// sees the outer counter `i` plus a phi for `total` whose back-edge
// source comes from the *inner* loop's last block. Single-source
// back-edge coalesce misses this shape because the outer phi's
// back-edge source flows through more than one block, including the
// inner header's phi merge for `total`.

int test(int n) {
    int i;
    int j;
    int total;
    int inner;
    total = 0;
    for (i = 0; i < n; i++) {
        inner = 0;
        for (j = 0; j < n; j++) inner = inner + 1;
        total = total + inner;
    }
    return total;
}

int main(void) {
    return test(7);
}
