/* C99 6.6: the address of a multi-dimensional array element is an address
   constant. A subscript at level i strides by product(dims[i+1..]) *
   sizeof(element); the pointer-array initializer path must apply the full
   stride ladder, not the leaf element size alone. */

struct S {
    long b;
};
static struct S h[7][8][2];
static long *p[] = {&h[6][0][0].b, &h[3][1][0].b, &h[0][0][1].b};
static struct S g[5][4];
static struct S *q[] = {&g[4][0], &g[2][1]};

int main(void) {
    long base = (long)&h[0][0][0].b;
    if ((long)p[0] - base != (6L * 8 * 2) * (long)sizeof(struct S)) {
        return 1;
    }
    if ((long)p[1] - base != (3L * 8 * 2 + 1 * 2) * (long)sizeof(struct S)) {
        return 2;
    }
    if ((long)p[2] - base != 1L * (long)sizeof(struct S)) {
        return 3;
    }
    long gb = (long)&g[0][0];
    if ((long)q[0] - gb != (4L * 4) * (long)sizeof(struct S)) {
        return 4;
    }
    if ((long)q[1] - gb != (2L * 4 + 1) * (long)sizeof(struct S)) {
        return 5;
    }
    return 0;
}
