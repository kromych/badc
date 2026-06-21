// A `\`-continued macro definition whose body contains a `/* */` block
// comment spanning a physical-line break, where the line that opens the
// comment carries no trailing `\`. C99 5.1.1.2: a newline inside a block
// comment is comment white space, not a logical-line terminator, so the
// macro definition continues across it. Mishandling this truncates the
// macro at the comment and leaks its tail as file-scope tokens.

#include <stdio.h>

#define SET_IF(cond, dst, val) \
    do { \
        if (cond) \
        { \
            /* The comment opens here with no trailing backslash
               and closes on the following line. */ \
            dst = (val); \
        } \
    } while (0)

int after_marker = 1234;

int main(void) {
    int x = 0;
    SET_IF(1, x, 7);
    SET_IF(0, x, 99);   /* leaves x unchanged */
    if (x != 7) return 1;
    if (after_marker != 1234) return 2;
    return 0;
}
