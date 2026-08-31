// A local read before its address is taken yields the reaching store;
// every read from the point a pointer to it exists comes from memory,
// so a write through the pointer is observed. In a loop the escape
// reaches the loads above it on the next iteration. A call placed
// before the address is taken cannot reach the local. The result is
// identical at -O and without it.
static int direct(int n) {
    int x = n;
    int before = x;
    int *p = &x;
    *p = before + 5;
    return x - before;                 /* 5 */
}

static int in_loop(int n) {
    int x = n;
    int *p = 0;
    int sum = 0;
    for (int i = 0; i < 3; i++) {
        sum += x;                      /* n, n + 1, n + 2 */
        if (i == 0)
            p = &x;
        *p += 1;
    }
    return sum;                        /* 3n + 3 */
}

static __attribute__((noinline)) void bump(int *q) { *q += 7; }

static int via_callee(int n) {
    int x = n;
    int before = x;
    bump(&x);
    return x - before;                 /* 7 */
}

static __attribute__((noinline)) int noise(int v) { return v * 3; }

static int call_between(int n) {
    int x = n;
    int r = noise(n);
    int before = x;
    int *p = &x;
    *p = r;
    return x - before;                 /* 2n */
}

int main(void) {
    if (direct(10) != 5) return 1;
    if (in_loop(10) != 33) return 2;
    if (via_callee(10) != 7) return 3;
    if (call_between(10) != 20) return 4;
    return 0;
}
