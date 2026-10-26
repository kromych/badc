// <getopt.h>'s parser and its state on the Windows targets, where mingw-w64
// defines them in libmingwex and msvcrt has none. As there, getopt stops at
// the first operand, and getopt_long and getopt_long_only move the operands
// they pass over behind the options unless the option string starts with
// `+` or POSIXLY_CORRECT is set; a leading `-` returns each operand as
// option 1, and setting optind to 0 restarts the scan. The file compiles to
// nothing elsewhere; the native-link driver offers it like an archive member.

#ifdef _WIN32

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *optarg;
int optind = 1;
int opterr = 1;
int optopt = '?';

enum { PERMUTE = 1, OPERANDS = 2, LONG_ONLY = 4 };

// The unread rest of an argument of short options, and the operands a
// permuting scan has passed over, argv[first..last).
static const char *rest = "";
static int first = -1, last = -1;

static void complain(char *const *argv, const char *opts, const char *what, int len,
                     const char *name) {
    if (opterr && *opts != ':')
        fprintf(stderr, "%s: %s -- %.*s\n", argv[0], what, len, name);
}

static void reverse(char *const *argv, int i, int j) {
    char **v = (char **)argv;
    for (j--; i < j; i++, j--) {
        char *t = v[i];
        v[i] = v[j];
        v[j] = t;
    }
}

// Ends a scan: the operands passed over move behind the options, and optind
// names the first of them.
static int finish(char *const *argv) {
    if (last >= 0) {
        reverse(argv, first, last);
        reverse(argv, last, optind);
        reverse(argv, first, optind);
        optind -= last - first;
    } else if (first >= 0) {
        optind = first;
    }
    first = last = -1;
    rest = "";
    return -1;
}

static int parse_long(int argc, char *const *argv, const char *opts,
                      const struct option *longs, int *index, int short_too) {
    const char *name = rest, *value = strchr(name, '=');
    size_t len = value ? (size_t)(value - name) : strlen(name);
    int bad = *opts == ':' ? ':' : '?';
    int match = -1, ambiguous = 0, i;
    const struct option *o;
    optind++;
    for (i = 0; longs[i].name; i++) {
        if (strncmp(name, longs[i].name, len))
            continue;
        if (strlen(longs[i].name) == len) {
            match = i;
            ambiguous = 0;
            break;
        }
        if (short_too && len == 1)
            continue;
        if (match < 0)
            match = i;
        else if (longs[i].has_arg != longs[match].has_arg ||
                 longs[i].flag != longs[match].flag || longs[i].val != longs[match].val)
            ambiguous = 1;
    }
    if (ambiguous) {
        complain(argv, opts, "ambiguous option", (int)len, name);
        optopt = 0;
        return '?';
    }
    if (match < 0) {
        if (short_too) {
            optind--;
            return -1;
        }
        complain(argv, opts, "unknown option", (int)strlen(name), name);
        optopt = 0;
        return '?';
    }
    o = &longs[match];
    if (o->has_arg == no_argument && value) {
        complain(argv, opts, "option doesn't take an argument", (int)len, name);
        optopt = o->flag ? 0 : o->val;
        return bad;
    }
    if (value && o->has_arg != no_argument)
        optarg = (char *)value + 1;
    else if (o->has_arg == required_argument && optind < argc)
        optarg = argv[optind++];
    if (o->has_arg == required_argument && !optarg) {
        complain(argv, opts, "option requires an argument", (int)len, name);
        optopt = o->flag ? 0 : o->val;
        return bad;
    }
    if (index)
        *index = match;
    if (o->flag) {
        *o->flag = o->val;
        return 0;
    }
    return o->val;
}

static int scan(int argc, char *const *argv, const char *opts, const struct option *longs,
                int *index, int flags) {
    const char *spec;
    int bad, c;
    if (!opts)
        return -1;
    if (optind == 0) {
        optind = 1;
        rest = "";
        first = last = -1;
    }
    if (*opts == '-')
        flags |= OPERANDS;
    else if (*opts == '+' || getenv("POSIXLY_CORRECT"))
        flags &= ~PERMUTE;
    if (*opts == '+' || *opts == '-')
        opts++;
    bad = *opts == ':' ? ':' : '?';
    optarg = NULL;
    if (!*rest) {
        const char *arg;
        for (;; optind++) {
            if (optind >= argc)
                return finish(argv);
            arg = argv[optind];
            if (arg[0] == '-' && arg[1])
                break;
            if (flags & OPERANDS) {
                optarg = argv[optind++];
                return 1;
            }
            if (!(flags & PERMUTE))
                return -1;
            if (first < 0) {
                first = optind;
            } else if (last >= 0) {
                reverse(argv, first, last);
                reverse(argv, last, optind);
                reverse(argv, first, optind);
                first = optind - (last - first);
                last = -1;
            }
        }
        if (first >= 0 && last < 0)
            last = optind;
        if (arg[1] == '-' && !arg[2]) {
            optind++;
            return finish(argv);
        }
        rest = arg + 1;
        if (longs && (*rest == '-' || (flags & LONG_ONLY))) {
            int short_too = 0;
            if (*rest == '-')
                rest++;
            else if (*rest != ':' && strchr(opts, *rest))
                short_too = 1;
            c = parse_long(argc, argv, opts, longs, index, short_too);
            if (c != -1) {
                rest = "";
                return c;
            }
        }
    }
    c = (unsigned char)*rest++;
    if (c == ':' || c == '-' || !(spec = strchr(opts, c))) {
        if (!*rest)
            optind++;
        complain(argv, opts, "unknown option", 1, (const char *)&rest[-1]);
        optopt = c;
        return '?';
    }
    if (longs && c == 'W' && spec[1] == ';') {
        if (!*rest) {
            if (++optind >= argc) {
                rest = "";
                complain(argv, opts, "option requires an argument", 1, "W");
                optopt = c;
                return bad;
            }
            rest = argv[optind];
        }
        c = parse_long(argc, argv, opts, longs, index, 0);
        rest = "";
        return c;
    }
    if (spec[1] != ':') {
        if (!*rest)
            optind++;
        return c;
    }
    if (*rest) {
        optarg = (char *)rest;
    } else if (spec[2] != ':') {
        if (++optind >= argc) {
            rest = "";
            complain(argv, opts, "option requires an argument", 1, (const char *)&spec[0]);
            optopt = c;
            return bad;
        }
        optarg = argv[optind];
    }
    rest = "";
    optind++;
    return c;
}

int getopt(int argc, char *const argv[], const char *opts) {
    return scan(argc, argv, opts, NULL, NULL, 0);
}

int getopt_long(int argc, char *const *argv, const char *opts, const struct option *longs,
                int *index) {
    return scan(argc, argv, opts, longs, index, PERMUTE);
}

int getopt_long_only(int argc, char *const *argv, const char *opts,
                     const struct option *longs, int *index) {
    return scan(argc, argv, opts, longs, index, PERMUTE | LONG_ONLY);
}

#endif
