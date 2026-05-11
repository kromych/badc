// C99 7.19/7.20/7.21 specify that <stdio.h>, <stdlib.h>, and
// <string.h> each expose `size_t`. Real-world C code routinely
// takes `size_t` parameters after `#include <stdlib.h>` without
// pulling `<stddef.h>` itself; before this fix c5 hid `size_t`
// behind `<stddef.h>` alone, so `void f(const size_t n)` died
// at "type expected" the moment it landed in a parameter list.
#include <stdio.h>   // exposes size_t
#include <stdlib.h>  // also exposes size_t
#include <string.h>  // also exposes size_t

static int seen = 0;
static void f_stdio(size_t n)         { (void)n; seen++; }
static void f_stdlib(const size_t n)  { (void)n; seen++; }
static void f_string(unsigned int x, const size_t n) { (void)x; (void)n; seen++; }

int main(void) {
    f_stdio(1);
    f_stdlib(2);
    f_string(3, 4);
    return seen; // 3
}
