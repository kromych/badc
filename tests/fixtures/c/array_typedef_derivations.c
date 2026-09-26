// C99 6.7.7p3: a typedef name for an array type is that type, so the first
// derivation of a declarator applies to the whole array: `A *p` points to
// it, `A *v[2]` is an array of such pointers, `A (*pa)[2]` points to an
// array of two of them and `A *(*pf)(void)` points to a function returning
// one; only a declarator with no derivation has the array type itself.
// Each check exits with its own code; success returns 0.

typedef int A[3];
static A arr = {4, 5, 6};
static A two[2] = {{1, 2, 3}, {4, 5, 6}};
static A *gv[2] = {&arr, &two[0]};
typedef A *PA2[2];
typedef A *(*getter)(void);
static A *get(void) { return &arr; }
static int use_v(A *v[2]) { return (*v[1])[1]; }
static int use_cb(A *(*cb)(void)) { return (*cb())[2]; }

struct M {
    A *m[2];
    A *(*f)(void);
    int tail;
};

int main(void) {
    typedef A *PA;
    A *v[2] = {&arr, &two[1]};
    A (*w[2]) = {&two[0], &arr};
    A (*pa)[2] = &two;
    A *(pp) = &arr;
    A *(*pf)(void) = get;
    A *(*afp[2])(void) = {get, get};
    getter g = get;
    PA q = &arr;
    PA2 q2 = {&arr, &two[0]};
    struct M s = {{&arr, &two[1]}, get, 42};
    if (sizeof(v) != 2 * sizeof(void *) || (*v[1])[2] != 6) return 1;
    if (sizeof(w) != 2 * sizeof(void *) || (*w[0])[1] != 2) return 2;
    if (sizeof(*pa) != 2 * sizeof(A) || (*pa)[1][2] != 6) return 3;
    if (sizeof(pp) != sizeof(void *) || (*pp)[0] != 4) return 4;
    if (sizeof(*pf()) != sizeof(A) || (*pf())[1] != 5) return 5;
    if ((*afp[1]())[0] != 4) return 6;
    if ((*g())[2] != 6) return 7;
    if (sizeof(PA) != sizeof(void *) || (*q)[1] != 5) return 8;
    if (sizeof(PA2) != 2 * sizeof(void *) || (*q2[1])[2] != 3) return 9;
    if (sizeof(s.m) != 2 * sizeof(void *) || (*s.m[1])[0] != 4 || s.tail != 42) return 10;
    if ((*s.f())[1] != 5) return 11;
    if (use_v(gv) != 2 || use_cb(get) != 6) return 12;
    if (sizeof(gv) != 2 * sizeof(void *) || (*gv[1])[2] != 3) return 13;
    return 0;
}
