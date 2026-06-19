/* C99 6.7.8: a multi-dimensional array of structs initialized with nested
   braces. Each outer brace opens a sub-array, not a single struct, so the
   inner dimensions must be honored -- at file scope (sized and via the
   element layout) and for a function-local static. */

struct cpx { double r, i; };

struct cpx g2[2][2] = { { {1, 2}, {3, 4} }, { {5, 6}, {7, 8} } };

struct cpx g3[2][2][2] = {
    { { {1, 1}, {2, 2} }, { {3, 3}, {4, 4} } },
    { { {5, 5}, {6, 6} }, { {7, 7}, {8, 8} } },
};

int main(void) {
    if (g2[0][0].r != 1 || g2[0][1].i != 4 || g2[1][0].r != 5 || g2[1][1].i != 8) return 1;
    if (g3[0][0][0].r != 1 || g3[1][1][1].i != 8 || g3[1][0][1].r != 6) return 2;

    static struct cpx s2[2][2] = { { {9, 10}, {11, 12} }, { {13, 14}, {15, 16} } };
    if (s2[0][0].r != 9 || s2[1][1].i != 16 || s2[0][1].r != 11) return 3;

    return 0;
}
