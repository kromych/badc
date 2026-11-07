/* A comma whose operands are constant folds to its right operand in a
 * constant expression, and its discarded operand may be cast to void, as
 * gcc and clang accept under C99 6.6p10. */
char check(const void *s);

struct S { unsigned short len, max; const char *p; };

static const struct S s = { 3, ((void)sizeof(check("abc")), sizeof("abc")), "abc" };
static const struct S t = { (1, 2), ((void)0, 5) * 2, ((void)0, "xy") };
static int y;
static int *q = ((void)0, &y);
static int w = ((void)0, 2) * 3;
static int a[(1, 4)];
enum { E = ((void)0, 7) };
_Static_assert((0, 1), "comma");

int main(void) {
    int local = ((void)0, 4);
    if (s.max != 4 || local != 4 || s.p[0] != 'a') return 1;
    if (t.len != 2 || t.max != 10 || t.p[1] != 'y') return 2;
    if (q != &y || w != 6 || sizeof a != 4 * sizeof(int) || E != 7) return 3;
    switch (local) {
    case (1, 4): return 0;
    default: return 4;
    }
}
