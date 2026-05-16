// Locks C99 6.4.5 paragraph 6: a string literal has type
// `char[N+1]` (the `+1` counts the implicit trailing NUL). The
// `sizeof` operator reads the array size, NOT the decayed
// pointer; only when the literal appears in a value position
// does the array-to-pointer conversion (C99 6.3.2.1p3) apply.
//
// The c5 frontend previously set the string-literal expression
// type to `Ty::Ptr` immediately, with no array-byte-count side
// channel. `sizeof("...")` then read the pointer's size and
// returned 8 for every literal, breaking idioms like
// `sizeof "magic" - 1` and `static char buf[sizeof DEFAULT]`.
//
// Returns 0 on success; each failure path returns a distinct
// nonzero code.

int main(void) {
    if (sizeof("") != 1) return 11;
    if (sizeof("a") != 2) return 12;
    if (sizeof("abc") != 4) return 13;
    if (sizeof("!<arch>\n") != 9) return 14;

    // Adjacent string-literal concatenation (C99 5.1.1.2 phase 6)
    // produces a single literal whose byte count is the sum.
    if (sizeof("abc" "def") != 7) return 15;
    if (sizeof("foo" "bar" "baz") != 10) return 16;

    // The classic "skip the trailing NUL" idiom.
    if ((sizeof("hello") - 1) != 5) return 17;

    return 0;
}
