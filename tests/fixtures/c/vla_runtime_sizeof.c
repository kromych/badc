/* C99 6.5.3.4p2: sizeof applied to a variable-length array is a
   runtime value, n * sizeof(element). The size is fixed at the
   declaration (6.7.6.2p4), so a later change to n does not affect it. */
int main(void) {
    int n = 7;
    long a[n];
    unsigned long sz = sizeof(a);
    if (sz != (unsigned long)n * sizeof(long)) {
        return 1;
    }
    /* sizeof(a) / sizeof(a[0]) recovers the element count. */
    if (sz / sizeof(a[0]) != (unsigned long)n) {
        return 2;
    }
    n = 100;
    if (sizeof(a) != 7 * sizeof(long)) {
        return 3;
    }
    return 0;
}
