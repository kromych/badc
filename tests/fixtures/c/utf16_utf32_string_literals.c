// C11 6.4.5 UTF string literals: `u"..."` stores char16_t elements (2
// bytes each), `U"..."` stores char32_t elements (4 bytes each), each
// terminated by a zero element. A `uint16_t[]` / `uint32_t[]` array takes
// the matching literal directly, and `sizeof` reports the element stride.

typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

static const uint16_t name[] = u"PK";
static const uint32_t wide[] = U"db";

int main(void) {
    // Element counts include the terminator: "PK" -> P, K, 0.
    if (sizeof(name) != 3 * 2) return 1;
    if (sizeof(wide) != 3 * 4) return 2;
    if (name[0] != 'P' || name[1] != 'K' || name[2] != 0) return 3;
    if (wide[0] != 'd' || wide[1] != 'b' || wide[2] != 0) return 4;

    // A block-scope literal used as a pointer keeps the element width.
    const uint16_t *p = u"Hi";
    if (p[0] != 'H' || p[1] != 'i' || p[2] != 0) return 5;

    // L"..." (target wchar_t) is unaffected.
    const int w[] = L"ab";
    if (w[0] != 'a' || w[1] != 'b' || w[2] != 0) return 6;
    return 0;
}
