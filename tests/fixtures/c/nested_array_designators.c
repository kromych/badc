// C99 6.7.8p6/p7/p17: array designators at every level of a nested
// initializer, in each aggregate context -- a top-level 2-D struct
// array, a deferred-size 2-D struct array with compound-literal
// elements, a member 2-D scalar array, a member 3-D pointer array,
// a deep positional member array, and a GNU range over rows. All of
// these route through one struct-array walker.

struct st { unsigned char state, action; };
static const struct st tab[4][5] = {
    [1] = { [2] = { 10, 11 }, [4] = { 12, 13 } },
    [3] = { [0] = { 20, 21 } },
};

struct rf { int reg, lsb, msb; };
static const struct rf t1[][3] = {
    { [0] = (struct rf){ .reg = 1 }, [2] = (struct rf){ .reg = 4 } },
    { [1] = { 7, 8, 9 } },
};

struct api { int ver; unsigned cmd[4][3]; };
static const struct api a1 = {
    .ver = 9,
    .cmd = { [1] = { [0] = 5, [2] = 6 }, [3] = { [1] = 7 } },
};

static int obj1, obj2;
struct holder { int *ptrs[3][2][2]; };
static const struct holder h = {
    .ptrs = { [1] = { [0] = { [1] = &obj1 }, [1] = { [0] = &obj2 } } },
};

struct deep { unsigned char coef[2][2][2][2]; };
static const struct deep d = {
    .coef = { { { { 1, 2 }, { 3, 4 } }, { { 5, 6 }, { 7, 8 } } } },
};

static const struct st rr[4][2] = { [1 ... 2] = { { 1, 2 }, { 3, 4 } } };

// Chained subscripts naming one element, and a member chain below them.
static struct st grid[2][3] = {
    [0][1] = { 40, 41 },
    [1][2].action = 42,
};

int main(void) {
    if (tab[1][2].state != 10 || tab[1][4].action != 13) return 1;
    if (tab[3][0].state != 20 || tab[0][0].state != 0) return 2;
    if (t1[0][0].reg != 1 || t1[0][2].reg != 4 || t1[1][1].msb != 9) return 3;
    if (a1.cmd[1][0] != 5 || a1.cmd[1][2] != 6 || a1.cmd[3][1] != 7) return 4;
    if (a1.cmd[0][0] != 0 || a1.ver != 9) return 5;
    if (h.ptrs[1][0][1] != &obj1 || h.ptrs[1][1][0] != &obj2) return 6;
    if (h.ptrs[0][0][0] != 0 || h.ptrs[1][0][0] != 0) return 7;
    if (d.coef[0][0][0][0] != 1 || d.coef[0][0][1][1] != 4) return 8;
    if (d.coef[0][1][1][1] != 8 || d.coef[1][0][0][0] != 0) return 9;
    if (rr[1][0].state != 1 || rr[2][1].action != 4 || rr[0][0].state != 0) return 10;
    if (grid[0][1].state != 40 || grid[0][1].action != 41) return 11;
    if (grid[1][2].action != 42 || grid[1][2].state != 0) return 12;
    return 0;
}
