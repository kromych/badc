// A loop-carried 32-bit value that enters the loop with its upper half
// unspecified and is read past the loop and by a right shift, an index
// and a division in it: unsigned (zero-extended reads, C17 6.2.5p9),
// signed (sign-extended reads), and one whose next value is wider than 32
// bits before its conversion (C17 6.3.1.3p2). Each result is checked
// against the same computation over volatile objects. Returns 0 when every
// check passes; each failure returns a distinct code.

typedef unsigned long long u64;

static unsigned table[256];
static int signed_table[256];

__attribute__((noinline)) unsigned zero_extended(u64 seed, const unsigned char *p, long n) {
    unsigned c = (unsigned)~seed;
    while (n--)
        c = table[(c ^ *p++) & 0xff] ^ (c >> 8);
    return ~c;
}

__attribute__((noinline)) unsigned zero_extended_ref(u64 seed, const unsigned char *p, long n) {
    volatile unsigned c = (unsigned)~seed;
    while (n--)
        c = table[(c ^ *p++) & 0xff] ^ (c >> 8);
    return ~c;
}

__attribute__((noinline)) int sign_extended(u64 seed, const unsigned char *p, long n) {
    int h = (int)(seed * 0x9e3779b97f4a7c15ull);
    long q = 0;
    while (n--) {
        h = (h >> 3) ^ signed_table[*p++];
        q += h / 7;
    }
    return h ^ (int)q;
}

__attribute__((noinline)) int sign_extended_ref(u64 seed, const unsigned char *p, long n) {
    volatile int h = (int)(seed * 0x9e3779b97f4a7c15ull);
    volatile long q = 0;
    while (n--) {
        h = (h >> 3) ^ signed_table[*p++];
        q += h / 7;
    }
    return h ^ (int)q;
}

__attribute__((noinline)) unsigned widened(u64 seed, const unsigned char *p, long n) {
    unsigned c = (unsigned)(seed >> 7);
    u64 s = 0;
    while (n--) {
        c = c * 2654435761u + *p++;
        s += c >> 5;
    }
    return c ^ (unsigned)s;
}

__attribute__((noinline)) unsigned widened_ref(u64 seed, const unsigned char *p, long n) {
    volatile unsigned c = (unsigned)(seed >> 7);
    volatile u64 s = 0;
    while (n--) {
        c = c * 2654435761u + *p++;
        s += c >> 5;
    }
    return c ^ (unsigned)s;
}

int main(void) {
    for (unsigned i = 0; i < 256; i++) {
        unsigned c = i;
        for (int k = 0; k < 8; k++)
            c = c & 1 ? 0xEDB88320u ^ (c >> 1) : c >> 1;
        table[i] = c;
        signed_table[i] = (int)(c ^ 0x80000000u);
    }
    unsigned char buf[300];
    for (int i = 0; i < 300; i++)
        buf[i] = (unsigned char)(i * 37 + 11);
    u64 seeds[3] = {0xfedcba9876543210ull, 0x00000000ffffffffull, 0x8000000180000001ull};
    for (int s = 0; s < 3; s++) {
        if (zero_extended(seeds[s], buf, 300) != zero_extended_ref(seeds[s], buf, 300))
            return 1 + s;
        if (zero_extended(seeds[s], buf, 0) != zero_extended_ref(seeds[s], buf, 0))
            return 4 + s;
        if (sign_extended(seeds[s], buf, 300) != sign_extended_ref(seeds[s], buf, 300))
            return 7 + s;
        if (sign_extended(seeds[s], buf, 0) != sign_extended_ref(seeds[s], buf, 0))
            return 10 + s;
        if (widened(seeds[s], buf, 300) != widened_ref(seeds[s], buf, 300))
            return 13 + s;
    }
    return 0;
}
