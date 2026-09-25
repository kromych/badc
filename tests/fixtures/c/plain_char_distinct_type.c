// C99 6.2.5p15: `char`, `signed char` and `unsigned char` are three
// distinct types, and plain `char` has the representation of one of the
// other two. Generic selection (C11 6.5.1.1), `__builtin_types_compatible_p`,
// `typeof`, the element type of a string literal (C99 6.4.5p5) and of
// `__func__` (6.4.2.2p1) tell the three apart on every target, while a
// plain `char` value keeps the target's signedness (`__CHAR_UNSIGNED__`).
// Each check exits with its own code; success returns 0.

#include <stdint.h>

#define WHICH(x) _Generic((x), signed char: 1, char: 2, unsigned char: 3, default: 0)
#define WHICH_PTR(p) _Generic((p), signed char *: 1, char *: 2, unsigned char *: 3, default: 0)

char pc;
signed char sc;
unsigned char uc;
const char lit[] = "\xff";
struct S {
    char c;
    signed char sc;
    unsigned char uc;
};

int main(void) {
    struct S s;
    if (WHICH(sc) != 1 || WHICH(pc) != 2 || WHICH(uc) != 3) {
        return 1;
    }
    if (WHICH((int8_t)0) != 1 || WHICH((uint8_t)0) != 3) {
        return 2;
    }
    if (WHICH("a"[0]) != 2 || WHICH(lit[0]) != 2 || WHICH(__func__[0]) != 2) {
        return 3;
    }
    if (WHICH((__typeof__(pc))0) != 2 || WHICH((__typeof__(sc))0) != 1
        || WHICH((__typeof__(uc))0) != 3) {
        return 4;
    }
    if (WHICH(s.c) != 2 || WHICH(s.sc) != 1 || WHICH(s.uc) != 3) {
        return 5;
    }
    if (WHICH_PTR(&pc) != 2 || WHICH_PTR(&sc) != 1 || WHICH_PTR(&uc) != 3
        || WHICH_PTR("a") != 2) {
        return 6;
    }
    if (__builtin_types_compatible_p(char, signed char)
        || __builtin_types_compatible_p(char, unsigned char)
        || __builtin_types_compatible_p(signed char, unsigned char)
        || __builtin_types_compatible_p(char *, unsigned char *)
        || !__builtin_types_compatible_p(char, __typeof__(lit[0]))) {
        return 7;
    }
    // The integer promotions (6.3.1.1p2) take every character type to `int`.
    if (WHICH(pc + 0) != 0 || WHICH(sc + 0) != 0 || WHICH(uc + 0) != 0) {
        return 8;
    }
    // Plain `char` is distinct even from the type whose representation it
    // takes, and its values follow that representation.
    int v = lit[0];
#ifdef __CHAR_UNSIGNED__
    if (v != 255 || _Generic(pc, unsigned char: 1, default: 0)) {
        return 9;
    }
#else
    if (v != -1 || _Generic(pc, signed char: 1, default: 0)) {
        return 9;
    }
#endif
    pc = (char)0xff;
    if ((pc < 0) != (v < 0) || (unsigned char)pc != 255 || sizeof(char) != 1) {
        return 10;
    }
    return 0;
}
