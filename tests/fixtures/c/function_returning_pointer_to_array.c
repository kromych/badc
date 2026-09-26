// C99 6.7.5.3p1 forbids a function returning an array, not one returning a
// pointer to an array: in `T (*f(void))[N]` the group holds f's parameter
// list and the suffix derives the array its result points to. Such a group
// declares a function at block scope too, and one with no suffix returns
// the plain pointer its `*`s spell. Each check exits with its own code;
// success returns 0.

static int arr[3] = {7, 8, 9};
static int grid[2][3] = {{1, 2, 3}, {4, 5, 6}};
static int x = 5;
static int *px = &x;
static double half(double v) { return v / 2; }
static double (*fns[3])(double) = {half, half, half};
static int twice(int v) { return 2 * v; }

int (*mki(void))[3] { return &arr; }
static int (*mk2(void))[2][3] { return &grid; }
double (*(*mkf(void))[3])(double) { return &fns; }
static int *(*h(void)) { return &px; }
static int (*k(void)) { return &x; }

int main(void) {
    int (*mkl(void))[3];
    int (*sig(int))(int);
    int (*(*pfa)(void))[3] = mki;
    if ((*mki())[1] != 8) return 1;
    if (sizeof(*mki()) != 3 * sizeof(int)) return 2;
    if ((*mk2())[1][2] != 6 || sizeof(*mk2()) != 6 * sizeof(int)) return 3;
    if ((*mkf())[1](4) != 2) return 4;
    if (sizeof(*mkf()) != 3 * sizeof(void *)) return 5;
    if (**h() != 5) return 6;
    if (*k() != 5) return 7;
    if ((*mkl())[2] != 9 || mkl() != mki()) return 8;
    if (sig(1)(4) != 8) return 9;
    if ((*pfa())[0] != 7 || sizeof(*pfa()) != 3 * sizeof(int)) return 10;
    return 0;
}

int (*mkl(void))[3] { return &arr; }
int (*sig(int s))(int) { return s ? twice : 0; }
