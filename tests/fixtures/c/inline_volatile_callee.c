/* C99 5.1.2.3p2 / 6.7.3p6: a volatile access is a side effect even
   when the value is unused. A callee whose inlined form would drop
   such an access -- a dead read of a volatile parameter, a store to
   one, a volatile local -- stays out of line, and each access is
   performed exactly once per call. */
volatile int g = 6;

static int read_param(volatile int x) {
    x;
    return 1;
}

static int write_param(volatile int x) {
    x = 1;
    return 2;
}

static int local_pair(void) {
    volatile int t = 3;
    t;
    return 4;
}

int main(void) {
    int r = read_param(g) + write_param(0) + local_pair();
    return r - 7;
}
