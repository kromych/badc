// Locks the `<inttypes.h>` wrapper that ships with the c5 dialect.
//
// C99 7.8 layers `<inttypes.h>` on top of `<stdint.h>`: the
// fixed-width typedefs come through transitively, plus the
// `PRIx<N>` / `SCNx<N>` printf/scanf conversion-specifier macros.
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code so a regression points at the
// failing clause.

#include <inttypes.h>

// The fixture runs under the interpreter too, which has no library calls.
static int same(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++;
        b++;
    }
    return *a == *b;
}

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

    // 7.8.1 -- PRI / SCN macros are conversion-specifier strings. The
    // 64-bit, greatest-width and pointer-width ones take the length
    // modifier of the type the target gives the typedef; 32-bit is plain
    // "<conv>"; 16- and 8-bit scanf use the "h" / "hh" length modifiers.
    if (!same(PRId64, _Generic((int64_t)0, long: "ld", long long: "lld"))) return 30;
    if (!same(PRIu64, _Generic((uint64_t)0, unsigned long: "lu", unsigned long long: "llu")))
        return 31;
    if (!same(PRIx64, _Generic((uint64_t)0, unsigned long: "lx", unsigned long long: "llx")))
        return 32;
    if (!same(PRId32, "d")) return 33;
    if (!same(SCNd8, "hhd")) return 34;
    if (!same(SCNd16, "hd")) return 35;
    if (!same(PRIdMAX, _Generic((intmax_t)0, long: "ld", long long: "lld"))) return 36;
    if (!same(PRIdPTR, _Generic((intptr_t)0, int: "d", long: "ld", long long: "lld")))
        return 37;
    if (!same(SCNd64, PRId64) || !same(SCNxMAX, PRIxMAX)) return 38;

    return 0;
}
