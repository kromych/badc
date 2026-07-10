// A subscripted row of a multi-dimensional array is itself an array, so
// `typeof(arr2d[i])` is an array type -- not the pointer it decays to in a
// value context. A real-world shape relies on this via
// `ARRAY_SIZE(to_check[THROTTLE_READ])` over a `to_check[THROTTLE_MAX][4]`
// table. The same holds for a `*p` pointer-to-array row deref and a string
// literal. Returns 0 on success; distinct non-zero per fail.

#define IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), typeof(&(x)[0])))
#define BUG_STRUCT(x)                                                          \
    struct {                                                                   \
        int : (x) ? -1 : 1;                                                    \
    }
#define BUG_ON_ZERO(x) (int)(sizeof(BUG_STRUCT(x)) - sizeof(BUG_STRUCT(x)))
#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + BUG_ON_ZERO(!IS_ARRAY(x)))

enum { THROTTLE_READ = 0, THROTTLE_WRITE = 1, THROTTLE_MAX = 2 };

int main(void) {
    int arr2d[3][4];
    int arr3d[3][4][5];
    int arr1d[5];
    int (*p2)[4] = arr2d;
    static const int to_check[THROTTLE_MAX][4];

    // A row of a 2-D array is an array; its decayed pointer is not.
    if (IS_ARRAY(arr2d[1]) != 1) {
        return 1;
    }
    // A row of a 3-D array is an array at every partial-subscript depth.
    if (IS_ARRAY(arr3d[1]) != 1 || IS_ARRAY(arr3d[1][2]) != 1) {
        return 2;
    }
    // `*p` where p is a pointer to array yields the row (array), like p[0].
    if (IS_ARRAY(*p2) != 1) {
        return 3;
    }
    // A string literal has array type char[N].
    if (IS_ARRAY("hello") != 1) {
        return 4;
    }
    // Address-of a scalar element is a pointer, never an array.
    if (IS_ARRAY(&arr1d[0]) != 0) {
        return 5;
    }
    // ARRAY_SIZE over a row recovers the inner dimension.
    if (ARRAY_SIZE(to_check[THROTTLE_READ]) != 4) {
        return 6;
    }
    if (ARRAY_SIZE(arr3d[1]) != 4 || ARRAY_SIZE(arr3d[1][2]) != 5) {
        return 7;
    }
    return 0;
}
