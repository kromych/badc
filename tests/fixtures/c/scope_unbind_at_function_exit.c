// C99 6.2.1p4: a binding made by a function's scope ends with that
// scope, and the file-scope name it hid becomes visible again. Every
// kind of inner binding the compiler tracks is exercised here over a
// file-scope object of the same name, and a later function reads that
// object back: a binding left in place would resolve the name to the
// inner declaration's frame slot instead.

int a = 11;
int b = 22;
int c = 33;
int d = 44;
int e = 55;
int m = 88;
int n = 99;

enum { h = 77 };

// Prototype parameters are bound while the parameter list is parsed and
// unbound at the declarator's `;` or `,`.
int use_m(int m);
int use_n(int n, int a), use_n2(int n, int b);

// Function-type typedef: its parameter names have no scope at all.
typedef int cmp_fn(int c, int d);

int by_param(int a) { return a; }

int by_local(void) {
    int b = 1;
    return b;
}

int by_block(void) {
    {
        int c = 2;
        if (c != 2) return -1;
    }
    return 2;
}

int by_static(void) {
    static int d = 3;
    return d;
}

int by_typedef(void) {
    typedef int e;
    e v = 4;
    return v;
}

int by_extern_over_enum(void) {
    extern int h;
    return 5;
}

int use_m(int m) { return m; }
int use_n(int n, int a) { return n + a; }
int use_n2(int n, int b) { return n + b; }

int main(void) {
    if (by_param(1) != 1) return 1;
    if (by_local() != 1) return 2;
    if (by_block() != 2) return 3;
    if (by_static() != 3) return 4;
    if (by_typedef() != 4) return 5;
    if (by_extern_over_enum() != 5) return 6;
    // The file-scope objects must be visible again with their own values.
    if (a != 11) return 7;
    if (b != 22) return 8;
    if (c != 33) return 9;
    if (d != 44) return 10;
    if (e != 55) return 11;
    if (m != 88) return 12;
    if (n != 99) return 13;
    if (h != 77) return 14;
    if (use_m(m) != 88) return 15;
    if (use_n(n, a) != 110) return 16;
    if (use_n2(n, b) != 121) return 17;
    return 0;
}
