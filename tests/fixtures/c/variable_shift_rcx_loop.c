/* The x86_64 variable-shift lowering borrows rcx for the count; a
   loop-carried value colored into rcx is live across the shift via
   the back edge while its pc interval excludes the shift, so the
   save must not rely on a pc-interval liveness test. */
long g(long n, long m, long c, long k) {
    long acc = 0;
    for (long i = 0; acc < n; i += (m << c)) {
        acc = i + k;
    }
    return k;
}

int main(void) {
    return g(100, 2, 3, 1) == 1 ? 0 : 1;
}
