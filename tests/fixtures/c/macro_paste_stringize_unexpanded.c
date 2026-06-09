// An argument that is an operand of `#` or `##` is substituted
// without macro expansion (C99 6.10.3.1p1 / 6.10.3.2p2). A value that
// must be expanded before a paste needs an extra macro layer.

#define VAL 42
#define cat(x, y) x##y
#define str(x) #x

// `paste` is a macro; as a `##` operand it pastes its literal token.
#define paste []
int cat(paste, _);   // -> int paste_;  (not int []_;)
int cat(a, paste);   // -> int apaste;

// Two-level forces the argument to expand before the paste.
#define cat2_(x, y) x##y
#define cat2(x, y)  cat2_(x, y)

int main(void) {
    paste_ = 1;
    apaste = 2;
    if (paste_ + apaste != 3) return 1;

    // Stringize uses the unexpanded argument: str(VAL) is "VAL".
    const char *s = str(VAL);
    if (s[0] != 'V' || s[1] != 'A' || s[2] != 'L' || s[3] != 0) return 2;

    // A direct paste of VAL keeps the literal token.
    int catVALx = 7;
    if (cat(catVAL, x) != 7) return 3;

    // The two-level form expands VAL to 42 before pasting.
    int v42 = 9;
    if (cat2(v, VAL) != 9) return 4;

    return 0;
}
