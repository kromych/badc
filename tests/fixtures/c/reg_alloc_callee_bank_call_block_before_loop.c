// Call-crossing precision for phi classes: in `qs` the recursive-call
// block is laid out at a lower pc than the partition loop, and the
// loop keeps more values live than the callee bank minus one. Only
// the values whose CFG live range spans the calls (a, hi, i) need a
// callee-saved home; a pc-interval test also flagged lo/pivot/j,
// overfilled the callee bank, and spilled the loop induction
// variable. The SSA snapshot locks spill_count=0 for `qs`.
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
    unsigned int seed = 12345;
    int i;
    for (i = 0; i < 64; i++) {
        seed = seed * 1103515245u + 12345u;
        a[i] = (int)(seed & 0x7fffffff);
    }
    qs(a, 0, 63);
    for (i = 1; i < 64; i++) {
        if (a[i] < a[i - 1]) {
            return 1;
        }
    }
    return 0;
}
