// Narrow integer locals: storing a value outside the destination
// range truncates to the type width (C99 6.3.1.3) and a load
// re-extends per signedness. `signed char` and `unsigned char` are
// 1-byte (C99 6.2.5); `int` is 4-byte. The truncated `signed char`
// is also read across a loop back edge, so the result is identical
// at -O (where mem2reg may promote the slot) and without it.
int main(void) {
    signed char sc = 300;        // 300 mod 256 = 44
    unsigned char uc = 300;      // 44
    signed char neg = 200;       // wraps to -56 when read as signed
    int i = 0;
    int acc = 0;
    while (i < 4) {
        acc = acc + sc;          // 44 * 4 = 176
        i = i + 1;
    }
    int r = 0;
    if (sc != 44) r = r + 1;
    if (uc != 44) r = r + 2;
    if (neg != -56) r = r + 4;
    if (acc != 176) r = r + 8;
    return r;                    // 0 when every width holds
}
