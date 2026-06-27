/* C99 6.3.1.8: a relational comparison converts its operands to the
   common type. For unsigned int vs int the common type is unsigned int,
   so the comparison is unsigned and a negative signed operand converts to
   a large unsigned value -- its sign-extended high bits must not leak
   into the compare. */

int main(void) {
    unsigned u = 0xFFFFFFFFu;
    int s = -1;
    if (u < s) {
        return 1;
    }
    if (s < u) {
        return 2;
    }
    if (!(u <= s)) {
        return 3;
    }
    if (!(u >= s)) {
        return 4;
    }
    if (u > s) {
        return 5;
    }
    /* Same-signedness comparisons must be unaffected. */
    unsigned a = 5, b = 10;
    if (!(a < b) || b < a) {
        return 6;
    }
    int x = -5, y = 3;
    if (!(x < y) || y < x) {
        return 7;
    }
    /* An 8-byte common type keeps a full-width compare. */
    unsigned long bu = 0xFFFFFFFFFFFFFFFFul;
    if (bu < s) {
        return 8;
    }
    return 0;
}
