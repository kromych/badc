/* Narrow locals merged at a join and read back at their declared width: the
 * values reaching the join are already masked or sign-extended, across a
 * branch and across a loop back edge, beside joins whose incoming values do
 * not fit the read, which has to narrow them. */

__attribute__((noinline)) int mix(int x) { return x * 3 + 1; }

/* Zero and a byte masked from an int. */
__attribute__((noinline)) int join_masked(int x)
{
    unsigned char c = 0;
    if ((unsigned)x < 128)
        c = (unsigned char)(x & 0xff);
    return (c ^ 42) != 0;
}

/* A byte accumulated over a loop. */
__attribute__((noinline)) int loop_masked(int n)
{
    unsigned char c = 0;
    for (int i = 0; i < n; i++)
        c = (unsigned char)(c + mix(i));
    return c ^ 42;
}

/* A byte counter that wraps. */
__attribute__((noinline)) int count_u8(int n)
{
    unsigned char c = 0;
    for (int i = 0; i < n; i++)
        c = (unsigned char)(c + 1);
    return c;
}

/* A signed byte counter that wraps. */
__attribute__((noinline)) int count_s8(int n)
{
    signed char c = 0;
    for (int i = 0; i < n; i++)
        c = (signed char)(c + 3);
    return c;
}

/* A constant and a 16-bit truncation. */
__attribute__((noinline)) int join_u16(int x)
{
    unsigned short s = 7;
    if (x > 1000)
        s = (unsigned short)x;
    return s + 1;
}

/* Zero and a full int: the byte read keeps its mask. */
__attribute__((noinline)) int join_unmasked(int x, int y)
{
    int v = 0;
    if (x > 0)
        v = y;
    unsigned char c = (unsigned char)v;
    return c;
}

/* Zero and a byte read as a signed char: 0x80..0xff do not fit. */
__attribute__((noinline)) int join_byte_as_signed(int x)
{
    unsigned char b = 0;
    if (x > 0)
        b = (unsigned char)x;
    signed char s = (signed char)b;
    return s;
}

int main(void)
{
    if (join_masked(42) != 0 || join_masked(7) != 1 || join_masked(300) != 1)
        return 1;
    if (join_masked(-1) != 1)
        return 2;
    if (loop_masked(10) != 187 || loop_masked(100) != 76 || loop_masked(0) != 42)
        return 3;
    if (count_u8(255) != 255 || count_u8(256) != 0 || count_u8(300) != 44)
        return 4;
    if (count_s8(42) != 126 || count_s8(43) != -127 || count_s8(0) != 0)
        return 5;
    if (join_u16(5) != 8 || join_u16(70000) != 4465 || join_u16(65535) != 0x10000)
        return 6;
    if (join_unmasked(1, 0x1234) != 0x34 || join_unmasked(0, 0x1234) != 0)
        return 7;
    if (join_unmasked(1, -2) != 254)
        return 8;
    if (join_byte_as_signed(0x7f) != 127 || join_byte_as_signed(0x80) != -128)
        return 9;
    if (join_byte_as_signed(0x1ff) != -1 || join_byte_as_signed(-5) != 0)
        return 10;
    return 42;
}
