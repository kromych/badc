/* C99 6.2.4p2: a loop-body VLA is freed on every iteration, so the
   stack pointer returns to its block-entry value and each iteration's
   VLA lands at the same address. 64 rounds of 256 KiB would need
   16 MiB if a round leaked. Returns 42. */
int main(void) {
    volatile int scale = 1;
    unsigned long first = 0;
    long sum = 0;
    for (int iter = 0; iter < 64; iter++) {
        long n = (long)scale << 18;
        char a[n];
        a[0] = (char)iter;
        a[n - 1] = (char)(iter + 1);
        if (iter == 0) {
            first = (unsigned long)a;
        } else if ((unsigned long)a != first) {
            return 1;
        }
        sum += a[0] + a[n - 1];
    }
    return sum == 4096 ? 42 : 2;
}
