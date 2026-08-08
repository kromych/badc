// C99 6.2.3: structure and union members live in a name space of their
// own, so declaring a member cannot change what an ordinary identifier of
// the same name denotes. Each object below is subscripted after a member
// of its name has been declared; the recorded dimensions must survive.

static const short tbl[][3] = {
    {1, 2, 3},
    {4, 5, 6},
};

struct after_2d {
    int tbl;
};

static int cube[2][3][4];

struct after_3d {
    char cube;
};

typedef int row_t[4];
static row_t grid[3];

struct after_typedef {
    long grid;
};

struct inner {
    int cube[2][2];
};

// A member declared through a function-pointer type, whose parameters
// re-enter the declarator machinery under the member's own declarator.
struct nested {
    int (*tbl)(struct inner *p, int grid[2][2]);
};

int main(void)
{
    int i, j, k, n = 0;

    if (tbl[1][2] != 6 || tbl[0][1] != 2)
        return 1;

    for (i = 0; i < 2; i++)
        for (j = 0; j < 3; j++)
            for (k = 0; k < 4; k++)
                cube[i][j][k] = n++;
    if (cube[1][2][3] != 23 || cube[0][0][1] != 1)
        return 2;

    for (i = 0; i < 3; i++)
        for (j = 0; j < 4; j++)
            grid[i][j] = i * 10 + j;
    if (grid[2][3] != 23 || grid[0][1] != 1)
        return 3;

    if (sizeof cube != 2 * 3 * 4 * sizeof(int))
        return 4;
    if (sizeof grid != 3 * 4 * sizeof(int))
        return 5;
    return 0;
}
