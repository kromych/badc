/* C99 6.7.1: the specifiers of a declaration -- storage-class, type,
   type-qualifier, function-specifier -- may appear in any order. The
   parser consumed storage-class specifiers only ahead of the type, so a
   type-first order (`INTN STATIC f()`, the edk2 firmware form) was
   rejected with `identifier expected in declaration (got static)`. The
   file-scope and block-scope declaration parsers now also consume
   specifiers that trail the type. Comparisons check both the values and
   that internal-linkage (static) still applies. */

typedef long INTN;

INTN static file_fn(void) {              /* type before storage-class */
    return 7;
}

int static file_i = 3;                   /* type before storage-class */
unsigned const static int file_u = 5;    /* storage-class amid specifiers */
int const file_c = 9;                    /* qualifier after type */

static int block(void) {
    int static s = 4;                    /* block-scope, type first */
    unsigned static u = 6;               /* block-scope, type first */
    int const q = 2;                     /* block-scope qualifier after type */
    return s + (int)u + q;               /* 12 */
}

int main(void) {
    if (file_fn() != 7)
        return 1;
    if (file_i != 3)
        return 2;
    if (file_u != 5)
        return 3;
    if (file_c != 9)
        return 4;
    if (block() != 12)
        return 5;
    return 0;
}
