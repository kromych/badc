// Locks C99 6.5.3.3 paragraph 3: the integer promotions are
// performed on the operand of unary `-`, and the result has the
// promoted operand type. Truncating the result to `int` after
// the negation drops the high half of an `unsigned long long`
// operand, so a subsequent comparison or shift runs in `int`
// instead of the operand's actual width.
//
// Each failure returns a distinct nonzero code so the cause of a
// regression is visible from the exit alone.
//
// Stand-alone -- no headers.

typedef unsigned long long uint64_t;
typedef long long int64_t;

int main(void) {
    // Direct comparison, inline negation. The result of unary
    // `-` has the promoted operand type (unsigned long long
    // here), so the comparison runs unsigned 64-bit.
    // `-0xa8` as `unsigned long long` is `0xffffffffffffff58`,
    // which is not less than `0x1000`.
    {
        uint64_t svcoff = 0xa8ULL;
        if ((-svcoff) < 0x1000) return 11;
    }

    // Same shape with the operand loaded from a struct field
    // through the explicit truncation-then-widening cast chain
    // that some callers use to force a particular sign-extension.
    {
        struct { long long i; } sv = { 0xa8 };
        uint64_t svcoff = (uint64_t)(int64_t)(int)sv.i;
        if ((-svcoff) < 0x1000) return 12;
    }

    // Negation feeding a ternary that picks between two paths.
    // If the type collapses to `int`, the comparison reads the
    // truncated low half as a small negative signed value and
    // routes through the wrong branch.
    {
        uint64_t svcoff = 0xa8ULL;
        int picked = ((-svcoff) < 0x1000) ? 1 : 2;
        if (picked != 2) return 13;
    }

    // Sanity: a small positive operand of unary `-` still wraps
    // unsigned 64-bit to a huge value rather than producing
    // zero or a small negative.
    {
        uint64_t svcoff = 8ULL;
        if ((-svcoff) < 0x1000) return 14;
    }

    return 0;
}
