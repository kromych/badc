/* C99 6.5.16p3: an assignment expression's value is the value of the
   left operand after conversion to its type. When the left operand is
   a narrower integer than the right-hand side, a wider enclosing use
   must see the narrowed (truncated and re-extended) value, not the raw
   right-hand side. The store truncates the stored bytes; the value
   carried forward must be narrowed independently. */

int main(void) {
    unsigned u;
    signed char sc;
    unsigned char uc;
    short sh;

    /* signed char: low byte 0x03, sign-extended -> 3 */
    u = (sc = (unsigned long)0xFFFFFFFFFFFF0003UL);
    if (u != 3u) {
        return 1;
    }
    /* short: 0xABCD sign-extends to 0xFFFFABCD when widened unsigned */
    u = (sh = 0x1234ABCD);
    if (u != 0xFFFFABCDu) {
        return 2;
    }
    /* unsigned char: masks to 0xFD */
    u = (uc = 0x12FD);
    if (u != 0xFDu) {
        return 3;
    }
    /* nested: g = (sc = wide) chained */
    unsigned long w = 0x1122334455667788UL;
    u = (uc = (sh = w));   /* sh=(short)0x7788; uc=(uchar)0x88; u=0x88 */
    if (u != 0x88u) {
        return 4;
    }
    return 0;
}
