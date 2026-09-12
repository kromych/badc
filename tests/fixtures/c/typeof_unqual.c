// C23 6.7.2.5 `typeof_unqual` and its GNU spellings `__typeof_unqual__` /
// `__typeof_unqual`: the operand's type without the qualifiers on the type
// itself. A pointee's qualification stays, an array's elements lose theirs
// (6.7.3p10 makes an array's qualifiers its elements'), and the operand may
// be a type name or an expression. Every expectation matches clang.
// Returns 0 on success; distinct non-zero per failure.

struct S {
    int x;
};

// The `READ_ONCE` shape: the scalar type of the operand, requalified.
int f(const volatile int *p) {
    return *(const volatile __typeof_unqual__(*(int *)p) *)&(*(int *)p);
}

// Type-name operands.
_Static_assert(__builtin_types_compatible_p(typeof_unqual(const int), int) == 1, "const int");
_Static_assert(__builtin_types_compatible_p(typeof_unqual(int *const), int *) == 1, "int *const");
_Static_assert(__builtin_types_compatible_p(typeof_unqual(const int *), const int *) == 1, "pointee");
_Static_assert(__builtin_types_compatible_p(typeof_unqual(const int *), int *) == 0, "pointee kept");
_Static_assert(__builtin_types_compatible_p(__typeof_unqual(const struct S), struct S) == 1, "struct");
_Static_assert(sizeof(typeof_unqual(const int[3])) == 3 * sizeof(int), "array");

int main(void) {
    int x = 7;
    const int cx = 0;
    int *const cp = &x;
    const int *pc = &x;
    const int ca[3] = {0, 0, 0};
    const struct S cs = {1};

    if (f(&x) != 7) return 1;

    // `typeof` keeps the object's qualification, `typeof_unqual` drops it.
    if (_Generic(&(typeof(cx)){0}, const int *: 1, int *: 2) != 1) return 2;
    if (_Generic(&(typeof_unqual(cx)){0}, const int *: 1, int *: 2) != 2) return 3;
    if (_Generic(&(__typeof_unqual__(cp)){0}, int *const *: 1, int **: 2) != 2) return 4;

    // A pointee's stays.
    if (_Generic(&(typeof_unqual(pc)){0}, const int **: 1, int **: 2) != 1) return 5;
    if (__builtin_types_compatible_p(typeof_unqual(pc), const int *) != 1) return 6;

    // An array's elements are unqualified with it.
    if (_Generic(&(typeof(ca)){0}, const int (*)[3]: 1, int (*)[3]: 2) != 1) return 7;
    if (_Generic(&(typeof_unqual(ca)){0}, const int (*)[3]: 1, int (*)[3]: 2) != 2) return 8;
    if (sizeof(typeof_unqual(ca)) != sizeof ca) return 9;

    // A struct object.
    if (_Generic(&(typeof_unqual(cs)){0}, const struct S *: 1, struct S *: 2) != 2) return 10;
    if (_Generic(&(typeof_unqual(cs.x)){0}, const int *: 1, int *: 2) != 2) return 11;

    // A declaration through the specifier is a plain object.
    typeof_unqual(cx) y = cx;
    y = 3;
    if (y != 3) return 12;
    typeof_unqual(ca) copy = {1, 2, 3};
    copy[1] = 5;
    if (copy[0] + copy[1] + copy[2] != 9) return 13;
    __typeof_unqual(pc) q = pc;
    if (*q != 7) return 14;
    return 0;
}
