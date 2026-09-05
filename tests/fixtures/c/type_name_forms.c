// C99 6.7.6 type names in every position that reads one: a cast, `sizeof`,
// `_Alignof`, a `_Generic` association and `va_arg`, with abstract
// declarators of pointer, array, pointer-to-array and function-pointer
// shape and qualifiers before and after the `*`. Each check exits with
// its own code; success returns 0.

#include <stdarg.h>

struct s {
    int a;
    char b;
};

typedef int row[3];

static int rows[2][3] = {{1, 2, 3}, {4, 5, 6}};

static void touch(int x) { (void)x; }
static int add1(int x) { return x + 1; }

// Each pair of variadic arguments is a string and a function pointer,
// read back through type names with abstract declarators.
static long sum_va(int n, ...) {
    va_list ap;
    long total = 0;
    va_start(ap, n);
    while (n-- > 0) {
        const char *s = va_arg(ap, const char *);
        int (*f)(int) = va_arg(ap, int (*)(int));
        int (*r)[3] = va_arg(ap, int (*)[3]);
        total += f((int)s[0]) + (*r)[1];
    }
    va_end(ap);
    return total;
}

int main(void) {
    int arr[3] = {7, 8, 9};
    void *p = rows;

    int (*rp)[3] = (int (*)[3])p;
    if (rp[1][2] != 6) return 1;
    if ((*rp)[1] != 2) return 2;
    row *tp = (row *)p;
    if (tp[1][0] != 4) return 3;

    void (*fp)(int) = (void (*)(int))touch;
    fp(1);
    int (*ap1)(int) = (int (*)(int))add1;
    if (ap1(1) != 2) return 4;

    const char *const words[] = {"ab", "cd"};
    const char *const *w = (const char *const *)words;
    if (w[1][0] != 'c') return 5;

    unsigned long ul = (unsigned long const)-1;
    if (ul != (unsigned long)-1) return 6;
    if ((unsigned long volatile)3 != 3) return 7;

    if (sizeof(int[4][2]) != 8 * sizeof(int)) return 8;
    if (sizeof(int (*)[4]) != sizeof(void *)) return 9;
    if (sizeof(row[2]) != 6 * sizeof(int)) return 10;
    if (sizeof(row *) != sizeof(void *)) return 11;
    if (sizeof(int[3]) != sizeof arr) return 12;
    if (_Alignof(struct s *) != _Alignof(void *)) return 13;
    if (_Alignof(struct s) != _Alignof(int)) return 14;
    if (_Alignof(int[4]) != _Alignof(int)) return 15;
    if (_Alignof(row) != _Alignof(int)) return 16;

    // 6.5.1.1: the controlling expression undergoes lvalue and
    // array-to-pointer conversion, so an array type name never matches.
    if (_Generic(arr, int[3]: 1, int *: 2, default: 0) != 2) return 17;
    if (_Generic(rp, int (*)[3]: 1, default: 0) != 1) return 18;
    if (_Generic(tp, row *: 1, default: 0) != 1) return 19;
    if (_Generic(fp, void (*)(int): 1, int (*)(int): 2, default: 0) != 1) return 20;
    if (_Generic(ap1, void (*)(int): 1, int (*)(int): 2, default: 0) != 2) return 21;
    if (_Generic(touch, void (*)(int): 1, default: 0) != 1) return 22;
    if (_Generic(w, const char *const *: 1, char **: 2, default: 0) != 1) return 23;

    if (sum_va(2, "a", add1, rows, "b", add1, rows + 1) !=
        ('a' + 1 + 2) + ('b' + 1 + 5))
        return 24;
    return 0;
}
