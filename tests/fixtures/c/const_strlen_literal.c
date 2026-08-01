// `strlen` / `__builtin_strlen` of a string literal is an integer
// constant expression for gcc and clang, so it can size an array or
// carry a `_Static_assert`. The count stops at the first NUL, as the
// library function does, which is what makes
//
//     _Static_assert(sizeof(S) - 1 == strlen(S), "...")
//
// a test for an embedded NUL rather than a tautology.
//
// The fold applies to that exact shape only: a call on a runtime string
// stays an ordinary call, and stays usable as a variable-length array
// bound.

#include <stdio.h>
#include <string.h>

_Static_assert(sizeof("abc") - 1 == strlen("abc"), "literal length");
_Static_assert(sizeof("abc") - 1 == __builtin_strlen("abc"), "builtin spelling");
_Static_assert(__builtin_strlen("ab" "cd") == 4, "adjacent literals concatenate");
_Static_assert(__builtin_strlen("a\0b") == 1, "count stops at the first NUL");
_Static_assert(sizeof("a\0b") - 1 != __builtin_strlen("a\0b"), "embedded NUL differs");
_Static_assert(__builtin_strlen("") == 0, "empty literal");

// A constant bound, not a variable-length array.
static char sized[__builtin_strlen("hello")];
_Static_assert(sizeof(sized) == 5, "array bound folds");

// The folded value is `size_t`, so it composes with `sizeof` arithmetic
// without a signedness change.
_Static_assert(__builtin_strlen("xy") - 3 > 0, "result is unsigned");

struct tagged {
    char body[__builtin_strlen("member")];
    int after;
};
_Static_assert(sizeof(struct tagged) == 12, "member bound folds");

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

int main(void) {
    if (sizeof(sized) != 5) return 1;
    if (sizeof(struct tagged) != 12) return 2;

    // Runtime calls are unaffected: on a variable, on a literal, and
    // through a function pointer.
    const char *s = "dynamic";
    char buf[64];
    strcpy(buf, s);
    if (strlen(s) != 7) return 10;
    if (strlen("literal") != 7) return 11;
    if (strlen(buf) != 7) return 12;

    size_t (*fp)(const char *) = strlen;
    if (fp("via-pointer") != 11) return 13;

    // A runtime operand still gives a variable-length array.
    {
        char vla[strlen(s) + 1];
        if (sizeof vla != 8) return 20;
        vla[0] = 'x';
        vla[1] = 0;
        if (!streq(vla, "x")) return 21;
    }

    // A folded operand in a runtime expression keeps its value.
    if (strlen("abcd") + strlen(s) != 11) return 30;

    printf("ok\n");
    return 0;
}
