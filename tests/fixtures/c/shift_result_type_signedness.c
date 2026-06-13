// C99 6.5.7: the result of `E1 << E2` has the type of the promoted left
// operand, not the shift count `E2`. A cast of a shift result to a signed
// type therefore reads the operand's (unsigned) type and must sign-extend.
// The BJSON limb sign-extension `(int32_t)(v << shift) >> shift` relied on
// this: when the `<<` node carried the shift count's signed `int` type, the
// cast saw a signed-to-signed same-width conversion and skipped the
// extension, so a negative limb deserialized as a large positive value.
// Asserted by return code.

static int sext(unsigned v, int shift) {
    return (int)(v << shift) >> shift;
}

int main(void) {
    if (sext(0xFB, 24) != -5) return 1;     // high byte 0xFB -> -5
    if (sext(0xFF, 24) != -1) return 2;
    if (sext(0x80, 24) != -128) return 3;   // sign bit set
    if (sext(0x7F, 24) != 127) return 4;    // sign bit clear stays positive
    // A short LHS promotes to signed int (6.5.7); the count's type is
    // irrelevant to the result type.
    unsigned short s = 0x8000;
    if ((int)(s << 16) >> 16 == 0) return 5; // exercises the promote path
    return 0;
}
