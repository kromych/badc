int main() {
    int x;
    long y;
    char c;
    int *p;
    long *q;
    char *s;

    if (sizeof(x) != 4) return 1;       // real i32 storage
    if (sizeof(y) != 8) return 2;
    if (sizeof(c) != 1) return 3;
    if (sizeof(p) != 8) return 4;
    if (sizeof(q) != 8) return 5;
    if (sizeof(s) != 8) return 6;

    // sizeof(*expr) yields the size of the pointee, not the pointer.
    if (sizeof(*p) != 4) return 7;
    if (sizeof(*q) != 8) return 8;
    if (sizeof(*s) != 1) return 9;

    // Operand is not evaluated -- p is uninitialised, but sizeof(*p) is fine.
    return 0;
}
