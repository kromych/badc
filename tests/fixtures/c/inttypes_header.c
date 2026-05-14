// Locks the `<inttypes.h>` wrapper that ships with the c5 dialect.
//
// C99 7.8 layers `<inttypes.h>` on top of `<stdint.h>`: the
// fixed-width typedefs come through transitively, plus the
// `PRIx<N>` / `SCNx<N>` printf/scanf conversion-specifier macros.
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code so a regression points at the
// failing clause.

#include <inttypes.h>

int main(void) {
    // 7.8 -- the typedefs must still resolve through the wrapper.
    int8_t   s8   = -1;
    int16_t  s16  = -2;
    int32_t  s32  = -3;
    int64_t  s64  = -4;
    uint8_t  u8   = 1;
    uint16_t u16  = 2;
    uint32_t u32  = 3;
    uint64_t u64  = 4;
    intmax_t  im  = -5;
    uintmax_t um  = 5;
    intptr_t  ip  = (intptr_t)&s64;
    uintptr_t up  = (uintptr_t)&u64;
    if (sizeof(s8)  != 1) return 11;
    if (sizeof(s16) != 2) return 12;
    if (sizeof(s32) != 4) return 13;
    if (sizeof(s64) != 8) return 14;
    if (sizeof(u8)  != 1) return 15;
    if (sizeof(u16) != 2) return 16;
    if (sizeof(u32) != 4) return 17;
    if (sizeof(u64) != 8) return 18;
    if (sizeof(im) != 8) return 19;
    if (sizeof(um) != 8) return 20;
    if (sizeof(ip) != 8) return 21;
    if (sizeof(up) != 8) return 22;

    // 7.8.1 -- PRI / SCN macros are conversion-specifier strings.
    // Verify the width-class specifiers expand the way LP64 / LLP64
    // require for c5 (int64_t is `long long`, so the 64-bit class
    // is "ll<conv>" uniformly; 32-bit is plain "<conv>"; 16- and 8-
    // bit scanf use the "h" / "hh" length modifiers).
    const char *pd64 = PRId64;
    if (pd64[0] != 'l' || pd64[1] != 'l' || pd64[2] != 'd' || pd64[3] != 0) return 30;
    const char *pu64 = PRIu64;
    if (pu64[0] != 'l' || pu64[1] != 'l' || pu64[2] != 'u' || pu64[3] != 0) return 31;
    const char *px64 = PRIx64;
    if (px64[0] != 'l' || px64[1] != 'l' || px64[2] != 'x' || px64[3] != 0) return 32;
    const char *pd32 = PRId32;
    if (pd32[0] != 'd' || pd32[1] != 0) return 33;
    const char *sd8 = SCNd8;
    if (sd8[0] != 'h' || sd8[1] != 'h' || sd8[2] != 'd' || sd8[3] != 0) return 34;
    const char *sd16 = SCNd16;
    if (sd16[0] != 'h' || sd16[1] != 'd' || sd16[2] != 0) return 35;
    const char *pdmax = PRIdMAX;
    if (pdmax[0] != 'l' || pdmax[1] != 'l' || pdmax[2] != 'd' || pdmax[3] != 0) return 36;
    const char *pdptr = PRIdPTR;
    if (pdptr[0] != 'l' || pdptr[1] != 'l' || pdptr[2] != 'd' || pdptr[3] != 0) return 37;

    return 0;
}
