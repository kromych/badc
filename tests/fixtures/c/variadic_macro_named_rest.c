// GCC named-rest variadic macro: the last parameter `name...` makes the
// macro variadic and binds the trailing arguments to `name`, the named
// analogue of `__VA_ARGS__`. Stringization (`#name`) and the `, ##name`
// empty-elision behave as they do for `__VA_ARGS__`.

#define SUM(args...) add3(args)
#define TAIL(first, rest...) add3(first, rest)
#define HEAD(a, rest...) id(a, ##rest)
#define STR(rest...) #rest

int add3(int a, int b, int c) { return a + b + c; }
int id(int a) { return a; }

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++;
        b++;
    }
    return *a == *b;
}

int main(void) {
    // Named tail carries every argument.
    if (SUM(1, 2, 3) != 6) return 1;

    // A fixed parameter plus a named tail.
    if (TAIL(10, -4, -6) != 0) return 2;

    // `, ##rest` drops the comma when the tail is empty, so `id(5)` is a
    // valid one-argument call.
    if (HEAD(5) != 5) return 3;

    // Stringizing the named tail joins the arguments the same way
    // `#__VA_ARGS__` does.
    if (!streq(STR(a, b), "a, b")) return 4;

    return 0;
}
