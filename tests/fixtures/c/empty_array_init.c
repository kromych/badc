// A file-scope array with an empty initializer `T x[] = {}` has zero
// elements but keeps its element type: it decays to a pointer when indexed,
// `sizeof` reports 0, and `typeof(x)` stays distinct from `typeof(&x[0])`.
// The `ARRAY_SIZE`-style macro below combines all three -- the
// `__builtin_types_compatible_p` guard rejects a decayed pointer -- and
// evaluates to 0 for an empty array and N for a sized one.
#define IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), typeof(&(x)[0])))
#define BUILD_BUG_STRUCT(x) struct { int : (x) ? -1 : 1; }
#define BUILD_BUG_ZERO(x) (sizeof(BUILD_BUG_STRUCT(x)) - sizeof(BUILD_BUG_STRUCT(x)))
#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + BUILD_BUG_ZERO(!IS_ARRAY(x)))

static const struct {
    const char *name;
    long long value;
} empty[] = {
};

static int sized[] = { 10, 20, 30 };

int main(void) {
    int i, sum = 0;
    // Block-scope empty arrays (automatic and static) take the local
    // declaration path; all-`#if`'d-out element lists reduce to this shape.
    int local_empty[] = {};
    static int static_empty[] = {};
    if (sizeof(empty) != 0) return 1;
    if (ARRAY_SIZE(empty) != 0) return 2;
    // The element type survives: `&empty[0]` is a valid pointer expression.
    if (&empty[0] != (void *) empty) return 3;
    // Non-empty arrays are unaffected.
    if (ARRAY_SIZE(sized) != 3) return 4;
    if (sizeof(sized) != 3 * (int) sizeof(int)) return 5;
    for (i = 0; i < (int) ARRAY_SIZE(sized); i++) {
        sum += sized[i];
    }
    if (sum != 60) return 6;
    if (sizeof(local_empty) != 0 || ARRAY_SIZE(local_empty) != 0) return 7;
    if (sizeof(static_empty) != 0 || ARRAY_SIZE(static_empty) != 0) return 8;
    return 0;
}
