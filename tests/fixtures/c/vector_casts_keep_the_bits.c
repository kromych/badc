// GNU C vector extension: a cast between a vector and an integer of the same
// size, or between two vectors of the same size, keeps the bits, as gcc and
// clang define it. Every target here is little-endian: lane 0 is the low part.

typedef int v2si __attribute__((vector_size(8)));
typedef short v4hi __attribute__((vector_size(8)));
typedef unsigned char v4qu __attribute__((vector_size(4)));
typedef long long v2di __attribute__((vector_size(16)));
typedef int v4si __attribute__((vector_size(16)));

static v2si from_ll(long long q) {
    return (v2si)q;
}

static long long to_ll(v2si v) {
    return (long long)v;
}

static v4qu from_u(unsigned u) {
    return (v4qu)u;
}

static unsigned to_u(v4qu v) {
    return (unsigned)v;
}

int main(void) {
    v2si a = from_ll(0x0000000700000005LL);
    if (a[0] != 5 || a[1] != 7 || to_ll(a) != 0x0000000700000005LL)
        return 1;
    v4hi h = (v4hi)a;
    if (h[0] != 5 || h[1] != 0 || h[2] != 7 || h[3] != 0)
        return 2;
    if ((long long)(v2si){-1, 0} != 0xffffffffLL)
        return 3;
    if ((unsigned long long)(v2si){1, 2} != 0x0000000200000001ULL)
        return 4;
    v4qu b = from_u(0x04030201u);
    if (b[0] != 1 || b[3] != 4 || to_u(b) != 0x04030201u || sizeof b != 4)
        return 5;
    v4si w = (v4si)(v2di){0x100000002LL, 3};
    if (w[0] != 2 || w[1] != 1 || w[2] != 3 || w[3] != 0)
        return 6;
    return 0;
}
