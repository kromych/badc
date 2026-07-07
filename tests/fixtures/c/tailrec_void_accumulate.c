// A void helper whose only recursion is a same-block tail call: the last
// effectful instruction is the self-call and the return yields no value,
// so the pass turns it into a loop (constant-return mode) rather than
// leaving it recursive. The per-level store to the global happens before
// the recursive call, so it stays inside the loop body.

static long total;

static void accumulate(int n) {
    if (n == 0) return;
    total += n;
    accumulate(n - 1);
}

int main(void) {
    accumulate(100);
    // 100 + 99 + ... + 1 = 5050.
    return total == 5050 ? 0 : 1;
}
