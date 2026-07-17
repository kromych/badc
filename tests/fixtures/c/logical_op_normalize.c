// C99 6.5.13p3 / 6.5.14p3: the result of `&&` and `||` is int 0 or 1,
// regardless of the operand values. The result is observable when stored
// and used arithmetically (an array index, an addend) rather than only as
// a branch condition. A truthy operand that is not already 1 -- a pointer
// or an int like 5 -- must normalize to 1 on both the short-circuit path
// (lhs alone decides) and the evaluated-rhs path.

static int big = 0x6441c0;

__attribute__((noinline)) static int or_ll(void *p, int n) { return p || n > 0; }
__attribute__((noinline)) static int or_rr(int n, void *p) { return n > 0 || p; }
__attribute__((noinline)) static int and_ll(void *p, int n) { return p && n > 0; }
__attribute__((noinline)) static int and_rr(int a, int b) { return a && b; }

int main(void) {
    void *p = (void *)(long)big; // a truthy, non-1 pointer

    // Short-circuit path: lhs alone decides.
    if (or_ll(p, 0) != 1) return 1;          // p || ... -> 1
    if (and_ll((void *)0, 5) != 0) return 2; // 0 && ... -> 0

    // Evaluated-rhs path: rhs must normalize.
    if (or_rr(0, p) != 1) return 3;          // 0 || p -> 1 (not p)
    if (and_rr(5, 7) != 1) return 4;         // 5 && 7 -> 1 (not 7)
    if (and_rr(5, 0) != 0) return 5;         // 5 && 0 -> 0

    // As an array index: the original crash shape.
    int t[2] = {10, 20};
    if (t[or_ll(p, 0)] != 20) return 6;      // index must be 1
    if (t[and_ll((void *)0, 9)] != 10) return 7;

    // Chained.
    if ((p || (void *)0 || 0) != 1) return 8;
    if ((5 && 7 && 3) != 1) return 9;
    return 0;
}
