// C99 6.7.8p13: an automatic-storage array of structs may carry
// non-constant element initializers, each initialized as if by
// assignment in declaration order. A deferred-size array (`v[]`)
// whose element field takes the address of a local is the case
// the constant stage-into-data path cannot represent; it must
// route to per-element runtime stores. Omitted entries are zeroed
// (6.7.8p19).

struct V {
    char *n;
    int *p;
};

int main(void) {
    int x = 7, y = 9;
    struct V v[] = {{"x", &x}, {"y", &y}};
    if (*v[0].p != 7) return 1;
    if (*v[1].p != 9) return 2;
    if (v[0].n[0] != 'x') return 3;
    if (v[1].n[0] != 'y') return 4;
    // Mutating through the stored address is visible at the source.
    *v[0].p = 11;
    if (x != 11) return 5;
    return 0;
}
