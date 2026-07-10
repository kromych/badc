// A file-scope array declared with empty brackets and no initializer is
// a tentative definition (C99 6.9.2): if the type is still incomplete at
// the end of the translation unit it is completed to one element;
// otherwise a later declaration supplies the size. A real-world shape is
// a macro that expands to `static const char name[];`, often with no
// later declaration to complete it.

#include <stdio.h>

// Never completed -- becomes a one-element zero-filled array.
static const char never_completed[];
// Completed by a later defining declaration in the same unit.
static char completed[];
static char completed[] = "hello";

const char *take_never(void) { return never_completed; }

int main(void) {
    int fails = 0;
    if (never_completed[0] != 0) fails |= 1;
    if (take_never() != never_completed) fails |= 2;
    if (completed[0] != 'h') fails |= 4;
    for (int i = 0; "hello"[i]; i++) {
        if (completed[i] != "hello"[i]) fails |= 8;
    }
    if (fails) {
        printf("FAIL mask=%d\n", fails);
        return 1;
    }
    printf("ok\n");
    return 0;
}
