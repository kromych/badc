// Locks C99 6.5.3.4 -- `sizeof` does not evaluate its operand.
// The idiom `sizeof ((T *)0)->m` is the standard way to fetch
// the size of a struct member without instantiating the struct;
// the cast-from-zero and the `->` are never executed. The same
// shape underlies `offsetof` (already shipped via `<stddef.h>`).
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#include <stddef.h>

struct Stab_Sym {
    int  n_value;
    char n_type;
    short n_desc;
    int  n_strx;
};

struct Nested {
    struct {
        // long long is 8 bytes on every supported target;
        // `long` would be 4 bytes on Windows LLP64.
        long long deep;
    } inner;
};

int main(void) {
    // Scalar member, four positions of the same idiom.
    if (sizeof ((struct Stab_Sym *)0)->n_value != 4) return 11;
    if (sizeof ((struct Stab_Sym *)0)->n_type  != 1) return 12;
    if (sizeof ((struct Stab_Sym *)0)->n_desc  != 2) return 13;
    if (sizeof ((struct Stab_Sym *)0)->n_strx  != 4) return 14;

    // Nested struct member -- the `->` lands on a struct value,
    // then `.deep` selects a field.
    if (sizeof ((struct Nested *)0)->inner.deep != 8) return 15;

    // The `offsetof` macro from `<stddef.h>` is the
    // address-of-via-null-cast cousin; both must still work.
    if (offsetof(struct Stab_Sym, n_type) != 4) return 16;
    if (offsetof(struct Nested, inner.deep) != 0) return 17;

    return 0;
}
