// C99 6.2.1p4: a parameter's scope ends with its declaration and a block
// local's with its block, so the file-scope array of the same name keeps its
// own shape afterwards. The declarator writes the shared symbol slot, so the
// multi-dimensional stride list has to survive the inner binding: without it
// the second subscript of `grid[i][j]` no longer sees an array.

static const unsigned int grid[2][4] = {{1, 2, 3, 4}, {5, 6, 7, 8}};
static const int cube[2][2][2] = {{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}};

// A prototype names the parameter, and so does the definition.
static unsigned int read_word(unsigned int grid);
static int pick(int cube);

static unsigned int read_word(unsigned int grid) { return grid; }

static int pick(int cube) { return cube + 1; }

static int through_block(void) {
    {
        unsigned int grid = 9;
        if (grid != 9) {
            return 1;
        }
    }
    for (int cube = 0; cube < 1; cube++) {
        if (cube != 0) {
            return 2;
        }
    }
    return grid[1][2] == 7 && cube[1][0][1] == 6 ? 0 : 3;
}

int main(void) {
    if (read_word(grid[1][0]) != 5 || pick(1) != 2) {
        return 1;
    }
    if (sizeof(grid) != 32 || sizeof(grid[0]) != 16) {
        return 2;
    }
    if (cube[0][1][1] != 4 || cube[1][1][0] != 7) {
        return 3;
    }
    return through_block();
}
