// C99 6.6 constant expressions admit the conditional operator
// `?:`. This is heavily relied on by the static-assert idiom
// `typedef char check[cond ? 1 : -1];` (miniz, sqlite, libpng,
// stb_*) -- a `false` conditional resolves to `-1`, which fails
// the array-dimension positivity check at compile time. c5 used
// to stop the constant-expression chain at logical-or, so the
// idiom hit "close bracket expected in array declarator" and
// every consumer was unbuildable. Now const-expr starts at
// `parse_const_expr_cond`, matching clang/gcc.
#include <stdlib.h>

typedef char check_int_4[sizeof(int) == 4 ? 1 : -1];
typedef char check_short_2[sizeof(short) == 2 ? 1 : -1];
typedef char check_char_1[sizeof(char) == 1 ? 1 : -1];
typedef char check_nested[(1 == 1 ? 2 : 9) == 2 ? 1 : -1];

enum E {
    A = 1 ? 5 : 7,
    B = 0 ? 5 : 7,
    C = (A > B ? A * 2 : B * 2),
};

int main(void) {
    int xs[1 ? 4 : 99];
    xs[0] = A; // 5
    xs[1] = B; // 7
    xs[2] = C; // 14
    xs[3] = sizeof(check_nested);
    return xs[0] + xs[1] + xs[2] + xs[3]; // 5 + 7 + 14 + 1 = 27
}
