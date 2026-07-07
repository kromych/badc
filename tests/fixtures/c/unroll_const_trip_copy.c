/* Constant-trip loops fully unroll: the trip-8 copy loop and the
 * rotated-index accumulation collapse to straight-line code (locked
 * by the SSA snapshot); the computed values check the per-copy index
 * substitution, including the signed % on the rotated index. */
long a[8], b[8];

int main(void) {
    long i, s = 0;
    for (i = 0; i < 8; i++) a[i] = i * 3 + 1;
    for (i = 0; i < 8; i++) b[i] = a[i];
    for (i = 0; i < 8; i++) s += b[(i + 1) % 8] * (i + 1);
    /* sum of a[(i+1)%8] * (i+1) = sum over j of a[j]*w */
    if (s != 4 + 7 * 2 + 10 * 3 + 13 * 4 + 16 * 5 + 19 * 6 + 22 * 7 + 1 * 8)
        return 1;
    if (i != 8) return 2;
    return 0;
}
