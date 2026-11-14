// C99 7.19.6.2: sscanf reads back what printf wrote -- every integer and
// floating conversion with its length modifiers, `long double` through
// `%Lf`, `%Lg` and `%La` in the target's format, strings, characters,
// scansets, `%n` and `*` -- and the count is the number of assignments, or
// EOF when the input ends first.

// snapshot-budget: exempt
#include <stdio.h>
#include <string.h>

int main(void) {
    char text[256], word[16], set[16], c, again[256];
    signed char hh = -100;
    short h = -12345;
    int i = -2147483647, n = 0, x = 0;
    long l = -1234567890L;
    long long ll = 9007199254740993LL;
    unsigned u = 4000000000u;
    unsigned long ul = 0xdeadbeefUL;
    float f = 0.1f;
    double d = 2.718281828459045;
    long double lf = 3.25L, lg = -1e-300L, la = 1.5L;
    void *p = (void *)0x1234;
    snprintf(text, sizeof text, "%hhd %hd %d %ld %lld %u %lx %o %.9g %.17g %Lf %Lg %La %s %c %p", hh,
             h, i, l, ll, u, ul, 0755, f, d, lf, lg, la, "word", 'q', p);
    printf("%s\n", text);
    signed char hh2;
    short h2;
    int i2, o2;
    long l2;
    long long ll2;
    unsigned u2;
    unsigned long ul2;
    float f2;
    double d2;
    long double lf2, lg2, la2;
    void *p2;
    int count = sscanf(text, "%hhd %hd %i %ld %lld %u %lx %o %f %lf %Lf %Lg %La %15s %c %p%n", &hh2,
                       &h2, &i2, &l2, &ll2, &u2, &ul2, &o2, &f2, &d2, &lf2, &lg2, &la2, word, &c,
                       &p2, &n);
    snprintf(again, sizeof again, "%hhd %hd %d %ld %lld %u %lx %o %.9g %.17g %Lf %Lg %La %s %c %p",
             hh2, h2, i2, l2, ll2, u2, ul2, o2, f2, d2, lf2, lg2, la2, word, c, p2);
    printf("%d %d %s\n", count, n == (int)strlen(text), strcmp(text, again) ? again : "same");
    count = sscanf("key=[abc] 12x", "key=[%15[^]]] %*d%c", set, &c);
    printf("%d %s %c\n", count, set, c);
    printf("%d %d %d ", sscanf("", "%d", &x), sscanf(" 7", "%*d%d", &x), sscanf("z", "%d", &x));
    printf("%d %d\n", sscanf("10 20", "%d %d %d", &i2, &o2, &x), sscanf("%5", "%%%d", &x));
    return 0;
}
