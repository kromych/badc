/* C99 6.5.15p5: with two arithmetic arms the conditional's type is
   the usual-arithmetic-conversions common type and each arm converts
   to it, whichever arm is selected. `c ? 1u : -1` is unsigned int in
   both directions, not the else-arm's int. */
int main(void) {
    unsigned r = 0;
    long z = (r == 0) ? 1u : -1;
    if (z != 1) {
        return 1;
    }
    long w = (r != 0) ? 1u : -1;
    if (w != 4294967295L) {
        return 2;
    }
    /* Then-arm conversion: -1 selected against an unsigned else. */
    long v = (r == 0) ? -1 : 1u;
    if (v != 4294967295L) {
        return 3;
    }
    /* Rank widening: the int arm widens to long long. */
    long long p = (r == 0) ? -1 : 0LL;
    if (p != -1LL) {
        return 4;
    }
    return 0;
}
