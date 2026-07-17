// C99 6.7.8p6 at block scope: a designator may index every dimension of a
// multi-dimensional array of structs down to a single element,
// `arr[i][j] = { ... }`. Each subscript scales by the product of the
// dimensions below it, so the element lands at the row-major flat offset.
// This must hold for an automatic local, a `static` local, and depths past
// two dimensions -- reaching parity with a file-scope initializer. A whole-row
// `[i] = { {...}, {...} }` designator and fully-braced positional init keep
// working alongside the element form.

struct cell {
    int a;
    int b;
};

int main(void) {
    // Automatic local: element designators into a 2D array of structs.
    struct cell set[2][2] = {
        [0][1] = {5, 6},
        [1][0] = {7, 8},
    };
    if (set[0][1].a != 5 || set[0][1].b != 6) return 1;
    if (set[1][0].a != 7 || set[1][0].b != 8) return 2;
    if (set[0][0].a != 0 || set[1][1].b != 0) return 3; // untouched stay zero

    // Static local: same designators, storage in the data image.
    static struct cell grid[2][2] = {
        [1][1] = {3, 4},
        [0][0] = {9, 1},
    };
    if (grid[1][1].a != 3 || grid[1][1].b != 4) return 4;
    if (grid[0][0].a != 9 || grid[0][0].b != 1) return 5;
    if (grid[0][1].a != 0 || grid[1][0].b != 0) return 6;

    // Three dimensions: index every subscript to one element.
    struct cell cube[2][2][2] = {
        [1][0][1] = {42, 43},
        [0][1][0] = {7, 8},
    };
    if (cube[1][0][1].a != 42 || cube[1][0][1].b != 43) return 7;
    if (cube[0][1][0].a != 7 || cube[0][1][0].b != 8) return 8;
    if (cube[0][0][0].a != 0 || cube[1][1][1].b != 0) return 9;

    // A whole-row `[i]` designator with a nested list, and positional
    // fully-braced init, both still fill correctly.
    struct cell rows[2][2] = {
        [1] = {{14, 15}, {16, 17}},
        [0] = {{10, 11}, {12, 13}},
    };
    if (rows[0][1].a != 12 || rows[1][1].b != 17) return 10;

    struct cell pos[2][2] = {{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}};
    if (pos[0][0].a != 1 || pos[1][1].b != 8) return 11;
    return 0;
}
