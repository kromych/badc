// A variadic function pointer declared with an initializer (or through a
// typedef) keeps its variadic prototype: an indirect call through it must
// place the variadic arguments per the host variadic ABI, not as fixed
// register arguments. The declarator captures the prototype before the
// initializer's cast runs a base-type parse that would otherwise clear it.
// quickjs's std.sprintf reaches this via `int (*f)(DynBuf*, const char*,
// ...) = (void*)dbuf_printf;`.

#include <stdarg.h>

static int vsum(int *acc, int n, ...) {
    va_list ap;
    va_start(ap, n);
    int s = 0;
    for (int k = 0; k < n; k++)
        s += va_arg(ap, int);
    va_end(ap);
    *acc = s;
    return 0;
}

typedef int (*vfp)(int *, int, ...);

int main(void) {
    int (*fp)(int *, int, ...) = (void *)vsum; // initializer
    int acc = -1;
    fp(&acc, 2, 100, 23);
    if (acc != 123) return 1;

    vfp gp = (void *)vsum; // typedef + initializer
    acc = -1;
    gp(&acc, 3, 50, 70, 3);
    if (acc != 123) return 2;

    return 0;
}
