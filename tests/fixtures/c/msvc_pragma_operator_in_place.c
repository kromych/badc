/* MSVC `__pragma(tokens)` takes effect where it stands, as C99 6.10.9
   `_Pragma` does: one a macro expansion produces governs the tokens after
   it on its line, as clang reads it for a Windows target.
   `-Wint-conversion` is an error by default, so the unit compiles only
   while the diagnostic pragmas reach the declaration and the statement
   they surround. */

#define X 1
#pragma push_macro("X")
#undef X
__pragma(pop_macro("X")) int x = X;

#define Y 2
#pragma push_macro("Y")
#undef Y
#define POP_Y __pragma(pop_macro("Y"))
POP_Y int y = Y;

#define QUIET(s) __pragma(GCC diagnostic push) __pragma(GCC diagnostic ignored "-Wint-conversion") s __pragma(GCC diagnostic pop)

QUIET(int *one = 1;) int *none = 0;

#define PACKED(decl) __pragma(pack(push, 1)) decl __pragma(pack(pop))

PACKED(struct P { char c; int i; };) struct U { char c; int i; };

int main(void) {
    int *two;
    QUIET(two = 2;) if (two != (int *)2) return 1;
    if (x != 1 || y != 2) return 2;
    if (one != (int *)1 || none) return 3;
    if (sizeof(struct P) != 5 || sizeof(struct U) != 8) return 4;
    return 0;
}
