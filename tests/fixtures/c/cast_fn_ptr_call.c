// C99 6.5.4 + 6.7.6: an abstract function-pointer declarator in
// cast position -- `(int (*)(int))p` -- converts a pointer value
// to a function-pointer type that can then be called. The same
// declarator in `sizeof` is a separate, still-unsupported parse.
//
// The round-trip goes through `void *`, not `long`: a function
// address is pointer-width on every target, whereas `long` is
// 32-bit on LLP64 (Windows) and would truncate it.

static int add_one(int x) {
    return x + 1;
}

static int mul_two(int x) {
    return x * 2;
}

int main(void) {
    // Cast the function address straight to the abstract
    // function-pointer type.
    int (*f)(int) = (int (*)(int))&add_one;
    if (f(41) != 42) return 1;

    // Round-trip through a pointer-width `void *`.
    void *vp = &add_one;
    int (*g)(int) = (int (*)(int))vp;
    if (g(7) != 8) return 2;

    // Cast applied inline at the call site.
    if (((int (*)(int))&mul_two)(21) != 42) return 3;

    return 0;
}
