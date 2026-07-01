// C99 7.18.2 exact-width minimum macros. INT32_MIN / INT64_MIN must use
// the `-MAX-1` idiom so the positive operand of unary minus stays in
// range for the macro's signed exact-width type; the direct literal
// form makes INT32_MIN take a wider type and INT64_MIN unrepresentable
// in any signed type.
#include <stdint.h>

// Compile-time type lock: a wrong promoted type makes the array
// dimension non-positive and fails compilation.
typedef char check_i32_width[sizeof(INT32_MIN) == 4 ? 1 : -1];
typedef char check_i64_width[sizeof(INT64_MIN) == 8 ? 1 : -1];

int main(void) {
    if (INT32_MIN >= 0) return 21;
    if (INT32_MIN + INT32_MAX != -1) return 22;
    if (INT64_MIN >= 0) return 10;
    if (INT64_MIN + INT64_MAX != -1) return 11;
    // Every derived signed minimum aliases INT64_MIN.
    if (INTMAX_MIN >= 0 || INTPTR_MIN >= 0 || PTRDIFF_MIN >= 0) return 30;
    return 0;
}
