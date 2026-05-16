// Locks C99 6.10.3.4 re-scan after `##`-paste.
//
// After a function-like macro's body is constructed (parameter
// substitution + `#` + `##`), the result is re-scanned for
// further macro replacement. When the re-scanned token is a
// function-like macro name and the next source token after the
// outer invocation is `(`, the re-scan must consume those
// arguments and expand the inner macro.
//
// The pattern shows up wherever a width-mux paste-macro forwards
// to a width-specific function-like macro:
//
//     #define ELFW(t) ELF##64##_##t
//     #define ELF64_ST_VIS(o) ((o) & 0x03)
//     ELFW(ST_VIS)(7)   // expects 3
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#define INNER1(x)        ((x) + 1)
#define WIDEN_64_(name)  WIDTH_64_##name
#define WIDTH_64_FOO(x)  ((x) * 10)
#define WIDTH_64_BAR(a, b) ((a) - (b))
#define PASTE_VIA(t)     ELF##64##_##t
#define ELF64_ST_VIS(o)  ((o) & 0x03)

int main(void) {
    // Single-level: paste produces a function-like macro name,
    // which is then called with source-side args.
    if (PASTE_VIA(ST_VIS)(7) != 3) return 11;
    if (PASTE_VIA(ST_VIS)(255) != 3) return 12;

    // Paste through an indirection: WIDEN_64_(FOO) -> WIDTH_64_FOO
    // (a function-like macro), then (5) -> 50.
    if (WIDEN_64_(FOO)(5) != 50) return 13;

    // Inner macro with two args; commas inside the call must be
    // attributed to the inner argument list, not to the outer
    // WIDEN_64_(name).
    if (WIDEN_64_(BAR)(20, 3) != 17) return 14;

    // Non-paste chain still works: object-like macro names whose
    // expansion is a function-like macro followed by source `(`.
    if (INNER1(2) != 3) return 15;

    return 0;
}
