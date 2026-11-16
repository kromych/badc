// Accumulator recursion over `|`, `^` and `&` becomes a loop as `+` and `*`
// do: each is associative and commutative on the bits, so the loop's
// reassociation is exact, and narrowing to the return type reads the low
// bits alone. Returns 0 when every result matches.

__attribute__((noinline)) static int load_le32(const unsigned char *p, int i) {
    if (i >= 4)
        return 0;
    return ((int)p[i] << (8 * i)) | load_le32(p, i + 1);
}

__attribute__((noinline)) static unsigned mix(unsigned n) {
    if (n == 0)
        return 0x5A5A5A5Au;
    return (n * 0x9E3779B9u) ^ mix(n - 1);
}

__attribute__((noinline)) static unsigned short clear_down(unsigned short n) {
    if (n == 0)
        return (unsigned short)0xFFFF;
    return (unsigned short)((unsigned short)~(1u << (n % 16)) & clear_down((unsigned short)(n - 1)));
}

__attribute__((noinline)) static signed char set_down(signed char n) {
    if (n <= 0)
        return 0;
    return (signed char)((signed char)(1 << (n % 7)) | set_down((signed char)(n - 1)));
}

int main(void) {
    unsigned char bytes[4] = {0x78, 0x56, 0x34, 0x12};
    if (load_le32(bytes, 0) != 0x12345678)
        return 1;
    unsigned want = 0x5A5A5A5Au;
    for (unsigned k = 1; k <= 100; k++)
        want ^= k * 0x9E3779B9u;
    if (mix(100) != want)
        return 2;
    unsigned short m = 0xFFFF;
    for (unsigned k = 1; k <= 20; k++)
        m &= (unsigned short)~(1u << (k % 16));
    if (clear_down(20) != m)
        return 3;
    signed char o = 0;
    for (int k = 1; k <= 9; k++)
        o |= (signed char)(1 << (k % 7));
    if (set_down(9) != o)
        return 4;
    return 0;
}
