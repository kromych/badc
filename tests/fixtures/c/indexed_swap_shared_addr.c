// In-place array swaps reuse one `base + index*scale` address for both
// the load and the store of an element. The scaled-index fold collapses
// every such access into the addressing mode, not only single-use ones,
// so the shared shift and add drop out.

static void swap(long *a, int i, int j) {
    long t = a[i];
    a[i] = a[j];
    a[j] = t;
}

int main() {
    long x[5];
    int i;
    for (i = 0; i < 5; i++) {
        x[i] = i + 1;
    }
    swap(&x[0], 0, 4);
    swap(&x[1], 0, 2);
    // x was 1 2 3 4 5; swap(0,4) -> 5 2 3 4 1; swap on &x[1] (0,2) over
    // {2,3,4} swaps 2 and 4 -> 5 4 3 2 1.
    if (x[0] != 5 || x[1] != 4 || x[2] != 3 || x[3] != 2 || x[4] != 1) {
        return 1;
    }
    return 0;
}
