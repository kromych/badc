// M25 -- arrays as language types. Pre-M25 c5 required `int *xs =
// malloc(N * sizeof *xs);` for any array; this fixture pins:
//   - stack arrays of scalar types
//   - global arrays
//   - sizeof(arr) returning N * sizeof(elem)
//   - array-to-pointer decay (passing an array to a pointer-typed
//     parameter)
//   - struct arrays (correct per-element scaling)
//   - array fields inside a struct
//   - char arrays for string-shaped buffers
//
// Aggregate / brace initializers (`int xs[] = {1, 2, 3};`) are M28
// territory; this fixture only pins the bones.

int g_xs[5];
char g_buf[16];

struct Pair {
    int a;
    int b;
};

struct Histogram {
    int counts[8];
    int total;
};

static int sum_n(int *xs, int n) {
    int total;
    int i;
    total = 0;
    i = 0;
    while (i < n) {
        total = total + xs[i];
        i = i + 1;
    }
    return total;
}

int main() {
    int xs[5];
    int i;
    int total;
    struct Pair pairs[3];
    struct Histogram h;
    char local_buf[8];

    // Stack array of int.
    i = 0;
    while (i < 5) {
        xs[i] = i + 1;
        i = i + 1;
    }
    if (sum_n(xs, 5) != 15) return 1;
    // sizeof(xs) = 5 * sizeof(int) = 5 * 4 = 20 (M31).
    if (sizeof(xs) != 20) return 2;

    // Global arrays survive into the data segment.
    i = 0;
    while (i < 5) {
        g_xs[i] = i * 10;
        i = i + 1;
    }
    if (g_xs[0] + g_xs[1] + g_xs[2] + g_xs[3] + g_xs[4] != 100) return 3;
    if (sizeof(g_xs) != 20) return 4;       // 5 * sizeof(int) = 20
    if (sizeof(g_buf) != 16) return 5;

    // char buffer with byte-by-byte writes.
    g_buf[0] = 'h';
    g_buf[1] = 'i';
    g_buf[2] = 0;
    if (g_buf[0] != 'h') return 6;
    if (g_buf[1] != 'i') return 7;
    if (g_buf[2] != 0) return 8;

    // Stack array of struct -- per-element scaling must use
    // sizeof(struct Pair) = 16, not 8.
    i = 0;
    while (i < 3) {
        pairs[i].a = i;
        pairs[i].b = i * 100;
        i = i + 1;
    }
    if (pairs[0].a != 0) return 9;
    if (pairs[1].a != 1) return 10;
    if (pairs[2].b != 200) return 11;
    // struct Pair = {int a; int b;} = 8 bytes (4+4) under M31.
    // pairs[3] = 24 bytes total.
    if (sizeof(pairs) != 24) return 12;

    // Struct field that is itself an array.
    h.total = 0;
    i = 0;
    while (i < 8) {
        h.counts[i] = i + 1;
        h.total = h.total + h.counts[i];
        i = i + 1;
    }
    if (h.total != 36) return 13;

    // Local char buffer indexed by pointer arithmetic via decay.
    i = 0;
    while (i < 8) {
        local_buf[i] = 'A' + i;
        i = i + 1;
    }
    if (local_buf[0] != 'A') return 14;
    if (local_buf[7] != 'H') return 15;

    // Pointer-into-array: `&xs[2]` is a regular `int*` and pointer
    // arithmetic still works on the original-array storage.
    int *p;
    p = &xs[2];
    total = p[0] + p[1] + p[2];  // xs[2] + xs[3] + xs[4]
    if (total != 12) return 16;

    return 0;
}
