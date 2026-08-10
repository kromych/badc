// C99 6.7.5.2p6 array compatibility through
// `__builtin_types_compatible_p`: two array types are compatible when the
// element types are compatible and, where both bounds are specified, the
// bounds agree. An omitted bound (`T []`) is an incomplete array type and
// matches any bound. C99 6.7.6.2: an array is never compatible with a
// pointer. Every expectation below matches gcc and clang. Returns 0 on
// success; distinct non-zero per failure.

static char arr4[4];
static char *ptr;
static int grid[2][3];

// An omitted bound matches any specified bound, in either argument order.
_Static_assert(__builtin_types_compatible_p(char[], char[4]) == 1, "[] ~ [4]");
_Static_assert(__builtin_types_compatible_p(char[4], char[]) == 1, "[4] ~ []");
_Static_assert(__builtin_types_compatible_p(char[], char[]) == 1, "[] ~ []");

// Two specified bounds must agree.
_Static_assert(__builtin_types_compatible_p(char[4], char[4]) == 1, "[4] ~ [4]");
_Static_assert(__builtin_types_compatible_p(char[4], char[8]) == 0, "[4] !~ [8]");

// An array is never compatible with a pointer, either order, either bound.
_Static_assert(__builtin_types_compatible_p(char[], char *) == 0, "[] !~ ptr");
_Static_assert(__builtin_types_compatible_p(char *, char[]) == 0, "ptr !~ []");
_Static_assert(__builtin_types_compatible_p(char[4], char *) == 0, "[4] !~ ptr");

// The element type still has to match.
_Static_assert(__builtin_types_compatible_p(int[], char[]) == 0, "elem type");
_Static_assert(__builtin_types_compatible_p(char *[], char *[4]) == 1, "ptr elem");
_Static_assert(__builtin_types_compatible_p(char *[], char[4]) == 0, "ptr vs char");

// Top-level qualifiers are ignored, as for any other type name.
_Static_assert(__builtin_types_compatible_p(const char[], char[]) == 1, "const []");
_Static_assert(__builtin_types_compatible_p(char[], const char[]) == 1, "[] const");

// Rank participates: a bound may be omitted per dimension, but an array of
// arrays is not compatible with a one-dimensional array of the element type.
_Static_assert(__builtin_types_compatible_p(int[2][3], int[2][3]) == 1, "2x3");
_Static_assert(__builtin_types_compatible_p(int[2][3], int[2][4]) == 0, "inner bound");
_Static_assert(__builtin_types_compatible_p(int[][3], int[2][3]) == 1, "outer omitted");
_Static_assert(__builtin_types_compatible_p(int[2][3], int[6]) == 0, "rank");
_Static_assert(__builtin_types_compatible_p(int[2][3], int[]) == 0, "rank vs []");

// A zero-length array carries a specified bound of 0, which the omitted
// bound still matches.
_Static_assert(__builtin_types_compatible_p(int[0], int[]) == 1, "[0] ~ []");

int main(void) {
    // `typeof` of an object mixes with a written array type name, the shape
    // a compile-time array guard uses.
    if (__builtin_types_compatible_p(typeof(arr4), char[]) != 1) {
        return 1;
    }
    if (__builtin_types_compatible_p(char[], typeof(arr4)) != 1) {
        return 2;
    }
    if (__builtin_types_compatible_p(typeof(arr4), char[4]) != 1) {
        return 3;
    }
    if (__builtin_types_compatible_p(typeof(arr4), char[8]) != 0) {
        return 4;
    }
    // A pointer object never matches an array type name, and an array
    // object never matches a pointer type name.
    if (__builtin_types_compatible_p(typeof(ptr), char[]) != 0) {
        return 5;
    }
    if (__builtin_types_compatible_p(typeof(arr4), char *) != 0) {
        return 6;
    }
    // A `typeof` operand still compares unequal to a pointer type name
    // written out, the guard a compile-time element count relies on.
    // TODO: a multi-dimensional `typeof` operand (`grid`, `grid[0]`) keeps
    // its pointer level because the element type is not recoverable from
    // the decay markers, so it does not yet match a written array type
    // name; the written-out forms above cover the multi-dimensional rules.
    if (__builtin_types_compatible_p(typeof(grid), int *) != 0) {
        return 7;
    }
    return 0;
}
