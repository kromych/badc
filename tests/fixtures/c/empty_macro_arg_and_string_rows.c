// A function-like macro called with empty parentheses passes one empty
// argument, so its parameter is substituted with nothing (C99
// 6.10.3p4); the parameter name must not survive to be rescanned. A
// string literal initializing a row of a multi-dimensional char array
// fills that row, padded with NUL (C99 6.7.8p14).

#define x 2
#define q(a) a
#define r(a, b) a ## b
#define str(s) # s

int v[q()] = { q(1), r(2, 3), r(4, ), r(, 5), r(, ) };

char rows[2][6] = { str(hello), str() };

int main(void) {
    // q() expanded to nothing, so the array size is inferred from the
    // four non-empty initializers; `x` (the object macro = 2) must not
    // have leaked in as the dimension.
    if (sizeof(v) / sizeof(int) != 4) return 1;
    if (v[0] != 1 || v[1] != 23 || v[2] != 4 || v[3] != 5) return 2;

    if (rows[0][0] != 'h' || rows[0][4] != 'o' || rows[0][5] != 0) return 3;
    if (rows[1][0] != 0) return 4;

    return 0;
}
