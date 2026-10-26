// <wordexp.h>: wordexp splits on blanks and keeps a quoted field whole,
// WRDE_DOOFFS leaves we_offs null slots ahead of the words, WRDE_APPEND
// adds to an earlier expansion, and WRDE_NOCMD refuses a command
// substitution with WRDE_CMDSUB, in each C library's numbering.
#define _XOPEN_SOURCE 700
#include <stddef.h>
#include <string.h>
#include <wordexp.h>

int main(void) {
    wordexp_t we;

#ifdef __APPLE__
    if (WRDE_APPEND != 1 || WRDE_DOOFFS != 2 || WRDE_CMDSUB != 3 || WRDE_NOSYS != 5) return 1;
#else
    if (WRDE_DOOFFS != 1 || WRDE_APPEND != 2 || WRDE_CMDSUB != 4 || WRDE_NOSYS != -1) return 1;
#endif
    if (sizeof(wordexp_t) != 3 * sizeof(size_t) || offsetof(wordexp_t, we_offs) != 2 * sizeof(size_t))
        return 2;
    if (wordexp("one  two 'three four'", &we, 0) != 0) return 3;
    if (we.we_wordc != 3 || strcmp(we.we_wordv[2], "three four") != 0) return 4;
    if (wordexp("five", &we, WRDE_APPEND) != 0) return 5;
    if (we.we_wordc != 4 || strcmp(we.we_wordv[3], "five") != 0 || we.we_wordv[4]) return 6;
    wordfree(&we);
    we.we_offs = 2;
    if (wordexp("x y", &we, WRDE_DOOFFS) != 0) return 7;
    if (we.we_wordc != 2 || we.we_wordv[0] || we.we_wordv[1] || strcmp(we.we_wordv[3], "y") != 0)
        return 8;
    wordfree(&we);
    if (wordexp("a $(echo b) c", &we, WRDE_NOCMD) != WRDE_CMDSUB) return 9;
    return 0;
}
