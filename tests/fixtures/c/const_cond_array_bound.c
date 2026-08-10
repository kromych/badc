/* C99 6.6p3: in a constant expression the operand not selected by a
   constant condition is not evaluated and need not itself be a constant
   expression. An array bound of this shape -- a constant condition with a
   non-constant unselected arm -- is a constant, not a C99 6.7.6.2 VLA.
   The `?:`, `||`, and `&&` short-circuit forms all apply. `nc` is declared
   but appears only in unselected arms, so it is never referenced. Sizes
   match gcc and clang; also checked at run time. */
int nc(void);

int a[__builtin_constant_p(32) ? 5 : nc()]; /* const-true condition -> 5 */
int b[0 ? nc() : 7];                        /* const-false condition -> 7 */
int c[(1 || nc()) ? 9 : nc()];              /* || short-circuits RHS -> 9 */
int d[(0 && nc()) + 11];                    /* && short-circuits RHS -> 11 */
int e[1 ? 2 ? 3 : nc() : nc()];             /* nested conditional -> 3 */

struct T {
    int m[__builtin_constant_p(64) ? 6 : nc()];
    int tail;
};

_Static_assert(sizeof(a) / sizeof(int) == 5, "a");
_Static_assert(sizeof(b) / sizeof(int) == 7, "b");
_Static_assert(sizeof(c) / sizeof(int) == 9, "c");
_Static_assert(sizeof(d) / sizeof(int) == 11, "d");
_Static_assert(sizeof(e) / sizeof(int) == 3, "e");
_Static_assert(sizeof(((struct T *)0)->m) / sizeof(int) == 6, "T.m");

int main(void) {
    if (sizeof(a) / sizeof(int) != 5) return 1;
    if (sizeof(b) / sizeof(int) != 7) return 2;
    if (sizeof(c) / sizeof(int) != 9) return 3;
    if (sizeof(d) / sizeof(int) != 11) return 4;
    if (sizeof(e) / sizeof(int) != 3) return 5;
    struct T t;
    if (sizeof(t.m) / sizeof(int) != 6) return 6;
    return 0;
}
