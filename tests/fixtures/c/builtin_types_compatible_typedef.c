// C99 6.7.7p3: a typedef name is the aliased type, so an array typedef
// in a `__builtin_types_compatible_p` type-name position is that array
// type, and `A *` over an array typedef names a pointer to the array.
// Every expectation below matches gcc. Returns 0 on success; distinct
// non-zero per failure.

typedef int T5[5];
typedef T5 TT;
typedef int TI[];
typedef int G23[2][3];
typedef int T0[0];
struct S { int x; };
typedef struct S SA[3];
static int a5[5];

// A bare array typedef is the array type: bound and element rules apply
// exactly as for the written-out form, through a chained alias and a
// qualified use (top-level qualifiers are dropped).
_Static_assert(__builtin_types_compatible_p(T5, int[5]) == 1, "T5 ~ [5]");
_Static_assert(__builtin_types_compatible_p(T5, int[]) == 1, "T5 ~ []");
_Static_assert(__builtin_types_compatible_p(T5, int[4]) == 0, "T5 !~ [4]");
_Static_assert(__builtin_types_compatible_p(T5, int *) == 0, "T5 !~ ptr");
_Static_assert(__builtin_types_compatible_p(TT, int[5]) == 1, "chained");
_Static_assert(__builtin_types_compatible_p(const T5, int[5]) == 1, "const T5");

// A deferred-bound typedef is an incomplete array type.
_Static_assert(__builtin_types_compatible_p(TI, int[5]) == 1, "TI ~ [5]");
_Static_assert(__builtin_types_compatible_p(TI, int[]) == 1, "TI ~ []");

// `A *` is a pointer to the array, not a pointer to the element.
_Static_assert(__builtin_types_compatible_p(T5 *, int (*)[5]) == 1, "T5 *");
_Static_assert(__builtin_types_compatible_p(T5 *, int (*)[4]) == 0, "bound");
_Static_assert(__builtin_types_compatible_p(T5 *, int *) == 0, "elem ptr");
_Static_assert(__builtin_types_compatible_p(T5 *, int (*)[]) == 1, "[] ptee");
_Static_assert(__builtin_types_compatible_p(T5 **, int (**)[5]) == 1, "**");

// Multi-dimensional and zero-length aliases keep their exact bounds.
_Static_assert(__builtin_types_compatible_p(G23, int[2][3]) == 1, "2x3");
_Static_assert(__builtin_types_compatible_p(G23, int[2][4]) == 0, "inner");
_Static_assert(__builtin_types_compatible_p(G23 *, int (*)[2][3]) == 1, "2x3 *");
_Static_assert(__builtin_types_compatible_p(T0, int[0]) == 1, "T0 ~ [0]");
_Static_assert(__builtin_types_compatible_p(T0, int[]) == 1, "T0 ~ []");

// Aggregate elements follow the same rules.
_Static_assert(__builtin_types_compatible_p(SA, struct S[3]) == 1, "struct arr");
_Static_assert(__builtin_types_compatible_p(SA, struct S *) == 0, "struct ptr");

int main(void) {
    // `typeof` of an array object composes with a pointer declarator the
    // same way the typedef does.
    if (__builtin_types_compatible_p(__typeof__(a5), T5) != 1) {
        return 1;
    }
    if (__builtin_types_compatible_p(__typeof__(a5) *, int (*)[5]) != 1) {
        return 2;
    }
    if (__builtin_types_compatible_p(__typeof__(a5) *, int *) != 0) {
        return 3;
    }
    return 0;
}
