// A program that declares POSIX `strnlen`, BSD `strsep`, `strlcpy` and
// `strlcat`, C99 `isblank` and XSI `isascii` / `toascii` itself, without
// <string.h> or <ctype.h>, links each to the C library or to a definition
// the link supplies, as a configure link probe does; on Linux glibc's
// `mempcpy` too. Exits 0 when each returns what its interface specifies.

#include <stddef.h>

size_t strnlen(const char *s, size_t maxlen);
char *strsep(char **stringp, const char *delim);
size_t strlcpy(char *dst, const char *src, size_t size);
size_t strlcat(char *dst, const char *src, size_t size);
int isblank(int c);
int isascii(int c);
int toascii(int c);
#ifdef __linux__
void *mempcpy(void *dst, const void *src, size_t n);
#endif

static int same(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++;
        b++;
    }
    return *a == *b;
}

int main(void) {
    char buf[8];
    char line[] = "a,b;c";
    char *rest = line;
    if (strnlen("abcdef", 4) != 4 || strnlen("ab", 4) != 2)
        return 1;
    if (strlcpy(buf, "abcdefghij", sizeof buf) != 10 || !same(buf, "abcdefg"))
        return 2;
    if (strlcpy(buf, "ab", sizeof buf) != 2 || strlcat(buf, "cdefgh", sizeof buf) != 8 ||
        !same(buf, "abcdefg"))
        return 3;
    if (strlcat(buf, "xy", 4) != 6 || !same(buf, "abcdefg"))
        return 4;
    if (!same(strsep(&rest, ",;"), "a") || !same(strsep(&rest, ",;"), "b"))
        return 5;
    if (!same(strsep(&rest, ",;"), "c") || rest != 0 || strsep(&rest, ",") != 0)
        return 6;
    if (!isblank(' ') || !isblank('\t') || isblank('\n') || isblank('a'))
        return 7;
    if (!isascii(0x7f) || isascii(0x80) || isascii(-1) || toascii(0x1c1) != 0x41)
        return 8;
#ifdef __linux__
    if ((char *)mempcpy(buf, "xyz", 3) != buf + 3 || buf[0] != 'x' || buf[3] != 'd')
        return 9;
#endif
    return 0;
}
