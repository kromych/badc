// An N-dimensional array initializer pads every nesting level to the
// element count its sub-array spans (the product of the dimensions
// below it), so a short inner list keeps subsequent sub-arrays on the
// right stride (C99 6.7.8p21). The outermost dimension may be inferred
// from the initializer, and array designators may appear at the inner
// levels.

int inferred[][3][5] = {
    { {0, 0, 3, 5}, {1, [3] = 6, 7}, },
    { {1, 2}, {[4] = 7, }, },
};

int explicit3d[2][3][5] = {
    { {0, 0, 3, 5}, {1, [3] = 6, 7}, },
    { {1, 2}, {[4] = 7, }, },
};

int twod[3][4] = { {1, 2}, {[2] = 9}, };

int main(void) {
    if (sizeof(inferred) != 2 * 3 * 5 * sizeof(int)) return 1;

    // Inner-row padding: arr[0][0] == {0,0,3,5,0}.
    if (inferred[0][0][4] != 0) return 2;
    // Designator in an inner row: {1,[3]=6,7} -> {1,0,0,6,7}.
    if (inferred[0][1][0] != 1 || inferred[0][1][3] != 6 || inferred[0][1][4] != 7) return 3;
    // Missing third row of the first block is zero.
    if (inferred[0][2][0] != 0) return 4;
    // Second block: {{1,2},{[4]=7}} with a zero third row.
    if (inferred[1][0][0] != 1 || inferred[1][0][1] != 2) return 5;
    if (inferred[1][1][4] != 7 || inferred[1][1][0] != 0) return 6;

    // The explicit-dimension form lays out identically.
    if (explicit3d[0][1][4] != inferred[0][1][4]) return 7;
    if (explicit3d[1][1][4] != inferred[1][1][4]) return 8;

    // 2D with a designated second row: {1,2,0,0} then {0,0,9,0}.
    if (twod[0][0] != 1 || twod[0][1] != 2 || twod[0][3] != 0) return 9;
    if (twod[1][2] != 9 || twod[1][0] != 0) return 10;
    if (twod[2][0] != 0) return 11;

    return 0;
}
