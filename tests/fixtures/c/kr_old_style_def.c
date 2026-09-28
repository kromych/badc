// Old-style (K&R) function definition: the parameter names appear in
// the declarator and their types are given in declarations between the
// `)` and the body; an unlisted parameter keeps the default int (C99
// 6.9.1). An array parameter is adjusted to a pointer.

int mix(a, b, c) char b; long c; { return a - c + b; }

int first(p) char *p; { return p[0]; }

// The identifier list is no prototype (6.9.1p7): every call passes the
// promoted arguments, which the entry converts to the declared types
// (6.9.1p10), a `float` from `double` and a `char` from `int`.
double scale(a, x, c) int a; float x; char c; { return a + x * 2 + c; }

// A prior prototype naming the promoted types is the type calls use (6.7.5.3p15).
double halve(double, int);
double halve(x, c) float x; char c; { return x / 2 + c; }

int main(void) {
    if (mix(1, 0, 1) != 0) return 1;      // a=1 (int), b=0 (char), c=1 (long)
    if (mix(10, 5, 3) != 12) return 2;     // 10 - 3 + 5
    if (first("Z") != 'Z') return 3;
    double (*unproto)() = scale;
    if (scale(1, 1.5f, 300) != 48.0) return 4;   // 1 + 3 + (char)300
    if (unproto(1, 1.5f, 300) != 48.0) return 5;
    double (*proto)(double, int) = halve;
    if (halve(5.0, 1) != 3.5) return 6;
    if (proto(5.0, 1) != 3.5) return 7;
    return 0;
}
