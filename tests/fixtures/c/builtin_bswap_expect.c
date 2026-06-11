// GCC byte-swap and branch-hint builtins, available with no header.
// __builtin_bswap16/32/64 reverse the byte order of a value;
// __builtin_expect evaluates to its first operand (the hint is not
// consumed); __builtin_unreachable marks a point control must not reach
// and lowers to a trap. Asserted against hand-computed values so the
// fixture runs on every lane including the interpreter.

int main(void) {
    if (__builtin_bswap16(0x0102u) != 0x0201u) return 1;
    if (__builtin_bswap32(0x01020304u) != 0x04030201u) return 2;
    if (__builtin_bswap64(0x0102030405060708ull) != 0x0807060504030201ull) return 3;

    // A non-constant operand exercises the runtime path.
    volatile unsigned r = 0xAABBCCDDu;
    if (__builtin_bswap32(r) != 0xDDCCBBAAu) return 4;

    int x = 5;
    if (__builtin_expect(x == 5, 1) != 1) return 5;
    if (__builtin_expect(x, 0) != 5) return 6;

    // Never taken: must compile and link.
    if (x != 5) __builtin_unreachable();
    return 0;
}
