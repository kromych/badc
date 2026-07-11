// C99 6.5.2.5p4: a compound literal is an lvalue naming an unnamed object
// with automatic storage. Taking its address must work for a scalar type,
// not only for the struct and array forms. The scalar value was materialized
// as a pure rvalue, so `&(int){5}` was rejected with "bad address-of".

static int deref(int *p) { return *p; }

int main(void) {
    // Address of a scalar compound literal, then read it back.
    int *p = &(int){5};
    if (*p != 5) return 1;

    // The object is mutable through the pointer.
    *p = 10;
    if (*p != 10) return 2;

    // Passing the address to a function expecting `T *`.
    if (deref(&(int){9}) != 9) return 3;

    // Other scalar types.
    double *d = &(double){2.5};
    if (*d != 2.5) return 4;
    char *c = &(char){'A'};
    if (*c != 'A') return 5;

    // The initializer may be a run-time expression.
    int k = 3;
    int *q = &(int){k + 4};
    if (*q != 7) return 6;

    // `*&literal` round-trips to the value.
    if (*&(int){42} != 42) return 7;

    // The struct, array, and value-position forms are unchanged.
    struct P { int x, y; };
    struct P *sp = &(struct P){3, 4};
    if (sp->x + sp->y != 7) return 8;
    int (*ap)[3] = &(int[3]){1, 2, 3};
    if ((*ap)[2] != 3) return 9;
    if ((int){7} + 1 != 8) return 10;
    return 0;
}
