// <ctype.h>'s C99 `isblank` on the Windows targets, whose msvcrt.dll does
// not export it. The file compiles to nothing elsewhere; the native-link
// driver offers it like an archive member.

#ifdef _WIN32

#include <ctype.h>

// C99 7.4.1.3: in the "C" locale, only space and horizontal tab.
int isblank(int c) {
    return c == ' ' || c == '\t';
}

#endif
