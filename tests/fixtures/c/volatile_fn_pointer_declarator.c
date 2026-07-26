/* A parenthesized declarator's pointer-level count is band arithmetic
   on the type tag, so a qualifier the inner declarator contributes must
   not enter the difference. `T (*volatile name)(args)` puts one there,
   and so does a qualified pointee in the return type. Losing the count
   drops the function-pointer lineage, and the C99 6.3.2.1p4 no-op `*`
   then loads through the code address. Arrays of such pointers take the
   same path via `(*arr[i])()`. */
static volatile int c41 = 41;
static volatile int c42 = 42;

static int r41(void) { return 41; }
static int r42(void) { return 42; }
static volatile int *p41(void) { return &c41; }
static volatile int *p42(void) { return &c42; }

static int (*volatile fp)(void) = r42;
static volatile int *(*fq)(void) = p41;
static volatile int *(*arr[2])(void) = {p41, p42};

int main(void) {
    if (fp() != 42) {
        return 1;
    }
    if ((*fp)() != 42) {
        return 2;
    }
    if (*fq() != 41) {
        return 3;
    }
    if (*(*fq)() != 41) {
        return 4;
    }
    if (*(*arr[0])() != 41 || *arr[1]() != 42) {
        return 5;
    }
    fp = r41;
    if (fp() != 41) {
        return 6;
    }
    return 0;
}
