// C99 6.7.8p20: an array of structs may be initialized by a flat value
// list with the per-element braces elided. The array length is inferred
// from the value count divided by each element's scalar slot count.

struct one {
    long q;
};

struct two {
    int x, y;
};

// One value per element; the array length is two.
struct one a[] = {1, 0};

// Two values per element; the array length is two.
struct two b[] = {1, 2, 3, 4};

// A short final element zero-fills the rest (C99 6.7.9p21).
struct two c[] = {10, 20, 30};

int main(void) {
    if (a[0].q != 1 || a[1].q != 0) return 1;
    if (b[0].x != 1 || b[0].y != 2 || b[1].x != 3 || b[1].y != 4) return 2;
    if (c[0].x != 10 || c[0].y != 20 || c[1].x != 30 || c[1].y != 0) return 3;
    return 0;
}
