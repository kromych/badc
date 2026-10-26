// A block-scope typedef of a variable-length array type (C99 6.7.7p2):
// its size expression is evaluated when the declaration is reached
// (6.7.7p3), so a later change to the bound leaves the type alone, and
// every object declared with the name is a variable-length array of that
// length, as are an alias of it and the pointee of a pointer to it. In a
// loop the typedef is evaluated again on each iteration. Returns 0 when
// every check passes; each failure returns a distinct code.

#include <stddef.h>

static int fill(char *p, int n) {
    for (int i = 0; i < n; i++) p[i] = (char)('a' + i);
    return p[n - 1] == (char)('a' + n - 1);
}

static int bound_at_declaration(int n) {
    typedef char U[n];
    int len = n;
    n += 5;
    U u;
    U *pu = &u;
    typedef U V;
    V v;
    if (sizeof(U) != (size_t)len || sizeof u != (size_t)len) return 1;
    if (sizeof *pu != (size_t)len || sizeof v != (size_t)len) return 2;
    if (!fill(u, len) || (*pu)[0] != 'a' || pu[0][len - 1] != u[len - 1]) return 3;
    if ((char *)(pu + 1) - (char *)pu != (ptrdiff_t)len) return 4;
    if (_Alignof(U) != 1 || sizeof(int[sizeof(U)]) != len * sizeof(int)) return 5;
    return 0;
}

static int per_iteration(void) {
    int total = 0;
    for (int i = 1; i <= 4; i++) {
        typedef int W[i];
        W w;
        for (int j = 0; j < i; j++) w[j] = j;
        total += (int)(sizeof w / sizeof w[0]) + w[i - 1];
    }
    return total;
}

int main(void) {
    int r = bound_at_declaration(3);
    if (r == 0) r = bound_at_declaration(40) * 10;
    if (r == 0 && per_iteration() != 16) r = 100;
    return r;
}
