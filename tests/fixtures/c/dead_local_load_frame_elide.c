// A slot load with no consumers emits no machine code, so it must not
// force a frame: an object that is never observed needs no storage
// (C99 6.2.4p2), and the loop leaf below compiles without a prologue.
// A volatile slot access is itself observable behaviour (5.1.2.3p2 /
// 6.7.3p6), is always emitted, and keeps the frame.

typedef unsigned char u8;
typedef unsigned long long u64;

u64 fold(const u8 *x) {
    u64 i, u = 0;
    for (i = 0; i < 8; i++) u = (u << 8) | x[i];
    return u;
}

long vol_keep(const u8 *x) {
    volatile long u = x[0];
    u;
    return 9;
}

int main(void) {
    u8 buf[8];
    u64 i;
    for (i = 0; i < 8; i++) buf[i] = (u8)(i + 1);
    if (fold(buf) != 0x0102030405060708ULL) return 1;
    if (vol_keep(buf) != 9) return 2;
    return 0;
}
