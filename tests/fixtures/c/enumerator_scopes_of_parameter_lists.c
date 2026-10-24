// An enumeration constant a prototype's parameter list declares has
// prototype scope; one a definition's parameter list or old-style
// declaration list declares has the scope of the function's block (C99
// 6.2.1p4). The exit status is the number of the first check that fails.
enum { A = 1, B = 1, K = 1, P = 1 };

void proto(enum { A = 2 } x);
void callback(void (*f)(enum { B = 3 } y));

static int def(enum { P = 4 } x) {
    return P + x;
}

static int old(k) enum { K = 5 } k; {
    return K + k;
}

int main(void) {
    if (A != 1 || B != 1)
        return 1;
    if (def(0) != 4 || P != 1)
        return 2;
    if (old(0) != 5 || K != 1)
        return 3;
    void inner(enum { A = 6 } z);
    if (A != 1)
        return 4;
    int D = 7;
    void shadowed(enum { D = 8 } w);
    if (D != 7)
        return 5;
    return 0;
}
