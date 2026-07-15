// A static helper that writes through a pointer parameter inlines at -O:
// with no aggregate parameter or return, the splice reproduces the store
// against the caller's pointer argument. Exercises a setter, an in-place
// mutator, and a swap (whose local `t` is a value, not an address-taken
// slot), then checks the inlined stores hit the right addresses in order.

struct point {
    int x, y, z;
};

static void set_x(struct point *p, int v) { p->x = v; }
static void addto(int *p, int v) { *p += v; }
static void swap2(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

int main(void) {
    struct point p = {1, 2, 3};
    set_x(&p, 40);      /* x = 40 */
    addto(&p.y, 5);     /* y = 7 */
    addto(&p.z, -1);    /* z = 2 */
    swap2(&p.x, &p.z);  /* x <-> z : x = 2, z = 40 */
    if (p.x != 2) return 1;
    if (p.y != 7) return 2;
    if (p.z != 40) return 3;

    int a[4] = {0, 0, 0, 0};
    for (int i = 0; i < 4; i++) addto(&a[i], i * 10 + 1);
    if (a[0] != 1 || a[1] != 11 || a[2] != 21 || a[3] != 31) return 4;
    return 0;
}
