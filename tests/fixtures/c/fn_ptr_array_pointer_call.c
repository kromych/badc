// A call through an element of a pointer to an array of function
// pointers, or of a pointer to function pointers: the subscript is
// `*(p + i)` (C99 6.5.2.1p2) and reaches the function pointer, so the
// call yields the declared return type -- a struct pointer included --
// and an explicit `*` on the element is the 6.3.2.1p4 no-op. A decayed
// array (an object or a member, one- or two-dimensional) keeps its
// element's depth through `*` and `[i]`, so `*arr` is the first element.

struct T {
    int a;
};
static struct T box = {7};
typedef struct T *sel_t(int, int);
static struct T *sel(int a, int b) {
    box.a = a * 10 + b;
    return &box;
}
static sel_t *arr[3] = {sel, sel, sel};

static int g(int a, int b) {
    return a * 10 + b;
}
typedef int fn_t(int, int);
static fn_t *tbl[3] = {g, g, g};
static fn_t *tbl2[2][3] = {{g, g, g}, {g, g, g}};
struct S {
    fn_t *fparr[3];
    fn_t *(*pfp)[3];
    fn_t *fparr2[2][3];
};

int main(void) {
    sel_t *(*pp)[3] = &arr;
    sel_t **pe = arr;
    if ((*pp)[1](2, 1) != &box) return 1;
    if ((*pp)[1](2, 1)->a != 21) return 2;
    if (pe[1](3, 4)->a != 34) return 3;
    if ((*(*pp)[2])(5, 6)->a != 56) return 4;
    if ((*pe[0])(7, 8)->a != 78) return 5;
    if (pp[0][1](1, 2) == 0) return 6;

    fn_t **qe = tbl;
    fn_t *(*qp)[3] = &tbl;
    fn_t *(*qp2)[2][3] = &tbl2;
    fn_t ***qee = &qe;
    if (qe[1](2, 1) != 21) return 7;
    if ((*qe[1])(2, 1) != 21) return 8;
    if ((*qp)[1](2, 1) != 21) return 9;
    if ((*(*qp)[1])(2, 1) != 21) return 10;
    if ((**qp)(2, 1) != 21) return 11;
    if ((*qp[0])(2, 1) != 21) return 12;
    if (qee[0][1](2, 1) != 21) return 13;
    if ((*qee[0][1])(2, 1) != 21) return 14;
    if ((***qee)(2, 1) != 21) return 15;
    if ((*qp2)[1][2](2, 1) != 21) return 16;
    if ((*(*qp2)[1][2])(2, 1) != 21) return 17;
    if ((*(*qp2)[1])(2, 1) != 21) return 18;

    if ((*tbl)(2, 1) != 21) return 19;
    if ((*tbl2[1])(2, 1) != 21) return 20;
    if ((**tbl2)(2, 1) != 21) return 21;
    if ((*tbl2[1][2])(2, 1) != 21) return 22;
    if ((*(tbl + 1))(2, 1) != 21) return 23;
    if ((**&tbl)(2, 1) != 21) return 24;

    struct S s = {{g, g, g}, &tbl, {{g, g, g}, {g, g, g}}};
    if (s.fparr[1](2, 1) != 21) return 25;
    if ((*s.fparr[1])(2, 1) != 21) return 26;
    if ((*s.fparr)(2, 1) != 21) return 27;
    if ((*s.pfp)[1](2, 1) != 21) return 28;
    if ((*s.fparr2[1])(2, 1) != 21) return 29;
    if ((**s.fparr2)(2, 1) != 21) return 30;
    if ((*(s.fparr + 1))(2, 1) != 21) return 31;
    return 0;
}
