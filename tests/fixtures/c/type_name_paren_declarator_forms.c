// Type names whose abstract declarator is parenthesized (C99 6.7.6) derive
// the same type in a constant initializer as in a block: an array of
// (const) pointers to function is an array compound literal of static
// storage (6.5.2.5p3) whose element is addressable in an address constant,
// and a declarator may sit in a redundant parenthesis, open with an
// attribute or apply to a function typedef. A parenthesis holding a type
// specifier and `*` is a parameter list. The exit status is the number of
// the first check that fails.
static int f1(void) { return 1; }
static int f2(void) { return 2; }
static int f3(int x) { return x + 3; }
static int a = 10, b = 20;
typedef int (*fp)(void);
typedef int fn(void);
static int s1(short *p) { return *p; }
static int u1(unsigned *p) { return (int)*p; }
static int apply(int (short *), short);
_Static_assert(__builtin_types_compatible_p(int (unsigned *), __typeof__(u1)), "a parameter list");

static int (*const *const t1)(void) = (int (*const[])(void)){f1, f2};
static int (**t2)(void) = (int (*[])(void)){f2, f1};
static int (*const *t3)(void) = (int (*const[3])(void)){f1, f2};
static int (*const *t4)(int) = (int (*const[])(int)){f3};
static fp const *t5 = (fp const[]){f2, f2};
static int *const *t6 = (int *const[]){&a, &b};
static int (*const *t7)(void) = &(int (*const[])(void)){f1, f2}[1];
static int (*(*t8)[2])(void) = &(int (*[1][2])(void)){{f1, f2}}[0];
static int (*const g9)(void) = (int ((*))(void))f2;
static int (*g10)(void) = (int (__attribute__((unused)) *)(void))f1;
static fn **g11 = (fn (*[2])){f1, f2};

int main(void) {
    int (*p)(void) = (int ((*))(void))f1;
    int (*const *q)(void) = (int (*const[])(void)){f2, f1};
    int (*r)(void) = (int (__attribute__((unused)) *)(void))f2;
    if (t1[0]() + t1[1]() != 3)
        return 1;
    if (t2[0]() + t2[1]() != 3)
        return 2;
    if (t3[0]() + t3[1]() != 3 || t3[2] != 0)
        return 3;
    if (t4[0](4) != 7)
        return 4;
    if (t5[0]() + t5[1]() != 4)
        return 5;
    if (*t6[0] + *t6[1] != 30)
        return 6;
    if (t7[0]() != 2)
        return 7;
    if ((*t8)[0]() + (*t8)[1]() != 3)
        return 8;
    if (g9() != 2)
        return 9;
    if (p() != 1)
        return 10;
    if (q[0]() + q[1]() != 3)
        return 11;
    if (g10() != 1)
        return 12;
    if (g11[0]() + 2 * g11[1]() != 5)
        return 13;
    if (apply(s1, 7) != 7)
        return 14;
    if (!__builtin_types_compatible_p(int (short *), __typeof__(s1)))
        return 15;
    if (r() != 2)
        return 16;
    return 0;
}

static int apply(int f(short *), short v) { return f(&v); }
