// Locks C99 7.17p2: `size_t` is an unsigned integer type. A
// signed underlying typedef makes `~(size_t)0` evaluate to -1
// instead of the maximum value, and any `MAX_SIZET / N`-shaped
// cap divides to 0 (signed: -1 / N == 0). Lua's `MAXASIZE` and
// every similar guard are computed that way.

#include <stddef.h>

int main(void) {
    size_t max_sz = ~(size_t)0;
    if (max_sz / 9 == 0) return 1;                       // signed-div symptom
    if (max_sz / 9 != 2049638230412172401ULL) return 2;  // 0xFFFFFFFFFFFFFFFF / 9
    if (max_sz < 1000) return 3;                         // signed-cmp symptom
    // Maximum (size_t) cap pattern as it appears in Lua's
    // luaconf.h: pick the smaller of an integer bound and a
    // byte-budget bound. With size_t signed the byte-budget
    // collapses to 0 and the cap collapses with it.
    unsigned int word_cap = 1u << 31;
    size_t byte_cap = max_sz / (sizeof(int) + 1);
    unsigned int actual = (word_cap < byte_cap) ? word_cap : (unsigned int)byte_cap;
    if (actual != word_cap) return 4;
    return 0;
}
