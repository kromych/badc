// `__typeof__(type-name)` accepts an abstract array type: `T [N]`, `T []`,
// and `T [N][M]` (C99 6.7.6 / the GCC extension). The result is the array
// type, so sizeof / _Alignof report the array's size and alignment and a
// declarator through the specifier is an array. An omitted bound is an
// incomplete array type -- compatible with any bound of the same element,
// and distinct from a pointer. Sizes match GCC and clang. Returns 0 on
// success; distinct non-zero per failure.

typedef unsigned long long u64;

// Compile-time array sizes / alignment, cross-checked against GCC and clang.
_Static_assert(sizeof(__typeof__(u64 [64])) == 512, "typeof 1-D array size");
_Static_assert(sizeof(__typeof__(int [2][3])) == 24, "typeof 2-D array size");
_Static_assert(_Alignof(__typeof__(u64 [64])) == _Alignof(u64), "typeof array alignment");
// An incomplete `T []` type name is an array type: compatible with any bound
// of the same element and not compatible with a pointer.
_Static_assert(__builtin_types_compatible_p(__typeof__(int []), int [7]),
               "incomplete array compatible with any bound");
_Static_assert(!__builtin_types_compatible_p(__typeof__(int []), int *),
               "incomplete array is not a pointer");
_Static_assert(!__builtin_types_compatible_p(__typeof__(int [4]), int *),
               "complete array is not a pointer");

// A file-scope object declared through the specifier is an array.
static __typeof__(u64 [4]) file_row;

int main(void) {
    // Declare and use an object of the typeof-array type.
    __typeof__(u64 [4]) a;
    for (int i = 0; i < 4; i++) a[i] = (u64)i * 100;
    if (a[0] != 0 || a[3] != 300 || sizeof(a) != 32) return 1;

    // Multi-dimensional: the per-row stride and total size are correct.
    __typeof__(int [2][3]) m;
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < 3; j++) m[i][j] = i * 10 + j;
    if (m[0][0] != 0 || m[1][2] != 12 || m[0][2] != 2 || sizeof(m) != 24) return 2;

    // The file-scope object is a real array of the right extent.
    file_row[2] = 9;
    if (file_row[2] != 9 || sizeof(file_row) != 32) return 3;

    // `T *[N]` is an array of pointers, not a pointer to an array.
    if (sizeof(__typeof__(u64 *[3])) != 3 * sizeof(u64 *)) return 4;

    // A pointer to an incomplete array is a well-formed pointer.
    __typeof__(int []) *p = 0;
    if (sizeof(p) != sizeof(void *)) return 5;
    (void)p;
    return 0;
}
