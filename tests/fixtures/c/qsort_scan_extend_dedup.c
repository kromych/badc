// A partition scan re-derives `(long)i` in the loop header, the
// increment block, and the swap block. The extends are the same
// (value, kind) at dominated positions, so one dominating sxtw /
// movslq per iteration suffices (C99 6.3.1.3 gives one conversion
// result per value). Locks the cross-block extend dedup; the sort
// result checks the deduped index still addresses correctly.

static void qs(int *a, int lo, int hi) {
    if (lo >= hi) return;
    int pivot = a[(lo + hi) / 2];
    int i = lo, j = hi;
    while (i <= j) {
        while (a[i] < pivot) i++;
        while (a[j] > pivot) j--;
        if (i <= j) {
            int t = a[i];
            a[i] = a[j];
            a[j] = t;
            i++;
            j--;
        }
    }
    qs(a, lo, j);
    qs(a, i, hi);
}

int main(void) {
    int a[64];
    unsigned int seed = 12345u;
    for (int i = 0; i < 64; i++) {
        seed = seed * 1103515245u + 12345u;
        a[i] = (int)(seed >> 16) - 0x4000;
    }
    qs(a, 0, 63);
    for (int i = 1; i < 64; i++)
        if (a[i] < a[i - 1]) return 1;
    return 0;
}
