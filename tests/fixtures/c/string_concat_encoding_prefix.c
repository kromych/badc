// C99 6.4.5p4 / C11 6.4.5p5: a run of adjacent string literal tokens is
// concatenated into one literal. An unprefixed part joins a prefixed run
// at the run's element width, whichever end of the run carries the
// prefix, so `L"ab" "cd"` and `"ab" L"cd"` are both `wchar_t[5]`. A run
// carrying two different prefixes has no defined result and is rejected;
// the lexer tests cover that side. Matches GCC and clang. Returns 0,
// distinct non-zero per failure.

typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef __WCHAR_TYPE__ wc_t;

#define W __SIZEOF_WCHAR_T__

static const wc_t lead[] = L"ab" "cd";
static const wc_t trail[] = "ab" L"cd";
static const uint16_t u_lead[] = u"ab" "cd";
static const uint32_t u_trail[] = "ab" U"cd";

static int differs(const wc_t *p) {
    return p[0] != 'a' || p[1] != 'b' || p[2] != 'c' || p[3] != 'd' || p[4] != 0;
}

int main(void) {
    if (sizeof(lead) != 5 * W || sizeof(trail) != 5 * W) return 1;
    if (differs(lead) || differs(trail)) return 2;

    if (sizeof(u_lead) != 5 * 2 || sizeof(u_trail) != 5 * 4) return 3;
    if (u_lead[0] != 'a' || u_lead[3] != 'd' || u_lead[4] != 0) return 4;
    if (u_trail[0] != 'a' || u_trail[3] != 'd' || u_trail[4] != 0) return 5;

    // The prefix may sit anywhere in a run of three or more, and repeat.
    if (sizeof(L"a" "b" L"c") != 4 * W) return 6;
    if (sizeof("a" "b" L"c") != 4 * W) return 7;
    if (sizeof(U"a" "b" "c") != 4 * 4) return 8;

    // An all-unprefixed run stays narrow.
    if (sizeof("ab" "cd") != 5) return 9;

    // Escapes and embedded quotes inside a part do not end the run.
    if (sizeof(L"a\"b" "\\c") != 6 * W) return 10;
    {
        const wc_t *p = L"a\"b" "\\c";
        if (p[1] != '"' || p[3] != '\\' || p[4] != 'c' || p[5] != 0) return 11;
    }

    // A run split across lines concatenates the same way.
    {
        const wc_t *p = "ab"
                        L"cd";
        if (differs(p)) return 12;
    }

    // The literal decays to a pointer at the run's element width.
    {
        const wc_t *p = L"ab" "cd";
        if (p[2] != 'c') return 13;
    }
    return 0;
}
