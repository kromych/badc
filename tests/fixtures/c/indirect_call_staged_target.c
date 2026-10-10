// snapshot-flags(linux-aarch64): -ffixed-x9 -ffixed-x10 -ffixed-x11 -ffixed-x12 -ffixed-x13 -ffixed-x14 -ffixed-x15 -ffixed-x20 -ffixed-x21 -ffixed-x22 -ffixed-x23 -ffixed-x24 -ffixed-x25 -ffixed-x26 -ffixed-x27 -ffixed-x28
/* An indirect call with seventeen arguments through a pointer that
 * arrives in the first argument register. With x9..x15 and x20..x28
 * kept out of the allocation (`-ffixed-`), AAPCS64 leaves the target no
 * register: the marshal writes x0..x7 and x16 / x17, so the target is
 * staged in a cell above the nine stack arguments in the outgoing area
 * and reloaded for the `blr`. The callee weights each argument by its
 * position, so a misplaced one changes the sum. Returns 0 when the
 * indirect call matches the direct one. */

typedef long (*f17)(long, long, long, long, long, long, long, long, long, long, long, long,
                    long, long, long, long, long);

static long weigh17(long v1, long v2, long v3, long v4, long v5, long v6, long v7, long v8,
                    long v9, long v10, long v11, long v12, long v13, long v14, long v15,
                    long v16, long v17) {
    return v1 + 2 * v2 + 3 * v3 + 4 * v4 + 5 * v5 + 6 * v6 + 7 * v7 + 8 * v8 + 9 * v9 +
           10 * v10 + 11 * v11 + 12 * v12 + 13 * v13 + 14 * v14 + 15 * v15 + 16 * v16 +
           17 * v17;
}

__attribute__((noinline)) long through(f17 fp, long a, long b) {
    return fp(a, b, a + b, a - b, a * b, a + 1, b + 1, a + 2, b + 2, a + 3, b + 3, a + 4,
              b + 4, a + 5, b + 5, a + 6, b + 6);
}

f17 volatile pick = weigh17;

int main(void) {
    long want = weigh17(3, 5, 8, -2, 15, 4, 6, 5, 7, 6, 8, 7, 9, 8, 10, 9, 11);
    return through(pick, 3, 5) == want ? 0 : 1;
}
