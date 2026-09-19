// A narrow parameter arrives in a register whose bits above its width are
// unspecified (AAPCS64 6.8.2, System V AMD64 3.2.3, the x64 convention).
// Each callee is reached through a volatile pointer whose type passes a
// 64-bit integer in that register, so a pattern sits above the narrow
// value. The callee must read its parameter at the declared width whether
// it only reads it or also assigns it in a loop, which is where the
// parameter leaves its frame slot for a register.

#define NOINLINE __attribute__((noinline))

typedef unsigned long long u64;
enum tone { LOW, HIGH };

NOINLINE static unsigned char step_u8(unsigned char x, int n) {
    for (int i = 0; i < n; i++) x = x * 3 + 1;
    return x;
}
NOINLINE static unsigned short step_u16(unsigned short x, int n) {
    for (int i = 0; i < n; i++) x = x * 3 + 1;
    return x;
}
NOINLINE static unsigned step_u32(unsigned x, int n) {
    for (int i = 0; i < n; i++) x = x * 3u + 1u;
    return x;
}
NOINLINE static signed char step_i8(signed char x, int n) {
    for (int i = 0; i < n; i++) x = x - 3;
    return x;
}
NOINLINE static short step_i16(short x, int n) {
    for (int i = 0; i < n; i++) x = x - 3;
    return x;
}
NOINLINE static int step_i32(int x, int n) {
    for (int i = 0; i < n; i++) x = x - 3;
    return x;
}
NOINLINE static long step_long(long x, int n) {
    for (int i = 0; i < n; i++) x = x - 3;
    return x;
}
NOINLINE static _Bool flip(_Bool b, int n) {
    for (int i = 0; i < n; i++) b = !b;
    return b;
}
NOINLINE static enum tone toggle(enum tone t, int n) {
    for (int i = 0; i < n; i++) t = (enum tone)(t ^ 1);
    return t;
}
NOINLINE static long widen_u32(unsigned x) { return (long)x + 1; }
NOINLINE static long widen_i32(int x) { return (long)x - 1; }

int main(void) {
    const u64 above32 = 0xa5a5a5a500000000ull;
    const u64 above16 = 0xa5a5a5a5a5a50000ull;
    const u64 above8 = 0xa5a5a5a5a5a5a500ull;

    unsigned char (*volatile u8)(u64, int) = (unsigned char (*)(u64, int))step_u8;
    unsigned short (*volatile u16)(u64, int) = (unsigned short (*)(u64, int))step_u16;
    unsigned (*volatile u32)(u64, int) = (unsigned (*)(u64, int))step_u32;
    signed char (*volatile i8)(u64, int) = (signed char (*)(u64, int))step_i8;
    short (*volatile i16)(u64, int) = (short (*)(u64, int))step_i16;
    int (*volatile i32)(u64, int) = (int (*)(u64, int))step_i32;
    _Bool (*volatile fb)(u64, int) = (_Bool (*)(u64, int))flip;
    enum tone (*volatile ft)(u64, int) = (enum tone (*)(u64, int))toggle;
    long (*volatile wu)(u64) = (long (*)(u64))widen_u32;
    long (*volatile wi)(u64) = (long (*)(u64))widen_i32;

    if (u8(above8 | 7, 0) != 7 || u8(above8 | 7, 2) != 67) return 1;
    if (u8(above8 | 200, 1) != (unsigned char)601) return 2;
    if (u16(above16 | 7, 0) != 7 || u16(above16 | 60000, 1) != (unsigned short)180001) return 3;
    if (u32(above32 | 7, 0) != 7u || u32(above32 | 7, 2) != 67u) return 4;
    if (u32(above32 | 0xfffffff0u, 1) != 0xffffffd1u) return 5;

    if (i8(above8 | 0xfb, 0) != -5 || i8(above8 | 0xfb, 2) != -11) return 6;
    if (i16(above16 | 0xfffb, 0) != -5 || i16(above16 | 0xfffb, 2) != -11) return 7;
    if (i32(above32 | 0xfffffffbu, 0) != -5 || i32(above32 | 0xfffffffbu, 2) != -11) return 8;
    if (step_long(-5, 2) != -11 || step_long(1L << 30, 1) != (1L << 30) - 3) return 9;

    if (fb(above8 | 1, 0) != 1 || fb(above8 | 1, 3) != 0 || fb(above8, 1) != 1) return 10;
    if (ft(above32 | HIGH, 0) != HIGH || ft(above32 | HIGH, 3) != LOW) return 11;

    if (wu(above32 | 0xfffffff0u) != 0xfffffff1L) return 12;
    if (wi(above32 | 0xfffffffbu) != -6) return 13;
    return 0;
}
