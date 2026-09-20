// A call to the unit's first function is recorded against its symbol,
// keyed by the call's value id. `f` loses a block before mem2reg (the
// dead loop body), gains a phi in mem2reg (`x`), and loses another block
// after it (`c` is 0), which reads that table: the key has to have moved
// with the call.

__attribute__((noinline)) static int first(int x) { return x + 1; }

__attribute__((noinline)) static int f(int a) {
    int c = 0;
    int x;
    while (0) {
        a += 1; a += 2; a += 3; a += 4; a += 5; a += 6; a += 7; a += 8;
    }
    if (a) x = 1; else x = 2;
    if (c) x = first(x);
    return first(x);
}

int main(void) {
    if (f(1) != 2) return 1;
    if (f(0) != 3) return 2;
    return 0;
}
