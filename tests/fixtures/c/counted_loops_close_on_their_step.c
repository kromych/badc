// Loops counted down to zero, tested before the decrement (`n--`) and
// after it (`--n`), with 64-bit and 32-bit counters, from zero, from one,
// and with the counter read past the loop; and compares with small
// negative constants. Each result is checked against the same count kept
// in a volatile object. Returns 0 when every check passes; each failure
// returns a distinct code.

typedef unsigned long long u64;

__attribute__((noinline)) u64 post64(const unsigned char *p, u64 n) {
    u64 s = 0;
    while (n--)
        s = s * 5 + *p++;
    return s;
}

__attribute__((noinline)) unsigned post32(const unsigned char *p, unsigned n) {
    unsigned s = 0;
    while (n--)
        s = s * 5 + *p++;
    return s;
}

__attribute__((noinline)) int post_int(const unsigned char *p, int n) {
    int s = 0;
    while (n--)
        s ^= *p++ << (n & 7);
    return s;
}

__attribute__((noinline)) u64 pre64(const unsigned char *p, u64 n) {
    u64 s = 0;
    do
        s = s * 5 + *p++;
    while (--n);
    return s;
}

__attribute__((noinline)) unsigned pre32(const unsigned char *p, unsigned n) {
    unsigned s = 0;
    while (--n)
        s = s * 5 + *p++;
    return s;
}

// The counter is read past the loop, where it has wrapped.
__attribute__((noinline)) u64 kept(const unsigned char *p, u64 n, u64 *left) {
    u64 s = 0;
    while (n--)
        s += *p++;
    *left = n;
    return s;
}

__attribute__((noinline)) u64 reference(const unsigned char *p, u64 n) {
    volatile u64 s = 0;
    for (volatile u64 i = 0; i < n; i++)
        s = s * 5 + p[i];
    return s;
}

__attribute__((noinline)) int negatives(long x, int y) {
    return (x == -7) + 2 * (x != -4095) + 4 * (x == -4096) + 8 * (y == -1) + 16 * (x < -100);
}

int main(void) {
    unsigned char b[200];
    for (int i = 0; i < 200; i++)
        b[i] = (unsigned char)(i * 29 + 3);
    if (post64(b, 200) != reference(b, 200)) return 1;
    if (post64(b, 0) != 0) return 2;
    if (post64(b, 1) != b[0]) return 3;
    if (post32(b, 200) != (unsigned)reference(b, 200)) return 4;
    if (post32(b, 0) != 0) return 5;
    if (pre64(b, 200) != reference(b, 200)) return 6;
    if (pre64(b, 1) != b[0]) return 7;
    if (pre32(b, 200) != (unsigned)reference(b, 199)) return 8;
    if (pre32(b, 1) != 0) return 9;
    int t = 0;
    for (int n = 13; n--;)
        t ^= b[12 - n] << (n & 7);
    if (post_int(b, 13) != t || post_int(b, 0) != 0) return 10;
    u64 left = 1;
    if (kept(b, 10, &left) != 0 + b[0] + b[1] + b[2] + b[3] + b[4] + b[5] + b[6] + b[7] + b[8] + b[9])
        return 11;
    if (left != (u64)-1) return 12;
    if (negatives(-7, -1) != 1 + 2 + 8 + 0) return 13;
    if (negatives(-4095, 0) != 16) return 14;
    if (negatives(-4096, 5) != 2 + 4 + 16) return 15;
    if (negatives(7, -1) != 2 + 8) return 16;
    return 0;
}
