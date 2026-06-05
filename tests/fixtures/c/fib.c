// Recursive Fibonacci. The recursive `return fib(n-1) + fib(n-2)`
// shape has one non-tail call and one tail-position call; the
// tail-call lowering pass picks up the second leg.

static long fib(int n) {
    if (n < 2) return (long)n;
    return fib(n - 1) + fib(n - 2);
}

int main(void) {
    long r = fib(20);
    // fib(20) = 6765
    if (r != 6765) return 1;
    return 0;
}
