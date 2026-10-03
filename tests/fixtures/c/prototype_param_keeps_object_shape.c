// C99 6.2.1p4: a parameter of a function pointer's prototype has prototype
// scope, so declaring it cannot change the array an identifier of the same
// name denotes outside -- whether the prototype belongs to an object, a
// member or a parameter of function-pointer type. Each check exits with
// its own code; success returns 0.

static int grid[3][4];
static int cube[2][3][4];
static const short tbl[][3] = {{1, 2, 3}, {4, 5, 6}};

static void (*hook)(int cube[5][5]);

struct holder {
    int (*cb)(int grid[2][2]);
};

static int apply(int (*cube)(int tbl[4]), int v) {
    return cube ? cube(&v) : v;
}

int main(void) {
    struct holder h = {0};
    if (&grid[1][0] - &grid[0][0] != 4 || sizeof grid[0] != 4 * sizeof(int)) return 1;
    if (&cube[1][0][0] - &cube[0][0][0] != 12 || sizeof cube[1] != 3 * 4 * sizeof(int)) return 2;
    if (&cube[0][1][0] - &cube[0][0][0] != 4 || sizeof cube[1][2] != 4 * sizeof(int)) return 3;
    if (&tbl[1][0] - &tbl[0][0] != 3 || tbl[1][2] != 6) return 4;
    if (apply(0, 9) != 9 || hook || h.cb) return 5;
    return 0;
}
