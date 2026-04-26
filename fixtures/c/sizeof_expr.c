int main() {
    int x;
    char c;
    int *p;
    char *s;

    if (sizeof(x) != 8) return 1;
    if (sizeof(c) != 1) return 2;
    if (sizeof(p) != 8) return 3;
    if (sizeof(s) != 8) return 4;

    // sizeof(*expr) yields the size of the pointee, not the pointer.
    if (sizeof(*p) != 8) return 5;
    if (sizeof(*s) != 1) return 6;

    // Operand is not evaluated -- p is uninitialised, but sizeof(*p) is fine.
    return 0;
}
