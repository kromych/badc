// `__builtin_expect` is a predefined compiler builtin, available with
// no header and no auto-include: its value is the first operand. No
// #include in this file, so a regression back to header-dependent
// availability fails to compile.
static long branch_hint(long v) {
    return __builtin_expect(v != 0, 1);
}

int main(void) {
    if (branch_hint(2) != 1) {
        return 1;
    }
    if (__builtin_expect(0, 1)) {
        return 2;
    }
    if (__builtin_expect(7, 7) != 7) {
        return 3;
    }
    return 0;
}
