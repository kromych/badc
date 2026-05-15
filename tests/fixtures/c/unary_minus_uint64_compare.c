// Locks C99 6.5.3.3 paragraph 3: the integer promotions are
// performed on the operand of unary `-`, and the result has the
// promoted operand type. Collapsing the result to `int` after the
// negation truncates an `unsigned long long` operand to 32 bits.
//
// Surfaced in c5's compile of upstream tinycc on AArch64. In
// `arm64-gen.c`'s `load()`:
//
//   uint64_t svcoff = (uint64_t)(int64_t)(int32_t)sv->c.i;
//   if (-svcoff < 0x1000)
//       o(0xd10003a0 | intr(r) | -svcoff << 10);   // 1-instr SUB
//   else { arm64_movimm(30, -svcoff); ... }        // 2-instr form
//
// With `svcoff = 0xa8`, the operand of `-` is unsigned 64-bit, so
// `-svcoff = 0xffffffffffffff58`. The unsigned comparison against
// `0x1000` is false, so the 2-instruction branch must fire. When
// the unary-minus result was forced to `int`, the high half was
// dropped, `-svcoff` became `0xffffff58` reinterpreted as the
// signed `-168`, the signed `< 0x1000` check went the wrong way,
// and the emitted bytes shifted the 16-bit overflow into the
// instruction's opcode field, producing illegal instructions.
//
// Each failure returns a distinct nonzero code so the cause of a
// regression is visible from the exit alone.
//
// Stand-alone -- no headers.

typedef unsigned long long uint64_t;
typedef long long int64_t;

int main(void) {
    // Direct comparison, inline negation. C99 says result of
    // unary `-` has the promoted operand type (unsigned long long
    // here), so the comparison runs unsigned 64-bit.
    {
        uint64_t svcoff = 0xa8ULL;
        if ((-svcoff) < 0x1000) return 11;
    }

    // Same shape with svcoff loaded from a struct field, matching
    // the upstream `sv->c.i` access pattern.
    {
        struct { long long i; } sv = { 0xa8 };
        uint64_t svcoff = (uint64_t)(int64_t)(int)sv.i;
        if ((-svcoff) < 0x1000) return 12;
    }

    // Negation fed into ternary that decides between two
    // computations. The wrong-type comparison would have routed
    // the large operand through the small-branch path -- which
    // is exactly the upstream tinycc bug the fix unblocks.
    {
        uint64_t svcoff = 0xa8ULL;
        int picked = ((-svcoff) < 0x1000) ? 1 : 2;
        if (picked != 2) return 13;
    }

    // Sanity: a positive operand of `-` still works -- C99
    // unsigned negation wraps to a large value, not zero.
    {
        uint64_t svcoff = 8ULL;
        if ((-svcoff) < 0x1000) return 14;
    }

    return 0;
}
