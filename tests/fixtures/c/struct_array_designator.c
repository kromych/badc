// C99 6.7.8p7 array designator on a struct-array element. The
// known-size constant-staging path used to surface "struct array
// element must be a brace list" on the leading `[`; it now
// resolves `[K] = {field, ...}` to the element at index K and
// resumes positional iteration after the jump. Unspecified
// indices stay zero per C99 6.7.8p21.

struct point { int x; int y; };

static struct point sized[3] = {
    [2] = {30, 31},
    [0] = {10, 11},
};

int main(void) {
    if (sized[0].x != 10 || sized[0].y != 11) return 1;
    if (sized[1].x != 0 || sized[1].y != 0) return 2;
    if (sized[2].x != 30 || sized[2].y != 31) return 3;
    return 0;
}
