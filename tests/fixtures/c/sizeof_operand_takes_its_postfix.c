/* The operand of `sizeof` is a unary-expression (C99 6.5.3.4): a call, a
 * subscript or a postfix increment after the name belongs to it, so
 * `sizeof h(1)` is the size of `int` and neither the call nor the increment
 * is evaluated, in code and in constant expressions alike. Returns 0. */
static int calls;
static int h(int x) { return calls += x; }
static int (*fp)(int) = h;
static char arr[3][5];
static char (*rowp(void))[5] {
    calls++;
    return arr;
}
static const unsigned long k = sizeof h(1);
enum { E = sizeof fp(2) };
_Static_assert(sizeof (h)(3) == sizeof(int), "the size of the call");

int main(void) {
    long x = 5;
    char c = 1;
    unsigned long a = sizeof h(1), b = sizeof fp(1), d = sizeof (fp)(1);
    unsigned long e = sizeof x++, f = sizeof c--, g = sizeof (c)++;
    unsigned long r = sizeof rowp()[0], s = sizeof arr + 1, t = sizeof (arr) - 1;
    if (a != sizeof(int) || b != sizeof(int) || d != sizeof(int) || k != sizeof(int) ||
        E != sizeof(int)) {
        return 1;
    }
    if (e != sizeof(long) || f != 1 || g != 1 || x != 5 || c != 1) {
        return 2;
    }
    if (r != 5 || s != 16 || t != 14 || calls != 0) {
        return 3;
    }
    return 0;
}
