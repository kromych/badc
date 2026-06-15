// C99 6.10.9: the `_Pragma` operator destringizes its string-literal
// operand and processes the result as a `#pragma` directive. It may be
// produced by macro expansion (the `#x` stringize feeding `_Pragma`),
// must not be recognized inside a string or character literal, and an
// unsupported pragma is ignored the same way `#pragma` ignores it.

#define DO_PRAGMA(x) _Pragma(#x)
#define PACK(n) DO_PRAGMA(pack(n))

// `pack` via the operator folds into the same pack stack as the
// directive form; the struct that follows packs at 1.
PACK(1)
struct Packed {
    char a;
    int b;
};
DO_PRAGMA(pack())

struct Aligned {
    char a;
    int b;
};

int main(void) {
    if (sizeof(struct Packed) != 5) return 1;
    if (sizeof(struct Aligned) != 8) return 2;

    // The operator name inside a string literal is not the operator.
    const char *s = "_Pragma(\"once\")";
    if (s[0] != '_' || s[1] != 'P') return 3;

    // An unsupported pragma is accepted and ignored.
    _Pragma("GCC diagnostic push")
    _Pragma("GCC diagnostic pop")

    return 0;
}
