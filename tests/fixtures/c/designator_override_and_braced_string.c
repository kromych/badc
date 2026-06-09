// A duplicate designator re-initializes the whole subobject: the later
// `.d = { ... }` clears the array member before applying its values, so
// positions set only by the earlier initializer read as zero (C99
// 6.7.8p19 / p21). A character array may also be initialized by a
// brace-wrapped string literal (C99 6.7.8p14), including in a compound
// literal.

struct s {
    int a, b, c;
    char d[3];
    int e;
} g = {
    .a = 1,
    .b = 2,
    .d = {[0] = 3, [2] = 5},
    .d = {[0] = 4, [1] = 6},
};

char gstr[] = {"hello"};
char gbuf[8] = {"hi"};

int take(char *s) {
    return (s[0] == 'a' && s[1] == 'b' && s[2] == 'c' && s[3] == 0) ? 0 : 1;
}

int main(void) {
    // The second `.d` fully replaces the first: d == {4, 6, 0}.
    if (g.a != 1 || g.b != 2) return 1;
    if (g.d[0] != 4 || g.d[1] != 6 || g.d[2] != 0) return 2;

    // Brace-wrapped string at file scope.
    if (sizeof(gstr) != 6) return 3;
    if (gstr[0] != 'h' || gstr[4] != 'o' || gstr[5] != 0) return 4;
    if (sizeof(gbuf) != 8 || gbuf[0] != 'h' || gbuf[2] != 0) return 5;

    // Brace-wrapped string at block scope and in a compound literal.
    char l[] = {"world"};
    if (l[0] != 'w' || l[4] != 'd' || l[5] != 0) return 6;
    if (take((char[6]){"abc"}) != 0) return 7;

    return 0;
}
