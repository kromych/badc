// C99 6.7.5.3p8: a parameter declared with function type is adjusted to
// pointer-to-function. An abstract (unnamed) function-type parameter --
// `RET ( param-types )` -- appears in real-world code as
// `void test_a(float32_t(uint32_t), float32_t(uint32_t))`. It must be
// distinguished from a parenthesized declarator `RET (name)` by a
// type-start after the paren. Returns 0 on success; non-zero per fail.

typedef unsigned u32;

// Abstract function-type parameters (decay to function pointers).
int apply1(int(int), int);
int apply2(u32(u32), int(void), int);

// Regression: a parenthesized declarator names a variable; a `(*fp)` is a
// function pointer; a named function-type parameter also decays.
int mixed(int (x), int (*fp)(int), int g(int)) {
    return x + fp(x) + g(x);
}

int apply1(int fn(int), int x) {
    return fn(x);
}

int inc(int a) {
    return a + 1;
}
int neg(int a) {
    return -a;
}

int main(void) {
    if (apply1(inc, 41) != 42) {
        return 1;
    }
    // mixed(3, inc, neg) = 3 + inc(3) + neg(3) = 3 + 4 + (-3) = 4
    if (mixed(3, inc, neg) != 4) {
        return 2;
    }
    return 0;
}
