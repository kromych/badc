// C99 6.7.5.3p7 + 6.7.5.2p1: `[`'s contents inside a parameter
// declarator may carry `static` and / or any type qualifier
// (`const` / `volatile` / `restrict`) before the dimension
// expression. The keywords are hints to the compiler; badc
// records the dimension as if they were absent and continues.

static int sum_static(int xs[static 3]) {
    return xs[0] + xs[1] + xs[2];
}

static int sum_qualified(int xs[const 3]) {
    return xs[0] + xs[1] + xs[2];
}

static int sum_volatile(int xs[volatile 3]) {
    return xs[0] + xs[1] + xs[2];
}

static int first_row(int xs[static 2][3]) {
    return xs[0][0] + xs[0][1] + xs[0][2];
}

int main(void) {
    int xs[3] = {1, 2, 3};
    if (sum_static(xs) != 6) return 1;
    if (sum_qualified(xs) != 6) return 2;
    if (sum_volatile(xs) != 6) return 3;

    int grid[2][3] = {{4, 5, 6}, {7, 8, 9}};
    if (first_row(grid) != 15) return 4;
    return 0;
}
