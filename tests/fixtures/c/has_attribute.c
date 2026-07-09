// `__has_attribute(NAME)` feature-test operator: 1 for attributes the
// compiler recognizes, else 0; `#ifdef __has_attribute` is true. Names may
// be spelled bare or `__`-wrapped. Also resolves when reached through a
// macro alias, as glib's `#define g_macro__has_attribute __has_attribute`
// does. Returns 0 on success; a distinct non-zero code per failure.

#ifndef __has_attribute
#error "__has_attribute should be defined"
#endif

// glib-style alias: the operator is reached only after macro substitution.
#define has_attr __has_attribute

#if __has_attribute(cleanup)
#define A 1
#else
#define A 0
#endif

#if __has_attribute(__packed__)
#define B 1
#else
#define B 0
#endif

#if __has_attribute(no_such_attribute_zzz)
#define C 1
#else
#define C 0
#endif

#if has_attr(pure)
#define D 1
#else
#define D 0
#endif

int main(void) {
    if (A != 1) {
        return 1; // cleanup recognized -> glib g_auto* activate
    }
    if (B != 1) {
        return 2; // __packed__ normalizes to packed
    }
    if (C != 0) {
        return 3; // unknown attribute -> 0
    }
    if (D != 1) {
        return 4; // reached through a macro alias
    }
    return 0;
}
