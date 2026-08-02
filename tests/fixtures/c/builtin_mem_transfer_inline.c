// GCC memory-transfer builtins with an integer-constant-expression
// byte count expand inline, so a freestanding unit that uses them
// needs no library function. A count the expansion declines falls
// back to the library through the auto-included thunk header.

struct box {
    unsigned long a, b;
    unsigned int c;
    unsigned char d;
};

static unsigned char buf[64];

static void put_u32(void *p, unsigned int v) {
    __builtin_memcpy(p, &v, sizeof(v));
}

static unsigned int get_u32(const void *p) {
    unsigned int v;
    __builtin_memcpy(&v, p, sizeof(v));
    return v;
}

int main(void) {
    struct box a, b;

    // Whole-object copy with the structure's own alignment.
    __builtin_memset(&a, 0, sizeof(a));
    if (a.a != 0 || a.b != 0 || a.c != 0 || a.d != 0) return 1;
    a.a = 0x0123456789abcdefUL;
    a.b = 0xfedcba9876543210UL;
    a.c = 0xdeadbeefU;
    a.d = 0x5a;
    __builtin_memcpy(&b, &a, sizeof(b));
    if (b.a != a.a || b.b != a.b || b.c != a.c || b.d != a.d) return 2;

    // Unaligned accesses through `void *`: the expansion may only
    // assume byte alignment.
    for (int i = 0; i < 5; i++) put_u32(&buf[i * 7 + 1], 0x11223344U + i);
    for (int i = 0; i < 5; i++)
        if (get_u32(&buf[i * 7 + 1]) != 0x11223344U + (unsigned) i) return 3;

    // A non-constant byte value fills every byte.
    __builtin_memset(buf, (int) (b.d), 16);
    for (int i = 0; i < 16; i++)
        if (buf[i] != 0x5a) return 4;

    // Overlapping moves, forward and backward, at an alignment that
    // keeps the expansion inline and at one that does not.
    unsigned long words[6];
    for (int i = 0; i < 6; i++) words[i] = 0x100UL + i;
    __builtin_memmove(&words[1], &words[0], 3 * sizeof(words[0]));
    for (int i = 0; i < 3; i++)
        if (words[1 + i] != 0x100UL + i) return 5;
    for (int i = 0; i < 6; i++) words[i] = 0x100UL + i;
    __builtin_memmove(&words[0], &words[1], 3 * sizeof(words[0]));
    for (int i = 0; i < 3; i++)
        if (words[i] != 0x101UL + i) return 6;
    for (int i = 0; i < 24; i++) buf[i] = (unsigned char) i;
    __builtin_memmove(&buf[4], &buf[0], 16);
    for (int i = 0; i < 16; i++)
        if (buf[4 + i] != i) return 13;
    for (int i = 0; i < 24; i++) buf[i] = (unsigned char) i;
    __builtin_memmove(&buf[0], &buf[4], 16);
    for (int i = 0; i < 16; i++)
        if (buf[i] != i + 4) return 14;

    // A count past the inline cap, and a count that is not a constant
    // expression, both still perform the transfer.
    unsigned char big[512], big2[512];
    for (int i = 0; i < 512; i++) big[i] = (unsigned char) (i * 3);
    __builtin_memcpy(big2, big, sizeof(big));
    for (int i = 0; i < 512; i++)
        if (big2[i] != (unsigned char) (i * 3)) return 7;
    unsigned long n = 24;
    __builtin_memset(big2, 0, n);
    for (unsigned long i = 0; i < n; i++)
        if (big2[i] != 0) return 8;
    if (big2[n] != (unsigned char) (24 * 3)) return 9;

    // The value is the destination address (C99 7.21.2.1p2).
    if (__builtin_memcpy(&b, &a, sizeof(b)) != (void *) &b) return 10;
    if (__builtin_memset(&b, 0, sizeof(b)) != (void *) &b) return 11;
    if (__builtin_memmove(&b, &a, 16) != (void *) &b) return 12;
    return 0;
}
