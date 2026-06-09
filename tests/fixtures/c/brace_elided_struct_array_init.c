// C99 6.7.8p20: when a struct member is an array of structs, the braces
// around each element may be elided; the flat initializer list fills the
// elements' fields in order. A brace-elided element must consume exactly
// one struct's worth of fields, including a nested array field with its
// own (possibly partial) brace list. Omitted trailing elements are zero
// (6.7.8p21).
//
// Before the fix a brace-elided element was written as a single scalar
// with the struct's byte width, overflowing the initializer byte writer.
struct Out {
    int type;
    void *out;
    void *expected[2];
};

static char c0, c1, c2, c3;

// Fully brace-elided: each element's fields appear flat. The nested
// `expected[2]` member is partially initialized (second slot zero).
static struct {
    int line;
    struct Out outs[4];
} t = {
    7,
    { 1, &c0, { "a" }, 2, &c1, { "b", &c3 }, 3, &c2, { "c" } }
    // outs[3] omitted -> zero
};

int main(void) {
    if (t.line != 7) return 1;
    if (t.outs[0].type != 1 || t.outs[0].out != &c0) return 2;
    if (t.outs[0].expected[0] == 0 || t.outs[0].expected[1] != 0) return 3;
    if (t.outs[1].type != 2 || t.outs[1].expected[1] != &c3) return 4;
    if (t.outs[2].type != 3 || t.outs[2].out != &c2) return 5;
    if (t.outs[3].type != 0 || t.outs[3].out != 0) return 6; // zero-filled
    return 0;
}
