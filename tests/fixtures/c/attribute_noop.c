// Locks the predefined `__attribute__` / `__declspec` macro stubs.
//
// C99 has no `__attribute__` or `__declspec`; both are common
// implementation-defined extensions. The c5 preprocessor absorbs
// them as empty function-like macros so source that tags
// declarations with format-check / alignment / calling-convention
// hints still parses. The fixture exercises every position the
// stubs are expected to handle.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#include <stdarg.h>
#include <stdio.h>

// Prefix attribute on a function declaration.
__attribute__((noreturn))
static void noreturn_helper(int code);

// Postfix attribute on a function declaration (the GCC position).
static int sum_two(int a, int b) __attribute__((pure));

// Multiple attributes, nested parens, comma payload.
static int formatted(const char *fmt, ...)
    __attribute__((format(printf, 1, 2)));

// MSVC-style declspec on a struct.
__declspec(align(16)) struct aligned16 {
    int a;
    int b;
};

static int sum_two(int a, int b) {
    return a + b;
}

static int formatted(const char *fmt, ...) {
    (void)fmt;
    return 42;
}

static void noreturn_helper(int code) {
    (void)code;
}

int main(void) {
    if (sum_two(2, 3) != 5) return 11;
    if (formatted("%d %d", 1, 2) != 42) return 12;
    // The struct still parses and lays out its two ints; the c5
    // dialect ignores the alignment request, so sizeof is the
    // natural 8 bytes (two `int` fields). The stub's job is to
    // avoid corrupting the layout, not to honour the alignment.
    if (sizeof(struct aligned16) < 8) return 13;
    return 0;
}
