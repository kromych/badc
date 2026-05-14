// Locks C99 6.2.1 paragraph 4 (the inner-scope shadow rule) for
// the case where a function prototype reuses the spelling of an
// outer typedef as a parameter name. While parsing the prototype
// the typedef is hidden by the parameter binding; on `)` (end of
// prototype scope) the outer typedef must reappear unchanged.
//
// The pre-fix parser left the typedef's array dimension cleared
// to zero after the prototype, so a later declaration of the
// typedef's name decayed from `long[64]` to a scalar `long`.
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

#include <stddef.h>

typedef long jmp_buf[64];

// Parameter name reuses the typedef spelling. Standard scope
// ends at the closing `)`.
void shadow_proto(void *jmp_buf);

struct S { jmp_buf b; };

int main(void) {
    jmp_buf       loose;
    struct S      s;

    if (sizeof(loose) != 64 * sizeof(long)) return 11;
    if (sizeof(s.b)   != 64 * sizeof(long)) return 12;
    if (sizeof(s)     != 64 * sizeof(long)) return 13;
    return 0;
}
