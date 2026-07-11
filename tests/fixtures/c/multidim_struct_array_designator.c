// C99 6.7.8p6: a designator may index every dimension of a multi-dimensional
// array down to a single element -- `arr[i][j] = { ... }` for an array of
// structs. Each subscript scales by the product of the dimensions below it,
// so the element lands at the row-major flat offset. A trailing `.field`
// overrides one field of the designated element; a whole-row designator
// `[i] = { {...}, {...} }` and positional zero-fill keep working.

struct cell {
    int a;
    int b;
};

static const struct cell grid[3][3] = {
    [0][1] = {5, 6},
    [2][0] = {7, 8},
    [1][1].b = 55, // field override on a 2D element (a stays 0)
};

static const struct cell cube[2][2][2] = {
    [1][0][1] = {3, 4},
    [0][1][0] = {9, 1},
};

static const struct cell rows[2][2] = {
    [0] = {{10, 11}, {12, 13}}, // whole-row designator with a nested list
    [1] = {{14, 15}, {16, 17}},
};

int main(void) {
    if (grid[0][1].a != 5 || grid[0][1].b != 6) return 1;
    if (grid[2][0].a != 7 || grid[2][0].b != 8) return 2;
    if (grid[1][1].a != 0 || grid[1][1].b != 55) return 3; // override + zero
    if (grid[0][0].a != 0 || grid[2][2].b != 0) return 4;  // untouched stay zero

    if (cube[1][0][1].a != 3 || cube[1][0][1].b != 4) return 5;
    if (cube[0][1][0].a != 9 || cube[0][1][0].b != 1) return 6;
    if (cube[0][0][0].a != 0) return 7;

    if (rows[0][1].a != 12 || rows[1][1].b != 17) return 8;
    return 0;
}
