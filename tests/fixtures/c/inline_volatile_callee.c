/* C99 5.1.2.3p2 / 6.7.3p6: a volatile access is a side effect even
   when the value is unused. Inlining must preserve each access
   exactly once per call: a volatile parameter's cell relocates into a
   caller frame slot initialized from the argument and keeps its reads
   and writes, while a callee whose spliced form would drop an access
   (the volatile local here) stays out of line. */
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
