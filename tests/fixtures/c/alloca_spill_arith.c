/* A single function that both calls alloca (making it dynamic-sp) and
   carries a wide live set of integers through arithmetic and
   comparisons, so the allocator parks operands in spill slots. Once
   alloca moves the stack pointer, those slots must be read through the
   frame pointer; an sp-relative read would take the wrong bytes. Values
   are seeded from the alloca'd buffer so nothing folds away. Exercised
   at -O0 and -O and under BADC_MAX_GPR=2 BADC_MAX_FPR=2. Returns 42. */
#include <alloca.h>

int main(void) {
    long n = 1L << 16;
    unsigned char *p = (unsigned char *)alloca(n);
    p[0] = 1;
    p[1] = 2;
    p[2] = 3;
    p[3] = 4;
    p[4] = 5;
    p[5] = 6;
    p[n - 1] = 7;

    long a = p[0], b = p[1], c = p[2], d = p[3], e = p[4], f = p[5];
    long g = a + b, h = c + d, i = e + f;
    long j = g * 3, k = h * 5, l = i * 7;
    long m = (g < h) ? j : k;
    long o = (h < i) ? k : l;
    long q = (i < g) ? l : j;
    long sum = a + b + c + d + e + f + g + h + i + j + k + l + m + o + q;
    long cmp = (a < b) + (b < c) + (c < d) + (d < e) + (e < f)
             + (g > h) + (h > i) + (j != k) + (k != l) + (l != j);
    long r = sum + cmp;

    /* Read the written bytes back after all the arithmetic; the spilled
       values above must still be intact. alloca storage is not zeroed,
       so only the bytes written above are checked. */
    long ends = (long)p[0] + (long)p[n - 1];
    long mid = (long)p[2] + (long)p[3];

    /* a..f=1..6: g=3 h=7 i=11 j=9 k=35 l=77; m=9 o=35 q=9;
       sum=21+21+121+53=216; cmp=5+0+3=8; r=224. ends=1+7=8; mid=3+4=7. */
    return (r == 224 && ends == 8 && mid == 7) ? 42 : 1;
}
