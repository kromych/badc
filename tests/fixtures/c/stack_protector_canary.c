// snapshot-flags: -fstack-protector-strong
// `-fstack-protector-strong`: every function holding an array, an
// aggregate with an array member, or a local whose address is taken gets a
// canary between its locals and the saved return address, loaded in the
// prologue and compared on every return path. The shapes below cover the
// frame forms the check has to survive: a plain array, several returns out
// of one frame, an aggregate copy, a variable-length array, an
// over-aligned automatic object, and a variadic callee. Each returns a
// distinct non-zero code on failure and the program returns 0.

#include <stdarg.h>
#include <string.h>

static void fill(char *p, unsigned long n, char c) {
    for (unsigned long i = 0; i < n; i++) {
        p[i] = c;
    }
}

static int one_array(int seed) {
    char b[32];
    fill(b, sizeof b, (char)seed);
    return b[0] + b[31];
}

static int many_returns(int x) {
    char b[16];
    fill(b, sizeof b, (char)x);
    if (x == 1) {
        return b[0];
    }
    if (x == 2) {
        return b[0] + 1;
    }
    return b[0] + 2;
}

struct Rec {
    int n;
    char tag[8];
};

static int aggregate(int seed) {
    struct Rec r;
    r.n = seed;
    memset(r.tag, seed, sizeof r.tag);
    struct Rec copy = r;
    return copy.n + copy.tag[7];
}

static int vla(int n) {
    char b[n];
    fill(b, (unsigned long)n, (char)n);
    return b[n - 1];
}

static int over_aligned(int seed) {
    __attribute__((aligned(32))) char b[64];
    fill(b, sizeof b, (char)seed);
    return b[63];
}

static int variadic(int n, ...) {
    char b[24];
    va_list ap;
    int sum = 0;
    fill(b, sizeof b, (char)n);
    va_start(ap, n);
    for (int i = 0; i < n; i++) {
        sum += va_arg(ap, int);
    }
    va_end(ap);
    return sum + b[0];
}

static int addr_of_scalar(int seed) {
    int x = seed;
    int *p = &x;
    *p += 1;
    return x;
}

int main(void) {
    if (one_array(3) != 6) {
        return 1;
    }
    if (many_returns(1) != 1) {
        return 2;
    }
    if (many_returns(2) != 3) {
        return 3;
    }
    if (many_returns(7) != 9) {
        return 4;
    }
    if (aggregate(5) != 10) {
        return 5;
    }
    if (vla(9) != 9) {
        return 6;
    }
    if (over_aligned(4) != 4) {
        return 7;
    }
    if (variadic(3, 10, 20, 30) != 63) {
        return 8;
    }
    if (addr_of_scalar(41) != 42) {
        return 9;
    }
    return 0;
}
