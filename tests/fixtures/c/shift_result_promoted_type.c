/* C99 6.5.7p3: the result of a shift has the promoted type of the
   left operand; the count operand does not participate. A signed
   64-bit `>>` must not narrow to int in a surrounding expression. */
int main(void) {
    long long x = -8589934592LL; /* -0x2_0000_0000 */
    long long y = (x >> 1) + 0;
    if (y != -4294967296LL) {
        return 1;
    }
    unsigned long long b = 0x8000000000000000ULL;
    if ((b >> 63) != 1) {
        return 2;
    }
    unsigned int u = 0x80000000u;
    if ((u >> 31) != 1) {
        return 3;
    }
    int neg = -16;
    if ((neg >> 2) != -4) {
        return 4;
    }
    /* Promoted sub-int LHS: unsigned char shifts as (zero-extended)
       int. */
    unsigned char c = 0x80;
    if ((c >> 3) != 0x10) {
        return 5;
    }
    return 0;
}
