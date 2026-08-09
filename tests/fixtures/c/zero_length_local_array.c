/* GCC zero-length array `T x[0]`: a complete type holding no elements, so
   `sizeof` is 0 and a `sizeof(x) != 0` guard is false. The declarator folds
   `[0]` to the same sentinel as a flexible array member (`T x[]`), which
   made a local one first rejected outright and then sized as one element --
   the guarded shape below then ran code the reference compilers drop.

   The trailing-member case is the flexible-array rule (C99 6.7.2.1p16) and
   is unchanged: the member is left out of the enclosing `sizeof`. */

struct pt { int x, y; };

static struct pt g_struct0[0];
static int g_int0[0];
static char g_char0[0];
static int g_after = 11;

struct fam { int n; char d[0]; };
struct fam_struct { int n; struct pt d[0]; };

static int guard_body_ran = 0;

static int sink(const void *p) {
    guard_body_ran = 1;
    return p != 0;
}

static int in_stmt_expr(void) {
    /* zero-length array inside a statement expression, as the macro uses */
    return ({ char z[0]; (void)z; 0; });
}

static int block_scope(void) {
    struct pt z[0];
    int i[0];
    char c[0];
    char rows[0][4];
    static struct pt s[0];
    int neighbour[3];

    if (sizeof z != 0 || sizeof i != 0 || sizeof c != 0)
        return 1;
    if (sizeof rows != 0 || sizeof s != 0)
        return 2;
    /* The shape the guarded-call idiom relies on. */
    if (sizeof z != 0 && sink(z))
        return 3;
    if (guard_body_ran)
        return 4;

    neighbour[0] = 5;
    neighbour[1] = 6;
    neighbour[2] = 7;
    /* An empty object still has an address of its own. */
    if ((const void *)z == (const void *)neighbour)
        return 5;
    if (neighbour[0] + neighbour[1] + neighbour[2] != 18)
        return 6;
    return 0;
}

int main(void) {
    int rc = block_scope();
    if (rc)
        return rc;

    if (sizeof g_struct0 != 0 || sizeof g_int0 != 0 || sizeof g_char0 != 0)
        return 7;
    if (sizeof g_struct0 != 0 && sink(g_struct0))
        return 8;
    if (guard_body_ran)
        return 9;
    /* A zero-size global must not have eaten the next object's storage. */
    if (g_after != 11)
        return 10;

    if (sizeof(struct fam) != sizeof(int))
        return 11;
    if (sizeof(struct fam_struct) != sizeof(int))
        return 12;
    if (__builtin_offsetof(struct fam, d) != sizeof(int))
        return 13;
    if (sizeof(int[0]) != 0)
        return 14;

    {
        struct pt p = { 1, 2 };
        char pad[2 * (int)sizeof(int) - (int)sizeof p];   /* 8 - 8 == 0 */
        if (sizeof pad != 0)
            return 15;
        if (in_stmt_expr() + (p.x + p.y - 3) != 0)
            return 16;
    }
    return 0;
}
