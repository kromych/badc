/* C99 6.7.8: a multi-dimensional automatic-storage array may carry
   non-constant element initializers (e.g. the address of a local). The
   per-element runtime store path recurses into nested braces and honors
   brace elision; omitted trailing positions are zero (6.7.8p21). */

int main(void) {
    int x = 5, y = 6, z = 7, w = 8;

    /* full nested braces */
    int *a[2][2] = {{&x, &y}, {&z, &w}};
    if (*a[0][0] != 5 || *a[0][1] != 6 || *a[1][0] != 7 || *a[1][1] != 8) {
        return 1;
    }

    /* brace elision: the flat list fills row-major */
    int *b[2][2] = {&x, &y, &z, &w};
    if (*b[1][0] != 7 || *b[1][1] != 8) {
        return 2;
    }

    /* partial rows: omitted trailing positions are zero */
    int *c[2][3] = {{&x}, {0, &y}};
    if (c[0][1] != 0 || c[0][2] != 0 || *c[1][1] != 6 || c[1][2] != 0) {
        return 3;
    }

    /* three dimensions */
    int *d[2][1][2] = {{{&x, 0}}, {{0, &w}}};
    if (d[0][0][0] != &x || d[1][0][1] != &w || d[0][0][1] != 0) {
        return 4;
    }

    return 0;
}
