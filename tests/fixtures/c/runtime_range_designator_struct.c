/* GNU array range designator over struct-typed elements in an automatic
   initializer (an interrupt-map dummy-mask shape): the braced entry is
   evaluated once and its bytes replicate across the range, for declared
   and deferred sizes, with a later element overriding a range slot, a
   range inside a struct member's array, and non-constant rows of a
   2-D array. Asserted by return code. */

static int calls;
static int next(int seed) {
    calls++;
    return seed;
}

struct pair {
    int x;
    long long y;
};

static int check_struct_ranges(int seed) {
    calls = 0;
    struct pair d[4] = { [0 ... 2] = { next(seed), 9 }, [3] = { 5, 6 } };
    if (calls != 1) return 101;
    for (int i = 0; i < 3; i++)
        if (d[i].x != seed || d[i].y != 9) return 1;
    if (d[3].x != 5 || d[3].y != 6) return 2;

    /* deferred size from the range end + a positional tail */
    struct pair e[] = { [1 ... 3] = { next(seed), 9 }, { 5, 6 } };
    if (sizeof(e) / sizeof(e[0]) != 5) return 102;
    if (calls != 2) return 103;
    if (e[0].x != 0 || e[0].y != 0) return 3;
    for (int i = 1; i <= 3; i++)
        if (e[i].x != seed || e[i].y != 9) return 4;
    if (e[4].x != 5 || e[4].y != 6) return 5;

    /* a later whole-element entry overrides one range slot */
    struct pair o[3] = { [0 ... 2] = { next(seed), 1 }, [1] = { next(seed + 4), 2 } };
    if (calls != 4) return 104;
    if (o[0].x != seed || o[0].y != 1 || o[2].x != seed || o[2].y != 1) return 6;
    if (o[1].x != seed + 4 || o[1].y != 2) return 7;
    return 0;
}

struct holder {
    int arr[5];
    int tail;
};

static int check_member_range(int seed) {
    calls = 0;
    struct holder h = { .arr = { [1 ... 3] = next(seed) }, .tail = 8 };
    if (calls != 1) return 105;
    if (h.arr[0] != 0 || h.arr[4] != 0) return 8;
    if (h.arr[1] != seed || h.arr[2] != seed || h.arr[3] != seed) return 9;
    if (h.tail != 8) return 10;
    return 0;
}

static int check_row_range(int seed) {
    /* rows of a 2-D array: each covered row copies the once-stored
       first row (row values may be non-constant, beyond gcc) */
    calls = 0;
    int m[4][2] = { [0 ... 2] = { next(seed), 5 } };
    if (calls != 1) return 106;
    for (int r = 0; r < 3; r++)
        if (m[r][0] != seed || m[r][1] != 5) return 11;
    if (m[3][0] != 0 || m[3][1] != 0) return 12;
    return 0;
}

int main(void) {
    int r;
    if ((r = check_struct_ranges(13))) return r;
    if ((r = check_member_range(17))) return r;
    if ((r = check_row_range(29))) return r;
    return 0;
}
