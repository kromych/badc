/* Loop-depth-weighted spill-cost ordering.

   `hot` computes eight values before the loop and reads them once
   after it, while the loop's induction variable `i` and accumulator
   `acc` are read every iteration. The pre-loop values are live across
   the whole loop and interfere with the loop-carried values, so a bank
   that cannot hold them all must spill something. Ordering the coloring
   by loop-depth-weighted use count makes the once-used pre-loop values
   the spill candidates and keeps `i` / `acc` in registers. Unsigned
   arithmetic keeps the wraparound defined (C99 6.2.5p9). */

static unsigned hot(const unsigned *a, unsigned n) {
    unsigned c0 = a[0] + 1u;
    unsigned c1 = a[1] + 2u;
    unsigned c2 = a[2] + 3u;
    unsigned c3 = a[3] + 4u;
    unsigned c4 = a[4] + 5u;
    unsigned c5 = a[5] + 6u;
    unsigned c6 = a[6] + 7u;
    unsigned c7 = a[7] + 8u;
    unsigned acc = 0u;
    unsigned i;
    for (i = 0u; i < n; i++) {
        acc += a[i & 7u] * (i + 1u);
        acc ^= acc << 1;
        acc += i;
    }
    return acc ^ c0 ^ c1 ^ c2 ^ c3 ^ c4 ^ c5 ^ c6 ^ c7;
}

int main(void) {
    unsigned a[8] = {3u, 5u, 7u, 11u, 13u, 17u, 19u, 23u};
    unsigned r = hot(a, 1000u);
    return (int)(r & 0xFFu);
}
