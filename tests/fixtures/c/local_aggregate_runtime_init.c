// A local aggregate initializer may mix a runtime value read from a
// file-scope scalar (its stored value is not a constant expression,
// C99 6.6) with a string-literal char-array member that zero-fills its
// tail (C99 6.7.8p14). The address of a global stays a constant.

int g = 3;
int arr_src = 7;
char *label = "ok";

struct rec {
    int i;
    char s[10];
    int *p;
};

int main(void) {
    // Struct: field 0 is a runtime read of `g`; field 1 a string with
    // trailing zero-fill; field 2 the constant address of a global.
    struct rec b = {g, "hola", &g};
    if (b.i != 3) return 1;
    if (b.s[0] != 'h' || b.s[1] != 'o' || b.s[2] != 'l' || b.s[3] != 'a') return 2;
    if (b.s[4] != 0 || b.s[9] != 0) return 3;
    if (b.p != &g) return 4;

    // Array: a runtime global read sits beside constants.
    int xs[3] = {g, arr_src, 5};
    if (xs[0] != 3 || xs[1] != 7 || xs[2] != 5) return 5;

    // A bare global pointer read by value is runtime, too.
    char *m = label;
    if (m[0] != 'o' || m[1] != 'k') return 6;

    return 0;
}
