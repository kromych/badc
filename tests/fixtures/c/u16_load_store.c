// DEFERRED: pointer-deref of `unsigned short *` reads/writes 4
// bytes, not 2.
//
// c5's bytecode has Op::Si (store int / 4 bytes), Op::Sc (store
// char / 1 byte), and the implicit 8-byte store via Op::Sl, but
// no Op::Sh (store half / 2 bytes). Same on the load side --
// no Op::Lh / Op::Lhu.
//
// As a result, `*(u16*)p = v;` lowers to a 4-byte write, which
// silently corrupts the two bytes after the intended target.
// Likewise, `u16 v = *(u16*)p;` reads 4 bytes and the high half
// is whatever happened to be at p+2.
//
// This bites an SQL engine's vdbeMemRenderNum. The "%g"-of-double
// rendering uses a `sqlite3DigitPairs.a[]` lookup with `*(u16*)`
// 2-byte writes to fill a 21-byte digit buffer two digits at a
// time. With c5's 4-byte stores, every iteration smashes the
// buffer's tail field (`sign`), and the resulting string is
// empty -- avg(x) and any other floating-point aggregate
// returns "" instead of the formatted value.
//
// Fix: add Op::Sh / Op::Lh / Op::Lhu and route them via
// store_op_for(`unsigned short`) / load_op_for(`unsigned short`)
// when the C type is short or u16.
#include <stdio.h>
#include <string.h>

typedef unsigned short u16;

int main() {
    char src[10] = "ABCDE";
    char dst[10];
    memset(dst, 0, sizeof(dst));

    // 16-bit store at offset 2: only buf[2..3] should change.
    *(u16 *)(&dst[2]) = 0x4241; // 'A' at [2], 'B' at [3] (LE)
    if (dst[0] != 0 || dst[1] != 0) return 1;
    if (dst[2] != 'A' || dst[3] != 'B') return 2;
    // dst[4] must NOT have been clobbered by an over-wide write.
    if (dst[4] != 0) return 3;

    // 16-bit load at offset 1: should read exactly src[1..2].
    u16 v = *(u16 *)(&src[1]);
    // little-endian: low byte = src[1] = 'B', high byte = src[2] = 'C'.
    // 'B' = 0x42, 'C' = 0x43, so v = 0x4342 if the load is 16-bit.
    // Today c5 reads 4 bytes (returns 0x45444342 = "EDCB"), so this
    // assertion fails.
    if (v != 0x4342) return 4;

    return 0;
}
