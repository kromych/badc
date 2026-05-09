// enum as a type tag. `enum Foo { ... };` registers each
// constant as a Token::Num; `enum Foo` then works as a type spec
// equivalent to `int` in c5 (every integer in the dialect is a
// 64-bit signed int, and enums collapse to that). The fixture
// pins typing in parameter / return / local / array-dimension
// positions, plus negative initializers in the enum body.

enum Color {
    RED = 1,
    GREEN,
    BLUE,
    BLACK = 0,
    WHITE = -1,
};

enum Direction { NORTH, SOUTH, EAST, WEST };

static int classify(enum Color c) {
    return (int)c + 100;
}

int main() {
    enum Color c;
    enum Direction d;
    int xs[GREEN];           // dimension from enum constant

    c = RED;
    if (c != 1) return 1;
    if (GREEN != 2) return 2;
    if (BLUE != 3) return 3;
    if (BLACK != 0) return 4;
    if (WHITE != -1) return 5;

    d = SOUTH;
    if (d != 1) return 6;
    if (EAST != 2) return 7;
    if (WEST != 3) return 8;

    if (classify(GREEN) != 102) return 9;
    // xs is `int xs[2]` (GREEN = 2). 2 * sizeof(int) = 8.
    if (sizeof(xs) != 8) return 10;

    // Enum-typed parameter accepts plain integer values too -- c5
    // doesn't enforce enum-strictness.
    if (classify(42) != 142) return 11;

    return 0;
}
