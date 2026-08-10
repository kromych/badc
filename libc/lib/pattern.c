// POSIX pattern matching for targets whose C library has none:
// `fnmatch` (IEEE Std 1003.1 XSH) and the `regcomp` / `regexec` /
// `regerror` / `regfree` quartet (POSIX.2 BRE and ERE).
//
// macOS and Linux bind their libc's routines from <fnmatch.h> and
// <regex.h>; this file covers Windows, where msvcrt has neither. The
// native-link driver offers it like an archive member, so an image that
// calls none of these carries none of it.
//
// Regex subset. Supported: BRE and ERE, concatenation, alternation,
// `*` `+` `?` and `{n,m}` repetition, grouping and capture, `.`,
// bracket expressions with ranges and the POSIX character classes,
// `^` / `$` anchors, back-references, and the REG_EXTENDED, REG_ICASE,
// REG_NOSUB, REG_NEWLINE, REG_NOTBOL, REG_NOTEOL and REG_STARTEND
// flags. Matching is byte-oriented over the C locale and leftmost-
// longest for the whole match; subexpression offsets come from the
// first parse reaching that end, repetitions explored greedily and
// alternatives left to right.
//
// Reported rather than approximated: multi-character collating symbols
// `[. .]` and equivalence classes `[= =]` (REG_ECOLLATE), the GNU `\w`
// `\W` `\s` `\S` `\b` `\B` `\<` `\>` escapes (REG_BADPAT), and an
// exploration past the step or recursion budget (REG_ESPACE).
//
// Where glibc and the BSD-derived libc disagree the engine follows
// glibc, which is what the programs reaching for these headers are
// written against: an unterminated `[` is a literal, an empty
// alternation branch and an empty pattern are accepted, an ERE takes
// stacked repetition operators, BRE `\|` is alternation, and an escaped
// `/` does not open a new pathname component. Four glibc behaviours are
// not reproduced, each a place where the strict reading and the BSD
// libc agree against it: a `^` or `$` away from a pattern boundary is
// an anchor rather than a newline assertion; REG_ICASE folds the
// subject rather than the pattern text; under FNM_PERIOD a period is
// leading only at the head of the subject, not at whatever position a
// `*` reached; and under FNM_PATHNAME an escaped `/` still matches a
// separator that a wildcard expansion has already passed.

#ifdef _WIN32

#include <fnmatch.h>
#include <regex.h>
#include <stddef.h>

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::malloc, "malloc")
#pragma binding(msvcrt::realloc, "realloc")
#pragma binding(msvcrt::free, "free")

extern void *malloc(size_t size);
extern void *realloc(void *ptr, size_t size);
extern void free(void *ptr);

#define PM_STEP_BUDGET 4000000L
#define PM_DEPTH_BUDGET 8000

static int pm_fold(int c) { return (c >= 'A' && c <= 'Z') ? c + 32 : c; }

static size_t pm_len(const char *s) {
    const char *p = s;
    while (*p) {
        p++;
    }
    return (size_t)(p - s);
}

static int pm_has(const char *s, int c) {
    while (*s) {
        if (*s++ == c) {
            return 1;
        }
    }
    return 0;
}

static int pm_cmp(const char *a, const char *b, size_t n) {
    size_t i;
    for (i = 0; i < n; i++) {
        if ((unsigned char)a[i] != (unsigned char)b[i]) {
            return 1;
        }
    }
    return 0;
}

static void pm_copy(char *d, const char *s, size_t n) {
    size_t i;
    for (i = 0; i < n; i++) {
        d[i] = s[i];
    }
}

static void pm_zero(void *d, size_t n) {
    unsigned char *p = (unsigned char *)d;
    size_t i;
    for (i = 0; i < n; i++) {
        p[i] = 0;
    }
}

enum {
    PM_ALNUM, PM_ALPHA, PM_BLANK, PM_CNTRL, PM_DIGIT, PM_GRAPH,
    PM_LOWER, PM_PRINT, PM_PUNCT, PM_SPACE, PM_UPPER, PM_XDIGIT,
    PM_NCLASS
};

static const char *const pm_class_name[PM_NCLASS] = {
    "alnum", "alpha", "blank", "cntrl", "digit", "graph",
    "lower", "print", "punct", "space", "upper", "xdigit"
};

