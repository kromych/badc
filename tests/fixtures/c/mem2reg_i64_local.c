// A `long` local assigned once and read across a loop body. With no
// address taken, mem2reg promotes the full-width slot to a register
// under -O; the loop-carried `acc` and `i` need a join phi and stay
// in memory. The result is identical at -O and without it.
long f(long n) {
    long base = n * 3;
    long acc = 0;
    long i = 0;
    while (i < 4) {
        acc = acc + base;
        i = i + 1;
    }
    return acc;
}
int main(void) {
    return (int)f(7);
}
