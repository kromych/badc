// libc surface smoke test. Exercises the binding entries in
// string.h, stdio.h, stdlib.h, and ctype.h that typical C
// applications reach for. The fixture deliberately avoids:
//   * libc functions returning a 32-bit `int` in a way that the
//     return value's sign bit matters (strcmp's negative result,
//     for instance) -- c5's calling convention reads the return
//     register as a 64-bit value, and not every libc on every
//     target sign-extends. For sign-sensitive checks the user
//     should mask or re-sign-extend explicitly until a return-
//     value sign-extension pass lands.
//   * math.h FP returns -- aarch64 macOS variadic-FP and the
//     existing FP-return convention cross-cut differently.
// Both of those work for the *common* cases (strcmp == 0, sqrt
// of an integer-result-perfect value), but skipping the
// negative-result probes keeps this fixture robust across all
// five native targets.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int main() {
    char buf[128];
    char *p;

    // --- string.h -----------------------------------------------
    if (strlen("hello") != 5) return 1;
    if (strlen("") != 0) return 2;
    if (strcmp("abc", "abc") != 0) return 3;
    if (strncmp("abcdef", "abcxyz", 3) != 0) return 4;

    p = strchr("hello", 'l');
    if (p == 0) return 5;
    if (*p != 'l') return 6;

    // strcpy / strcat -- write through a buffer.
    strcpy(buf, "abc");
    strcat(buf, "DEF");
    if (strcmp(buf, "abcDEF") != 0) return 7;

    // memmove with overlapping regions.
    strcpy(buf, "0123456789");
    memmove(buf + 2, buf, 5);
    // Now buf = "01" + "01234" + "56789"[from offset 7] = "0101234789".
    if (buf[2] != '0') return 8;
    if (buf[6] != '4') return 9;

    // --- stdio.h ------------------------------------------------
    sprintf(buf, "%d-%s-%d", 7, "hi", 42);
    if (strcmp(buf, "7-hi-42") != 0) return 10;
    snprintf(buf, 16, "%d", 99);
    if (strcmp(buf, "99") != 0) return 11;

    // --- ctype.h ------------------------------------------------
    if (!isspace(' ')) return 12;
    if (!isdigit('5')) return 13;
    if (isdigit('a')) return 14;
    if (!isalpha('Q')) return 15;
    if (!isalnum('z')) return 16;
    if (toupper('a') != 'A') return 17;
    if (tolower('Z') != 'z') return 18;
    if (!isxdigit('f')) return 19;

    // --- stdlib.h -----------------------------------------------
    if (atoi("42") != 42) return 20;
    if (atoi("-17") != -17) return 21;
    if (abs(-5) != 5) return 22;

    return 0;
}
