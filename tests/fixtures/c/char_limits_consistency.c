// CHAR_MIN / CHAR_MAX in <limits.h> must match plain char's signedness
// (C99 5.2.4.2.1): when plain char is unsigned, CHAR_MIN is 0 and CHAR_MAX
// is UCHAR_MAX; otherwise they equal SCHAR_MIN / SCHAR_MAX. The compiler
// predefines __CHAR_UNSIGNED__ exactly when plain char is unsigned, so the
// header's CHAR_* values must agree with the runtime signedness of a char
// that holds a high-bit value. A signed CHAR_MAX (127) on an unsigned-char
// target makes locale-aware code take the wrong branch (the failure that
// broke decimal locale-override handling on AArch64 ELF).

#include <limits.h>

int main(void) {
    // 0xFF in a plain char is negative iff char is signed.
    char c = (char)0xFF;
    if (c < 0) {
        if (CHAR_MIN != SCHAR_MIN || CHAR_MAX != SCHAR_MAX) return 1;
        if (CHAR_MIN != -128 || CHAR_MAX != 127) return 2;
    } else {
        if (CHAR_MIN != 0 || CHAR_MAX != UCHAR_MAX) return 3;
        if (CHAR_MIN != 0 || CHAR_MAX != 255) return 4;
    }
    return 0;
}
