// <uchar.h>'s conversions (C17 7.28.1) on macOS and Windows, whose C
// libraries define none of them. The multibyte encodings both libraries
// provide are stateless, so each conversion runs `mbrtowc` / `wcrtomb` from
// the initial state; the caller's `mbstate_t` holds what spans calls: the
// bytes of an incomplete character, the low surrogate `mbrtoc16` still owes
// and the high surrogate `c16rtomb` waits to pair. Elsewhere the file is
// empty; the link offers it like an archive member.

#if defined(__APPLE__) || defined(_WIN32)

#include <errno.h>
#include <limits.h>
#include <string.h>
#include <uchar.h>
#include <wchar.h>

struct state {
    unsigned char held;
    char bytes[MB_LEN_MAX];
    char16_t owed;
    char16_t high;
};
_Static_assert(sizeof(struct state) <= sizeof(mbstate_t), "the state fits an mbstate_t");

static struct state *state_of(mbstate_t *ps, mbstate_t *internal) {
    return (struct state *)(ps ? ps : internal);
}

static size_t fail(struct state *st) {
    memset(st, 0, sizeof *st);
    errno = EILSEQ;
    return (size_t)-1;
}

// The next character of the held bytes followed by `s[0..n)`: the count of
// bytes of `s` it takes, 0 for the null character, or -1 / -2 as `mbrtowc`
// reports an invalid or an incomplete one.
static size_t decode(char32_t *c, const char *s, size_t n, struct state *st) {
    char buf[MB_LEN_MAX];
    size_t held = st->held;
    size_t take = n < MB_LEN_MAX - held ? n : MB_LEN_MAX - held;
    memcpy(buf, st->bytes, held);
    memcpy(buf + held, s, take);
    mbstate_t initial;
    memset(&initial, 0, sizeof initial);
    wchar_t wc;
    size_t r = mbrtowc(&wc, buf, held + take, &initial);
    if (r == (size_t)-2) {
        if (take < n)
            return fail(st);
        memcpy(st->bytes + held, s, take);
        st->held = (unsigned char)(held + take);
        return r;
    }
    if (r == (size_t)-1)
        return fail(st);
    st->held = 0;
    *c = (char32_t)wc;
    return r == 0 ? 0 : r - held;
}

// The multibyte form of `c`: wchar_t holds every character on macOS, and on
// Windows the code pages hold none beyond the Basic Multilingual Plane.
static size_t encode(char *s, char32_t c) {
    if ((c >= 0xD800 && c <= 0xDFFF) || c > 0x10FFFF || c > WCHAR_MAX) {
        errno = EILSEQ;
        return (size_t)-1;
    }
    mbstate_t initial;
    memset(&initial, 0, sizeof initial);
    return wcrtomb(s, (wchar_t)c, &initial);
}

size_t mbrtoc32(char32_t *pc32, const char *s, size_t n, mbstate_t *ps) {
    static mbstate_t internal;
    struct state *st = state_of(ps, &internal);
    if (!s) {
        pc32 = NULL;
        s = "";
        n = 1;
    }
    char32_t c;
    size_t r = decode(&c, s, n, st);
    if (r < (size_t)-2 && pc32)
        *pc32 = c;
    return r;
}

size_t mbrtoc16(char16_t *pc16, const char *s, size_t n, mbstate_t *ps) {
    static mbstate_t internal;
    struct state *st = state_of(ps, &internal);
    if (!s) {
        pc16 = NULL;
        s = "";
        n = 1;
    }
    if (st->owed) {
        if (pc16)
            *pc16 = st->owed;
        st->owed = 0;
        return (size_t)-3;
    }
    char32_t c;
    size_t r = decode(&c, s, n, st);
    if (r >= (size_t)-2)
        return r;
    if (c > 0xFFFF) {
        st->owed = (char16_t)(0xDC00 | (c & 0x3FF));
        c = 0xD800 | ((c - 0x10000) >> 10);
    }
    if (pc16)
        *pc16 = (char16_t)c;
    return r;
}

size_t c32rtomb(char *s, char32_t c32, mbstate_t *ps) {
    char buf[MB_LEN_MAX];
    (void)ps;
    if (!s) {
        s = buf;
        c32 = 0;
    }
    return encode(s, c32);
}

size_t c16rtomb(char *s, char16_t c16, mbstate_t *ps) {
    static mbstate_t internal;
    struct state *st = state_of(ps, &internal);
    char buf[MB_LEN_MAX];
    if (!s) {
        s = buf;
        c16 = 0;
    }
    if (st->high) {
        if (c16 < 0xDC00 || c16 > 0xDFFF)
            return fail(st);
        char32_t c = 0x10000 + ((char32_t)(st->high - 0xD800) << 10) + (c16 - 0xDC00);
        st->high = 0;
        return encode(s, c);
    }
    if (c16 >= 0xD800 && c16 <= 0xDBFF) {
        st->high = c16;
        return 0;
    }
    return encode(s, c16);
}

#endif
