// C99 6.7.7p3 boundary: when a struct body that ends with an
// array-typedef field is itself wrapped in a `typedef struct {
// ... } NAME;`, the array-typedef carrier must not leak from
// the inner field into the outer declarator binding of `NAME`.
//
// Surface shape from MonoCypher:
//
//     typedef int fe[10];
//     typedef struct { fe X; fe Y; fe Z; fe T; } ge;
//     static void zero(ge *p) { p->X[0] = 0; }
//
// `ge` must bind as a struct typedef (array_size = 0). If the
// inner field T's `fe[10]` carrier leaks out, the outer
// `ge` symbol records array_size = 10 and a later `ge *p`
// parameter is misclassified, so `p->X` errors with `->
// requires a single-level struct pointer`.

typedef int fe[10];
typedef struct { fe X; fe Y; fe Z; fe T; int n; } ge;

static int zero_and_sum(ge *p) {
    int i;
    int s = 0;
    for (i = 0; i < 10; i++) {
        p->X[i] = i;
        p->Y[i] = i + 1;
        s += p->X[i] + p->Y[i];
    }
    p->n = s;
    return p->n;
}

int main(void) {
    ge g;
    int s = zero_and_sum(&g);
    // sum_i=0..9 (i + (i+1)) = (9*10/2) + (sum_i=0..9 (i+1))
    //                       = 45 + 55 = 100.
    if (s != 100) return 1;
    if (g.X[5] != 5) return 2;
    if (g.Y[5] != 6) return 3;
    if (g.n   != 100) return 4;
    return 0;
}
