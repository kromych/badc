// GCC `__builtin_types_compatible_p(T1, T2)`: an integer constant, 1 when
// the two type names are compatible (top-level qualifiers ignored), else 0.
// Also exercises composition with `typeof` and the `__builtin_choose_expr`
// thunk, a common shape for stripping qualifiers off a type. Each check
// returns a distinct non-zero code on failure; success returns 0.

// Constant-expression contexts.
_Static_assert(__builtin_types_compatible_p(int, int) == 1, "int == int");
_Static_assert(__builtin_types_compatible_p(int, long) == 0, "int != long");
_Static_assert(__builtin_types_compatible_p(int, const int) == 1, "const ignored");
_Static_assert(__builtin_types_compatible_p(unsigned int, int) == 0, "signedness matters");
_Static_assert(__builtin_types_compatible_p(char *, char *) == 1, "ptr == ptr");
_Static_assert(__builtin_types_compatible_p(char *, int *) == 0, "ptr pointee matters");

#define __builtin_choose_expr(c, a, b) ((c) ? (a) : (b))
#define strip(expr)                                                        \
    typeof(__builtin_choose_expr(                                          \
        __builtin_types_compatible_p(typeof(expr), unsigned char) ||       \
            __builtin_types_compatible_p(typeof(expr), const unsigned char), \
        (unsigned char)1, (expr) + 0))

int main(void) {
    // Runtime value context.
    if (__builtin_types_compatible_p(int, int) != 1) {
        return 1;
    }
    if (__builtin_types_compatible_p(int, double) != 0) {
        return 2;
    }
    // typeof composition: strip const/volatile off an lvalue and copy it.
    const volatile int ci = 42;
    strip(ci) t = ci + 0;
    if (t != 42) {
        return 3;
    }
    // A wide type flows through the `(expr)+0` fallback with its width.
    long wide = 0x1122334455L;
    strip(wide) w = wide;
    if (w != 0x1122334455L) {
        return 4;
    }
    return 0;
}
