int main() {
    int x;
    long y;
    char c;
    int *p;
    long *q;
    char *s;

    if (sizeof(x) != 4) return 1;       // real i32 storage
    // y is `long`: 8 on LP64, 4 on LLP64 (Windows).
#ifdef __BADC_WINDOWS__
    if (sizeof(y) != 4) return 2;
#else
    if (sizeof(y) != 8) return 2;
#endif
    if (sizeof(c) != 1) return 3;
    if (sizeof(p) != 8) return 4;
    if (sizeof(q) != 8) return 5;
    if (sizeof(s) != 8) return 6;

    // sizeof(*expr) yields the size of the pointee, not the pointer.
    if (sizeof(*p) != 4) return 7;
    // *q has type `long` -- 8 on LP64, 4 on LLP64.
#ifdef __BADC_WINDOWS__
    if (sizeof(*q) != 4) return 8;
#else
    if (sizeof(*q) != 8) return 8;
#endif
    if (sizeof(*s) != 1) return 9;

    // Operand is not evaluated -- p is uninitialised, but sizeof(*p) is fine.
    return 0;
}
