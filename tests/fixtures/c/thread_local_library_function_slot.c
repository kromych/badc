/* A `_Thread_local` slot naming a C-library function holds the address a
 * static-storage slot naming it holds (C99 6.5.9p6), and calls it. */
#include <string.h>

typedef size_t (*lenfn)(const char *);

static _Thread_local lenfn t = strlen;
static lenfn s = strlen;

int main(void) { return !(t == s && t("abc") == 3 && s("ab") == 2); }
