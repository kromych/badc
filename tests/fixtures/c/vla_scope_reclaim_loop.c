/* C99 6.2.4p2: a VLA declared in a loop body is reclaimed on each
   iteration. Without the stack pointer being restored per iteration,
   100000 rounds of 256 bytes would exhaust the stack long before the
   loop ends. Self-checks the accumulated value. */
int main(void) {
    long total = 0;
    for (int iter = 0; iter < 100000; iter++) {
        int n = 64;
        int a[n];
        for (int i = 0; i < n; i++) {
            a[i] = i;
        }
        total += a[iter & 63];
    }
    long expect = 0;
    for (int iter = 0; iter < 100000; iter++) {
        expect += (iter & 63);
    }
    return total == expect ? 0 : 1;
}
