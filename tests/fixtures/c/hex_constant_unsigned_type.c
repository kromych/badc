/* C99 6.4.4.1: an unsuffixed hexadecimal or octal constant takes the
   first type of int, unsigned int, long, unsigned long, long long,
   unsigned long long that can represent it, so 0xffffffff (and the
   octal 037777777777) is unsigned int rather than signed long. A
   decimal constant with no suffix never takes an unsigned type. The
   signed/unsigned outcome of a mixed comparison depends on this. */
int main(void) {
    int x = -1;
    /* x converts to unsigned int 4294967295, equal to 0xffffffff. */
    if (x != 0xffffffff) {
        return 1;
    }
    /* 037777777777 octal is also unsigned int 4294967295. */
    if (x != 037777777777) {
        return 2;
    }
    /* Decimal 4294967295 is signed long; x sign-extends and differs. */
    if (!(x != 4294967295)) {
        return 3;
    }
    return 0;
}
