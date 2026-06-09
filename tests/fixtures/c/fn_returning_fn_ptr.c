// A function whose return type is itself a function pointer
// (`int (*f())()`) leaves a function-pointer rvalue, so a following
// unary `*` is the C99 6.3.2.1p4 decay no-op and the result can be
// called directly.

int sub(int a, int b) {
    return a - b;
}

int (*pick(int which))(int, int) {
    return which ? sub : 0;
}

int main(void) {
    // Deref the returned function pointer, then call it.
    if ((*pick(1))(7, 3) != 4) return 1;
    // Call the returned function pointer without an explicit deref.
    if (pick(1)(10, 6) != 4) return 2;
    if (pick(0) != 0) return 3;
    // Store the returned function pointer in an explicit fn-pointer
    // variable, then call through it.
    int (*q)(int, int) = pick(1);
    if (q(9, 2) != 7) return 4;
    return 0;
}
