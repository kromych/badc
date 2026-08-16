// C99 6.4.4.4p10: an integer character constant has type `int`, whatever
// its value. The packed bytes of a multi-character constant therefore wrap
// into that width instead of promoting the constant to a wider type, so a
// four-byte form with the high bit set is negative. The assertions below
// hold on both plain-char signednesses: multi-character packing masks each
// byte, so the target's `char` signedness does not reach the result.

static int width(void) {
    if (sizeof('a') != sizeof(int)) return 1;
    if (sizeof('\xF0') != sizeof(int)) return 2;
    if (sizeof('abcd') != sizeof(int)) return 3;
    if (sizeof('\xF0\x9F\x98\x80') != sizeof(int)) return 4;
    return 0;
}

static int value(void) {
    if ('ab' != 24930) return 5;
    if ('abc' != 6382179) return 6;
    if ('abcd' != 1633837924) return 7;
    if ('\xF0\x9F\x98\x80' != -257976192) return 8;
    if ('\x7F\xFF\xFF\xFF' != 2147483647) return 9;
    if ('\x80\x00\x00\x00' != -2147483648 - 0) return 10;
    return 0;
}

static int sign(void) {
    if (!('\xF0\x9F\x98\x80' < 0)) return 11;
    if ('\x7F\xFF\xFF\xFF' < 0) return 12;
    if (!('\x80\x00\x00\x00' < 0)) return 13;
    // Fewer than four bytes cannot reach the sign bit.
    if ('\xF0\x9F' < 0) return 14;
    if ('\xF0\x9F\x98' < 0) return 15;
    return 0;
}

// C11 6.4.4.4p2-p4: the encoding prefix fixes the type. `u'c'` is
// `char16_t` (`uint_least16_t`) and `U'c'` is `char32_t`
// (`uint_least32_t`) -- unsigned, and the same width on every target,
// so neither tracks `wchar_t`. `L'c'` is `wchar_t`, whose width the
// target picks, so only its relation to the others is asserted here.
static int prefixed(void) {
    if (sizeof(u'a') != 2) return 19;
    if (sizeof(U'a') != 4) return 20;
    if ((__typeof__(u'a')) - 1 < 0) return 21;
    if ((__typeof__(U'a')) - 1 < 0) return 22;
    if (sizeof(L'a') != 2 && sizeof(L'a') != 4) return 23;
    // The retyping leaves the code point alone.
    if (u'a' != 97 || U'a' != 97 || L'a' != 97) return 24;
    if (u'\uFFFD' != 65533) return 25;
    if (U'\U0001F600' != 128512) return 26;
    return 0;
}

// A `case` label and an array bound run the constant through the
// constant-expression evaluator rather than the expression parser; both
// must read the same type.
static int labelled(int x) {
    switch (x) {
        case '\xF0\x9F\x98\x80': return 1;
        case 'ab': return 2;
        case u'\uFFFD': return 3;
        default: return 0;
    }
}

static char packed[sizeof('abcd')];
static char packed_u16[sizeof(u'a')];
static char packed_u32[sizeof(U'a')];

int main(void) {
    int r;
    if ((r = width()) != 0) return r;
    if ((r = value()) != 0) return r;
    if ((r = sign()) != 0) return r;
    if ((r = prefixed()) != 0) return r;
    if (labelled(-257976192) != 1) return 16;
    if (labelled(24930) != 2) return 17;
    if (sizeof(packed) != sizeof(int)) return 18;
    if (labelled(65533) != 3) return 27;
    if (sizeof(packed_u16) != 2) return 28;
    if (sizeof(packed_u32) != 4) return 29;
    return 0;
}
