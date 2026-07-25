// C99 6.7.8p7+p22: a `[N] =` designator may name a row of a 2-D
// struct array whose outer dimension is deferred; the size is one past
// the largest row reached, positional rows continue after a designated
// one, and skipped rows stay zero. File-scope and block-scope statics
// take separate paths; both match GCC/clang.

struct pair {
    int a, b;
};

static struct pair fgrid[][2] = {
    [2] = {{1, 2}, {3, 4}},
    [0] = {{5, 6}, {7, 8}},
};

// Designated row then a positional row continuing at the next index.
static struct pair cont[][2] = {
    [1] = {{1, 2}, {3, 4}},
    {{5, 6}, {7, 8}},
};

int main(void) {
    static struct pair sgrid[][2] = {
        {{21, 22}, {23, 24}},
        [2] = {{9, 10}, {11, 12}},
    };

    if (sizeof(fgrid) / sizeof(fgrid[0]) != 3) return 1;
    if (fgrid[2][0].a != 1 || fgrid[2][1].b != 4) return 2;
    if (fgrid[0][0].a != 5 || fgrid[0][1].b != 8) return 3;
    if (fgrid[1][0].a != 0 || fgrid[1][1].b != 0) return 4;

    if (sizeof(cont) / sizeof(cont[0]) != 3) return 5;
    if (cont[1][0].a != 1 || cont[2][1].b != 8) return 6;
    if (cont[0][0].a != 0) return 7;

    if (sizeof(sgrid) / sizeof(sgrid[0]) != 3) return 8;
    if (sgrid[0][1].b != 24 || sgrid[2][0].a != 9) return 9;
    if (sgrid[1][0].a != 0 || sgrid[1][1].b != 0) return 10;

    return 0;
}
