/* GCC zero-length array `T x[0]` as a local. The declarator folds `[0]`
   to the same sentinel as a flexible array member, so a local one was
   wrongly rejected ("declared with empty brackets needs an initializer").
   It is valid and empty; compile-time-assert idioms (e.g. a
   `char c[-offsetof(type, first_field)]` array, which is `[0]` for a
   first member) rely on it. */

static int in_stmt_expr(void) {
    /* zero-length array inside a statement expression, as the macro uses */
    return ({ char z[0]; (void)z; 0; });
}

int main(void) {
    char a[0];
    (void)a;

    int b[0];
    (void)b;

    struct pt { int x, y; } p = { 1, 2 };
    char pad[2 * (int)sizeof(int) - (int)sizeof p];   /* 8 - 8 == 0 */
    (void)pad;

    return in_stmt_expr() + (p.x + p.y - 3);
}
