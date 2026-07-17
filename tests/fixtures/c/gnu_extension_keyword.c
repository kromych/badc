// GCC `__extension__` is a no-op annotation that prefixes an
// expression or a declaration to suppress a GNU-extension diagnostic.
// The lexer skips it, so it carries no semantic effect and may appear
// in any of these positions.

#include <stdio.h>

__extension__ typedef long long ext_ll;

typedef void (*voidf)(void);

int main(void) {
    void *p = (void *) 0;
    // Expression position, including a pointer-to-function cast
    // as used under __GNUC__.
    voidf f = (__extension__ (voidf)(p));
    ext_ll x = __extension__ 5;
    int y = __extension__ (3 + 4);
    if (f != 0) return 1;
    if (x != 5) return 2;
    if (y != 7) return 3;
    printf("ext x=%lld y=%d\n", x, y);
    return 0;
}
