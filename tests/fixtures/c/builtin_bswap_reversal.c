// __builtin_bswap16/32/64 with a runtime operand lower to the
// byte-reversal instruction (x86-64 `bswap` / `movzx`+`rol`, aarch64
// `rev` / `rev`+`lsr`), not a per-byte shift / mask sequence. One
// function per width keeps each lowering visible in the snapshots.
//
// Returns 0 on success, otherwise the number of the failing check.

unsigned long long swap16(unsigned short x) {
    return __builtin_bswap16(x);
}

unsigned long long swap32(unsigned int x) {
    return __builtin_bswap32(x);
}

unsigned long long swap64(unsigned long long x) {
    return __builtin_bswap64(x);
}

int main(void) {
    // Volatile operands so the checks exercise the runtime lowering
    // rather than the constant fold.
    volatile unsigned short h = 0xabcd;
    volatile unsigned int w = 0x11223344u;
    volatile unsigned long long v = 0x0102030405060708ull;

    if (swap16(h) != 0xcdab) {
        return 1;
    }
    if (swap32(w) != 0x44332211u) {
        return 2;
    }
    if (swap64(v) != 0x0807060504030201ull) {
        return 3;
    }

    // The operand converts to the operation's width first (C99
    // 6.5.2.2p7), so a wider value is truncated before the reversal
    // and the 16- / 32-bit results are zero-extended.
    if (__builtin_bswap16(v) != 0x0807) {
        return 4;
    }
    if (__builtin_bswap32(v) != 0x08070605u) {
        return 5;
    }
    if (__builtin_bswap16(w) != 0x4433) {
        return 6;
    }
    return 0;
}
