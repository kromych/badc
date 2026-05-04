// M24 -- local variable initializers and C99 block-scope
// declarations. Pre-M24 c5 required all decls at the top of a
// block; this fixture pins:
//   - `int x = 5;` at the top of a function
//   - declarations interleaved with statements
//   - declarations inside nested `{ ... }` blocks shadow outer ones
//   - multiple declarators with mixed init: `int a = 1, b, c = 3;`
//   - char and pointer initializers

typedef struct Point {
    int x;
    int y;
} Point;

static int sum_three(int a, int b, int c) {
    return a + b + c;
}

int main() {
    int total = 0;
    char first = 'A';
    char *greeting = "hi";
    int a = 1, b, c = 3;

    b = 2;

    if (total != 0) return 1;
    if (first != 'A') return 2;
    if (greeting[0] != 'h') return 3;
    if (greeting[1] != 'i') return 4;
    if (a + b + c != 6) return 5;

    // Statement first, then a fresh declaration -- C99 block-scope.
    total = sum_three(a, b, c);
    if (total != 6) return 6;

    int doubled = total * 2;
    if (doubled != 12) return 7;

    // Initializer that calls a function.
    int from_call = sum_three(10, 20, 30);
    if (from_call != 60) return 8;

    // Nested block: shadowing + restoration.
    {
        int total = 99;
        if (total != 99) return 9;
        int inner_only = 7;
        if (inner_only != 7) return 10;
    }
    // Outer `total` is restored.
    if (total != 6) return 11;

    // Pointer initializer using the address-of an existing local.
    int *pa = &a;
    if (*pa != 1) return 12;

    // Struct value initializer copying from another struct.
    Point origin;
    origin.x = 0;
    origin.y = 0;
    Point p = origin;
    if (p.x != 0) return 13;
    if (p.y != 0) return 14;

    return 0;
}
