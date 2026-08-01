// A function designator in a static initializer names the function's
// address only when it is the whole initializer. `f(...)` is a call, and
// a call the constant evaluator folds is a valid initializer (C99 6.6p6);
// consuming the name as an address left the argument list behind.
//
// Declaring the library functions is what made the difference: an
// undeclared name took the constant-evaluator path already.

#include <string.h>

static int two(void) { return 2; }
static int three(void) { return 3; }

static int (*fp)(void) = two;
static int (*tab[])(void) = {two, three};
struct holder {
    int (*f)(void);
    int n;
};
static struct holder h = {three, 4};

static const unsigned long len = __builtin_strlen("abcd");
static const int cmp = __builtin_strcmp("ab", "ab");

int main(void) {
    static const unsigned long block_len = __builtin_strlen("abc");
    if (fp() != 2) return 1;
    if (tab[0]() != 2 || tab[1]() != 3) return 2;
    if (h.f() != 3 || h.n != 4) return 3;
    if (len != 4) return 4;
    if (cmp != 0) return 5;
    if (block_len != 3) return 6;
    return 0;
}
