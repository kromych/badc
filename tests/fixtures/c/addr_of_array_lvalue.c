// The address of an array-typed lvalue is a pointer to that array type
// (C99 6.5.3.2p3): a row of a multi-dimensional array, an array member
// and a row of one, a row of a pointer to an array and the array `*p`
// reaches, a string literal and a compound literal. An array parameter
// is a pointer (6.7.5.3p7), so its address is a pointer to a pointer.
// `sizeof`, `typeof`, the subscript stride, arithmetic and a comparison
// follow the type.
static int m[2][2] = {{1, 2}, {3, 4}};
static int t[2][3][4];
static int arr[3] = {1, 2, 3};
static int *q = arr + 1;
static int buf[3] = {0, 8, 9};
struct S { int a[3]; int mm[2][3]; int (*pa)[3]; };
struct F { int n; int fa[]; };
int (*pa)[2] = m;
int (*p3)[3][4] = t;

// `typeof` of a pointer difference is the difference's type, as the Linux
// kernel's ALIGN relies on.
#define ALIGN_UP(x, a) (((x) + ((__typeof__(x))(a) - 1)) & ~((__typeof__(x))(a) - 1))

static int through_params(int p[3], int q[][2], int r[2][3][4]) {
    if (sizeof(&p) != sizeof(int **) || sizeof(*&p) != sizeof(int *) || (&p)[0] != p)
        return 20;
    if (sizeof(*&q) != sizeof(int (*)[2]) || (&q)[0] != q)
        return 21;
    if (sizeof(*&r[1]) != sizeof(int[3][4]) || sizeof(*&r[1][2]) != sizeof(int[4]))
        return 22;
    if ((&r[1])[0][2][3] != 42 || (&r[1][2])[0][3] != 42)
        return 23;
    return 0;
}

static int both(int *a, int **b) { return a[0] + **b; }

int main(void) {
    struct S s = {{1, 2, 3}, {{1, 2, 3}, {4, 5, 6}}, 0};
    struct S *sp = &s;
    struct F *f = (struct F *)buf;
    int rc;
    s.pa = s.mm;
    t[1][2][3] = 42;
    t[0][2][3] = 7;

    if ((&m[1])[0][1] != 4 || (*&m[1])[1] != 4 || (**&m)[1] != 2)
        return 1;
    if (sizeof(&m[1]) != sizeof(int *) || sizeof(*&m[1]) != sizeof(int[2]) || sizeof(*&m) != sizeof m)
        return 2;
    if (sizeof(*&t[1]) != sizeof(int[3][4]) || sizeof(*&t[1][2]) != sizeof(int[4]) || sizeof(*&t) != sizeof t)
        return 3;
    if ((&t[1])[0][2][3] != 42 || (&t[1][2])[0][3] != 42 || (*&t[1])[2][3] != 42)
        return 4;
    if (sizeof(*&*m) != sizeof(int[2]) || (*&*m)[1] != 2)
        return 5;

    if ((&s.a)[0][2] != 3 || (&sp->a)[0][1] != 2 || sizeof(*&s.a) != sizeof(int[3]))
        return 6;
    if (sizeof(*&s.mm) != sizeof(int[2][3]) || sizeof(*&s.mm[1]) != sizeof(int[3]))
        return 7;
    if ((&s.mm[1])[0][2] != 6 || (&sp->mm[1])[0][2] != 6 || (*&sp->mm)[1][0] != 4)
        return 8;
    if (sizeof(*&s.pa[1]) != sizeof(int[3]) || (&s.pa[1])[0][1] != 5)
        return 9;
    if (sizeof(&f->fa) != sizeof(int *) || (*&f->fa)[1] != 9)
        return 10;

    if (sizeof(*&*pa) != sizeof(int[2]) || (&*pa)[1][0] != 3 || (&(*pa))[1][1] != 4)
        return 11;
    if (sizeof(*&pa[1]) != sizeof(int[2]) || (&pa[1])[0][1] != 4)
        return 12;
    if (sizeof(*&p3[1][1]) != sizeof(int[4]) || (&p3[1][2])[0][3] != 42 || (&(*p3)[1])[1][3] != 7)
        return 13;

    if (&m[1] - &m[0] != 1 || (char *)(&m[0] + 1) - (char *)m != sizeof(int[2]))
        return 14;
    if (&m[1] != &m[0] + 1 || (*(&m[0] + 1))[1] != 4 || (&t[0] + 1)[0][2][3] != 42)
        return 15;

    if (sizeof(*&"abc") != 4 || (*&"abc")[1] != 'b' || (&"abc")[0][2] != 'c')
        return 16;
    if (sizeof(*&(int[]){1, 2, 3}) != sizeof(int[3]) || (&(int[]){1, 2, 3})[0][2] != 3)
        return 17;

    {
        __typeof__(&m[1]) r = &m[1];
        __typeof__(*m) row;
        row[0] = 9;
        if ((*r)[1] != 4 || sizeof(*(__typeof__(&t[1]))0) != sizeof(int[3][4]))
            return 19;
        if (sizeof row != sizeof(int[2]) || row[0] != 9 || sizeof(!m) != sizeof(int))
            return 24;
        if (!__builtin_types_compatible_p(__typeof__(&m[1]), int (*)[2]))
            return 25;
        if (ALIGN_UP((char *)&m[1] - (char *)m, 16) != 16 || ALIGN_UP(m[1] - m[0], 4) != 4
            || sizeof(pa = m) != sizeof(int (*)[2]) || sizeof(__typeof__(m[0] + 1)) != sizeof(int *))
            return 27;
    }
    if (both(arr, &q) != 3)
        return 26;
    rc = through_params(arr, m, t);
    if (rc)
        return rc;
    return 0;
}
