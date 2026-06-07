// C99 6.5.4 + 6.7.6: an abstract function-pointer declarator in
// cast position -- `(int (*)(int))p` -- converts a pointer value
// to a function-pointer type that can then be called. The same
// declarator in `sizeof` is a separate, still-unsupported parse.

static int add_one(int x) {
    return x + 1;
}

static int mul_two(int x) {
    return x * 2;
}

int main(void) {
    long p = (long)&add_one;
    int (*f)(int) = (int (*)(int))p;
    if (f(41) != 42) return 1;

    // Cast applied inline at the call site.
    if (((int (*)(int))(long)&mul_two)(21) != 42) return 2;

    return 0;
}
