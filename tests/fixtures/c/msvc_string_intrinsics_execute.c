// MSVC's string intrinsics on x64, as <intrin.h> declares them: __stosb,
// __stosw, __stosd and __stosq store the value into `count` elements of
// their width, and __movsb, __movsw, __movsd and __movsq copy `count`
// elements, each through `rep stos` or `rep movs`; the elements past
// `count` keep their bytes. Elsewhere the program exits 0.

#if defined(_WIN32) && defined(__x86_64__)
#include <intrin.h>

static int all(const unsigned char *p, unsigned long long n, unsigned char v)
{
    while (n--)
        if (*p++ != v)
            return 0;
    return 1;
}

int main(void)
{
    unsigned char b[9];
    __stosb(b, 0x11, sizeof b);
    __stosb(b, 0xa5, 8);
    if (!all(b, 8, 0xa5) || b[8] != 0x11)
        return 1;
    unsigned short w[5] = {0};
    __stosw(w, 0xbeef, 4);
    if (w[0] != 0xbeef || w[3] != 0xbeef || w[4] != 0)
        return 2;
    unsigned long d[5] = {0};
    __stosd(d, 0xdeadbeefUL, 4);
    if (d[0] != 0xdeadbeefUL || d[3] != 0xdeadbeefUL || d[4] != 0)
        return 3;
    unsigned long long q[3] = {0};
    __stosq(q, 0x0102030405060708ULL, 2);
    if (q[0] != 0x0102030405060708ULL || q[1] != q[0] || q[2] != 0)
        return 4;
    __stosb(b, 0x33, 0);
    if (b[0] != 0xa5)
        return 5;

    unsigned char src[7] = {1, 2, 3, 4, 5, 6, 7}, dst[8] = {0};
    __movsb(dst, src, 7);
    for (int i = 0; i < 7; i++)
        if (dst[i] != src[i])
            return 6;
    if (dst[7] != 0)
        return 7;
    unsigned short ws[3] = {0x1111, 0x2222, 0x3333}, wd[4] = {0};
    __movsw(wd, ws, 3);
    if (wd[0] != 0x1111 || wd[2] != 0x3333 || wd[3] != 0)
        return 8;
    unsigned long ds[2] = {0x89abcdefUL, 0x01234567UL}, dd[3] = {0};
    __movsd(dd, ds, 2);
    if (dd[0] != ds[0] || dd[1] != ds[1] || dd[2] != 0)
        return 9;
    unsigned long long qs[2] = {~0ULL, 42}, qd[3] = {0};
    __movsq(qd, qs, 2);
    if (qd[0] != ~0ULL || qd[1] != 42 || qd[2] != 0)
        return 10;
    return 0;
}
#else
int main(void)
{
    return 0;
}
#endif
