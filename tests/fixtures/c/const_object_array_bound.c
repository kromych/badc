// A `const`-qualified integer object with static storage folds its value
// in a later constant expression (C99 6.6 leaves this to the
// implementation; GCC/clang fold it), so a `const` used as an array bound
// yields a fixed array rather than a VLA -- and may then carry an
// initializer.

static const int A = 8;
static const unsigned long B = 100;
static char g1[A * 2 + 1];       /* 17 */
static int g2[B / 10];           /* 10 */

int main(void) {
    static const int C = 5;
    char s1[A + 1] = "";         /* 9 -- const bound with an initializer */
    int s2[C * C];               /* 25 -- block-scope static const */
    if (sizeof(g1) != 17) return 1;
    if (sizeof(g2) != 10 * (int) sizeof(int)) return 2;
    if (sizeof(s1) != 9) return 3;
    if (sizeof(s2) != 25 * (int) sizeof(int)) return 4;
    s1[0] = 'x';
    s2[24] = 7;
    if (s1[0] != 'x' || s2[24] != 7) return 5;
    return 0;
}
