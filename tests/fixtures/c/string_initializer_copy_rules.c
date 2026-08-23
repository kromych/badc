// C99 6.7.8p14/p21 string-literal initializer copy rules, applied at
// every destination shape: bare array, brace-wrapped array,
// multi-dimensional row, struct member (constant and runtime paths),
// and flexible array member.
//
// The rules are the same at each: the literal's characters are copied
// in order, an embedded NUL is one of them, the terminator is stored
// when the destination is unbounded or has room for it, and a bounded
// destination is zero-filled past the literal. A wide literal decodes
// at the wchar_t stride and needs a matching element width (6.7.8p15).
//
// Two of these were sink-specific before the rules were shared: a
// flexible array member stopped its copy at an embedded NUL, and a wide
// literal in a multi-dimensional row fell through to the pointer path
// and stored the literal's address.

#include <stddef.h>

struct Fam {
    int n;
    char v[];
};

struct Member {
    int tag;
    char a[5];
    wchar_t w[4];
};

static struct Fam fam_embedded = {1, "a\0b"};
static struct Fam fam_plain = {2, "abc"};

static char bare_unbounded[] = "p\0q";
static char bare_exact[3] = "abc";
static char bare_padded[6] = "ab";
static char brace_wrapped[] = {"xy"};

static char narrow_rows[3][4] = {"ab", "cdef", "g"};
static wchar_t wide_rows[3][4] = {L"ab", L"cdef", L"g"};

static wchar_t wide_unbounded[] = L"hi";
static wchar_t wide_exact[2] = L"hi";
static wchar_t wide_padded[4] = L"hi";

static struct Member member_const = {7, "x\0y", L"hi"};

int main(void) {
    /* Flexible array member: every character is copied, the embedded
       NUL included, and the terminator sizes the tail. */
    if (fam_embedded.v[0] != 'a' || fam_embedded.v[1] != 0) return 1;
    if (fam_embedded.v[2] != 'b' || fam_embedded.v[3] != 0) return 2;
    if (fam_plain.n != 2) return 3;
    if (fam_plain.v[0] != 'a' || fam_plain.v[2] != 'c' || fam_plain.v[3] != 0) return 4;

    /* Bare and brace-wrapped arrays. */
    if (sizeof(bare_unbounded) != 4) return 5;
    if (bare_unbounded[1] != 0 || bare_unbounded[2] != 'q') return 6;
    if (bare_exact[0] != 'a' || bare_exact[2] != 'c') return 7;
    if (sizeof(bare_exact) != 3) return 8;
    if (bare_padded[1] != 'b' || bare_padded[2] != 0 || bare_padded[5] != 0) return 9;
    if (sizeof(brace_wrapped) != 3 || brace_wrapped[2] != 0) return 10;

    /* Rows of a multi-dimensional array, narrow and wide. */
    if (narrow_rows[0][1] != 'b' || narrow_rows[0][2] != 0 || narrow_rows[0][3] != 0) return 11;
    if (narrow_rows[1][0] != 'c' || narrow_rows[1][3] != 'f') return 12;
    if (narrow_rows[2][0] != 'g' || narrow_rows[2][1] != 0) return 13;
    if (wide_rows[0][1] != L'b' || wide_rows[0][2] != 0 || wide_rows[0][3] != 0) return 14;
    if (wide_rows[1][0] != L'c' || wide_rows[1][3] != L'f') return 15;
    if (wide_rows[2][0] != L'g' || wide_rows[2][1] != 0) return 16;

    /* Wide arrays: terminator when there is room, dropped on exact fit. */
    if (sizeof(wide_unbounded) / sizeof(wchar_t) != 3) return 17;
    if (wide_unbounded[2] != 0) return 18;
    if (wide_exact[0] != L'h' || wide_exact[1] != L'i') return 19;
    if (wide_padded[1] != L'i' || wide_padded[2] != 0 || wide_padded[3] != 0) return 20;

    /* Struct members, constant path. */
    if (member_const.tag != 7) return 21;
    if (member_const.a[0] != 'x' || member_const.a[1] != 0) return 22;
    if (member_const.a[2] != 'y' || member_const.a[3] != 0 || member_const.a[4] != 0) return 23;
    if (member_const.w[1] != L'i' || member_const.w[2] != 0 || member_const.w[3] != 0) return 24;

    /* Struct members, runtime path (the initializer is not constant). */
    {
        int tag = 8;
        struct Member local = {tag, "x\0y", L"hi"};
        if (local.tag != 8) return 25;
        if (local.a[0] != 'x' || local.a[1] != 0) return 26;
        if (local.a[2] != 'y' || local.a[3] != 0 || local.a[4] != 0) return 27;
        if (local.w[1] != L'i' || local.w[2] != 0 || local.w[3] != 0) return 28;
    }
    return 0;
}
