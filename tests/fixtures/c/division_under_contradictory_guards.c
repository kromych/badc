// A division by a variable in an arm whose guards contradict: under
// `d > 5` the test `d < 1` never holds, so the range analysis sees the
// divisor with no value, `[6, 0]`. The compiler must still compile the
// arm; the program never runs it.

#define NOINLINE __attribute__((noinline))

NOINLINE static int sdiv_dead(int a, int d) {
    if (d > 5) {
        if (d < 1) return a / d;
    }
    return a;
}
NOINLINE static unsigned udiv_dead(unsigned a, unsigned d) {
    if (d > 5) {
        if (d < 1) return a / d;
    }
    return a;
}
NOINLINE static int srem_dead(int a, int d) {
    if (d > 5) {
        if (d < 1) return a % d;
    }
    return a;
}
NOINLINE static unsigned urem_dead(unsigned a, unsigned d) {
    if (d > 5) {
        if (d < 1) return a % d;
    }
    return a;
}

int main(void) {
    if (sdiv_dead(7, 9) != 7 || udiv_dead(7u, 9u) != 7u) return 1;
    if (srem_dead(7, 9) != 7 || urem_dead(7u, 9u) != 7u) return 2;
    if (sdiv_dead(7, 2) != 7 || urem_dead(7u, 0u) != 7u) return 3;
    return 0;
}
