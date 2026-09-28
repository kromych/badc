// C99 6.7.5.1, 6.7.5.2: `double (*(*p)[3])(double)` declares a pointer to
// an array of three pointers to functions. An element reached through it,
// `p[0][i]` or `(*p)[i]`, is such a function pointer, and a call through it
// converts its arguments to the parameter types (C99 6.5.2.2p7). The
// callees take `double` and the arguments are `int`, so an element whose
// function type was lost passes them unconverted. Each check exits with its
// own code; success returns 0.

static double half(double x) { return x / 2; }
static double twice(double x) { return x * 2; }
static double (*table[3])(double) = {half, twice, half};
static double (*grid[2][3])(double) = {{half, half, half}, {twice, twice, half}};

double (*(*fg)[3])(double) = &table;
typedef double (*(*G)[3])(double);

struct holder {
    double (*(*m)[3])(double);
    G t;
};

static double through_param(double (*(*p)[3])(double), G q) {
    return (*p)[1](4) + q[0][0](4);
}

int main(void) {
    double (*(*bg)[3])(double) = grid;
    double (*(*gg)[2][3])(double) = &grid;
    G tg = &table;
    struct holder h = {&table, grid};

    if (fg[0][1](4) != 8.0) return 1;
    if ((*fg)[2](4) != 2.0) return 2;
    if (bg[1][1](4) != 8.0) return 3;
    if ((*bg)[1](4) != 2.0) return 4;
    if ((*gg)[1][0](4) != 8.0) return 5;
    if (gg[0][0][2](4) != 2.0) return 6;
    if (tg[0][1](4) != 8.0) return 7;
    if (h.m[0][1](4) != 8.0) return 8;
    if (h.t[1][0](4) != 8.0) return 9;
    if (through_param(&table, grid) != 10.0) return 10;
    if (sizeof *fg != 3 * sizeof(void *) || sizeof **gg != 3 * sizeof(void *)) return 11;
    if ((void *)&bg[1][2] != (void *)&grid[1][2]) return 12;
    return 0;
}
