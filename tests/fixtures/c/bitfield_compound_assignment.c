// Locks C99 6.5.16.2 -- a compound assignment `E1 OP= E2` is
// equivalent to `E1 = E1 OP E2` with `E1` evaluated once. C99
// 6.7.2.1 paragraph 10 makes a bitfield a valid lvalue subject
// to the same access rules as any other struct member, so the
// compound operators (`|=`, `&=`, `^=`, `+=`, `-=`, `<<=`,
// `>>=`) must work directly on a bitfield member.
//
// The fixture exercises the bit-twiddle subset (logical ops),
// arithmetic +=/-= that stay within the bitfield's value range,
// shift compound assignment, and that the bits adjacent to the
// updated field stay untouched.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

struct Bits {
    unsigned short a : 1;
    unsigned short b : 3;
    unsigned short c : 4;
    unsigned short d : 8;
};

int main(void) {
    struct Bits s;
    s.a = 0;
    s.b = 0;
    s.c = 0;
    s.d = 0;

    // OR-assign on width-1.
    s.b |= 5;
    if (s.b != 5) return 11;
    s.b |= 2;
    if (s.b != 7) return 12;

    // AND-assign keeps the masked-in bits.
    s.b &= 6;
    if (s.b != 6) return 13;

    // XOR-assign toggles bits within the field.
    s.b ^= 7;
    if (s.b != 1) return 14;

    // Adjacent fields must stay untouched after each step.
    s.a = 1;
    s.c = 12;
    s.d = 200;
    s.b ^= 7;
    if (s.a != 1)   return 15;
    if (s.b != 6)   return 16;
    if (s.c != 12)  return 17;
    if (s.d != 200) return 18;

    // Arithmetic compound ops -- within the field's value range.
    s.c += 1;
    if (s.c != 13) return 19;
    s.c -= 4;
    if (s.c != 9) return 20;

    // Shift compound assignment.
    s.d <<= 1;
    if (s.d != (200u << 1) % 256) return 21;
    s.c >>= 2;
    if (s.c != 2) return 22;

    return 0;
}
