/* A file-scope compound literal has static storage (C99 6.5.2.5p6), so
 * its address, and that address plus an integer constant, is an address
 * constant (6.6p9). A character array literal of unknown size initialized
 * from a string literal, bare, braced or parenthesized, takes the string's
 * size; a bound stands (6.7.8p14, p22). A string that only begins an
 * element is an element, and a string at a row boundary fills the row.
 * Returns 0. */
#include <wchar.h>

char *p = (char[]){"xyz"};
char *q = (char[]){1, 2, 3} + 2;
static const char *r = (const char[]){"ab"} + 1;
static int *s = (int[]){4, 5, 6} + 1;
static char *t = 1 + (char[]){"xy"};
static char (*u)[4] = &(char[]){"xyz"};
struct H {
    char *p;
    int n;
};
static struct H h = {(char[]){"hi"}, 2};
static char *v = (char[4]){"ab"};
static char (*b3)[3] = &(char[3]){"abc"};
static char (*b8)[8] = &(char[8]){"abcdefgh"};
static char (*pa)[4] = &(char[]){("xyz")};
static char (*e1)[1] = &(char[]){"abc"[1]};
static char (*e2)[2] = &(char[]){"ab"[0], 'c'};
static char (*rows)[4] = (char[][4]){"ab", "cd"} + 1;
static char (*cube)[2][3] = (char[][2][3]){"ab", "cd", "ef"};
static wchar_t (*wa)[3] = &(wchar_t[]){L"ab"};
static wchar_t **wp = (wchar_t *[]){L"a", L"b"} + 1;
static int n = sizeof((char[]){"xyz"});
static __typeof__((char[]){"xyz"}) tv;

int main(void) {
    if (p[1] != 'y' || p[3] != 0 || *q != 3 || *r != 'b' || *s != 5 || *t != 'y') {
        return 1;
    }
    if ((*u)[2] != 'z' || sizeof *u != 4 || h.p[1] != 'i' || h.n != 2) {
        return 2;
    }
    if (v[1] != 'b' || v[2] != 0 || v[3] != 0) {
        return 3;
    }
    if (sizeof *b3 != 3 || (*b3)[2] != 'c' || sizeof *b8 != 8 || (*b8)[7] != 'h') {
        return 4;
    }
    if ((*pa)[2] != 'z' || (*e1)[0] != 'b' || (*e2)[0] != 'a' || (*e2)[1] != 'c') {
        return 5;
    }
    if (rows[0][1] != 'd' || rows[-1][0] != 'a' || cube[1][0][1] != 'f' || cube[1][1][0] != 0) {
        return 6;
    }
    if ((*wa)[1] != L'b' || (*wa)[2] != 0 || wp[0][0] != L'b' || wp[-1][0] != L'a') {
        return 7;
    }
    return n == 4 && sizeof tv == 4 ? 0 : 8;
}
