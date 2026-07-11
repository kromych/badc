// C99 6.7.2.1p16: a flexible array member has an (incomplete) array type,
// distinct from the pointer its name decays to. So
// `__builtin_types_compatible_p(typeof(m), typeof(&m[0]))` is false for a
// flexible array member `m` -- the array-detection idiom must see it as an
// array, exactly as it does a fixed-size array member and unlike a real
// pointer member.

#define IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), typeof(&(x)[0])))

// The build-time array assertion QEMU-style code layers on top: an empty
// bitfield of width 0 when the argument is true, a diagnostic (negative
// width) when false.
#define BUILD_ASSERT_STRUCT(x) struct { int : (-!!(x)); }
#define BUILD_ASSERT_ZERO(x) (sizeof(BUILD_ASSERT_STRUCT(x)) - sizeof(BUILD_ASSERT_STRUCT(x)))

struct flex {
    int len;
    unsigned short data[];
};

struct fixed {
    int len;
    unsigned short data[8];
};

struct with_ptr {
    int len;
    unsigned short *data;
};

int main(void) {
    // A flexible array member is an array, not a pointer.
    if (!IS_ARRAY(((struct flex *) 0)->data)) return 1;
    // A fixed-size array member is an array.
    if (!IS_ARRAY(((struct fixed *) 0)->data)) return 2;
    // A pointer member is not an array.
    if (IS_ARRAY(((struct with_ptr *) 0)->data)) return 3;

    // The build assertion over the flexible member folds to a width-0
    // bitfield (no negative width) and evaluates to 0.
    if (BUILD_ASSERT_ZERO(!IS_ARRAY(((struct flex *) 0)->data)) != 0) return 4;

    // A fixed array member's sizeof is unaffected.
    struct fixed f;
    if (sizeof(f.data) != 16) return 5;
    return 0;
}
