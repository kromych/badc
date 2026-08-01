// C99 6.7.5.2p4/p6 through `__builtin_types_compatible_p`: `T (*)[]`
// names a pointer to an incomplete array type; dereferencing it in a
// `typeof` operand yields that array type, whose unspecified bound is
// compatible with any bound of the same element type. Pointers to array
// types are compatible when the pointees are (6.7.5.1p2). Top-level
// qualifiers are dropped, and qualifiers written on an array type apply
// to the element (6.7.3p8), which the comparison also drops. Every
// expectation matches gcc. Returns 0 on success; distinct non-zero per
// failure.

struct elem {
    int v;
};

struct outer {
    int before;
    struct elem tab[4];
};

// The compile-time guard shape a member-to-container conversion uses:
// the operand pointer recast to `const T (*)[]`, dereferenced under
// `typeof`, against `typeof` of the container's array member.
_Static_assert(
    __builtin_types_compatible_p(typeof(*((const struct elem(*)[])0)),
                                 typeof(((struct outer *)0)->tab)),
    "deref of const T (*)[] ~ member T[4]");
_Static_assert(
    __builtin_types_compatible_p(typeof(*((struct elem(*)[])0)),
                                 typeof(((struct outer *)0)->tab)),
    "deref of T (*)[] ~ member T[4]");

// The dereferenced row against written array type names.
_Static_assert(__builtin_types_compatible_p(typeof(*((struct elem(*)[])0)),
                                            struct elem[]) == 1,
               "deref ~ T[]");
_Static_assert(__builtin_types_compatible_p(typeof(*((struct elem(*)[])0)),
                                            struct elem[4]) == 1,
               "deref ~ T[4]");
_Static_assert(__builtin_types_compatible_p(typeof(*((struct elem(*)[])0)),
                                            struct elem *) == 0,
               "deref !~ T *");
_Static_assert(__builtin_types_compatible_p(typeof(*((struct elem(*)[])0)),
                                            struct elem) == 0,
               "deref !~ T");

// Pointers to array types: an unspecified pointee bound is compatible
// with any, specified bounds must agree, and the element must match.
_Static_assert(__builtin_types_compatible_p(struct elem(*)[],
                                            struct elem(*)[4]) == 1,
               "(*)[] ~ (*)[4]");
_Static_assert(__builtin_types_compatible_p(struct elem(*)[4],
                                            struct elem(*)[8]) == 0,
               "(*)[4] !~ (*)[8]");
_Static_assert(__builtin_types_compatible_p(int(*)[], char(*)[4]) == 0,
               "element type");
_Static_assert(__builtin_types_compatible_p(int(*)[], int *) == 0,
               "(*)[] !~ elem ptr");

// A sized deref keeps its bound; a zero-length bound stays 0, not
// unspecified.
_Static_assert(__builtin_types_compatible_p(typeof(*((int(*)[4])0)),
                                            int[4]) == 1,
               "sized deref ~ [4]");
_Static_assert(__builtin_types_compatible_p(typeof(*((int(*)[0])0)),
                                            int[4]) == 0,
               "[0] deref !~ [4]");
_Static_assert(__builtin_types_compatible_p(typeof(*((int(*)[0])0)),
                                            int[0]) == 1,
               "[0] deref ~ [0]");

// Multi-dimensional rows: the deref recovers every dimension, with an
// unspecified outer bound matching any and the inner bounds compared.
_Static_assert(__builtin_types_compatible_p(typeof(*((int(*)[5][3])0)),
                                            int[5][3]) == 1,
               "deref [5][3]");
_Static_assert(__builtin_types_compatible_p(typeof(*((int(*)[][3])0)),
                                            int[5][3]) == 1,
               "deref [][3] ~ [5][3]");
_Static_assert(__builtin_types_compatible_p(typeof(*((int(*)[][3])0)),
                                            int[5][4]) == 0,
               "deref [][3] !~ [5][4]");

static struct outer container;

// The full container-of shape: recast a member pointer to the row type,
// assert element-type identity, and step back to the container.
static struct outer *to_outer(struct elem *e, int idx) {
    void *member = (void *)((const struct elem(*)[]) & e[-idx]);
    _Static_assert(
        __builtin_types_compatible_p(typeof(*((const struct elem(*)[]) &
                                              e[-idx])),
                                     typeof(((struct outer *)0)->tab)) ||
            __builtin_types_compatible_p(typeof(*((const struct elem(*)[]) &
                                                  e[-idx])),
                                         typeof(void)),
        "member row type");
    return (struct outer *)((char *)member -
                            __builtin_offsetof(struct outer, tab));
}

int main(void) {
    // Runtime (non-constant) contexts run the same comparison.
    int r1 = __builtin_types_compatible_p(typeof(*((struct elem(*)[])0)),
                                          typeof(((struct outer *)0)->tab));
    if (r1 != 1) {
        return 1;
    }
    int r2 = __builtin_types_compatible_p(struct elem(*)[], struct elem(*)[9]);
    if (r2 != 1) {
        return 2;
    }
    // `_Generic` selects through the same compatibility rule: a pointer
    // to an incomplete array matches the sized association.
    int r3 = _Generic((int(*)[])0, int(*)[7] : 1, default : 0);
    if (r3 != 1) {
        return 3;
    }
    // Element access through the dereferenced row scales by the element.
    container.tab[2].v = 42;
    struct elem *row = *((struct elem(*)[]) & container.tab[0]);
    if (row[2].v != 42) {
        return 4;
    }
    // The recovered container pointer round-trips.
    if (to_outer(&container.tab[3], 3) != &container) {
        return 5;
    }
    return 0;
}
