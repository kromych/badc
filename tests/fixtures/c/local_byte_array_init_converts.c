// An automatic array of one-byte elements converts each constant
// initializer to the element type as if by assignment (C99 6.7.8p11): a
// `_Bool` element holds 1 for any nonzero value (6.3.1.2), a character
// element the truncation of a floating value (6.3.1.4) and the low byte
// of a wider integer (6.3.1.3).

int main(void)
{
    _Bool flags[5] = {2, 0, 256, -1, 0.5};
    unsigned char bytes[4] = {300, -1, 65.9, 255.0};
    signed char small[2] = {-1.5, 127.0};
    for (int i = 0; i < 5; i++)
        if (*(unsigned char *)&flags[i] != (i == 1 ? 0 : 1))
            return 1 + i;
    if (bytes[0] != 44 || bytes[1] != 255 || bytes[2] != 65 || bytes[3] != 255) return 6;
    if (small[0] != -1 || small[1] != 127) return 7;
    return 0;
}
