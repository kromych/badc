// C99 6.5.3.4 / 6.7.6: `sizeof` accepts an abstract function-pointer
// type-name. `int (*)(int)` and `void (*)(void)` denote a pointer to
// function, so their size is the pointer width; the arg-list and any
// `[N]` / nested declarator collapse to that pointer level. The same
// declarator already parses in cast position; this pins the `sizeof`
// operand path, in both the runtime primary and the constant-expression
// form (array dimension, enum constant).

enum { FP = sizeof(void (*)(void)) };

int main(void) {
    if (sizeof(int (*)(int)) != sizeof(void *)) return 1;
    if (sizeof(void (*)(void)) != sizeof(void *)) return 2;
    if (sizeof(int (*)(int, char)) != sizeof(void *)) return 3;

    // Pointer-to-array declarator: still a pointer.
    if (sizeof(int (*)[5]) != sizeof(void *)) return 4;

    // Function returning a function pointer.
    if (sizeof(void (*(*)(int))(void)) != sizeof(void *)) return 5;

    // Constant-expression contexts.
    if (FP != sizeof(void *)) return 6;
    char a[sizeof(int (*)(int))];
    if (sizeof(a) != sizeof(void *)) return 7;

    // Non-function-pointer type-names are unaffected.
    if (sizeof(int) != 4) return 8;
    if (sizeof(int[5]) != 5 * sizeof(int)) return 9;
    if (sizeof(int *) != sizeof(void *)) return 10;

    return 0;
}
