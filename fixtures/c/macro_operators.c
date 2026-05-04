// M22 -- preprocessor stringification (#), token pasting (##), and
// variadic macros with __VA_ARGS__. The fixture keeps the test
// surface modest -- string equality is checked byte-by-byte because
// c5 doesn't have a bundled strcmp.

#include <stdio.h>

// Stringification: TURN_INTO_STRING(hello) expands to "hello".
#define TURN_INTO_STRING(x) #x

// Token pasting: PASTE(a, b) yields the identifier `ab`.
#define PASTE(a, b) a ## b

// Variadic with no fixed parameters: SUM_VA(...) expands to the args
// joined by ", " in c5's preprocessor. Using it inside a function
// call gives a regular comma-separated argument list.
#define SUM_VA(...) sum(__VA_ARGS__)

// Variadic with a fixed parameter plus the variadic tail.
#define LOG(level, ...) printf(level, __VA_ARGS__)

int sum(int a, int b, int c) {
    return a + b + c;
}

int main() {
    char *s;
    int paste_var;
    int va_total;

    // Stringification: the operator yields a literal "hello".
    s = TURN_INTO_STRING(hello);
    if (s[0] != 'h') return 1;
    if (s[1] != 'e') return 2;
    if (s[2] != 'l') return 3;
    if (s[3] != 'l') return 4;
    if (s[4] != 'o') return 5;
    if (s[5] != 0) return 6;

    // Token pasting: PASTE(paste, _var) -> paste_var (the local).
    PASTE(paste, _var) = 42;
    if (paste_var != 42) return 7;

    // Variadic with no fixed args.
    va_total = SUM_VA(1, 2, 3);
    if (va_total != 6) return 8;

    // Variadic with one fixed arg + tail.
    LOG("M22 OK: %d %d %d\n", 7, 8, 9);

    return 0;
}
