// C99 6.7.8p20: the braces around each element of an array of structs
// may be elided, with the flat value list filling consecutive elements.
// This holds for a top-level array of structs (not only a struct member
// array) at file scope, block scope, and for a static local, in both
// known-size and size-from-initializer (`[]`) forms. Omitted trailing
// elements are zero (6.7.8p21).
//
// Before the fix these paths rejected an elided element, and the known-
// size static-local path wrote each scalar with the struct's byte width,
// overrunning the pre-allocated region (panic).
struct P {
    int a;
    int b;
};

static struct P fs_known[3] = { 1, 2, 3, 4, 5, 6 };
static struct P fs_unsized[] = { 10, 20, 30, 40 }; // 2 elements

int main(void) {
    struct P bs_known[2] = { 100, 200, 300, 400 };
    struct P bs_unsized[] = { 11, 12, 13, 14, 15, 16 }; // 3 elements
    static struct P sl_known[3] = { 7, 8, 9, 10 };      // sl_known[2] zero
    static struct P sl_unsized[] = { 21, 22, 23, 24 };  // 2 elements

    if (fs_known[0].a != 1 || fs_known[2].b != 6) return 1;
    if (sizeof(fs_unsized) / sizeof(fs_unsized[0]) != 2) return 2;
    if (fs_unsized[1].a != 30) return 3;

    if (bs_known[0].b != 200 || bs_known[1].a != 300) return 4;
    if (sizeof(bs_unsized) / sizeof(bs_unsized[0]) != 3) return 5;
    if (bs_unsized[2].b != 16) return 6;

    if (sl_known[1].a != 9 || sl_known[2].a != 0) return 7; // trailing zero
    if (sizeof(sl_unsized) / sizeof(sl_unsized[0]) != 2) return 8;
    if (sl_unsized[1].b != 24) return 9;

    // A mix of braced and elided elements in one list.
    struct P mixed[3] = { { 1, 2 }, 3, 4, { 5, 6 } };
    if (mixed[1].a != 3 || mixed[2].b != 6) return 10;
    return 0;
}
