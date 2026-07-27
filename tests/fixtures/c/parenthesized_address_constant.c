/* C99 6.5.1p5: a parenthesized expression has the type and value of the
   expression, so `&(obj)` designates the same address as `&obj`. 6.5.3.2
   takes a unary-expression operand and 6.6p9 makes the result an address
   constant, valid wherever a static-storage object is initialized.
   6.3.2.1p4 makes `&func` and `func` the same value, and 6.5.6p8 scales a
   trailing `+ n` by the pointee size of the type the operand carries.

   Every form appears at file scope and again at block scope with `static`
   storage: both take the constant-expression path, and a divergence between
   them must fail here rather than pass at one scope. The compound literals
   of 6.5.2.5 are file-scope only -- at block scope the literal has automatic
   storage duration (6.5.2.5p5), so its address is not an address constant. */

struct s {
    int a;
    int b;
};

struct t {
    struct s in;
    int arr[4];
};

static struct s obj = {11, 22};
static struct t agg = {{33, 44}, {1, 2, 3, 4}};
static int arr[4] = {5, 6, 7, 8};
static int grid[2][3] = {{1, 2, 3}, {4, 5, 6}};

int fn(int x) {
    return x + 100;
}

static struct s *f_plain = &obj;
static struct s *f_paren = &(obj);
static struct s *f_paren2 = &((obj));
static int *f_member = &(obj.b);
static int *f_deep = &(agg.in.b);
static int *f_elem = &(arr[2]);
static int *f_aggelem = &(agg.arr[3]);
static int *f_grid = &(grid[1][2]);
static int (*f_whole)[4] = &(arr);
static int (*f_fnp)(int) = &(fn);
static struct s *f_plus = &(obj) + 1;
static int *f_memberplus = &(obj.a) + 1;
static char *f_castplus = (char *)&(obj) + 4;
static char *f_deref = (char *)&(*&obj);
static struct s *f_lit = &(struct s){77, 88};
static struct s *f_litgrp = &((struct s){99, 111});

static int check(void) {
    static struct s *b_plain = &obj;
    static struct s *b_paren = &(obj);
    static struct s *b_paren2 = &((obj));
    static int *b_member = &(obj.b);
    static int *b_deep = &(agg.in.b);
    static int *b_elem = &(arr[2]);
    static int *b_aggelem = &(agg.arr[3]);
    static int *b_grid = &(grid[1][2]);
    static int (*b_whole)[4] = &(arr);
    static int (*b_fnp)(int) = &(fn);
    static struct s *b_plus = &(obj) + 1;
    static int *b_memberplus = &(obj.a) + 1;
    static char *b_castplus = (char *)&(obj) + 4;
    static char *b_deref = (char *)&(*&obj);

    if (b_plain != &obj) return 21;
    if (b_paren != &obj || b_paren->a != 11) return 22;
    if (b_paren2 != &obj) return 23;
    if (b_member != &obj.b || *b_member != 22) return 24;
    if (b_deep != &agg.in.b || *b_deep != 44) return 25;
    if (b_elem != &arr[2] || *b_elem != 7) return 26;
    if (b_aggelem != &agg.arr[3] || *b_aggelem != 4) return 27;
    if (b_grid != &grid[1][2] || *b_grid != 6) return 28;
    if (b_whole != &arr || (*b_whole)[1] != 6) return 29;
    if (b_fnp != fn || b_fnp(2) != 102) return 30;
    if (b_plus != &obj + 1) return 31;
    if (b_memberplus != &obj.b) return 32;
    if (b_castplus != (char *)&obj.b) return 33;
    if (b_deref != (char *)&obj) return 34;
    return 0;
}

int main(void) {
    int rc;

    if (f_plain != &obj) return 1;
    if (f_paren != &obj || f_paren->a != 11) return 2;
    if (f_paren2 != &obj) return 3;
    if (f_member != &obj.b || *f_member != 22) return 4;
    if (f_deep != &agg.in.b || *f_deep != 44) return 5;
    if (f_elem != &arr[2] || *f_elem != 7) return 6;
    if (f_aggelem != &agg.arr[3] || *f_aggelem != 4) return 7;
    if (f_grid != &grid[1][2] || *f_grid != 6) return 8;
    if (f_whole != &arr || (*f_whole)[1] != 6) return 9;
    if (f_fnp != fn || f_fnp(1) != 101) return 10;
    if (f_plus != &obj + 1) return 11;
    if (f_memberplus != &obj.b) return 12;
    if (f_castplus != (char *)&obj.b) return 13;
    if (f_deref != (char *)&obj) return 14;
    if (f_lit->a != 77 || f_lit->b != 88) return 15;
    if (f_litgrp->a != 99 || f_litgrp->b != 111) return 16;

    rc = check();
    if (rc != 0) return rc;
    return 0;
}
