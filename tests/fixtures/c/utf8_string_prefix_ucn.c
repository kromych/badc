// C11 6.4.5p3: a `u8` string literal is UTF-8 with element type
// `char`, so it is a narrow literal and joins an unprefixed part in an
// adjacent-literal run (6.4.5p5); pairing it with `L`, `u` or `U` has no
// defined result and the lexer rejects it. C11 6.4.3 universal
// character names encode as UTF-8 in a narrow or `u8` literal and as one
// code point in a wide one. Byte values measured against GCC 16.1.0 and
// clang 21 at -std=c11. Returns 0, distinct non-zero per failure.

typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef __WCHAR_TYPE__ wc_t;

#define W __SIZEOF_WCHAR_T__

static const char ascii[] = u8"hi";
static const char eacute[] = u8"\u00E9";
static const char grin[] = u8"\U0001F600";
static const char plain_eacute[] = "\u00E9";

static int bytes_differ(const char *p, const char *want, unsigned n) {
    unsigned i;
    for (i = 0; i < n; i++) {
        if ((unsigned char)p[i] != (unsigned char)want[i]) return 1;
    }
    return 0;
}

int main(void) {
    // A `u8` literal is an array of `char` at one byte per element.
    if (sizeof(ascii) != 3) return 1;
    if (ascii[0] != 'h' || ascii[1] != 'i' || ascii[2] != 0) return 2;
    if (sizeof(u8"a"[0]) != 1) return 3;

    // U+00E9 is two UTF-8 bytes, U+1F600 is four.
    if (sizeof(eacute) != 3) return 4;
    if (bytes_differ(eacute, "\xC3\xA9", 2)) return 5;
    if (sizeof(grin) != 5) return 6;
    if (bytes_differ(grin, "\xF0\x9F\x98\x80", 4)) return 7;

    // An unprefixed narrow literal is the same encoding as `u8`.
    if (sizeof(plain_eacute) != 3) return 8;
    if (bytes_differ(plain_eacute, eacute, 3)) return 9;

    // The three concatenation cells C11 6.4.5p5 defines for `u8`.
    {
        static const char a[] = u8"ab" u8"cd";
        static const char b[] = u8"ab" "cd";
        static const char c[] = "ab" u8"cd";
        if (sizeof(a) != 5 || sizeof(b) != 5 || sizeof(c) != 5) return 10;
        if (bytes_differ(a, "abcd", 5)) return 11;
        if (bytes_differ(b, "abcd", 5)) return 12;
        if (bytes_differ(c, "abcd", 5)) return 13;
    }
    // The prefix may sit anywhere in a longer run, and repeat.
    if (sizeof(u8"a" "b" u8"c") != 4) return 14;
    if (sizeof("a" u8"b" "c") != 4) return 15;
    {
        const char *p = "a" u8"\u00E9" "b";
        if (p[0] != 'a' || (unsigned char)p[1] != 0xC3) return 16;
        if ((unsigned char)p[2] != 0xA9 || p[3] != 'b' || p[4] != 0) return 17;
    }

    // A `u8` literal decays to `char *` and takes the ordinary escapes.
    {
        const char *p = u8"x\ty\n";
        if (p[0] != 'x' || p[1] != '\t' || p[2] != 'y' || p[3] != '\n') return 18;
    }

    // C11 6.4.3p2 permits these three below U+00A0; U+00A0 is the first
    // two-byte encoding and U+10FFFF the code space limit.
    if (sizeof(u8"\u0024\u0040\u0060") != 4) return 19;
    if (bytes_differ(u8"\u0024\u0040\u0060", "$@`", 4)) return 20;
    if (sizeof(u8"\u00A0") != 3) return 21;
    if (bytes_differ(u8"\u00A0", "\xC2\xA0", 2)) return 22;
    if (sizeof(u8"\U0010FFFF") != 5) return 23;
    if (bytes_differ(u8"\U0010FFFF", "\xF4\x8F\xBF\xBF", 4)) return 24;

    // The same name is one code point in a wide literal: `u` needs the
    // surrogate pair above U+FFFF, `L` and `U` hold the scalar value.
    {
        static const uint16_t s16[] = u"\U0001F600";
        static const uint32_t s32[] = U"\U0001F600";
        static const wc_t sw[] = L"\u00E9";
        if (sizeof(s16) != 3 * 2 || s16[0] != 0xD83D || s16[1] != 0xDE00) return 25;
        if (sizeof(s32) != 2 * 4 || s32[0] != 0x1F600) return 26;
        if (sizeof(sw) != 2 * W || sw[0] != 0xE9) return 27;
    }
    if (L'\u00E9' != 0xE9) return 28;

    // A universal character name below U+0080 is one byte in a
    // narrow character constant. The references disagree above it --
    // GCC packs the UTF-8 bytes, clang rejects the form -- so the
    // lexer tests pin that case instead of this fixture.
    if ('\u0024' != '$') return 29;

    // `u8` is an ordinary identifier when no quote follows it.
    {
        int u8 = 7;
        if (u8 != 7) return 30;
    }
    return 0;
}