static int pm_is_alpha(int c) {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

static int pm_is_digit(int c) { return c >= '0' && c <= '9'; }

static int pm_in_class(int which, int c) {
    switch (which) {
    case PM_ALNUM:  return pm_is_alpha(c) || pm_is_digit(c);
    case PM_ALPHA:  return pm_is_alpha(c);
    case PM_BLANK:  return c == ' ' || c == '\t';
    case PM_CNTRL:  return c < 0x20 || c == 0x7f;
    case PM_DIGIT:  return pm_is_digit(c);
    case PM_GRAPH:  return c > 0x20 && c < 0x7f;
    case PM_LOWER:  return c >= 'a' && c <= 'z';
    case PM_PRINT:  return c >= 0x20 && c < 0x7f;
    case PM_PUNCT:  return c > 0x20 && c < 0x7f && !pm_is_alpha(c) && !pm_is_digit(c);
    case PM_SPACE:  return c == ' ' || (c >= '\t' && c <= '\r');
    case PM_UPPER:  return c >= 'A' && c <= 'Z';
    case PM_XDIGIT: return pm_is_digit(c) || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
    }
    return 0;
}

// Class name between `[:` and `:]`, or -1 when unknown.
static int pm_class_lookup(const char *name, size_t len) {
    int i;
    for (i = 0; i < PM_NCLASS; i++) {
        if (pm_len(pm_class_name[i]) == len && pm_cmp(pm_class_name[i], name, len) == 0) {
            return i;
        }
    }
    return -1;
}

// ---------------------------------------------------------------- fnmatch

// Read one bracket member at `*pp`. Sets `*ch` to its character value, or
// `*cls` to a `[:name:]` class index; returns -1 when the text is not a
// valid member, which makes the whole bracket expression a literal `[`.
// `[.x.]` and `[=x=]` denote a single character in the C locale.
static int fnm_item(const char **pp, int flags, int *ch, int *cls) {
    const char *p = *pp;
    *cls = -1;
    if (p[0] == '[' && (p[1] == ':' || p[1] == '.' || p[1] == '=')) {
        char kind = p[1];
        const char *q = p + 2;
        const char *e = q;
        while (*e && !(e[0] == kind && e[1] == ']')) {
            e++;
        }
        if (*e == 0) {
            return -1;
        }
        if (kind == ':') {
            int which = pm_class_lookup(q, (size_t)(e - q));
            if (which < 0) {
                return -1;
            }
            *cls = which;
            *pp = e + 2;
            return 0;
        }
        if (e - q != 1) {
            return -1;
        }
        *ch = (unsigned char)*q;
        *pp = e + 2;
        return 0;
    }
    if (*p == 0) {
        return -1;
    }
    *ch = (unsigned char)*p++;
    if (*ch == '\\' && !(flags & FNM_NOESCAPE)) {
        if (*p == 0) {
            return -1;
        }
        *ch = (unsigned char)*p++;
    }
    *pp = p;
    return 0;
}

// Test one bracket expression against `c`. Returns the position after
// the closing `]`, or a null pointer when the expression is malformed,
// which POSIX leaves to be handled as a literal `[`.
static const char *fnm_bracket(const char *p, unsigned char c, int flags, int *ok) {
    int neg = 0;
    int matched = 0;
    int first = 1;
    int fold = flags & FNM_CASEFOLD;
    unsigned char sc = fold ? (unsigned char)pm_fold(c) : c;

    if (*p == '!' || *p == '^') {
        neg = 1;
        p++;
    }
    for (;;) {
        int lo, hi, cls;
        if (*p == 0) {
            return 0;
        }
        if (*p == ']' && !first) {
            break;
        }
        first = 0;
        if (fnm_item(&p, flags, &lo, &cls) < 0) {
            return 0;
        }
        if (cls >= 0) {
            // FNM_CASEFOLD folds characters and range endpoints, not
            // class membership.
            if (pm_in_class(cls, c)) {
                matched = 1;
            }
            continue;
        }
        if (*p == '-' && p[1] != ']' && p[1] != 0) {
            const char *q = p + 1;
            if (fnm_item(&q, flags, &hi, &cls) < 0 || cls >= 0) {
                return 0;
            }
            p = q;
            if (fold) {
                if (sc >= pm_fold(lo) && sc <= pm_fold(hi)) {
                    matched = 1;
                }
            } else if (c >= (unsigned char)lo && c <= (unsigned char)hi) {
                matched = 1;
            }
            continue;
        }
        if (fold) {
            lo = pm_fold(lo);
        }
        if ((unsigned char)lo == sc) {
            matched = 1;
        }
    }
    p++;
    if (neg) {
        matched = !matched;
    }
    // A bracket expression never matches the separator under
    // FNM_PATHNAME, negated or not.
    if (c == '/' && (flags & FNM_PATHNAME)) {
        matched = 0;
    }
    *ok = matched;
    return p;
}

// `leading` records that the next subject character sits where a period
// must be matched explicitly under FNM_PERIOD: the head of the string,
// or just past a separator when FNM_PATHNAME is set.
static int fnm_match(const char *p, const char *s, int flags, int leading) {
    int fold = flags & FNM_CASEFOLD;
    for (;;) {
        int escaped = 0;
        unsigned char pc = (unsigned char)*p++;
        switch (pc) {
        case 0:
            if (*s == 0) {
                return 0;
            }
            if ((flags & FNM_LEADING_DIR) && *s == '/') {
                return 0;
            }
            return FNM_NOMATCH;
        case '?':
            if (*s == 0) {
                return FNM_NOMATCH;
            }
            if (*s == '/' && (flags & FNM_PATHNAME)) {
                return FNM_NOMATCH;
            }
            if (*s == '.' && leading && (flags & FNM_PERIOD)) {
                return FNM_NOMATCH;
            }
            leading = 0;
            s++;
            break;
        case '*':
            while (*p == '*') {
                p++;
            }
            if (*s == '.' && leading && (flags & FNM_PERIOD)) {
                return FNM_NOMATCH;
            }
            if (*p == 0) {
                if ((flags & (FNM_PATHNAME | FNM_LEADING_DIR)) == FNM_PATHNAME) {
                    return pm_has(s, '/') ? FNM_NOMATCH : 0;
                }
                return 0;
            }
            // An unescaped separator after the wildcard consumes the rest
            // of the component; anything else is confined to it, so the
            // separator's own position is not a candidate.
            if (*p == '/' && (flags & FNM_PATHNAME)) {
                while (*s && *s != '/') {
                    s++;
                }
                if (*s != '/') {
                    return FNM_NOMATCH;
                }
                break;
            }
            for (;;) {
                if (*s == '/' && (flags & FNM_PATHNAME)) {
                    return FNM_NOMATCH;
                }
                if (fnm_match(p, s, flags, 0) == 0) {
                    return 0;
                }
                if (*s == 0) {
                    return FNM_NOMATCH;
                }
                s++;
            }
        case '[': {
            int ok = 0;
            const char *np;
            if (*s == 0) {
                return FNM_NOMATCH;
            }
            if (*s == '.' && leading && (flags & FNM_PERIOD)) {
                return FNM_NOMATCH;
            }
            np = fnm_bracket(p, (unsigned char)*s, flags, &ok);
            if (np == 0) {
                if (*s != '[') {
                    return FNM_NOMATCH;
                }
                s++;
                leading = 0;
                break;
            }
            if (!ok) {
                return FNM_NOMATCH;
            }
            p = np;
            leading = (flags & FNM_PATHNAME) && *s == '/';
            s++;
            break;
        }
        case '\\':
            if (!(flags & FNM_NOESCAPE)) {
                if (*p == 0) {
                    return FNM_NOMATCH; // a trailing escape matches nothing
                }
                pc = (unsigned char)*p++;
                escaped = 1;
            }
            // fall through
        default:
            if (*s == 0) {
                return FNM_NOMATCH;
            }
            if (fold) {
                if (pm_fold((unsigned char)*s) != pm_fold(pc)) {
                    return FNM_NOMATCH;
                }
            } else if ((unsigned char)*s != pc) {
                return FNM_NOMATCH;
            }
            // Only an unescaped separator opens a new component.
            leading = (flags & FNM_PATHNAME) && pc == '/' && !escaped;
            s++;
            break;
        }
    }
}

int fnmatch(const char *pattern, const char *string, int flags) {
    return fnm_match(pattern, string, flags, 1);
}

// ------------------------------------------------------------------ regex

enum {
    RX_EMPTY, RX_CHAR, RX_ANY, RX_SET, RX_BOL, RX_EOL,
    RX_CAT, RX_ALT, RX_REP, RX_GROUP, RX_BACKREF
};

typedef struct {
    unsigned char op;
    unsigned char ch;
    int group;
    int min, max;
    int left, right;
    int set;
} rx_node;

typedef struct {
    rx_node *nodes;
    int nnodes, cnodes;
    unsigned char *sets;
    int nsets, csets;
    int root;
    int ngroups;
    int cflags;
} rx_prog;

typedef struct {
    rx_prog *prog;
    const char *p;
    int err;
    int depth;
} rx_parse;

static int rx_new_node(rx_parse *ps, int op) {
    rx_prog *g = ps->prog;
    rx_node *n;
    if (g->nnodes == g->cnodes) {
        int want = g->cnodes ? g->cnodes * 2 : 32;
        rx_node *grown = (rx_node *)realloc(g->nodes, (size_t)want * sizeof(rx_node));
        if (!grown) {
            ps->err = REG_ESPACE;
            return -1;
        }
        g->nodes = grown;
        g->cnodes = want;
    }
    n = &g->nodes[g->nnodes];
    n->op = (unsigned char)op;
    n->ch = 0;
    n->group = -1;
    n->min = 0;
    n->max = -1;
    n->left = -1;
    n->right = -1;
    n->set = -1;
    return g->nnodes++;
}

static int rx_new_set(rx_parse *ps) {
    rx_prog *g = ps->prog;
    if (g->nsets == g->csets) {
        int want = g->csets ? g->csets * 2 : 4;
        unsigned char *grown = (unsigned char *)realloc(g->sets, (size_t)want * 32u);
        if (!grown) {
            ps->err = REG_ESPACE;
            return -1;
        }
        g->sets = grown;
        g->csets = want;
    }
    pm_zero(g->sets + (size_t)g->nsets * 32u, 32u);
    return g->nsets++;
}

static void rx_set_add(unsigned char *set, int c, int icase) {
    set[(c >> 3) & 31] |= (unsigned char)(1 << (c & 7));
    if (icase) {
        if (c >= 'a' && c <= 'z') {
            c -= 32;
        } else if (c >= 'A' && c <= 'Z') {
            c += 32;
        } else {
            return;
        }
        set[(c >> 3) & 31] |= (unsigned char)(1 << (c & 7));
    }
}

static int rx_alt(rx_parse *ps);

// Read one bracket member at `ps->p`. Returns its character value, or -1
// for a `[:name:]` class (which the caller adds through `*cls`), or -2 on
// error. `[.x.]` and `[=x=]` denote a single character in the C locale.
static int rx_bracket_item(rx_parse *ps, int *cls) {
    *cls = -1;
    if (ps->p[0] == '[' && (ps->p[1] == ':' || ps->p[1] == '.' || ps->p[1] == '=')) {
        char kind = ps->p[1];
        const char *q = ps->p + 2;
        const char *e = q;
        while (*e && !(e[0] == kind && e[1] == ']')) {
            e++;
        }
        if (*e == 0) {
            ps->err = kind == ':' ? REG_ECTYPE : REG_ECOLLATE;
            return -2;
        }
        if (kind == ':') {
            int which = pm_class_lookup(q, (size_t)(e - q));
            if (which < 0) {
                ps->err = REG_ECTYPE;
                return -2;
            }
            ps->p = e + 2;
            *cls = which;
            return -1;
        }
        if (e - q != 1) {
            ps->err = REG_ECOLLATE;
            return -2;
        }
        ps->p = e + 2;
        return (unsigned char)*q;
    }
    return (unsigned char)*ps->p++;
}

// Bracket expression, `ps->p` just past the `[`.
static int rx_bracket(rx_parse *ps) {
    int icase = ps->prog->cflags & REG_ICASE;
    int idx = rx_new_set(ps);
    unsigned char *set;
    int neg = 0;
    int first = 1;
    int after_range = 0;
    int node;
    if (idx < 0) {
        return -1;
    }
    set = ps->prog->sets + (size_t)idx * 32u;
    if (*ps->p == '^') {
        neg = 1;
        ps->p++;
    }
    for (;;) {
        int lo, hi, cls, c;
        if (*ps->p == 0) {
            ps->err = REG_EBRACK;
            return -1;
        }
        if (*ps->p == ']' && !first) {
            break;
        }
        // A range end cannot start another range.
        if (!first && after_range && *ps->p == '-' && ps->p[1] != ']' && ps->p[1] != 0) {
            ps->err = REG_ERANGE;
            return -1;
        }
        first = 0;
        after_range = 0;
        lo = rx_bracket_item(ps, &cls);
        if (lo == -2) {
            return -1;
        }
        if (cls >= 0) {
            for (c = 0; c < 256; c++) {
                if (pm_in_class(cls, c)) {
                    rx_set_add(set, c, icase);
                }
            }
            continue;
        }
        if (*ps->p == '-' && ps->p[1] != ']' && ps->p[1] != 0) {
            ps->p++;
            hi = rx_bracket_item(ps, &cls);
            if (hi == -2) {
                return -1;
            }
            if (cls >= 0 || hi < lo) {
                ps->err = REG_ERANGE;
                return -1;
            }
            while (lo <= hi) {
                rx_set_add(set, lo, icase);
                lo++;
            }
            after_range = 1;
            continue;
        }
        rx_set_add(set, lo, icase);
    }
    ps->p++;
    if (neg) {
        int i;
        for (i = 0; i < 32; i++) {
            set[i] = (unsigned char)~set[i];
        }
        set[0] &= (unsigned char)~1u; // a null byte never appears in the subject
        if (ps->prog->cflags & REG_NEWLINE) {
            set['\n' >> 3] &= (unsigned char)~(1 << ('\n' & 7));
        }
    }
    node = rx_new_node(ps, RX_SET);
    if (node < 0) {
        return -1;
    }
    ps->prog->nodes[node].set = idx;
    return node;
}

static int rx_literal(rx_parse *ps, int c) {
    int node = rx_new_node(ps, RX_CHAR);
    if (node < 0) {
        return -1;
    }
    ps->prog->nodes[node].ch = (unsigned char)c;
    return node;
}

// `\<c>` outside a bracket. POSIX leaves an escaped ordinary character
// undefined; the GNU word and character-class escapes carry meanings
// this engine does not implement, so they are refused instead of
// silently degrading to the literal letter.
static int rx_escape(rx_parse *ps, int c) {
    if (c == 'w' || c == 'W' || c == 's' || c == 'S' ||
        c == 'b' || c == 'B' || c == '<' || c == '>') {
        ps->err = REG_BADPAT;
        return -1;
    }
    return rx_literal(ps, c);
}

// `{n,m}` (ERE) or `\{n,m\}` (BRE), `ps->p` just past the opening brace.
// An unclosed interval is REG_EBRACE and a closed one holding anything but
// a count is REG_BADBR, which is what both platform libcs report.
static int rx_interval(rx_parse *ps, int ere, int *min, int *max) {
    const char *q = ps->p;
    const char *close = ps->p;
    long lo = 0, hi;
    while (*close) {
        if (ere && *close == '}') {
            break;
        }
        if (!ere && close[0] == '\\' && close[1] == '}') {
            break;
        }
        close++;
    }
    if (*close == 0) {
        ps->err = REG_EBRACE;
        return -1;
    }
    // An omitted lower bound reads as zero, as glibc has it.
    if (*q != ',' && !pm_is_digit((unsigned char)*q)) {
        ps->err = REG_BADBR;
        return -1;
    }
    while (pm_is_digit((unsigned char)*q)) {
        lo = lo * 10 + (*q++ - '0');
        if (lo > 65535) {
            ps->err = REG_BADBR;
            return -1;
        }
    }
    hi = lo;
    if (*q == ',') {
        q++;
        if (pm_is_digit((unsigned char)*q)) {
            hi = 0;
            while (pm_is_digit((unsigned char)*q)) {
                hi = hi * 10 + (*q++ - '0');
                if (hi > 65535) {
                    ps->err = REG_BADBR;
                    return -1;
                }
            }
        } else {
            hi = -1;
        }
    }
    if (q != close || (hi >= 0 && hi < lo)) {
        ps->err = REG_BADBR;
        return -1;
    }
    ps->p = close + (ere ? 1 : 2);
    *min = (int)lo;
    *max = (int)hi;
    return 1;
}

static int rx_wrap_rep(rx_parse *ps, int body, int min, int max) {
    int node = rx_new_node(ps, RX_REP);
    if (node < 0) {
        return -1;
    }
    ps->prog->nodes[node].left = body;
    ps->prog->nodes[node].min = min;
    ps->prog->nodes[node].max = max;
    return node;
}

// One atom plus any repetition operators applied to it. `at_start` marks
// the position where BRE treats `*` and `^` as ordinary characters.
static int rx_piece(rx_parse *ps, int at_start) {
    int ere = ps->prog->cflags & REG_EXTENDED;
    int atom = -1;
    int repeated;
    int c;

    c = (unsigned char)*ps->p;
    if (c == 0) {
        return rx_new_node(ps, RX_EMPTY);
    }
    if (c == '^') {
        if (ere || at_start) {
            ps->p++;
            atom = rx_new_node(ps, RX_BOL);
            return atom; // an anchor takes no repetition operator
        }
        ps->p++;
        atom = rx_literal(ps, '^');
    } else if (c == '$') {
        const char *q = ps->p + 1;
        int is_anchor = ere ? 1 : (*q == 0 || (q[0] == '\\' && (q[1] == ')' || q[1] == '|')));
        ps->p++;
        if (is_anchor) {
            return rx_new_node(ps, RX_EOL);
        }
        atom = rx_literal(ps, '$');
    } else if (c == '.') {
        ps->p++;
        atom = rx_new_node(ps, RX_ANY);
    } else if (c == '[') {
        ps->p++;
        atom = rx_bracket(ps);
    } else if (ere && c == '(') {
        int gi = ++ps->prog->ngroups;
        int body;
        ps->p++;
        ps->depth++;
        body = rx_alt(ps);
        ps->depth--;
        if (body < 0) {
            return -1;
        }
        if (*ps->p != ')') {
            ps->err = REG_EPAREN;
            return -1;
        }
        ps->p++;
        atom = rx_new_node(ps, RX_GROUP);
        if (atom < 0) {
            return -1;
        }
        ps->prog->nodes[atom].left = body;
        ps->prog->nodes[atom].group = gi;
    } else if (ere && (c == '*' || c == '+' || c == '?' || c == '{')) {
        ps->err = REG_BADRPT;
        return -1;
    } else if (c == '*' && !ere && at_start) {
        ps->p++;
        atom = rx_literal(ps, '*');
    } else if (c == '\\') {
        int e = (unsigned char)ps->p[1];
        if (e == 0) {
            ps->err = REG_EESCAPE;
            return -1;
        }
        if (!ere && e == '{') {
            ps->err = REG_BADRPT;
            return -1;
        }
        if (!ere && e == '(') {
            int gi = ++ps->prog->ngroups;
            int body;
            ps->p += 2;
            ps->depth++;
            body = rx_alt(ps);
            ps->depth--;
            if (body < 0) {
                return -1;
            }
            if (ps->p[0] != '\\' || ps->p[1] != ')') {
                ps->err = REG_EPAREN;
                return -1;
            }
            ps->p += 2;
            atom = rx_new_node(ps, RX_GROUP);
            if (atom < 0) {
                return -1;
            }
            ps->prog->nodes[atom].left = body;
            ps->prog->nodes[atom].group = gi;
        } else if (!ere && e >= '1' && e <= '9') {
            ps->p += 2;
            if (e - '0' > ps->prog->ngroups) {
                ps->err = REG_ESUBREG;
                return -1;
            }
            atom = rx_new_node(ps, RX_BACKREF);
            if (atom < 0) {
                return -1;
            }
            ps->prog->nodes[atom].group = e - '0';
        } else {
            ps->p += 2;
            atom = rx_escape(ps, e);
        }
    } else {
        ps->p++;
        atom = rx_literal(ps, c);
    }
    if (atom < 0) {
        return -1;
    }

    for (repeated = 0;; repeated = 1) {
        int min, max;
        c = (unsigned char)*ps->p;
        if (c == '*') {
            ps->p++;
            min = 0;
            max = -1;
        } else if (ere && c == '+') {
            ps->p++;
            min = 1;
            max = -1;
        } else if (ere && c == '?') {
            ps->p++;
            min = 0;
            max = 1;
        } else if (ere && c == '{') {
            ps->p++;
            if (rx_interval(ps, 1, &min, &max) < 0) {
                return -1;
            }
        } else if (!ere && c == '\\' && ps->p[1] == '{') {
            ps->p += 2;
            if (rx_interval(ps, 0, &min, &max) < 0) {
                return -1;
            }
        } else {
            return atom;
        }
        if (repeated && !ere) {
            // A BRE takes one repetition operator per atom.
            ps->err = REG_BADRPT;
            return -1;
        }
        atom = rx_wrap_rep(ps, atom, min, max);
        if (atom < 0) {
            return -1;
        }
    }
}

static int rx_at_branch_end(rx_parse *ps) {
    int ere = ps->prog->cflags & REG_EXTENDED;
    if (*ps->p == 0) {
        return 1;
    }
    if (ere) {
        return *ps->p == '|' || (*ps->p == ')' && ps->depth > 0);
    }
    return ps->p[0] == '\\' && (ps->p[1] == '|' || ps->p[1] == ')');
}

static int rx_branch(rx_parse *ps) {
    int head = -1;
    int at_start = 1;
    while (!rx_at_branch_end(ps)) {
        int piece = rx_piece(ps, at_start);
        at_start = 0;
        if (piece < 0) {
            return -1;
        }
        if (head < 0) {
            head = piece;
        } else {
            int cat = rx_new_node(ps, RX_CAT);
            if (cat < 0) {
                return -1;
            }
            ps->prog->nodes[cat].left = head;
            ps->prog->nodes[cat].right = piece;
            head = cat;
        }
    }
    if (head < 0) {
        head = rx_new_node(ps, RX_EMPTY);
    }
    return head;
}

static int rx_alt(rx_parse *ps) {
    int ere = ps->prog->cflags & REG_EXTENDED;
    int head = rx_branch(ps);
    if (head < 0) {
        return -1;
    }
    for (;;) {
        int rhs, node;
        if (ere && *ps->p == '|') {
            ps->p++;
        } else if (!ere && ps->p[0] == '\\' && ps->p[1] == '|') {
            ps->p += 2;
        } else {
            return head;
        }
        rhs = rx_branch(ps);
        if (rhs < 0) {
            return -1;
        }
        node = rx_new_node(ps, RX_ALT);
        if (node < 0) {
            return -1;
        }
        ps->prog->nodes[node].left = head;
        ps->prog->nodes[node].right = rhs;
        head = node;
    }
}

// ------------------------------------------------------------- matching

enum { RXK_NODE, RXK_GEND, RXK_REP };

typedef struct rx_k {
    int kind;
    int node;
    int i;
    const char *pos;
    const struct rx_k *up;
} rx_k;

typedef struct {
    const rx_prog *prog;
    const char *begin;
    const char *end;
    int eflags;
    long steps;
    int depth;
    int overflow;
    const char *best;
    const char **gstart;
    const char **gs;
    const char **ge;
    const char **bs;
    const char **be;
} rx_ctx;

static void rx_run(rx_ctx *x, int ni, const rx_k *k, const char *s);

static void rx_pop(rx_ctx *x, const rx_k *k, const char *s) {
    if (x->overflow) {
        return;
    }
    if (k == 0) {
        if (x->best == 0 || s > x->best) {
            int i;
            x->best = s;
            for (i = 0; i <= x->prog->ngroups; i++) {
                x->bs[i] = x->gs[i];
                x->be[i] = x->ge[i];
            }
        }
        return;
    }
    switch (k->kind) {
    case RXK_NODE:
        rx_run(x, k->node, k->up, s);
        return;
    case RXK_GEND: {
        const char *os = x->gs[k->i];
        const char *oe = x->ge[k->i];
        x->gs[k->i] = x->gstart[k->i];
        x->ge[k->i] = s;
        rx_pop(x, k->up, s);
        x->gs[k->i] = os;
        x->ge[k->i] = oe;
        return;
    }
    default: {
        const rx_node *n = &x->prog->nodes[k->node];
        int count = k->i + 1;
        if (s == k->pos) {
            // An empty iteration makes no progress. It is worth taking to
            // reach a still-unmet minimum, and as the first iteration,
            // where it is what makes the body's subexpressions
            // participate. Past that the loop's own exit already offers
            // this position with the last iteration's offsets intact.
            if (k->i == 0 || k->i < n->min) {
                rx_pop(x, k->up, s);
            }
            return;
        }
        if (n->max < 0 || count < n->max) {
            rx_k nk;
            nk.kind = RXK_REP;
            nk.node = k->node;
            nk.i = count;
            nk.pos = s;
            nk.up = k->up;
            rx_run(x, n->left, &nk, s);
        }
        if (count >= n->min) {
            rx_pop(x, k->up, s);
        }
        return;
    }
    }
}

static int rx_at_bol(const rx_ctx *x, const char *s) {
    if (s == x->begin) {
        return !(x->eflags & REG_NOTBOL);
    }
    return (x->prog->cflags & REG_NEWLINE) && s[-1] == '\n';
}

static int rx_at_eol(const rx_ctx *x, const char *s) {
    if (s == x->end) {
        return !(x->eflags & REG_NOTEOL);
    }
    return (x->prog->cflags & REG_NEWLINE) && *s == '\n';
}

static void rx_run(rx_ctx *x, int ni, const rx_k *k, const char *s) {
    const rx_node *n;
    if (x->overflow) {
        return;
    }
    x->steps++;
    x->depth++;
    if (x->steps > PM_STEP_BUDGET || x->depth > PM_DEPTH_BUDGET) {
        x->overflow = 1;
        x->depth--;
        return;
    }
    n = &x->prog->nodes[ni];
    switch (n->op) {
    case RX_EMPTY:
        rx_pop(x, k, s);
        break;
    case RX_CHAR:
        if (s < x->end) {
            int a = (unsigned char)*s;
            int b = n->ch;
            if (x->prog->cflags & REG_ICASE) {
                a = pm_fold(a);
                b = pm_fold(b);
            }
            if (a == b) {
                rx_pop(x, k, s + 1);
            }
        }
        break;
    case RX_ANY:
        if (s < x->end && !((x->prog->cflags & REG_NEWLINE) && *s == '\n')) {
            rx_pop(x, k, s + 1);
        }
        break;
    case RX_SET:
        if (s < x->end) {
            const unsigned char *set = x->prog->sets + (size_t)n->set * 32u;
            int c = (unsigned char)*s;
            if (set[(c >> 3) & 31] & (1 << (c & 7))) {
                rx_pop(x, k, s + 1);
            }
        }
        break;
    case RX_BOL:
        if (rx_at_bol(x, s)) {
            rx_pop(x, k, s);
        }
        break;
    case RX_EOL:
        if (rx_at_eol(x, s)) {
            rx_pop(x, k, s);
        }
        break;
    case RX_CAT: {
        rx_k nk;
        nk.kind = RXK_NODE;
        nk.node = n->right;
        nk.i = 0;
        nk.pos = 0;
        nk.up = k;
        rx_run(x, n->left, &nk, s);
        break;
    }
    case RX_ALT:
        rx_run(x, n->left, k, s);
        rx_run(x, n->right, k, s);
        break;
    case RX_GROUP: {
        const char *old = x->gstart[n->group];
        rx_k nk;
        nk.kind = RXK_GEND;
        nk.node = ni;
        nk.i = n->group;
        nk.pos = s;
        nk.up = k;
        x->gstart[n->group] = s;
        rx_run(x, n->left, &nk, s);
        x->gstart[n->group] = old;
        break;
    }
    case RX_REP: {
        if (n->max < 0 || n->max > 0) {
            rx_k nk;
            nk.kind = RXK_REP;
            nk.node = ni;
            nk.i = 0;
            nk.pos = s;
            nk.up = k;
            rx_run(x, n->left, &nk, s);
        }
        if (n->min == 0) {
            rx_pop(x, k, s);
        }
        break;
    }
    default: {
        const char *gs = x->gs[n->group];
        const char *ge = x->ge[n->group];
        size_t len, i;
        int same = 1;
        if (gs == 0 || ge == 0) {
            break;
        }
        len = (size_t)(ge - gs);
        if ((size_t)(x->end - s) < len) {
            break;
        }
        for (i = 0; i < len && same; i++) {
            if (x->prog->cflags & REG_ICASE) {
                same = pm_fold((unsigned char)gs[i]) == pm_fold((unsigned char)s[i]);
            } else {
                same = (unsigned char)gs[i] == (unsigned char)s[i];
            }
        }
        if (same) {
            rx_pop(x, k, s + len);
        }
        break;
    }
    }
    x->depth--;
}

// -------------------------------------------------------------- interface

static void rx_free_prog(rx_prog *g) {
    free(g->nodes);
    free(g->sets);
    free(g);
}

int regcomp(regex_t *preg, const char *pattern, int cflags) {
    rx_parse ps;
    rx_prog *g;
    preg->__prog = 0;
    preg->re_nsub = 0;
    g = (rx_prog *)malloc(sizeof(rx_prog));
    if (!g) {
        return REG_ESPACE;
    }
    pm_zero(g, sizeof(rx_prog));
    g->cflags = cflags;
    g->root = -1;
    ps.prog = g;
    ps.p = pattern;
    ps.err = 0;
    ps.depth = 0;
    g->root = rx_alt(&ps);
    if (g->root >= 0 && *ps.p != 0 && ps.err == 0) {
        ps.err = REG_EPAREN;
    }
    if (g->root < 0 || ps.err) {
        int err = ps.err ? ps.err : REG_BADPAT;
        rx_free_prog(g);
        return err;
    }
    preg->__prog = g;
    preg->re_nsub = (size_t)g->ngroups;
    return 0;
}

int regexec(const regex_t *preg, const char *string, size_t nmatch,
            regmatch_t *pmatch, int eflags) {
    const rx_prog *g = (const rx_prog *)preg->__prog;
    rx_ctx x;
    const char **slots;
    const char *start;
    size_t i;
    int ngroups;
    int rc = REG_NOMATCH;

    if (!g) {
        return REG_BADPAT;
    }
    ngroups = g->ngroups;
    x.prog = g;
    x.eflags = eflags;
    if ((eflags & REG_STARTEND) && nmatch > 0 && pmatch) {
        x.begin = string + pmatch[0].rm_so;
        x.end = string + pmatch[0].rm_eo;
    } else {
        x.begin = string;
        x.end = string + pm_len(string);
    }
    slots = (const char **)malloc((size_t)(ngroups + 1) * 5u * sizeof(const char *));
    if (!slots) {
        return REG_ESPACE;
    }
    x.gstart = slots;
    x.gs = slots + (ngroups + 1);
    x.ge = slots + 2 * (ngroups + 1);
    x.bs = slots + 3 * (ngroups + 1);
    x.be = slots + 4 * (ngroups + 1);
    x.steps = 0;
    x.depth = 0;
    x.overflow = 0;

    for (start = x.begin; start <= x.end; start++) {
        int j;
        for (j = 0; j <= ngroups; j++) {
            x.gstart[j] = 0;
            x.gs[j] = 0;
            x.ge[j] = 0;
            x.bs[j] = 0;
            x.be[j] = 0;
        }
        x.best = 0;
        rx_run(&x, g->root, 0, start);
        if (x.overflow) {
            free(slots);
            return REG_ESPACE;
        }
        if (x.best) {
            rc = 0;
            if (!(g->cflags & REG_NOSUB) && pmatch) {
                for (i = 0; i < nmatch; i++) {
                    if (i == 0) {
                        pmatch[0].rm_so = (regoff_t)(start - string);
                        pmatch[0].rm_eo = (regoff_t)(x.best - string);
                    } else if ((int)i <= ngroups && x.bs[i] && x.be[i]) {
                        pmatch[i].rm_so = (regoff_t)(x.bs[i] - string);
                        pmatch[i].rm_eo = (regoff_t)(x.be[i] - string);
                    } else {
                        pmatch[i].rm_so = -1;
                        pmatch[i].rm_eo = -1;
                    }
                }
            }
            break;
        }
    }
    free(slots);
    return rc;
}

void regfree(regex_t *preg) {
    if (preg->__prog) {
        rx_free_prog((rx_prog *)preg->__prog);
        preg->__prog = 0;
    }
    preg->re_nsub = 0;
}

size_t regerror(int errcode, const regex_t *preg, char *errbuf, size_t errbuf_size) {
    static const char *const msg[] = {
        "Success",
        "No match",
        "Invalid regular expression",
        "Invalid collation character",
        "Invalid character class name",
        "Trailing backslash",
        "Invalid back reference",
        "Unmatched [, [^, [:, [. or [=",
        "Unmatched ( or \\(",
        "Unmatched \\{",
        "Invalid content of \\{\\}",
        "Invalid range end",
        "Out of memory",
        "Invalid preceding regular expression"
    };
    const char *s;
    size_t len;
    (void)preg;
    if (errcode == REG_ENOSYS) {
        s = "Operation not supported";
    } else if (errcode >= 0 && errcode <= REG_BADRPT) {
        s = msg[errcode];
    } else {
        s = "Unknown error";
    }
    len = pm_len(s) + 1;
    if (errbuf_size > 0) {
        size_t copy = len > errbuf_size ? errbuf_size - 1 : len - 1;
        pm_copy(errbuf, s, copy);
        errbuf[copy] = 0;
    }
    return len;
}

#endif
