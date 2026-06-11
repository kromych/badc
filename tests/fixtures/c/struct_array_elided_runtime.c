// C99 6.7.8p20 brace elision for a struct-array element with a
// non-constant initializer. A flat value list fills consecutive struct
// elements without per-element braces; when any value is non-constant
// the runtime per-field store path fills each element's fields from the
// flat list, the same as the braced form. Braced and elided elements
// may be mixed.

struct P {
    int a, b;
};

int run(int x) {
    // Deferred size, fully brace-elided, non-constant values.
    struct P d[] = {x, x + 1, x + 2, x + 3};
    if (d[0].a != x || d[0].b != x + 1) return 1;
    if (d[1].a != x + 2 || d[1].b != x + 3) return 2;

    // Known size, mixing braced and elided elements.
    struct P k[3] = {{x, 2}, x + 3, x + 4, {7, 8}};
    if (k[0].a != x || k[0].b != 2) return 3;
    if (k[1].a != x + 3 || k[1].b != x + 4) return 4;
    if (k[2].a != 7 || k[2].b != 8) return 5;
    return 0;
}

int main(void) {
    for (int i = 0; i < 20; i++) {
        if (run(i)) return i + 1;
    }
    return 0;
}
