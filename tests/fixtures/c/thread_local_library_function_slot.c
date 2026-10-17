/* A `_Thread_local` slot naming a C-library function holds the address a
 * static-storage slot and code take of it (C99 6.5.9p6), and calls it. */
#include <string.h>

typedef size_t (*lenfn)(const char *);

static _Thread_local lenfn t = strlen;
static lenfn s = strlen;

int main(void) {
    lenfn d = strlen;
    return !(t == s && t == d && t("abc") == 3 && s("ab") == 2);
}
