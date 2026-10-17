/* A string literal initializes a character array wherever one is
 * initialized (C99 6.7.8p14, p15): a block-scope compound literal of
 * unknown size, which takes the string's length (p22), a member, bare,
 * braced or parenthesized, a row a string fills at a row boundary under
 * brace elision (p20), with constant and non-constant neighbours. Returns
 * 0. */
#include <string.h>
#include <wchar.h>

struct T {
    char m[4];
    int n;
};
struct W {
    wchar_t w[3];
    int n;
};
struct D {
    char m[2][3];
    int n;
};

static int literals(int x) {
    char *s = (char[]){"0123456789abcdef"};
    char *t = (char[]){"ZYXWVUTSRQPONMLK"};
    char (*p)[4] = &(char[]){"xyz"};
    char *pa = (char[]){("xyz")};
    char (*e1)[1] = &(char[]){"abc"[1]};
    char (*e2)[2] = &(char[]){"ab"[0], 'c'};
    char (*rows)[4] = (char[][4]){"ab", "cd"};
    char *cube = (char[][2][3]){{"ab", "cd"}, {"ef", {x}}}[1][1];
    __typeof__((char[]){"xyz"}) tv;
    if (strcmp(s, "0123456789abcdef") != 0 || strcmp(t, "ZYXWVUTSRQPONMLK") != 0) {
        return 1;
    }
    if (sizeof *p != 4 || (*p)[2] != 'z' || sizeof((char[]){"xyz"}) != 4 || sizeof tv != 4) {
        return 2;
    }
    if (pa[2] != 'z' || (*e1)[0] != 'b' || (*e2)[1] != 'c' || rows[1][1] != 'd') {
        return 3;
    }
    return cube[0] == x && cube[-3] == 'e' ? 0 : 4;
}

static int members(int x) {
    struct T a = {{"ab"}, x};
    struct T b = {("ab"), x};
    struct W w = {{L"ab"}, x};
    struct D d = {{"ab", "cd"}, x};
    struct D e = {"ab", x};
    static struct D f = {"ab", 5};
    char c[2][2][3] = {"ab", "cd", "ef", "gh"};
    char g[2][3] = {"ab", {x}};
    if (a.m[1] != 'b' || a.m[3] != 0 || a.n != x || b.m[1] != 'b' || b.n != x) {
        return 5;
    }
    if (w.w[1] != L'b' || w.w[2] != 0 || w.n != x || d.m[1][1] != 'd' || d.n != x) {
        return 6;
    }
    if (e.m[0][1] != 'b' || e.m[1][0] != x || e.n != 0 || f.m[1][0] != 5 || f.n != 0) {
        return 7;
    }
    return c[1][1][1] == 'h' && c[1][0][2] == 0 && g[0][1] == 'b' && g[1][0] == x ? 0 : 8;
}

int main(void) {
    int r = literals('q');
    return r ? r : members('q');
}
