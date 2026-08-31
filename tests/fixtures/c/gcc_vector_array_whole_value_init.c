// C99 6.7.8p13 over the GCC vector extension: an initializer for an object
// of vector type is either a brace list of lanes or a single expression of
// compatible vector type. The second form has to hold where the object is
// an array element or an array member of a struct -- the shape the kernel's
// AEGIS-128 NEON unit uses -- because the vector is modeled as an aggregate
// of lanes and the traversal would otherwise elide into it and spend one
// sibling value per lane.

typedef __attribute__((vector_size(16))) unsigned char u8x16;

struct state {
    u8x16 v[3];
};

static unsigned char lane(u8x16 v, int i) { return ((unsigned char *)&v)[i]; }

// A designated lane list at file scope stages constant bytes.
static u8x16 statics[2] = {[1] = {9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9}};

int main(void) {
    u8x16 a = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
    u8x16 b = {21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36};
    u8x16 c = {41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56};

    // Array of vectors, whole-value elements.
    u8x16 arr[3] = {a, b, c};
    if (lane(arr[0], 0) != 1 || lane(arr[0], 15) != 16) return 1;
    if (lane(arr[1], 0) != 21 || lane(arr[1], 15) != 36) return 2;
    if (lane(arr[2], 0) != 41 || lane(arr[2], 15) != 56) return 3;

    // Struct whose member is an array of vectors, braced.
    struct state s = {{a, b, c}};
    if (lane(s.v[0], 0) != 1 || lane(s.v[0], 15) != 16) return 4;
    if (lane(s.v[1], 0) != 21 || lane(s.v[1], 15) != 36) return 5;
    if (lane(s.v[2], 0) != 41 || lane(s.v[2], 15) != 56) return 6;

    // The same list with the member's braces elided (C99 6.7.8p20).
    struct state e = {a, b, c};
    if (lane(e.v[0], 0) != 1 || lane(e.v[2], 15) != 56) return 7;

    // A short list zero-fills the rest (C99 6.7.8p21).
    u8x16 part[3] = {c};
    if (lane(part[0], 0) != 41) return 8;
    if (lane(part[1], 0) != 0 || lane(part[2], 15) != 0) return 9;

    // Lane brace lists still name lanes, mixed with whole-vector siblings.
    u8x16 mixed[2] = {{7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7}, b};
    if (lane(mixed[0], 0) != 7 || lane(mixed[0], 15) != 7) return 10;
    if (lane(mixed[1], 0) != 21 || lane(mixed[1], 15) != 36) return 11;

    // A compound literal element names the vector type itself.
    u8x16 lit[2] = {(u8x16){3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3}, a};
    if (lane(lit[0], 7) != 3 || lane(lit[1], 7) != 8) return 12;

    // Designated elements take a whole vector too (C99 6.7.8p17).
    u8x16 des[3] = {[2] = a, [0] = b};
    if (lane(des[0], 0) != 21 || lane(des[2], 0) != 1) return 13;
    if (lane(des[1], 0) != 0 || lane(des[1], 15) != 0) return 14;

    // The GNU range designator replicates the value across the range.
    u8x16 rng[3] = {[0 ... 2] = c};
    if (lane(rng[0], 0) != 41 || lane(rng[1], 9) != 50 || lane(rng[2], 15) != 56)
        return 15;

    // A two-dimensional array of vectors keeps the element stride.
    u8x16 grid[2][2] = {{a, b}, {c, a}};
    if (lane(grid[0][0], 0) != 1 || lane(grid[0][1], 0) != 21) return 16;
    if (lane(grid[1][0], 0) != 41 || lane(grid[1][1], 15) != 16) return 17;

    // An array of structs whose member is an array of vectors.
    struct state pair[2] = {{{a, b, c}}, {{c, b, a}}};
    if (lane(pair[0].v[0], 0) != 1 || lane(pair[0].v[2], 0) != 41) return 18;
    if (lane(pair[1].v[0], 0) != 41 || lane(pair[1].v[2], 0) != 1) return 19;

    // A struct whose plain member is a vector, as an array element.
    struct holder { u8x16 x; int n; };
    struct holder hs[2] = {{a, 5}, {b, 6}};
    if (lane(hs[0].x, 0) != 1 || hs[0].n != 5) return 21;
    if (lane(hs[1].x, 15) != 36 || hs[1].n != 6) return 22;

    // A constant lane-list array stays a staged blob.
    u8x16 konst[2] = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                      {2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2}};
    if (lane(konst[0], 15) != 1 || lane(konst[1], 0) != 2) return 20;

    if (lane(statics[1], 0) != 9 || lane(statics[0], 15) != 0) return 23;

    return 0;
}
