// Old-style (K&R) function definition: the parameter names appear in
// the declarator and their types are given in declarations between the
// `)` and the body; an unlisted parameter keeps the default int (C99
// 6.9.1). An array parameter is adjusted to a pointer.

int mix(a, b, c) char b; long c; { return a - c + b; }

int first(p) char *p; { return p[0]; }

int main(void) {
    if (mix(1, 0, 1) != 0) return 1;      // a=1 (int), b=0 (char), c=1 (long)
    if (mix(10, 5, 3) != 12) return 2;     // 10 - 3 + 5
    if (first("Z") != 'Z') return 3;
    return 0;
}
