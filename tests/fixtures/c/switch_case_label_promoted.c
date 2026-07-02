/* C99 6.8.4.2p5: each case constant converts to the promoted type of
   the controlling expression. On an int switch `case 0x80000000:`
   (unsigned int constant) converts to INT_MIN and must match. */
int main(void) {
    int v = -2147483647 - 1;
    int hit = 0;
    switch (v) {
        case 0x80000000:
            hit = 1;
            break;
        default:
            hit = 2;
            break;
    }
    if (hit != 1) {
        return 1;
    }
    /* Unsigned controlling type: a negative label wraps modulo 2^32. */
    unsigned u = 0xfffffffeu;
    switch (u) {
        case -2:
            hit = 3;
            break;
        default:
            hit = 4;
            break;
    }
    if (hit != 3) {
        return 2;
    }
    /* 8-byte controlling type keeps full-width labels. */
    long long w = -4294967296LL;
    switch (w) {
        case -4294967296LL:
            hit = 5;
            break;
        case 0x80000000:
            hit = 6;
            break;
        default:
            hit = 7;
            break;
    }
    if (hit != 5) {
        return 3;
    }
    return 0;
}
