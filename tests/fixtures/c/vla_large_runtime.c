/* C99 6.7.6.2: a VLA sized by a runtime value far beyond any fixed
   per-frame reservation. 262144 ints (1 MiB) are written and summed;
   the volatile scale keeps the size out of constant folding. Returns
   42. */
int main(void) {
    volatile int scale = 1;
    long n = (long)scale << 18;
    int v[n];
    for (long i = 0; i < n; i++) {
        v[i] = 1;
    }
    long s = 0;
    for (long i = 0; i < n; i++) {
        s += v[i];
    }
    return s == n ? 42 : 1;
}
