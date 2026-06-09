// `sizeof` accepts an abstract array type-name `sizeof(T [N])` whose
// dimensions multiply the element size (C99 6.7.6 / 6.5.3.4), and it
// binds to a full unary-expression so `sizeof(arr)[i]` parses as
// `sizeof((arr)[i])` rather than indexing the size constant.

int matches[128];

int main(void) {
    if (sizeof(int [2]) != 2 * sizeof(int)) return 1;
    if (sizeof(int [2][3]) != 6 * sizeof(int)) return 2;
    if (sizeof(char [5]) != 5) return 3;

    // The whole-array size still reads through a paren.
    if (sizeof(matches) != 128 * sizeof(int)) return 4;

    // `sizeof(matches)[0]` is `sizeof((matches)[0])` == sizeof(int).
    if (sizeof(matches)[0] != sizeof(int)) return 5;

    return 0;
}
