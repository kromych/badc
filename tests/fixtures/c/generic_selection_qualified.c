// C11 6.5.1.1 `_Generic` and GCC `__builtin_types_compatible_p` over
// qualified types. The controlling expression undergoes lvalue conversion
// (6.5.1.1p2), so a `const` on the object itself never selects, while a
// pointee's `const` is part of the type (6.7.3p9): `const T *` and `T *`
// are distinct associations. Every expectation matches clang.
// Returns 0 on success; distinct non-zero per failure.

struct St {
    int x;
    int arr[2];
    char *name;
};
typedef int row[3];

int pick(struct St *s) { return _Generic(s, const struct St *: 1, struct St *: 2); }
int pickc(const struct St *s) { return _Generic(s, const struct St *: 1, struct St *: 2); }
int pickw(struct St *s) { return _Generic(s, struct St *: 2, const struct St *: 1); }

// Constant-expression contexts: the builtin drops the qualifiers on the
// types themselves and compares a pointee's.
_Static_assert(__builtin_types_compatible_p(const int, int) == 1, "object const");
_Static_assert(__builtin_types_compatible_p(int *const, int *) == 1, "object const, pointer");
_Static_assert(__builtin_types_compatible_p(const int *, int *) == 0, "pointee const");
_Static_assert(__builtin_types_compatible_p(const int **, int *const *) == 0, "level");
_Static_assert(__builtin_types_compatible_p(const int *const *, const int *const *) == 1, "same");
_Static_assert(__builtin_types_compatible_p(const void *, void *) == 0, "const void");
_Static_assert(__builtin_types_compatible_p(const int[3], int[3]) == 1, "array element const");
_Static_assert(__builtin_types_compatible_p(const int (*)[3], int (*)[3]) == 0, "array pointee");
_Static_assert(__builtin_types_compatible_p(int (*)(int), int (*)(const int)) == 1, "param object");
_Static_assert(__builtin_types_compatible_p(int (*)(int *), int (*)(const int *)) == 0, "param pointee");

int main(void) {
    int x = 0;
    const int cx = 0;
    int *const cp = &x;
    const int *pc = &x;
    const int *const cpc = &x;
    const int ca[3] = {0, 0, 0};
    const struct St cs = {1, {0, 0}, 0};
    const struct St *ps = &cs;
    const row *pr = &ca;

    if (pick(0) * 10 + pickc(0) != 21) return 1;
    if (pickw(0) != 2) return 2;

    // A qualified association never matches a converted controlling
    // expression.
    if (_Generic(x, const int: 1, int: 2) != 2) return 3;
    if (_Generic(cx, const int: 1, int: 2) != 2) return 4;
    if (_Generic(cp, int *const: 1, int *: 2) != 2) return 5;

    // A pointee's qualification is part of the type; array-to-pointer
    // conversion keeps the element's.
    if (_Generic(pc, const int *: 1, int *: 2) != 1) return 6;
    if (_Generic(ca, const int *: 1, int *: 2) != 1) return 7;
    if (_Generic(&cx, const int *: 1, int *: 2) != 1) return 8;
    if (_Generic(*pc, const int: 1, int: 2) != 2) return 9;
    if (_Generic(pr, const int (*)[3]: 1, int (*)[3]: 2) != 1) return 10;

    // 6.5.2.3p3: a member of a const object is const.
    if (_Generic(&ps->x, const int *: 1, int *: 2) != 1) return 11;
    if (_Generic(&cs.x, const int *: 1, int *: 2) != 1) return 12;
    if (_Generic(cs.arr, const int *: 1, int *: 2) != 1) return 13;
    if (_Generic(cs.name, char *const: 1, char *: 2) != 2) return 14;

    // Rvalues are unqualified: arithmetic (6.5.6), casts (6.5.4p5),
    // assignment (6.5.16p3).
    if (_Generic(&(typeof(cx + 1)){0}, const int *: 1, int *: 2) != 2) return 15;
    if (_Generic(&(typeof((const int)x)){0}, const int *: 1, int *: 2) != 2) return 16;
    if (_Generic(&(typeof(x = cx)){0}, const int *: 1, int *: 2) != 2) return 17;
    if (_Generic(&(typeof(cpc + 1)){0}, const int **: 1, const int *const *: 2) != 1) return 18;

    // 6.5.15p6: the conditional's result carries both pointees'
    // qualifiers.
    if (_Generic(1 ? cp : pc, const int *: 1, int *: 2) != 1) return 19;
    if (_Generic(1 ? pc : cp, const int *: 1, int *: 2) != 1) return 20;
    if (_Generic(1 ? (void *)&x : pc, const void *: 1, void *: 2) != 1) return 21;

    // `typeof` keeps the qualification the declaration spelled.
    if (_Generic(&(typeof(cx)){0}, const int *: 1, int *: 2) != 1) return 22;
    if (_Generic(&(typeof(ca)){0}, const int (*)[3]: 1, int (*)[3]: 2) != 1) return 23;

    // Runtime value contexts of the builtin.
    if (__builtin_types_compatible_p(typeof(cx), int) != 1) return 24;
    if (__builtin_types_compatible_p(typeof(pc), int *) != 0) return 25;
    if (__builtin_types_compatible_p(typeof(pc), const int *) != 1) return 26;
    if (_Generic((const char *const *)0, const char *const *: 1, const char **: 2, char **: 3) != 1)
        return 27;

    // A value's type drops the object's own `const` (6.3.2.1p2): pointer
    // difference and comparison see one pointer type.
    if (cp - &x != 0 || &x - cp != 0 || (cp + 1) - cp != 1) return 28;
    if (!(cp == &x) || cp != pc || cpc - pc != 0) return 29;
    return 0;
}
