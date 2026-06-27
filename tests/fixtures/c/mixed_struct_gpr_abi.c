/* AAPCS64 5.4.2 C.10: a non-homogeneous aggregate no larger than 16
   bytes with a floating-point member passes in general registers, not by
   reference. Both call directions must agree on the register layout. */

struct mixed {
    long i;
    double d;
};

static long take(struct mixed m, int k) {
    return (long)((double)m.i + m.d * 2.0) + k;
}

static long take2(int a, int b, int c, int d, int e, int f, struct mixed m) {
    return a + b + c + d + e + f + m.i + (long)m.d;
}

int main(void) {
    struct mixed m = {3, 4.5};
    if (take(m, 2) != 14) {
        return 1;
    }
    if (take2(1, 2, 3, 4, 5, 6, m) != 28) {
        return 2;
    }
    return 0;
}
