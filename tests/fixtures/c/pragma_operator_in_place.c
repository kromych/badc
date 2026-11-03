/* C99 6.10.9: a `_Pragma` operator takes effect where it stands in the
   token stream, so one a macro expansion produces governs the tokens
   after it on its line. `-Wint-conversion` is an error by default, so
   the unit compiles only while each diagnostic pragma reaches the
   declaration or statement it surrounds. */

#define X 1
#pragma push_macro("X")
#undef X
_Pragma("pop_macro(\"X\")") int x = X;

#define Y 2
#pragma push_macro("Y")
#undef Y
#define POP_Y _Pragma("pop_macro(\"Y\")")
POP_Y int y = Y;

#define QUIET(s) _Pragma("GCC diagnostic push") _Pragma("GCC diagnostic ignored \"-Wint-conversion\"") s _Pragma("GCC diagnostic pop")

QUIET(int *one = 1;) int *none = 0;

#define PACKED(decl) _Pragma("pack(push, 1)") decl _Pragma("pack(pop)")

PACKED(struct P { char c; int i; };) struct U { char c; int i; };

int main(void) {
    int *two;
    QUIET(two = 2;) if (two != (int *)2) return 1;
    if (x != 1 || y != 2) return 2;
    if (one != (int *)1 || none) return 3;
    if (sizeof(struct P) != 5 || sizeof(struct U) != 8) return 4;
    return 0;
}
